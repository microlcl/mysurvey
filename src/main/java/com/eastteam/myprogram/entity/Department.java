package com.eastteam.myprogram.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Department extends BaseEntity {
	
	private String id;	
	@JsonProperty(value="text")
	private String name;
	@JsonIgnore
	private Department parent;	
	private List<Department> children;	
	@JsonIgnore
	private String description;

	public String getId() {
		return id;
	}

	public void setId(String departmentId) {
		this.id = departmentId;
	}

	public Department getParent() {
		return parent;
	}

	public void setParent(Department parent) {
		this.parent = parent;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Department> getChildren() {
		return children;
	}

	public void setChildren(List<Department> children) {
		this.children = children;
	}
	
	

}
