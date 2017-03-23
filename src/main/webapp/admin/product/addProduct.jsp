<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="global" uri="http://ssj.kingdee.com/tags/html" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../../public/console_lib.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增加产品</title>
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<div id="cc" class="easyui-layout"  style="width: 100%; margin-left: auto; margin-right: auto;font-size:13px;">
<table><tr>
    <td>
    <!-- 新增对话框 -->
    <div id="dataDialog" style="width:800px;" align="center" >
        <form id="dataDialogForm">
        <input type="hidden" name="id" />
        <input type="hidden" name="prodId" id="prodId" />
        <input type="hidden" name="settleBatchId" />
        <table id="basicInfo" cellspacing="1" cellpadding="0" class="tb_searchbar">
			<input id="status" name="status" readonly="readonly" type="hidden">
            <tr >
                <td class="td_title" width="25%" align="right"><span id="tmpTrTitle" style="display:none;" >选择产品模板：</span></td>
                <td align="left">
                    <span id="tmpTr" style="display:none;" >
                    <input id="prodTmpCombobox" name="tmpId" style="width:150px;" class="easyui-combobox"
                               data-options="editable:false,valueField:'id',textField:'tmpName',mode:'remote'" /> 
                    </span>
                </td>
                <td class="td_title" width="25%" align="right" rowspan="13">期数利率：</td>
                <td align="left" rowspan="13" style="vertical-align: middle;">
                    &nbsp;&nbsp;1期<input id="annualRate0" name="rateList[0].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[0].period" value="1" type="hidden"><br/>
                    &nbsp;&nbsp;2期<input id="annualRate1" name="rateList[1].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[1].period"  value="2" type="hidden"/><br/>
                    &nbsp;&nbsp;3期<input id="annualRate2" name="rateList[2].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[2].period"  value="3" type="hidden"/><br/>
                    &nbsp;&nbsp;4期<input id="annualRate3" name="rateList[3].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[3].period"  value="4" type="hidden"/><br/>
                    &nbsp;&nbsp;5期<input id="annualRate4" name="rateList[4].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[4].period"  value="5" type="hidden"/><br/>
                    &nbsp;&nbsp;6期<input id="annualRate5" name="rateList[5].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[5].period"  value="6" type="hidden"/><br/>
                    &nbsp;&nbsp;7期<input id="annualRate6" name="rateList[6].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[6].period"  value="7" type="hidden"/><br/>
                    &nbsp;&nbsp;8期<input id="annualRate7" name="rateList[7].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[7].period"  value="8" type="hidden"/><br/>
                    &nbsp;&nbsp;9期<input id="annualRate8" name="rateList[8].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[8].period"  value="9" type="hidden"/><br/>
                    10期<input id="annualRate9" name="rateList[9].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[9].period"  value="10" type="hidden"/><br/>
                    11期<input id="annualRate10" name="rateList[10].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[10].period"  value="11" type="hidden"/><br/>
                    12期<input id="annualRate11" name="rateList[11].annualRate" style="width:40%;text-align:center;" maxLength="5" class="easyui-validatebox" 
                        data-options="required:true,validType:['isDecimalTwo','range[0.01,99.99]']"/>%<input name="rateList[11].period"  value="12" type="hidden"/><br/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">产品名称：</td>
                <td align="left">
                  <input id="pname" name="pname" style="width:80%;" maxLength="80" class="easyui-validatebox" data-options="required:true" />
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">产品类型：</td>
                <td align="left">
                  <select id="ptype" name="ptype" style="width:55%;" maxLength="80" class="easyui-validatebox" data-options="required:true" >
                    <option value="" selected="selected"></option>
                    <option value="1">普通产品</option>
                    <option value="2">新手产品</option>
					<option value="3">抢购产品</option>
                  </select>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">期数：</td>
                <td align="left">
                  <input name="periods" style="width:45%;" maxLength="2" class="easyui-validatebox" onkeyup="changePeriods(this.value);" data-options="required:true,validType:['positiveInteger']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">锁定期限（月）：</td>
                <td align="left">
                  <input name="lockPeriods" style="width:45%;" maxLength="2" class="easyui-validatebox" data-options="required:true,validType:['positiveInteger']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">预约截止当期结息日之前期限（天）：</td>
                <td align="left">
                  <input name="reserveDay" style="width:45%;" maxLength="3" class="easyui-validatebox" data-options="required:true,validType:['positiveInteger']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">募集金额（元）：</td>
                <td align="left">
                    <input id="amountYuan" name="amountYuan" style="width:45%;" maxLength="10" class="easyui-validatebox" data-options="required:true,validType:['positiveInteger']"/>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">最低申购金额（元）：</td>
                <td align="left">
                  <input name="minInvestAmountYuan" style="width:45%;" maxLength="10" class="easyui-validatebox" data-options="required:true,validType:['positiveInteger','lessThan[\'#amountYuan\']']" />
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">最大申购金额（元）：</td>
                <td align="left">
                  <input name="maxInvestAmountYuan" style="width:45%;" maxLength="10" class="easyui-validatebox" 
                         data-options="required:true,validType:['positiveInteger','lessThan[\'#amountYuan\']']"/>
                </td>
            </tr>
            <tr id="raiseStartTimeTr">
                <td class="td_title" width="25%" align="right">募集开始时间：</td>
                <td align="left">
                    <input name="raiseStartTimeStr" id ="raiseStartTimeBox" style="width:177px;" maxLength="20" class="easyui-datetimebox" 
                           data-options="editable:false,required:true"/>
                </td>
            </tr>
            <tr id="raiseEndTimeTr">
                <td class="td_title" width="25%" align="right">募集截止时间：</td>
                <td align="left">
                    <input name="raiseEndTimeStr" id="raiseEndTimeBox" style="width:177px;" maxLength="20" class="easyui-datetimebox" 
                           data-options="editable:false,required:true"/>
                </td>
            </tr>
            <tr id="calculInterestDateTr">
                <td class="td_title" width="25%" align="right">起息日期：</td>
                <td align="left">
                    <input name="calculInterestDateStr" id="calculInterestDateStr" style="width:50%;" maxLength="80" class="easyui-datebox" data-options="editable:false,required:true"/>
                </td>
            </tr>
            <tr id="timeUnitCodeTr">
                <td class="td_title" width="25%" align="right">时间单位类型：</td>
                <td align="left" >
                    <input id="timeUnitCodeCombobox" name="timeUnitCode"  style="width:50%;" class="easyui-combobox" data-options="editable:false,multiple:false"/>
                </td>
            </tr>
            <tr id="saleChannelTr">
                <td class="td_title" width="25%" align="right">购买渠道：</td>
                <td align="left" colspan="3">
                   	理财市场：<input type="checkbox" name="saleChannel"  value="04" checked="checked"/>&nbsp;
					WEB-PC：<input type="checkbox" name="saleChannel"  value="02" />&nbsp;
					H5： <input type="checkbox" name="saleChannel"     value="12" />&nbsp;
				     <!--     随管家：   <input type="checkbox" name="saleChannel"  value="01" />&nbsp; -->
                </td>
            </tr>
            <tr id="assetTr">
                <td class="td_title" width="25%" align="right">选择资产：</td>
                <td align="left" colspan="3">
                   <input id="assetIdsCombobox" name="assetIdsCombobox"  style="width:85%;" class="easyui-combobox" data-options="editable:false,multiple:true"/>
                    <a id="refreshAssetsButton" href="#" style="display:none;" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="refreshAssets();" >清除重新选择</a>
                </td>
            </tr>
			<tr id="publishTimeTr" style="display: none">
				<td class="td_title" width="25%" align="right">发布时间：</td>
				<td align="left" >
					<input name="publishTimeStr" id="publishTimeStr" style="width:177px;" maxLength="20" class="easyui-datetimebox" data-options="editable:false,required:false"/>
				</td>
				<td class="td_title" width="25%" align="right"></td>
				<td align="left"></td>
			</tr>
			<tr>
				<td class="td_title" width="25%" align="right">活动标签：</td>
				<td align="left" colspan="3" >
					<input id="activityTag" name="activityTag" style="width:90%;" maxlength="100" />
				</td>
			</tr>
            <tr>
                <td class="td_title" width="25%" align="right">补贴说明：</td>
                <td align="left" colspan="3">
					<input id="subsidy" name="subsidy" style="width:90%;" maxlength="100" />
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">项目介绍：</td>
                <td align="left" colspan="3">
                    <script id="editor-edit-description" type="text/plain" style="width:100%;height:80px;"></script>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">资金用途：</td>
                <td align="left" colspan="3">
                    <script id="editor-edit-moneyPurpose" type="text/plain" style="width:100%;height:80px;"></script>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">资金保障：</td>
                <td align="left" colspan="3">
                    <script id="editor-edit-insurance" type="text/plain" style="width:100%;height:80px;"></script>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">收益计算：</td>
                <td align="left" colspan="3">
                    <script id="editor-edit-interestCalculate" type="text/plain" style="width:100%;height:80px;"></script>
                </td>
            </tr>
            <tr>
                <td class="td_title" width="25%" align="right">如何赎回：</td>
                <td align="left" colspan="3">
                    <script id="editor-edit-redeem" type="text/plain" style="width:100%;height:80px;"></script>
                </td>
            </tr>
        </table>
        </form>
    </div>
    
    </td>
    <td style="margin-left:100px;vertical-align:top;">
    <a id="refreshProdButton" href="#" style="display:none;" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="refreshPage();" >刷新数据</a>
    <global:hasPermission url="/zcProd/create">
        <a id="addProdButton" href="#" style="display:none;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="submitUpdateProd();" >增加产品</a>
    </global:hasPermission>
    <global:hasPermission url="/zcProd/update">
        <a id="editProdButton" href="#" style="display:none;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="submitUpdateProd();" >保存修改</a>
    </global:hasPermission>
    
    </td></tr>
