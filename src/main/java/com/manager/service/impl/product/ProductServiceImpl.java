package com.manager.service.impl.product;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.manager.product.dto.ProductResDTO;
import com.manager.service.product.ProductService;
import com.manager.util.PropertiesUtil;
import com.mhdq.manager.api.service.productres.ProductResMsService;
import com.mhdq.rpc.RpcCommonConstant;
import com.mhdq.rpc.RpcRespDTO;
import com.server.api.util.GenerateCode;

@Service
public class ProductServiceImpl implements ProductService {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private PropertiesUtil propertiesUtil;
	
	@Autowired
	private ProductResMsService productResMsService;
	
	@Override
	public boolean createProductPic(CommonsMultipartFile[] files, String prodId) {
		
		FileOutputStream fileOutputStream = null;
		FileInputStream fileInputStream = null;
		File parentFolder = new File(propertiesUtil.getProperties().getProperty("product_file_path"));
		if(!parentFolder.exists()) {  //创建放图片的目录
			parentFolder.mkdirs();
		}
		List<ProductResDTO> list = new ArrayList<>();
		int isHave = 0;  //是否有图片传过来
		String parentResId = GenerateCode.generateResIdCode();
		File parentFile = new File(parentFolder.getAbsolutePath() + File.separator + parentResId);
		if(!parentFile.exists()) {
			parentFile.mkdirs();
		}
		for(int i=0; i<files.length; i++) {
			logger.info("fileName---------->" + files[i].getOriginalFilename());  //输出文件的名字
			//对有图片的进行处理
			if(!files[i].isEmpty()) {
				isHave ++ ;
				String subResId = GenerateCode.generateResIdCode();
				try {
					
					//拿到输出流，同时重命名上传的文件  
					fileOutputStream = new FileOutputStream(parentFile.getAbsolutePath() + File.separator + subResId + ".jpg");  
					//拿到上传文件的输入流  
					fileInputStream = (FileInputStream) files[i].getInputStream();  
					
					//以写字节的方式写文件  
					int b = 0;  
					while((b=fileInputStream.read()) != -1){  
						fileOutputStream.write(b);  
					} 
					ProductResDTO productResDTO = new ProductResDTO();
					productResDTO.setProdId(prodId);
					productResDTO.setResId(subResId);
					productResDTO.setResParentId(parentResId);
					list.add(productResDTO);
					
					 
				} catch (Exception e) {
					logger.error(e.getMessage());
					return false;
				} finally {
					try {
						fileOutputStream.flush();
						fileOutputStream.close();  
						fileInputStream.close(); 
					} catch (IOException e) {
						e.printStackTrace();
					}  
				}
			}
			
		}
		if(isHave != 0) {
			ProductResDTO productResDTO = new ProductResDTO();
			productResDTO.setProdId(prodId);
			productResDTO.setResId(parentResId);
			productResDTO.setResParentId(null);
			list.add(productResDTO);
		}
		
		if(list.size() != 0) {
			RpcRespDTO<Integer> result = productResMsService.createProductRes(list);
			if(result.getCode().equals(RpcCommonConstant.CODE_SUCCESS)) {
				return true;
			}
		}
		return true;
	}


}
