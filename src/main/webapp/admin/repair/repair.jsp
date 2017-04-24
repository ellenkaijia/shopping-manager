<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/hasPermission" prefix="global"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>维修管理</title>
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
						<td style="width: 250px;"><input name="userId"
							style="width: 200px;" placeholder="用户编号" /></td>
						<td style="width: 250px;"><input name="repairId"
							style="width: 200px;" placeholder="维修单浩" /></td>
						<td class="td_title" style="width: 80px;" align="right">状态：</td>
						<td style="width: 100px;"><select name="status"
							style="width: 80px;">
								<option value="" selected="selected">全部</option>
								<option value="0">未处理</option>
								<option value="1">已处理</option>
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

			<table id="bandDatagrid" class="easyui-datagrid" title="维修列表"
				style="width: 100%; height: 500px;" method="post" rownumbers="true"
				singleSelect="false" pagination="true" pageSize="15"
				pageList="[10, 15 , 20, 30, 40 ]" toolbar="#menuToolbar"
				checkOnSelect="false" selectOnCheck="false"
				data-options="loadFilter:globalDatagridFilter">
				<thead>
					<tr>
						<th field="repairId" width="200" align="center">维修码</th>
						<th field="orderId" width="150" align="center">关联订单码</th>
						<th field="prodId" width="150" align="center">关联产品码</th>
						<th field="userId" width="150" align="center">发起用户</th>
						<th field="userName" width="150" align="center">联系人</th>
						<th field="userPhone" width="150" align="center">联系电话</th>
						<th field="userAddress" width="150" align="center">联系地址</th>
						<th field="whatProblem" width="150" align="center">故障原因</th>
						<th field="status" width="150" align="center" formatter="changeStatus">状态</th>
						<th field="createTime" width="150" align="center" formatter="getEndDate">时间</th>
						<th field="abcdefg" width="230" align="left"
							formatter="operationTh">操作</th>
							
					</tr>
				</thead>
			</table>
		</div>

	</div>

	<script type="text/javascript">
		//定义全局变量cbObj 记录复选框选中的行 id作为key rowData作为value
		cbObj = {};
		$(function() {
			$("#bandDatagrid").datagrid("options").url = "${ctx}/repair/getRepairList";
			bandCtrl("queryConditionForm");//给查询条件form中的input绑定回车事件，按下回车时执行查询

			dataDialogForm = $("#dataDialogForm").form();

		});

	</script>

	<script type="text/javascript">
		// 查询
		function query() {
			var data = $("#queryConditionForm").serializeObject();
			$("#bandDatagrid").datagrid('load', data);
		}

		function changeStatus(value) {
			if(value == 0) {
				return "<span style=\'color:blue\'>未处理</span>";
			} else if(value == 1) {
				return "<span style=\'color:red\'>已处理</span>";
			}
		}
		
		function getEndDate(value) {
			if (value) {
				return formatDatebox(value);
			} else {
				return "/";
			}
		}
		
		function changeRepairStatusOne(id) {
			commonSubmit("该维修单是否要确认？", "${ctx}/repair/changeRepairStatusOne", {
				'id' : id
			}, "bandDatagrid", null);
		}
		
		function operationTh(value, row, index) {
			var opera = "";
			//未匹配且未使用的债权 允许删除
			if (row.status == 0) {
				<global:hasPermission url="/repair/changeRepairStatusOne">
				opera += '<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="changeRepairStatusOne('
						+ "'" + row.id + "'" + ');" >确认处理</a>&nbsp;';
				</global:hasPermission>
			} else {
				opera += "/&nbsp;";
			}
			return opera;
		}


		
	</script>
</body>
</html>