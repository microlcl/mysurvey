package com.eastteam.myprogram.dao;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.Department;
import com.eastteam.myprogram.entity.User;


public class UserMybatisDaoTest extends SpringTransactionalTestCase {
	
	private static Logger logger = LoggerFactory.getLogger(UserMybatisDaoTest.class);

	@Autowired
	private UserMybatisDao userDao;

	@Test
	public void getUser() throws Exception {
		User user = userDao.getUser("zhang3");
		logger.info(user.toString());
		assertNotNull("User not found", user);

	}


	@Test
	public void saveUser()  throws Exception {
		logger.info("hello");
		User user = new User();
		user.setId("lichunlei");
		user.setName("Cheney");
		user.setPassword("1111111");
		userDao.save(user);		
	}
	
	
	@Test
	public void updateUser() throws Exception {
		logger.info("update user information");
		User user = new User();
		Department department = new Department();
		user.setId("YDQ");
		user.setName("Devin");
		user.setSex("男");
		user.setAddress("ABC");
		user.setEmail("a@cn.abc");
		user.setDepartment(department);
		user.getDepartment().setId("D1-1");
		user.setBirthday("1980-01-01");
		user.setPhoneNum("123123");
		user.setStatus("sdfsa");
		user.setHometown("asdfas");
		
		userDao.updateUser(user);
		
	}
	
	@Test
	public void deleteUserRole() throws Exception {
		User user = new User();
		user.setId("YDQ");
		
		userDao.deleteUserRole(user);
	}
	
	@Test
	public void updateUserRole() throws Exception {
		List roleList = new ArrayList();
		roleList.add("R2");
		roleList.add("R3");
		
		Map<String, Object> param = new HashMap();
		param.put("userId", "YDQ");
		param.put("roleList", roleList);
		
		userDao.updateUserRole(param);
	}
	
	@Test
	public void updateUserPersonal() throws Exception {
		logger.info("update personal user information");
		User user = new User();
		Department department = new Department();
		user.setId("YDQ");
		user.setName("Devin");
		user.setPassword("asdfsafsafdsdf");
		user.setSex("男");
		user.setAddress("ABC");
		user.setEmail("a@cn.abc");
		user.setBirthday("1980-01-01");
		user.setPhoneNum("123123");
		user.setHometown("asdfas");
		
		userDao.updatePersonalInfo(user);
		
	}
	
	@Test
	public void findByDepartment() throws Exception {
	
		List<User> user = userDao.findByDepartment("D1");
		logger.info(user.toString());
	}
}
