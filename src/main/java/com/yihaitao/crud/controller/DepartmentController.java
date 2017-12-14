package com.yihaitao.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yihaitao.crud.bean.Department;
import com.yihaitao.crud.bean.ReturnMessage;
import com.yihaitao.crud.service.DepartmentService;

@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService service;
	
	@RequestMapping("/depts")
	@ResponseBody
	public ReturnMessage getDepts(){
		List<Department> list = service.getDepts();
		return ReturnMessage.success().add("depts", list);
	}
}
