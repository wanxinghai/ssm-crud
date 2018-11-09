package com.kish.crud.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kish.crud.beans.Department;
import com.kish.crud.services.DepartmentService;
import com.kish.crud.utils.Msg;

@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getAllDeptsWithJSON(){
		
		List<Department> allDepts = departmentService.getAllDepts();
		
		Msg msg=Msg.success().add("allDepts", allDepts);
		
		return msg;
	}
}
