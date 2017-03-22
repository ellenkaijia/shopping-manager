package com.manager.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.manager.constant.Log4jSuper;
import com.manager.dao.SysLogDao;
import com.manager.model.admin.SysLog;
import com.manager.service.ISysLogService;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;
import com.server.api.util.DateUtils;


@Service
public class SysLogServiceImpl extends Log4jSuper implements ISysLogService {

	@Resource
    SysLogDao sysLogDao;
	
	public int insertSelective(SysLog record){
	    return sysLogDao.insertSelective(record);
	}
	
	public DataGrid dataGrid(SysLog condi, Page page) {
	    if(condi.getCreateTimeTo()!=null){
	        condi.setCreateTimeTo(DateUtils.nextDays(condi.getCreateTimeTo(), 1));
	    }
	    page.setParams(condi);
		List<SysLog> list = sysLogDao.dataGrid(page);
		return Page.getDataGrid(page, list, null);
	}

	public SysLog getByKey(Long logId) {
		return sysLogDao.selectByPrimaryKey(logId);
	}


}
