<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>操作日志查询</title>
</head>
<body>
<div id="cc" class="easyui-layout"  style="width: 100%; height: 630px; margin-left: auto; margin-right: auto">
	
	<div data-options="region:'north',title:'查询条件',iconCls:'icon-mysearch ',split:true" style="width: 100%;height:66px;">
		<form id="queryConditionForm">
		  <input name="whatSoEver" style="display:none;" /><!-- 当form只有一个input时会，在页面按回车会自动提交表单，此隐藏的input是为了阻止自动提交的 -->
		  <table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
				<td style="width: 100px;text-align:center;"> 
				  <input name="logTitle" style="width:100px;" placeholder="日志标题,模糊查询"/> 
                </td>
				<td style="width: 100px;text-align:center;"> 
				  <input name="userName" style="width:100px;" placeholder="用户名,模糊查询"/>
                </td>
				<td style="width: 100px;text-align:center;"> 
				  <input name="realName" style="width:100px;" placeholder="真实姓名,模糊查询"/> 
                </td>
                <td class="td_title" style="width: 65px;" align="right">操作时间：</td>
				<td style="width: 240px;"> 
				  <input name="createTime" class="easyui-datebox" style="width:110px;" />-<input name="createTimeTo" class="easyui-datebox" style="width:110px;" /> 
				</td>
                <td align="left">
				     &nbsp;&nbsp;&nbsp;&nbsp;
				     <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" onclick="query();" >查询</a> 
				     &nbsp;&nbsp;&nbsp;&nbsp;
					 <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="clearForm('queryConditionForm');">清空</a>
				</td>
			</tr>
         </table> 
        </form>
    </div>
    
    <div data-options="region:'center',border:false"  style="width: 100%; height: 650px;">
		<table id="logDatagrid" class="easyui-datagrid" title="操作日志列表" style="width:100%;height:500px;" 
		    url="${ctx}/sysLog/dataGrid" method="post" rownumbers="true" singleSelect="true" 
		    pagination="true" pageSize="15" pageList="[10, 15 , 20, 30, 40 ]" 
		    data-options="loadFilter:globalDatagridFilter"  
		>
			<thead>
				<tr>
					<th field="logId" width="65" align="center" formatter="operaTh">日志ID</th>
					<th field="logTitle" width="100" align="center">日志标题</th>
					<th field="userName" width="100" align="center" >用户名</th>
					<th field="realName" width="80" align="center">真实姓名</th>
					<th field="reqIp" width="120" align="center" >IP地址</th>
					<th field="createTime" width="130" align="center" formatter="formatDateTimebox">操作时间</th>
					<th field="reqData" width="550" align="left" formatter="html2Text" >请求参数</th> 
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- 详情对话框 -->
	<div id="dataDialog" style="width:650px;height:410px;display: none" align="center" 
	     data-options=" title:'查看日志详情',modal:true,closed:true,maximizable:true,iconCls:'icon-myinfo',
	                    buttons :[{iconCls:'icon-no',text:'关闭',handler:function(){dataDialog.dialog('close');}}] " >
		<form id="dataDialogForm">
	    <table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
				<td class="td_title" width="15%" align="right">日志ID：</td>
				<td align="left">
				  <input name="logId" style="width:90%;" />
                </td>
			</tr>
			<tr>
                <td class="td_title" width="15%" align="right">操作内容：</td>
                <td align="left">
                  <input name="logTitle" style="width:90%;"/>
                </td>
            </tr>
			<tr>
				<td class="td_title" width="15%" align="right">用户名：</td>
				<td align="left">
				  <input name="userName" style="width:90%;" />
                </td>
			</tr>
			<tr>
				<td class="td_title" width="15%" align="right">真实姓名：</td>
				<td align="left">
				  <input name="realName" style="width:90%;" maxLength="200" />
                </td>
			</tr>
			<tr>
				<td class="td_title" width="15%" align="right">IP地址：</td>
				<td align="left">
				  <input name="reqIp" style="width:90%;"/>
                </td>
			</tr>
			<tr>
				<td class="td_title" width="15%" align="right">操作时间：</td>
				<td align="left">
				  <input id="createTimeStr" style="width:90%;"/>
                </td>
			</tr>
			<tr>
				<td class="td_title" width="15%" align="right">请求参数：</td>
				<td align="left">
				  <textarea name="reqData" rows="11" style="width:90%;resize:none;"></textarea> 
                </td>
			</tr>
		</table>
		</form>
	</div>
	
</div>

<script type="text/javascript">
function query(){
	var data = $("#queryConditionForm").serializeObject();
	$("#logDatagrid").datagrid('load',data);
}

function viewDetail(logId){
    var row = eval("(" + ajaxSync("${ctx}/sysLog/getByKey", {'logId':logId}) + ")");
	dataDialogForm.form('clear');
	dataDialogForm.form('load',row);
	$("#createTimeStr").val(formatDateTimebox(row.createTime));
	dataDialog.dialog("open");
}
function operaTh(logId){
	return "<a href='#' class='easyui-linkbutton' title='点击查看详情' alt='点击查看详情' iconCls='icon-mysearch' plain='true' onclick='viewDetail(\""+logId+"\");' >"+logId+"</a>";
}
var dataDialog;
var dataDialogForm;
$(function(){
	dataDialog = $('#dataDialog').show().dialog();
	dataDialogForm = $("#dataDialogForm").form();
	bandCtrl("queryConditionForm");
})
</script>
</body>
</html>