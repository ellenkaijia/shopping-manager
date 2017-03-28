<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="/hasPermission" prefix="global"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="../../public/console_lib.jsp" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>产品管理</title>
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
					<td style="width: 250px;"><input name="prodName"
													 style="width: 200px;" placeholder="产品名称" /></td>
					<td style="width: 250px;"><input name="codeId"
													 style="width: 200px;" placeholder="产品型号" /></td>
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
		<div id="menuToolbar" style="height: auto" class="datagrid-toolbar">
			<global:hasPermission url="/product/createProduct">
				<a href="#" class="easyui-linkbutton" iconCls="icon-add"
				   plain="true" onclick="addProductDialog();">新增产品</a>
			</global:hasPermission>
		</div>

		<table id="zcProductDatagrid" class="easyui-datagrid" title="产品列表"
			   style="width: 100%; height: 500px;" method="post" rownumbers="true"
			   singleSelect="false" pagination="true" pageSize="15"
			   pageList="[10, 15 , 20, 30, 40 ]" toolbar="#menuToolbar"
			   checkOnSelect="false" selectOnCheck="false"
			   data-options="loadFilter:globalDatagridFilter">
			<thead>
			<tr>
				<th field="prodId" width="80" align="center">产品Id</th>
				<th field="prodName" width="120" align="center">产品名称</th>
				<th field="codeId" width="70" align="center">产品型号</th>
				<th field="prodDetail" width="30" align="center">产品详情</th>
				<th field="prodTypeName" width="130" align="left">所属种类</th>
				<th field="prodPrize" width="100" align="right">产品价格（元）</th>
				<th field="prodFreeTime" width="90" align="center">产品保修期（年）</th>
				<th field="prodSum" width="80" align="center">产品库存量</th>
				<th field="prodSellSum" width="80" align="center">产品已售量</th>
				<th field="createTime" width="100" align="center">上传时间</th>
				<th field="status" width="100" align="center">状态</th>
				<th field="abcdefg" width="200" align="left"
					formatter="operationTh">操作</th>
			</tr>
			</thead>
		</table>
	</div>

	<!-- 新增产品对话框 -->
	<div id="dataDialog"
		 style="width: 450px; height: 300px; display: none" align="center">
		<form id="dataDialogForm">
			<table cellspacing="1" cellpadding="0" class="tb_searchbar">
				<tr>
					<td class="td_title" width="25%" align="right">产品名称：</td>
					<td align="left"><input name="prodName" style="width: 45%;"
											maxLength="80" class="easyui-validatebox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品型号：</td>
					<td align="left"><input name="codeId" style="width: 45%;"
											maxLength="80" class="easyui-validatebox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品详情：</td>
					<td align="left"><input name="prodDetail" style="width: 45%;"
											maxLength="80" class="easyui-validatebox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">种类名称：</td>
					<td align="left"><input name="prodTypeName" style="width: 45%;"
											maxLength="80" class="easyui-validatebox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品价格：</td>
					<td align="left"><input name="prodPrize" style="width: 45%;"
											maxLength="80" class="easyui-numberbox"
											data-options="required:true" /></td>&nbsp;元
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品保修期：</td>
					<td align="left"><input name="prodFreeTime" style="width: 45%;"
											maxLength="80" class="easyui-numberbox"
											data-options="required:true" /></td>&nbsp;年
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品库存量：</td>
					<td align="left"><input name="prodSum" style="width: 45%;"
											maxLength="80" class="easyui-numberbox"
											data-options="required:true" /></td>&nbsp;个
				</tr>
			</table>
		</form>
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
		$("#zcProductDatagrid").datagrid("options").url = "${ctx}/product/dataGrid";
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

	// 打开债权打包对话框
	function addProductDialog() {
		var tabTitle = "新增产品";
    	var tabIcon = "";
    	parent.addTab(tabTitle, "/admin/product/addProduct.jsp", tabIcon);
	}

	function operationTh(value, row, index) {
		var opera = "";
		//未匹配且未使用的债权 允许删除
		if (row.isUsed == 0 && row.isMatch == 0) {
			<global:hasPermission url="/zcDebt/delete">
			opera += '<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleDebt('
					+ row.id + ');" >删除</a>&nbsp;';
			</global:hasPermission>
		} else {
			opera += "/&nbsp;";
		}
		//未匹配且未使用的债权 允许编辑债权
		if (row.isUsed == 0 && row.isMatch == 0) {
			<global:hasPermission url="/zcDebt/update">
			opera += '<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="showUpdateDebt('
					+ row.id + ');" >编辑</a>&nbsp;';
			</global:hasPermission>
		} else {
			opera += "/";
		}
		return opera;
	}

</script>
</body>
</html>