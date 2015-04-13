package com.eastteam.myprogram.web.account;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.account.AccountService;
import com.eastteam.myprogram.web.WebUtils;

@Controller
@RequestMapping(value = "/login")
public class LoginController {
	
	
	@Autowired
	AccountService accountService;

	private static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping(method = RequestMethod.GET)
	public String login() {
		logger.info("in log controller");
		return "account/login";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String login(User loginuser, HttpSession session, RedirectAttributes redirectAttributes) {
		logger.debug("in log controller. user " + loginuser.getId() + ",password=" + loginuser.getPlainPassword());
		User u = accountService.getUser(loginuser.getId(), loginuser.getPlainPassword());
		if (u == null) {
			u = new User(loginuser.getId());
		}
//		if (u == null) {
//			redirectAttributes.addFlashAttribute("message", "用户名或密码错误");
//			return "redirect:/login";
//		}
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
//		List<String> authorizedFunctionIdList = accountService.getAuthorizedFunctionList(u);
//		u.setAuthorizedFunctionList(authorizedFunctionIdList);
//		logger.info(u.getAuthorizedFunctionList().toString());
		session.setAttribute("user", u);
		String lastUri = WebUtils.getLastVistURL(session);
		if( lastUri != null) {
			WebUtils.removeLasVistURL(session);
			return "redirect:" + lastUri;
		}
		return "redirect:/index.jsp";
	}
}
