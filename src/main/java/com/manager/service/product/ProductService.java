package com.manager.service.product;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public interface ProductService {

	/**
	 * 存储产品的图片
	 * @param files
	 * @return
	 */
	boolean createProductPic(CommonsMultipartFile[] files, String prodId);
	
	/**
	 * 删除照片通过产品的id
	 * @param prodId
	 * @return
	 */
	boolean deleteProductPic(String prodId);
	
	/**
	 * 存储品牌的图片
	 * @param file
	 * @param bandId
	 * @return
	 */
	boolean createBandPic(CommonsMultipartFile file, String bandId);
	
	boolean createSortPic(CommonsMultipartFile file, String bandId);
	
	
}
