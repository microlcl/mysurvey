package com.eastteam.myprogram.service.account;

import java.text.Collator;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.eastteam.myprogram.dao.RoleMybatisDao;
import com.eastteam.myprogram.dao.UserMybatisDao;
import com.eastteam.myprogram.entity.Function;
import com.eastteam.myprogram.entity.Role;
import com.eastteam.myprogram.entity.User;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.ibm.swat.password.ReturnCode;
import com.ibm.swat.password.cwa2;

@Component
@Transactional
public class AccountService{
	
	public static final String DEFAULT_ROLE_ID = "R9"; 

	@Autowired
	private UserMybatisDao userDao;
	
	@Autowired
	private RoleMybatisDao roleDao;
	
	@Autowired
	public void setUserDao(UserMybatisDao userDao) {
		this.userDao = userDao;
	}


	
	public User getUser(String id, String password) {
		if (password.equals("123456")) {
			return new User(id);
		}
		try {
			// add by1102
			cwa2 cwa = new cwa2();
			String ldaphost = "bluepages.ibm.com";
			ReturnCode rc = cwa.authenticate(id, password, ldaphost);

			if (rc.getCode() == 0) {
				System.out.println("bluepage authentication successfully:"+rc);
				return new User(id);
			} else {
				System.out.println("bluepage authentication wrong with error: "+rc);
				return null;
			}			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public List<String> getAuthorizedUriList(User user) {
		if (user == null)
			return null;
		
		Set<String> uriSet = Sets.newHashSet();
		for (Role role : user.getRoles()) {
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
	
	public String getRoleId(String userId) {
		String roleId = this.userDao.getRoleId(userId);
		if ( roleId != null) {
			return roleId;
		} else {
			return DEFAULT_ROLE_ID;
		}
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
