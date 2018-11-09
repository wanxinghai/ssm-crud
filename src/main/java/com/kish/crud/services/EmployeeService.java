package com.kish.crud.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kish.crud.beans.Employee;
import com.kish.crud.beans.EmployeeExample;
import com.kish.crud.beans.EmployeeExample.Criteria;
import com.kish.crud.daos.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAllEmployees(){
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveOneEmployee(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	public boolean checkEmployee(String empName) {
		EmployeeExample example=new EmployeeExample();
		
		Criteria criteria = example.createCriteria();
		
		criteria.andEmpNameEqualTo(empName);
		
		long count = employeeMapper.countByExample(example);
		
		return count==0?true:false;
	}

	public Employee selectOneEmployeeById(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}

	public void updateOneEmployee(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void deleteOneEmployeeById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatchEmployeeByIds(List<Integer> empIds) {
		EmployeeExample example=new EmployeeExample();
		
		Criteria criteria = example.createCriteria();
		
		criteria.andEmpIdIn(empIds);
		
		employeeMapper.deleteByExample(example);
	}
	
}
