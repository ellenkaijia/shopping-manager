package com.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.manager.product.dto.MAddressInfoDTO;
import com.manager.product.dto.UserInfoDTO;
import com.mhdq.manager.api.service.UserMsService;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;

/**  
* 类说明   
*  
* @author zkj  
* @date 2017年4月20日  新建  
*/
@Controller
@RequestMapping("/user")
public class UserMsController {

	@Autowired
	private UserMsService userMsService;
	
	@RequestMapping("/dataGrid")
	@ResponseBody
	public DataGrid dataGrid(UserInfoDTO userInfoDTO, Page page) {
		DataGrid dataGrid = userMsService.dataGrid(userInfoDTO, page);
		return dataGrid;
	}
	
	@RequestMapping("/addressList")
	@ResponseBody
	public DataGrid addressList(MAddressInfoDTO maddressInfoDTO, Page page) {
		DataGrid dataGrid = userMsService.addressList(maddressInfoDTO, page);
		return dataGrid;
	}
}
