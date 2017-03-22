<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
</head>
<body>
<div id="cc" class="easyui-layout"  style="width: 100%; height: 630px; margin-left: auto; margin-right: auto">

	<div data-options="region:'north',title:'查询条件',iconCls:'icon-mysearch ',split:true" style="width: 100%;height:66px;">
		<form id="queryConditionForm">
		  <input name="whatSoEver" style="display:none;" /><!-- 当form只有一个input时会，在此input中按回车会自动提交表单，此隐藏的input是为了阻止自动提交的 -->
		  <table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
				<td style="width: 100px;text-align:center;"> 
				  <input id="userNameCombobox" name="userName" style="width:100px;" placeholder="用户名,模糊查询"/>
                </td>
                <td class="td_title" style="width: 40px;" align="right">角色：</td>
				<td style="width: 100px;"> 
				  <input id="roleNameCombobox" name="roleId" style="width:80px;" class="easyui-combobox" 
				         data-options="editable:false,valueField:'id',textField:'name',mode:'remote'" /> 
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
			<global:hasPermission url="/sysUser/create">  
        		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="create();" >增加</a>
        	</global:hasPermission>
        	<global:hasPermission url="/sysUser/edit">
        		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit();" >编辑</a>
        	</global:hasPermission>
        	<global:hasPermission url="/sysUser/delete">
        		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteOne();" >删除</a>
        	</global:hasPermission>
		</div> 
		<table id="userDatagrid" class="easyui-datagrid" title="角色列表" style="width:100%;height:500px;" 
		    url="${ctx}/sysUser/dataGrid" method="post" rownumbers="true" singleSelect="true" 
		    pagination="true" pageSize="15" pageList="[10, 15 , 20, 30, 40 ]" toolbar="#menuToolbar"
		    data-options="loadFilter:globalDatagridFilter"  
		>
			<thead>
				<tr>
					<th field="soWhatEver" width="100" align="center" checkbox="true"></th>
					<th field="userName" width="200" align="center" sortable="true">登录名</th>
					<th field="realName" width="100" align="center">真实姓名</th>
					<th field="phone" width="100" align="center">手机号</th>
					<th field="isSuperAdmin" width="100" align="center" formatter="getIfCn">是否超级管理员</th>
					<th field="roleName" width="150" align="center">角色名称</th>
					<th field="roleStatus" width="60" align="center" formatter="getStatusCn">角色状态</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- 新增对话框 -->
	<div id="dataDialog" style="width:450px;height:350px;display: none" align="center"   
	     data-options=" title:'新增',modal:true,closed:true,maximizable:true,iconCls:'icon-add',
	                    buttons:[{iconCls:'icon-ok',text:'提交',handler:function(){addUser();}}] "  >
		<form id="dataDialogForm">
		<input type="hidden" name="userId" />
	    <table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
				<td class="td_title" width="20%" align="right">用户名：</td>
				<td align="left">
				  <input id="userNameCombobox2" name="userName" style="width:90%;" 
				      class="easyui-validatebox" data-options="required:true,validType:['userNameRemote']" />
                </td>
			</tr>
			<tr>
                <td class="td_title" width="20%" align="right">密码：</td>
                <td align="left">
                  <input id="userPwd" type="password" name="userPwd" style="width:90%;" maxLength="200" 
                      class="easyui-validatebox" data-options="required:true,validType:['length[6,20]']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="20%" align="right">确认密码：</td>
                <td align="left">
                  <input type="password" name="userPwdRepeat" style="width:90%;" maxLength="200" 
                      class="easyui-validatebox" data-options="required:true,validType:['length[6,20]','eqPassword[\'#userPwd\']']"/>
                </td>
            </tr>
			<tr>
				<td class="td_title" width="20%" align="right">真实姓名：</td>
				<td align="left">
				  <input name="realName" style="width:90%;" maxLength="200" class="easyui-validatebox" data-options="required:true"/>
                </td>
			</tr>
			<tr>
				<td class="td_title" width="20%" align="right">手机：</td>
				<td align="left">
					<input name="phone" style="width:90%;" maxLength="11" class="easyui-validatebox" data-options="required:true,validType:['mobile']"/>
				</td>
			</tr>
			<tr>
				<td class="td_title" width="20%" align="right">角色：</td>
				<td align="left">
				  <input id="roleNameCombobox2" name="roleId" style="width:90%;" class="easyui-combobox" 
                         data-options="editable:false,valueField:'id',textField:'name',mode:'remote'" />
                </td>
			</tr>
		</table>
		</form>
	</div>
	
	<!-- 编辑对话框 -->
    <div id="dataDialogEdit" style="width:450px;height:350px;display: none" align="center"
          data-options=" title:'修改用户',modal:true,closed:true,maximizable:true,iconCls:'icon-edit',
                         buttons :[{iconCls:'icon-ok',text:'提交',handler:function(){editUser();}}] "  >
        <form id="dataDialogFormEdit">
        <input type="hidden" name="userId" />
        <table cellspacing="1" cellpadding="0" class="tb_searchbar">
            <tr>
                <td class="td_title" width="20%" align="right">用户名：</td>
                <td align="left">
                  <input name="userName" style="width:90%;" disabled="disabled" />
                </td>
            </tr>
            <tr>
                <td class="td_title" width="20%" align="right">重置密码：</td>
                <td align="left">
                  <input id="userPwdEdit" type="password" name="userPwd" style="width:90%;" maxLength="200" 
                      class="easyui-validatebox" data-options="validType:['length[6,20]']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="20%" align="right">确认密码：</td>
                <td align="left">
                  <input type="password" name="userPwdRepeat" style="width:90%;" maxLength="200" 
                      class="easyui-validatebox" data-options="validType:['length[6,20]','eqPassword[\'#userPwdEdit\']']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="20%" align="right">真实姓名：</td>
                <td align="left">
                  <input name="realName" style="width:90%;" maxLength="200" class="easyui-validatebox" data-options="required:true"/>
                </td>
            </tr>
			<tr>
				<td class="td_title" width="20%" align="right">手机：</td>
				<td align="left">
					<input name="phone" style="width:90%;" maxLength="11" class="easyui-validatebox" data-options="required:true,validType:['mobile']"/>
				</td>
			</tr>
            <tr>
                <td class="td_title" width="20%" align="right">角色：</td>
                <td align="left">
                  <input id="roleNameCombobox3" name="roleId" style="width:90%;" class="easyui-combobox" 
                         data-options="editable:false,valueField:'id',textField:'name',mode:'remote'" />
                </td>
            </tr>
        </table>
        </form>
    </div>
	
