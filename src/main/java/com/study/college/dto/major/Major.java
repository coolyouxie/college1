package com.study.college.dto.major;

/**
 * 
 * @author 解帅
 * @description 专业类
 */
public class Major {
	
	private Long id ;
	
	private String majorNo;
	
	private String name;
	
	private String majorType;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMajorNo() {
		return majorNo;
	}

	public void setMajorNo(String majorNo) {
		this.majorNo = majorNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMajorType() {
		return majorType;
	}

	public void setMajorType(String majorType) {
		this.majorType = majorType;
	}

}
