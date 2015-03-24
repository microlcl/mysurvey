package com.eastteam.myprogram.service.myGroup;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Map;

import org.apache.catalina.connector.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.eastteam.myprogram.dao.MyGroupMybatisDao;
import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.PageableService;
import com.eastteam.myprogram.service.paper.PaperService;

@Component
@Transactional
public class MyGroupService extends PageableService{
	
	@Autowired
	private MyGroupMybatisDao myGroupsMybatisDao;
	
	private static Logger logger = LoggerFactory.getLogger(MyGroupService.class);
	
	public List search(String userId) {
		logger.info("show user's all groups");
		return myGroupsMybatisDao.search(userId);
	}
	
	public void saveGroup(Group group){
		logger.info("save new group----created by "+group.getCreater().getId());
		myGroupsMybatisDao.insertGroup(group);
	}
	
	public void deleteGroup(Long groupId){
		logger.info("delete group "+groupId);
		myGroupsMybatisDao.deleteGroup(groupId);
	}
	
	public Group getSelectedGroup(Long groupId){
		logger.info("get group: "+groupId+"to update");
		return myGroupsMybatisDao.getSelectedGroup(groupId);
	}
	
	public void updateGroup(Group group){
		logger.info("update group "+group.getId());
		myGroupsMybatisDao.updateGroup(group);
	}
	
	public boolean importGroup(MultipartFile file,Group group){
		logger.info("import group"+group.getId());
		try {			
			File tempFile = File.createTempFile("tempFile",null);
			tempFile.deleteOnExit();
			file.transferTo(tempFile);
			String filePath = tempFile.getPath();
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));
			String line = "";
			String content = group.getContent();
			if (content.length() != 0) {
				group.setGitems();
			}
			
			while ((line = br.readLine()) != null ) {
				String[] info = line.split(",");
				if (info.length == 2) {
					content += info[0].trim() + "^" + info[1].trim() + "|";
				}else {
					return false;
				}
			}
			
			if (content.length() != 0) {
				group.setContent(content);
				group.setGitems();
			}
			br.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return true;
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
