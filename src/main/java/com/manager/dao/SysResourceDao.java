package com.manager.dao;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.manager.model.admin.SysResource;
import com.server.api.easyui.Page;

public interface SysResourceDao {

	int deleteByPrimaryKey(Long resId);

	int insert(SysResource record);

	int insertSelective(SysResource record);

	SysResource selectByPrimaryKey(Long resId);

	int updateByPrimaryKeySelective(SysResource record);

	int updateByPrimaryKey(SysResource record);

	List<SysResource> dataGrid(Page<SysResource> page);

	/***
	 * 获取员工拥有的资源列表，order by r.res_parent_id, r.RES_SEQ , r.res_id
	 * 
	 * @param userId
	 *            为空时查询所有菜单（不包括操作），相当于超级管理员
	 * @param resType
	 *            资源类型，1-菜单，2-操作
	 * @param resStatus
	 *            资源状态，1-有效，2-无效
	 * @return
	 */
	List<SysResource> getRessByCondi(@Param("roleId") Long roleId, @Param("userId") Long userId,
			@Param("resType") Integer resType, @Param("resStatus") Integer resStatus,
			@Param("resParentId") Long resParentId);

	List<SysResource> resParentIdCombotree();

	List<Long> getParenResIds(@Param("list") List<Long> childIds);

	int deleteByPrimaryKeyBatch(@Param("set") Set<Long> resIds);

	List<SysResource> getFirstRess();

	List<Long> getByResUrl(@Param("url") String url);

	List<Long> getParenMenuIds(@Param("list") List<Long> resIds);

	/** 此方法慎用，清除所有资源数据 */
	void deleteAll();
}
