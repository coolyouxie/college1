package com.study.college.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class DateUtil {
	
	private static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd hh:mm:ss";
	
	public static String formatDateToStr(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat(YYYY_MM_DD_HH_MM_SS);
		if(date==null){
			return null;
		}
		return sdf.format(date);
	}
	
	public static Date parseDateStrToDate(String dateStr,String pattern){
		if(StringUtils.isEmpty(dateStr)){
			return null;
		}
		DateFormat format = new SimpleDateFormat(pattern);
		try {
			return format.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
	

}
