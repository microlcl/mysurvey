/**
 * 
 */
package com.eastteam.myprogram.service.paper;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.PaperMybatisDao;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.service.PageableService;
import com.google.common.collect.Maps;

/**
 * @author LSS
 *
 */

@Component
@Transactional
public class PaperService extends PageableService{
	@Autowired
	private PaperMybatisDao paperMybatisDao;
	
	private int pageSize;
	
	private static Logger logger = LoggerFactory.getLogger(PaperService.class);
	
	
	public List search(Map parameters) {
		logger.info("in service, pagesize = " + pageSize);
		Map param = Maps.newHashMap(parameters);
		return paperMybatisDao.search(param);
	}
	

	public List<Question> getQuestions(String paper_id){
		return paperMybatisDao.selectQuestions(paper_id);
	}
	
	public String[] splitQuestionOptions(String options){
		String[] questionOptions = options.split("\\^");
		return questionOptions;
	}
	
	public void saveQuestions(Paper paper) {
		logger.info("in paper save service");
		this.paperMybatisDao.insertPaper(paper);
		String paperId = Long.toString(paper.getId());
		Iterator<Question> it = paper.getQuestions().iterator();
		while(it.hasNext()){
			Question question = it.next();
			HashMap<String, Object> map = new HashMap<String, Object>();
			if (question.getId() != null) {
				map.put("paperId", paperId);
				map.put("questionId", question.getId());
				map.put("position", question.getPosition());
				this.paperMybatisDao.insertQuestions(map);
			}
		}
	}
	
	public Paper selectPaper(String paperId) {
		logger.info("in paper select paper service");
		return(this.paperMybatisDao.selectPaper(paperId));
		
	}
	
	public void deletePaper(String paperId) {
		logger.info("in paper delete service");
//		this.paperMybatisDao.deletePaper(Long.parseLong(paperId));
//		this.paperMybatisDao.deleteQuestions(Long.parseLong(paperId));
		this.paperMybatisDao.discardPaper(Long.parseLong(paperId));
		
	}
	
	public void publishPaper(String paperId) {
		logger.info("in paper publish service");
		this.paperMybatisDao.publishPaper(Long.parseLong(paperId));
	}
	
	public void updatePaper(Paper paper) {
		logger.info("in paper update service");
		logger.info("正在更新的paper" + paper);
		this.paperMybatisDao.updatePaper(paper);
		this.paperMybatisDao.deleteQuestions(paper.getId());
		
		Iterator<Question> it = paper.getQuestions().iterator();
		while(it.hasNext()){
			Question question = it.next();
			HashMap<String, Object> map = new HashMap<String, Object>();
			if (question.getId() != null) {
				map.put("paperId", paper.getId());
				map.put("questionId", question.getId());
				map.put("position", question.getPosition());
				this.paperMybatisDao.insertQuestions(map);
			}
		}
	}


	@Override
	public List search(Map parameters, Pageable pageRequest) {
		// TODO Auto-generated method stub
		Map param = Maps.newHashMap(parameters);
		param.put("offset", pageRequest.getOffset());
		param.put("pageSize", pageRequest.getPageSize());
		param.put("sort", this.getOrderValue(pageRequest.getSort()));
		return this.paperMybatisDao.search(param);
	}


	@Override
	public Long getCount(Map parameters) {
		// TODO Auto-generated method stub
		return this.paperMybatisDao.getCount(parameters);
	}
}
