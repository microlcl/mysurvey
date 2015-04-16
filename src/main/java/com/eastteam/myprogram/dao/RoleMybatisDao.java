package com.eastteam.myprogram.dao;

import java.util.List;
import java.util.Map;

import com.eastteam.myprogram.entity.Function;
import com.eastteam.myprogram.entity.Role;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.entity.UserRole;


/**
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * 
 */
@MyBatisRepository
public interface RoleMybatisDao {
	void save(Role role);
	void update(Role role);
	void delete(String roleId);
	List<Role> search(Map<String, Object> parameters);
	Long getCount(Map<String, Object> parameters);
	Role getRole(String id);
	List<Role> findRoleByName(String name);
	List<Role> findRole(Role role);
	List<Role> selectAll();
	List<Function> getFunctions(String roleId);
	List<UserRole> findUserByRole(String roleId);
	List<UserRole> allUserRoles();
	List<UserRole> allAdmins();
	void removeUserRole(UserRole userRole);
	void addUserRole(UserRole userRole);
}
