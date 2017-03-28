package com.manager.util;

import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

/**  
* 读取配置文件 
*  
* @author zkj  
* @date 2017年3月27日  新建  
*/
@Component
public class PropertiesUtil implements InitializingBean {

	private Properties properties;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public void afterPropertiesSet() throws Exception {
		this.properties = new Properties();
		 try {
			 	properties.load(this.getClass().getClassLoader().getResourceAsStream("config/path.properties"));
	        } catch (IOException e) {
	            log.error(e.getMessage(),e);
	        }
	}
	
 	
	public Properties getProperties() {
		return properties;
	}
	
}
