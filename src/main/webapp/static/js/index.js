//定义全局变量
var totalRecord;
var currentPage;
//js获取访问路径
/*var localObj = window.location;
var contextPath = localObj.pathname.split("/")[1];
var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
var server_context = basePath;*/
var contextPath = "/"+window.location.pathname.split("/")[1];
//========== list ==========
$(function(){
	//去首页
	to_page(1);
});

/*${APP_PATH}这是JSP的EL表达式，js里无法获取到值。
在jsp定义一个全局变量path，包含的js就可以应用了。
*/
function to_page(pageNo){
	$.ajax({
		url:path+"/emps",
		data:"pageNo="+pageNo,
		type:"GET",
		success:function(result){
			//1、解析并显示员工数据
			build_emps_table(result);
			//2、解析并显示分页信息
			build_page_info(result);
			//3、解析显示分页条数据
			build_page_nav(result);
		}
	});
	//当前页面全选时，删除后跳转回当前页面，全选按钮还被勾上，所以清除全选选中状态。以及勾选全选，点击分页操作后全选还被选中
	$("#check_all").prop("checked",false);
}

//解析并显示员工数据
function build_emps_table(result){
	$("#emps_tab tbody").empty();
	var emps = result.data.pageInfo.list;
	$(emps).each(function(index,e){
		var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>")
		var empnoTd = $("<td></td>").append(e.empno);
		var enameTd = $("<td></td>").append(e.ename);
		var emailTd = $("<td></td>").append(e.email);
		var hiredateTd = $("<td></td>").append(jsonDateFormat(e.hiredate));
		var dnameTd = $("<td></td>").append(e.dept.dname);
		//1.为编辑按钮添加一个自定义的属性，来表示当前员工id
		//2.增加一个伪样式edit_btn，监听编辑事件
		var editBtnTd = $('<button class="btn btn-primary btn-sm edit_btn"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑</button>');
		editBtnTd.attr("edit-id",e.empno);
		var delBtnTd = $('<button class="btn btn-danger btn-sm del_btn"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除</button>');
		//1.为删除按钮添加一个自定义的属性来表示当前删除的员工id
		//2.增加一个伪样式del_btn，监听删除事件
		delBtnTd.attr("del-id",e.empno);
		$("<tr></tr>").append(checkboxTd).append(empnoTd).append(enameTd).append(emailTd).append(hiredateTd).append(dnameTd).append(editBtnTd).append('&nbsp;').append(delBtnTd).appendTo("#emps_tab tbody");
	});
}

//解析显示分页信息
function build_page_info(result){
	$("#page_info_area").empty();
	$("#page_info_area").append("当前"+result.data.pageInfo.pageNum+"页，总"+
			result.data.pageInfo.pages+"页，总"+
			result.data.pageInfo.total+"条记录");
	totalRecord = result.data.pageInfo.total;//全局变量构建时赋值
	currentPage = result.data.pageInfo.pageNum;
}

//解析显示分页条，点击分页要能去下一页....
function build_page_nav(result){
	//page_nav_area
	$("#page_nav_area").empty();
	var ul = $("<ul></ul>").addClass("pagination");
	//构建元素
	var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
	var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
	var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
	var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
	//添加首页和前一页 的提示
	ul.append(firstPageLi).append(prePageLi);
	//遍历给ul中添加页码提示
	$.each(result.data.pageInfo.navigatepageNums,function(index,item){
		var numLi = $("<li></li>").append($("<a></a>").append(item));
		if(result.data.pageInfo.pageNum == item){
			numLi.addClass("active");
		}
		//添加页码点击事件
		numLi.click(function(){
			to_page(item); 
		});
		ul.append(numLi);
	});
	//添加下一页和末页 的提示
	ul.append(nextPageLi).append(lastPageLi);
	
	//如果前面有页数，添加向前点击分页事件
	if(result.data.pageInfo.hasPreviousPage == true){
		//为元素添加点击翻页的事件
		firstPageLi.click(function(){
			to_page(1);
		});
		prePageLi.click(function(){
			to_page(result.data.pageInfo.pageNum -1);
		});
	}else{
		firstPageLi.addClass("disabled");
		prePageLi.addClass("disabled");
	}
	//如果后面有页数，添加向后点击分页事件
	if(result.data.pageInfo.hasNextPage == true){
		nextPageLi.click(function(){
			to_page(result.data.pageInfo.pageNum +1);
		});
		lastPageLi.click(function(){
			to_page(result.data.pageInfo.pages);
		});
	}else{
		nextPageLi.addClass("disabled");
		lastPageLi.addClass("disabled");
	}
	
	//把ul加入到nav
	var navEle = $('<nav aria-label="Page navigation"></nav>').append(ul);
	navEle.appendTo("#page_nav_area");
}

