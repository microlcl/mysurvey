package com.eastteam.myprogram.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.eastteam.myprogram.entity.Function;
import com.eastteam.myprogram.entity.Role;
import com.eastteam.myprogram.entity.RoleFunction;

public class RoleMybatisDaoTest extends SpringTransactionalTestCase {
	private static Logger logger = LoggerFactory.getLogger(RoleMybatisDaoTest.class);

	@Autowired
	private RoleMybatisDao roleDao;
	
	@Test
	public void getAllRole() throws Exception{
		List<Role> allRole = roleDao.selectAll();
		logger.info(allRole.toString());
		System.out.println(allRole.size());
		assertNotNull("allRole not null", allRole);
	}
	
	
	@Test
	public void testSaveRole_Function() throws Exception{
		RoleFunction roleFunction=new RoleFunction();
		roleFunction.setRole_id("R1");
		roleFunction.setFunction_id("F7");
//		roleDao.deleteRole_Function("R1");
//		assertEquals(4,roleDao.getRole("R1").getFunctions().size());
	}
	
	@Test
	public void testGetFunctions() throws Exception {
		List<Function> functions = roleDao.getFunctions("R0");
		System.out.println(functions);
	}
}
