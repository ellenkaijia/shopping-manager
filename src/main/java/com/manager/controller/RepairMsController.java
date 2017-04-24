package com.manager.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.manager.controller.base.BaseController;
import com.manager.controller.base.ResultInfo;
import com.manager.product.dto.MRepairInfoDTO;
import com.manager.product.dto.MRepairInfoShowDTO;
import com.mhdq.manager.api.service.RepairMsService;
import com.mhdq.rpc.RpcCommonConstant;
import com.mhdq.rpc.RpcRespDTO;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;

/**  
* 类说明   
*  
* @author zkj  
* @date 2017年4月24日  新建  
*/
@Controller
@RequestMapping("/repair")
public class RepairMsController extends BaseController {
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private RepairMsService repairMsService;
	
	@RequestMapping("/getRepairList")
	@ResponseBody
	public DataGrid getRepairList(MRepairInfoDTO mrepairInfoDTO, Page page) {
		log.info("*******getRepairList方法获取********");
		return repairMsService.getRepairList(mrepairInfoDTO, page);
	}
	
	@RequestMapping("/changeRepairStatusOne")
	@ResponseBody
	public ResultInfo changeRepairStatusOne(@RequestParam("id") Long id) {
		RpcRespDTO<Integer> respDTO = repairMsService.changeRepairStatusOne(id);
		if (RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
				return this.success();
			} else {
				this.fail("没有更新到对应的记录，可能找不到对应的记录");
			}
		} else {
			return this.fail(respDTO.getMsg());
		}
		return null;
	}

}
