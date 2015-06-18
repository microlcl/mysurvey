package com.eastteam.myprogram.dao;

import static org.junit.Assert.*;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.User;


public class UserMybatisDaoTest extends SpringTransactionalTestCase {
	
	private static Logger logger = LoggerFactory.getLogger(UserMybatisDaoTest.class);

	@Autowired
	private UserMybatisDao userDao;

	@Test
	public void getRoleId() throws Exception {
		String roleId = userDao.getRoleId("lichlei@cn.ibm.com");
		logger.info(roleId);
		assertNotNull("User not found ", roleId);
		
		roleId = userDao.getRoleId("lichlei2@cn.ibm.com");
		logger.info(roleId);
		assertNull("should be null", roleId);

	}
	
	@Test
	public void update() throws Exception {
		User user = userDao.getUser("lichlei@cn.ibm.com");
		logger.info(user.getName());
		logger.info(user.getPassword());
		
		User myUser = new User("lichlei@cn.ibm.com");
		myUser.setPlainPassword("654321");
		myUser.setPassword("abcdef");
		myUser.setName("lichlei");
		userDao.update(myUser);
		logger.info("after updated");
		User user2 = userDao.getUser("lichlei@cn.ibm.com");
		logger.info(user2.getName());
		logger.info(user2.getPassword());

	}


}
