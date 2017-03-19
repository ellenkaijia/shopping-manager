function clearAndReloadCombobox(comboboxId){
	if(comboboxId){
		$('#' + comboboxId).combobox('clear');
		$('#' + comboboxId).combobox('reload');
	}
}
// 如果金额为空或小于等于0则输出/，否则格式化金额
function showSlashWhenEmpty(value){
	if(typeof(value)=="undefined" || value=="" || value<=0 ){
		return "/";
	}
	return formatMoneyFen(value);
}

// 数据导出为CSV文件，数据为字符串格式如：var CSV_STRING = "'col1','col2','col3'\n'1','2','3'\n'4','5','6'";
function exportCsv(csvDatas , fileName){
	if(typeof(csvDatas)!="string" || csvDatas==null || csvDatas=="" || csvDatas.length<1){
		$.messager.alert("数据为空，无法导出");
		return;
	}
	if(typeof(fileName)=="undefined" || fileName==null || fileName==""){
		fileName = "导出数据.csv";
	}
	if(fileName.indexOf(".csv")<0){
		fileName += ".csv";
	}
	if (typeof msie !== "undefined" && msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)){
		// IE浏览器
		csvDatas = "\ufeff" + csvDatas; // 告诉excel以utf8编码打开文件
        if (typeof Blob !== "undefined") {
            var blob1 = new Blob([csvDatas], { type: "text/csv" });
            window.navigator.msSaveBlob(blob1, fileName );
        } else {
            txtArea1.document.open("text/csv", "replace");
            txtArea1.document.write(csvDatas);
            txtArea1.document.close();
            txtArea1.focus();
            sa = txtArea1.document.execCommand("SaveAs", true, fileName );
        }

    } else {
    	var a = document.createElement("a");
        a.download = fileName; // 下载文件名
        a.href = "data:text/csv;charset=utf-8,\ufeff" + encodeURIComponent(csvDatas);// 告诉excel以utf8编码打开文件
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }
}

//将html字符串转换为一般文本显示，不换行，没有样式，只显示原始text
function html2Text(htmlStr){
	if(typeof(htmlStr)=="undefined" || typeof(htmlStr)!="string" || htmlStr==null || htmlStr==""){
		return;
	}
	var REGX_HTML_ENCODE = /"|&|‘|<|>|[\x00-\x20]|[\x7F-\xFF]|[\u0100-\u2700]/g;
	return htmlStr.replace(REGX_HTML_ENCODE,
                     function ($0) {
                         var c = $0.charCodeAt(0), r = ["&#"];
                     	 c = (c == 0x20) ? 0xA0 : c;
                     	 r.push(c);
                     	 r.push(";");
                     	 return r.join("");
    				 }
	);
}
function setCookie(name, value, days) {
	var Days = 7;
	if(typeof(days)!="undefined" && days>0){
		Days = days;
	}
	var exp = new Date();
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}
function getCookie(name) {
	var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
	if (arr = document.cookie.match(reg)){
		return unescape(arr[2]);
	}
	else{
		return "";
	}
}
function deleteCookie(name) {
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	var cval = getCookie(name);
	if (cval != null){
		document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
	}
}
function resPreView(tmpUrl , resType){
    if(tmpUrl==null || tmpUrl=="" || tmpUrl==undefined){
        return "";
    }
    if(resType==null || resType==undefined || resType==""){
        return "<a href='${cdnDns}"+tmpUrl+"' target='_blank'><img style='height:40px;' alt="+tmpUrl+" title="+tmpUrl+" src='${cdnDns}"+tmpUrl+"'></a>";
    }
    else{
        if(resType==2){//视频、音乐类
            return "<a href='${cdnDns}"+tmpUrl+"' target='_blank'><video style='height:80px;' src='${cdnDns}"+tmpUrl+"' controls='controls'>您的浏览器不支持video标签</video></a>";
        }
        else if(resType==6){//视频、音乐类
            return "<a href='${cdnDns}"+tmpUrl+"' target='_blank'><audio style='height:80px;' src='${cdnDns}"+tmpUrl+"' controls='controls'>您的浏览器不支持video标签</audio></a>";
        }
        else{//图片类
        	return "<a href='${cdnDns}"+tmpUrl+"' target='_blank'><img style='height:40px;' alt="+tmpUrl+" title="+tmpUrl+" src='${cdnDns}"+tmpUrl+"'></a>";
        }
    }
}

