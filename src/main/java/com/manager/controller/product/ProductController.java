package com.manager.controller.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.manager.controller.base.BaseController;
import com.manager.product.dto.ProductDTO;
import com.manager.service.product.ProductService;
import com.mhdq.manager.api.service.product.ProductMsService;
import com.mhdq.rpc.RpcCommonConstant;
import com.mhdq.rpc.RpcRespDTO;

@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductMsService productMsService;
	
	@RequestMapping("/createProduct")
	public String createProduct(@RequestParam("file") CommonsMultipartFile[] files, ProductDTO productDTO, ModelAndView modelAndView) {
		
		
		RpcRespDTO<String> rpcResult = productMsService.createPrpduct(productDTO);
		if(rpcResult.getCode().equals(RpcCommonConstant.CODE_SUCCESS)) {
			String prodId = rpcResult.getData();
			if(productService.createProductPic(files,prodId)) {
				modelAndView.addObject("code", "000000");
				modelAndView.addObject("message", "保存成功");
				return "/product/addProduct";
			} else {
				modelAndView.addObject("code", "000001");
				modelAndView.addObject("message", "保存图片出错");	
				return "/product/addProduct";
			}
			
		} else {
			modelAndView.addObject("code", "000002");
			modelAndView.addObject("message", rpcResult.getMsg());	
			return "/product/addProduct";
		}
		
	}

}
