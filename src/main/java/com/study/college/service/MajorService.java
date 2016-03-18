package com.study.college.service;

import java.util.List;

import com.study.college.dto.major.Major;

public interface MajorService {

	public List<Major> queryMajors(Major major);
	
	public Major saveMajor(Major major);
	
	public int deleteMajor(Major major);
	
	public int updateMajor(Major major);
}