// ajax同步请求方法，同步获取数据
function ajaxSync(ajaxUrl, ajaxParam){
	if ( typeof(ajaxUrl)!="undefined" && typeof(ajaxUrl)=="string" && ajaxUrl!="" ) {
		return $.ajax({
	        url : ajaxUrl,
	        type: 'POST',
	        data : ajaxParam,
	        cache : false,
	        dataType: 'json',
	        async: false
	    }).responseText;
	}
	return "";
}

// 格式化金额，s金额元，n精度（一般保留2位小数）
function formatMoney(money, length){
    if (typeof(money)=="undefined" || money==null || money==""){
        return "0.00";
    }
    if ( typeof(money)=='string' && money.indexOf(',')>=0 ){
        var reg = new RegExp(',', 'gm'); 
        money = money.replace(reg, "");
    }
    if (typeof(length)=="undefined" || length==null || length==""){
        length = 2;
    }
    length = length > 0 && length <= 20 ? length : 2;
    money = parseFloat((money + "").replace(/[^\d\.-]/g, "")).toFixed(length) + "";
    var l = money.split(".")[0].split("").reverse(),
            r = money.split(".")[1];
    t = "";
    for(i = 0; i < l.length; i ++ )
    {
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
    }
    return t.split("").reverse().join("") + "." + r;
}
function formatMoneyFen(moneyFen, length){
	if(typeof(moneyFen)=="undefined" || moneyFen==null || moneyFen==""){
		moneyFen = 0;
	}
	return formatMoney(parseInt(moneyFen)/100, length);
}
// 处理dataGrid，区分两种错误：1-找不到数据，2-后台报错
function globalDatagridFilter(globalDataGrid){
	if( typeof(globalDataGrid)!="undefined" && typeof(globalDataGrid.ifException)!="undefined" ){
		if(globalDataGrid.ifException==true){
			alertDelay("<span style='font-weight:bold;font-size:13px;color:red;' >后台报错:"+globalDataGrid.msg.substring(0,1200)+"</span>" , 5); // 2.后台异常情况
		}
		else if(typeof(globalDataGrid.total)!="undefined" && globalDataGrid.total<1 && 
				typeof(globalDataGrid.rows)!="undefined" && globalDataGrid.rows.length<1 ){
			alertDelay("<span style='font-weight:bold;font-size:15px;color:blue;' >找不到数据<br/>请更改查询条件</span>"); // 1.找不到数据情况
	    }
	}
	return globalDataGrid;
}
function convert(rows){
	if(typeof(rows)=='undefined' || rows==null && rows=="" || rows.length<1){
		return;
	}
	var topNodes = [];
	// get the top level nodes
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		if (!hasParent(row.resParentId)){
			topNodes.push({
				id : row.resId,
				resId : row.resId,
				resName : row.resName,
				resParentId : row.resParentId,
				resType : row.resType,
				resIcon : row.resIcon,
				resUrl : row.resUrl,
				resSeq : row.resSeq,
				resStatus : row.resStatus,
				text : row.resName,
				iconCls : row.resIcon,
				attributes : row.attributes
			});
		}
	}
	
	var toDo = [];
	for(var i=0; i<topNodes.length; i++){
		toDo.push(topNodes[i]);
	}
	while(toDo.length){
		var node = toDo.shift();//取出首个元素并在数组中删除
		// get the children nodes
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (row.resParentId == node.resId){
				var child = {
						id : row.resId,
						resId : row.resId,
						resName : row.resName,
						resParentId : row.resParentId,
						resType : row.resType,
						resIcon : row.resIcon,
						resUrl : row.resUrl,
						resSeq : row.resSeq,
						resStatus : row.resStatus,
						text : row.resName,
						iconCls : row.resIcon,
						attributes : row.attributes
				};
				if (node.children){
					node.children.push(child);
				} 
				else {
					node.children = [child];
				}
				toDo.push(child);
			}
		}
	}
	return topNodes;
}

