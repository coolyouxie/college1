package com.study.college.persistence.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.study.college.dto.form.teacher.TeacherRequestForm;
import com.study.college.dto.human.Teacher;

public interface TeacherMapper {
	
	public List<Teacher> query(TeacherRequestForm form);
	
	public int count(TeacherRequestForm form);
	
	public int deleteById(Long id);
	
	public int insert(Teacher teacher);
	
	/**
	 * 根据id更新信息
	 * @param id
	 * @param teacher
	 * @return
	 */
	public int updateById(@Param("id")Long id,@Param("i")Teacher teacher);
	
	public Teacher getById(@Param("id")Long id);

}
