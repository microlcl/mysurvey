package com.eastteam.myprogram.service.role;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.RoleMybatisDao;
import com.eastteam.myprogram.entity.UserRole;
import com.eastteam.myprogram.service.PageableService;

@Component
@Transactional
public class RoleService extends PageableService{

	private static Logger logger = LoggerFactory.getLogger(RoleService.class);
	
	private RoleMybatisDao roleMybatisDao;
	
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
	
	public List<UserRole> getUsersByRole(String roleId){
		return roleMybatisDao.findUserByRole(roleId);
	}

}
