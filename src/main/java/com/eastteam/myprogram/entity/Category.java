package com.eastteam.myprogram.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Category extends BaseEntity {
	
	private String id;
	@JsonProperty(value="_parentId")
	private String pid;
	private String name;
	private String trashed;
	private String comment;
	// 设定JSON序列化时的日期格式
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	private Date createdDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTrashed() {
		return trashed;
	}
	public void setTrashed(String trashed) {
		this.trashed = trashed;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Category)) {
			return false;
		}
		Category myObj = (Category)obj;
		return this.id.equals(myObj.id);
	}
	
	
}
