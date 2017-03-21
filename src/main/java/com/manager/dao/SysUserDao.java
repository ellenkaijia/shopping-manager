package com.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.manager.model.admin.SysUser;
import com.server.api.easyui.Page;

public interface SysUserDao {

	int deleteByPrimaryKey(Long userId);

	int insertSelective(SysUser record);

	SysUser selectByPrimaryKey(Long userId);

	int updateByPrimaryKeySelective(SysUser record);

	List<SysUser> getByUserName(@Param("userName") String userName);

	List<SysUser> dataGrid(Page<SysUser> page);

	List<SysUser> getUserName(SysUser user);
}
