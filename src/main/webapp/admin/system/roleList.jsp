<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
</head>
<body>
<div id="cc" class="easyui-layout"  style="width: 100%; height: 630px; margin-left: auto; margin-right: auto">
	<div data-options="region:'north',title:'查询条件',iconCls:'icon-mysearch ',split:true" style="width: 100%;height:66px;">
		<form id="queryConditionForm">
		  <input name="whatSoEver" style="display:none;" /><!-- 当form只有一个input时会，在此input中按回车会自动提交表单，此隐藏的input是为了阻止自动提交的 -->
		  <table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
				<td style="width: 100px;text-align: center;"> 
				  <input name="roleName" style="width:100px;" placeholder="角色名称,模糊查询"/>
                </td>
                <td class="td_title" style="width: 40px;" align="right">状态：</td>
				<td style="width: 100px;"> 
				  <select name="roleStatus" style="width: 60px;" placeholder="选择状态">
				  	<option value="" selected="selected"></option>
				  	<option value="1" >有效</option>
				  	<option value="2" >无效</option>
				  </select>
                </td>
                <td align="left">
				     <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" onclick="query();" >查询</a> 
				     &nbsp;&nbsp;&nbsp;&nbsp;
					 <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearForm('queryConditionForm');">清空</a>
				</td>
			</tr>
         </table> 
        </form>
    </div>
	<div data-options="region:'center',border:false"  style="width: 100%; height: 650px;">
		<div id="menuToolbar" style="height:auto" class="datagrid-toolbar">    
			<global:hasPermission url="/sysRole/create">
        		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addRole();" >增加</a>
        	</global:hasPermission>
        	<global:hasPermission url="/sysRole/edit">
        		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editRole();" >编辑</a>
        	</global:hasPermission>
        	<global:hasPermission url="/sysRole/delete">
        		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteRole();" >删除</a>
        	</global:hasPermission>
        	<global:hasPermission url="/sysRole/updatePermission">
        		<a href="#" class="easyui-linkbutton" iconCls="icon-myprivilege" plain="true" onclick="updatePermission();" >授权</a>
        	</global:hasPermission>
		</div> 
		<table id="roleDatagrid" class="easyui-datagrid" title="角色列表" style="width:100%;height:500px;" 
		    url="${ctx}/sysRole/dataGrid" method="post" rownumbers="true" singleSelect="true" 
		    pagination="true" pageSize="15" pageList="[10, 15 , 20, 30, 40 ]" toolbar="#menuToolbar"  
		    data-options="loadFilter:globalDatagridFilter"
		>
			<thead>
				<tr>
					<th field="soWhatEver" width="100" align="center" checkbox="true"></th>
					<th field="roleName" width="120" align="center">角色名称</th>
					<th field="roleStatus" width="60" align="center" formatter="getStatusCn">状态</th>
					<th field="userNames" width="1000" align="left">包含用户(用户名+空格+真实姓名，多个用英文,隔开)</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- 新增对话框 -->
	<div id="dataDialog" style="width:450px;height:150px;display: none" align="center" 
	     data-options=" title:'添加角色',modal:true,closed:true,maximizable:true,iconCls:'icon-add',
                        buttons:[{iconCls:'icon-ok',text:'提交',handler:function(){addOrEditData();}}] " >
		<form id="dataDialogForm">
		<input type="hidden" name="roleId" />
	    <table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
				<td class="td_title" width="20%" align="right">角色名称：</td>
				<td align="left">
				  <input name="roleName" style="width:90%;" maxLength="80" class="easyui-validatebox" data-options="required:true"/>
                </td>
			</tr>
			<tr>
				<td class="td_title" width="20%" align="right">状态：</td>
				<td align="left">
				  <select name="roleStatus" style="width:90%;" class="easyui-validatebox" data-options="required:true" >
				   	    <option  value="" selected="selected"></option>
				        <option  value="1" >有效</option>
				        <option  value="2" >无效</option>
			        </select>
                </td>
			</tr>
		</table>
		</form>
	</div>
	
	<!-- 授权对话框 -->
	<div id="privilegeDialog" style="width:750px;height:600px;display: none" align="center" 
	     data-options=" title:'给角色授权',modal:true,closed:true,maximizable:true,iconCls:'icon-add',
                        buttons:[{iconCls:'icon-ok',text:'提交',handler:function(){savePrivilege();}}] "  >
	   <form id="privilegeDialogForm">
	    <table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
				<td class="td_title" width="10%" align="right">权限</td>
				<td align="left">
				  <input type="hidden" name="roleId" id="roleId">
				  <input id="privilegeCombotree" name="resIds" style="width:90%;" class="easyui-comboTree" 
                         data-options="url:'${ctx}/sysRole/getCombotree',lines:true,checkbox:true,multiple:true,
                                       required:false,cascadeCheck:false,panelHeight:500,loadFilter:convert,onCheck:checkedChilds " />
				  <div style="text-align:center;"><a href="javascript:void(0);" style="text-decoration:none;"  onclick="cleanAllPrivilege();">清除所有权限</a></div>
                </td>
			</tr>
	     </table>
	    </form>
    </div>
	
