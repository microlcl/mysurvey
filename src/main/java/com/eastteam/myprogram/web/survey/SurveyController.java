package com.eastteam.myprogram.web.survey;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.support.RequestContext;

import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.entity.SurveyReceiver;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.answer.AnswerService;
import com.eastteam.myprogram.service.myGroup.MyGroupService;
import com.eastteam.myprogram.service.paper.PaperService;
import com.eastteam.myprogram.service.survey.SurveyService;
import com.eastteam.myprogram.web.Servlets;

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
	
	@Autowired
  	@Qualifier("configProperties")
  	private Properties configProperties;
	
	private static final String APPPATH="AppPath";
	private static final String SURVEYPATH="SurveyPath";
	
	private static Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	@RequestMapping (value = "myLaunch", method = RequestMethod.GET)
	public String myLaunch(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "survey_id desc") String sortType,
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
		model.addAttribute("surveyStatus", searchParams.get("surveyStatus"));
		
		logger.info("searchParams=" + searchParams);
		return "survey/myLaunch";
	}
	
	@RequestMapping (value = "myParticipation", method = RequestMethod.GET)
	public String myParicipation(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "sortType", defaultValue = "update_timestamp desc") String sortType,
			Model model, ServletRequest request, HttpSession session) {
		
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		int pageSize = Integer.parseInt(configProperties.getProperty("survey.pageSize"));
		String surveyStatus = null;
		String keyword = null;
		if (request.getParameter("search_surveyStatus") != "" && request.getParameter("search_surveyStatus") != null) {
			surveyStatus = request.getParameter("search_surveyStatus");
		}
		if (request.getParameter("search_keyword") != "" && request.getParameter("search_keyword") != null) {
			keyword = request.getParameter("search_keyword");
		}
		User user = (User) session.getAttribute("user");
		String userId = user.getId();
		Page<Survey> surveys = surveyService.getAllParticipationByUser(userId, pageNumber, pageSize, sortType, surveyStatus, keyword);
		
		logger.info("result length: " + surveys.getContent().size());
		
		model.addAttribute("surveys", surveys);
		model.addAttribute("sortType", sortType);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		model.addAttribute("surveyStatus", surveyStatus);
		
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
	public String publishSurvey(@PathVariable("id") String id,Model model,HttpSession session,HttpServletRequest request){
		Survey survey = surveyService.selectSurvey(id);
		Paper paper=paperService.selectPaper(String.valueOf(survey.getPaperId()));
		logger.info(survey.getIsAnonymous());
		List<Group> groups=myGroupService.search(((User)session.getAttribute("user")).getId());
		for (Group group : groups) {
			for (String gid : survey.getGroupIds())
				if (gid.equals(String.valueOf(group.getId())))
					group.setFlagString("");
		}
//		String receivers=survey.getReceivers();
//		String _receivers="";
//		Group receiversGroup =new Group();
//		receiversGroup.setContent(receivers);
//		receiversGroup.setGitems();
//		List<String[]> gitems = receiversGroup.getGitems();
//		for(String gitem[] : gitems){
//			if(gitem[2].equals("0")){
//				_receivers += gitem[1]+",";
//			}
//		}
//		model.addAttribute("gitems",gitems);
		
		
		model.addAttribute("survey", survey);
		model.addAttribute("paper",paper);
		model.addAttribute("groups",groups);
		model.addAttribute("url",configProperties.getProperty(APPPATH)+request.getContextPath()+configProperties.getProperty(SURVEYPATH)+id);
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
		User user = (User) session.getAttribute("user");
		RequestContext requestContext = new RequestContext(request);
	  if(request.getParameter("act").equalsIgnoreCase("save")){
			  survey.setStatus("1-0-3-0"); //D draft
			  survey.setCreater(user);
			  survey.setPaper(paperService.selectPaper(id));
//			  survey.setPaperURL(ServiceAddr+request.getContextPath()+"/survey/accessSurvey/");
			  surveyService.createSurvey(survey, "save",null);
			  return "survey/publishOK";
	  }else if(request.getParameter("act").equalsIgnoreCase("update")){
		  surveyService.updateSurvey(survey);
		  return "survey/publishOK";
	  }else{
//	     	String isPublish = request.getParameter("isPublish");
			survey.setCreater(user);
			survey.setPaper(paperService.selectPaper(id));
//			survey.setPaperURL(ServiceAddr+request.getContextPath()+"/survey/accessSurvey/");
			
			if(survey.getStatus().equalsIgnoreCase("1-0-3-0")){ // D draft
				survey.setStatus("1-0-3-1"); //P published
				surveyService.updateSurvey(survey);
			}else {
				survey.setStatus("1-0-3-1"); //P published
				surveyService.saveSurvey(survey);
			}
			
			if(!survey.getPaper().getStatus().getId().equals("1-0-1-1")){
				paperService.publishPaper(survey.getPaper().getId().toString());
			}
			
			if(survey.getSurveyGroup().equals("")||survey.getSurveyGroup()==null){
				redirectAttributes.addFlashAttribute("message", requestContext.getMessage("survey.publishsurvey.successURL")+"     "
			+configProperties.getProperty(APPPATH)+request.getContextPath()+configProperties.getProperty(SURVEYPATH)+survey.getId());
				return "redirect:/survey/myLaunch";
			}
			
			if(surveyService.createSurvey(survey,"publish",configProperties.getProperty(APPPATH)+request.getContextPath()+configProperties.getProperty(SURVEYPATH))){
				redirectAttributes.addFlashAttribute("message", requestContext.getMessage("survey.publishsurvey.success"));
				return "redirect:/survey/myLaunch";
			} else {
				redirectAttributes.addFlashAttribute("message", requestContext.getMessage("survey.publishsurvey.fail"));
				return "redirect:/paper/list?search_userId="+user.getId();
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
	public String saveAction(RedirectAttributes redirectAttributes,HttpSession session,HttpServletRequest request){
		
		Map<String, Object> answerQuestionId = Servlets.getParametersStartingWith(request, "questionId_");
		Map<String, Object> answerAnswer = Servlets.getParametersStartingWith(request, "answer_");
		String isUpdate = request.getParameter("isUpdate");
		RequestContext requestContext = new RequestContext(request);
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
			Map<String , Object> map=new HashMap<String, Object>();
			map.put("userId", ((User)session.getAttribute("user")).getId());
			map.put("surveyId", Long.parseLong(request.getParameter("surveyId")));
			if(!surveyService.selectSurvey(request.getParameter("surveyId")).getGroupsId().equals("")){
				SurveyReceiver surveyReceiver=surveyService.getPointedSurveyReceiver(map);
				surveyReceiver.setStatus("1");
				surveyReceiver.setUpdate_timeStamp(new Date());
				surveyService.upDateAssociatedReceivers(surveyReceiver);
			}
			surveyService.saveAction(answers);
			logger.info("user:"+((User)session.getAttribute("user")).getId()+" sumbitted an answer of survey:"+request.getParameter("surveyId"));
		}
			
		redirectAttributes.addFlashAttribute("message", requestContext.getMessage("survey.publishsurvey.savesuccess"));
		return "redirect:/survey/myParticipation";
	}
	
	@RequestMapping(value = "accessSurvey/{id}", method = RequestMethod.GET)
	public String accessSurvey(@PathVariable("id") String surveyId,Model model,HttpSession session,ServletRequest request){
		/*Survey survey=surveyService.selectSurvey(id);
		List<Question> questions = paperService.getQuestions(String.valueOf(survey.getPaperId()));
		Iterator<Question> it = questions.iterator();
		while(it.hasNext()){
			Question question = it.next();
			String[] questionOptions = paperService.splitQuestionOptions(question.getQuestionOptions());
			question.setSplitOptions(questionOptions);
		}*/
		
		String userId = request.getParameter("userId");	//如果是查看别人的的问卷有可能传入userId
		boolean canMod = false;							//如果是查看别人的问卷则不能修改
		boolean expired = true;
		if (userId==null || userId.equals("")) {
		
			userId = ((User) session.getAttribute("user")).getId(); 
			canMod = true;
		}
			
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
							question.getOptions()[Integer.parseInt(index)-1].setChecked(true);
						}
					}
				}
			}
		}
		
		if (canMod)
			expired = survey.getDeadlineTimestamp().before(new Date());	//如果可以修改则根据是否过期来决定问卷状态
		
		model.addAttribute("isUpdate", surveyAnswers.size() != 0);
		model.addAttribute("expired", expired);
		model.addAttribute("questions", surveyQuestions);
		model.addAttribute("survey", survey);
		return "survey/action";
	}
	
	@RequestMapping(value = "sendNoti", method = RequestMethod.POST)
	public String sendNoti(RedirectAttributes redirectAttributes,HttpSession session,HttpServletRequest request){
		RequestContext requestContext = new RequestContext(request);
		User user = (User) session.getAttribute("user");
		if(surveyService.sendNotification(request.getParameter("receivers"),request.getParameter("subject"),request.getParameter("surveyId") ,request.getParameter("desctription")  ,configProperties.getProperty(APPPATH)+request.getContextPath()+configProperties.getProperty(SURVEYPATH),user)){
			redirectAttributes.addFlashAttribute("message", requestContext.getMessage("survey.publishsurvey.remindsuccess"));
		    return "redirect:/survey/myLaunch";
		    }else {
			redirectAttributes.addFlashAttribute("message", requestContext.getMessage("survey.publishsurvey.remindfail"));
		    return "redirect:/survey/myLaunch";
		}
	}
	
	@RequestMapping(value = "statistic/{id}", method = RequestMethod.GET)
	public String answerStatistics(@PathVariable("id") String surveyId,Model model,HttpSession session) {
		
		Survey survey = surveyService.selectSurvey(surveyId);
		List<Question> questions = answerService.answerStatisticsBySurvey(survey);
		Set<String> answerIds = answerService.allAnswererIdsBySurvey(surveyId);
		
		List<SurveyReceiver> surveyReceivers=new ArrayList<SurveyReceiver>();
		String receivers="";
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("surveyId", survey.getId());
		surveyReceivers=surveyService.getAssociatedReceivers(map);
		for(SurveyReceiver surveyReceiver : surveyReceivers){
			if(surveyReceiver.getStatus().equals("0")){
				receivers += surveyReceiver.getUserId()+",";
			}
		}
		
		logger.info("receiver numbers:" + surveyReceivers.size());
		
		model.addAttribute("surveyReceivers",surveyReceivers);
		model.addAttribute("receivers",receivers);
		model.addAttribute("questions", questions);
		model.addAttribute("survey", survey);
		model.addAttribute("answerIds", answerIds);
		return "survey/statistic";
	}
	
	@RequestMapping(value = "export/{id}", method = RequestMethod.GET)
	public String exportSurvey(@PathVariable("id") String surveyId,HttpServletResponse response,Model model,HttpSession session) {
		
		Survey survey = surveyService.selectSurvey(surveyId);
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + survey.getSubject()  + ".xls\"");  
	    response.setContentType("application/octet-stream; charset=UTF-8");
	    
	    try {
			surveyService.exportSurvey(survey, response.getOutputStream());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	    
		return null;
	}
}
