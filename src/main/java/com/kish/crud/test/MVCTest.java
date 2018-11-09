package com.kish.crud.test;

import java.util.Iterator;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.kish.crud.beans.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MVCTest {

	@Autowired
	WebApplicationContext context;
	
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc(){
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void test() throws Exception {
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo", "1")).andReturn();
		
		MockHttpServletRequest request = result.getRequest();
		
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		
		System.out.println("当前页码："+pageInfo.getPageNum());
		System.out.println("总页码："+pageInfo.getPages());
		System.out.println("总记录数："+pageInfo.getTotal());
		System.out.println("页面连续显示的页码：");
		int[] navigatepageNums = pageInfo.getNavigatepageNums();
		for (int i = 0; i < navigatepageNums.length; i++) {
			int j = navigatepageNums[i];
			System.out.print(" "+j);
		}
		
		List<Employee> employees=pageInfo.getList();
		
		for(Employee employee:employees){
			System.out.println(employee.getdId() +"==>>" +employee.getEmpName());
		}
	}

}