//是否有父级元素？true有，false否
function hasParent(parentId){
	if(typeof(parentId)=='undefined' || parentId==null || parentId=="" || parentId<1){
		return false;
	}
	else{
		return true;
	}
}

//给指定的form中的所有input绑定回车事件，用于查询条件的form
function bandCtrl(formId){
	var isFocus = false; // 是否已经定位了光标
	if(formId!=undefined && formId!=null && formId!=""){
		$("#"+formId).find('input').each(function(){
			// 只有此form中的可见输入框才能定位光标（hidden、select、checkbox、radio均不能）
			if(!isFocus && $(this).val()=="" && $(this).css("display")!="none" && !$(this).prop("readonly")){
				$(this).focus();
				isFocus = true;
			}
			$(this).bind('keyup', function(event){
				   if (event.keyCode=="13"){
					   query();
				   }
			});
		});
	}
}

function globalFilter(data){
	if(typeof(data)=="undefined" || typeof(data.total)=="undefined" || data.total<=0){
		$.messager.alert("提示信息","找不到数据");
		data = {'total':0,'rows':[]};
	}
	return data;
}

function clearForm(formId){
	if(formId==undefined || formId==null){
		return;
	}
	$("#"+formId).form('clear');
}
function fileSize(fileId) {  
	var f = document.getElementById(""+fileId); 
	if(typeof(f)!='undefined' && typeof(f.files)!='undefined' && f.files.length>0){
		return f.files[0].size/1024/1024;//返回文件大小m
	}
    return 0;
} 
function clearInputFile(fileId){
	var file = $("#"+fileId);
	file.after(file.clone().val(""));
	file.remove();
}
function clearAllInputFile(){
	var files = $('input[type="file"]');
	if(typeof(files)=='undefined' || files.length<1){
		files = $('input[class="easyui-filebox"]');
	}
	var fileIds = [];
	if(typeof(files)!='undefined' && files.length>0){
		for(var i=0;i<files.length;i++){
			fileIds.push(files[i].id);
		}
		for(var i=0;i<fileIds.length;i++){
			clearInputFile(fileIds[i]);
		}
	}
}
function commonSubmit(comfirmMsg,submitUrl,submitData,datagridId,submitDialog){
	$.messager.confirm("请确认" , comfirmMsg , function(flag){
		if(flag){
			showProgress();
			$.ajax({
				url : submitUrl,
				type : 'POST',
				data : submitData,
				cache : false,
				dataType : 'json',
				error : function() {
					closeProgress();
					$.messager.alert('提示信息', '操作失败！');
				},
				success : function(response) {
					closeProgress();
					doResponse2(response , datagridId , submitDialog);
				}
			});
		}
	});
}
function commonFileSubmit(comfirmMsg , submitUrl , submitData , fileElementIds , datagridId , submitDialog){
	$.messager.confirm("请确认" , comfirmMsg , function(flag){
		if(flag){
			showProgress();
			$.ajaxFileUpload({
	    		url : submitUrl,
	    	   	type: 'POST',
	    	   	secureuri : false,
	    	   	fileElementIds : fileElementIds, //用英文逗号隔开
	    	   	dataType : 'json',
	    	   	responseType: 'json',
	    	   	data : submitData,
	    	   	error: function(e){
	    	   		closeProgress();
	    	   		$.messager.alert('提示信息', '操作失败！');
	    	   	},
	    	   	success : function(response){
	    	   		closeProgress();
					doResponse2(response , datagridId , submitDialog);
	    	    }
	    	})
		}
	});
}

