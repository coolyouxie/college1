package com.study.college.dto.human;

import java.util.Date;

/**
 * 
 * @author Administrator
 * @description 系统用户类，可登录该系统的用户
 */
public class User extends Human {
	
	private String account;
	
	private String email;
	
	private String password;
	
	private String level;
	
	private Date latestLoginTime = new Date();
	
	private Date latestLogoutTime = new Date();
	
	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public Date getLatestLoginTime() {
		return latestLoginTime;
	}

	public void setLatestLoginTime(Date latestLoginTime) {
		this.latestLoginTime = latestLoginTime;
	}

	public Date getLatestLogoutTime() {
		return latestLogoutTime;
	}

	public void setLatestLogoutTime(Date latestLogoutTime) {
		this.latestLogoutTime = latestLogoutTime;
	}
	
	
}
