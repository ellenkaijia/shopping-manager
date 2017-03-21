package com.manager.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.manager.constant.ConsoleConstants;
import com.manager.controller.base.BaseController;
import com.manager.controller.base.ResultInfo;
import com.manager.model.admin.SysResource;
import com.manager.model.admin.SysUser;
import com.manager.service.ISysUserService;
import com.manager.util.IPUtil;
import com.manager.util.SpringPropertiesActiveUtils;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;
import com.server.api.util.StringTools;


@Controller
@RequestMapping("/sysUser")
public class SysUserController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(SysUserController.class);
	@Autowired
	ISysUserService sysUserService;
/*	@Autowired
	SmsCommonRPCService smsCommonRPCService;*/
	@RequestMapping("/login")
	@ResponseBody
	public ResultInfo login(SysUser param) throws Exception{
		SysUser user = sysUserService.login(param, IPUtil.getClientIP(this.request));
		//UAT、生产环境需验证码验证
		if(SpringPropertiesActiveUtils.isUatEnv()||SpringPropertiesActiveUtils.isRunEnv()){
		//	boolean validaResult = smsCommonRPCService.validateAuthCode(user.getPhone(),param.getValidationCode());
			boolean validaResult = true;
			if(!validaResult){
				return this.fail("验证码错误或过期");
			}
		}
		session.setAttribute(ConsoleConstants.SESSION_USER_KEY, user);
		this.setUserNameAndPwdFromCookie(param);
		return this.success();

	}
	
	/**使用Cookie记住用户名、密码*/
	private void setUserNameAndPwdFromCookie(SysUser param){
	    Cookie userNameCookie = new Cookie(ConsoleConstants.COOKIE_USER_NAME , param.getUserName());
        userNameCookie.setMaxAge( 604800 ); // 7天有效期
        Cookie userPwdCookie = new Cookie(ConsoleConstants.COOKIE_USER_PWD , param.getUserPwd());
        userPwdCookie.setMaxAge( 604800 ); // 7天有效期
        this.response.addCookie(userNameCookie);
        this.response.addCookie(userPwdCookie);
	}
	
	/**浏览器获取用户名、密码，以自动填充输入框*/
	public static String[] getUserNameAndPwdFromCookie(HttpServletRequest request){
	    String[] results = new String[]{"",""};
	    if(request==null || request.getCookies()==null || request.getCookies().length<1){
	        return results;
	    }
	    try{
	        for(Cookie cookie : request.getCookies()){
	            if(results[0].length()>0 && results[1].length()>0){
	                break;
	            }
	            if(ConsoleConstants.COOKIE_USER_NAME.equals(cookie.getName())){
	                results[0] = URLDecoder.decode(cookie.getValue(), "UTF8");
	            }
	            else if(ConsoleConstants.COOKIE_USER_PWD.equals(cookie.getName())){
	                results[1] = URLDecoder.decode(cookie.getValue(), "UTF8");
	            }
	        }
	    }
	    catch(UnsupportedEncodingException e){
            logger.error(e.getMessage()); // 可以不用做任何事，因为只是获取cookie，不影响任何业务
        }
	    catch(Exception e){
	        logger.error(e.getMessage()); // 可以不用做任何事，因为只是获取cookie，不影响任何业务
	    }
	    return results;
	}
	
	@RequestMapping("/getValidationCode")
	@ResponseBody
	public ResultInfo getValidationCode(SysUser param) throws Exception{
		List<SysUser> user=sysUserService.getByUserName(param.getUserName());
		String phone=null;
		ResultInfo resultInfo = new ResultInfo();
		if( !CollectionUtils.isEmpty(user) ){
			phone=user.get(0).getPhone();
		}
		resultInfo.setCode(ConsoleConstants.RESULT_CODE_FAILED);
		if(StringUtils.isNotBlank(phone)){
			/*String sendResut= smsCommonRPCService.sendSms(phone);
			resultInfo.setCode(Integer.parseInt(sendResut));*/
			//TODO： 手机发起验证码
		}
		return resultInfo;
	}
	
	@RequestMapping("/logout")
	@ResponseBody
	public ResultInfo logout() throws Exception{
		session.invalidate();
		response.sendRedirect(request.getContextPath());
		return null;
	}
	
	@RequestMapping("/getUserMenus")
	@ResponseBody
	public List<SysResource> getUserMenus() {
		SysUser user = this.getUser();
		if(user!=null){
		    return user.getUserMenus();
		}
		return null;
	}
	
	@RequestMapping("/dataGrid")
	@ResponseBody
	public DataGrid dataGrid(SysUser condi, Page page){
		return sysUserService.dataGrid(condi , page);
	}
	
	@RequestMapping("/getUserName")
	@ResponseBody
	public List<SysUser> getUserName(SysUser record){
		return sysUserService.getUserName(record);
	}
	
	@RequestMapping("/create")
	@ResponseBody
	public ResultInfo create(SysUser record) throws Exception{
		sysUserService.create(record);
		return this.success();
	}
	
	@RequestMapping("/edit")
	@ResponseBody
	public ResultInfo edit(SysUser record) throws Exception{
		sysUserService.edit(record, this.getUser());
		return this.success();
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ResultInfo delete(Long userId) throws Exception{
		sysUserService.delete(userId);
		return this.success();
	}
	
	/**用户是否已存在：true-已经存在，false-不存在*/
	@RequestMapping("/isUserExists")
	@ResponseBody
	public boolean isUserExists(String userName) throws Exception{
		if(StringTools.isEmpty(userName)){
			return false;
		}
		List<SysUser> list = sysUserService.getByUserName(userName.trim());
		if(null!=list && !list.isEmpty()){
			return true; // 已经存在
		}
		return false;
	}
	
}
