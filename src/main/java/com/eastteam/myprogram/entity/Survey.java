package com.eastteam.myprogram.entity;

import java.util.Date;


public class Survey extends IdEntity{
	
	private User creater;
	private String paperURL;
	private String subject;
	private String description;
	private String isAnonymous ;
	private Date sentTimestamp;
	private Date deadlineTiemstamp;
	private String surveyGroup;
	private Paper paper;
	
	
	public Paper getPaper() {
		return paper;
	}
	public void setPaper(Paper paper) {
		this.paper = paper;
	}
	public User getCreater() {
		return creater;
	}
	public void setCreater(User creater) {
		this.creater = creater;
	}
	public String getPaperURL() {
		return paperURL;
	}
	public void setPaperURL(String paperURL) {
		this.paperURL = paperURL;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIsAnonymous() {
		return isAnonymous;
	}
	public void setIsAnonymous(String isAnonymous) {
		this.isAnonymous = isAnonymous;
	}
	public Date getSentTimestamp() {
		return sentTimestamp;
	}
	public void setSentTimestamp(Date sentTimestamp) {
		this.sentTimestamp = sentTimestamp;
	}
	public Date getDeadlineTiemstamp() {
		return deadlineTiemstamp;
	}
	public void setDeadlineTiemstamp(Date deadlineTiemstamp) {
		this.deadlineTiemstamp = deadlineTiemstamp;
	}
	public String getSurveyGroup() {
		return surveyGroup;
	}
	public void setSurveyGroup(String surveyGroup) {
		this.surveyGroup = surveyGroup;
	}
	
	

}
