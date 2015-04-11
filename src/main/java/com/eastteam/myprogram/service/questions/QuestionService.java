package com.eastteam.myprogram.service.questions;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.QuestionMybatisDao;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.service.PageableService;
import com.google.common.collect.Maps;

@Component
@Transactional
public class QuestionService extends PageableService {
	@Autowired
	private QuestionMybatisDao questionMybatisDao;
	
	private int pageSize;
	
	private static Logger logger = LoggerFactory.getLogger(QuestionService.class);
	
	@Override
	public List search(Map parameters, Pageable pageRequest) {
		logger.info("in service, pagesize = " + pageSize);
		
		Map<String,Object>param = Maps.newHashMap();
		param.put("offset", pageRequest.getOffset());
		param.put("pageSize", pageRequest.getPageSize());
		param.put("sort", this.getOrderValue(pageRequest.getSort()));
		param.put("userId", parameters.get("userId"));
		param.put("categoryIdList", parameters.get("categoryIdList"));
		List<Question> questions = questionMybatisDao.search(param);
		
		Iterator<Question> it = questions.iterator();
		while(it.hasNext()){
			Question question = it.next();
			Long answeredCount = questionMybatisDao.questionAnsweredCount(question.getId());
			Long usedCount = questionMybatisDao.questionUsedCount(question.getId());
			
			if(answeredCount > 0){
				question.setPaperAnswered(true);
			}
			if(usedCount > 0){
				question.setPaperUsed(true);
			}
		}
		
		return questions;
	}

	@Override
	public Long getCount(Map parameters) {
		// TODO Auto-generated method stub
		Map param = Maps.newHashMap(parameters);
		return questionMybatisDao.getCount(param);
	}
	
	public String[] splitQuestionOptions(String options){
		String[] questionOptions = options.split("\\^");
		return questionOptions;
	}
	
	public void saveQuestion(Question question){
		questionMybatisDao.save(question);
	}
	
	public Question getQuestion(Long questionId){
		Question question = questionMybatisDao.getQuestion(questionId);
		question.setSplitOptions(splitQuestionOptions(question.getQuestionOptions()));
		
		Long answeredCount = questionMybatisDao.questionAnsweredCount(question.getId());
		Long usedCount = questionMybatisDao.questionUsedCount(question.getId());
		
		if(answeredCount > 0){
			question.setPaperAnswered(true);
		}
		if(usedCount > 0){
			question.setPaperUsed(true);
		}
				
		return question;
	}
	
	public void updateQuestion(Question question){
		questionMybatisDao.update(question);
	}
	
	public void deleteQuestion(Long questionId){
		questionMybatisDao.delete(questionId);
	}
	
	public List<Paper> questionPaper(Long questionId){
		return questionMybatisDao.questionRelatedPaper(questionId);
	}
}
