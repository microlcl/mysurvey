package com.eastteam.myprogram.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.Answer;

public class AnswerMybatisDaoTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(AnswerMybatisDaoTest.class);

	@Autowired
	private AnswerMybatisDao answerMybatisDao;
	
	@Test
	public void searchTest() {
		Map<String,Object> parameters = new HashMap<String, Object>();
		parameters.put("surveyId", 1);
		parameters.put("userId", "admin");
		List<Answer> answers = answerMybatisDao.search(parameters);
		for (Answer answer : answers) {
			logger.info("-------------------------------------");
			logger.info("survey:"+answer.getSurveyId());
			logger.info("question:"+answer.getQuestionId());
			logger.info("user:"+answer.getUserId());
			logger.info("answer:"+answer.getAnswer());
		}
	}

}
