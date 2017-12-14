package com.yihaitao.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yihaitao.crud.bean.Department;
import com.yihaitao.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper mapper;
	
	public List<Department> getDepts() {
		return mapper.selectByExample(null);
	}

}
