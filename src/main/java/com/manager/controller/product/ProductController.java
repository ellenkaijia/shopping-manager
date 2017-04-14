package com.manager.controller.product;

import java.util.List;

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
import com.manager.product.dto.ProductBandDTO;
import com.manager.product.dto.ProductDTO;
import com.manager.product.dto.SortDTO;
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
		RpcRespDTO<String> rpcResult = productMsService.createPrpduct(productDTO);
		if(rpcResult.getCode().equals(RpcCommonConstant.CODE_SUCCESS)) {
			String prodId = rpcResult.getData();
			logger.info("prodId:" + prodId);
			if(productService.createProductPic(files,prodId)) {
				logger.info("***********保存成功**********");
				return this.success();
			} else {
				logger.info("***********保存图片时出错**********");
				return this.fail("保存图片时出错");
			}
			
		} else {
			logger.info(rpcResult.getMsg());
			return this.fail(rpcResult.getMsg());
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
		boolean result = productService.deleteProductPic(productId);
		RpcRespDTO<Integer> respDTO = productMsService.deleteProduct(productId);
		if (RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
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
	
	@RequestMapping("/addBand")
	@ResponseBody
	public ResultInfo addBand(@RequestParam("file") CommonsMultipartFile file, ProductBandDTO productBandDTO) {
		RpcRespDTO<String> respDTO = productMsService.addBand(productBandDTO);
		if (RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			String bandId = respDTO.getData();
			if(bandId == null) {
				return this.fail("保存失败");
			}
			logger.info("bandId:" + bandId);
			if(productService.createBandPic(file, bandId)) {
				logger.info("***********保存成功**********");
				return this.success();
			} else {
				return this.fail("保存图片失败");
			}
			
		} else {
			return this.fail(respDTO.getMsg());
		}
	}
	
	@RequestMapping("/showBand")
	@ResponseBody
	public DataGrid showBand(ProductBandDTO productBandDTO, Page page) {
		return productMsService.showBand(productBandDTO, page);
	}
	
	
	@RequestMapping("/getBand")
	@ResponseBody
	public List<ProductBandDTO> getProductBandList() {
		return productMsService.getProductBandList();
	}
	
	@RequestMapping("/gonew")
	@ResponseBody
	public ResultInfo gonew(@RequestParam("id") Long id) {
		RpcRespDTO<Integer> respDTO = productMsService.gonew(id);
		if(RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
				return this.success();
			} else {
				return this.fail("上新品失败");
			}
		} else {
			return this.fail("上新品服务后台失败");
		}
	}
	
	@RequestMapping("/cacelgonew")
	@ResponseBody
	public ResultInfo cacelgonew(@RequestParam("id") Long id) {
		RpcRespDTO<Integer> respDTO = productMsService.cacelgonew(id);
		if(RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
				return this.success();
			} else {
				return this.fail("取消上新品失败");
			}
		} else {
			return this.fail("取消上新品服务后台失败");
		}
	}
	
	@RequestMapping("/gohot")
	@ResponseBody
	public ResultInfo gohot(@RequestParam("id") Long id) {
		RpcRespDTO<Integer> respDTO = productMsService.gohot(id);
		if(RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
				return this.success();
			} else {
				return this.fail("上热搜失败");
			}
		} else {
			return this.fail("上热搜服务后台失败");
		}
	}
	
	@RequestMapping("/cacelgohot")
	@ResponseBody
	public ResultInfo cacelgohot(@RequestParam("id") Long id) {
		RpcRespDTO<Integer> respDTO = productMsService.cacelgohot(id);
		if(RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			if(respDTO.getData() == 1) {
				return this.success();
			} else {
				return this.fail("取消上热搜失败");
			}
		} else {
			return this.fail("取消上热搜服务后台失败");
		}
	}
	
	@RequestMapping("/addSort")
	@ResponseBody
	public ResultInfo addSort(@RequestParam("file") CommonsMultipartFile file, SortDTO sortDTO) {
		RpcRespDTO<String> respDTO = productMsService.addSort(sortDTO);
		if (RpcCommonConstant.CODE_SUCCESS.equals(respDTO.getCode())) {
			String sortId = respDTO.getData();
			if(sortId == null) {
				return this.fail("保存失败");
			}
			logger.info("sortId:" + sortId);
			if(productService.createSortPic(file, sortId)) {
				logger.info("***********保存成功**********");
				return this.success();
			} else {
				return this.fail("保存图片失败");
			}
			
		} else {
			return this.fail(respDTO.getMsg());
		}
	}
	
	@RequestMapping("/showSort")
	@ResponseBody
	public DataGrid showSort(SortDTO sortDTO, Page page) {
		return productMsService.showSort(sortDTO, page);
	}
	
	@RequestMapping("/getSort")
	@ResponseBody
	public List<SortDTO> getProductSortList() {
		return productMsService.getProductSortList();
	}

}
