package com.eastteam.myprogram.entity;

import java.util.Date;

public class SurveyReceiver {
	
	private Long surveyId;
	private String userId;
	private String nickName;
	private Date update_timeStamp;
	private String status;
	
	
	public Long getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(Long surveyId) {
		this.surveyId = surveyId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Date getUpdate_timeStamp() {
		return update_timeStamp;
	}
	public void setUpdate_timeStamp(Date update_timeStamp) {
		this.update_timeStamp = update_timeStamp;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	} 
	
	

}
