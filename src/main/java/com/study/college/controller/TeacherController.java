package com.study.college.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.college.dto.form.teacher.TeacherRequestForm;
import com.study.college.dto.form.teacher.TeacherResponseForm;
import com.study.college.dto.human.Teacher;
import com.study.college.dto.human.User;
import com.study.college.service.TeacherService;
import com.study.college.utils.DateUtil;

@Controller
@RequestMapping("teacher")
public class TeacherController {
	
	@Autowired
	private TeacherService teacherService;
	
	/**
	 * 
	 * @description 跳转教师管理页面
	 * @param m
	 * @param u
	 * @return
	 * @Date 2015-12-2 上午9:53:44
	 */
	@RequestMapping(value="/teacherManage",method=RequestMethod.GET)
	public String toTeacherManagePage(Model m,User u){
		return "teacher/teacherManage";
	}
	
	/**
	 * 
	 * @description 保存教师信息(异步)
	 * @param model
	 * @param t
	 * @return
	 * @Date 2015-12-2 上午9:53:07
	 */
	@RequestMapping(value = "/saveTeacherInfo",method=RequestMethod.POST)
	@ResponseBody
	public String saveTeacherInfo(Model model,@RequestBody TeacherRequestForm form){
		Teacher t = form.getTeacher();
		Date birthday = DateUtil.parseDateStrToDate(form.getBirthdayStr(), "yyyy-MM-dd");
		t.setBirthday(birthday);
		Teacher teacher = teacherService.saveTeacher(t);
		model.addAttribute("teacher", teacher);
		return "teacher/teacherManage";
	}
	
	/**
	 * 
	 * @description 查询教师信息
	 * @param m
	 * @param form
	 * @return
	 * @Date 2015-12-3 上午11:16:22
	 */
	@RequestMapping(value = "/queryTeachers", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryTeachers(Model m,TeacherRequestForm form) {
		TeacherResponseForm result = teacherService.queryTeachers(form);
		m.addAttribute("result", result);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		List<TeacherResponseForm> forms = new ArrayList<TeacherResponseForm>();
		if(CollectionUtils.isNotEmpty(result.getResultList())){
			for(Teacher t:result.getResultList()){
				TeacherResponseForm f = new TeacherResponseForm();
				f.setTeacher(t);
				forms.add(f);
			}
		}
		resultMap.put("resultList",forms);
		resultMap.put("pagination", result.getPagination());
		return resultMap;
	}
	
	/**
	 * 
	 * @description 根据教师id查询教师信息
	 * @param m
	 * @param form
	 * @return
	 * @Date 2015-12-3 上午11:16:43
	 */
	@RequestMapping(value = "/getTeacherById/{id}",method = RequestMethod.GET)
	public String getTeacherById(Model m, @PathVariable Long id){
		System.out.println();
		TeacherRequestForm form = new TeacherRequestForm();
		form.setId(id);
		Teacher teacher = teacherService.getTeacherById(form.getId());
		m.addAttribute("teacher",teacher);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("teacher", teacher);
		return "teacher/teacherEdit";
	}
	
	/**
	 * 
	 * @description 根据教师Id删除教师信息
	 * @param m
	 * @param form
	 * @return
	 * @Date 2015-12-3 上午11:17:06
	 */
	@RequestMapping(value = "/deleteTeacher",method = RequestMethod.POST)
	@ResponseBody
	public String deleteTeacher(Model m, @RequestBody TeacherRequestForm form){
		teacherService.deleteTeacher(form.getTeacher());
		return "teacher/teacherManage";
	}

}
