package com.eastteam.myprogram.service;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.dao.QuestionMybatisDao;
import com.eastteam.myprogram.dao.SpringTransactionalTestCase;
import com.eastteam.myprogram.service.survey.SurveyService;

public class SurveyServiceTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(SurveyServiceTest.class);

	@Autowired
	private SurveyService surveyService;
	
	@Test
	public void getAllParticipationByUserTest() {
		surveyService.getAllParticipationByUser("admin", 1, 15, "survey_id");
	}
	

}
