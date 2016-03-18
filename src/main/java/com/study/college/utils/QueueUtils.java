package com.study.college.utils;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class QueueUtils {
	
	public static void handle(String str){
		System.out.println(str);
	}

	public static void main(String[] args){
		BlockingQueue<String> queue = new LinkedBlockingQueue<String>(10);
		for(int i=0;i<9;i++){
			queue.offer("temp"+i);
		}
		for(int i=0;i<9;i++){
			handle(queue.poll());
		}
	}
}