//json日期格式转换为正常格式
function jsonDateFormat(jsonDate) {
    try {
        var date = new Date(jsonDate);
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        //var hours = date.getHours();
        //var minutes = date.getMinutes();
        //var seconds = date.getSeconds();
        //var milliseconds = date.getMilliseconds();
        //return date.getFullYear() + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds + "." + milliseconds;
        return date.getFullYear() + "-" + month + "-" + day;
    } catch (ex) {
        return "";
    }
}

//========== add ==========
//点击新增按钮弹出模态框。
$("#emp_add_modal_btn").click(function(){
	//清除表单数据（表单完整重置（表单的数据，表单的样式））
	reset_form("#empAddModal form");
	//s$("")[0].reset();
	//发送ajax请求，查出部门信息，显示在下拉列表中
	//getDepts();
	 getDepts("#empAddModal select");
	//弹出模态框
	$("#empAddModal").modal({
		backdrop:"static"
	});
});

function reset_form(ele){
	//1.清空表单数据（JQuery没有重置方法，转变DOM对象）
	$(ele)[0].reset();
	//2.清空表单样式
	$(ele).find("div").removeClass("has-error has-success");
	$(ele).find(".help-block").text("");
}

//时间控件
$(".form_date").datetimepicker({
	format:'yyyy-mm-dd',
    autoclose:true,//自动关闭
    minView:2,//最精准的时间选择为日期0-分 1-时 2-日 3-月 
});

//查出所有的部门信息并显示在下拉列表中
function getDepts(ele){
	//清空之前下拉列表的值（避免多次点击重复添加）
	$(ele).empty();
	$.ajax({
		url:path+"/depts",
		type:"GET",
		success:function(result){
			//显示部门信息在下拉列表中
			$.each(result.data.depts,function(){
				var optionEle = $("<option></option>").append(this.dname).attr("value",this.deptno);
				$(ele).append(optionEle);
			});
		}
	});
}

//点击保存，保存员工。
$("#emp_save_btn").click(function(){
	//1、先对要提交给服务器的数据JS客户端进行校验
	//1.1 校验用户名(客户端js规则校验)
	if(!validate_ename("#ename_add") ) return false;
	
	//1.2判断之前的ajax用户名校验是否重复（这里尽量避免查询数据库）
	if($(this).attr("ajax-va")=="error"){
		//此处查询数据库后的错误消息。但是多次点击保存，校验的提示错误信息消失了
		show_validate_msg("#ename_add","error",$(this).attr("ajax-va-errmsg"));
		return false;
	}
	//1.3校验 email
	if(!validate_email("#email_add")) return false;
	
	//2、发送ajax请求保存员工
	$.ajax({
		url:path+"/emp",
		type:"POST",
		data:$("#empAddModal form").serialize(),
		success:function(result){
			if(result.code == 100){
				//员工保存成功；
				//1、关闭模态框
				$("#empAddModal").modal('hide');
				
				//2、来到最后一页，显示刚才保存的数据
				//发送ajax请求显示最后一页数据即可
				to_page(totalRecord);
			}else{//服务器端的校验返回错误信息渲染页面
				for(var key in result.data.errorFields){//遍历json对象的每个key/value对,p为key
					show_validate_msg("#"+key, "error", result.data.errorFields[key]);
				}
			}
		}
	});
});

