package com.eastteam.myprogram.web.account;

import java.util.Map;
import java.util.Properties;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.account.AccountService;
import com.eastteam.myprogram.service.role.RoleService;
import com.google.common.collect.Maps;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	@Autowired
  	@Qualifier("configProperties")
  	private Properties configProperties;
	
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	static {
		sortTypes.put("id", "登录名");
		sortTypes.put("name", "姓名");
		sortTypes.put("email", "邮件");
	}
	
	private static Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private RoleService roleService;
	
	@RequestMapping(value="register",method = RequestMethod.GET)
	public String registerForm() {
		return "account/register";
	}
	
	@RequestMapping(value="register", method = RequestMethod.POST)
	public String register(@Valid User user, RedirectAttributes redirectAttributes) {
		logger.info("user=" + user);
		accountService.registerUser(user);
		redirectAttributes.addFlashAttribute("username", user.getId());
		return "redirect:/login";
	}
	
	@RequestMapping(value="reset", method = RequestMethod.GET)
	public String reset() {
		return "account/reset";
	}
	
	/**
	 * Ajax请求校验loginName是否唯一。
	 */
	@RequestMapping(value="api/checkLoginName")
	@ResponseBody
	public String checkLoginName(@RequestParam("id") String loginName) {
		logger.info("检查用户名是否已被注册");
		if (accountService.getUser(loginName) == null) {
			return "true";
		} else {
			return "false";
		}
	}

}
