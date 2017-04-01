<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 修改产品 -->
<div id="updateDialog" style="width:550px;height:550px;display: none" align="center">
	<form id="updateForm">
		<input type="hidden" name="prodId"/>
		<table cellspacing="1" cellpadding="0" class="tb_searchbar">
			<tr>
					<td class="td_title" width="25%" align="right">产品名称：</td>
					<td align="left"><input name="prodName" style="width: 45%;"
											maxLength="80" class="easyui-textbox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品型号：</td>
					<td align="left"><input name="codeId" style="width: 45%;"
											maxLength="80" class="easyui-textbox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品详情：</td>
					<td align="left"><input name="prodDetail" style="width: 45%;"
											maxLength="80" class="easyui-textbox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">种类名称：</td>
					<td align="left"><input name="prodTypeName" style="width: 45%;"
											maxLength="80" class="easyui-textbox"
											data-options="required:true" /></td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品价格：</td>
					<td align="left"><input name="prodPrize" style="width: 45%;"
											maxLength="80" class="easyui-numberbox"
											data-options="required:true" />&nbsp;元</td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品保修期：</td>
					<td align="left"><input name="prodFreeTime" style="width: 45%;"
											maxLength="80" class="easyui-textbox"
											data-options="required:true" />&nbsp;年</td>
				</tr>
				<tr>
					<td class="td_title" width="25%" align="right">产品库存量：</td>
					<td align="left"><input name="prodSum" style="width: 45%;"
											maxLength="80" class="easyui-numberbox"
											data-options="required:true" />&nbsp;个</td>
				</tr>
			
		</table>
	</form>
</div>

<script type="text/javascript">
	var updateDialog;
	var updateForm;
	var detailUrl = "${ctx}/product/show";
	var updateUrl = "${ctx}/product/update";

	$(function () {
		updateDialog = $('#updateDialog').show().dialog({
			title: '修改产品信息',
			modal: true,
			closed: true,
			maximizable: true,
			buttons: [{
				id: 'updateDebtButton',
				text: '修改',
				handler: function () {
					submitUpdateDebt();
				}
			}]
		});

		updateForm = $("#updateForm").form();
	});

	//显示修改弹出框
	function showUpdateProduct(id) {
		$("#updateDebtButton").show();
		updateDialog.dialog('setTitle', "产品修改");
		loadAndShowData(id); // 实时查询数据并填充form以便显示
		updateDialog.dialog("open");
	}

	// 实时查询数据并填充form以便显示
	function loadAndShowData(id) {
		updateForm.form('clear');
		var response = eval("(" + ajaxSync(detailUrl, {'id': id}) + ")"); // 实时查询数据
		if (response == null || response == undefined) {
			$.messager.alert('提示信息', '查询出错！');
		}
		updateForm.form('load', response);
	}

	function submitUpdateDebt() {
		var validateResult = updateForm.form('validate');
		if (!validateResult) {
			$.messager.alert('错误提示', '请正确输入！');
			return;
		}
		var data = updateForm.serializeObject();
		
		commonSubmit("确认修改此产品？", updateUrl, data, "zcProductDatagrid",
				updateDialog);  
	}
</script>


