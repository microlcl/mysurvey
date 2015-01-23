package com.eastteam.myprogram.entity;

import java.util.Date;
import java.util.List;
import java.util.TreeMap;

/**
 * @author gongbinfeng
 *
 */
public class Group extends IdEntity{
	private String groupName;
	private String comment;
	private String content;
	private Date editDate;
	private User creater;
	private List<String []> gitems;
	
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getEditDate() {
		return editDate;
	}
	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}
	public User getCreater() {
		return creater;
	}
	public void setCreater(User creater) {
		this.creater = creater;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<String[]> getGitems() {
		return gitems;
	}
	public void setGitems(List<String[]> gitems) {
		this.gitems = gitems;
	}
    
}