</table>
    
</div>

<script type="text/javascript">

	var operaType = getQueryString("operaType"); //操作类型
	var pid = getQueryString("pid"); // 产品ID
	var settleBatchId = getQueryString("settleBatchId"); // 结息批次ID
	var tmpId = getQueryString("tmpId"); // 模板ID
	var settleDate = getQueryString("settleDate"); // 到期日
	var planAddAmount = getQueryString("planAddAmount"); // 到期资产金额
	planAddAmount = planAddAmount == 'null' ? 0 : planAddAmount;

	var dataDialogForm;
	var dialogUrl;
	var dialogMsg;

	var assetIdsCombobox; // 资产下拉框，多选
	var timeUnitCodeCombobox; // 时间单位类型下拉框
	var assetIdsUrl; // 资产列表请求路径

	var isSupplyCapital = false; // 是否为补充资产
	var isAmountRight = false; // 募集金额是否在资产包金额范围内

	var descriptionEditEditor = UE.getEditor('editor-edit-description');
	var moneyPurposeEditEditor = UE.getEditor('editor-edit-moneyPurpose');
	var insuranceEditEditor = UE.getEditor('editor-edit-insurance');
	var interestCalculateEditEditor = UE.getEditor('editor-edit-interestCalculate');
	var redeemEditEditor = UE.getEditor('editor-edit-redeem');

	$(function () {

		dataDialogForm = $("#dataDialogForm").form();
		//产品模板下拉选择框
		$("#prodTmpCombobox").combobox({
			url: '${ctx}/zcProd/getProTmpList',
			onChange: function (newValue, oldValue) {
				if (operaType == "add") {
					var response = eval("(" + ajaxSync("${ctx}/zcProdTmp/getById", {'id': newValue}) + ")"); // 实时查询该模板的信息（基础信息及12个期数利率）
					loadData2Form(response);
					changePeriods(response.periods)

				}
			}
		});

		//资产包下拉选择框
		assetIdsUrl = getAssetIdsUrl();
		assetIdsCombobox = $('#assetIdsCombobox').combobox({
			url: assetIdsUrl,
			valueField: 'id',
			textField: 'assetName',
			mode: 'remote',
			formatter: function (row) {
				var opts = $(this).combobox('options');
				return row[opts.textField];
			}
		});

		// 时间单位类型选择框
		timeUnitCodeCombobox = $('#timeUnitCodeCombobox').combobox({
			url: "${ctx}/zcProd/getTimeUnitTypeList",
			valueField: 'code',
			textField: 'name',
			mode: 'remote',
			formatter: function (row) {
				var opts = $(this).combobox('options');
				return row[opts.textField];
			}
		});

		// 补充资金(1.2秒后加载数据，因为编辑器需要先初始化)
		setTimeout(function () {
			if (!!settleBatchId && !!tmpId && !!settleDate && !!planAddAmount) {
				isSupplyCapital = true;
				var response = eval("({'tmpId': " + tmpId + "})"); // 实时查询该模板的信息（基础信息及12个期数利率）
				loadData2Form(response);
			} else {
				if (operaType == "add") {
					isSupplyCapital = false;
				} else if (operaType == "edit") {
					// 编辑时查询产品类型：补充资金或普通
					getProductType();
				}
			}
		}, 1200);

		showOrHideButton(); // 控制按钮

	});

	//按钮显示、隐藏控制
	function showOrHideButton() {
		if (typeof(operaType) == "undefined" || operaType == "") {
			operaType = "add";
		}
		switch (operaType) {
			case 'add' : {
				$("#tmpTr").show();
				$("#tmpTrTitle").show();
				$("#addProdButton").show();
				dialogUrl = "${ctx}/zcProd/create";
				dialogMsg = "确定要增加产品批次信息？";
				return;
			}
			case 'edit' : {
				$("#editProdButton").show();
				$("#refreshProdButton").show();
				//刷新资产列表按钮
				$("#refreshAssetsButton").show();
				dialogUrl = "${ctx}/zcProd/update";
				dialogMsg = "确定要修改产品批次信息？";
				setTimeout("loadAndShowData(" + pid + ")", 500); // 必须等UEidtor初始化完成后再加载数据，否则出错
				return;
			}
			case 'view' : {
				$("#refreshProdButton").show();
				setTimeout("loadAndShowData(" + pid + ")", 500); // 必须等UEidtor初始化完成后再加载数据，否则出错
				return;
			}
		}
	}

	//获取资产URL
	function getAssetIdsUrl() {
		if (typeof(operaType) == "undefined" || operaType == "") {
			operaType = "add";
		}
		switch (operaType) {
			case 'add' : {
				return "${ctx}/zcProd/getUnusedAndNullStartTimeAssetList";
			}
			case 'edit' : {
				return "${ctx}/zcProd/getAssetListForEdit?pid=" + pid;
			}
			case 'view' : {
				return "${ctx}/zcProd/getAssetListByPid?pid=" + pid;
			}
		}
	}
	//刷新资产列表
	function refreshAssets() {
		var assetUrl = "${ctx}/zcProd/getUnusedAndNullStartTimeAssetList";
		$('#assetIdsCombobox').combobox({
			url: assetUrl,
			valueField: 'id',
			textField: 'assetName',
			mode: 'remote'
		});
	}

	//刷新页面
	function refreshPage() {
		loadAndShowData(pid);
	}

	// 实时查询数据并填充form以便显示
	function loadAndShowData(id) {
		dataDialogForm.form('clear'); // 先清空，再加载新数据
		var response = eval("(" + ajaxSync("${ctx}/zcProd/showDetail", {'id': id}) + ")"); // 实时查询数据
		loadData2Form(response);
		changePeriods(response.periods);//
		$("#prodId").val(id); // 不能删除
		$("#pname").focus();

		editInitData(response);
		showSaleChannel(response);
	}
	//编辑时初始化信息
	function editInitData(response){
		if (operaType != "edit" || (response.status !="3" && response.status !="4" && response.status != "5")) {
			return;
		}
		if(response.status !="3"){
			$("#ptype").attr("disabled", "disabled");
			$("#basicInfo input").each(function(){
				if($(this).attr("autocomplete")!="off" && $(this).attr("type")!="hidden"){
					$(this).css("background-color","#B6B6B4"); // 背景色为灰，不能编辑
					$(this).removeAttr("class");
					$(this).attr("readonly","readonly"); // 不能修改
				}
			});
		}
		if(response.status =="4" || response.status =="5"){

			if (response.status == "4") {//修改预发布产品信息
				$("#publishTimeTr").attr("style","display:display");//预发布时间可见
				$("#publishTimeStr").removeAttr("readonly"); // 可以修改
			}
			if (response.status == "5") {//修改募集中产品信息
				//选择资产
				$("#refreshAssetsButton").hide()
				$("#assetTr .textbox-addon").attr("style","display:none");
				$("#assetTr input").each(function(){
					$(this).unbind("click");
					$(this).attr("readonly","readonly"); // 不能修改
					$(this).css("background-color","#B6B6B4"); // 背景色为灰，不能编辑
				});
				//时间单位类型

				$("#timeUnitCodeTr .textbox-addon").attr("style","display:none");
				$("#timeUnitCodeTr input").each(function(){
					$(this).unbind("click");
					$(this).attr("readonly","readonly"); // 不能修改
					$(this).css("background-color","#B6B6B4"); // 背景色为灰，不能编辑
				});
				//募集开始时间
				$("#raiseStartTimeTr .textbox-addon").attr("style","display:none");
				$("#raiseStartTimeTr input").each(function(){
					$(this).unbind("click");
					$(this).attr("readonly","readonly"); // 不能修改
					$(this).css("background-color","#B6B6B4"); // 背景色为灰，不能编辑
				});
				//起息日
				$("#calculInterestDateTr .textbox-addon").attr("style","display:none");
				$("#calculInterestDateTr input").each(function(){
					$(this).unbind("click");
					$(this).attr("readonly","readonly"); // 不能修改
					$(this).css("background-color","#B6B6B4"); // 背景色为灰，不能编辑
				});
			}
			$("#activityTag").removeAttr("readonly");
			$("#activityTag").css("background-color","#FFFFFF");
			$("#subsidy").removeAttr("readonly");
			$("#subsidy").css("background-color","#FFFFFF");

		}
	}
	//富文本、期数利率数据装载
	function loadData2Form(response) {
		if (typeof(response) != "undefined") {
			// 补充资金
			if (isSupplyCapital) {
				if (operaType == "add") {
					response.settleBatchId = settleBatchId;
					response.tmpId = tmpId;
					response.amountYuan = planAddAmount / 100;
					//response.amountYuan = 100;
					response.raiseEndTimeStr = formatDateTimebox(parseInt(settleDate) - 1000);
				} else {
					response.tmpId = response.tmpId;
					response.amountYuan = response.amountYuan;
					response.raiseEndTimeStr = response.raiseEndTimeStr;
				}
				$("#assetTr").hide();
				$("#prodTmpCombobox").combobox("readonly");
			}

			if (operaType == 'edit' || operaType == 'view') {
				var assetJson = response.assetList;
			var assetIdArray = [];
			for (var i = 0; i < assetJson.length; i++) {
				assetIdArray.push(assetJson[i].id);
			}
			response.assetIdsCombobox = assetIdArray;
		}

		dataDialogForm.form('load', response);
		if (response.description != null && typeof(response.description) != 'undefined') {
			descriptionEditEditor.setContent(response.description, false);
		}
		if (response.moneyPurpose != null && typeof(response.moneyPurpose) != 'undefined') {
			moneyPurposeEditEditor.setContent(response.moneyPurpose, false);
		}
		if (response.insurance != null && typeof(response.insurance) != 'undefined') {
			insuranceEditEditor.setContent(response.insurance, false);
		}
		if (response.interestCalculate != null && typeof(response.interestCalculate) != 'undefined') {
			interestCalculateEditEditor.setContent(response.interestCalculate, false);
		}
		if (response.redeem != null && typeof(response.redeem) != 'undefined') {
			redeemEditEditor.setContent(response.redeem, false);
		}
		if (typeof(response.rateList) != "undefined" && response.rateList.length > 0) {
			for (var i in response.rateList) {
				var rateJson = response.rateList[i];
				$("input[name='rateList[" + i + "].annualRate']").val(rateJson.annualRateStr);
			}
		}
		for (var i = 0; i < 12; i++) {
			$("input[name='rateList[" + i + "].period']").val(parseInt(parseInt(i) + 1));
		}

		}
	}


	// 提交数据
	function submitUpdateProd() {
		var data = dataDialogForm.serializeObject();
		if($("#status").val()=="5"){
			if (data.raiseEndTimeStr >= data.calculInterestDateStr) {
				$.messager.alert('错误提示', '起息日期必须大于募集结束日期！');
				return;
			}
		}else{
			var validateResult = dataDialogForm.form('validate');
			if (!validateResult) {
				$.messager.alert('错误提示', '请正确输入！');
				return;
			}

			var todayStr = formatDateTimebox(new Date());
			if (data.raiseStartTimeStr < todayStr) {
				$.messager.alert('错误提示', '募集开始日期不能小于当前时间！');
				return;
			}
			if (data.raiseEndTimeStr < todayStr) {
				$.messager.alert('错误提示', '募集结束日期不能小于当前时间！');
				return;
			}
			if (data.tmpId == 0){
				$.messager.alert('错误提示', '请选择产品模板！');
				return;
			}
			if (data.raiseStartTimeStr >= data.raiseEndTimeStr) {
				$.messager.alert('错误提示', '募集结束日期必须大于募集开始日期！');
				return;
			}
			if (data.raiseEndTimeStr >= data.calculInterestDateStr) {
				$.messager.alert('错误提示', '起息日期必须大于募集结束日期！');
				return;
			}

			if($("#status").val()=="4"){
				if (data.publishTimeStr < todayStr) {
					$.messager.alert('错误提示', '发布时间不能小于当前时间！');
					return;
				}
				if (data.publishTimeStr > data.raiseStartTimeStr) {
					$.messager.alert('错误提示', '发布时间必须小于募集开始日期！');
					return;
				}
			}
		}
		data.id = $("#prodId").val();
		// 获取富文本框数据
		data.description = descriptionEditEditor.getContent();
		data.moneyPurpose = moneyPurposeEditEditor.getContent();
		data.insurance = insuranceEditEditor.getContent();
		data.interestCalculate = interestCalculateEditEditor.getContent();
		data.redeem = redeemEditEditor.getContent();
		var assetIdsJSON = assetIdsCombobox.combobox("getValues");
		var assetIdsStr = jsonArray2String(assetIdsJSON);
		data.assetIdsStr = assetIdsStr;
		
		//购买渠道
		var saleChannel="";  
	    $("input[name=saleChannel]:checkbox:checked").each(function() {  
	        saleChannel += $(this).val()+",";  
	    }); 
	       
	    if(saleChannel.length>0){
	       	data.saleChannel=saleChannel;
	    }else{
	       	data.saleChannel="04";
	    }
	    
		console.log("isSupplyCapital:" + isSupplyCapital);
		// 补充资金不校验募集金额与期限
		if (isSupplyCapital) {
			extracted(data);
			return;
		}

		// 校验金额与期限
		checkPeriodsAndAmount(data);
		console.log("isAmountRight:" + isAmountRight);
		// 募集金额不大于资产包金额
		if (isAmountRight) {
			extracted(data);
		} else if (!isAmountRight) {
			$.messager.alert('错误提示', '募集金额不得大于资产包金额！');
		}
	}

	/**
	 * 提交表单
	 */
	function extracted(data) {
		$.messager.confirm("请确认", dialogMsg, function(flag) {
			if (flag) {
				showProgress();
				$.ajax({
					url : dialogUrl,
					type : 'POST',
					data : data,
					cache : false,
					dataType : 'json',
					error : function() {
						closeProgress();
						$.messager.alert('提示信息', '操作失败！');
					},
					success : function(response2) {
						closeProgress();
						if (1 == response2.code) {//操作成功
							alertDelay(response2.message);
							if (operaType == "edit" || operaType == "add") {
								setTimeout("parent.closeCurrentTab();", 1500); // 添加、修改产品后关闭当前tab
							} else {
								loadAndShowData(pid);
							}
						} else {
							if (response2 != null && response2 != undefined) {
								$.messager.alert('提示信息', response2.message,
										'info');
							}
						}
					}
				});
			}
		});
	}

	/**
	 * 获取产品类型：普通产品，补充资金
	 */
	function getProductType() {
		$.ajax({
			url : '${ctx}/zcProd/isSupplyCapital',
			type : 'POST',
			data : {
				"id" : pid
			},
			cache : false,
			async : false,
			dataType : 'json',
			error : function() {
			},
			success : function(response2) {
				if (!!response2) {
					isSupplyCapital = response2.isSupplyCapital;
				}
			}
		});
	}

	/**
	 * 检查募集金额是否在资产包金额范围内，产品期限是否大于等于各资产期限
	 * @param data
	 */
	function checkPeriodsAndAmount(formData) {
		$.ajax({
			url : '${ctx}/zcProd/checkPeriodsAndAmount',
			type : 'POST',
			data : formData,
			cache : false,
			async : false,
			dataType : 'json',
			error : function() {
			},
			success : function(response2) {
				if (!!response2) {
					isAmountRight = response2.isAmountRight;
				}
			}
		});
	}
	//改变期数触发事件函数
	function changePeriods(periods) {
		if (periods) {
			var index = parseInt(periods);
			for (var i = 0; i < 12; i++) {
				var annualRateId = "annualRate" + i;
				if (i < index) {
					$("#" + annualRateId).validatebox("reduce"); // 恢复验证
					$("#" + annualRateId).removeAttr("readonly");
					$("#" + annualRateId).css("background-color", ""); // 去掉背景色
				} else {
					$("#" + annualRateId).val("");
					$("#" + annualRateId).validatebox("remove"); // 去掉验证
					$("#" + annualRateId).attr("readonly", "readonly"); // 不能修改
					$("#" + annualRateId).css("background-color", "#B6B6B4"); // 背景色为灰，不能编辑
				}
			}
		}
	}

	function showSaleChannel(response) {
		$("input[name='saleChannel']").each(function() {
			var value = $(this).val();
			var saleChannel = response.saleChannel;

			if (saleChannel.indexOf(value) >= 0) {
				$(this).prop("checked", "checked");
			}
		});
	}
</script>

</body>
</html>