function commonFileSubmitTree(comfirmMsg , submitUrl , submitData , fileElementIds , treeGridId , submitDialog){
	$.messager.confirm("请确认" , comfirmMsg , function(flag){
		if(flag){
			showProgress();
			$.ajaxFileUpload({
	    		url : submitUrl,
	    	   	type: 'POST',
	    	   	secureuri : false,
	    	   	fileElementIds : fileElementIds, //用英文逗号隔开
	    	   	dataType : 'json',
	    	   	responseType: 'json',
	    	   	data : submitData,
	    	   	error: function(e){
	    	   		closeProgress();
	    	   		$.messager.alert('提示信息', '操作失败！');
	    	   	},
	    	   	success : function(response){
	    	   		closeProgress();
	    	   		if(1 == response.code){
				     	$.messager.alert('提示信息', response.message,'info',function(){
				     		if(treeGridId!=null && treeGridId!=undefined){
				     			$("#"+treeGridId).treegrid('load');
				     		}
				     		if(submitDialog!=null && submitDialog!=undefined){
				     			submitDialog.dialog('close');
				     		}
				     	});
				 	}
					else{
						if(response!=null && response!=undefined){
							$.messager.alert('提示信息',response.message,'info');
						}
					}
	    	    }
	    	})
		}
	});
}

function commonSubmitTree(comfirmMsg,submitUrl,submitData, combotreeId, treeGridId ,submitDialog){
	$.messager.confirm("请确认" , comfirmMsg , function(flag){
		if(flag){
			showProgress();
			$.ajax({
				url : submitUrl,
				type : 'POST',
				data : submitData,
				cache : false,
				dataType : 'json',
				error : function() {
					closeProgress();
					$.messager.alert('提示信息', '操作失败！');
				},
				success : function(response) {
					closeProgress();
					if(1 == response.code){
			     		alertDelay(response.message);
			     		if(treeGridId!=null && treeGridId!=undefined){
			     			$("#"+treeGridId).treegrid('load');
			     		}
			     		if(combotreeId!=null && combotreeId!=undefined){
			     			$("#"+combotreeId).combotree('reload');
			     		}
			     		if(submitDialog!=null && submitDialog!=undefined){
			     			submitDialog.dialog('close');
			     		}
				 	}
					else{
						if(response!=null && response!=undefined){
							$.messager.alert('提示信息',response.message,'info');
						}
					}
				}
			});
		}
	});
}

String.prototype.endWith = function(str) {
	if (str == null || str == "" || this.length == 0 || str.length > this.length)
		return false;
	if (this.substring(this.length - str.length) == str)
		return true;
	else
		return false;
}
String.prototype.startWith = function(str) {
	if (str == null || str == "" || this.length == 0 || str.length > this.length)
		return false;
	if (this.substr(0, str.length) == str)
		return true;
	else
		return false;
}
/**
 * 是否图片
 * 
 * @param value
 * @returns
 */
function isImage(urlValue){
	if(typeof (urlValue) == undefined  || urlValue==null){
		return false;
	}
	var tempUrl = urlValue;
	if(tempUrl!="" && tempUrl.indexOf("?")>=0){
		 tempUrl = tempUrl.substr(0 , tempUrl.indexOf("?"));
	 }
	var urlLowerCase = (tempUrl+"").toLowerCase();
// "png,jpg,jpeg,gif,bmp,tga";
	return urlLowerCase.endWith(".png") || 
		urlLowerCase.endWith(".jpg") || 
		urlLowerCase.endWith(".jpeg") || 
		urlLowerCase.endWith(".gif") ||
		urlLowerCase.endWith(".tga") || 
		urlLowerCase.endWith(".bmp")  ;
}
/**
 * 是否视频
 * 
 * @param urlValue
 * @returns
 */
