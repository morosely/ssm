<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:forward page="/emps"></jsp:forward>
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
				    <p class="form-control-static" id="empName_update_static"></p>
				  </div>
				</div>
			
				<div class="form-group">
				  <label for="email" class="col-sm-2 control-label">Email</label>
				  <div class="col-sm-10">
				    <input type="email" class="form-control" id="email" name="email" placeholder="love@521.com">
				    <span id="" class="help-block"></span>
				  </div>
				</div>
			
				<div class="form-group">
				  <label class="col-sm-2 control-label">Gender</label>
				  <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="1"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="0"> 女
					</label>
				   </div>
				 </div>
	            
	            <div class="form-group">
	                <label for="hiredate" class="col-md-2 control-label">Hiredate</label>
	                <div class="input-group date form_date col-md-5" data-date="" data-date-format="dd MM yyyy" data-link-field="hiredate" data-link-format="yyyy-mm-dd"
	                style="margin-left: 15px;float:left">
	                    <input class="form-control" size="16" type="text" value="" readonly>
	                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
						<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	                </div>
					<input type="hidden" name="hiredate" value="" /><br/>
           		</div>
           		
           		<div class="form-group">
				  <label for="deptno" class="col-sm-2 control-label">Deptno</label>
				   <div class="col-sm-10">
				       <select class="form-control" name="deptno">
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