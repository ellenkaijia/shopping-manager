package com.manager.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.manager.model.admin.SysResource;
import com.manager.model.admin.SysRole;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;

public interface ISysRoleService {

	DataGrid dataGrid(SysRole role, Page page);

	void create(SysRole record) throws Exception;

	void edit(SysRole record) throws Exception;

	void delete(Long roleId) throws Exception;

	List<SysResource> getCombotree(Long roleId);

	String roleRessIds(Long roleId);

	void updatePermission(SysRole record) throws Exception;

	List<Map<String, String>> getAllRole(String q);

	Map<Long, Set<String>> getRoleRess();
}
