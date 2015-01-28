package com.eastteam.myprogram.dao;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.Survey;

public class SurveyMybatisDaoTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(QuestionMybatisDao.class);

	
	@Autowired
	private SurveyMybatisDao surveyMybatisDao;
	
	@Test
	public void surveySelectTest() {
		Survey survey = surveyMybatisDao.selectSurvey(Long.parseLong("12305"));
		if (survey == null) {
			logger.info("not found"); 
		}
		logger.info(survey.getSubject());
	}

}
