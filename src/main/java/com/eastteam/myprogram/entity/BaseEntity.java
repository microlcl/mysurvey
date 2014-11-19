package com.eastteam.myprogram.entity;

import org.apache.commons.lang3.builder.ToStringBuilder;

public abstract class BaseEntity {
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