function isVedio(urlValue){
	if(typeof (urlValue) == undefined  || urlValue==null){
		return false;
	}
	var tempUrl = urlValue;
	if(tempUrl!="" && tempUrl.indexOf("?")>=0){
		 tempUrl = tempUrl.substr(0 , tempUrl.indexOf("?"));
	 }
	var urlLowerCase = (tempUrl+"").toLowerCase();
	return urlLowerCase.endWith(".mp4")  || 
		urlLowerCase.endWith(".rmvb")  || 
		urlLowerCase.endWith(".rm")  || 
		urlLowerCase.endWith(".swf")  || 
		urlLowerCase.endWith(".flv")  || 
		urlLowerCase.endWith(".avi")  || 
		urlLowerCase.endWith(".wma")  || 
		urlLowerCase.endWith(".wav")  || 
		urlLowerCase.endWith(".mid")  || 
		urlLowerCase.endWith(".mpeg")  || 
		urlLowerCase.endWith(".mov")  ;
}

/**
 * 是否音频
 * 
 * @param urlValue
 * @returns
 */
function isAudio(urlValue){
	if(typeof (urlValue) == undefined  || urlValue==null){
		return false;
	}
	var tempUrl = urlValue;
	if(tempUrl!="" && tempUrl.indexOf("?")>=0){
		 tempUrl = tempUrl.substr(0 , tempUrl.indexOf("?"));
	 }
	var urlLowerCase = (tempUrl+"").toLowerCase();
	return urlLowerCase.endWith(".mp3")  || 
		urlLowerCase.endWith(".wav")  || 
		urlLowerCase.endWith(".amr")  || 
		urlLowerCase.endWith(".mid")  || 
		urlLowerCase.endWith(".cda")  || 
		urlLowerCase.endWith(".ogg");
}

/**
 * js获取url参数
 * 
 * @param name
 * @returns
 */
function getQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
}
function writeObj(obj){ 
    var description = ""; 
    for(var i in obj){   
        var property=obj[i];   
        description+=i+" = "+property+"\n";  
    }   
    return description; 
}
/**
 * 序列化表单为json对象
 */

$.fn.serializeObject = function() 
{
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};
/**
 * 合并两个json对象属性为一个对象
 * 
 * @param jsonbject1
 * @param jsonbject2
 * @returns resultJsonObject
 */
$.mergeJsonObject = function(jsonbject1, jsonbject2)
{
	var resultJsonObject = {};
	for ( var attr in jsonbject1) {
		resultJsonObject[attr] = jsonbject1[attr];
	}
	for ( var attr in jsonbject2) {
		resultJsonObject[attr] = jsonbject2[attr];
	}

	return resultJsonObject;
};
/**
 * js URL编码
 * 
 * @param clearString
 * @returns {String}
 */
function UrlEncode(clearString) 
{
  var output = '';
  var x = 0;
  clearString = clearString.toString();
  var regex = /(^[a-zA-Z0-9-_.]*)/;
  while (x < clearString.length) {
    var match = regex.exec(clearString.substr(x));
    if (match != null && match.length > 1 && match[1] != '') {
        output += match[1];
      x += match[1].length;
    } else {
      if (clearString.substr(x, 1) == ' ') {
        // 原文在此用 clearString[x] == ' ' 做判断, 但ie不支持把字符串当作数组来访问,
        // 修改后两种浏览器都可兼容
        output += '+';
      }
      else {
        var charCode = clearString.charCodeAt(x);
        var hexVal = charCode.toString(16);
        output += '%' + ( hexVal.length < 2 ? '0' : '' ) + hexVal.toUpperCase();
      }
      x++;
    }
  }
  return output;
}
/**
 * jquery ajax 请求（异步）
 * 
 * @param opUrl
 * @param data
 * @param successFn
 *            成功函数
 * @param errorFn
 *            失败函数
 */
