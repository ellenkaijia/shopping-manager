package com.manager.service.product;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public interface ProductService {

	/**
	 * 存储产品的图片
	 * @param files
	 * @return
	 */
	boolean createProductPic(CommonsMultipartFile[] files, String prodId);
}
