package com.manager.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mhdq.manager.api.service.LoginMsService;

@Controller
@RequestMapping("/loginControl")
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private LoginMsService loginMsService;
	
	@RequestMapping("/login")
    public String login() {
		logger.info("dsahjdhjaskdhjksahk");
		loginMsService.sayHello();
		return "login";
    }
}
