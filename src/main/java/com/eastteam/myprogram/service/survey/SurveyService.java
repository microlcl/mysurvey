package com.eastteam.myprogram.service.survey;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletOutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.AnswerMybatisDao;
import com.eastteam.myprogram.dao.MyGroupMybatisDao;
import com.eastteam.myprogram.dao.PaperMybatisDao;
import com.eastteam.myprogram.dao.SurveyMybatisDao;
import com.eastteam.myprogram.dao.SurveyReceiverMybatisDao;
import com.eastteam.myprogram.entity.Answer;
import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Paper;
import com.eastteam.myprogram.entity.Question;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.entity.SurveyReceiver;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.PageableService;
import com.eastteam.myprogram.utils.EmailSender;
import com.eastteam.myprogram.utils.ExcelHandler;
import com.eastteam.myprogram.utils.SendGrid;
import com.google.common.collect.Maps;
import com.sendgrid.SendGridException;

@Component
@Transactional
public class SurveyService extends PageableService {
	@Autowired
	private SurveyMybatisDao surveyMybatisDao;
	@Autowired
	private MyGroupMybatisDao myGroupMybatisDao;
	@Autowired
	private AnswerMybatisDao answerMybatisDao;
	@Autowired
	private SurveyReceiverMybatisDao surveyReceiverMybatisDao;
	@Autowired
	private PaperMybatisDao paperMybatisDao;
	
	
	@Autowired
  	@Qualifier("configProperties")
  	private Properties configProperties;
	
	private static final String EMAIL_SYS="SystemEmail";
	private static final String EMAIL_SYS_PSW="SystemEmailPassword";
	private static final String EMAIL_SYS_STMP="SystemEmailSTMP";
	
	private int pageSize;
	
	private static Logger logger = LoggerFactory.getLogger(SurveyService.class);

	public List search(Map parameters) {
		logger.info("in service, pagesize = " + pageSize);
		Map param = Maps.newHashMap(parameters);
		List<Survey> surveys = surveyMybatisDao.search(param);
		
		for (Survey survey : surveys) {
			//调查状态: D - 草稿,  P - 已发布, F - 已完成
			survey.setStatus(survey.getStatus().trim()); 
			if (survey.getStatus().trim().equals("D"))
				survey.setStatusString("Draft");
			if (survey.getStatus().trim().equals("P"))
				survey.setStatusString("Published");
			if (survey.getStatus().trim().equals("F"))
				survey.setStatusString("Completed");
			logger.debug("Transforming status :" + survey.getStatus() + " to " + survey.getStatusString());
			
			String[] groupsid = survey.getGroupsId().trim().split(",");
			String groupString = "";
			if (!groupsid[0].equals("")) {
				for (String s : groupsid) {
					Group g = myGroupMybatisDao.getSelectedGroup(Long
							.parseLong(s.trim()));
					groupString += g.getGroupName() + ",";
				}

				groupString = groupString
						.substring(0, groupString.length() - 1);
			}
			survey.setGroupsString(groupString);
		}
		
		return surveys;
	}
	
	@Override
	public List search(Map parameters, Pageable pageRequest) {
		Map param = Maps.newHashMap(parameters);
		param.put("offset", pageRequest.getOffset());
		param.put("pageSize", pageRequest.getPageSize());
		param.put("sort", this.getOrderValue(pageRequest.getSort()));
		
		List<Survey> surveys = surveyMybatisDao.search(param);
		
		for (Survey survey : surveys) {
			//调查状态：D - 草稿(可发布), P - 已发布, F - 已完成
			survey.setStatus(survey.getStatus().trim()); 
			
			if (survey.getStatus().trim().equals("1-0-3-0"))
				survey.setStatusString("Draft");
			if (survey.getStatus().trim().equals("1-0-3-1"))
				survey.setStatusString("Published");
			if (survey.getStatus().trim().equals("1-0-3-2"))
				survey.setStatusString("Completed");
			
			logger.debug("Transforming status :" + survey.getStatus() + " to " + survey.getStatusString());
			
			String[] groupsid = survey.getGroupsId().trim().split(",");
			String groupString = "";
			if(!groupsid[0].equals("")){
				for (String s : groupsid) {
					Group g = myGroupMybatisDao.getSelectedGroup(Long.parseLong(s.trim()));
					if(g != null){
						groupString += g.getGroupName() + ",";
					}
				}
				if (groupString != "") {
					groupString = groupString.substring(0, groupString.length() - 1);
				}
				
			}
			survey.setGroupsString(groupString);
		}
		return surveys;
	}

