<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/hasPermission" prefix="global"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
</head>
<body>
	<div id="cc" class="easyui-layout"
		style="width: 100%; height: 630px; margin-left: auto; margin-right: auto">
		<div
			data-options="region:'north',title:'查询条件',iconCls:'icon-mysearch ',split:true"
			style="width: 100%; height: 66px;">
			<form id="queryConditionForm">
				<input name="whatSoEver" style="display: none;" />
				<!-- 当form只有一个input时会，在此input中按回车会自动提交表单，此隐藏的input是为了阻止自动提交的 -->
				<table cellspacing="1" cellpadding="0" class="tb_searchbar">
					<tr>
						<td style="width: 250px;"><input name="userName"
							style="width: 200px;" placeholder="用户名" /></td>
						<td style="width: 250px;"><input name="userPhone"
							style="width: 200px;" placeholder="用户手机" /></td>
						<td style="width: 250px;"><input name="userId"
							style="width: 200px;" placeholder="用户编号" /></td>
						<td style="width: 100px;"><select name="status"
							style="width: 80px;">
								<option value="" selected="selected">全部</option>
								<option value="0">非默认地址</option>
								<option value="1">默认地址</option>
						</select></td>
						<td align="left"><a href="javascript:void(0);"
							class="easyui-linkbutton" iconCls="icon-search"
							onclick="query();">查询</a> &nbsp;&nbsp;&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							iconCls="icon-cancel" onclick="clearForm('queryConditionForm');">清空</a>
						</td>
					</tr>
				</table>
			</form>
		</div>

		<div data-options="region:'center',border:false"
			style="width: 100%; height: 650px;">

			<table id="zcProductDatagrid" class="easyui-datagrid" title="用户列表"
				style="width: 100%; height: 500px;" method="post" rownumbers="true"
				singleSelect="false" pagination="true" pageSize="15"
				pageList="[10, 15 , 20, 30, 40 ]" toolbar="#menuToolbar"
				checkOnSelect="false" selectOnCheck="false"
				data-options="loadFilter:globalDatagridFilter">
				<thead>
					<tr>
						<th field="userId" width="180" align="center">用户编号</th>
						<th field="userName" width="120" align="center">用户名</th>
						<th field="userPhone" width="120" align="center">手机号码</th>
						<th field="userAddress" width="120" align="center">收获地址</th>
						<th field="status" width="120" align="center" formatter="changeStatus">是否默认</th>
					</tr>
				</thead>
			</table>
		</div>

	</div>

	<script type="text/javascript">
		//债权打包对话框
		var dataDialog;
		var dataDialogForm;
		var dialogUrl;
		var dialogMsg;

		//定义全局变量cbObj 记录复选框选中的行 id作为key rowData作为value
		cbObj = {};
		$(function() {
			$("#zcProductDatagrid").datagrid("options").url = "${ctx}/user/addressList";
			bandCtrl("queryConditionForm");//给查询条件form中的input绑定回车事件，按下回车时执行查询

			dataDialogForm = $("#dataDialogForm").form();

		});
	</script>

	<script type="text/javascript">
		// 查询
		function query() {
			var data = $("#queryConditionForm").serializeObject();
			$("#zcProductDatagrid").datagrid('load', data);
		}
		
		function changeStatus(value) {
			if(value == 0) {
				return "/";
			} else if(value == 1) {
				return "<span style=\'color:red\'>默认地址</span>";
			}
		}
	</script>
</body>
</html>