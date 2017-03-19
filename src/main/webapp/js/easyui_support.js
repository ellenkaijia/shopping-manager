String.prototype.replaceAll = function(s1,s2){ 
return this.replace(new RegExp(s1,"gm"),s2); 
}
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, //month 
		"d+" : this.getDate(), //day 
		"h+" : this.getHours(), //hour 
		"m+" : this.getMinutes(), //minute 
		"s+" : this.getSeconds(), //second 
		"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter 
		"S" : this.getMilliseconds()
	//millisecond 
	};
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};
/**
 * datagrid日期格式化
 */
function formatDateTimebox(value) {
	if (value == null || value == '') {
		return '';
	}
	var dt;
	if (value instanceof Date) {
		dt = value;
	} else {
		dt = new Date(value);
		if (isNaN(dt)) {
			value = value.replace(/\/Date\((-?\d+)\)\//, '$1'); //标红的这段是关键代码，将那个长字符串的日期值转换成正常的JS日期格式
			dt = new Date();
			dt.setTime(value);
		}
	}

	return dt.format("yyyy-MM-dd hh:mm:ss"); //这里用到一个javascript的Date类型的拓展方法，这个是自己添加的拓展方法，在后面的步骤3定义
}
function formatNumber(value,precision){
	if(value==null || value=="" || precision==null || precision=="" || precision<=0){
		return "";
	}
	return value.toFixed(precision);//格式化,保留两位小数
}
/**
 * datagrid日期格式化(只有日期)
 */
function formatDatebox(value) {
	if (value == null || value == '') {
		return '';
	}
	var dt;
	if (value instanceof Date) {
		dt = value;
	} else {
		dt = new Date(value);
		if (isNaN(dt)) {
			value = value.replace(/\/Date\((-?\d+)\)\//, '$1'); //标红的这段是关键代码，将那个长字符串的日期值转换成正常的JS日期格式
			dt = new Date();
			dt.setTime(value);
		}
	}

	return dt.format("yyyy-MM-dd"); //这里用到一个javascript的Date类型的拓展方法，这个是自己添加的拓展方法，在后面的步骤3定义
}
/**
把数组字符串变成数组
*/
function getList(value) 
{
	//number转string
	value = String(value);
	if (value != undefined && value != '') 
	{
		var values = [];
		var t = value.split(',');
		for ( var i = 0; i < t.length; i++) 
		{
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} 
	else 
	{
		return [];
	}
}
function jsonArray2String(jsonArray){
	var str = "";
	if(typeof(jsonArray)!='undefined' && jsonArray!=null && jsonArray.length>0 ){
		for(var i=0;i<jsonArray.length;i++){
			str += String(jsonArray[i]) + ",";
		}
		str = str.substring(0, str.length-1);
	}
	return str;
}
/** 
 *  
 * 扩展validatebox
 */  
$.extend($.fn.validatebox.defaults.rules, {  
	isDecimal: {
        validator: function (value, param) {
            return /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(value);
        },
        message: '请输入小数'
    },
    isDecimalOne: {
        validator: function (value, param) {
            return /^\d+(\.\d{1})?$/.test(value);
        },
        message: '请输入数字,并且小数点后面最多只能保留一位'
    },
    isDecimalTwo: {
        validator: function (value, param) {
            return /^\d+(\.\d{1,2})?$/.test(value);
        },
        message: '请输入数字,并且小数点后面最多只能保留两位'
    },
    isNumber: {
        validator: function (value, param) {
            return /^\d+$/.test(value);
        },
        message: '请输入整数'
    },
    positiveInteger: {
        validator: function (value, param) {
            return /^\+?[1-9][0-9]*$/.test(value);
        },
        message: '请输入大于0的整数'
    },
    eqPassword : {  
        validator : function(value, param) {  
            return value == $(param[0]).val();  
        },  
        message : '密码不一致！'  
    },
    notEqual : {  
        validator : function(value, param) {  
        	if(value!=undefined && value!="" && $(param[0])!=undefined && $(param[0]).val()!=""){
        		return value.toUpperCase() != $(param[0]).val().toUpperCase();
        	}
       		return true;
        },  
        message : '前后值不能相同！'  
    },
    lessThan : {  
        validator : function(value, param) {  
            return parseFloat(value) < parseFloat( $(""+param[0]).val() );  
        },  
        message : '必须小于前一个值'  
    },
    anotherNotNull : {  
        validator : function(value, param)
        {  
            if(value == null && $(param[0]).val() == null)
            {
            	return false;
            }
            else
            {
            	return true;
            }
        },  
        message : '其中一个不能为空！'  
    },
    mobile: {
        validator: function (value, param) {
            return /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(value);
        },
        message: '手机号码格式不正确'
    },
    email: {
        validator: function (value, param) {
            return /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value);
        },
        message: '邮箱格式不正确'
    },
    accountName: {
        validator: function (value, param) {
            return (/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(value) || 
            	    /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value) )
            	    && value!="" && value.length>=6;
        },
        message: '账号格式不正确'
    },
    operaScore: {
        validator: function (value, param) {
        	return /^\d+$/.test(value) && parseInt(value)>=1 && parseInt(value)<=10;
        },
        message: '请输入1~10之间的整数（含1和10）'
    },
    max:{
    	validator:function(value,param){
        	return value <= param[0];
        },
        message:'输入的数字必须小于等于{0}'
    },
    min:{
    	validator:function(value,param){
        	return value >= param[0];
        },
        message:'输入的数字必须大于等于{0}'
    },
    range:{
        validator:function(value,param){
        	return value >= param[0] && value <= param[1];
        },
        message:'输入的数字在{0}到{1}之间'
    },
    length:{
        validator:function(value,param){
        	return value.length >= param[0] && value.length <= param[1];
        },
        message:'长度在{0}到{1}之间'
    },
    maxLength:{
    	validator:function(value,param){
        	return value.length < param[0];
        },
        message:'长度不能超过{0}'
    },
    byteLength:{
    	validator:function(value,param){
    		var Zhlength=0;// 全角
    		var Enlength=0;// 半角
    		for(var i=0;i<value.length;i++){
    	         if(value.substring(i, i + 1).match(/[^\x00-\xff]/ig) != null)
    	         Zhlength+=1;
    	         else
    	         Enlength+=1;
    	     }
    	     // 返回当前字符串字节长度
    		var len = (Zhlength*3)+Enlength;
    	     return len >param[0] && len<=param[1];
    	},
    	message:'字节长度区间为({0},{1}]'
    },
    userName:{
    	validator:function(value,param){
    		var Zhlength=0;// 全角
    		var Enlength=0;// 半角
    		for(var i=0;i<value.length;i++){
    	         if(value.substring(i, i + 1).match(/[^\x00-\xff]/ig) != null)
    	         Zhlength+=1;
    	         else
    	         Enlength+=1;
    	     }
    	     // 返回当前字符串字节长度
    		var len = (Zhlength*2)+Enlength;
    	     return len >param[0] && len<=param[1];
    	},
    	message:'字节长度区间为({0},{1}]'
    },
    numAndLetter:{
    	validator:function(value,param){
    		var regex = /^[0-9A-Za-z]+$/g;
    		if(regex.test(value)){
    			return true;
    		}
    	    return false;
    	},
    	message:'只能输入数字和字母'
    },
    excel:{
    	validator:function(value,param){
    	    if(!value.endsWith('xls') && !value.endWith('xlsx')){
    	    	return false;
    	    }
    	    return true;
    	},
    	message:'请选择excel文件'
    }
});

/**
 * 显示等待条
 */
function showProgress()
{
   $.messager.progress
    (   
        {
			text : '数据加载中....',
			interval : 100
		}
	);
}
/**
 * 关闭等待条
 */
function closeProgress()
{
    $.messager.progress('close');
}
/**
清空查询条件
*/
function cleanQueryCondition()
{
    queryConditionForm.find('input,textarea,select').val('');
}
/**
清空查询条件
*/
function cleanQueryCondition(myFormCondition)
{
	$("#myFormCondition").find('input,textarea,select').val('');
}
/**
 * 一般处理response
 */
function doCommonResponse(response)
{
	$.messager.alert('提示信息', response.message,'info');
}
/**
 * datagrid处理response
 */
function doResponse(response){
	if(1 == response.code){//操作成功
     	alertDelay(response.message);
     	datagrid.datagrid('reload');dataDialog.dialog('close');
 	}
	else{
		$.messager.alert('提示信息',response.message,'info');
	}
}

/**
 * datagrid处理response
 */
function doResponse2(response2, dataGridId ,dataDialog2)
{
	if(1 == response2.code){//操作成功
		alertDelay(response2.message);
		if(dataGridId!=null && dataGridId!=undefined){
 			$("#"+dataGridId).datagrid('reload');
 		}
 		if(dataDialog2!=null && dataDialog2!=undefined){
 			dataDialog2.dialog('close');
 		}
 	}
	else{
		if(response2!=null && response2!=undefined){
			$.messager.alert('提示信息',response2.message,'info');
		}
	}
}

/**
 * 日期格式化
 * @param date
 */
formatterDate = function(date) {
	
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	return date.getFullYear() + '-' + month + '-' + day;
};

/**
 * treegrid处理response
 */
function doResponseOfTreegrid(response)
{
	if(1 == response.code){//操作成功
		alertDelay(response.message);
		treegrid.treegrid('reload');dataDialog.dialog('close');
 	}
	else
	{
		$.messager.alert('提示信息',response.message,'info');
	}
}
/**
 * 加载枚举
 * @param name      枚举名称
 * @param enumName  要赋值的js对象名称
 */
function loadEnum(name,enumName)
{
	//数据字典url
	var queryEnumByNameUrl = baseUrl + '/dataDictionary/queryEnumByName';
	$.ajax
    (
       {
          url : queryEnumByNameUrl + '?enumName=' + name,
          type: 'POST',
          async:true,
		  data : '',
		  cache : false,
		  error: function()
		         {
		         },
		  success : function(response) 
		            {
			           
			           var data = response;
			           //动态赋值
			           eval(enumName + '=' + data);
			        }
       
       }
    );
}
/**
 * datagrid格式化数据字典的列
 * @param value    
 * @param enumObj    枚举
 * @returns {String}
 */
function formatEnum(value,enumObj)
{
	var result = "";
	if(enumObj)
	{
		for(var i=0;i<enumObj.length;i++)
		{
			if(value == enumObj[i].attributeValue)
			{
				result =  enumObj[i].attributeValueMeaning;
				break;
			}
		}
	}
	return result;
}

/**
 * 根据一个或多个枚举名称，加载一个或多个枚举（数组）
 * @param queryEnumsUrl    url
 * @param enumNames        枚举名称，多个用逗号隔开，例如：'accountStatus,transType'
 * @param onLoadSuccessFn  加载成功回调
 */
function loadEnumsByNames(queryEnumsUrl,enumNames,onLoadSuccessFn)
{
	var data = {'enumNames':enumNames};
	$.ajax
    (
       {
          url : queryEnumsUrl,
          type: 'POST',
		  data : data,
		  cache : false,
		  dataType: 'json',
		  error: function()
		         {
		         },
		  success : function(data) 
		            {
			           onLoadSuccessFn(data);
			        }
       }
    );
}
//延迟tm秒后自动关闭提示框，用于成功时的弹出框自动关闭
function alertDelay(msg, tm){  
    var interval;  
    var time=1000;  
    var x;  
    if(null==tm||''==tm){  
        x=Number(2);  
    }else{  
        x=Number(tm);  
    }  
    $.messager.alert('系统提示','<div class="messager-icon messager-info"></div><div>'+msg+'</div>',"",function(){});   
    $(".messager-window .window-header .panel-title").append("（"+x+"秒后自动关闭）");  
    interval=setInterval(fun,time);  
    function fun(){  
        --x;  
        if(x==0){  
          clearInterval(interval);  
          $(".messager-body").window('close');    
        }  
        $(".messager-window .window-header .panel-title").text("");  
        $(".messager-window .window-header .panel-title").append("系统提示（"+x+"秒后自动关闭）");  
    }  
}  

// 扩展easyui，动态添加、删除验证
$.extend($.fn.validatebox.methods, {    
    remove: function(jq, newposition){    
        return jq.each(function(){    
            $(this).removeClass("validatebox-text validatebox-invalid").unbind('focus').unbind('blur');  
        });    
    },  
    reduce: function(jq, newposition){    
        return jq.each(function(){    
           var opt = $(this).data().validatebox.options;  
           $(this).addClass("validatebox-text").validatebox(opt);  
        });    
    }     
});
