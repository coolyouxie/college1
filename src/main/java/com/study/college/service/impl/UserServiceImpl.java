package com.study.college.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.college.dto.human.User;
import com.study.college.persistence.mapper.UserMapper;
import com.study.college.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper mapper;

	public User saveUserInfo(User user) {
		if(user.getId()!=null){
			return mapper.insert(user);
		}
		mapper.update(user);
		return user;
	}

	public int deleteUserInfo(User u) {
		int count = mapper.delete(u);
		return count;
	}

	public List<User> queryUsers(User u) {
		List<User> resultList = mapper.query(u);
		return resultList;
	}

	public User getUserInfo(User u) {
		User user = mapper.getUser(u);
		return user;
	}

}
