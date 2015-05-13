package com.eastteam.myprogram.dao;

import com.eastteam.myprogram.entity.User;




/**
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * 
 */
@MyBatisRepository
public interface UserMybatisDao {
	String getRoleId(String userId);	
	void save(User user);
	User getUser(String id);
	User getUserByIdPwd(User user);
}
