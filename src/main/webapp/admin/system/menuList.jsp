<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/hasPermission" prefix="global"%>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../../public/console_lib.jsp" />
<title>菜单管理</title>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>/js/icon.js?${version}"></script>
<script type="text/javascript" src="<%=basePath%>/js/easyui/ajaxfileupload.js?${version}" charset="utf-8"></script>
</head>
<body>

<div id="cc" class="easyui-layout"  style="width: 100%; height: 750px; margin-left: auto; margin-right: auto">
    <div data-options="region:'center',border:false"  style="height: 500px;">
        <div id="menuToolbar" style="padding:5px;height:auto" class="datagrid-toolbar">    
            <div >    
                <global:hasPermission url="/sysResource/create">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addRess();" >增加</a>
                </global:hasPermission>
                <a href="#" class="easyui-linkbutton" iconCls="icon-20" plain="true" onclick="expandOrCollapse(1);">展开</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-16" plain="true" onclick="expandOrCollapse(2);">折叠</a>
                <global:hasPermission url="/sysResource/treeGrid">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="treeGridReload();">刷新</a>
                </global:hasPermission>
                <global:hasPermission url="/sysResource/exportMenu">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="exportMenu();">导出资源</a>
                </global:hasPermission>
                <global:hasPermission url="/sysResource/importMenu">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="showImportDialog();">导入资源</a>
                </global:hasPermission>
            </div>
        </div> 
        <table id="treegrid" title="菜单管理" class="easyui-treegrid" style="width:800px;height:700px;" 
                url="${ctx}/sysResource/treeGrid" toolbar="#menuToolbar"   
                method="post" rownumbers="false" idField="resId" treeField="resName" iconCls='icon-ok' 
                data-options="loadFilter:convert"
        >
        <thead>
            <tr>
                <th field="resId" align="center" width="40" >ID</th>
                <th field="resName" width="250" >资源名称</th>
                <th field="resType" width="60" align="center" formatter="getResTypeCn">资源类型</th>
                <th field="resUrl" width="270" >资源URL</th>
                <th field="resSeq" width="35" align="right">排序</th>
                <th field="resStatus" width="40" align="center" formatter="getStatusCn">状态</th>
                <th field="none" width="65" align="center" formatter="formatOpera">操作</th>
            </tr>
        </thead>
        </table>
    </div>
    
    <!-- 新增对话框 -->
    <div id="dataDialog" style="width:450px;height:300px;display: none" align="center" 
         data-options=" title:'增加资源',modal:true,closed:true,maximizable:true,iconCls:'icon-add',
                        buttons:[{iconCls:'icon-ok',text:'提交',handler:function(){addOrEditData();}}] " >
        <form id="dataDialogForm">
        <input type="hidden" name="resId" />
        <table cellspacing="1" cellpadding="0" class="tb_searchbar">
            <tr>
                <td class="td_title" width="20%" align="right">资源名称：</td>
                <td align="left">
                  <input name="resName" style="width:90%;" maxLength="80" class="easyui-validatebox" data-options="required:true"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="20%" align="right">资源状态：</td>
                <td align="left">
                  <select name="resStatus" style="width:90%;" class="easyui-validatebox" data-options="required:true" >
                        <option  value="" selected="selected"></option>
                        <option  value="1" >有效</option>
                        <option  value="2" >无效</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="20%" align="right">资源类型：</td>
                <td align="left">
                  <select name="resType" style="width:90%;" class="easyui-validatebox" data-options="required:true">
                        <option  value="" selected="selected"></option>
                        <option  value="1" >菜单</option>
                        <option  value="2" >操作</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="20%" align="right">资源URL：</td>
                <td align="left">
                  <input name="resUrl" style="width:90%;" maxLength="80" />
                </td>
            </tr>
            <tr>
                <td class="td_title" width="15%" align="right">资源图标：</td>
                <td align="left">
                  <input name="resIcon" style="width:90%;" class="easyui-combobox" 
                         data-options="data:iconData,panelHeight:300,required:true,editable:false,formatter:formatIconList "  />
                </td>
            </tr>
            <tr>
                <td class="td_title" width="15%" align="right">排序号：</td>
                <td align="left">
                  <input name="resSeq" style="width:90%;" maxLength="3" class="easyui-validatebox" data-options="required:true,validType:['positiveInteger']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="15%" align="right">父级资源：</td>
                <td align="left">
                  <input id="resParentIdCombotree" name="resParentId" style="width:90%;" class="easyui-comboTree" 
                         data-options=" url:'${ctx}/sysResource/resParentIdCombotree',valueField:'resId',lines:true,required: false,
                                        editable : false,cascadeCheck:false,panelHeight:350,loadFilter:convert " /><br/>
                  <div style="text-align:center;"><a href="javascript:void(0);" style="text-decoration:none;" onclick="cleanResParent();">置空(即一级菜单)&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                </td>
            </tr>
        </table>
        </form>
    </div>
    
    <!-- 导出资源form -->
    <form id="exportMenuForm" action="${ctx}/sysResource/exportMenu" method="post"></form>
    
    <!-- 导入菜单 -->
    <div id="importMenuDialog"  style="width:450px;height:200px;display:none;" align="center" 
         data-options=" title:'导入菜单',modal:true,closed:true,maximizable:true,iconCls:'icon-add',
                        buttons:[{iconCls:'icon-ok',text:'提交',handler:function(){importMenu();}}] "  >
        <form id="importMenuForm">
                <tr>
                    <td align="left">
                        <input type="file" id="importMenuFile" name="importMenuFile" style="width:300px;" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
    
