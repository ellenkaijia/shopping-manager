package com.manager.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.manager.dao.login.LoginDao;
import com.manager.entity.login.LoginEntity;
import com.manager.service.LoginService;

@Service
public class LoginServiceImpl implements LoginService {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private LoginDao loginDao;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void test() throws Exception {
		logger.info("loginservice来了");
		LoginEntity loginEntity = new LoginEntity();
		loginEntity.setName("陈倩婷");
		loginEntity.setPassword("cqt");
		int i = loginDao.insert(loginEntity);
		logger.info("***********插入的记录数为{} *********",i);
		
	}

}
