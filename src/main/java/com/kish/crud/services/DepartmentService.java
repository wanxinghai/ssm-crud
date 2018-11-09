package com.kish.crud.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kish.crud.beans.Department;
import com.kish.crud.beans.Employee;
import com.kish.crud.daos.DepartmentMapper;
import com.kish.crud.daos.EmployeeMapper;

@Service
public class DepartmentService {

	@Autowired
	DepartmentMapper departmentMapper;

	public List<Department> getAllDepts() {
		return departmentMapper.selectByExample(null);
	}
	
}
