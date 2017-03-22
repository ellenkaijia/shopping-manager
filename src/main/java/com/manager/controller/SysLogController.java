package com.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.manager.controller.base.BaseController;
import com.manager.model.admin.SysLog;
import com.manager.service.ISysLogService;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;


@Controller
@RequestMapping("/sysLog")
public class SysLogController extends BaseController {

	@Autowired
	ISysLogService sysLogService;
	
	@RequestMapping("/dataGrid")
	@ResponseBody
	public DataGrid dataGrid(SysLog condi , Page page){
		return sysLogService.dataGrid(condi, page);
	}
	
	@RequestMapping("/getByKey")
	@ResponseBody
	public SysLog getByKey(Long logId){
		return sysLogService.getByKey(logId);
	}
	
}