function jqueryAjax(opUrl,data,successFn,errorFn)
{
	$.ajax
    (
       {
          url : opUrl,
          type: 'POST',
		  data : data,
		  cache : false,
		  dataType: 'json',
		  error: function(response)
		         {
			             if(errorFn)
			             {
			            	 errorFn(response);
			             }
			             
		         },
		  success : function(response) 
		            {
					     if(successFn)
			             {
					    	 successFn(response);
			             }
			        }
       
       }
    );
}

// long型数字除以100转2位小数
function format2Decimal(number){
	if(null == number || number == ''){
		return "0.00";	
	}
	var decimal = parseFloat(number);
	return decimal.toFixed(2);
}

function formatAmountf2y(obj){
	return parseFloat(obj).toFixed(2);
}

// ------------------------------------regex---------------------------------------------
// 验证为空
function  isEmpty(str){
	        if(str==null){
	        	 return true;
	        }
			var regExp=new RegExp("^ *$");
			return regExp.test(str);

}

// 验证为数字
function  checkNumber(str){
			if(isEmpty(str)){
				return false;
			}
			else{
					var regExp=new RegExp("^\\d+$");
					return regExp.test(str);
			}
}

// 验证为小数
function checkND(str){
	if(isEmpty(str)){
		return false;
	}
	else{
			var regExp=new RegExp("(^\\d+$)|(^\\d+\.{1}\\d+$)");
			return regExp.test(str);
	}
	
}

// 验证为小数且验证小数位长度
function checkNDouble(str,len){
			if(isEmpty(str)){
				return false;
			}else{
					var reg="";
					
					if(len!=""&& len!=null){
							reg="^\\d+\.?\\d{"+len+"}$";
					}else{
							reg="^\\d+\.?\\d*$";
					}
					var regExp=new RegExp(reg);
					return regExp.test(str);	
			}
}

// 验证为邮件
function  checkEmail(str){
				if(isEmpty(str)){
					return false;
				}else{
						var reg="\\w+@\\w+\.{1}((com)|(cn)|(com.cn)|(net))$";
						var regExp=new RegExp(reg);
						return regExp.test(str);	
				}

}

// 验证为日期
function checkDate(str){
			if(isEmpty(str)){
					return false;
			}else{	
				var reg="(\\d{4}-\\d{1,2}-\\d{1,2}$)|(\\d{4}/\\d{1,2}/\\d{1,2}$)";
				/*
				 * if(str.indexOf(":")>-1){ reg="(\\d{4}-\\d{1,2}-\\d{1,2}
				 * {1}\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?)|(\\d{4}/\\d{1,2}/\\d{1,2}
				 * {1}\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?)|(\\d{4}-\\d{1,2}-\\d{1,2}
				 * {1}\\d{2}:\\d{2})|(\\d{4}/\\d{1,2}/\\d{1,2}
				 * {1}\\d{2}:\\d{2})"; }
				 */
				var regExp=new RegExp(reg);
				return regExp.test(str);	
			}
}

// 验证为电话号码
function  checkTel(str){
		if(isEmpty(str)){
					return false;
		}else{	
			    var reg="^1[3458]\\d{9}$";
				if(str.indexOf("-")>-1){
						reg="\\d{3,4}-{1}\\d{7,8}$";
				}
				var regExp=new RegExp(reg);
				return regExp.test(str);	
			}
}

// 验证为手机
function checkMobile(str){
	if(isEmpty(str)){
			return false;
	}else{	
		var reg="^1[3458]\\d{9}$";
		var regExp=new RegExp(reg);
		return regExp.test(str);	
	}
		
}

// 检查字符串长度
function checkStrLen(str,len){
		if(isEmpty(str)){
					return false;
		}else{	
				var reg="^\\w{"+len+"}$";
				var regExp=new RegExp(reg);
				return regExp.test(str);	
		}
}

