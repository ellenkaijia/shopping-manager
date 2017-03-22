package com.manager.dao;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.manager.model.admin.SysRoleResourceKey;


public interface SysRoleResourceDao {
	
    int deleteByPrimaryKey(SysRoleResourceKey key);

    int insert(SysRoleResourceKey record);

    int insertSelective(SysRoleResourceKey record);
    
    void deleteByCondi(@Param("resId") Long resId , @Param("roleId") Long roleId);
    
    int insertBatch(List<SysRoleResourceKey> list);
    
    int deleteByResIdBatch(@Param("set") Set<Long> resIds);
    
    List<SysRoleResourceKey> getRoleRess();
    
    /**此方法慎用，清除所有角色-资源关联数据*/
    void deleteAll();
    
}