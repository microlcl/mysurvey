package com.eastteam.myprogram.service.role;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.RoleMybatisDao;
import com.eastteam.myprogram.entity.Role;
import com.eastteam.myprogram.entity.UserRole;
import com.eastteam.myprogram.service.PageableService;

@Component
@Transactional
public class RoleService extends PageableService{

	private static Logger logger = LoggerFactory.getLogger(RoleService.class);
	
	@Autowired
	private RoleMybatisDao roleMybatisDao;
	
	@Override
	public List search(Map parameters, Pageable pageRequest) {
		return null;
	}

	@Override
	public Long getCount(Map parameters) {
		return null;
	}
	
	public List<Role> getAllRoles() {
		return roleMybatisDao.selectAll();
	}
	
	public List<UserRole> getUsersByRole(String roleId){
		return roleMybatisDao.findUserByRole(roleId);
	}

	public List<UserRole> getAllUserRoles() {
		return roleMybatisDao.allUserRoles();
	}
	
	public List<UserRole> getAllAdmins() {
		return roleMybatisDao.allAdmins();
	}
	
	public void addUserRole(UserRole userRole) {
		roleMybatisDao.addUserRole(userRole);
	}
	
	public void removeUserRole(UserRole userRole) {
		roleMybatisDao.removeUserRole(userRole);
	}
	
	public Role getRole(String roleId) {
		return roleMybatisDao.getRole(roleId);
	}
}
