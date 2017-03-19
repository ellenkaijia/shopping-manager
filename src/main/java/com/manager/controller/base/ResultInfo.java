package com.manager.controller.base;


import java.io.Serializable;

import com.manager.constant.ConsoleConstants;


/**
 * 请求结果封装模型
 * @author zkj
 * @date 2017年3月19日
 */
public class ResultInfo implements Serializable{
    
    private static final long serialVersionUID = -7809954899845836239L;
    
    private Integer code = ConsoleConstants.RESULT_CODE_FAILED; // 1-成功，其他为失败
    private String message = "失败";
    private Object data = null;
    
	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
	
}