</div>

<script type="text/javascript">

function showImportDialog(){
    importMenuForm.form('clear');
    importMenuDialog.dialog('open');
}

function importMenu(){
    if(!importMenuForm.form('validate')){
        return;
    }
    if($("#importMenuFile").val()==""){
        $.messager.alert("错误提示","您未选择文件");
        return;
    }
    var data =  importMenuForm.serializeObject();
    commonFileSubmitTree("请确认你已经充分了解导入菜单会造成的后果" , "${ctx}/sysResource/importMenu" , data , "importMenuFile" , "treegrid" , importMenuDialog);
}

function exportMenu(){
    $.messager.confirm("请确认","导出资源耗费时间较长，请确认操作！",function(flag){
        if(flag==true){
            $('#exportMenuForm').submit();
        }
    });
}

function expandOrCollapse(type){
    if(type==1){
        $("#treegrid").treegrid('expandAll');
    }
    else{
        $("#treegrid").treegrid('collapseAll');
    }
}

function treeGridReload(){
    $("#treegrid").treegrid('load');
}

function formatOpera(value, row, index){
    var opHtml = "";  
    <global:hasPermission url="/sysResource/edit">
        opHtml = '<a alt="修改" title="修改" class="icon-edit" style="display:inline-block;vertical-align:middle;width:16px;height:16px;" href="javascript:void(0);" onclick="editRess(' + row.resId + ');"></a>';
        opHtml += '&nbsp&nbsp';
    </global:hasPermission>
    <global:hasPermission url="/sysResource/delete">
        opHtml += '<a alt="删除" title="删除" class="icon-remove" style="display:inline-block;vertical-align:middle;width:16px;height:16px;" href="javascript:void(0);" onclick="deleteRess(' + row.resId + ');"></a>';
    </global:hasPermission>
    return opHtml;
}

function formatString(str){
    for ( var i = 0; i < arguments.length - 1; i++){
        str = str.replace("{" + i + "}", arguments[i + 1]);
    }
    return str;
}

function cleanResParent(){
    resParentIdCombotree.combotree('setValue','');
    resParentIdCombotree.combotree('clear');
}

function deleteRess(resId){
    commonSubmitTree("该资源及其所有子资源以及角色相关资源都将删除<br/>确定？","${ctx}/sysResource/delete",{'resId':resId},"resParentIdCombotree","treegrid",dataDialog);
}

function editRess(resId){
    dataDialogForm.form('clear');
    $("#treegrid").treegrid('select', resId);
    var row = $("#treegrid").treegrid('getSelected');
    dataDialogForm.form('load',row);
    if(row.resParentId==undefined || row.resParentId==null || row.resParentId==""){
        cleanResParent();//置空父级菜单id
    }
    dialogUrl = "${ctx}/sysResource/edit";
    dialogMsg = "确定要修改资源？";
    dataDialog.dialog({title:"修改资源",iconCls:'icon-edit'});
    dataDialog.dialog("open");
}

function addRess(){
    dataDialogForm.form('clear');
    dialogUrl = "${ctx}/sysResource/create";
    dialogMsg = "确定要增加资源？";
    dataDialog.dialog({title:"增加资源",iconCls:'icon-add'});
    dataDialog.dialog("open");
}

function addOrEditData(){
    var validateResult = dataDialogForm.form('validate');
    if(!validateResult){
       $.messager.alert('错误提示', '请正确输入！');
       return;
    }
    var data = dataDialogForm.serializeObject();
    if(data.resType==2 && (data.resUrl==null || data.resUrl=="")){
        $.messager.alert('错误提示', '资源类型为操作时，url不能为空');
        return;;
    }
    commonSubmitTree(dialogMsg,dialogUrl,data,"resParentIdCombotree","treegrid",dataDialog);
}

function formatIconList(v){
    return formatString('<span class="{0}" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span>&nbsp;{1}', v.value, v.value);
}

</script>
<script type="text/javascript">
var dataDialog;
var dataDialogForm;
var dialogUrl;
var dialogMsg;
var importMenuDialog;
var importMenuForm;
$(function(){
    dataDialog = $('#dataDialog').show().dialog();
    dataDialogForm = $("#dataDialogForm").form();
    resParentIdCombotree = $('#resParentIdCombotree').combotree(); 
    importMenuDialog = $('#importMenuDialog').show().dialog();
    importMenuForm = $("#importMenuForm").form();
});
</script>

</body>
</html>