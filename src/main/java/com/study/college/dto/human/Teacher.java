package com.study.college.dto.human;

/**
 * 
 * @author 解帅
 * @description 教师类
 */
public class Teacher extends Human {
	
	private String level;
	
	private boolean headMaster;

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public boolean isHeadMaster() {
		return headMaster;
	}

	public void setHeadMaster(boolean headMaster) {
		this.headMaster = headMaster;
	}

}
