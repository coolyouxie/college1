package com.study.college.service;

import java.util.List;

import com.study.college.dto.human.User;

public interface UserService {
	
	public User getUserInfo(User u);
	
	public User saveUserInfo(User user);
	
	public int deleteUserInfo(User u);
	
	public List<User> queryUsers(User u);

}