</div>
<script type="text/javascript">

function query(){
	var data = $("#queryConditionForm").serializeObject();
	$("#roleDatagrid").datagrid('load',data); 
}

function cleanAllPrivilege(){
	privilegeCombotree.combotree('setValue','');
	privilegeCombotree.combotree('clear');
}

function editRole(){
	var rows = $("#roleDatagrid").datagrid('getSelections');
    if (rows.length != 1){
    	$.messager.alert("提示信息","请选择一行数据");
    	return;
    }
	dataDialogForm.form('clear');
	dataDialogForm.form('load',rows[0]);
	dialogUrl = "${ctx}/sysRole/edit";
	dialogMsg = "确定要修改角色？";
	dataDialog.dialog({title:'修改角色',iconCls:'icon-edit'});
	dataDialog.dialog("open");
}

function addRole(){
	dataDialogForm.form('clear');
	dialogUrl = "${ctx}/sysRole/create";
	dialogMsg = "确定要增加角色？";
	dataDialog.dialog({title:'添加角色',iconCls:'icon-add'});
	dataDialog.dialog("open");
}

function deleteRole(){
	var rows = $("#roleDatagrid").datagrid('getSelections');
    if (rows.length != 1){
    	$.messager.alert("提示信息","请选择一行数据");
    	return;
    }
    commonSubmit("确定要删除此角色？","${ctx}/sysRole/delete",{'roleId':rows[0].roleId}, "roleDatagrid", dataDialog);
}

function addOrEditData(){
    var validateResult = dataDialogForm.form('validate');
    if(!validateResult){
       $.messager.alert('错误提示', '请正确输入！');
       return;
    }
    var data = $("#dataDialogForm").serializeObject();
    commonSubmit(dialogMsg,dialogUrl,data, "roleDatagrid", dataDialog);
}

//选中节点时，子节点跟随父节点。但父节点不跟随子节点。
function checkedChilds(treeNode , checked){
	var tree = privilegeCombotree.combotree('tree');	// get the tree object
	//处理子节点
	var childNodes = tree.tree('getChildren', treeNode.target);//得到该节点下的所有节点数组  
	if(childNodes){
		var child;
		for(var i=0;i<childNodes.length;i++){
			child = childNodes[i];
			if(child && checked!=child.checked){//如果子节点和父节点状态不同
				if(checked){
					tree.tree('check',child.target);
				}
				else {
					tree.tree('uncheck',child.target);
				}
			}
		}
	}
}

function updatePermission(){
	var rows = $("#roleDatagrid").datagrid('getSelections');
    if (rows.length != 1){
    	$.messager.alert("提示信息","请选择一行数据");
    	return;
    }
    cleanAllPrivilege();//清空权限树数据
    //根据员工所在部门id重新加载权限combotree
    privilegeCombotree.combotree('reload',"${ctx}/sysRole/getCombotree" + '?roleId=' + rows[0].roleId);
 	//同步查询部门拥有的功能id
    var resIds = ajaxSync("${ctx}/sysRole/roleRessIds", {'roleId':rows[0].roleId});
    privilegeDialogForm.form('load',{
		'roleId' : rows[0].roleId,
		'resIds' : getList(resIds)
    });
    privilegeDialog.dialog("open");
}

//保存此角色的资源
function savePrivilege(){
	var roleId = $('#roleId').val();
    var resIds = privilegeCombotree.combotree("getValues");
    showProgress();
    $.ajax({
    	url : "${ctx}/sysRole/updatePermission",
        type: 'POST',
		data : {'roleId':roleId,'resIds':resIds},
		cache : false,
		traditional:true,
		dataType: 'json',
		error: function(){
			closeProgress();
		    $.messager.alert('提示信息', '操作失败！');
		},
		success : function(response){
			closeProgress();
		    //点击确定的时候，关闭对话框，并且刷新列表
			if(1 == response.code){
				alertDelay(response.message);
				privilegeDialog.dialog('close');
				$("#roleDatagrid").datagrid('reload');
                privilegeCombotree.combotree('reload');
 		    }
			else{
		    	$.messager.alert('提示信息', response.message,'info');
	        }
		}
    });
}

</script>
<script type="text/javascript">

var dataDialog;
var dataDialogForm;
var dialogUrl;
var dialogMsg;

var privilegeDialog;
var privilegeDialogForm;
var privilegeCombotree;

$(function(){
	dataDialog = $('#dataDialog').show().dialog();
	dataDialogForm = $("#dataDialogForm").form();
	
	privilegeDialog = $('#privilegeDialog').show().dialog();
	
	privilegeDialogForm = $('#privilegeDialogForm').form();
	
	privilegeCombotree = $('#privilegeCombotree').combotree(); 
	
	bandCtrl("queryConditionForm");//给查询条件form中的input绑定回车事件，按下回车时执行查询
});
</script>
</body>
</html>