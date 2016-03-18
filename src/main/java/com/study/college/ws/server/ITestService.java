package com.study.college.ws.server;

import javax.jws.WebService;

import com.study.college.dto.human.Human;
import com.study.college.dto.human.Teacher;

@WebService
public interface ITestService {

	public String sayHello(String words);
	
	public Teacher getTeacher(Teacher t);
	
}
