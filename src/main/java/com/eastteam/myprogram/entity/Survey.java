package com.eastteam.myprogram.entity;

import java.sql.Timestamp;
import java.util.Date;


public class Survey extends IdEntity{
	
	private User creater;
	private String userId;
	private int paperId;
	private String paperURL;
	private String groupsId;
	private Timestamp sentTimestamp;
	private Timestamp deadlineTiemstamp;
	private String description;
	private String subject;
	private String isAnonymous ;
	private String surveyGroup;
	private Paper paper;
	private Timestamp updateTimestamp;
	private String status;
	private String statusString;
	private String groupsString;
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getPaperId() {
		return paperId;
	}
	public void setPaperId(int paperId) {
		this.paperId = paperId;
	}
	public String getGroupsId() {
		return groupsId;
	}
	public void setGroupsId(String groupsId) {
		this.groupsId = groupsId;
	}
	public Timestamp getUpdateTimestamp() {
		return updateTimestamp;
	}
	public void setUpdateTimestamp(Timestamp updateTimestamp) {
		this.updateTimestamp = updateTimestamp;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatusString() {
		return statusString;
	}
	public void setStatusString(String statusString) {
		this.statusString = statusString;
	}
	public String getGroupsString() {
		return groupsString;
	}
	public void setGroupsString(String groupsString) {
		this.groupsString = groupsString;
	}
	public void setSentTimestamp(Timestamp sentTimestamp) {
		this.sentTimestamp = sentTimestamp;
	}
	public void setDeadlineTiemstamp(Timestamp deadlineTiemstamp) {
		this.deadlineTiemstamp = deadlineTiemstamp;
	}
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
	public Date getDeadlineTiemstamp() {
		return deadlineTiemstamp;
	}
	public String getSurveyGroup() {
		return surveyGroup;
	}
	public void setSurveyGroup(String surveyGroup) {
		this.surveyGroup = surveyGroup;
	}
	
	

}
