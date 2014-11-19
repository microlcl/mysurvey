package com.eastteam.myprogram.entity;

public class Answer extends BaseEntity{
	private Long questionId;
	private String answer;
	public Long getQuestionId() {
		return questionId;
	}
	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}

}
