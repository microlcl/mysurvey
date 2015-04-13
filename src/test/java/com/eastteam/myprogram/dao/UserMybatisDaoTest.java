package com.eastteam.myprogram.dao;

import static org.junit.Assert.*;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


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


}
