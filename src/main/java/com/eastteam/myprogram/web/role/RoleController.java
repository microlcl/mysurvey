package com.eastteam.myprogram.web.role;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eastteam.myprogram.entity.UserRole;
import com.eastteam.myprogram.service.role.RoleService;

@Controller
@RequestMapping(value = "/role")
public class RoleController {

	@Autowired
	private RoleService roleService;
	
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public String showAllUserRoles(Model model, ServletRequest request, HttpSession session) {
		
		List<UserRole> userRoles = roleService.getAllAdmins();
		
		model.addAttribute("userRoles", userRoles);
		
		return "role/list";
	}
	
	@RequestMapping(value = "remove", method = RequestMethod.GET)
	public String removeUserRole(Model model, ServletRequest request, HttpSession session) {
		
		String userId = request.getParameter("userId");
		String roleId = request.getParameter("roleId");
		
		UserRole userRole = new UserRole();
		userRole.setRoleId(roleId);
		userRole.setUserId(userId);

		roleService.removeUserRole(userRole);
		
		return "";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String addUserRole(Model model, ServletRequest request, HttpSession session) {
		
		String userId = request.getParameter("userId");
		String roleId = request.getParameter("roleId");
		
		UserRole userRole = new UserRole();
		userRole.setRoleId(roleId);
		userRole.setUserId(userId);

		roleService.addUserRole(userRole);
		
		return "";
	}

}
