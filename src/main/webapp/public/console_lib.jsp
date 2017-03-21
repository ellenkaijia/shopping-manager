<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="session"/>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<meta http-equiv="Pragma" content="no-cache" />   
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link rel="shortcut icon" href="${ctx}/images/logoTitle.ico" type="image/x-icon"/>
<link rel="bookmark" href="${ctx}/images/logoTitle.ico" type="image/x-icon"/>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="description" content="sdj jsp">

<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/table.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/easyui_icon.css" />

<!-- 客户端机器可以访问外网时jquery使用百度cdn资源 -->
<!-- <script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script> -->

<!-- 客户端机器不能访问外网则使用工程内的jquery -->
<script src="${ctx}/js/jquery-2.1.4.min.js"></script>

<!-- easyui使用1.4.3，支持多重验证。 -->
<script type="text/javascript" src="<%=basePath%>/js/easyui/jquery.easyui.min.js?${version}" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>/js/easyui/locale/easyui-lang-zh_CN.js?${version}" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>/js/easyui_support.js?${version}" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>/js/common.js?${version}" charset="utf-8"></script>

<script type="text/javascript">
// 创建一个tab
function addTab(title,url,icon){
    if($('#tabs').tabs('exists',title)){
        $('#tabs').tabs('close',title);//已经存在，先删除
    }
    $('#tabs').tabs('add',{
        title:title,
        content:createFrame(url),
        closable:true,
        icon:icon
    });
}

// tab的内容是一个iframe
function createFrame(url){
    var frameHtml = '';
    if(url.indexOf('http') <= -1){
        url = "${ctx}" + url;
    }
    frameHtml = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
    return frameHtml;
}

// 关闭当前tab
function closeCurrentTab(){  
    var tab=$('#tabs').tabs('getSelected'); // 获取当前选中tabs  
    var index = $('#tabs').tabs('getTabIndex',tab); // 获取当前选中tabs的index  
    $('#tabs').tabs('close',index); // 关闭对应index的tabs  
}
</script>
