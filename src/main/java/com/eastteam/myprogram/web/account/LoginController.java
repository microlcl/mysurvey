package com.eastteam.myprogram.web.account;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContext;

import com.eastteam.myprogram.entity.Role;
import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.account.AccountService;
import com.eastteam.myprogram.service.role.RoleService;
import com.eastteam.myprogram.web.WebUtils;

@Controller
@RequestMapping(value = "/login")
public class LoginController {
	
	
	@Autowired
	AccountService accountService;
	@Autowired
	RoleService roleService;

	private static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping(method = RequestMethod.GET)
	public String login() {
		logger.info("in log controller");
		return "account/login";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String login(User loginuser, HttpSession session, HttpServletRequest request,RedirectAttributes redirectAttributes,HttpServletResponse response) {
		logger.debug("in log controller. user " + loginuser.getId() + ",password=" + loginuser.getPlainPassword());
		User u = accountService.getUserByIdPwd(loginuser.getId(), loginuser.getPlainPassword());
		RequestContext requestContext = new RequestContext(request);
		if (u == null) {
			redirectAttributes.addFlashAttribute("message", requestContext.getMessage("login.error"));
			return "redirect:/login";
		}
		
		String roleid = accountService.getRoleId(u.getId());
		Role role = roleService.getRole(roleid);
		List<Role> roles = new ArrayList<Role>();
		roles.add(role);
		u.setRoles(roles);		

		logger.info(u.toString());

		logger.info("set user in session");
		List<String> authorizedUriList = accountService.getAuthorizedUriList(u);
		logger.info(authorizedUriList.toString());
		String userid = "";
		try {
			userid = URLEncoder.encode(loginuser.getId(), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			userid = loginuser.getId();
		}
		u.setAuthorizedUriList(authorizedUriList);
		List<String> authorizedFunctionIdList = accountService.getAuthorizedFunctionList(u);
		u.setAuthorizedFunctionList(authorizedFunctionIdList);
		logger.info(u.getAuthorizedFunctionList().toString());
		String rememberMe = request.getParameter("rememberMe");
		if(rememberMe!=null && rememberMe.equals("on")){
		    Cookie cookie = new Cookie("cookie_user", loginuser.getId()+"-"+loginuser.getPlainPassword());                
		    cookie.setMaxAge(60*60*24*30); //cookie 保存30天
		    response.addCookie(cookie);
		}else{  
		    Cookie cookie = new Cookie("cookie_user",loginuser.getId()+"-"+null);                
		    cookie.setMaxAge(60*60*24*30); //cookie 保存30天
		    response.addCookie(cookie);             
		}
		session.setAttribute("user", u);
		String lastUri = WebUtils.getLastVistURL(session);
		if( lastUri != null) {
			WebUtils.removeLasVistURL(session);
			return "redirect:" + lastUri;
		}
		return "redirect:/survey/myParticipation";
	}	

}
