/**
 * 
 */
package com.eastteam.myprogram.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.Category;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;

/**
 * @author LSS
 *
 */
public class PaperMybatisDaoTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(PaperMybatisDaoTest.class);
	
	@Autowired
	private PaperMybatisDao paperMybatisDao;
	
	@Test
	public void SearchPaperTest(){
		logger.info("in Paper search test");
		Map params = new HashMap();
		params.put("businessType", "1-0-2-0");
		params.put("formType", "1-0-12-3");
		List<Paper> result = paperMybatisDao.search(params);
		logger.info("result.size=" + result.size());
		logger.info("result=" + result);
	}
	
	@Test
	public void getCountTest() throws Exception {
		logger.info("In Paper get count test");
		
		Long count = paperMybatisDao.getCount(null);
		logger.info("count=" + count);
	}
	
	@Test
	public void getQuestionsTest() throws Exception {
		logger.info("In Paper get questions test");
		String paper_id = "1";
		List<Question> questions = this.paperMybatisDao.selectQuestions(paper_id);
		logger.info("=====Test Questions: " + questions);
	}
	
	@Test
	public void insertPaperTest() throws Exception {
		logger.info("In Paper insert paper test");
		Paper paper = new Paper();
		paper.setPaperName("新增调查问卷测试");
		Category businessType = new Category();
		businessType.setId("1-0-2-0");
		paper.setBusinessType(businessType);
		Category status = new Category();
		status.setId("1-0-1-0");
		paper.setStatus(status);
		this.paperMybatisDao.insertPaper(paper);
		logger.info("新增调查问卷的id: " + paper.getId());
		logger.info("插入数据之后测count " + this.paperMybatisDao.getCount(null));
		logger.info("插入数据之后测调查问卷内容 ：");
		SearchPaperTest();
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("paper.getId()=====" + paper.getId());
		map.put("paperId", paper.getId());
		map.put("questionId", 1);
		map.put("position", 10);
		this.paperMybatisDao.insertQuestions(map);
		logger.info("=====新增调查问卷的问题之后此问卷的所有问题：" + this.paperMybatisDao.selectQuestions(Long.toString(paper.getId())));
	}
	
	@Test
	public void selectPaperTest() throws Exception {
		logger.info("In paper select paper test ");
		String paperId = "1";
		logger.info("====Select Paper info: " + this.paperMybatisDao.selectPaper(paperId));
	}
	
	@Test
	public void deletePaperTest() throws Exception {
		logger.info("In paper delete paper test ");
		String paperId = "1";
		this.paperMybatisDao.deletePaper(Long.parseLong(paperId));
		logger.info("删除paper之后paper是否还存在： " + this.paperMybatisDao.selectPaper(paperId));
		this.paperMybatisDao.deleteQuestions(Long.parseLong(paperId));
		logger.info("删除paper之后questions关联表是否还存在： " + this.paperMybatisDao.selectQuestions(paperId));
		logger.info("删除问卷之后测count " + this.paperMybatisDao.getCount(null));
	}
	
	@Test
	public void publishPaperTest() throws Exception {
		logger.info("In Paper publish paper test");
		String paperId = "3";
		this.paperMybatisDao.publishPaper(Long.parseLong(paperId));
		logger.info("测试发布paper后它的状态： " + this.paperMybatisDao.selectPaper(paperId));
	}
	
	@Test
	public void updatePaperTest() throws Exception {
		logger.info("In Paper update paper test");
		Paper paper = this.paperMybatisDao.selectPaper("1");
		this.paperMybatisDao.updatePaper(paper);
		logger.info("测试更新paper后它的状态： " + this.paperMybatisDao.selectPaper("1"));
	}
}
