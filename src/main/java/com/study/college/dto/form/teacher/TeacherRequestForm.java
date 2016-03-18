package com.study.college.dto.form.teacher;

import java.util.Date;

import com.study.college.dto.human.Teacher;
import com.study.college.dto.major.Major;
import com.study.college.utils.Pagination;

public class TeacherRequestForm {
	
	private Teacher teacher = new Teacher();
	
	private Pagination pagination = new Pagination();
	
	private String birthdayStr;

	public Teacher getTeacher() {
		return teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
	
	public String getLevel() {
		return teacher.getLevel();
	}

	public void setLevel(String level) {
		teacher.setLevel(level);
	}

	public boolean isHeadMaster() {
		return teacher.isHeadMaster();
	}

	public void setHeadMaster(boolean headMaster) {
		teacher.setHeadMaster(headMaster);
	}
	
	public String getName() {
		return teacher.getName();
	}

	public void setName(String name) {
		teacher.setName(name);
	}

	public String getSex() {
		return teacher.getSex();
	}

	public void setSex(String sex) {
		teacher.setSex(sex);
	}

	public Date getBirthday() {
		return teacher.getBirthday();
	}

	public void setAge(Date birthday) {
		teacher.setBirthday(birthday);
	}

	public String getCode() {
		return teacher.getCode();
	}

	public void setCode(String code) {
		teacher.setCode(code);
	}

	public Long getId() {
		return teacher.getId();
	}

	public void setId(Long id) {
		teacher.setId(id);
	}

	public String getType() {
		return teacher.getType();
	}

	public void setType(String type) {
		teacher.setType(type);
	}

	public Major getMajor() {
		return teacher.getMajor();
	}

	public void setMajor(Major major) {
		teacher.setMajor(major);
	}

	public Date getCreateTime() {
		return teacher.getCreateTime();
	}

	public void setCreateTime(Date createTime) {
		teacher.setCreateTime(createTime);
	}

	public Date getUpdateTime() {
		return teacher.getUpdateTime();
	}

	public void setUpdateTime(Date updateTime) {
		teacher.setUpdateTime(updateTime);
	}

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	
	public int getPage() {
		return pagination.getPage();
	}

	public void setPage(int page) {
		pagination.setPage(page);
	}

	public int getRows() {
		return pagination.getRows();
	}

	public void setRows(int rows) {
		pagination.setRows(rows);
	}

	public int getRecords() {
		return pagination.getRecords();
	}

	public void setRecords(int records) {
		pagination.setRecords(records);
	}

	public void countRecords(int records) {
		pagination.countRecords(records);
	}

	public int getTotal() {
		return pagination.getTotal();
	}

	public void setTotal(int total) {
		pagination.setTotal(total);
	}

	public String getSidx() {
		return pagination.getSidx();
	}

	public void setSidx(String sidx) {
		pagination.setSidx(sidx);
	}

	public String getSord() {
		return pagination.getSord();
	}

	public void setSord(String sord) {
		pagination.setSord(sord);
	}

	public int getStartRow() {
		return pagination.getStartRow();
	}

	public int getEndRow() {
		return pagination.getEndRow();
	}

	public boolean isSearch() {
		return pagination.isSearch();
	}

	public void setSearch(boolean search) {
		pagination.setSearch(search);
	}

	public String getBirthdayStr() {
		return birthdayStr;
	}

	public void setBirthdayStr(String birthdayStr) {
		this.birthdayStr = birthdayStr;
	}
}
