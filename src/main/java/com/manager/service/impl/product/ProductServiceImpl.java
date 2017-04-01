package com.manager.service.impl.product;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
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
		InputStream inputStream = null;
		File parentFolder = new File(propertiesUtil.getProperties().getProperty("product_file_path"));
		if (!parentFolder.exists()) { // 创建放图片的目录
			parentFolder.mkdirs();
		}
		List<ProductResDTO> list = new ArrayList<>();
		int isHave = 0; // 是否有图片传过来
		String parentResId = GenerateCode.generateResIdCode();
		File parentFile = new File(parentFolder.getAbsolutePath() + File.separator + parentResId);
		if (!parentFile.exists()) {
			parentFile.mkdirs();
		}
		for (int i = 0; i < files.length; i++) {
			logger.info("fileName---------->" + files[i].getOriginalFilename()); // 输出文件的名字
			// 对有图片的进行处理
			if (!files[i].isEmpty()) {
				isHave++;
				String subResId = GenerateCode.generateResIdCode();
				try {

					// 拿到输出流，同时重命名上传的文件
					fileOutputStream = new FileOutputStream(
							parentFile.getAbsolutePath() + File.separator + subResId + ".jpg");
					// 拿到上传文件的输入流
					inputStream = files[i].getInputStream();

					// 以写字节的方式写文件
					int b = 0;
					while ((b = inputStream.read()) != -1) {
						fileOutputStream.write(b);
					}
					ProductResDTO productResDTO = new ProductResDTO();
					productResDTO.setProdId(prodId);
					productResDTO.setResId(subResId);
					productResDTO.setResSeq(isHave + 1);
					productResDTO.setResParentId(parentResId);
					list.add(productResDTO);

				} catch (Exception e) {
					logger.error(e.getMessage());
					return false;
				} finally {
					try {
						fileOutputStream.flush();
						fileOutputStream.close();
						inputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

		}
		if (isHave != 0) {
			ProductResDTO productResDTO = new ProductResDTO();
			productResDTO.setProdId(prodId);
			productResDTO.setResId(parentResId);
			productResDTO.setResSeq(0);
			productResDTO.setResParentId(null);
			list.add(productResDTO);
		}

		if (list.size() != 0) {
			RpcRespDTO<Integer> result = productResMsService.createProductRes(list);
			if (result.getCode().equals(RpcCommonConstant.CODE_SUCCESS)) {
				return true;
			}
		}
		return true;
	}

	@Override
	public boolean deleteProductPic(String prodId) {
		List<ProductResDTO> list = productResMsService.getProductResList(prodId);
		if (CollectionUtils.isEmpty(list)) {
			return true;
		} else {
			String parentPath = propertiesUtil.getProperties().getProperty("product_file_path");
			StringBuffer deletePath = new StringBuffer(parentPath);
			File deleteFile = null;
			deletePath.append(File.separator).append(list.get(0).getResId());
			deleteFile = new File(deletePath.toString());
			return this.deleteDir(deleteFile);
		}

	}

	/**
	 * 递归删除文件夹
	 * @param dir
	 * @return
	 */
	private boolean deleteDir(File dir) {
		if(dir.isDirectory()) {
			String[] children = dir.list();
			for(int i=0; i<children.length; i++) {
				boolean success = deleteDir(new File(dir,children[i]));
				if(!success){
					return false;
				}
			}
		}
		return dir.delete();
	}

}
