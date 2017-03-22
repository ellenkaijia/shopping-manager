package com.manager.filter;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/***
 * JSTL标签，页面上判断当前用户是否有此操作的权限，若没有则不显示。
 * @author haibin_huang
 *
 */
public class HasPermission extends TagSupport {

	private static final long serialVersionUID = 9106178301464336242L;
	
	private String url = null;

	@Override
	public int doStartTag() throws JspException {
        if (PrivilegeFilter.validatePrivilege(this.pageContext.getSession(), url)) {
        	//当前用户有url的权限，输出标签体的内容。
            return TagSupport.EVAL_BODY_INCLUDE;
        } 
        else {
        	//当前用户没有url的权限，跳过标签体，即不显示此按钮。
            return TagSupport.SKIP_BODY;
        }
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
