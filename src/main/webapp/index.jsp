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
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">
    var path = "${APP_PATH}";
</script>

</head>
<body>
	<!-- 搭建显示页面 -->
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
				<button class="btn btn-success btn-sm" id="emp_add_modal_btn">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增
				</button>
				<button class="btn btn-danger btn-sm" id="emp_delete_all_btn">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;批量删除
				</button>
			</div>
		</div>
		<!-- 列表 -->
		<br/>
		<div class="row">
			<table class="table table-hover" id="emps_tab">
			<thead>
		  		<tr>
		  			<th>
						<input type="checkbox" id="check_all"/>
					</th>
					<th>#</th>
					<th>EmpName</th>
					<th>Email</th>
					<th>Hiredate</th>
					<th>DeptName</th>
					<th>Operate</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
			</div>
		</div>
	</div>
	
	<!-- 员工添加的模态框-->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
				<div class="form-group">
				  <label for="ename" class="col-sm-2 control-label">EmpName</label>
				  <div class="col-sm-10">
				    <input type="ename" class="form-control" id="ename_add" name="ename" placeholder="请输入名字">
				  	<span id="" class="help-block"></span>
				  </div>
				</div>
			
				<div class="form-group">
				  <label for="email" class="col-sm-2 control-label">Email</label>
				  <div class="col-sm-10">
				    <input type="email" class="form-control" id="email_add" name="email" placeholder="love@520.com">
				    <span id="" class="help-block"></span>
				  </div>
				</div>
			
				<div class="form-group">
				  <label class="col-sm-2 control-label">Gender</label>
				  <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender_add1" value="1" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender_add0" value="0"> 女
					</label>
				   </div>
				 </div>
	            
	            <div class="form-group">
	                <label for="hiredate_add" class="col-md-2 control-label">Hiredate</label>
	                <div class="input-group date form_date col-md-5" data-date="" data-date-format="dd MM yyyy" data-link-field="hiredate_add" data-link-format="yyyy-mm-dd"
	                style="margin-left: 15px;float:left">
	                    <input class="form-control" size="16" type="text" value="" readonly >
	                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
						<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	                </div>
					<input type="hidden" id="hiredate_add" name="hiredate" value="" /><br/>
           		</div>
           		
           		<div class="form-group">
				  <label for="deptno" class="col-sm-2 control-label">Deptno</label>
				   <div class="col-sm-10">
				       <select class="form-control" id="deptno_add" name="deptno">
				       </select>
		    	  </div>
				</div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
				<div class="form-group">
				  <label for="ename" class="col-sm-2 control-label">EmpName</label>
				  <div class="col-sm-10">
				    <p class="form-control-static" id="ename_update"></p>
				  </div>
				</div>
			
				<div class="form-group">
				  <label for="email" class="col-sm-2 control-label">Email</label>
				  <div class="col-sm-10">
				    <input type="email" class="form-control" id="email_update" name="email" placeholder="love@521.com">
				    <span id="" class="help-block"></span>
				  </div>
				</div>
			
				<div class="form-group">
				  <label class="col-sm-2 control-label">Gender</label>
				  <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender_update1" value="1"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender_update0" value="0"> 女
					</label>
				   </div>
				 </div>
	            
	            <div class="form-group">
	                <label for="hiredate_update" class="col-md-2 control-label">Hiredate</label>
	                <div class="input-group date form_date col-md-5" data-date="" data-date-format="dd MM yyyy" data-link-field="hiredate_update" data-link-format="yyyy-mm-dd"
	                style="margin-left: 15px;float:left">
	                    <input class="form-control" size="16" type="text" value="" readonly id="hiredate_update_show">
	                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
						<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	                </div>
					<input type="hidden" id="hiredate_update" name="hiredate" value="" /><br/>
           		</div>
           		
           		<div class="form-group">
				  <label for="deptno" class="col-sm-2 control-label">Deptno</label>
				   <div class="col-sm-10">
				       <select class="form-control" id="deptno_update" name="deptno">
				       </select>
		    	  </div>
				</div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
<script src="${APP_PATH}/static/js/index.js"></script>
</body>
</html>