package com.study.college.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.study.college.dto.human.User;
import com.study.college.service.UserService;


@RequestMapping("login")
@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;

	@RequestMapping(value="/userLogin", method=RequestMethod.POST)
	public String login(Model model,User user){
		User loginUser = userService.getUserInfo(user);
		if(loginUser!=null&&loginUser.getAccount().equals(user.getAccount())&&loginUser.getPassword().equals(user.getPassword())){
			return "index";
		}
		return "login";
	}
}
