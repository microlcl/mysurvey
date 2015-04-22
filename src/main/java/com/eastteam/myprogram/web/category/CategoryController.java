package com.eastteam.myprogram.web.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.eastteam.myprogram.entity.Category;
import com.eastteam.myprogram.entity.CategoryLiteBean;
import com.eastteam.myprogram.service.category.CategoryService;
import com.google.common.collect.Lists;

@Controller
@RequestMapping(value = "/category")
public class CategoryController {
	
	private static Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping(method = RequestMethod.GET, value="/list")
	public String list() {
		return "category/list";
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/api/search", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, List> search() {
		Map<String, List> map = new HashMap<String, List>();
		map.put("rows", categoryService.search());
		return map;
	}
	
	@RequestMapping(method = RequestMethod.POST,value = "/api/subId/{pid}")
	@ResponseBody
	public String getNextSubId(@PathVariable("pid")String pid) {
		logger.info("pid={}", pid);
		String nextSubId = this.categoryService.getNextSubId(pid);
		logger.info("nextSubId={}", nextSubId);
		return nextSubId;
	}
	
	@RequestMapping(method = RequestMethod.POST,value = "/api/save")
	@ResponseBody
	public ResponseEntity<?> save(Category category) {

		logger.info("in save:" + category);
		this.categoryService.save(category);
		
		return new ResponseEntity(HttpStatus.CREATED);
	}
	
	@RequestMapping(value = "/api/delete/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void delete(@PathVariable("id") String id) {
		categoryService.delete(id);
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/api/getAll/{functionId}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<CategoryLiteBean> getAll(@PathVariable("functionId")String functionId) {
		
		return categoryService.getFuntionCategorys(functionId);
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/api/getSurveyStatus", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<CategoryLiteBean> getSurveyStatus() {
		List<CategoryLiteBean> surveyStatusList1 = Lists.newArrayList();
		List<CategoryLiteBean> surveyStatusList = Lists.newArrayList();
		CategoryLiteBean surveyStatus = new CategoryLiteBean();
		surveyStatus.setName("调查状态");
		CategoryLiteBean surveyStatusD = new CategoryLiteBean();
		surveyStatusD.setId("D");
		surveyStatusD.setName("草稿");
		surveyStatusList.add(surveyStatusD);
		CategoryLiteBean surveyStatusP = new CategoryLiteBean();
		surveyStatusP.setId("P");
		surveyStatusP.setName("已发布");
		surveyStatusList.add(surveyStatusP);
		CategoryLiteBean surveyStatusF = new CategoryLiteBean();
		surveyStatusF.setId("F");
		surveyStatusF.setName("已完成");
		surveyStatusList.add(surveyStatusF);
		surveyStatus.setChildren(surveyStatusList);
		surveyStatusList1.add(surveyStatus);
		return surveyStatusList1;
	}
	/**
	 * 得到一级子节点，用于生产下拉列表
	 * @param functionId
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/api/getChildren/{functionId}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<CategoryLiteBean> getChildren(@PathVariable("functionId")String functionId) {		
		return categoryService.getFuntionCategorysForList(functionId);
	}	
}
