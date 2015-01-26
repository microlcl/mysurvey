package com.eastteam.myprogram.web.survey;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.eclipse.jetty.server.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpRequest;
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

import sun.text.resources.FormatData;

import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.myGroup.MyGroupService;
import com.eastteam.myprogram.service.paper.PaperService;
import com.eastteam.myprogram.service.questions.QuestionService;
import com.eastteam.myprogram.service.survey.SurveyService;
import com.eastteam.myprogram.web.Servlets;
import com.google.common.collect.Maps;

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
	
	
	@RequestMapping(value = "publishSurvey/{id}", method = RequestMethod.GET)
	public String addQuestion(@PathVariable("id") String id,Model model,HttpSession session){
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
		survey.setPaperURL("http://www.ibm.com/cn/zh/");
		if(surveyService.publishSurvey(survey)){
			return "survey/publishOK";
		}else {
			return "survey/publishFail";
		}
		
	}
	

}
