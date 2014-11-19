package com.eastteam.myprogram.web;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * 与页面表单字段对应的FormBean。
 * 有时候页面呈现的内容和Entity并不是对应的，有可能是几个Entity组成一个表单，
 * 所以我们需要FormBean来作为页面数据的model.
 * 对于页面需要提交数组对象的情况，尤其必要。
 * 
 * @author lichlei
 *
 */
public abstract class BaseFormBean {
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
