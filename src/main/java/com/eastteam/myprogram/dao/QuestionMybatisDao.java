package com.eastteam.myprogram.dao;


import java.util.List;
import java.util.Map;

import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;

@MyBatisRepository
public interface QuestionMybatisDao {
	public void save(Question question);
	public void update(Question question);
	public void delete(Long questionId);
	public Question getQuestion(Long questionId);
	public List<Question> search(Map<String, Object> parameters);
	public Long getCount(Map<String, Object> parameters);
	public Long questionAnsweredCount(Long questionId);
	public Long questionUsedCount(Long questionId);
	public List<Paper> questionRelatedPaper(Long questionId);
}
