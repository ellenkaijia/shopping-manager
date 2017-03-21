package com.manager.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.manager.constant.DBConstant;
import com.manager.dao.SysResourceDao;
import com.manager.dao.SysUserDao;
import com.manager.exception.ServiceException;
import com.manager.filter.PrivilegeFilter;
import com.manager.model.admin.SysResource;
import com.manager.model.admin.SysUser;
import com.manager.pojo.RetryPojo;
import com.manager.service.ISysUserService;
import com.manager.util.MD5Utils;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;

@Service
public class SysUserServiceImpl implements ISysUserService {

	@Autowired
	SysUserDao sysUserDao;
	
	@Autowired
	SysResourceDao sysResourceDao;

	private int defaultLockTime = 10 * 60; // 超过最大重试次数时，默认锁定时间
	private int retryMax = 5; // 一个账号最多重试次数
	private int ipRetryMax = 20; // 同一个ip最多重试次数
	private Map<String, RetryPojo> retryCache = new HashMap<String, RetryPojo>();

	@Override
	public SysUser login(SysUser param, String ip) throws Exception {
		List<SysUser> list = sysUserDao.getByUserName(param.getUserName());
		SysUser user = null;

		retryValidate(param.getUserName(), ip); // 校验重试次数

		if (list == null || list.isEmpty() || list.size() > 1
				|| !list.get(0).getUserPwd().equals(MD5Utils.MD5Encode(param.getUserPwd() + param.getUserName()))) {
			retryIncement(param.getUserName(), ip);
			throw new ServiceException("账号或密码错误");
		} else {
			retryCache.remove(param.getUserName());
			retryCache.remove(ip);
			user = list.get(0);
			user.setUserPwd(null); // 清除密码值，防止在页面用EL表达式查看
			boolean isSuperAdmin = PrivilegeFilter.isSuperAdmin(user);
			// 查询此员工拥有的所有资源，
			List<SysResource> userRess = sysResourceDao.getRessByCondi(null, isSuperAdmin ? null : user.getUserId(),
					null, DBConstant.STATUS_NORMAL, null);
			user.setUserMenus(userRess);// 设置此员工的菜单树，以及拥有的url集合（实际操作时校验每个url的权限）
		}
		return user;
	}

	@Override
	public DataGrid dataGrid(SysUser condi, Page page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SysUser> getByUserName(String userName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SysUser> getUserName(SysUser record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void create(SysUser record) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void edit(SysUser record, SysUser currentUser) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(Long userId) throws Exception {
		// TODO Auto-generated method stub

	}

	private void retryValidate(String userName, String ip) throws Exception {

		long current = (new Date()).getTime() / 1000; // 秒

		RetryPojo retry = retryCache.get(userName);
		if (retry != null) {
			if (retry.getRetry() > this.retryMax && (current - retry.getLockStartTime()) < this.defaultLockTime) {
				throw new ServiceException("连续错误" + this.retryMax + "次，锁定" + defaultLockTime + "秒");
			}
		}

		RetryPojo ipRetry = retryCache.get(ip);
		if (ipRetry != null) {
			if (ipRetry.getRetry() > this.ipRetryMax && (current - ipRetry.getLockStartTime()) < this.defaultLockTime) {
				throw new ServiceException("同一IP连续错误" + this.ipRetryMax + "次，此IP锁定" + this.defaultLockTime + "秒");
			}
		}
	}

	private void retryIncement(String userName, String ip) {
		RetryPojo retry = retryCache.get(userName);
		if (retry != null) {
			retry.retryAutoIncre(); // 自增1
		} else {
			retry = new RetryPojo();
			retryCache.put(userName, retry);
		}

		RetryPojo ipPojo = retryCache.get(ip);
		if (ipPojo != null) {
			ipPojo.retryAutoIncre(); // 自增1
		} else {
			ipPojo = new RetryPojo();
			retryCache.put(ip, ipPojo);
		}
	}

}