</div>
<script type="text/javascript">
function query(){
	var data = $("#queryConditionForm").serializeObject();
	$("#userDatagrid").datagrid('load',data); 
}

function create(){
	dataDialogForm.form('clear');
	dataDialog.dialog("open");
}

function edit(){
	var rows = $("#userDatagrid").datagrid('getSelections');
    if (rows.length != 1){
    	$.messager.alert("提示信息","请选择一行数据");
    	return;
    }
	dataDialogFormEdit.form('clear');
	dataDialogFormEdit.form('load',rows[0]);
	dataDialogEdit.dialog("open");
}

function deleteOne(){
	var rows = $("#userDatagrid").datagrid('getSelections');
    if (rows.length != 1){
    	$.messager.alert("提示信息","请选择一行数据");
    	return;
    }
    if(rows[0].isSuperAdmin==1){
    	$.messager.alert("提示信息","超级管理员不能删除");
    	return;
    }
    commonSubmit("确定要删除此用户？","${ctx}/sysUser/delete",{'userId':rows[0].userId}, "userDatagrid", dataDialog);
}

function addUser(){
    var validateResult = dataDialogForm.form('validate');
    if(!validateResult){
       $.messager.alert('错误提示', '请正确输入！');
       return;
    }
    var data = dataDialogForm.serializeObject();
    if(typeof(data.roleId)=="undefined" || data.roleId=="" || data.roleId<=0){
    	$.messager.alert('错误提示', '请选择角色！');
    	return;
    }
    commonSubmit("确定要增加用户？","${ctx}/sysUser/create",data, "userDatagrid", dataDialog);
}

function editUser(){
	var validateResult = dataDialogFormEdit.form('validate');
    if(!validateResult){
       $.messager.alert('错误提示', '请正确输入！');
       return;
    }
    var data = dataDialogFormEdit.serializeObject();
    if(typeof(data.roleId)=="undefined" || data.roleId=="" || data.roleId<=0){
        $.messager.alert('错误提示', '请选择角色！');
        return;
    }
    commonSubmit("确定要修改用户？","${ctx}/sysUser/edit",data, "userDatagrid", dataDialogEdit);
}
</script>
<script type="text/javascript">
var dataDialog;
var dataDialogForm;

var dataDialogEdit;
var dataDialogFormEdit;

$(function(){
	dataDialog = $('#dataDialog').show().dialog();
	dataDialogForm = $("#dataDialogForm").form();
	
	dataDialogEdit = $('#dataDialogEdit').show().dialog({});
    dataDialogFormEdit = $("#dataDialogFormEdit").form();
	
    // 角色下拉框初始化url以获取数据
	$("#roleNameCombobox").combobox({url : "${ctx}/sysRole/getAllRole?isShowEmpty=true"});
	$("#roleNameCombobox2,#roleNameCombobox3").combobox({url : "${ctx}/sysRole/getAllRole"});
	
	bandCtrl("queryConditionForm");
});

//扩展validatebox
$.extend($.fn.validatebox.defaults.rules, {  
userNameRemote: {
    validator: function (value, param) {
        var isExists = ajaxSync("${ctx}/sysUser/isUserExists", {'userName':value});
        if(isExists=="true"){
            $.fn.validatebox.defaults.rules.userNameRemote.message = '账号已存在';
            return false;
        }
        return true;
   },
   message: ''
}
})

</script>

</body>
</html>