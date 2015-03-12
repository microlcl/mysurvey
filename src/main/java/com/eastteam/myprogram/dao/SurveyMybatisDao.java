package com.eastteam.myprogram.dao;

import java.util.List;
import java.util.Map;

import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Survey;

@MyBatisRepository
public interface SurveyMybatisDao {
	
	public List<Survey> search(Map<String, Object> parameters);
	public Long getCount(Map<String, Object> parameters);
	public Survey selectSurvey(Long surveyId);
	public void updateSurvey(Survey survey);
	public void save(Survey Survey);
	public List<Survey> findByGroups(List<Group> groups);
}
