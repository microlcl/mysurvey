/**
 * 
 */
package com.eastteam.myprogram.web.paper;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.paper.PaperService;

/**
 * @author LSS
 *
 */
@Controller
@RequestMapping (value = "/paper")
public class PaperController {
	@Autowired
	private PaperService paperService;
	
	@Autowired
  	@Qualifier("configProperties")
  	private Properties configProperties;
	
	private static Logger logger = LoggerFactory.getLogger(PaperService.class);
	
	@RequestMapping (value = "list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "paper_id") String sortType,
			Model model, ServletRequest request){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		if ((request.getParameter("search_categoryId1") != "") && (request.getParameter("search_categoryId1") != null)) {
			searchParams.put("status", request.getParameter("search_categoryId1"));
		}
		if (request.getParameter("search_categoryId2") != "" && (request.getParameter("search_categoryId2") != null) ) {
			searchParams.put("businessType", request.getParameter("search_categoryId2"));
		}
		List<Paper> papers = this.paperService.search(searchParams);
		model.addAttribute("papers", papers);
		model.addAttribute("sortType", sortType);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		logger.info("in paper Controller: searchParams=" + searchParams);
		Object status = searchParams.get("categoryId1");
		model.addAttribute("status", status);
		Object businessType = searchParams.get("categoryId2");
		model.addAttribute("businessType", businessType);
		
		return "paper/list";
	}
	
	@RequestMapping(value = "show/{id}", method = RequestMethod.GET)
	public String show(@PathVariable("id") String id, Model model) {
		List<Question> questions = this.paperService.getQuestions(id);
		Iterator<Question> it = questions.iterator();
		while(it.hasNext()){
			Question question = it.next();
			String[] questionOptions = this.paperService.splitQuestionOptions(question.getQuestionOptions());
			question.setSplitOptions(questionOptions);
		}
		model.addAttribute("questions", questions);
		return "/paper/paperDetail";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(Model model) {
		return "paper/addPaper";
	}
	
	@RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable("id") String id, Model model) {
		//List<Question> questions = this.paperService.getQuestions(id);
		Paper paper = this.paperService.selectPaper(id);
		Iterator<Question> it = paper.getQuestions().iterator();
		while(it.hasNext()){
			Question question = it.next();
			String[] questionOptions = this.paperService.splitQuestionOptions(question.getQuestionOptions());
			question.setSplitOptions(questionOptions);
		}
		model.addAttribute("selectpaper", paper);
		return "/paper/updatePaper";
	}
	
	@RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable("id") String id, Model model) {
		this.paperService.deletePaper(id);
		
		return "redirect:/paper/list/";
	}
	
	@RequestMapping(value = "publish/{id}", method = RequestMethod.GET)
	public String publish(@PathVariable("id") String id, Model model) {
		logger.info("in paper control publish");
		this.paperService.publishPaper(id);
		
		return "redirect:/paper/list/";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, Paper paperBean, HttpServletRequest request){
		logger.info("=====in paper Controller update parper");
		this.paperService.updatePaper(paperBean);
		
		return "redirect:/paper/list/";
	}
	
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public String save(Model model, Paper paper, HttpServletRequest request){
		logger.info("in paper Controller save parper");

		this.paperService.saveQuestions(paper);
		
		return "redirect:/paper/list/";
	}
	
	/**
	 * 得到某一种businessType下的的papers
	 * @param departmentId
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/api/search", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<User> search(@RequestParam(value = "businessType")String businessType) {
		Map parameters = new HashMap();
		if (!StringUtils.isBlank(businessType)) {
			parameters.put("businessType", businessType);
		}
		return this.paperService.search(parameters);
	}
	
	/**
	 * 得到具体某个paper的问卷内容
	 * @param paperId
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/api/getQuestions/{paperId}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<Question> getQuestions(@PathVariable("paperId") String paperId) {		 
		return this.paperService.getQuestions(paperId);
	}
	
	/**
	 * 得到所有的的papers用于paper选择器
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/api/searchAll", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Page<Paper> searchAll(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "paper_id") String sortType,
			Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		logger.info(searchParams.toString());
		Page<Paper> papers = paperService.getCurrentPageContent(
				searchParams, pageNumber, Integer.parseInt(configProperties.getProperty("list.pagesize")), sortType);
		return papers;
	}
	
}
