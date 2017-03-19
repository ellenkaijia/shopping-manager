<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="session"/>
<c:set var="version" value="V1.0" scope="session"/>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();
//    String[] cookies = com.kingdee.finance.fixin.controller.SysUserController.getUserNameAndPwdFromCookie(request);
    String userName = "zkj";
    String userPwd = "zkj";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="public/console_lib.jsp" />
<title>电器商城后台管理系统</title>
<style type="text/css">
html, body {
	background-color: #FFF;
	color: #444;
	font: 12px/1.5 tahoma, arial, 'Hiragino Sans GB', \5b8b\4f53, sans-serif;
}

img {
	border: none;
}

.head {
	width: 890px;
	margin: 50px auto 0 auto;
}

.head strong {
	color: #FFF;
	border-radius: 3px;
	padding: 2px 10px 3px;
	padding: 3px 10px 2px \9;
	*padding: 4px 10px 1px;
	position: absolute;
	margin: 0 0 0 15px;
	background-color: #C40;
	font-weight: bold;
	font-size: 27px
}

.main {
	width: 890px;
	margin: 0 auto;
	padding: 10px;
	border-radius: 3px;
	background: url(${pageContext.request.contextPath}/images/bg5.png) no-repeat;
	overflow: hidden;
	height: 460px;
}

.main .right {
	float: right;
	background-color: #FAFAFA;
	box-shadow: 1px 1px 1px #FAFAFA;
	border-radius: 3px;
	padding: 10px 20px 20px 20px;
	width: 280px;
	border: 2px solid #DDD;
}

.main .right p {
	font-family: "Microsoft YaHei";
	font-size: 12px;
	font-weight: bold;
	color: #C40;
}

.main .right div input {
	border: 1px solid #999;
	border-right: 1px solid #DCDCDC;
	border-bottom: 1px solid #DCDCDC;
	height: 17px;
	line-height: 16px;
	padding: 9px;
	vertical-align: middle;
	width: 250px;
	margin-bottom: 5px;
	background-color: #FFF;
	font-size: 14px;
	font-style:Microsoft YaHei; 
	font-weight:bold;
	color: #006C00;
}

.button_01 {
	display: inline-block;
	height: 30px;
	line-height: 24px;
	line-height: 20px \9;
	width: 270px;
	padding: 5px 0;
	*padding: 3px 0 7px;
	_padding: 5px 0;
	text-align: center;
	vertical-align : middle;
	text-decoration: none;
	color: #604413;
	background: #F8BC54;
	border: 1px solid #B7842C;
	border-radius: 3px;
	background: linear-gradient(top, #FCB233 0%, #F8BC54 100%);
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.8) inset, 1px 1px 3px
		rgba(0, 0, 0, 0.2);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#FCB233',
		endColorstr='#F8BC54', GradientType=0);
	cursor: pointer;
	font-family: "Microsoft YaHei";
	font-size: 18px;
	font-weight: bold;
	*position: absolute;
}

.button_02 {
	display: inline-block;
	height: 30px;
	line-height: 24px;
	line-height: 20px \9;
	width: 130px;
	*padding: 3px 0 7px;
	_padding: 5px 0;
	text-align: center;
	vertical-align : middle;
	text-decoration: none;
	color: #604413;
	background: #F8BC54;
	border: 1px solid #B7842C;
	border-radius: 3px;
	background: linear-gradient(top, #FCB233 0%, #F8BC54 100%);
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.8) inset, 1px 1px 3px
	rgba(0, 0, 0, 0.2);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#FCB233',
	endColorstr='#F8BC54', GradientType=0);
	cursor: pointer;
	font-family: "Microsoft YaHei";
	font-size: 18px;
	font-weight: bold;
	*position: absolute;
}

.button_01:hover,.button_02:hover {
	color: #412E0C;
	border: 1px solid #A17324;
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.8) inset, 1px 1px 5px
		rgba(0, 0, 0, 0.4);
	filter: progid:DXImageTransform.Microsoft.Shadow(Strength=2, Direction=135,
		Color='#999999');
}

.foot {
	text-align: center;
	border-top: 1px solid #DDD;
	padding-top: 20px;
	width: 890px;
	margin: 0 auto;
}

