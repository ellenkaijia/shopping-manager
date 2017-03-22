package com.manager.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.manager.dao.SysResourceDao;
import com.manager.dao.SysRoleDao;
import com.manager.dao.SysRoleResourceDao;
import com.manager.dao.SysUserRoleDao;
import com.manager.model.admin.SysResource;
import com.manager.model.admin.SysRole;
import com.manager.model.admin.SysRoleResourceKey;
import com.manager.service.ISysRoleService;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;
import com.server.api.util.StringTools;


@Service
public class SysRoleServiceImpl implements ISysRoleService {

	@Resource
	SysRoleDao sysRoleDao;
	@Resource
	SysResourceDao sysResourceDao;
	@Resource
	SysUserRoleDao sysUserRoleDao;
	@Resource
	SysRoleResourceDao sysRoleResourceDao;
	
	@Override
    public DataGrid dataGrid(SysRole role, Page page) {
	    page.setParams(role);
        List<SysRole> list = sysRoleDao.dataGrid(page);
        return Page.getDataGrid(page, list, null);
        }

	@Override
	public void create(SysRole record) throws Exception {
		sysRoleDao.insertSelective(record);
	}

	@Override
	public void edit(SysRole record) throws Exception {
		sysRoleDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public void delete(Long roleId) throws Exception {
		sysRoleDao.deleteByPrimaryKey(roleId);
		sysRoleResourceDao.deleteByCondi(null, roleId);
		sysUserRoleDao.deleteByCondi(roleId, null);
	}

	@Override
	public List<SysResource> getCombotree(Long roleId) {
		List<SysResource> allRess = sysResourceDao.getRessByCondi(null, null, null, null , null);//所有资源，树
		List<SysResource> roleResources = sysResourceDao.getRessByCondi(roleId, null, null, null, null);//该角色拥有的权限
		if(roleResources!=null && !roleResources.isEmpty()){
			Set<Long> roleRessSet = new HashSet<Long>();//该角色拥有的resId集合
			for(SysResource one : roleResources){
				roleRessSet.add(one.getResId());
			}
			//对该角色拥有的资源设置勾选状态
			for(SysResource one : allRess){
				if(roleRessSet.contains(one.getResId())){
					one.setAttributes("true");
				}
			}
		}
		return allRess;
	}

	@Override
	public String roleRessIds(Long roleId) {
		StringBuilder sb = new StringBuilder();
		List<SysResource> roleResources = sysResourceDao.getRessByCondi(roleId, null, null, null, null);//该角色拥有的权限
		if(roleResources!=null && !roleResources.isEmpty()){
			for(SysResource one : roleResources){
				sb.append(one.getResId()).append(",");
			}
			sb.deleteCharAt(sb.length()-1);
		}
		return sb.toString();
	}

	@Override
	public void updatePermission(SysRole record)  throws Exception{
		sysRoleResourceDao.deleteByCondi(null, record.getRoleId());
		if(StringTools.isEmpty(record.getResIds())){
			return;
		}
		List<Long> resIds = new ArrayList<Long>();
		for(String one : record.getResIds().trim().split(",")){
			Long resId = Long.valueOf(one.trim());
			if(!resIds.contains(resId)){
				resIds.add(resId);
			}
		}
		this.getParenResIds(resIds , resIds);//将所有选中的菜单的所有父菜单id查询出来
		List<SysRoleResourceKey> list = new ArrayList<SysRoleResourceKey>();
		if(resIds!=null && !resIds.isEmpty()){
			for(Long resId : resIds){
				SysRoleResourceKey one = new SysRoleResourceKey();
				one.setResId(resId);
				one.setRoleId(record.getRoleId());
				list.add(one);
			}
			if(list!=null && list.size()>0){
				sysRoleResourceDao.insertBatch(list);//新权限列表
			}
		}
	}
	
	public void getParenResIds(List<Long> resIds , List<Long> all){
	    if(resIds==null || resIds.isEmpty()){
	        return;
	    }
	    List<Long> parentFuncIds = sysResourceDao.getParenResIds(resIds);
	    if(parentFuncIds!=null && parentFuncIds.size()>0){
	        for(Long one : parentFuncIds){
	            if(!all.contains(one)){
	                all.add(one);//排除已经存在的
	            }
	        }
	        this.getParenResIds(parentFuncIds, all);//递归
	    }
	}

	@Override
	public List<Map<String, String>> getAllRole(String q) {
		return sysRoleDao.getAllRole(q);
	}

	@Override
	public Map<Long, Set<String>> getRoleRess() {
		List<SysRoleResourceKey> list = sysRoleResourceDao.getRoleRess();
		Map<Long ,Set<String>> map = null;
	    Set<String> set = null;
	    if(list!=null && !list.isEmpty()){
	        map = new HashMap<Long ,Set<String>>();
	        set = new HashSet<String>();
	        Long oldRoldId = list.get(0).getRoleId();
	        map.put(oldRoldId, set);
	        for(SysRoleResourceKey one : list){
	            if(oldRoldId.equals(one.getRoleId())){
	                set.add(one.getResUrl());//同一角色拥有的权限url
	            }
	            else{
	                //创建新的角色set
	                oldRoldId = one.getRoleId();//另外一个角色的id
	                set = new HashSet<String>();
	                set.add(one.getResUrl());
	                map.put(oldRoldId, set);
	            }
	        }	        
	    }
	    return map;
	}
	
	
	
}
