package com.study.college.service;

import java.util.List;

import com.study.college.dto.form.teacher.TeacherRequestForm;
import com.study.college.dto.form.teacher.TeacherResponseForm;
import com.study.college.dto.human.Teacher;

public interface TeacherService {
	/**
	 * 
	 * @description 无分页参数
	 * @param teacher
	 * @return
	 * @Date 2015-12-2 上午10:00:05
	 */
	public List<Teacher> queryTeachers(Teacher teacher);
	
	/**
	 * 
	 * @description 带分页参数
	 * @param form
	 * @return
	 * @Date 2015-12-2 上午10:00:25
	 */
	public TeacherResponseForm queryTeachers(TeacherRequestForm form);
	
	public Teacher saveTeacher(Teacher teacher);
	
	public int deleteTeacher(Teacher teacher);
	
	public int updateTeacher(Teacher teacher);
	
	public Teacher getTeacherById(Long id);

}
