package com.eastteam.myprogram.dao;

import com.eastteam.myprogram.entity.Survey;

@MyBatisRepository
public interface SurveyMybatisDao {
	
	public void save(Survey Survey);
	
}