.tip {
	font-size: 13px;
	font-weight: normal;
	color: red;
	background:
		url(${pageContext.request.contextPath}/images/easyui_icons/info.png)
		no-repeat;
	border: 1px solid #ddd;
	width: 245px;
	padding: 2px 0px 2px 25px;
	line-height: 18px;
	background-position: 3px 4px;
	border-color: #40b3ff;
	background-color: #e5f5ff;
}
</style>
<script type="text/javascript">
	//局部登录改为全页面
	if (window != top)
		top.location.href = location.href;

	var baseUrl = '${pageContext.request.contextPath}';
	var loginUrl = baseUrl + '/sysUser/login';
	var logoutUrl = baseUrl + '/sysUser/logout';
	var validCodeUrl = baseUrl + '/sysUser/getValidationCode';
	var loginJsp = baseUrl + '/admin/index.jsp';
	function showProgress() {
		$.messager.progress({
			text : '登录中....',
			interval : 100
		});
	}
	function closeProgress() {
		$.messager.progress('close');
	}
	function sendValidationCode(){
		$("#info").hide();
		if($("#userName").val()==""){
			$("#userName").focus();
			$.messager.alert("错误提示", "用户名不能为空");
			return ;
		}

		$.ajax({
			type : "POST",
			url : validCodeUrl,
			data : {
				"userName" : $("#userName").val()
			},
			timeout : 10000,
			dataType : "json",
			success: function(result){
				if (result.code == '1'){
					$.messager.alert("提示","验证码已发送，请查收！");
				} else if (result.code == '-1'){
					$.messager.alert("提示","用户名或手机号码为空，请联系管理员。");
				} else {
					$.messager.alert("提示","系统异常，请联系管理员。");
				}
			}
		});
	}
	
	function login(){
		$("#info").hide();
		if($("#userName").val()==""){
			$("#userName").focus();
			$.messager.alert("错误提示", "用户名不能为空");
			return ;
		}
		userPwd = $("#userPwd").val();
		if(userPwd==""){
			$("#userPwd").focus();
            $.messager.alert("错误提示", "密码不能为空");
            return ;
        }
		if(userPwd.length<6){
			$("#userPwd").focus();
            $.messager.alert("错误提示", "密码长度最少为6");
            return ;
        }
		if($("#validationCode").val()==""){
			$("#validationCode").focus();
			$.messager.alert("错误提示", "验证码不能为空");
			return ;

		}
		showProgress();
        $.ajax({
            url : loginUrl,
            type : 'POST',
            cache : false,
            dataType : 'JSON',
            data : {
            	'userName' : $("#userName").val(),
            	'userPwd' : $("#userPwd").val(),
				'validationCode' : $("#validationCode").val()
            },
            error : function() {
                closeProgress();
                document.getElementById('info').innerHTML = '未知错误';
            },
            success : function(response) {
                closeProgress();
                if (response.code == 1) {
                	setCookie("userName",$("#userName").val());
                    setCookie("userPwd",$("#userPwd").val());
                    window.location.href = loginJsp;
                } 
                else{
                    $('#info').html(response.message);
                    $("#info").show();
                }
            }
        });
	}
</script>
</head>
<body>
	<div class="head">
		<a href="javascript:void(0)"><img style="width:80px;height:80px"
			src="<%=basePath%>/images/logo.jpg"></a> 
		<a href="javascript:void(0)"><img style="width:80px;height:80px"
			src="<%=basePath%>/images/logo2.jpg"></a> 
		<strong>电器商城管理系统</strong>
	</div>
	<div class="main">
		<div class="left"></div>
		<div class="right">
		    <div>
		       <p>账号</p>
		       <input type="text" id="userName" name="userName" onkeyup="javascript:if(event.keyCode==13){login();}" value="<%=userName %>" />
		    </div>
		    <div>
               <p>密码</p>
               <input type="password" id="userPwd" name="userPwd" onkeyup="javascript:if(event.keyCode==13){login();}" value="<%=userPwd %>"  />
            </div>
			<div >
				<p>验证码</p>
				<input type="text" id="validationCode" name="validationCode" onkeyup="javascript:if(event.keyCode==13){login();}" size="10"/>
				<a type="button" class="button_02" id="sendValidationCode"  onclick="sendValidationCode();">获取验证码</a>
			</div>
            <div>
               <p></p>
               <span id="info" class="tip" style="display: none;"></span>
            </div>
            <br/>
            <div>
                <a type="button" class="button_01" style="vertical-align : middle;" onclick="login();">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
            </div>
		  </table>
		</div>
	</div>
	<div class="foot">Copy ${version} &copy; 赵楷佳</div>
	
</body>

<script type="text/javascript">

// 进入页面后自动获取光标，操作人员不需要需要手工点击输入框
function focusOnInput(){
	if($("#userName").val()==""){
		$("#userName").focus();
		return;
	}
	if($("#userPwd").val()==""){
        $("#userPwd").focus();
        return;
    }
	$("#validationCode").focus();
	$("#userName").val(getCookie("userName"));
	$("#userPwd").val(getCookie("userPwd"));
}

setTimeout("focusOnInput()",100);

</script>

</html>