//1.校验用户名规则(客户端js规则校验)
function validate_ename(ele_id){
	var empName = $(ele_id).val();
	var regName = /^[a-zA-Z0-9\u2E80-\u9FFF_-]{6,16}$/;
	if(!regName.test(empName)){
		show_validate_msg(ele_id, "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
		return false;
	}else{
		show_validate_msg(ele_id, "success", "");
		return true;
	}
}

//2.校验邮箱(客户端js规则校验)
function validate_email(ele_id){
	var email = $(ele_id).val();
	var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	if(!regEmail.test(email)){
		show_validate_msg(ele_id, "error", "邮箱格式不正确");
		return false;
	}else{
		show_validate_msg(ele_id, "success", "");
		return true;
	}
}

//1.Change事件校验用户名是否可用
$("#ename_add").change(function(){
	//1.校验用户名规则(客户端js规则校验)
	if(!validate_ename("#ename_add")) return false;
	//2.发送ajax请求校验用户名是否可用
	var ename = this.value;
	$.ajax({
		url:path+"/checkuser",
		data:"ename="+ename,
		type:"GET",
		success:function(result){
			if(result.code==100){
				show_validate_msg("#ename_add","success","");
				$("#emp_save_btn").attr("ajax-va","success");
				$("#emp_save_btn").attr("ajax-va-errmsg","");//校验成功时清空之前的错误信息
			}else{
				show_validate_msg("#ename_add","error",result.data.valid_ename_error);
				//保持错误消息，避免多次点击保存按钮去多次查询数据库
				$("#emp_save_btn").attr("ajax-va","error");
				$("#emp_save_btn").attr("ajax-va-errmsg",result.data.valid_ename_error);
			}
		}
	});
});

//2.Change事件校验邮件是否可用
$("#email_add").change(function(){
	if(!validate_email("#email_add")) return false;
});

//显示校验结果的提示信息
function show_validate_msg(ele,status,msg){
	//清空样式
	$(ele).parent().removeClass("has-success has-error");
	$(ele).next("span").text("");
	if("success"==status){
		$(ele).parent().addClass("has-success");
		$(ele).next("span").text(msg);
	}else if("error" == status){
		$(ele).parent().addClass("has-error");
		$(ele).next("span").text(msg);
	}
}

//========== edit ==========
//我们是按钮创建之前去绑定了click，所以绑定不上。
//1）、可以在创建按钮的时候绑定。   
//2）、绑定点击.live()jquery新版没有live，使用on进行替代
$(document).on("click",".edit_btn",function(){
	//清除表单数据（表单完整重置（表单的数据，表单的样式））
	reset_form("#empUpdateModal form");
	//1、查出部门信息，并显示部门列表
	getDepts("#empUpdateModal select");
	//2、查出员工信息，显示员工信息
	getEmp($(this).attr("edit-id"));
	
	//3、把员工的id传递给模态框的更新按钮
	$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
	$("#empUpdateModal").modal({
		backdrop:"static"
	});
});

$("#email_update").change(function(){
	if(!validate_ename("#email_update")) return false;
});

//编辑时通过id查询emp
function getEmp(id){
	$.ajax({
		url:path+"/emp/"+id,
		type:"GET",
		success:function(result){
			//console.log(result);
			var emp = result.data.emp;
			$("#ename_update").text(emp.ename);
			$("#email_update").val(emp.email);
			$("#empUpdateModal input[name='gender']").val([emp.gender]);
			$("#hiredate_update_show").val(jsonDateFormat(emp.hiredate));
			$("#hiredate_update").val(jsonDateFormat(emp.hiredate));
			$("#deptno_update").val([emp.deptno]);
		}
	});
}

$("#email_update").change(function(){
	if(!validate_email("#email_update")) return false;
});
/**
 * $.ajax({
		url:path+"/emp/"+$(this).attr("edit-id"),
		type:"POST",
		data:$("#empUpdateModal form").serialize()+"&_method=PUT",
		success:function(result){
			}
	});
*/
//点击更新，更新员工信息
$("#emp_update_btn").click(function(){
	//验证邮箱是否合法
	//1、校验邮箱信息
	if(!validate_email("#email_update")){
		return false;
	}
	//2、发送ajax请求保存更新的员工数据
	$.ajax({
		url:path+"/emp/"+$(this).attr("edit-id"),
		type:"PUT",
		data:$("#empUpdateModal form").serialize(),
		success:function(result){
			//1、关闭对话框
			$("#empUpdateModal").modal("hide");
			//2、回到本页面
			to_page(currentPage);
		}
	});
});

//========== delete ==========
//单个删除
$(document).on("click",".del_btn",function(){
	//1、弹出是否确认删除对话框
	var empName = $(this).parents("tr").find("td:eq(2)").text();
	var empId = $(this).attr("del-id");
	//alert($(this).parents("tr").find("td:eq(1)").text());
	if(confirm("确认删除【"+empName+"】吗？")){
		//确认，发送ajax请求删除即可
		$.ajax({
			url:path+"/emp/"+empId,
			type:"DELETE",
			success:function(result){
				//回到本页
				to_page(currentPage);
			}
		});
	}
});

//完成全选/全不选功能
$("#check_all").click(function(){
	//attr获取checked是undefined;
	//我们这些dom原生的属性；attr获取自定义属性的值；
	//prop修改和读取dom原生属性的值
	$(".check_item").prop("checked",$("#check_all").prop("checked"));
});

//每个checkbox对全选总按钮的影响
$(document).on("click",".check_item",function(){
	//判断当前选择中的元素是否10个
	$("#check_all").prop("checked",$(".check_item:checked").length==$(".check_item").length);
});

//点击全部删除，就批量删除
$("#emp_delete_all_btn").click(function(){
	var enames = "";
	var del_empids ="";
	$.each($(".check_item:checked"),function(){
		//console.log($(this).parent().next().next().text());
		//组装名字（用于弹出框）
		enames += $(this).parents("tr").find("td:eq(2)").text()+",";
		//组装员工id字符串
		del_empids += $(this).parents("tr").find("td:eq(1)").text()+",";
	});
	//表示没有选择任何checkbox
	if(enames.length == 0) return false;
	
	//去除empNames多余的,
	enames = enames.substring(0, enames.length-1);
	//去除删除的id多余的,
	del_empids = del_empids.substring(0, del_empids.length-1);
	
	if(confirm("确认删除【"+enames+"】吗？")){
		//发送ajax请求删除
		$.ajax({
			url:path+"/emp/"+del_empids,
			type:"DELETE",
			success:function(result){
				//回到当前页面
				to_page(currentPage);
			}
		});
	}
});