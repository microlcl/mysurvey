package com.eastteam.myprogram.web.role;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/role")
public class RoleController {

	@RequestMapping(value = "all", method = RequestMethod.GET)
	public String showAllUserRoles() {
		return "";
	}

}
