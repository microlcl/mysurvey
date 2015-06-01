package com.eastteam.myprogram.service.answer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.AnswerMybatisDao;
import com.eastteam.myprogram.dao.QuestionMybatisDao;
import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Option;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.service.paper.PaperService;
import com.eastteam.myprogram.service.survey.SurveyService;


@Component
@Transactional
public class AnswerService {
	@Autowired
	private AnswerMybatisDao answerMybatisDao;
	@Autowired
	private QuestionMybatisDao questionMybatisDao;
	@Autowired
	private SurveyService surveyService;
	@Autowired
	private PaperService paperService;
	
	
	private static Logger logger = LoggerFactory.getLogger(AnswerService.class);
	
	public List<Answer> getAnswerForSurveyByUser(String surveyId, String userId) {
		logger.info("getting answer for survey by user");
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("surveyId", surveyId);
		parameters.put("userId", userId);
		return answerMybatisDao.search(parameters);
	}
	
	public List<Question> answerStatisticsBySurvey(Survey survey) {
	
		logger.info("getting answer statistics by question");
		Paper surveyPaper = paperService.selectPaper(String.valueOf(survey.getPaperId()));
		List<Question> questions = paperService.getQuestions(String.valueOf(surveyPaper.getId()));
		
		for (Question question : questions) {
			
			//开放性问题暂时不做处理
			if (question.getQuestionType().equals(Question.OPEN_QUESTION))
				continue;
			
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("surveyId", survey.getId());
			parameters.put("questionId", question.getId());
			List<Answer> allAnswers = answerMybatisDao.search(parameters);
			for (Answer answer : allAnswers) {
				String[] answerIndex = answer.getAnswer().trim().split(",");
				for (String index : answerIndex) {
					question.getOptions()[Integer.parseInt(index) - 1].counting();
					question.counting();
				}
			}
			
			for (Option option : question.getOptions())
				option.setPercent((float)option.getCount()/question.getAllAnswerCounting());
		}
		logger.info("questions of statistics:"+questions.size());
		return questions;
	}
	
	public Set<String> allAnswererIdsBySurvey(String surveyId) {
		
		logger.info("getting all answerer ids by survey");
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("surveyId", surveyId);
		List<Answer> answers = answerMybatisDao.search(parameters);
		List<String> idList = new ArrayList<String>();
		Set<String> idSet = new HashSet<String>();
		
		for (Answer answer : answers) 
			idList.add(answer.getUserId());
		
		idSet.addAll(idList);
		
		return idSet;
	}
}
