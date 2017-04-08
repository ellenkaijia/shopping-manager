<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/hasPermission" prefix="global"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>品牌管理</title>
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
						<td style="width: 250px;"><input name="bandName"
							style="width: 200px;" placeholder="品牌名称" /></td>
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
				<global:hasPermission url="/product/addBand">
					<a href="#" class="easyui-linkbutton" iconCls="icon-add"
						plain="true" onclick="addBandDialog();">新增品牌</a>
				</global:hasPermission>
			</div>

			<table id="bandDatagrid" class="easyui-datagrid" title="产品列表"
				style="width: 100%; height: 500px;" method="post" rownumbers="true"
				singleSelect="false" pagination="true" pageSize="15"
				pageList="[10, 15 , 20, 30, 40 ]" toolbar="#menuToolbar"
				checkOnSelect="false" selectOnCheck="false"
				data-options="loadFilter:globalDatagridFilter">
				<thead>
					<tr>
						<th field="bandId" width="200" align="center">品牌Id</th>
						<th field="bandName" width="150" align="center">品牌名称</th>
					</tr>
				</thead>
			</table>
		</div>


		<!-- 新增对话框 -->
		<div id="dataDialog"
			style="width: 450px; height: 300px; display: none" align="center">
			<form id="dataDialogForm" enctype="multipart/form-data" method="post"
				action="${ctx}/product/addBand">
				<table cellspacing="1" cellpadding="0" class="tb_searchbar">
					<tr>
						<td class="td_title" width="25%" align="right">品牌名称：</td>
						<td align="left"><input name="bandName" style="width: 45%;"
							maxLength="80" class="easyui-validatebox"
							data-options="required:true" /></td>
					</tr>
					<tr>
						<td class="td_title" width="25%" align="right">品牌logo：</td>
						<td align="left"><input name="file" id="bandband"
							style="width: 45%;" maxLength="80" type="file"
							data-options="required:true" class="easyui-validatebox" /></td>
					</tr>
					<tr>
						<td class="td_title" width="25%" align="right">图片预览：</td>
						<td><img id="bandPic" title="品牌logo" alt="品牌logo"
							src="${pageContext.request.contextPath}/images/news_06.png"
							style="width: 45%"></td>
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
		var isValidate = true;
		//定义全局变量cbObj 记录复选框选中的行 id作为key rowData作为value
		cbObj = {};
		$(function() {
			$("#bandDatagrid").datagrid("options").url = "${ctx}/product/showBand";
			bandCtrl("queryConditionForm");//给查询条件form中的input绑定回车事件，按下回车时执行查询

			dataDialogForm = $("#dataDialogForm").form();

		});

		dataDialog = $('#dataDialog').show().dialog({
			title : '新增品牌管理',
			modal : true,
			closed : true,
			maximizable : true,
			buttons : [ {
				text : '添加',
				handler : function() {
					addData();
				}
			} ]
		});
	</script>

	<script type="text/javascript">
		// 查询
		function query() {
			var data = $("#queryConditionForm").serializeObject();
			$("#bandDatagrid").datagrid('load', data);
		}

		function addData() {
			var validateResult = dataDialogForm.form('validate');
			if (!validateResult) {
				$.messager.alert('错误提示', '请正确输入！');
				return;
			}
			extracted();
		}

		function addBandDialog() {
			dataDialogForm.form('clear');
			dialogUrl = "${ctx}/product/addBand";
			dialogMsg = "确定要添加品牌？";
			dataDialog.dialog('setTitle', "添加品牌");
			$("#bandband").change(function() {
				var file = this.files[0];
				var reader = new FileReader();
				reader.readAsDataURL(file);
				reader.onload = function(e) {
					$("#bandPic").attr("src", this.result);
				};
			});
			dataDialog.dialog("open");
		}

		/**
		 * 提交表单
		 */
		function extracted() {
			$.messager.confirm("请确认", dialogMsg, function(flag) {
				if (flag) {
					showProgress();
					$('#dataDialogForm').form(
							'submit',
							{
								onSubmit : function() {
									var isValid = $(this).form('validate');
									if (!isValid) {
										$.messager.progress('close'); // hide progress bar while the form is invalid
									}
									if (!isValidate) {
										$.messager.alert('提示',
												'不能重复提交表单，请关闭重新开启');
										closeProgress();
									}
									return isValidate; // return false will stop the form submission
								},
								success : function(data) {
									var data = eval('(' + data + ')'); // change the JSON string to javascript object
									$.messager.confirm('提示', data.message
											+ "\n 是否去掉该表单？", function(r) {
									});
									closeProgress();
								}
							});
				}
			});
		}
	</script>
</body>
</html>