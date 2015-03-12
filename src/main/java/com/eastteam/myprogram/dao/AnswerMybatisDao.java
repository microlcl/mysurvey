package com.eastteam.myprogram.dao;

import java.util.List;
import java.util.Map;

import com.eastteam.myprogram.entity.Answer;

@MyBatisRepository
public interface AnswerMybatisDao {
	public void save(Answer answer);
	public void update(Answer answer);
	public void delete(Long answerId);
	public Answer getAnswer(Long answerId);
	public List<Answer> search(Map<String, Object> parameters);
	public void saveAction(List<Answer> answers);
	public void updateAction(List<Answer> answers);
	public Long getCount(Map<String, Object> parameters);
}
