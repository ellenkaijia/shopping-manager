package com.manager.service;

import java.util.List;

import com.manager.model.admin.SysUser;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;


public interface ISysUserService {

	SysUser login(SysUser param, String ip) throws Exception;
	
	DataGrid dataGrid(SysUser condi, Page page);

	/**查根据userName查询用户信息，不是like模糊查询*/
	List<SysUser> getByUserName(String userName);
	
	/**查根据userName查询用户信息，是like模糊查询*/
	List<SysUser> getUserName(SysUser record);

	void create(SysUser record ) throws Exception;

	void edit(SysUser record , SysUser currentUser) throws Exception;

	void delete(Long userId) throws Exception;
	
}
