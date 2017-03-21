package com.manager.controller.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.manager.constant.ConsoleConstants;
import com.manager.model.admin.SysUser;
import com.server.api.util.StringTools;

public class BaseController {

	protected final Logger log = LoggerFactory.getLogger(getClass());// 子类可直接用此log对象打印日志
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected HttpSession session;

	@ModelAttribute
	public void setReqAndResp(HttpServletRequest request,HttpServletResponse response,HttpSession session) {
		this.request = request;
		this.response = response;
		this.session = session;
	}
	
	/** 获取登录用户的用户名 */
	public static String getUserName(HttpSession session) {
		if (session != null) {
			SysUser user = BaseController.getUser(session);
			if (user != null) {
				return user.getUserName();
			}
		}
		return "";
	}

	/** 获取登录用户的用户名 */
	public static String getUserName(HttpServletRequest request) {
		SysUser user = BaseController.getUser(request);
		if (user != null) {
			return user.getUserName();
		}
		return "";
	}

	/** 获取当前登录人(员工) */
	public static SysUser getUser(HttpSession session) {
		Object obj = session.getAttribute(ConsoleConstants.SESSION_USER_KEY);
		if (obj != null) {
			return (SysUser) obj;
		}
		return null;
	}

	/** 获取当前登录人(员工) */
	public static SysUser getUser(HttpServletRequest request) {
		if (request != null) {
			HttpSession session = request.getSession();
			if (session != null) {
				Object obj = session.getAttribute(ConsoleConstants.SESSION_USER_KEY);
				if (obj != null) {
					return (SysUser) obj;
				}
			}
		}
		return null;
	}
	
	/**获取当前登录人(员工)*/
	protected SysUser getUser(){
        Object obj = session.getAttribute(ConsoleConstants.SESSION_USER_KEY);
        if(obj != null){
            return (SysUser)obj;
        }
        return null;
    }
	
	/**直接返回成功的ResultInfo，避免每处都new ResultInfo()*/
	protected ResultInfo success(){
	    ResultInfo resultInfo = new ResultInfo();
	    resultInfo.setCode(ConsoleConstants.RESULT_CODE_SUCCESS);
        resultInfo.setMessage("成功");
        return resultInfo;
	}

	/**直接返回失败的ResultInfo，避免每处都new ResultInfo()*/
	protected ResultInfo fail(String msg){
		ResultInfo resultInfo = new ResultInfo();
		resultInfo.setCode(ConsoleConstants.RESULT_CODE_FAILED);
		resultInfo.setMessage(msg);
		return resultInfo;
	}
	
	/**业务处理发生程序异常（前台）*/
	protected void error(ResultInfo resultInfo,String errorMsg,Exception e){
	    if(e!=null){
	    	log.error(e.getMessage(),e);
	    }
		resultInfo.setCode(ConsoleConstants.RESULT_CODE_FAILED);
		if(!StringTools.isEmpty(errorMsg)){
			resultInfo.setMessage(errorMsg);
		}
		else{
			resultInfo.setMessage("服务器异常");
		}
	}
	
	/**业务处理成功（前台）*/
	protected ResultInfo success(ResultInfo resultInfo, String successMsg, Object data){
	    if(resultInfo==null){
            resultInfo = new ResultInfo();
        }
		resultInfo.setCode(ConsoleConstants.RESULT_CODE_SUCCESS);
		if(!StringTools.isEmpty(successMsg)){
			resultInfo.setMessage(successMsg);
		}
		else{
			resultInfo.setMessage("成功");
		}
		resultInfo.setData(data);
		return resultInfo;
	}

}
