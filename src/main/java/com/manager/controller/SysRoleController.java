package com.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.manager.controller.base.BaseController;
import com.manager.controller.base.ResultInfo;
import com.manager.model.admin.SysResource;
import com.manager.model.admin.SysRole;
import com.manager.service.ISysRoleService;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;
import com.server.api.util.StringTools;


@Controller
@RequestMapping("/sysRole")
public class SysRoleController extends BaseController {

	@Autowired
	ISysRoleService sysRoleService;
	
	@RequestMapping("/dataGrid")
	@ResponseBody
	public DataGrid dataGrid(SysRole role, Page page){
		return sysRoleService.dataGrid(role, page);
	}
	
	@RequestMapping("/create")
	@ResponseBody
	public ResultInfo create(SysRole role) throws Exception{
		sysRoleService.create(role);
		return this.success();
	}
	
	@RequestMapping("/edit")
	@ResponseBody
	public ResultInfo edit(SysRole role) throws Exception{
		sysRoleService.edit(role);
		return this.success();
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ResultInfo delete(Long roleId) throws Exception{
		sysRoleService.delete(roleId);
		return this.success();
	}
	
	@RequestMapping("/getCombotree")
	@ResponseBody
	public List<SysResource> getCombotree(Long roleId){
		return sysRoleService.getCombotree(roleId);
	}
	
	@RequestMapping("/roleRessIds")
	@ResponseBody
	public String roleRessIds(Long roleId){
		return sysRoleService.roleRessIds(roleId);
	}
	
	@RequestMapping("/updatePermission")
	@ResponseBody
	public ResultInfo updatePermission(SysRole record) throws Exception{
		sysRoleService.updatePermission(record);
		return this.success();
	}
	
	@RequestMapping("/getAllRole")
	@ResponseBody
	public List<Map<String,String>> getAllRole(String q, Boolean isShowEmpty){
		if(StringTools.isEmpty(q)){
			q = null;
		}
		List<Map<String,String>> appData = sysRoleService.getAllRole(q);
		if(isShowEmpty!=null && isShowEmpty.booleanValue()){
		    Map<String,String> map = new HashMap<String,String>(){
		        private static final long serialVersionUID = 1L;
		        {
		            put("id", "");
		            put("name", "全部");
		        }
		    };
		    appData.add(map);
		}
		return appData;
	}
	
}
