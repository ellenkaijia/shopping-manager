package com.manager.service;

import com.manager.model.admin.SysLog;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;

public interface ISysLogService {

    int insertSelective(SysLog record);
    
	DataGrid dataGrid(SysLog condi , Page page);
	
	SysLog getByKey(Long logId);
	
}
