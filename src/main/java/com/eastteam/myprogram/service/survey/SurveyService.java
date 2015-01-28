package com.eastteam.myprogram.service.survey;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.SurveyMybatisDao;
import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.Survey;
import com.eastteam.myprogram.service.PageableService;
import com.eastteam.myprogram.service.myGroup.MyGroupService;
import com.eastteam.myprogram.utils.EmailSender;
import com.google.common.collect.Maps;

@Component
@Transactional
public class SurveyService extends PageableService {
	@Autowired
	private SurveyMybatisDao surveyMybatisDao;
	@Autowired
	private MyGroupService myGroupService;
	
	private int pageSize;
	
	private static Logger logger = LoggerFactory.getLogger(SurveyService.class);

	public List search(Map parameters) {
		logger.info("in service, pagesize = " + pageSize);
		Map param = Maps.newHashMap(parameters);
		List<Survey> surveys = surveyMybatisDao.search(param);
		
		for (Survey survey : surveys) {
			//调查状态： N - 新建, D - 草稿, R - 可发布, P - 已发布, F - 已完成, C - 作废
			survey.setStatus(survey.getStatus().trim()); 
			if (survey.getStatus().trim().equals("N"))
				survey.setStatusString("新建");
			if (survey.getStatus().trim().equals("D"))
				survey.setStatusString("草稿");
			if (survey.getStatus().trim().equals("R"))
				survey.setStatusString("可发布");
			if (survey.getStatus().trim().equals("P"))
				survey.setStatusString("已发布");
			if (survey.getStatus().trim().equals("F"))
				survey.setStatusString("已完成");
			if (survey.getStatus().trim().equals("C"))
				survey.setStatusString("作废");
			logger.debug("Transforming status :" + survey.getStatus() + " to " + survey.getStatusString());
			
			String[] groupsid = survey.getGroupsId().trim().split(",");
			String groupString = "";
			for (String s : groupsid) {
				Group g = myGroupService.getSelectedGroup(Long.parseLong(s.trim()));
				groupString += g.getGroupName() + ",";
			}
			
			groupString = groupString.substring(0, groupString.length() - 1);
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
			//调查状态： N - 新建, D - 草稿, R - 可发布, P - 已发布, F - 已完成, C - 作废
			survey.setStatus(survey.getStatus().trim()); 
			if (survey.getStatus().trim().equals("N"))
				survey.setStatusString("新建");
			if (survey.getStatus().trim().equals("D"))
				survey.setStatusString("草稿");
			if (survey.getStatus().trim().equals("R"))
				survey.setStatusString("可发布");
			if (survey.getStatus().trim().equals("P"))
				survey.setStatusString("已发布");
			if (survey.getStatus().trim().equals("F"))
				survey.setStatusString("已完成");
			if (survey.getStatus().trim().equals("C"))
				survey.setStatusString("作废");
			logger.debug("Transforming status :" + survey.getStatus() + " to " + survey.getStatusString());
			
			String[] groupsid = survey.getGroupsId().trim().split(",");
			String groupString = "";
			for (String s : groupsid) {
				Group g = myGroupService.getSelectedGroup(Long.parseLong(s.trim()));
				groupString += g.getGroupName() + ",";
			}
			
			groupString = groupString.substring(0, groupString.length() - 1);
			survey.setGroupsString(groupString);
		}
		return surveys;
	}

	@Override
	public Long getCount(Map parameters) {
		return this.surveyMybatisDao.getCount(parameters);
	}
	
	public Survey selectSurvey(String surveyId) {
		return this.surveyMybatisDao.selectSurvey(surveyId);
	}
	
	
	public boolean publishSurvey(Survey survey){
		logger.info("save new survey :"+ survey.getSubject());
		surveyMybatisDao.save(survey);
		HashSet<String> _receiver=new HashSet<String>();
		String[] groupsId=survey.getSurveyGroup().split("\\,");
		List<Group> groups=new ArrayList<Group>();
		for(String groupId : groupsId){
			groups.add(myGroupService.getSelectedGroup(Long.parseLong(groupId)));
		}
		for(Group group : groups){
			group.setGitems();
			for(String[] emailaddr : group.getGitems()){
				_receiver.add(emailaddr[1]);
			}
		}
		
	return new EmailSender().sendmail(survey.getSubject(), "easysurveytest@163.com",_receiver.toArray(), survey.getDescription(), survey.getPaperURL(), "text/html;charset=gb2312");
	}
	
}
