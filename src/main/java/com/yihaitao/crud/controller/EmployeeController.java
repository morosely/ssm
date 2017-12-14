package com.yihaitao.crud.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yihaitao.crud.bean.Employee;
import com.yihaitao.crud.bean.ReturnMessage;
import com.yihaitao.crud.service.EmployeeService;
@Controller
public class EmployeeController {
	@Autowired
	private EmployeeService employeeService;
	public static final Integer NavigatePageNums = 5;
	public static final Integer PageSize = 10;

	/**
	 * 查询员工数据（分页查询）
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo,Model model){
		// 这不是一个分页查询；
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pageNo, PageSize);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> list = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo pageInfo = new PageInfo(list,NavigatePageNums);
		model.addAttribute("pageInfo",pageInfo);
		return "list";
	}
	
	/**
	 * 查询员工数据（分页查询）Json模式，支持BS电脑，手机，Ipad与服务器端交互
	 * 导入jackson包
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public ReturnMessage getEmpsWithJson(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo){
		// 这不是一个分页查询；
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pageNo, PageSize);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> list = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo pageInfo = new PageInfo(list,NavigatePageNums);
		return ReturnMessage.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 保存员工信息
	 * 1、支持JSR303校验
	 * 2、导入Hibernate-Validator
	 */
	@ResponseBody
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	public ReturnMessage saveEmp(@Valid Employee employee,BindingResult result){
		Map<String,Object> map = new HashMap<String,Object>();
		if(result.hasErrors()){
			List<FieldError> list = result.getFieldErrors();
			for(FieldError fieldError:list){
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return ReturnMessage.fail().add("errorFields", map);
		}
		employeeService.saveEmp(employee);
		return ReturnMessage.success();
	}
	
	/**
	 * 检查用户名是否可用
	 */
	@ResponseBody
	@RequestMapping(value="/checkuser",method=RequestMethod.GET)
	public ReturnMessage checkUser(@RequestParam("ename")String ename){
		boolean flag = employeeService.checkUser(ename);
		if(flag){
			return ReturnMessage.success();
		}else{
			return ReturnMessage.fail().add("valid_ename_error", "用户名不可用");
		}
	}
	
	/**
	 * 通过id查询emp
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public ReturnMessage getEmpById(@PathVariable("id")Integer id){
		Employee employee = employeeService.getEmpById(id);
		return ReturnMessage.success().add("emp", employee);
	}
	
	/**
	 * 更新员工信息
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empno}",method=RequestMethod.PUT)
	public ReturnMessage updateEmp(Employee employee){
		employeeService.updateEmp(employee);
		return ReturnMessage.success();
	}
	
	/**
	 * 通过id删除emp
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public ReturnMessage deleteEmpById(@PathVariable("ids")String ids){
		if(ids.contains(",")){
			String[] arr = ids.split("-");
			List list = Arrays.asList(arr);
			employeeService.deleteEmpBatch(list);
		}else{
			employeeService.deleteEmpById(Integer.parseInt(ids));
		}
		return ReturnMessage.success();
	}
}
