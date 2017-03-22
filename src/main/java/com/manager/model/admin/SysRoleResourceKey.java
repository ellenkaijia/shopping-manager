package com.manager.model.admin;

import java.io.Serializable;

public class SysRoleResourceKey implements Serializable {
	
    private Long resId;
    private Long roleId;
    private String resUrl;
    private static final long serialVersionUID = 1L;

    public Long getResId() {
        return resId;
    }

    public void setResId(Long resId) {
        this.resId = resId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

	public String getResUrl() {
		return resUrl;
	}

	public void setResUrl(String resUrl) {
		this.resUrl = resUrl;
	}
}