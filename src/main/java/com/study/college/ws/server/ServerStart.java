package com.study.college.ws.server;

import javax.xml.ws.Endpoint;

public class ServerStart {
	
	public static void main(String[] args){
		System.out.println("web service start");  
        TestServiceImpl implementor = new TestServiceImpl();  
        String address = "http://localhost:8080/helloWorld";  
        Endpoint.publish(address, implementor);  
        System.out.println("web service started");  
	}

}
