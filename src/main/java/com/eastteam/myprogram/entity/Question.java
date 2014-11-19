package com.eastteam.myprogram.entity;


public class Question extends IdEntity {
	
	/** 单选题 **/
	public static final String SINGLE_CHOICE = "1";
	/** 多选题 **/
	public static final String MULTIPLE_CHOICE = "2";
	/** 开放性问题 **/
	public static final String OPEN_QUESTION = "3";

	private String question;
	private String questionType;
	private String questionOptions;
	private String trashed;
	private String businessType;
	/**此问题有谁增加**/
	private User creater;

	public User getCreater() {
		return creater;
	}
	public void setCreater(User creater) {
		this.creater = creater;
	}
	private int position;
	private boolean paperAnswered = false;
	private boolean paperUsed = false;
	private Option[] options;

	@Deprecated
	private String[] splitOptions;
	
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getQuestionType() {
		return questionType;
	}
	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	public String getQuestionOptions() {
		return questionOptions;
	}
	
	public void setQuestionOptions(String questionOptions) {
		this.questionOptions = questionOptions;
		// 得到questionOptions的同时，用^分隔此字符串，并初始化选项List
		String[] optionsArray = questionOptions.split("\\^");
		if (optionsArray != null) {
			this.options = new Option[optionsArray.length];
		}
		for(int i = 0; i < optionsArray.length; i ++) {
			options[i] = (new Option(optionsArray[i]));
		}
	}	
	@Deprecated
	public String[] getSplitOptions() {
		return splitOptions;
	}
	@Deprecated
	public void setSplitOptions(String[] splitOptions) {
		this.splitOptions = splitOptions;
	}
	public String getTrashed() {
		return trashed;
	}
	public void setTrashed(String trashed) {
		this.trashed = trashed;
	}
	public String getBusiness_type() {
		return businessType;
	}
	public void setBusiness_type(String business_type) {
		this.businessType = business_type;
	}
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
	}
	public boolean isPaperAnswered() {
		return paperAnswered;
	}
	public void setPaperAnswered(boolean paperAnswered) {
		this.paperAnswered = paperAnswered;
	}
	public boolean isPaperUsed() {
		return paperUsed;
	}
	public void setPaperUsed(boolean paperUsed) {
		this.paperUsed = paperUsed;
	}
	public Option[] getOptions() {
		return options;
	}
	public void setOptions(Option[] options) {
		this.options = options;
	}
	
}
