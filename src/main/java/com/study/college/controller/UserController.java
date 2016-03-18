package com.study.college.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.study.college.dto.human.User;
import com.study.college.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/userManage",method=RequestMethod.GET)
	public String toUserManagePage(Model m,User u){
		
		return "user/userManage";
	}
	
}
