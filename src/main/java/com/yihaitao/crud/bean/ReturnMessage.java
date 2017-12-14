package com.yihaitao.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回的类
 * @author Administrator
 *
 */
public class ReturnMessage {
	//状态编码 100：成功；200：失败
	private Integer code;
	//提示信息
	private String message;
	//用户要返回给浏览器的数据
	private Map<String,Object> data = new HashMap<String,Object>();
	
	public static ReturnMessage success(){
		ReturnMessage rm = new ReturnMessage();
		rm.setCode(100);
		rm.setMessage("处理成功");
		return rm;
	}
	
	public static ReturnMessage fail(){
		ReturnMessage rm = new ReturnMessage();
		rm.setCode(200);
		rm.setMessage("处理失败");
		return rm;
	}
	
	public ReturnMessage add(String key,Object value){
		this.getData().put(key, value);
		return this;
	}
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Map<String, Object> getData() {
		return data;
	}
	public void setData(Map<String, Object> data) {
		this.data = data;
	}

}
