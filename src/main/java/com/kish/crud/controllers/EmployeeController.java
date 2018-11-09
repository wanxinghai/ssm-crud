package com.kish.crud.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kish.crud.beans.Employee;
import com.kish.crud.services.EmployeeService;
import com.kish.crud.utils.Msg;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	//@RequestMapping("/emps")
	/*public String getEmployees(@RequestParam(value="pageNo",defaultValue="1") Integer pageNo,Model model){
		
		PageHelper.startPage(pageNo, 5);
		
		List<Employee> allEmployees = employeeService.getAllEmployees();
		
		PageInfo pageInfo=new PageInfo(allEmployees,5);
		
		model.addAttribute("pageInfo", pageInfo);
		
		return "list";
	}*/
	
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmployeesWithJSON(@RequestParam(value="pageNo",defaultValue="1") Integer pageNo){
		
		PageHelper.startPage(pageNo, 5);
		
		List<Employee> allEmployees = employeeService.getAllEmployees();
		
		PageInfo<Employee> pageInfo=new PageInfo<Employee>(allEmployees,5);
		
		Msg msg=Msg.success().add("pageInfo", pageInfo).add("wodehai", "123456");
		
		return msg;
	}
	
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmployeesWithJSON(@Valid Employee employee,BindingResult result){
		
		Map<String,Object> errorMsgMap=new HashMap<String, Object>();
		
		if(result.hasErrors()){
			List<FieldError> fieldErrors = result.getFieldErrors();
			
			boolean isDeptName=false;
			
			for(FieldError error:fieldErrors){
				if("empName".equals(error.getField())){
					isDeptName=true;
				}
				errorMsgMap.put(error.getField(), error.getDefaultMessage());
			}
			
			if(!isDeptName){
				boolean isUse=employeeService.checkEmployee(employee.getEmpName());
				if(!isUse){
					errorMsgMap.put("empName", "用户名已存在！！！");
				}
			}
			return Msg.fail().add("validata_msg", errorMsgMap);
		}else{
			employeeService.saveOneEmployee(employee);
			return Msg.success();
		}
	}
	
	@RequestMapping(value="/checkuser")
	@ResponseBody
	public Msg checkEmployeeWithJSON(@RequestParam("empName") String empName){
		boolean isUse=employeeService.checkEmployee(empName);
		if(isUse){
			return Msg.success();
		}else{
			return Msg.fail();
		}
	}
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getOneEmployeeWithJSON(@PathVariable("id") Integer id){
		
		Employee employee=employeeService.selectOneEmployeeById(id);
		
		return Msg.success().add("employee", employee);
	}
	
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmployeesWithJSON(@Valid Employee employee,BindingResult result){
		
		Map<String,Object> errorMsgMap=new HashMap<String, Object>();
		
		if(result.hasErrors()){
			
			List<FieldError> fieldErrors = result.getFieldErrors();
			
			for(FieldError error:fieldErrors){
				
				errorMsgMap.put(error.getField(), error.getDefaultMessage());
			}
			
			return Msg.fail().add("validata_msg", errorMsgMap);
		}else{
			employeeService.updateOneEmployee(employee);
			return Msg.success();
		}
	}
	
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmployeeWithJSON(@PathVariable("ids") String ids){
		
		if(ids.contains("-")){
			List<Integer> empIds=new ArrayList<Integer>();
			
			String[] str_ids=ids.split("-");
			
			for(String id :str_ids){
				empIds.add(Integer.parseInt(id));
			}
			employeeService.deleteBatchEmployeeByIds(empIds);
			
		}else{
			employeeService.deleteOneEmployeeById(Integer.parseInt(ids));
		}

		return Msg.success();
	}
}
