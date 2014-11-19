package com.eastteam.myprogram.web.account;

import java.util.List;

import com.eastteam.myprogram.entity.Role;
import com.google.common.collect.Lists;

/**
 * 方便在页面迭代出某用户所有拥有的role的JavaBean
 * @author lichlei
 *
 */
public class RoleBean extends Role {
	
	private boolean checked;
	
	public List<RoleBean> roleList(List<Role> role){
		List<RoleBean> roleList = Lists.newArrayList();
		
		for(int i=0; i<role.size(); i++){
			RoleBean roleBean = new RoleBean();
			
			roleBean.setId(role.get(i).getId());
			roleBean.setName(role.get(i).getName());	
			roleList.add(roleBean);
		}
		return roleList;
	}

	public RoleBean() {
		// TODO Auto-generated constructor stub
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	
}
