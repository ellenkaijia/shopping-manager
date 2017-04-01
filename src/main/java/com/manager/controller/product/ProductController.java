package com.manager.controller.product;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.manager.controller.base.BaseController;
import com.manager.controller.base.ResultInfo;
import com.manager.product.dto.ProductDTO;
import com.manager.service.product.ProductService;
import com.mhdq.manager.api.service.product.ProductMsService;
import com.mhdq.rpc.RpcCommonConstant;
import com.mhdq.rpc.RpcRespDTO;
import com.server.api.easyui.DataGrid;
import com.server.api.easyui.Page;

@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductMsService productMsService;
	
	@RequestMapping("/createProduct")
	@ResponseBody
	public ResultInfo createProduct(@RequestParam("file") CommonsMultipartFile[] files, ProductDTO productDTO) {
		logger.info("***********正在调用createProduct的Controller**********");
		ResultInfo resultInfo = new ResultInfo();
		RpcRespDTO<String> rpcResult = productMsService.createPrpduct(productDTO);
		if(rpcResult.getCode().equals(RpcCommonConstant.CODE_SUCCESS)) {
			String prodId = rpcResult.getData();
			logger.info("prodId:" + prodId);
			if(productService.createProductPic(files,prodId)) {
				logger.info("***********保存成功**********");
				resultInfo.setCode(1);
				resultInfo.setMessage("保存成功");
				return resultInfo;
			} else {
				logger.info("***********保存图片时出错**********");
				resultInfo.setCode(1);
				resultInfo.setMessage("保存图片时出错");
				return resultInfo;
			}
			
		} else {
			logger.info(rpcResult.getMsg());
			resultInfo.setCode(1);
			resultInfo.setMessage(rpcResult.getMsg());
			return resultInfo;
		}
		
	}
	@RequestMapping("/dataGrid")
	@ResponseBody
	public DataGrid dataGrid(ProductDTO productDTO, Page page) {
		DataGrid dataGrid = productMsService.dataGrid(productDTO, page);
		return dataGrid;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ResultInfo productDelete(@RequestParam("prodId") String productId) {
		RpcRespDTO<Integer> respDTO = productMsService.deleteProduct(productId);
		if (RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
				boolean result = productService.deleteProductPic(productId);
				if(result) {
					return this.success();
				}
			} else {
				this.fail("没有删除对应的记录，可能找不到对应的记录");
			}
		} else {
			return this.fail(respDTO.getMsg());
		}
		return this.fail("删除照片失败");
	}
	
	
	@RequestMapping("/update")
	@ResponseBody
	public ResultInfo updateProduct(ProductDTO productDTO) {
		RpcRespDTO<Integer> respDTO = productMsService.updateProduct(productDTO);
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
	
	@RequestMapping("/release")
	@ResponseBody
	public ResultInfo releaseProduct(@RequestParam("prodId") String productId) {
		RpcRespDTO<Integer> respDTO = productMsService.releaseProduct(productId);
		if (RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
				return this.success();
			} else {
				this.fail("没有发布成功，可能找不到对应的记录");
			}
		} else {
			return this.fail(respDTO.getMsg());
		}
		return null;
	}
	
	@RequestMapping("/show")
	@ResponseBody
	public ProductDTO showProduct(@RequestParam("id") Long id) {
		return productMsService.showProduct(id);
	}
	

}
