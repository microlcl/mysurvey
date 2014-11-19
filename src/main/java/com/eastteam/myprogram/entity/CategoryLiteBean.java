package com.eastteam.myprogram.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 由于EasyUI组件comboTree需要特殊的json数据格式，所以定义另一个Category的entity bean。
 * @author lichlei
 *
 */
public class CategoryLiteBean extends BaseEntity {
	private String id;
	@JsonProperty(value="text")
	private String name;
	private List<CategoryLiteBean> children;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<CategoryLiteBean> getChildren() {
		return children;
	}
	public void setChildren(List<CategoryLiteBean> children) {
		this.children = children;
	}
	
}
