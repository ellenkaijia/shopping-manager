package com.manager.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.manager.service.LoginService;
import com.mhdq.manager.api.service.LoginMsService;

@Controller
@RequestMapping("/loginControl")
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private LoginMsService loginMsService;
	@Autowired
	private LoginService loginService;
	
	@RequestMapping("/login")
	@ResponseBody
    public String login() {
		logger.info("dsahjdhjaskdhjksahk");
		loginMsService.sayHello("zhaokaijia");
		try {
			loginService.test();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "login";
    }
}
