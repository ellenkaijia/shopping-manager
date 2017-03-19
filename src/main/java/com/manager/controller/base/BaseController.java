package com.manager.controller.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.manager.constant.ConsoleConstants;
import com.manager.model.admin.SysUser;

public class BaseController {

    /**获取登录用户的用户名*/
    public static String getUserName(HttpSession session){
        if(session!=null){
            SysUser user = BaseController.getUser(session);
            if(user!=null){
                return user.getUserName();
            }
        }
        return "";
    }
    
    /**获取登录用户的用户名*/
    public static String getUserName(HttpServletRequest request){
    	SysUser user = BaseController.getUser(request);
    	if(user!=null){
    		return user.getUserName();
    	}
        return "";
    }
    
    /**获取当前登录人(员工)*/
	public static SysUser getUser(HttpSession session){
        Object obj = session.getAttribute(ConsoleConstants.SESSION_USER_KEY);
        if(obj != null){
            return (SysUser)obj;
        }
        return null;
    }
	
	/**获取当前登录人(员工)*/
	public static SysUser getUser(HttpServletRequest request){
		if(request!=null){
			HttpSession session = request.getSession();
			if(session!=null){
				Object obj = session.getAttribute(ConsoleConstants.SESSION_USER_KEY);
		        if(obj != null){
		            return (SysUser)obj;
		        }
			}
		}
        return null;
    }
	
}
