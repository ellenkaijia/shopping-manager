package com.manager.filter;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.manager.constant.ConsoleConstants;
import com.manager.controller.base.BaseController;
import com.manager.controller.base.ResultInfo;
import com.manager.json.JacksonUtils;
import com.manager.model.admin.SysUser;
import com.server.api.util.StringTools;

/**
 * 权限过滤器，主要用于页面访问的权限控制
 * 
 * @author admin
 */
public class PrivilegeFilter implements Filter{

	Logger log = LoggerFactory.getLogger(PrivilegeFilter.class);
	private String rightConfig;
	//不做权限校验的页面列表：index.jsp,login.jsp
	private String notPrivilegeControlUrls = null;
	//静态资源文件不做校验
	private String notPrivilegeStaticFiles ;
	//没有权限时候要跳转到的页面
	private String noPrivilegePage = null;
	//不做校验的控制器路径
	private String noPrivilegeController = null;
	
	/**权限校验*/
	public static boolean validatePrivilege(HttpSession session,String url){
		boolean result = false;
		if(session != null){
			Object object = session.getAttribute(ConsoleConstants.SESSION_USER_KEY);
			if(object != null){
				SysUser user = (SysUser)object;
				if(isSuperAdmin(user)){
					//是超级管理员
					result = true;
				}
				else if(user.hasPrivilege(url)){
					//访问的url在权限范围
					result = true;
				}
			}
		}
		return result;
	}
	
	public static boolean isSuperAdmin(SysUser user){
		if(user.getIsSuperAdmin()==null || user.getIsSuperAdmin()!=1){
			return false;
		}
		return true;
	}
	
	public PrivilegeFilter(){
		super();
	}

	public void doFilter(ServletRequest request, ServletResponse response,FilterChain filterChain) throws IOException, ServletException{
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse) response; 
		HttpSession session = req.getSession(false);
		
		String projectRootUrl = req.getContextPath();
		String noPrivilegePageUrl = projectRootUrl + noPrivilegePage;
		
		//访问目标url
		String url = PrivilegeFilter.getRequestUri(req);
		String pageName = "";
		if(url.indexOf("/") > -1){
			pageName = url.substring(url.lastIndexOf("/") + 1);
		}
		String fileExtensionName = "";
		if(url.indexOf(".") > -1)
		{
			fileExtensionName = url.substring(url.lastIndexOf("."));
		}
		
		if("/".equalsIgnoreCase(url)){
			//首页
			filterChain.doFilter(request, response);
		}
		else if("/admin/index.jsp".equalsIgnoreCase(url) && (session==null || session.getAttribute(ConsoleConstants.SESSION_USER_KEY)==null) ){
            res.sendRedirect(req.getContextPath()); // 登录页
        }
		else if(!StringTools.isNull(fileExtensionName) &&
					!StringTools.isNull(notPrivilegeStaticFiles) && 
					notPrivilegeStaticFiles.contains(fileExtensionName) ) {
			//不做权限校验的静态文件（js、css、images等）
			filterChain.doFilter(request, response);
		}
		else if(!StringTools.isNull(pageName) && 
					!StringTools.isNull(notPrivilegeControlUrls) && 
					notPrivilegeControlUrls.contains(pageName) ) {
			//不做权限校验的页面
			filterChain.doFilter(request, response);
		}
		else if(noPrivilegeController.contains(url) || 
				session!=null && session.getAttribute(ConsoleConstants.SESSION_USER_KEY)!=null && PrivilegeFilter.validatePrivilege(session,url)){
			//有权限访问
			filterChain.doFilter(request, response);
		}
		else
		{	
			if(session==null || session.getAttribute(ConsoleConstants.SESSION_USER_KEY)==null){
				//未登录或会话超时
			    res.sendRedirect(req.getContextPath()); // 登录页
			}else{
				log.info(BaseController.getUserName(session)+"没有权限"+url);
				if(url.endsWith(".jsp")){
					//访问的是jsp页面
					res.sendRedirect(noPrivilegePageUrl);
				}
				else{
					//访问的是controller
					ResultInfo resultInfo = new ResultInfo();
					resultInfo.setCode(ConsoleConstants.RESULT_CODE_FAILED);
					resultInfo.setMessage("您没有权限，请联系管理员。");
					res.setCharacterEncoding("utf-8");
					res.getWriter().println(JacksonUtils.jsonObjectSerializer(resultInfo));
					res.getWriter().flush();
				}
			}
			return;
		}
		
	}
	
	/**获得访问URL的从context后面的字符串，以/开头。*/
    public static String getRequestUri(final HttpServletRequest request){
        if(request==null){
            return "";
        }
        try{
            StringBuilder uri = new StringBuilder(request.getRequestURI());
            if(uri!=null && uri.length()>0){
                uri.delete(0, request.getContextPath().length());
                if(uri.indexOf("?")>0){
                    uri.delete(uri.indexOf("?"), uri.length());
                }
                if(uri.indexOf(";")>0){
                    uri.delete(uri.indexOf(";"), uri.length());
                }
            }
            return uri.toString();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return "";
    }
	
	public void init(FilterConfig filterConfig) throws ServletException{
	    this.rightConfig = filterConfig.getInitParameter("rightConfig");//rightConfig
	    Properties p = new Properties();
        try {
            p.load(this.getClass().getClassLoader().getResourceAsStream(rightConfig));
            this.notPrivilegeControlUrls = p.getProperty("notPrivilegeControlUrls");
            this.notPrivilegeStaticFiles = p.getProperty("notPrivilegeStaticFiles");
            this.noPrivilegePage = p.getProperty("noPrivilegePage");
            this.noPrivilegeController = p.getProperty("noPrivilegeController");
        } catch (IOException e) {
            log.error(e.getMessage(),e);
        }
	}

	public void destroy(){
	}
	
	public static void main(String[] args){
//		String str = "/employee/queryUserMenuTree,\n\t\t\t\t/employee/logout,\n\t\t\t\t/ftpFile/handleFileInfo";
//		System.out.println(str.contains("/ftpFile/handleFileInfo"));
		String uri = "/sscf/dddController/tetes1?ddd=45525885";
		System.out.println(uri.substring(0, uri.indexOf("?")));
	}

}