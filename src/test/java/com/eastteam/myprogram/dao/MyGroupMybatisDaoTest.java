package com.eastteam.myprogram.dao;


import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.Group;
import com.eastteam.myprogram.entity.User;

public class MyGroupMybatisDaoTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(QuestionMybatisDao.class);
	
	@Autowired
	private MyGroupMybatisDao myGroupMybatisDao;
	
	@Test
	public void saveGroupTest() throws Exception {
		logger.info("Group save");
		
		Group group = new Group();
		group.setGroupName("test group name");
		group.setComment("this is junit test group");
		group.setCreater(new User("admin"));
		group.setContent("jack^jack@cn.ibm.com|tom^tom@cn.ibm.com|stan^stan@cn.ibm.com|^xxx@cn.ibm.com");
		myGroupMybatisDao.insertGroup(group);
		
		Group group2 = new Group();
		group2.setGroupName("test group name2");
		group2.setComment("this is junit test group2");
		group2.setCreater(new User("admin"));
		group2.setContent("hello^jack@cn.ibm.com|lilei^tom@cn.ibm.com|hohoh^stan@cn.ibm.com|xxx^xxx@cn.ibm.com");
		myGroupMybatisDao.insertGroup(group2);
	}
	
	@Test
	public void updateGroupTest() throws Exception {
		logger.info("Group update");
		
		Group group = new Group();
		group.setId(1l);
		group.setGroupName("test update group name");
		group.setComment("this is junit test group for test update group name");
		group.setContent("lilei^tom@cn.ibm.com|hohoh^stan@cn.ibm.com|xxx^xxx@cn.ibm.com");
		myGroupMybatisDao.updateGroup(group);
	}
	
	@Test
	public void deleteGroupTest() throws Exception {
		logger.info("Group delete");
		myGroupMybatisDao.deleteGroup(1l);
	}
	
	@Test
	public void searchGroupTest() throws Exception {
		logger.info("====Qestion search");
		
		List<Group> result = myGroupMybatisDao.search("admin");
		logger.info("result=" + result);
	}
	
	
	@Test
	public void getSelectedGroupTest() throws Exception {
		logger.info("get selected Group");
		Group group=myGroupMybatisDao.getSelectedGroup(1l);
	}
	
}
