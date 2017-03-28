package com.manager.service.impl;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.manager.controller.base.BaseController;
import com.manager.dao.SysResourceDao;
import com.manager.dao.SysRoleResourceDao;
import com.manager.exception.ServiceException;
import com.manager.json.JacksonUtils;
import com.manager.model.admin.SysResource;
import com.manager.model.admin.SysRoleResourceKey;
import com.manager.service.ISysResourceService;
import com.manager.service.ISysRoleService;
import com.manager.util.ZcRandomUtil;

@Service
public class SysResourceServiceImpl implements ISysResourceService {

	@Autowired
	ISysRoleService sysRoleService;
	@Resource
	SysRoleResourceDao sysRoleResourceDao;
	@Resource
	SysResourceDao sysResourceDao;

	@Override
	public List<SysResource> treeGrid(Integer resStatus) {
		return sysResourceDao.getRessByCondi(null, null, null, resStatus, null);
	}

	@Override
	public List<SysResource> resParentIdCombotree() {
		return sysResourceDao.resParentIdCombotree();
	}

	@Override
	public void create(SysResource record, HttpSession session) throws Exception {
		sysResourceDao.insertSelective(record);
	}

	@Override
	public void edit(SysResource record, HttpSession session) throws Exception {
		sysResourceDao.updateByPrimaryKey(record);
	}

	@Override
	public void delete(Long resId, HttpSession session) throws Exception {
		BaseController.isSuperAdmin(session);// 只有超级管理员才能删除资源
		Set<Long> toBeDeleteSet = new HashSet<Long>();
		getResIdsToDelete(resId, toBeDeleteSet);
		if (toBeDeleteSet != null && !toBeDeleteSet.isEmpty()) {
			sysResourceDao.deleteByPrimaryKeyBatch(toBeDeleteSet);// 删除该资源及其子资源id
			sysRoleResourceDao.deleteByResIdBatch(toBeDeleteSet);// 删除角色、资源关联记录
		}
	}

	private void getResIdsToDelete(Long resId, Set<Long> toBeDeleteSet) {
		if (toBeDeleteSet == null) {
			toBeDeleteSet = new HashSet<Long>();// 要删除的菜单id集合
		}
		if (!toBeDeleteSet.contains(resId)) {
			toBeDeleteSet.add(resId);
		}
		// 删除功能的子功能
		List<SysResource> childList = sysResourceDao.getRessByCondi(null, null, null, null, resId);
		if (childList != null && !childList.isEmpty()) {
			for (SysResource one : childList) {
				getResIdsToDelete(one.getResId(), toBeDeleteSet);
			}
		}
	}

	@Override
	public List<SysResource> exportMenu() {
		List<SysResource> firstMenu = sysResourceDao.getFirstRess();
		if (firstMenu != null && !firstMenu.isEmpty()) {
			for (SysResource one : firstMenu) {
				getChildList(one);
				one.setResId(null);
			}
		}
		return firstMenu;
	}

	private void getChildList(SysResource parent) {
		if (parent == null || parent.getResId() == null) {
			return;
		}
		List<SysResource> childList = sysResourceDao.getRessByCondi(null, null, null, null, parent.getResId());
		if (childList != null && !childList.isEmpty()) {
			parent.setChildList(childList);
			for (SysResource one : childList) {
				getChildList(one);
				one.setResId(null);
			}
		}
	}

	@Override
	public void importMenu(MultipartFile importMenuFile, HttpSession session) throws Exception {
		// 只有超级管理员才能导入资源
		BaseController.isSuperAdmin(session);
		if (importMenuFile == null || importMenuFile.getSize() < 1) {
			throw new ServiceException("文件内容为空");
		}
		String menuContent = new String(importMenuFile.getBytes(), "UTF8");
		List<SysResource> list = JacksonUtils.jsonListUnSerializer(menuContent, SysResource.class);
		if (list != null && !list.isEmpty()) {

			// 1.获取旧角色的权限，导入后保持原有权限不变Map<角色id , Set<角色权限url>>
			Map<Long, Set<String>> oldRoleRess = sysRoleService.getRoleRess();// 获取旧的角色的权限，导入菜单后，保持原角色/角色的权限不变

			// 2.清除菜单数据、角色/角色的权限数据
			sysResourceDao.deleteAll();
			sysRoleResourceDao.deleteAll();// 先清空旧的角色-菜单数据

			// 3.导入新的菜单数据
			for (SysResource one : list) {
				insertMenus(one);// 导入新菜单
			}

			// 4.维护新的角色-权限关联关系，因为权限id更改了
			obtainRoleRess(oldRoleRess);

		}
	}