	@Override
	public Long getCount(Map parameters) {
		return this.surveyMybatisDao.getCount(parameters);
	}
	
	public Survey selectSurvey(String surveyId) {
		Survey survey = this.surveyMybatisDao.selectSurvey(Long.parseLong(surveyId));
		String[] groupsid = survey.getGroupsId().trim().split(",");
		String groupString = "";
		if (!groupsid[0].equals("")) {
			for (String s : groupsid) {
				Group g = myGroupMybatisDao.getSelectedGroup(Long
						.parseLong(s.trim()));
				if(g != null){
					groupString += g.getGroupName() + ",";
				}
			}

			if(groupString.length() != 0){
				groupString = groupString
						.substring(0, groupString.length() - 1);
			}
		}
		survey.setGroupsString(groupString);
		survey.setGroupIds(survey.getGroupsId().trim().split(","));
		return survey;
	}
	
	public Page<Survey> getAllParticipationByUser(String userId, int pageNumber, int pageSize, String sort, String surveyStatus, String keyword) {
		
		Pageable pageRequest = new PageRequest(pageNumber-1, pageSize, new Sort(sort));
		Map parameters = new HashMap<String, Object>();

		List<SurveyReceiver> surveysByUser = surveyReceiverMybatisDao.allSurveysByUser(userId);
		parameters.put("surveysByUser", surveysByUser);
		parameters.put("surveyStatus", surveyStatus);
		parameters.put("keyword", keyword);
		Long count = getCount(parameters);
		List<Survey> surveys = this.search(parameters, pageRequest);
		Page<Survey> contents = new PageImpl<Survey>(surveys, pageRequest, count);
		
		return contents;
	}
	
	public void saveAction(List<Answer> answers){
		logger.info("save action of survey ");
		answerMybatisDao.saveAction(answers);
	}
	
	public void updateAction(List<Answer> answers){
		logger.info("update action of survey ");
		for (Answer answer : answers) {
			answerMybatisDao.update(answer);
		}
	}
	
	public void saveSurvey(Survey survey){
		logger.info("save survey :"+ survey.getSubject());
		surveyMybatisDao.save(survey);
	}
	
