<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!public String getClientIpAddr(HttpServletRequest request) 
  { 
    String ip = request.getHeader("x-forwarded-for");    
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) 
    {    
        ip = request.getHeader("Proxy-Client-IP");    
    }    
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
    {    
        ip = request.getHeader("WL-Proxy-Client-IP");    
    }    
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) 
    {    
        ip = request.getRemoteAddr();    
    }    
    return ip;    
  }
%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
    //用户名
	String clientIp = getClientIpAddr(request);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../public/console_lib.jsp" />
<title>电器商城管理后台</title>
<script type="text/javascript" src="<%=basePath%>/js/menu_init.js?${version}"></script>
<style type="text/css">
.footer{text-align:center;color:#15428B; margin:0px; padding:0px;line-height:23px; font-weight:bold;}
.menuSpan{display:inline-block;height:45px;font-weight:bold;cursor:pointer;font-size:15px;}
#topMenuSpan span:hover{background-color: #666666;}
</style>
<script type="text/javascript">
var baseUrl = '${pageContext.request.contextPath}';
var queryUserMenuTreeUrl = baseUrl + '/sysUser/getUserMenus';
var logoutUrl = baseUrl + '/sysUser/logout';

$(function(){
	//局部登录改为全页面
	if (window != top){
		top.location.href = location.href;
	}
	//浏览器后退提示
    if (window.history && window.history.pushState) {
        $(window).on('popstate', function () {
            var hashLocation = location.hash;
            var hashSplit = hashLocation.split("#!/");
            var hashName = hashSplit[1];
            if (hashName !== '') {
                var hash = window.location.hash;
                if (hash === '') {
                	$.messager.confirm('退出系统确认', '离开当前页面会退出系统，需重新登录，请确认', function(r){
        				if (r){
        					window.location.href=logoutUrl;
        				}else{
        					  window.history.pushState('forward', null, './index.jsp');
        				}
        			});
                }
            }
        });
        window.history.pushState('forward', null, './index.jsp');
    	} 
	
        //监听右键事件，创建右键菜单
        $('#tabs').tabs({
            onContextMenu:function(e, title,index){
                e.preventDefault();
                if(index>=0){
                    $('#mm').menu('show', {
                        left: e.pageX,
                        top: e.pageY
                    }).data("tabTitle", title);
                }
            }
        });
        //右键菜单click
        $("#mm").menu({
            onClick : function (item) {
                closeTab(this, item.name);
            }
		});
});

function logout(){
    $.messager.confirm('请确认', '您确定退出吗？', function(r){
				if (r){
				    showProgress();
					window.location.href=logoutUrl;
			    }
	});
}

function logoutWithoutAsk(){
	$.ajax({
          url : logoutUrl,
          type: 'POST',
          cache : false,
          data:{
        	  loginName:'${user.userName}'
          },
          dataType: 'json',
          error: function(){null;},
          success : function(response) {
        	  null;
          }
    });
}
function showLoadingMenuProgress(){
   $.messager.progress({text : '正在加载菜单....',interval : 100});
}

//关闭Tabs
function closeTab(menu, type) {
    var allTabs = $("#tabs").tabs('tabs');
    var allTabtitle = [];
    $.each(allTabs, function (i, n) {
        var opt = $(n).panel('options');
        if (opt.closable){
        	allTabtitle.push(opt.title);
        }
    });
    var curTabTitle = $(menu).data("tabTitle");
    var curTabIndex = $("#tabs").tabs("getTabIndex", $("#tabs").tabs("getTab", curTabTitle));
    switch (type) {
        case 1:
            $("#tabs").tabs("close", curTabIndex);
            return false;
            break;
        case 2:
            for (var i = 0; i < allTabtitle.length; i++) {
                $('#tabs').tabs('close', allTabtitle[i]);
            }
            break;
        case 3:
            for (var i = 0; i < allTabtitle.length; i++) {
                if (curTabTitle != allTabtitle[i])
                    $('#tabs').tabs('close', allTabtitle[i]);
            }
            $('#tabs').tabs('select', curTabTitle);
            break;
        case 4:
            for (var i = curTabIndex; i < allTabtitle.length; i++) {
                $('#tabs').tabs('close', allTabtitle[i]);
            }
            $('#tabs').tabs('select', curTabTitle);
            break;
        case 5:
            for (var i = 0; i < curTabIndex-1; i++) {
                $('#tabs').tabs('close', allTabtitle[i]);
            }
            $('#tabs').tabs('select', curTabTitle);
            break;
        case 6: //刷新
        	var curTab = $("#tabs").tabs("getTab", curTabTitle) ;
        	var url = $(curTab.panel("options").content).attr("src");
        	var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
        	$("#tabs").tabs("update" , {
        		tab : curTab,
        		options : {title : curTabTitle , content : content }
        	});
            break;
    }
}
</script>
</head>
<body  class="easyui-layout" style="overflow-y: hidden"  scroll="no"  >
	<noscript>
	<div style="position:absolute; z-index:110; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
	    <img src="../framework/easyui/images/noscript.gif" alt='抱歉，请开启脚本支持！' />
	</div>
	</noscript>
	
	<!-- 顶部 -->
    <div region="north" split="true" border="false" style="overflow: hidden; height: 45px;background: #2d3e50;line-height: 40px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
        <span style="font-size:15px;height: 50px;width: 180px;">
            <img style="height: 45px;width:180px;" src="../images/logo_index_ssj.png"  align="absmiddle" /></span>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <span id="topMenuSpan">
        </span>
        <span style="float:right;padding-right:15px;font-size:10px;line-height:25px;vertical-align: middle;" class="head">
        	${user.userName}&nbsp;${user.roleName}<br/>
        	<a href="javascript:void(0)" id="loginOut" style="font-size:12px;float:right;line-height:11px;font-weight:bold;color:#996600;" onclick="logout()">安全退出</a>
        </span>
    </div>
    
    <!-- 左边导航菜单 -->
    <div region="west" hide="true"  split="true" title="导航菜单  收起  展开" style="width:180px;" id="west">
       <div id="nav" class="easyui-accordion" data-options="multiple:true" border="false"></div>
    </div>
    
    <!-- 主体 -->
    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false">
		</div>
		<div id="mm" class="easyui-menu" style="width:120px;">
	        <div id="mm-tabclose" data-options="name:1">关闭</div>
	        <div id="mm-tabcloseother" data-options="name:3">关闭其他</div>
	        <div id="mm-tabcloseall" data-options="name:2">关闭全部</div>
	        <div id="mm-tabcloseall" data-options="name:6">刷新当前tab</div>
    	</div>
    </div>
    
    <input type="hidden" value="<%=clientIp%>" id="clientIpInput"/>
    <input type="hidden" value="${user.userName}" id="usernameInput"/>
    <input type="hidden" value="${user.realName}" id="realNameInput"/>

</body>
</html>