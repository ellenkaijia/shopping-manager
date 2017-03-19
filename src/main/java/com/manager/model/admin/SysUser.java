package com.manager.model.admin;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.manager.constant.DBConstant;
import com.server.api.util.StringTools;

public class SysUser implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private Long userId;
    private String userName;
    private String userPwd;
    private String realName;
    private Integer isSuperAdmin = -1;//1-超级管理员，其他值表示非超级管理员
    private Set<String> userUrls = new HashSet<String>(); //拥有的资源url集合
	private List<SysResource> userMenus = new ArrayList<SysResource>();//员工拥有的菜单（资源类型为1）
	private String roleName;
	private Long roleId;
	private Integer roleStatus;
	private String phone;

	private String validationCode; //登录验证码

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public Long getRoleId() {
		return roleId;
	}

	public Integer getRoleStatus() {
		return roleStatus;
	}

	public void setRoleStatus(Integer roleStatus) {
		this.roleStatus = roleStatus;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		if(this.isSuperAdmin!=null && DBConstant.IS_SUPER_ADMIN_YES==this.isSuperAdmin){
			return "超级管理员";
		}
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName == null ? null : realName.trim();
    }

    public Integer getIsSuperAdmin() {
        return isSuperAdmin;
    }

    public void setIsSuperAdmin(Integer isSuperAdmin) {
        this.isSuperAdmin = isSuperAdmin;
    }

	public Set<String> getUserUrls() {
		return userUrls;
	}

	public void setUserUrls(Set<String> userUrls) {
		this.userUrls = userUrls;
	}

	public boolean hasPrivilege(String url){
		return this.userUrls!=null && this.userUrls.size()>0 && userUrls.contains(url);
	}

	public void setUserMenus(List<SysResource> list) {
		if(list!=null && !list.isEmpty()){
			for(SysResource one : list){
				if(one==null){
					continue;
				}
				if(one.getResType()!=null && DBConstant.RES_TYPE_MENU==one.getResType().intValue()){
					this.userMenus.add(one);//设置菜单，即资源类型为1
				}
				if(!StringTools.isEmpty(one.getResUrl())){
					this.userUrls.add(one.getResUrl().trim());//设置权限url集合
				}
			}
		}
	}

	public List<SysResource> getUserMenus() {
		return this.userMenus;
	}

	public String getValidationCode() {
		return validationCode;
	}

	public void setValidationCode(String validationCode) {
		this.validationCode = validationCode;
	}
	
}