var menuJson;
var selectedTopMenuId;
$(function(){
	loadMenu();
	loginPrompt();
});

//加载菜单
function loadMenu(){
	showLoadingMenuProgress();
    $.ajax({
	    url : queryUserMenuTreeUrl,
        type: 'POST',
	    cache : false,
		dataType: 'json',
		error: function(){
			closeProgress();
		},
		success : function(response){
			closeProgress();
		    menuJson = convert(response);
		    initMenu();
	    }
    });
}

function initMenu(){
	initTopMenu();//初始化顶级菜单
	initLeftMenu();//初始化左侧菜单
	initIndexTab();//初始化首页tab
	$(".panel-title").each(function(){
        if(this.innerText!=undefined && this.innerText.indexOf("导航菜单")>=0){
        	this.innerHTML = "&nbsp;&nbsp;<span style='cursor:pointer;' onclick='expandAll();'>展开</span>"+
        			"&nbsp;&nbsp;<span style='cursor:pointer;' onclick='collapseAll();'>收起</span>";
            return false;
        }
    });
}

function initTopMenu(){
	$("#topMenuSpan").html("");
	var topMenuSpanHtml = "";
	if(typeof(menuJson)!="undefined" && menuJson.length>0){
		for(var i=0; i<menuJson.length; i++){
			var one = menuJson[i];
			topMenuSpanHtml += "<span class='menuSpan' id='topMenu" + one.resId + "' onclick='selectTopMenu("+one.resId+")'>"+one.resName+"</span>&nbsp;";
		}
		$("#topMenuSpan").html(topMenuSpanHtml);
	}
}

function selectTopMenu(topMenuId){
	selectedTopMenuId = topMenuId;
	initLeftMenu();//初始化左侧菜单
}

//折叠
function collapseAll(){
	var pp = $('#nav').accordion('panels');    
	if (pp && pp.length>0){  
		for(var i=0 ; i<pp.length;i++){
			$("#nav").accordion("unselect",i);
		}
	}
}

//展开
function expandAll(){
	var pp = $('#nav').accordion('panels');    
	if (pp && pp.length>0){  
		for(var i=0 ; i<pp.length;i++){
			$("#nav").accordion("select",i);
		}
	}
}

//清空左侧菜单
function clearaLeftMenu(){
	var pp = $('#nav').accordion('panels'); 
	while (pp && pp.length>0){  
		$("#nav").accordion("remove",0);
	}
}

function initIndexTab(){
	var indexUrl = "main.html";
	$('#tabs').tabs('add',{
		title:'首页',
		content:'<iframe scrolling="auto" frameborder="0"  src="' + indexUrl + '" style="width:100%;height:100%;"></iframe>',
		closable:true,
		icon:'icon-myhome'
	});
}

function toJson(src){
	return eval('(' + src + ')');
}

//初始化左侧
function initLeftMenu(){
	clearaLeftMenu();
	$('#nav').accordion({ animate: false });//取消动画效果，加载更快
	var leftMenuJson = menuJson[0];//默认显示第一个顶级菜单
	if(typeof(selectedTopMenuId)!="undefined" && selectedTopMenuId>0 && typeof(menuJson)!="undefined" && menuJson.length>0){
		for(var i=0; i<menuJson.length; i++){
			if(menuJson[i].resId==selectedTopMenuId){
				leftMenuJson = menuJson[i];
				break;
			}
		}
	}
	if(typeof(leftMenuJson.children)=="undefined" || leftMenuJson.children.length<1){
		return;
	}
	$("#topMenuSpan").children().each(function(){
		$(this).css("color","rgb(255, 255, 255)");
		$(this).css("font-size","15px");
		$(this).css("font-weight","");
	});
	$("#topMenu"+leftMenuJson.resId).css("color","#996600");
	$("#topMenu"+leftMenuJson.resId).css("font-size","17px");
	$("#topMenu"+leftMenuJson.resId).css("font-weight","bold");
    $.each(leftMenuJson.children, function(i, firstMenu){
    	var menulist = '';
    	menulist += '<div style="margin-top:5px;margin-bottom:5px;">';
    	menulist += '<ul id="tree' + i + '"></ul>';
    	menulist += '</div>';
        //遍历生成一级菜单
		$('#nav').accordion('add',{
            title: firstMenu.text,
            content: menulist,
            iconCls: 'icon ' + firstMenu.iconCls,
            selected : true  //true展开，false折叠
        });
		//把二级以下转成tree
		$('#tree' + i).tree({
		    data: firstMenu.children,
		    lines:true,
		    onClick: function(node){
		        var url = node.resUrl;//菜单url
		        //如果url不为空的话就创建一个tab
		        if(url != null && url != ''){
		        	var icon = node.iconCls;
			        var tabTitle = node.text;
		        	addTab(tabTitle,url,icon);
		        }
		    }
		});
    });
}

function closeTabByTitle(title){
	$('#tabs').tabs('close',title);
}

//登录提示
function loginPrompt(){
	var content = '<p>' + '尊敬的&nbsp;' + $('#usernameInput').val() + '&nbsp;' + $("#realNameInput").val() + '</p></br>' ;
	content += '您的IP为：' + $('#clientIpInput').val();
	$.messager.show({  
        title: '非标后台欢迎您',  
        msg: content,  
        timeout: 3000,  
        height:150, 
        showType: 'slide'  
    });  
}
