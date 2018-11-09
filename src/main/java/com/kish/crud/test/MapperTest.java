package com.kish.crud.test;

import static org.junit.Assert.*;

import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kish.crud.beans.Department;
import com.kish.crud.beans.Employee;
import com.kish.crud.daos.DepartmentMapper;
import com.kish.crud.daos.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Test
	public void testCRUD() {
		/*ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml");
		DepartmentMapper bean = ac.getBean(DepartmentMapper.class);*/
		System.out.println(departmentMapper);
		
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
//		departmentMapper.insertSelective(new Department(null,"技术部"));
		
		//employeeMapper.insertSelective(new Employee(null, "tom", "1", "tom@163.com", 1));
	
		EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
		
		for (int i = 0; i < 50; i++) {
			String uuidName=UUID.randomUUID().toString().substring(0, 5);
			mapper.insertSelective(new Employee(null, uuidName, "0", uuidName+"@163.com", 3));
		}
	}

}
