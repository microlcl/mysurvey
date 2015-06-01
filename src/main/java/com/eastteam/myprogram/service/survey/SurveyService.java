package com.eastteam.myprogram.service.survey;

import java.sql.SQLException;
import java.util.ArrayList;
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
import com.eastteam.myprogram.service.PageableService;
import com.eastteam.myprogram.utils.EmailSender;
import com.eastteam.myprogram.utils.ExcelHandler;
import com.google.common.collect.Maps;

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
			//调查状态： N - 新建, D - 草稿, R - 可发布, P - 已发布, F - 已完成, C - 作废
			survey.setStatus(survey.getStatus().trim()); 
			if (survey.getStatus().trim().equals("D"))
				survey.setStatusString("草稿");
			if (survey.getStatus().trim().equals("P"))
				survey.setStatusString("已发布");
			if (survey.getStatus().trim().equals("F"))
				survey.setStatusString("已完成");
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
				survey.setStatusString("草稿");
			if (survey.getStatus().trim().equals("1-0-3-1"))
				survey.setStatusString("已发布");
			if (survey.getStatus().trim().equals("1-0-3-2"))
				survey.setStatusString("已完成");
			
			logger.debug("Transforming status :" + survey.getStatus() + " to " + survey.getStatusString());
			
			String[] groupsid = survey.getGroupsId().trim().split(",");
			String groupString = "";
			//System.out.println("======>"+groupsid[0]);
			if(!groupsid[0].equals("")){
				for (String s : groupsid) {
					Group g = myGroupMybatisDao.getSelectedGroup(Long.parseLong(s.trim()));
					groupString += g.getGroupName() + ",";
				}
				groupString = groupString.substring(0, groupString.length() - 1);
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
				groupString += g.getGroupName() + ",";
			}

			groupString = groupString
					.substring(0, groupString.length() - 1);
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
				HashSet<String> _receiver=new HashSet<String>();
				HashSet<String[]> _receiversInfo=new HashSet<String[]>();
				List<SurveyReceiver> surveyReceivers=new ArrayList<SurveyReceiver>();
				List<Group> groups=new ArrayList<Group>();
				for(String groupId : groupsId){
					groups.add(myGroupMybatisDao.getSelectedGroup(Long.parseLong(groupId)));
				}
				for(Group group : groups){
					group.setGitems();
					for(String[] gitems : group.getGitems()){
						_receiver.add(gitems[1]);
						_receiversInfo.add(gitems);
					}
				}
				
				for (String[] recInfoItem : _receiversInfo) {
					SurveyReceiver surveyReceiver = new SurveyReceiver();
					surveyReceiver.setNickName(recInfoItem[0]);
					surveyReceiver.setUserId(recInfoItem[1]);
					surveyReceiver.setStatus("0");
					surveyReceiver.setUpdate_timeStamp(null);
					surveyReceiver.setSurveyId(survey.getId());
					surveyReceivers.add(surveyReceiver);
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
				return new EmailSender().sendmail(
						configProperties.getProperty(EMAIL_SYS),
						configProperties.getProperty(EMAIL_SYS_PSW),
						configProperties.getProperty(EMAIL_SYS_STMP),
						survey.getSubject(), _receiver.toArray(),
						survey.getDescription(), surveyPath + survey.getId(),
						"text/html;charset=gb2312");
				// return true;
				// return false;
			}
		}
		return false;
	}
	
	
	public boolean sendNotification(String receivers,String subject,String surveyId,String desctription,String URL){
		String _receiver[] = receivers.split("\\,");
		logger.info("send notification");
	    return new EmailSender().sendmail(
	    		configProperties.getProperty(EMAIL_SYS),
	    		configProperties.getProperty(EMAIL_SYS_PSW),
	    		configProperties.getProperty(EMAIL_SYS_STMP),
	    		subject,_receiver,
	    		desctription, 
	    		URL+surveyId, 
	    		"text/html;charset=gb2312");
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
		List<Answer> answerList = answerMybatisDao.search(parameters);
		
		for (Answer answer : answerList) {
			
			if (!answers.containsKey(answer.getUserId())) 
				answers.put(answer.getUserId(), new ArrayList<Answer>());
			
			answers.get(answer.getUserId()).add(answer);
		}
		
		boolean isAnonymous = survey.getIsAnonymous().endsWith("T");
		
		ExcelHandler.doExprt(isAnonymous,questions, answers, out);
	}
}
 