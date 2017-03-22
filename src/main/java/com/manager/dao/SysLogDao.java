package com.manager.dao;

import java.util.List;

import com.manager.model.admin.SysLog;
import com.server.api.easyui.Page;


public interface SysLogDao {
	
    int insert(SysLog record);

    int insertSelective(SysLog record);

    SysLog selectByPrimaryKey(Long logId);

    List<SysLog> dataGrid(Page<SysLog> page);
    
}