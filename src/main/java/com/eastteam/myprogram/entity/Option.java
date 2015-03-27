package com.eastteam.myprogram.entity;

/**
 * 问题选项
 * @author lichlei
 *
 */
public class Option extends BaseEntity{
	private String content;
	private String value;
	private boolean checked = false;
	private int count;	//用于答案统计时记录该选项被选择的次数
	private float percent;	//用于答案统计时记录该选项所占总共答案百分比
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public float getPercent() {
		return percent;
	}

	public void setPercent(float percent) {
		this.percent = percent;
	}

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
	
	public void counting() {
		this.count++;
	}
	

}