/*
 * 替换指定长度的字符 返回值为-1时表示入参不合法 strObj: 源字符串 startPos: 替换字符开始位置 endPos: 替换字符结束位置
 * replaceChar: 要替换的字符
 */ 
function replacePos(strObj, startPos, endPos, replaceChar)
{
 if(strObj==null || strObj=='' || startPos>strObj.length || endPos>strObj.length || startPos>endPos || replaceChar==null || replaceChar=='')
 {
	   return -1;
 }
 var replaceStr='';
 for(var i=startPos; i<endPos; i++)
 {
	   replaceStr+=replaceChar;
 }
 var str = strObj.substr(0, startPos) + replaceStr + strObj.substring(endPos, strObj.length);
 
 return str;
}

// 格式long型日期
function formatDateByLong(number){
	var currentDate = "";
	var date = new Date(number);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	currentDate = year + "-";
	if(month < 10){
		month = "0" + month;	
	} 
	currentDate += month + "-";
	if(day < 10){
		day = "0" + day;	
	}
	currentDate += day;
	return currentDate;
}

function checkBankCount(str){
	if(isEmpty(str)){
					return false;
	}else{	
				var reg="^\\d{16,19}$";
				var regExp=new RegExp(reg);
				return regExp.test(str);	
	}
}


function checkCard(str){
	if(isEmpty(str)){
					return false;
	}else{	
				var reg="(^\\d{18}$)|(^\\d{17}X$)|(^\\d{15}$)";
				var regExp=new RegExp(reg);
				return regExp.test(str);	
	}
}

function checkPost(str){
	if(isEmpty(str)){
					return false;
	}else{	
				var reg="^\\d{6}$";
				var regExp=new RegExp(reg);
				return regExp.test(str);	
	}
}

function checkCardAndBirthAndAge(card,birth,age){
             if(isEmpty(card)||isEmpty(birth)||isEmpty(age)){
                     return false;
             }
              var cardPartYear=card.substring(6,10);
              var cardPartMonth=card.substring(10,12);
              var cardPartDay=card.substring(12,14);
              
              var birthParts=null;
              if(birth.indexOf(" ")>0){
                  birth=birth.split(" ")[0];
              }
              birthParts=birth.indexOf("-")>0? birth.split("-"):birth.split("/");
              var  birthPartYear=birthParts[0];
              var  birthPartMoth=birthParts[1].length==2? birthParts[1]:"0"+birthParts[1];
              var  birthPartDay=birthParts[2].length==2?  birthParts[2]:"0"+birthParts[2];
              if(cardPartYear!=birthPartYear || cardPartMonth!=birthPartMoth || cardPartDay!=birthPartDay){
                              return false;
              } 
              var currDate=new Date();
              var currYear=currDate.getFullYear();
              var factAge=currYear-cardPartYear;
              if(age!=factAge){
                     if((parseInt(age)+1)!=parseInt(factAge)){
                               return false;
                         
                     }
		                    
		        }
              
              return true;
                

}
// 验证是否为url
function checkUrl(str){
	if(isEmpty(str)){
		return false;	
	}
	/*
	 * var reg="^(\w+:\/\/)?\w+(\.\w+)+.*$"; var regExp=new RegExp(reg); return
	 * regExp.test(str);
	 */
	return true;	
}

// 字符串替换
function replaceStr(stringObj, str, regStr){
	var reg=new RegExp(str,"g");
	return stringObj.replace(reg, regStr);	
}

// 验证是否为中文
function isChina(str){
	return /.*[\u4e00-\u9fa5]+.*$/.test(str);	
}
// ------------------------------------regex---------------------------------------------

