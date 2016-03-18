package com.study.college.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.college.dto.form.teacher.TeacherRequestForm;
import com.study.college.dto.form.teacher.TeacherResponseForm;
import com.study.college.dto.human.Teacher;
import com.study.college.persistence.mapper.TeacherMapper;
import com.study.college.service.TeacherService;
import com.study.college.utils.Pagination;

@Service
public class TeacherServiceImpl implements TeacherService {
	
	@Autowired
	private TeacherMapper mapper;

	public List<Teacher> queryTeachers(Teacher teacher) {
		TeacherRequestForm form = new TeacherRequestForm();
		form.setTeacher(teacher);
		List<Teacher> results = mapper.query(form);
		return results;
	}

	public Teacher saveTeacher(Teacher teacher) {
		if(teacher.getId()==null){
			mapper.insert(teacher);
			return teacher;
		}
		mapper.updateById(teacher.getId(), teacher);
		return teacher;
	}

	public int deleteTeacher(Teacher teacher) {
		int count = mapper.deleteById(teacher.getId());
		return count;
	}

	public int updateTeacher(Teacher teacher) {
		
		return 0;
	}

	public TeacherResponseForm queryTeachers(TeacherRequestForm form) {
		int count = mapper.count(form);
		List<Teacher> resultList = mapper.query(form);
		TeacherResponseForm responseForm = new TeacherResponseForm();
		responseForm.setResultList(resultList);
		Pagination pagination = new Pagination();
		pagination.setPage(form.getPage());
		pagination.setRecords(count);
		pagination.setRows(form.getPagination().getRows());
		pagination.countRecords(count);
		responseForm.setPagination(pagination);
		return responseForm;
	}

	public Teacher getTeacherById(Long id) {
		Teacher t = mapper.getById(id);
		return t;
	}

}
