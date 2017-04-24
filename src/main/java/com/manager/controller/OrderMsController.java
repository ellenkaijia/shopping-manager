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
import com.manager.product.dto.MOrderInfoShowDTO;
import com.mhdq.manager.api.service.OrderMsService;
import com.mhdq.rpc.RpcCommonConstant;
import com.mhdq.rpc.RpcRespDTO;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;

/**  
* 类说明   
*  
* @author zkj  
* @date 2017年4月23日  新建  
*/
@Controller
@RequestMapping("/order")
public class OrderMsController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private OrderMsService orderMsService;
	
	@RequestMapping("/orderList")
	@ResponseBody
	DataGrid getOrderList(MOrderInfoShowDTO mOrderInfoShowDTO, Page page) {
		return orderMsService.getOrderList(mOrderInfoShowDTO, page);
		 
	}
	
	/**
	 * 确认订单已经收到看到
	 * @param id
	 * @return
	 */
	@RequestMapping("/changeOrderStatusOne")
	@ResponseBody
	public ResultInfo changeOrderStatusOne(@RequestParam("id") Long id) {
		RpcRespDTO<Integer> respDTO = orderMsService.changeOrderStatusOne(id);
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
	
	/**
	 * 变成交易完成
	 * @param id
	 * @return
	 */
	@RequestMapping("/changeOrderStatusThree")
	@ResponseBody
	public ResultInfo changeOrderStatusThree(@RequestParam("id") Long id) {
		RpcRespDTO<Integer> respDTO = orderMsService.changeOrderStatusThree(id);
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
