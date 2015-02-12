package com.eastteam.myprogram.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.entity.User;

public class SurveyMybatisDaoTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(SurveyMybatisDaoTest.class);

	
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
	
	@Test
	public void surveyByGroups() {
		List<Group> groups = new ArrayList<Group>();
		Group group = new Group();
		group.setId(Long.parseLong("1"));
		groups.add(group);
		group = new Group();
		group.setId(Long.parseLong("2"));
		groups.add(group);
		List<Survey> surveys = surveyMybatisDao.findByGroups(groups);
		logger.info(surveys.toString());
		logger.info("result size: " + surveys.size());
	}
	
	@Test
	public void getCountTest() {
		List<Group> groups = new ArrayList<Group>();
		Group group = new Group();
		group.setId(Long.parseLong("1"));
		groups.add(group);
		group = new Group();
		group.setId(Long.parseLong("2"));
		groups.add(group);
		Map parameters = new HashMap<String, Object>();
		parameters.put("groups", groups);
		Long count = surveyMybatisDao.getCount(parameters);
		logger.info("count: " + count);
	}
	
}
