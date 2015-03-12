package com.eastteam.myprogram.service;

import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.dao.SpringTransactionalTestCase;
import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Option;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.service.answer.AnswerService;
import com.eastteam.myprogram.service.paper.PaperService;

public class AnswerServiceTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(AnswerServiceTest.class);

	@Autowired
	private PaperService paperService;
	@Autowired
	private AnswerService answerService;
	
	@Test
	public void setAnswerTest() {
		
		List<Question> surveyQuestions = paperService.getQuestions("1");
		List<Answer> surveyAnswers = answerService.getAnswerForSurveyByUser("1", "admin");
		for (Question question : surveyQuestions) {
			for (Answer answer : surveyAnswers) {
				if (question.getId().equals(answer.getQuestionId())){
					if (question.getQuestionType().equals(Question.OPEN_QUESTION))	//如果是开放性问题
						question.setOpenAnswer(answer.getAnswer());
					else {	//如果是非开放性问题
						String[] answerIndex = answer.getAnswer().trim().split(",");
						for (String index : answerIndex) {
							question.getOptions()[Integer.parseInt(index)].setChecked(true);
						}
					}
				}
			}
		}
		
		for (Question question : surveyQuestions) {
			logger.info("--------------------------");
			logger.info("id:"+question.getId());
			logger.info(question.getQuestion());
			for (Option option : question.getOptions())
			logger.info(option.getValue() + " : " +option.getContent() + " : " + option.isChecked());
		}
	}

}
