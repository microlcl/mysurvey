package com.eastteam.myprogram.web.survey;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.myGroup.MyGroupService;
import com.eastteam.myprogram.service.paper.PaperService;
import com.eastteam.myprogram.service.survey.SurveyService;
import com.eastteam.myprogram.web.Servlets;
import com.sun.net.httpserver.HttpsServer;

@Controller
@RequestMapping (value = "/survey")
public class SurveyController {
	@Autowired
	private SurveyService surveyService;
	@Autowired
	private PaperService paperService;
	@Autowired
	private MyGroupService myGroupService;
	
	@Autowired
  	@Qualifier("configProperties")
  	private Properties configProperties;
	
	private static Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	@RequestMapping (value = "myLaunch", method = RequestMethod.GET)
	public String myLaunch(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "paper_id") String sortType,
			Model model, ServletRequest request, HttpSession session) {
		
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams.put("userId", ((User) session.getAttribute("user")).getId());
		String userId = request.getParameter("search_userId");
		int pageSize = Integer.parseInt(configProperties.getProperty("survey.pageSize"));
		
		logger.info(searchParams.toString());
		
		Page<Survey> surveys = surveyService.getCurrentPageContent(
				searchParams, pageNumber, pageSize, sortType);
		logger.info("result length: " + surveys.getContent().size());
		
		
		model.addAttribute("surveys", surveys);
		model.addAttribute("sortType", sortType);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		logger.info("searchParams=" + searchParams);
		return "survey/myLaunch";
	}
	
	@RequestMapping (value = "myParticipation", method = RequestMethod.GET)
	public String myParicipation(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "paper_id") String sortType,
			Model model, ServletRequest request, HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		String userId = user.getId();
		//surveyService.getAllSurveysByUser(userId);
		
		return "survey/myParticipation";
	}
	
	@RequestMapping (value = "show/{id}", method = RequestMethod.GET)
	public String surveyDetail(@PathVariable("id") String surveyId,Model model,HttpSession session) {
		
		Survey survey = surveyService.selectSurvey(surveyId);
		if (survey == null)
			return "error/404";
		model.addAttribute(survey);
		return "survey/surveyDetail";
	}
	
	/**
	 * 根据userId或者groupId分页查询survey
	 * @param pageNumber
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping (value = "/api/search", method = RequestMethod.GET)
	public Page<Survey> mySurvey(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "paper_id") String sortType,
			Model model, ServletRequest request) {
		
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		
		String userId = request.getParameter("search_userId");
		String groupId = request.getParameter("search_groupId");
		int pageSize = Integer.parseInt(configProperties.getProperty("survey.pagesize"));
		
		if (StringUtils.isNotBlank(userId)) {
			searchParams.put("userId", userId);
		}
		
		if (StringUtils.isNotBlank(groupId)) {
			searchParams.put("groupId", groupId);
		}
		
		Page<Survey> surveys = this.surveyService.getCurrentPageContent(
				searchParams, pageNumber, pageSize, sortType);
		
		return surveys;
	}
	
	@RequestMapping(value = "publishSurvey/{id}", method = RequestMethod.GET)
	public String publishSurvey(@PathVariable("id") String id,Model model,HttpSession session){
		Paper paper=paperService.selectPaper(id);
		List<Group> groups=myGroupService.search(((User)session.getAttribute("user")).getId());
		model.addAttribute("paper",paper);
		model.addAttribute("groups",groups);
		return "survey/publishSurvey";
	}
	
	@RequestMapping(value = "publishAndSaveSurvey/{paperid}", method = RequestMethod.POST)
	public String publishAndSaveSurvey(@ModelAttribute Survey survey,@PathVariable("paperid") String paperid,RedirectAttributes redirectAttributes,HttpSession session){
		survey.setCreater((User) session.getAttribute("user"));
		survey.setPaper(paperService.selectPaper(paperid));
//		survey.setPaperURL(request.getContextPath()+"/survey/accessSurvey/"+survey.getId());
//		System.out.println(survey.getPaperURL());
		if(surveyService.publishSurvey(survey)){
			return "survey/publishOK";
		}else {
			return "survey/publishFail";
		}
		
	}
	
	@RequestMapping(value = "accessSurvey/{id}", method = RequestMethod.GET)
	public String accessSurvey(@PathVariable("id") String id,Model model,HttpSession session){
		Survey survey=surveyService.selectSurvey(id);
		List<Question> questions = paperService.getQuestions(String.valueOf(survey.getPaperId()));
		Iterator<Question> it = questions.iterator();
		while(it.hasNext()){
			Question question = it.next();
			String[] questionOptions = paperService.splitQuestionOptions(question.getQuestionOptions());
			question.setSplitOptions(questionOptions);
		}
		model.addAttribute("questions", questions);
		model.addAttribute("survey", survey);
		return "survey/action";
	}
	

}
