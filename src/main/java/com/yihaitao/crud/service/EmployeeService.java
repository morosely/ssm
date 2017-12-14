package com.yihaitao.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yihaitao.crud.bean.Employee;
import com.yihaitao.crud.bean.EmployeeExample;
import com.yihaitao.crud.bean.EmployeeExample.Criteria;
import com.yihaitao.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper mapper;
	
	public List<Employee> getAll() {
		return mapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		mapper.insertSelective(employee);
	}

	public boolean checkUser(String ename) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEnameEqualTo(ename);
		return mapper.countByExample(example) == 0 ? true : false;
	}

	public Employee getEmpById(Integer id) {
		Employee employee = mapper.selectByPrimaryKey(id);
		return employee;
	}

	public void updateEmp(Employee employee) {
		mapper.updateByPrimaryKeySelective(employee);
	}

	public void deleteEmpById(Integer id) {
		mapper.deleteByPrimaryKey(id);
	}

	public void deleteEmpBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpnoIn(ids);
		mapper.deleteByExample(example);
	}

}
