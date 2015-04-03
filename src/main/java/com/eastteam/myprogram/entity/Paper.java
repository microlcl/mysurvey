/**
 * 
 */
package com.eastteam.myprogram.entity;

import java.util.List;


/**
 * @author LSS
 *
 */
public class Paper extends IdEntity {
	
	private String paperName;
	private Category businessType;
	private Category status;
	private List<Question> questions;
	private User creater;
	
	
	public String getPaperName() {
		return paperName;
	}
	public void setPaperName(String paperName) {
		this.paperName = paperName;
	}
	public Category getBusinessType() {
		return businessType;
	}
	public void setBusinessType(Category businessType) {
		this.businessType = businessType;
	}
	public Category getStatus() {
		return status;
	}
	public void setStatus(Category status) {
		this.status = status;
	}
	public List<Question> getQuestions() {
		return questions;
	}
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	public User getCreater() {
		return creater;
	}
	public void setCreater(User creater) {
		this.creater = creater;
	}

}
