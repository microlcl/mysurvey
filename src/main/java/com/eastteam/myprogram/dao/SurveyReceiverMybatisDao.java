package com.eastteam.myprogram.dao;

import java.util.List;
import java.util.Map;
import com.eastteam.myprogram.entity.SurveyReceiver;

@MyBatisRepository
public interface SurveyReceiverMybatisDao {
	public List<SurveyReceiver> search(Map<String, Object> map);
	public void save(Map<String, Object> map);
	public void update(SurveyReceiver surveyReceiver);
	public void delete(Map<String, Object> map);
	public SurveyReceiver getPointedSurveyReceiver(Map<String, Object> map);
	public List<SurveyReceiver> allSurveysByUser(String userId);
	public void saveWithoutGroup(SurveyReceiver surveyreceiver);
	public Long getCount(Map<String, Object> map);
}
