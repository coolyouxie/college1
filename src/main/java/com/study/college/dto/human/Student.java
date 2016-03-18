package com.study.college.dto.human;

/**
 * 
 * @author 解帅
 * @description 学生类
 */
public class Student extends Human {

	private Long id;
	
	private int grade;
	
	private int clussNo;
	
	private int majorId;
	
	private long teacherId;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public int getClussNo() {
		return clussNo;
	}

	public void setClussNo(int clussNo) {
		this.clussNo = clussNo;
	}

	public int getMajorId() {
		return majorId;
	}

	public void setMajorId(int majorId) {
		this.majorId = majorId;
	}

	public long getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(long teacherId) {
		this.teacherId = teacherId;
	}
	
}
