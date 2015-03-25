package com.eastteam.myprogram.web.survey;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;
import org.apache.commons.lang3.StringUtils;
import org.eclipse.jetty.http.HttpURI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.answer.AnswerService;
import com.eastteam.myprogram.service.myGroup.MyGroupService;
import com.eastteam.myprogram.service.paper.PaperService;
import com.eastteam.myprogram.service.survey.SurveyService;
import com.eastteam.myprogram.web.Servlets;
import com.sun.org.apache.bcel.internal.generic.NEW;

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
	private AnswerService answerService;
	
	private static final String ServiceAddr="http://localhost:8080";
	
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
		
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		int pageSize = Integer.parseInt(configProperties.getProperty("survey.pageSize"));
		
		User user = (User) session.getAttribute("user");
		String userId = user.getId();
		Page<Survey> surveys = surveyService.getAllParticipationByUser(userId, pageNumber, pageSize, sortType);
		
		logger.info("result length: " + surveys.getContent().size());
		
		model.addAttribute("surveys", surveys);
		model.addAttribute("sortType", sortType);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		
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
	
	@RequestMapping(value = "surveyDetail/{id}", method = RequestMethod.GET)
	public String publishSurvey(@PathVariable("id") String id,Model model,HttpSession session){
		Survey survey = surveyService.selectSurvey(id);
		Paper paper=paperService.selectPaper(String.valueOf(survey.getPaperId()));
		logger.info(survey.getIsAnonymous());
		List<Group> groups=myGroupService.search(((User)session.getAttribute("user")).getId());
		for (Group group : groups) {
			for (String gid : survey.getGroupIds())
				if (gid.equals(String.valueOf(group.getId())))
					group.setFlagString("");
		}
		String receivers=survey.getReceivers();
		String _receivers="";
		Group receiversGroup =new Group();
		receiversGroup.setContent(receivers);
		System.out.println("==>receivers:"+receivers);
		receiversGroup.setGitems();
		List<String[]> gitems = receiversGroup.getGitems();
		for(String gitem[] : gitems){
			if(gitem[2].equals("0")){
				_receivers += gitem[1]+",";
			}
		}
		model.addAttribute("receivers",_receivers);
		model.addAttribute("gitems",gitems);
		model.addAttribute("survey", survey);
		model.addAttribute("paper",paper);
		model.addAttribute("groups",groups);
		model.addAttribute("isPublish", true);
		return "survey/publishSurvey";
	}
	
	@RequestMapping(value = "createSurvey/{id}", method = RequestMethod.GET)
	public String createSurvey(@PathVariable("id") String id,Model model,HttpSession session){
		Paper paper=paperService.selectPaper(id);
		List<Group> groups=myGroupService.search(((User)session.getAttribute("user")).getId());
		model.addAttribute("paper",paper);
		model.addAttribute("groups",groups);
		model.addAttribute("isPublish", false);
		return "survey/publishSurvey";
	}
	
	@RequestMapping(value = "surveyAction/{id}", method = RequestMethod.POST)
	public String publishAndSaveSurvey(@ModelAttribute Survey survey,@PathVariable("id") String id,RedirectAttributes redirectAttributes,HttpSession session,HttpServletRequest request){
		
		String isPublish = request.getParameter("isPublish");
		if (isPublish.equals("true")) {
			if (survey.getId() == null)
				survey.setId(Long.parseLong(id));
			survey.setStatus("P");
			surveyService.updateSurvey(survey);
			return "survey/publishOK";
		} else {
			survey.setCreater((User) session.getAttribute("user"));
			survey.setPaper(paperService.selectPaper(id));
			survey.setPaperURL(ServiceAddr+request.getContextPath()+"/survey/accessSurvey/");
			if(surveyService.createSurvey(survey)){
				return "survey/publishOK";
			} else {
				return "survey/publishFail";
			}
		}
	}
	
	/*@RequestMapping(value = "createAndSaveSurvey/{paperid}", method = RequestMethod.POST)
	public String createAndSaveSurvey(@ModelAttribute Survey survey,@PathVariable("paperid") String paperid,RedirectAttributes redirectAttributes,HttpSession session,HttpServletRequest request){
		survey.setCreater((User) session.getAttribute("user"));
		survey.setPaper(paperService.selectPaper(paperid));
		survey.setPaperURL(ServiceAddr+request.getContextPath()+"/survey/accessSurvey/");
		System.out.println(survey.getPaperURL());
		if(surveyService.createSurvey(survey)){
			return "survey/publishOK";
		} else {
			return "survey/publishFail";
		}
		
	}
	*/
	@RequestMapping(value = "saveAction", method = RequestMethod.POST)
	public String saveAction(RedirectAttributes redirectAttributes,HttpSession session,ServletRequest request){
		
		Map<String, Object> answerQuestionId = Servlets.getParametersStartingWith(request, "questionId_");
		Map<String, Object> answerAnswer = Servlets.getParametersStartingWith(request, "answer_");
		String isUpdate = request.getParameter("isUpdate");
		logger.info("current operation is update : " + isUpdate);
		List<Answer> answers =new ArrayList<Answer>();
		for(String key : answerQuestionId.keySet()){
			Answer answer= new Answer();
			answer.setAnswer(answerAnswer.get(key).toString());
			answer.setQuestionId(Long.parseLong(answerQuestionId.get(key).toString()));
			answer.setSurveyId(Long.parseLong(request.getParameter("surveyId")));
			answer.setUserId(((User)session.getAttribute("user")).getId());
			answers.add(answer);
		}
		if (isUpdate.equals("true"))
			surveyService.updateAction(answers);
		else {
			Survey survey=surveyService.selectSurvey(request.getParameter("surveyId"));
			String receivers=survey.getReceivers();
			String updatedReceivers="";
			Group receiversGroup= new Group();
			receiversGroup.setContent(receivers);
			receiversGroup.setGitems();
			List<String []> receiversGitem =receiversGroup.getGitems();
			for(String [] gitem : receiversGitem){
				if(gitem[1].equals(((User)session.getAttribute("user")).getEmail())){
					gitem[2]="1";
					gitem[3]=new SimpleDateFormat("yyyy/MM/dd HH:mm").format(new Date());
				}
				System.out.println("date:"+gitem[3]);
				updatedReceivers+=gitem[0]+"^"+gitem[1]+"^"+gitem[2]+"^"+gitem[3]+"|";
			}
			survey.setReceivers(updatedReceivers);
			surveyService.updateSurvey(survey);
			surveyService.saveAction(answers);
			logger.info("user:"+((User)session.getAttribute("user")).getId()+" sumbitted an answer of survey:"+request.getParameter("surveyId")+",updatedreceivers:"+updatedReceivers);
		}
			
		return "survey/submitOk";
	}
	
	@RequestMapping(value = "accessSurvey/{id}", method = RequestMethod.GET)
	public String accessSurvey(@PathVariable("id") String surveyId,Model model,HttpSession session){
		/*Survey survey=surveyService.selectSurvey(id);
		List<Question> questions = paperService.getQuestions(String.valueOf(survey.getPaperId()));
		Iterator<Question> it = questions.iterator();
		while(it.hasNext()){
			Question question = it.next();
			String[] questionOptions = paperService.splitQuestionOptions(question.getQuestionOptions());
			question.setSplitOptions(questionOptions);
		}*/
		
		String userId = ((User) session.getAttribute("user")).getId();
		Survey survey = surveyService.selectSurvey(surveyId);
		Paper surveyPaper = paperService.selectPaper(String.valueOf(survey.getPaperId()));
		List<Question> surveyQuestions = paperService.getQuestions(String.valueOf(surveyPaper.getId()));
		List<Answer> surveyAnswers = answerService.getAnswerForSurveyByUser(surveyId, userId);
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
		model.addAttribute("isUpdate", surveyAnswers.size() != 0);
		model.addAttribute("expired", survey.getDeadlineTimestamp().before(new Date()));
		model.addAttribute("questions", surveyQuestions);
		model.addAttribute("survey", survey);
		
		return "survey/action";
	}
	
	@RequestMapping(value = "sendNoti", method = RequestMethod.POST)
	public String sendNoti(RedirectAttributes redirectAttributes,HttpSession session,ServletRequest request){
		if(surveyService.sendNotification(request.getParameter("receivers"),request.getParameter("subject"),request.getParameter("surveyId") ,request.getParameter("desctription")  ,request.getParameter("URL")))
		  return "survey/publishOK";
		else {
		  return "survey/publishFail";
		}
	}
}
