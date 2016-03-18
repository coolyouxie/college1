package com.study.college.ws.server;

import javax.jws.WebService;

import com.study.college.dto.human.Human;
import com.study.college.dto.human.Teacher;

@WebService(endpointInterface = "com.study.college.ws.server.ITestService", serviceName = "TestService")
public class TestServiceImpl implements ITestService {

	public String sayHello(String words) {
		System.out.println("Hello,"+words);
		return null;
	}

	public Teacher getTeacher(Teacher t) {
		if(t!=null){
			System.out.println(t.getName());
			t.setSex("female");
			return t;
		}
		return t;
	}
	
	public Teacher getTeacher(Teacher t,String str){
		if(t==null){
			return t;
		}
		t.setName(str);
		t.setSex("female");
		return t;
	}

}
