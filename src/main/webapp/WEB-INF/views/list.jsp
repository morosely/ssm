<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- web路径：
1.不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
2.以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
http://localhost:3306/crud
 -->
 <%
 	pageContext.setAttribute("APP_PATH", request.getContextPath());
 %>
<title>员工列表</title>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 标题 -->
		<div class="row">
		  <div class="col-md-12">
		  	<h1>员工列表</h1>
		  </div>
		</div>
		<!-- 按钮 -->
		<div class="row">
		 	<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-success btn-sm" type="submit">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增
				</button>
				<button class="btn btn-danger btn-sm" type="submit">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;批量删除
				</button>
			</div>
		</div>
		<!-- 列表 -->
		<br/>
		<div class="row">
			<table class="table table-hover">
				<thead>
			  		<tr>
						<th>#</th>
						<th>EmpName</th>
						<th>Job</th>
						<th>Hiredate</th>
						<th>DeptName</th>
						<th>Operate</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<td>${emp.empno}</td>
							<td>${emp.ename}</td>
							<td>${emp.job}</td>
							<td>${emp.hiredate}</td>
							<td>${emp.dept.dname}</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前 ${pageInfo.pageNum}页, 总共${pageInfo.pages}页, 共 ${pageInfo.total} 条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH}/emps?pageNo=1">首页</a></li>
				  	<c:if test="${pageInfo.hasPreviousPage}">
					    <li>
					      <a href="${APP_PATH}/emps?pageNo=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					</c:if>
				    <c:forEach items="${pageInfo.navigatepageNums}" var="naviPageNum">
				    	<c:choose>
				    		<c:when test="${pageInfo.pageNum==naviPageNum}">
				    			<li class="active"><a href="${APP_PATH }/emps?pageNo=${naviPageNum}">${naviPageNum}</a></li>
				    		</c:when>
				    		<c:otherwise>
				    			<li><a href="${APP_PATH}/emps?pageNo=${naviPageNum}">${naviPageNum}</a></li>
				    		</c:otherwise>
				    	</c:choose>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage}">
					    <li>
					      <a href="${APP_PATH }/emps?pageNo=${pageInfo.pageNum+1}" aria-label="Next">
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