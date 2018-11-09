package com.kish.crud.utils;

import java.util.HashMap;
import java.util.Map;

public class Msg {
	private int code;
	
	private String msg;
	
	private Map<String,Object> data=new HashMap<String,Object>();
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	public static Msg success(){
		Msg msg=new Msg();
		msg.setCode(100);
		msg.setMsg("处理成功！！！");
		return msg;
	}
	
	public static Msg fail(){
		Msg msg=new Msg();
		msg.setCode(200);
		msg.setMsg("处理失败！！！");
		return msg;
	}
	
	public Msg add(String dataKey,Object dataValue){
		this.data.put(dataKey, dataValue);
		return this;
	}
}
