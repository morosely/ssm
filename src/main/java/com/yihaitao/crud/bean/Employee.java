package com.yihaitao.crud.bean;

import java.util.Date;

import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

public class Employee {
    private Integer empno;

    @Pattern(regexp="^[a-zA-Z0-9\u2E80-\u9FFF_-]{6,16}$",message="用户名必须是2-5位中文或者6-16位英文和数字的组合(服务端)")
    private String ename;

    private String job;

    @Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",message="邮箱格式不正确(服务端)")
    private String email;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date hiredate;

    private Double sal;

    private String gender;

    private Integer deptno;
    
    private Department dept;

    public Employee() {
		super();
	}

	public Employee(Integer empno, String ename, String job, String email,
			Date hiredate, Double sal, String gender, Integer deptno,
			Department dept) {
		super();
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.email = email;
		this.hiredate = hiredate;
		this.sal = sal;
		this.gender = gender;
		this.deptno = deptno;
		this.dept = dept;
	}

	public Department getDept() {
		return dept;
	}

	public void setDept(Department dept) {
		this.dept = dept;
	}

	public Integer getEmpno() {
        return empno;
    }

    public void setEmpno(Integer empno) {
        this.empno = empno;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename == null ? null : ename.trim();
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job == null ? null : job.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Date getHiredate() {
        return hiredate;
    }

    public void setHiredate(Date hiredate) {
        this.hiredate = hiredate;
    }

    public Double getSal() {
        return sal;
    }

    public void setSal(Double sal) {
        this.sal = sal;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public Integer getDeptno() {
        return deptno;
    }

    public void setDeptno(Integer deptno) {
        this.deptno = deptno;
    }
}