package com.eastteam.myprogram.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class Group extends IdEntity{
	private String groupName;
	private String comment;
	private String content;
	private Date editDate;
	private User creater;
	private String trashed;
	private List<String []> gitems;
	private String flagString = "none";
	private List<GroupMember> groupMembers;
	
	
	
	public String getTrashed() {
		return trashed;
	}
	public void setTrashed(String trashed) {
		this.trashed = trashed;
	}
	public String getFlagString() {
		return flagString;
	}
	public void setFlagString(String flagString) {
		this.flagString = flagString;
	}
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
	public void setGitems() {
		this.gitems = parseContent();
	}
	
	public List<GroupMember> getGroupMembers() {
		return groupMembers;
	}
	public void setGroupMembers(List<GroupMember> groupMembers) {
		this.groupMembers = groupMembers;
	}
	
	public void setGitems(List<String[]> gitems) {
		this.gitems = gitems;
	}
	private List<String[]> parseContent(){
		String[] contentArray=null;
		List<String []> gitems=new ArrayList<String[]>();
		if(content!=null){
			contentArray=content.split("\\|");
		}
		
		if(contentArray!=null && contentArray.length>=1){
			for(String item : contentArray ){
				gitems.add(item.split("\\^"));
			}
		}
		return gitems;
	}
    
}
