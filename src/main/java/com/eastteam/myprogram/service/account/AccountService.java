package com.eastteam.myprogram.service.account;

import java.text.Collator;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.UserMybatisDao;
import com.eastteam.myprogram.entity.Function;
import com.eastteam.myprogram.entity.Role;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.PageableService;
import com.eastteam.myprogram.utils.Digests;
import com.eastteam.myprogram.utils.Encodes;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;

@Component
@Transactional
public class AccountService extends PageableService {

	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	private static final int SALT_SIZE = 8;
	
	@Autowired
	private UserMybatisDao userDao;
	
	@Autowired
	public void setUserDao(UserMybatisDao userDao) {
		this.userDao = userDao;
	}

	
	public void registerUser(User user) {
		String pwd = entryptPassword(user.getPlainPassword());
		user.setPassword(pwd);
		userDao.save(user);
	}

	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */
	public String entryptPassword(String plainPassword) {
//		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), null, HASH_INTERATIONS);
		return Encodes.encodeHex(hashPassword);
	}
	
	
	public void updateUserInfo(User user){
		userDao.updateUser(user);
	}
	
	public void updateUserPersonalInfo(User user){
		String pwd = entryptPassword(user.getPlainPassword());
		user.setPassword(pwd);		
		userDao.updatePersonalInfo(user);
	}
	
	public void deleteUserRole(User user){
		userDao.deleteUserRole(user);
	}
	
	public void updateUserRole(String userId, List selectedRoles){
		Map param = new HashMap();
		param.put("userId", userId);
		param.put("roleList", selectedRoles);
		userDao.updateUserRole(param);		
	}
	
	public List<User> search(Map parameters, Pageable pageRequest) {
		//这里必须new一个新的Map作为Mybatis的传入参数，以防改变parameters的values，进而影响URL的生成。
		Map param = Maps.newHashMap(parameters);
		param.put("offset", pageRequest.getOffset());
		param.put("pageSize", pageRequest.getPageSize());
		param.put("sort", this.getOrderValue(pageRequest.getSort()));
		return userDao.search(param);
	}
	
	public List<User> search(String departmentId) {
		return userDao.findByDepartment(departmentId);
	}
	
	public Long getCount(Map parameters) {
		Map param = Maps.newHashMap(parameters);
		return userDao.getCount(parameters);
	}
	
	public User findUserByLoginName(String loginName) {
		return userDao.findByLoginName(loginName);
	}
	
	public User getUser(String id) {
		return this.userDao.getUser(id);
	}
	
	public List<String> getAuthorizedUriList(User user) {
		if (user == null || user.getRoles() == null)
			return null;
		
		Set<String> uriSet = Sets.newHashSet();
		for (Role role : user.getRoles()) {
			if (role.getFunctions() == null)
				continue;
			for (Function function : role.getFunctions()) {
				String uris = function.getPath();
				String[] uriArray = uris.split(",");
				uriSet.addAll(Arrays.asList(uriArray));
			}
			
		}		
		ArrayList<String> uriList = Lists.newArrayList(uriSet);
		Collections.sort(uriList, Collator.getInstance());		
		
		return uriList;
//		return Collections.unmodifiableList(uriList);
	}
	
	public List<String> getAuthorizedFunctionList(User user) {
		if (user == null || user.getRoles() == null)
			return null;
		
		Set<String> functionIdSet = Sets.newHashSet();
		for (Role role : user.getRoles()) {
			if (role.getFunctions() == null)
				continue;
			for (Function function : role.getFunctions()) {
				functionIdSet.add(function.getId());
			}
			
		}		
		ArrayList<String> functionidList = Lists.newArrayList(functionIdSet);
		return Collections.unmodifiableList(functionidList);
	}

}
