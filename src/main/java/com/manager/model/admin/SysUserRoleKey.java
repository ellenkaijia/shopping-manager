package com.manager.model.admin;

import java.io.Serializable;

public class SysUserRoleKey implements Serializable {
	
    private Long roleId;
    private Long userId;
    private static final long serialVersionUID = 1L;

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}