	/** 维护原有的角色/角色所拥有的权限 */
	private void obtainRoleRess(Map<Long, Set<String>> map) {
		if (map == null || map.isEmpty()) {
			return;
		}
		for (Long roleId : map.keySet()) {
			Set<String> set = map.get(roleId);// 该角色原来所拥有的权限url
			if (set == null || set.isEmpty()) {
				continue;
			}
			List<Long> roleRess = new ArrayList<Long>();// 因菜单id改变，该角色的拥有的菜单权限的id也变
			for (String one : set) {
				List<Long> ccfIds = sysResourceDao.getByResUrl(one.trim());
				if (ccfIds != null && !ccfIds.isEmpty()) {
					for (Long id : ccfIds) {
						if (!roleRess.contains(id)) {
							roleRess.add(id);
						}
					}
				}
			}
			this.getParenMenuIds(roleRess, roleRess);
			if (roleRess != null && !roleRess.isEmpty()) {
				List<SysRoleResourceKey> srrList = new ArrayList<SysRoleResourceKey>();// 角色权限列表
				for (Long resId : roleRess) {
					SysRoleResourceKey srr = new SysRoleResourceKey();
					srr.setRoleId(roleId);
					srr.setResId(resId);
					srrList.add(srr);
				}
				sysRoleResourceDao.insertBatch(srrList);// 给所有角色主管赋最大权限，除菜单管理相关权限外。
			}
		}
	}

	private void getParenMenuIds(List<Long> resIds, List<Long> all) {
		if (resIds == null || resIds.isEmpty()) {
			return;
		}
		List<Long> parentFuncIds = sysResourceDao.getParenMenuIds(resIds);
		if (parentFuncIds != null && parentFuncIds.size() > 0) {
			for (Long one : parentFuncIds) {
				if (!all.contains(one)) {
					all.add(one);// 排除已经存在的
				}
			}
			this.getParenMenuIds(parentFuncIds, all);// 递归
		}
	}

	/** 插入菜单至数据库，保持原有的父子关系。 */
	private void insertMenus(SysResource parent) {
		if (parent == null) {
			return;
		}
		sysResourceDao.insertSelective(parent);// 增加菜单项
		if (parent.getChildList() != null && !parent.getChildList().isEmpty()) {
			for (SysResource child : parent.getChildList()) {
				child.setResParentId(parent.getResId());
				insertMenus(child);
			}
		}
	}
	
	public static void main(String args[]) {
		
		File file = new File("F:\\neo4j");
		File exportFile = new File("F:\\neo4j\\zhaokaijiaR.csv");
		file.mkdir();
		FileWriter fileWriter = null;
		if(!exportFile.exists()) {
			try {
				fileWriter = new FileWriter(exportFile, false);
				exportFile.createNewFile();
				Random random = new Random();
				StringBuffer stringBuffer = new StringBuffer();
			//	stringBuffer.append("id" + "," + "weight" + "," + "name" + "\r\n");
				for(int i=1; i<=10000; i++) {
					stringBuffer.append("" + (random.nextInt(999) + 1)  + ",");
					stringBuffer.append("" + (random.nextInt(999) + 1));
					stringBuffer.append("\r\n");
			//		stringBuffer.append("\"" + ZcRandomUtil.generateAllLowerString(8)  + "\"" + "\r\n");
				}
				fileWriter.write(stringBuffer.toString());
				
				
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					fileWriter.flush();
					fileWriter.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
		}
	}
}
