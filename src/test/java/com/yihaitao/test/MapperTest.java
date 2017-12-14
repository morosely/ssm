package com.yihaitao.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yihaitao.crud.bean.Department;
import com.yihaitao.crud.dao.DepartmentMapper;
import com.yihaitao.crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * @author lfy
 *推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *1、导入SpringTest模块
 *2、@ContextConfiguration指定Spring配置文件的位置
 *3、直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper; 
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	@Test
	public void testCRUD(){
		//1、创建SpringIOC容器
		//ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2、从容器中获取mapper
		//DepartmentMapper mapper = ac.getBean(DepartmentMapper.class);
		
		departmentMapper.insertSelective(new Department(99,"毒品研发","金三角"));
	
		//3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession。
		
//		for(){
//			employeeMapper.insertSelective(new Employee(null, , "M", "Jerry@atguigu.com", 1));
//		}
		/*long start1 = System.currentTimeMillis();
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=1;i<=1000;i++){
			int deptno = i%10*10;
			mapper.insert(new Employee(i, "name-"+i, "worker", i%10 + 1, new Date(), 3000.0, 0.0, deptno==0?10:deptno));
		}
		long end1 = System.currentTimeMillis();
		System.out.println("cost time is :" + (end1 - start1));//cost time is :109299
*/		
		/*long start2 = System.currentTimeMillis();
		for(int i=1001;i<=2000;i++){
			int deptno = i%10*10;
			employeeMapper.insert(new Employee(i, "name-"+i, "worker", i%10 + 1, new Date(), 3000.0, 0.0, deptno==0?10:deptno));
		}
		long end2 = System.currentTimeMillis();
		System.out.println("cost time is :" + (end2 - start2));//cost time is :109606
*/	}

}
