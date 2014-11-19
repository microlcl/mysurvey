package com.eastteam.myprogram.entity;

import java.util.List;

import com.google.common.collect.Lists;

public class Role extends BaseEntity {
	
	private String id;	
	private String name;	
	private List<Function> functions = Lists.newArrayList();
	private String description;

	public String getId() {
		return id;
	}

	public void setId(String roleId) {
		this.id = roleId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Function> getFunctions() {
		return functions;
	}

	public void setFunctions(List<Function> functions) {
		this.functions = functions;
	}

}
