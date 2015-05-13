package com.eastteam.myprogram.entity;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;


public class User extends BaseEntity{
	private String id;
	private String name;
	@JsonIgnore
	private String plainPassword;
	@JsonIgnore
	private String password;
	@JsonIgnore
	private Date registerDate;
	@JsonIgnore
	private String comment;	
	@JsonIgnore
	private List<Role> roles = Lists.newArrayList();
	@JsonIgnore
	private List<String> authorizedUriList;
	@JsonIgnore
	private List<String> authorizedFunctionList;
	
	public User() {
	}

	public User(String id) {
		this.id = id;
	}
	public User(String id, String password) {
		this.id = id;
		this.password = password;
	}
	
	@NotBlank
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	// 不显示在Restful接口的属性.
	@JsonIgnore
	public String getPlainPassword() {
		
		return plainPassword;
	}

	public void setPlainPassword(String plainPassword) {
		this.plainPassword = plainPassword;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	// 设定JSON序列化时的日期格式
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public List<String> getAuthorizedUriList() {
		return authorizedUriList;
	}

	public void setAuthorizedUriList(List<String> authorizedUriList) {
		this.authorizedUriList = authorizedUriList;
	}	
		
	public List<String> getAuthorizedFunctionList() {
		return authorizedFunctionList;
	}

	public void setAuthorizedFunctionList(List<String> authorizedFunctionList) {
		this.authorizedFunctionList = authorizedFunctionList;
	}

	public boolean checkPermission(String functionId) {
		if (authorizedFunctionList == null || authorizedFunctionList.isEmpty()) {
			return false;
		}
		
		return authorizedFunctionList.contains(functionId);
	}
	
	public String getEncodedUserId() {
		String encodedId = "";
		try {
			encodedId = URLEncoder.encode(id, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			encodedId = this.id;
		}
		
		return encodedId;
	}
	
}
