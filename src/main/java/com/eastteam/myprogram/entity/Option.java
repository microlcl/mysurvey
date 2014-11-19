package com.eastteam.myprogram.entity;

/**
 * 问题选项
 * @author lichlei
 *
 */
public class Option extends BaseEntity{
	private String content;
	private String value;
	boolean checked = false;
	
	public Option() {
		
	}
	
	public Option(String content) {
		this.content = content;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	

}
