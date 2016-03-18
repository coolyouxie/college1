package com.study.college.persistence.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.study.college.dto.human.User;

public interface UserMapper {
	
	/**
	 * @description 获取一个用户信息
	 * @param user
	 * @return
	 */
	public User getUser(@Param("user")User user);
	
	/**
	 * 
	 * @description 获取一个用户信息
	 * @param user
	 * @return
	 * @Date 2015-11-29
	 */
	public User insert(@Param("user")User user);
	
	/**
	 * 
	 * @description 删除用户信息
	 * @param user
	 * @return
	 * @Date 2015-11-29
	 */
	public int delete(@Param("user")User user);
	
	/**
	 * 
	 * @description 更新用户信息
	 * @param user
	 * @return
	 * @Date 2015-11-29 下午12:59:32
	 */
	public int update(@Param("user")User user);
	
	/**
	 * 
	 * @description 获取多个用户信息
	 * @param user
	 * @return
	 * @Date 2015-11-29 下午1:00:21
	 */
	public List<User> query(@Param("user")User user);

}
