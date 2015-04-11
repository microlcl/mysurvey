package com.eastteam.myprogram.web.questions;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.questions.QuestionService;
import com.eastteam.myprogram.web.Servlets;
import com.google.common.collect.Maps;

@Controller
@RequestMapping (value = "/question")
public class QuestionController {
	@Autowired
	private QuestionService questionService;
	
	@Autowired
  	@Qualifier("configProperties")
  	private Properties configProperties;
	
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("question", "问题名称");
		sortTypes.put("question_id", "默认顺序");
		sortTypes.put("creat_timestamp DESC","创建时间");
	}
	
	private static Logger logger = LoggerFactory.getLogger(QuestionController.class);
	
	@RequestMapping (value = "list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "creat_timestamp DESC") String sortType,
			Model model, ServletRequest request, HttpSession session){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams.put("trashed", "F");
		searchParams.put("sort", sortType);

		logger.info(searchParams.toString());
		Page<Question> questions = questionService.getCurrentPageContent(
				searchParams, pageNumber, Integer.parseInt(configProperties.getProperty("question.pagesize")), sortType);
		List<Question> allQuestions = questions.getContent();
		Iterator<Question> it = allQuestions.iterator();
		while(it.hasNext()){
			Question question = it.next();
			String[] questionOptions = questionService.splitQuestionOptions(question.getQuestionOptions());
			question.setSplitOptions(questionOptions);
		}
		
		model.addAttribute("questions", questions);
		model.addAttribute("sortType", sortType);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("sortTypes", sortTypes);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		Object categories = searchParams.get("categoryId");
		model.addAttribute("categories", categories);
		
		logger.info("searchParams=" + searchParams);
		return "question/list";
	}
	
	@RequestMapping(value = "addQuestion", method = RequestMethod.GET)
	public String addQuestion(Model model){
		return "question/addQuestion";
	}
	
	@RequestMapping(value = "saveQuestion", method = RequestMethod.POST)
	public String saveQuestion(@ModelAttribute Question question, RedirectAttributes redirectAttributes,HttpSession session){
		if(question.getQuestionType().equals("3"))
			question.setQuestionOptions("");
		else{
			StringBuffer sb = new StringBuffer();
			for(int i=0; i<question.getSplitOptions().length; i++){
				if(i == question.getSplitOptions().length-1){
					sb.append(question.getSplitOptions()[i]);
				}
				else
					sb.append(question.getSplitOptions()[i] + "^");
			}
			question.setQuestionOptions(sb.toString());
		}
		User user = (User)session.getAttribute("user");
		question.setCreater(user);
		questionService.saveQuestion(question);
		
		return "redirect:/question/list/";
	}
	
	@RequestMapping(value = "editQuestion/question_{id}", method = RequestMethod.GET)
	public String editQuestion(@PathVariable("id") String id, Model model){
		Question question = this.questionService.getQuestion(Long.parseLong(id));
		model.addAttribute("question", question);
		
		List<Paper> papers = this.questionService.questionPaper(Long.parseLong(id));
		model.addAttribute("papers", papers);
		
		return "question/editQuestion";
	}
	
	@RequestMapping(value = "updateQuestion", method = RequestMethod.POST)
	public String updateQuestion(@ModelAttribute Question question, RedirectAttributes redirectAttributes){
		if(question.getQuestionType().equals("3"))
			question.setQuestionOptions("");
		else{
			StringBuffer sb = new StringBuffer();
			for(int i=0; i<question.getSplitOptions().length; i++){
				if(i == question.getSplitOptions().length-1){
					sb.append(question.getSplitOptions()[i]);
				}
				else
					sb.append(question.getSplitOptions()[i] + "^");
			}
			question.setQuestionOptions(sb.toString());
		}
		
		questionService.updateQuestion(question);
		
		return "redirect:/question/list/";
	}
	
	@RequestMapping(value = "deleteQuestion/question_{id}", method = RequestMethod.GET)
	public String deleteQuestion(@PathVariable("id") String id,  RedirectAttributes redirectAttributes){
		questionService.deleteQuestion(Long.parseLong(id));
		
		return "redirect:/question/list/";
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/api/search", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Page<Question> search(@RequestParam(value = "page", defaultValue = "1") int pageNumber, 
			@RequestParam(value = "sortType", defaultValue = "question_id") String sortType,
			Model model, ServletRequest request) {		
	    Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
	    logger.info("in ajax response:" + searchParams.toString());
	    Page<Question> questions = questionService.getCurrentPageContent(searchParams, pageNumber, Integer.parseInt(configProperties.getProperty("question.pagesize")), sortType);

	    List<Question> allQuestions = questions.getContent();
	    Iterator<Question> it = allQuestions.iterator();
	    while(it.hasNext()){
	      Question question = it.next();
	      String[] questionOptions = questionService.splitQuestionOptions(question.getQuestionOptions());
	      question.setSplitOptions(questionOptions);
	    }  

	    return questions;
	  }	
	
//	@RequestMapping(value = "/searchPaper/question_{id}", method = RequestMethod.GET)
//	@ResponseBody
//	public Map paperQuestion(@PathVariable("id") String id,  RedirectAttributes redirectAttributes){
//		Map papers = 
//	}
}
