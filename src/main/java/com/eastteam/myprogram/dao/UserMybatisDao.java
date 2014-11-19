package com.eastteam.myprogram.dao;

import java.util.List;
import java.util.Map;

import com.eastteam.myprogram.entity.User;


/**
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * 
 */
@MyBatisRepository
public interface UserMybatisDao {
	void save(User user);
	void updateUser(User user);
	void updatePersonalInfo(User user);
	void deleteUserRole(User user);
	void updateUserRole(Map<String, Object> userRoleMap);
	User findByLoginName(String loginName);
	List<User> findByDepartment(String departmentId);
	List<User> search(Map<String, Object> parameters);
	Long getCount(Map<String, Object> parameters);
	User getUser(String id);
}
