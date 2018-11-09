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
	<div class="container">
		<div class="row">
			<div class="col-md-12"><h1>SSM-CRUD</h1></div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8 text-right">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>	
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>ID</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list}" var="employee">
						<tr>
							<td>${employee.empId}</td>
							<td>${employee.empName}</td>
							<td>${employee.gender=="1"?"男":"女"}</td>
							<td>${employee.email}</td>
							<td>${employee.department.deptName}</td>
							<td>
								<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑</button>
								<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">当前${pageInfo.pageNum}页，总记录数：${pageInfo.total}</div>
			<div class="col-md-6 text-right">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				    <li><a href="${APP_PATH}/emps?pageNo=1">首页</a></li>
				    <li>
				      <c:if test="${pageInfo.hasPreviousPage}">
					      <a href="${APP_PATH}/emps?pageNo=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
				      </c:if>				      
				    </li>
				    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNo">
				    	<c:if test="${pageInfo.pageNum==pageNo}">
				    		<li class="active"><a href="#">${pageNo}</a></li>
				    	</c:if>
					    <c:if test="${pageInfo.pageNum!=pageNo}">
					    	<li ><a href="${APP_PATH}/emps?pageNo=${pageNo}">${pageNo}</a></li>
					    </c:if>
				    </c:forEach>
					<c:if test="${pageInfo.hasNextPage}">
					    <li>
					      <a href="${APP_PATH}/emps?pageNo=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					</c:if>
				    <li><a href="${APP_PATH}/emps?pageNo=${pageInfo.pages}">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>