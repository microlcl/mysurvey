package com.eastteam.myprogram.service.answer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.AnswerMybatisDao;
import com.eastteam.myprogram.entity.Answer;


@Component
@Transactional
public class AnswerService {
	@Autowired
	private AnswerMybatisDao answerMybatisDao;
	
	private static Logger logger = LoggerFactory.getLogger(AnswerService.class);
	
	public List<Answer> getAnswerForSurveyByUser(String surveyId, String userId) {
		logger.info("getting answer for survey by user");
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("surveyId", surveyId);
		parameters.put("userId", userId);
		return answerMybatisDao.search(parameters);
	}
}
