package com.manager.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.manager.model.admin.SysRole;
import com.server.api.easyui.Page;

public interface SysRoleDao {
    int deleteByPrimaryKey(Long roleId);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(Long roleId);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);
    
    List<SysRole> dataGrid(Page<SysRole> page);
    
    List<Map<String,String>> getAllRole(@Param("q") String q);
    
}