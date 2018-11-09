<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
	<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工新增</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">姓名:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">邮箱:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@163.com">
			   	  <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">性别:</label>
			    <div class="col-sm-4">
				    <label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="1" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="0"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">部门:</label>
			    <div class="col-sm-4">
				    <select class="col-sm-4 form-control" name="dId"></select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="btnSave">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">姓名:</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_input"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">邮箱:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@163.com">
			   	  <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">性别:</label>
			    <div class="col-sm-4">
				    <label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_update_input" value="1" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="0"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">部门:</label>
			    <div class="col-sm-4">
				    <select class="col-sm-4 form-control" name="dId"></select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="btnUpdate">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-12"><h1>SSM-CRUD</h1></div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8 text-right">
				<button class="btn btn-primary" id="btnAdd">新增</button>
				<button class="btn btn-danger" id="btnDelAll">删除</button>
			</div>
		</div>	
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="employees_table">
					<thead>
						<tr>
						<th><input type="checkbox" id="check_all"></th>
						<th>ID</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6 text-right" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecords,currentNum;
	
		$(function(){
			toPage(1);
		});
		
		function toPage(pageNo){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pageNo="+pageNo,
				type:"get",
				success:function(result){
					build_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}
		
		function build_table(result){
			$("#employees_table tbody").empty();
			var employees=result.data.pageInfo.list;
			$.each(employees,function(index,item){
				var chkBoxTd=$("<td><input type='checkbox' class='check_item'></input></td>")
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=="1"?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm btn_edit")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑").attr("edit_id",item.empId);
				var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm btn_delete")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除").attr("delete_id",item.empId);
				var btnTD=$("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(chkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
				.append(emailTd).append(deptNameTd).append(btnTD)
				.appendTo("#employees_table tbody");
			});
		}
		
		function build_page_info(result){
			$("#page_info_area").empty();
			var pageInfo=result.data.pageInfo;
			$("#page_info_area").append("当前"+pageInfo.pageNum+"页，总记录数："+pageInfo.total);
			currentNum=pageInfo.pageNum;
			totalRecords=pageInfo.total;
		}
		
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var pageInfo=result.data.pageInfo;
			
			var ul=$("<ul></ul>").addClass("pagination");
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			firstPageLi.click(function(){
				toPage(1);
			});
			ul.append(firstPageLi);
			var prePageLi=$("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&laquo;").attr("aria-hidden","true"))
					.attr("aria-label","Previous").attr("href","#"));
			prePageLi.click(function(){
				toPage(pageInfo.pageNum-1);
			});
			if(pageInfo.hasPreviousPage){
				ul.append(prePageLi);
			}
			$.each(pageInfo.navigatepageNums,function(index,item){
				var numLi=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(pageInfo.pageNum==item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					toPage(item);
				});
				ul.append(numLi);
			});
			var nextPageLi=$("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&raquo;").attr("aria-hidden","true"))
					.attr("aria-label","Next").attr("href","#"));
			nextPageLi.click(function(){
				toPage(pageInfo.pageNum+1);
			});
			if(pageInfo.hasNextPage){
				ul.append(nextPageLi);
			}
			var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			lastPageLi.click(function(){
				toPage(pageInfo.pages);
			});
			ul.append(lastPageLi);
			var nav=$("<nav></nav>").attr("aria-label","Page navigation").append(ul);
			$("#page_nav_area").append(nav);
		}
		
		function resetForm(){
			$("#empAddModal form")[0].reset();
			$("#empAddModal form").find("*").removeClass("has-error has-success");
			$("#empAddModal form").find(".help-block").text("");
			$("#btnSave").attr("disabled",false);
		}
		
		$("#btnAdd").click(function(){
			
			resetForm();
			
			getAllEmployees("#empAddModal select");
			
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		function getAllEmployees(element){
			
			$(element).empty();
			
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				async:false,
				success:function(result){
					var depts=result.data.allDepts;
					
					$.each(depts,function(index,item){
						var opt=$("<option></option>").append(item.deptName).attr("value",item.deptId);
						$(element).append(opt);
					});
				}
			});
		}
		
		$("#btnSave").click(function(){
			var empName=$("#empName_add_input").val();
			var email=$("#email_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if(!regName.test(empName)){
				showValidatingMsg("#empName_add_input","error","用户名格式不正确");
				return;
			}else{
				showValidatingMsg("#empName_add_input","success","");
			}
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				showValidatingMsg("#email_add_input","error","不是一个合法的电子邮件地址");
				return;
			}else{
				showValidatingMsg("#email_add_input","success","");
			}
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"post",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					if(result.code==100){
						$('#empAddModal').modal('hide');
						toPage(totalRecords);
					}else{
						var errors=result.data.validata_msg;
						
						if(errors.empName!=undefined){
							showValidatingMsg("#empName_add_input","error",errors.empName);
						}else{
							showValidatingMsg("#empName_add_input","success","");
						}
						
						if(errors.email!=undefined){
							showValidatingMsg("#email_add_input","error",errors.email);	
						}else{
							showValidatingMsg("#email_add_input","success","");
						}
					}
				}
			});
		});
		
		function showValidatingMsg(element,status,msg){
			$(element).removeClass("has-error has-success");
			if("error"==status){
				$(element).parent().addClass("has-error");
				$(element).next("span").text(msg);
			}else{
				$(element).parent().addClass("has-success");
				$(element).next("span").text(msg);
			}
		}
		
		$("#empName_add_input").change(function(){
			var empName=$("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if(!regName.test(empName)){
				showValidatingMsg("#empName_add_input","error","用户名格式不正确");
				return;
			}else{
				showValidatingMsg("#empName_add_input","success","");
			}
			$.ajax({
				url:"${APP_PATH}/checkuser",
				type:"get",
				data:{"empName":empName},
				success:function(result){
					if(result.code==100){
						showValidatingMsg("#empName_add_input","success","用户名可用！！！");
						$("#btnSave").attr("disabled",false);
					}else{
						showValidatingMsg("#empName_add_input","error","用户名已存在！！！");
						$("#btnSave").attr("disabled",true);
					}
				}
			});
		});
		
		$(document).on("click",".btn_edit",function(){
			
			var edit_id=$(this).attr("edit_id");
			
			$("#btnUpdate").attr("edit_id",edit_id);
			
			getAllEmployees("#empUpdateModal select");
			
			$.ajax({
				url:"${APP_PATH}/emp/"+edit_id,
				type:"get",
				success:function(result){
					if(result.code==100){
						var employee=result.data.employee;
						
						$("#empName_update_input").text(employee.empName);
						
						$("#email_update_input").val(employee.email);
						
						$("#empUpdateModal input[name=gender]").val([employee.gender]);
						
						$("#empUpdateModal select").val([employee.dId]);
					}
				}
			});
			
			
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		$("#btnUpdate").click(function(){
			var email=$("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				showValidatingMsg("#email_update_input","error","不是一个合法的电子邮件地址");
				return;
			}else{
				showValidatingMsg("#email_update_input","success","");
			}
			$.ajax({
				url:"${APP_PATH}/emp/"+$("#btnUpdate").attr("edit_id"),
				type:"put",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					if(result.code==100){
						$('#empUpdateModal').modal('hide');
						toPage(currentNum);
					}else{
						var errors=result.data.validata_msg;
						
						if(errors.email!=undefined){
							showValidatingMsg("#email_update_input","error",errors.email);	
						}else{
							showValidatingMsg("#email_update_input","success","");
						}
					}
				}
			});
		});
		
		$(document).on("click",".btn_delete",function(){
			
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			
			if(confirm("确定删除【"+empName+"】员工?")){
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("delete_id"),
					type:"delete",
					success:function(result){
						if(result.code==100){
							toPage(currentNum);
						}
					}
				});
			}
		});
		
		$("#check_all").click(function(){
			var checked=$(this).prop("checked");
			
			$(".check_item").prop("checked",checked);
		});
		
		$(document).on("click",".check_item",function(){
			if($(".check_item:checked").length==5){
				$("#check_all").prop("checked",true);
			}else{
				$("#check_all").prop("checked",false);
			}
		});
		
		$("#btnDelAll").click(function(){
			
			var empNames="";
			var empIds="";
			$.each($(".check_item:checked"),function(index,item){
				var empName=$(item).parents("tr").find("td:eq(2)").text();
				var empId=$(item).parents("tr").find("td:eq(1)").text();
				empNames+=empName+",";
				empIds+=empId+"-";
			});
			
			if(empNames!=""&&empIds!=""){
				empNames=empNames.substring(0,empNames.length-1);
				empIds=empIds.substring(0,empIds.length-1);
				if(confirm("确定删除【"+empNames+"】员工?")){
					$.ajax({
						url:"${APP_PATH}/emp/"+empIds,
						type:"delete",
						success:function(result){
							if(result.code==100){
								toPage(currentNum);
								$("#check_all").prop("checked",false);
							}
						}
					});
				}
			}else{
				alert("请至少选择一名员工进行操作！");
			}
			
			
		});
	</script>
</body>
</html>