	public void updateSurvey(Survey survey){
		logger.info("updating survey :"+ survey.getSubject());
		logger.info("groups:"+survey.getGroupsId());
		surveyMybatisDao.updateSurvey(survey);
	}
	
	
	public boolean createSurvey(Survey survey,String act,String surveyPath){
		if(act.equalsIgnoreCase("update")){

			this.updateSurvey(survey);

		}else if(act.equalsIgnoreCase("save")){

			this.saveSurvey(survey);

		}else if (act.equalsIgnoreCase("publish")) {
			String[] groupsId=survey.getSurveyGroup().split("\\,");
			if(groupsId.length>0){
				List<String> recEmails = new ArrayList<String>();
				HashSet<String[]> _receiversInfo=new HashSet<String[]>();
				List<SurveyReceiver> surveyReceivers=new ArrayList<SurveyReceiver>();
				List<Group> groups=new ArrayList<Group>();
				for(String groupId : groupsId){
					Group group=myGroupMybatisDao.getSelectedGroup(Long.parseLong(groupId));
					group.setGitems();
					for(String[] gitem : group.getGitems()){
						SurveyReceiver surveyReceiver = new SurveyReceiver();
						if(!recEmails.contains(gitem[1])){
							recEmails.add(gitem[1]);
							surveyReceiver.setNickName(gitem[0]);
							surveyReceiver.setUserId(gitem[1]);
							surveyReceiver.setStatus("0");
							surveyReceiver.setUpdate_timeStamp(null);
							surveyReceiver.setSurveyId(survey.getId());
							surveyReceivers.add(surveyReceiver);
						}
					}
				}

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("surveyReceivers", surveyReceivers);
				surveyReceiverMybatisDao.save(map);
				logger.info("save new survey :" + survey.getSubject() + " by user:"
						+ survey.getCreater().getId()
						+ ",asscoiated survey receivers:");
				for (SurveyReceiver _surveyReceiver : surveyReceivers) {
					logger.info(_surveyReceiver.getUserId());
				}
				logger.info("===>receiver list over");
				logger.info("===>SurveyUrl:" + surveyPath + survey.getId());

				SendGrid sendgrid = new SendGrid(configProperties.getProperty(EMAIL_SYS),configProperties.getProperty(EMAIL_SYS_PSW));
				SendGrid.Email sendemail = new SendGrid.Email();
				String[] receivers = recEmails.toArray(new String[recEmails.size()]);

				sendemail.addTo(receivers);
				sendemail.setFrom(survey.getCreater().getId());
				sendemail.setSubject(survey.getSubject());
				sendemail.setHtml(survey.getDescription()+"<br>"+surveyPath + survey.getId());
				SendGrid.Response response = null;
				try {
					response = sendgrid.send(sendemail);
				} catch (SendGridException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return response.getStatus();

//				return new EmailSender().sendmail(
//						configProperties.getProperty(EMAIL_SYS),
//						configProperties.getProperty(EMAIL_SYS_PSW),
//						configProperties.getProperty(EMAIL_SYS_STMP),
//						survey.getSubject(), _receiver.toArray(),
//						survey.getDescription(), surveyPath + survey.getId(),
//						"text/html;charset=gb2312");
				// return true;
				// return false;
			}
		}
		return false;
	} 
	
	
	public boolean sendNotification(String receivers,String subject,String surveyId,String desctription,String URL,User user){
		String _receiver[] = receivers.split("\\,");
		logger.info("send notification");
		
		SendGrid sendgrid = new SendGrid(configProperties.getProperty(EMAIL_SYS),configProperties.getProperty(EMAIL_SYS_PSW));
		SendGrid.Email sendemail = new SendGrid.Email();
		sendemail.addTo(_receiver);
		sendemail.setFrom(user.getId());
		sendemail.setSubject(subject);
		sendemail.setHtml(desctription+"<br>"+URL+surveyId);
		SendGrid.Response response = null;
		try {
			response = sendgrid.send(sendemail);			
		} catch (SendGridException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return response.getStatus();
//	    return new EmailSender().sendmail(
//	    		configProperties.getProperty(EMAIL_SYS),
//	    		configProperties.getProperty(EMAIL_SYS_PSW),
//	    		configProperties.getProperty(EMAIL_SYS_STMP),
//	    		subject,_receiver,
//	    		desctription, 
//	    		URL+surveyId, 
//	    		"text/html;charset=gb2312");
//		return true;
	}
	
	public List<SurveyReceiver> getAssociatedReceivers(Map<String, Object> map){
		return surveyReceiverMybatisDao.search(map);
	}
	
	public void upDateAssociatedReceivers(SurveyReceiver surveyReceiver){
		surveyReceiverMybatisDao.update(surveyReceiver);
	}
	
	public SurveyReceiver getPointedSurveyReceiver(Map<String, Object> map){
		return surveyReceiverMybatisDao.getPointedSurveyReceiver(map);
	}
	
	@SuppressWarnings("unchecked")
	public void exportSurvey(Survey survey, ServletOutputStream out) throws SQLException {

		List<Question> questions = paperMybatisDao.selectQuestions(String.valueOf(survey.getPaperId()));
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("surveyId", survey.getId());
		Map<String, List<Answer>> answers = new HashMap<String, List<Answer>>();
		Map<String, Group> receivers = new HashMap<String, Group>();
		String[] groupsId=survey.getGroupsId().trim().split(",");
		List<Answer> answerList = answerMybatisDao.search(parameters);
		for (Answer answer : answerList) {
			
			if (!answers.containsKey(answer.getUserId())) 
				answers.put(answer.getUserId(), new ArrayList<Answer>());
			
			answers.get(answer.getUserId()).add(answer);
		}
		if (survey.getGroupsId() != null && survey.getGroupsId() !="") {
			System.out.println(survey.getGroupsId()+"********");
			for(String groupId : groupsId) {
				Group group=myGroupMybatisDao.getSelectedGroup(Long.parseLong(groupId));
				group.setGitems();
				for(String[] gitem : group.getGitems()){
					SurveyReceiver surveyReceiver = new SurveyReceiver();
					if(!receivers.containsKey(gitem[1])){
						receivers.put(gitem[1],group);
					}
				}
			}
		} else {
			receivers = null;
		}
		
		boolean isAnonymous = survey.getIsAnonymous().endsWith("T");
		
		ExcelHandler.doExprt(isAnonymous,questions, answers, out, receivers);
	}
	
	public void saveWithoutGroup(Map<String, Object> map) {
		SurveyReceiver surveyreceiver = new SurveyReceiver();
		surveyreceiver.setSurveyId(Long.valueOf(map.get("surveyId").toString()));
		surveyreceiver.setUserId(map.get("userId").toString());
		surveyreceiver.setUpdate_timeStamp(new Date());
		surveyreceiver.setStatus("1");
		surveyReceiverMybatisDao.saveWithoutGroup(surveyreceiver);
	}
}
 
