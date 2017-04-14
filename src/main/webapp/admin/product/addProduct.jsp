<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/hasPermission" prefix="global"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增加产品</title>
<script type="text/javascript" charset="utf-8"
	src="${ctx}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${ctx}/js/ueditor/ueditor.all.min.js">
	
</script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8"
	src="${ctx}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
	<div id="cc" class="easyui-layout"
		style="width: 100%; margin-left: auto; margin-right: auto; font-size: 13px;">
		<c:if test="${not empty message}">
			<p>
				<span>${message}</span>
			</p>
		</c:if>
		<table>
			<tr>
				<td>
					<!-- 新增对话框 -->
					<div id="dataDialog" style="width: 800px;" align="center">
						<form id="dataDialogForm" enctype="multipart/form-data"
							method="post" action="${ctx}/product/createProduct">
							<table id="basicInfo" cellspacing="1" cellpadding="0"
								class="tb_searchbar">
								<tr>
									<td class="td_title" width="25%" align="right">产品名称：</td>
									<td align="left"><input name="prodName"
										style="width: 45%;" maxLength="80" class="easyui-validatebox"
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
									<td align="left"><input name="prodDetail"
										style="width: 45%;" maxLength="80" class="easyui-validatebox"
										data-options="required:true" /></td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">种类名称：</td>
									<td style="width: 250px;"><input name="sortId"
													 style="width: 200px;" class="easyui-combobox"
													 data-options="url:'${ctx}/product/getSort',editable:false,valueField:'sortId',textField:'sortName',mode:'remote'" />
									</td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">所属品牌：</td>
									<td align="left"><input name="bandId"
										style="width: 45%;" class="easyui-combogrid"
										id="selectBandId" /></td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">产品价格：</td>
									<td align="left"><input name="prodPrize"
										style="width: 45%;" maxLength="80" class="easyui-numberbox"
										data-options="required:true" />&nbsp;元</td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">产品保修期：</td>
									<td align="left"><input name="prodFreeTime"
										style="width: 45%;" maxLength="80" class="easyui-numberbox"
										data-options="required:true" />&nbsp;年</td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">产品库存量：</td>
									<td align="left"><input name="prodSum" style="width: 45%;"
										maxLength="80" class="easyui-numberbox"
										data-options="required:true" />&nbsp;个</td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">产品第一实例图：</td>
									<td><input type="file" id="pictureOne" name="file"
										style="width: 45%;"></td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">产品详情图片1：</td>
									<td><input type="file" id="pictureTwo" name="file"
										style="width: 45%;"></td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">产品详情图片2：</td>
									<td><input type="file" id="pictureThree" name="file"
										style="width: 45%;"></td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">产品详情图片3：</td>
									<td><input type="file" id="pictureFour" name="file"
										style="width: 45%;"></td>
								</tr>
								<tr>
									<td class="td_title" width="25%" align="right">图片预览：</td>
									<td><img id="picOne" title="产品第一实例图" alt="产品第一实例图"
										src="${pageContext.request.contextPath}/images/news_06.png"
										style="width: 45%"> <img id="picTwo" title="产品详情图片1"
										alt="产品详情图片1"
										src="${pageContext.request.contextPath}/images/news_06.png"
										style="width: 45%"> <img id="picThree" title="产品详情图片2"
										alt="产品详情图片2"
										src="${pageContext.request.contextPath}/images/news_06.png"
										style="width: 45%"> <img id="picFour" title="产品详情图片3"
										alt="产品详情图片3"
										src="${pageContext.request.contextPath}/images/news_06.png"
										style="width: 45%"></td>
								</tr>
							</table>
						</form>

					</div>

				</td>
				<td style="margin-left: 100px; vertical-align: top;"><global:hasPermission
						url="/product/createProduct">
						<a id="addProdButton" href="#" style="display: block;"
							class="easyui-linkbutton" iconCls="icon-add" plain="true"
							onclick="submitUpdateProd();">增加产品</a>
					</global:hasPermission></td>
			</tr>
		</table>

	</div>

	<script type="text/javascript">
		var dataDialogForm;
		var dialogUrl;
		var dialogMsg;
		var isValidate = true;
		var assetIdComboboxData;
		$(function() {
			dataDialogForm = $("#dataDialogForm").form();
			dialogUrl = "${ctx}/product/createProduct";
			dialogMsg = "确认新增该产品？";
			
			assetIdComboboxData = $("#selectBandId").combogrid({
				url:'${ctx}/product/getBand',
				panelWidth:260,
				mode:'remote',
				editable:false,
				idField:'bandId',
				textField:'bandName',
				columns:[[
					{field:'bandId',title:'品牌Id',width:150},
					{field:'bandName',title:'品牌名称',width:100},
				]]
			});
			
		});
		

		// 提交数据
		function submitUpdateProd() {
			var data = dataDialogForm.serializeObject();
			var validateResult = dataDialogForm.form('validate');
			if (!validateResult) {
				$.messager.alert('错误提示', '请正确输入！');
				return;
			}
			if(data.bandId == '' || data.bandId == null) {
				$.messager.alert('错误提示', '所属品牌不能为空');
				return;
			}
			var formData = new FormData($("#dataDialogForm")[0]);
			extracted(formData);
			assetIdComboboxData = null;
		}

		/**
		 * 提交表单
		 */
		function extracted(data) {
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
										isValidate = false;
									});
									closeProgress();
								}
							});
				}
			});
		}

		$("#pictureOne").change(function() {
			var file = this.files[0];
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				$("#picOne").attr("src", this.result);
			};
		});

		$("#pictureTwo").change(function() {
			var file = this.files[0];
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				$("#picTwo").attr("src", this.result);
			};
		});

		$("#pictureThree").change(function() {
			var file = this.files[0];
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				$("#picThree").attr("src", this.result);
			};
		});

		$("#pictureFour").change(function() {
			var file = this.files[0];
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				$("#picFour").attr("src", this.result);
			};
		});
	</script>

</body>
</html>
