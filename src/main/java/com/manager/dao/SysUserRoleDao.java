package com.manager.dao;

import org.apache.ibatis.annotations.Param;

import com.manager.model.admin.SysUserRoleKey;

public interface SysUserRoleDao {
	
    int deleteByPrimaryKey(SysUserRoleKey key);

    int insert(SysUserRoleKey record);

    int insertSelective(SysUserRoleKey record);
    
    void deleteByCondi(@Param("roleId") Long roleId , @Param("userId") Long userId);
    
}