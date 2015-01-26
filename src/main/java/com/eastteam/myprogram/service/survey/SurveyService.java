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

@Component
@Transactional
public class SurveyService extends PageableService {
	@Autowired
	private SurveyMybatisDao surveyMybatisDao;
	@Autowired
	private MyGroupService myGroupService;
	
	private int pageSize;
	
	private static Logger logger = LoggerFactory.getLogger(SurveyService.class);

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
	
	@Override
	public List search(Map parameters, Pageable pageRequest) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long getCount(Map parameters) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