jQuery.extend({
    
	// 验证图片
	validImgFile: function(rsPath){
	
		if(rsPath == ""){
			
			$.messager.alert('提示信息', '文件不能为空！');
			return false;
		}
		
		var extStart = rsPath.lastIndexOf(".");
		var ext= rsPath.substring(extStart,rsPath.length).toUpperCase();
		var endTmp = [".BMP", ".PNG", ".GIF", ".JPG", ".JPEG", ".HTML", ".ZDDS"];
		if( $.inArray(ext, endTmp) == -1){
		 
			$.messager.alert('提示信息', '图片文件限于bmp,png,gif,jpeg,jpg,html格式！');
		 	return false;
		}
		return true;
	}

});

jQuery.extend({
	
	// 验证MP4
	validVideoFile: function(rsPath){
	
		if(rsPath == ""){
			
			$.messager.alert('提示信息', '文件不能为空！');
			return false;
		}
	
		var extStart = rsPath.lastIndexOf(".");
		var ext= rsPath.substring(extStart,rsPath.length).toUpperCase();
		var endTmp = [".MP4"];
		if( $.inArray(ext, endTmp) == -1){
		 
			$.messager.alert('提示信息', '文件限于mp4格式！');
		 	return false;
		}
		return true;
	}
});

jQuery.extend({
	
	// 验证MP3
	validAudioFile: function(rsPath){
	
		if(rsPath == ""){
			
			$.messager.alert('提示信息', '文件不能为空！');
			return false;
		}
	
		var extStart = rsPath.lastIndexOf(".");
		var ext= rsPath.substring(extStart,rsPath.length).toUpperCase();
		var endTmp = [".MP3",".CD",".OGG",".WMA",".ASF"];
		if( $.inArray(ext, endTmp) == -1){
		 
			$.messager.alert('提示信息', '音频文件限于mp3,cd,ogg,wma,asf格式！');
		 	return false;
		}
		return true;
	}
});

jQuery.extend({
	
	// 验证MP4
	validZddsFile: function(rsPath){
	
		if(rsPath == ""){
			
			$.messager.alert('提示信息', '文件不能为空！');
			return false;
		}
	
		var extStart = rsPath.lastIndexOf(".");
		var ext= rsPath.substring(extStart,rsPath.length).toUpperCase();
		var endTmp = [".ZDDS"];
		if( $.inArray(ext, endTmp) == -1){
		 
			$.messager.alert('提示信息', '文件限于zdds格式！');
		 	return false;
		}
		return true;
	}
});
//tab页面引用jsp，则此jsp中的表单验证会失效。可用此方法初始化表单的验证器。
function initValidBox(formId){
	if(formId==undefined || formId==null){
		return;
	}
	var form = $("#"+formId);//得到表单窗口中的form对象 
	$('input[type!="hidden"],select,textarea',form ).each(function(){  
	    $(this).validatebox();//初始化表单中的验证器  
	});  
}
//将16进制字符串如4CFF12000B67转换成4C-FF-12-00-0B-67，jsp页面展示用。
function mac2hex(macAdress){
	if(macAdress==undefined || macAdress==null || macAdress == ""){
		return;
	}
	if((macAdress.length%2) != 0){
		macAdress = "0" + macAdress;
	}
	var temp = "";
	for(var i=0;i<macAdress.length;i++){
		if(i>0 && i%2==0){
			temp = temp + "-";
		}
		temp = temp + macAdress.charAt(i);
	}
	return temp;
}

function getStatusCn(tmpValue){
	if(tmpValue==null || tmpValue==undefined){
		return "";
	}
	switch(tmpValue){
		case 1 : return "有效";
		default : return "无效";
	}
}

function getResTypeCn(tmpValue){
	if(tmpValue==null || tmpValue==undefined){
		return "";
	}
	switch(tmpValue){
		case 1 : return "菜单";
		default : return "操作";
	}
}

function getIfCn(tmpValue){
	if(tmpValue==null || tmpValue==undefined){
		return "";
	}
	switch(tmpValue){
		case 1 : return "是";
		default : return "否";
	}
}