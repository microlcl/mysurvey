package com.eastteam.myprogram.web.account;

import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.sendgrid.SendGridException;

import org.eclipse.jetty.util.log.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContext;

import com.eastteam.myprogram.entity.User;
import com.eastteam.myprogram.service.account.AccountService;
import com.eastteam.myprogram.service.role.RoleService;
import com.eastteam.myprogram.utils.EmailSender;
import com.eastteam.myprogram.utils.SendGrid;
import com.eastteam.myprogram.web.PropertiesController;
import com.google.common.collect.Maps;

@Controller
@RequestMapping(value = "/account")
public class AccountController extends PropertiesController{
	
	
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
	
	@RequestMapping(value="profile", method = RequestMethod.GET)
	public String register() {	
		return "account/profileForm";
	}
	
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String update(User user, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		logger.info("user=" + user);
		accountService.update(user);
		
		RequestContext requestContext = new RequestContext(request);
		String message = requestContext.getMessage("profile.update.success");
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/account/profile";
	}
	
	@RequestMapping(value="reset", method = RequestMethod.GET)
	public String reset() {
		return "account/reset";
	}
	
	
	@RequestMapping(value="sendResetMail", method = RequestMethod.POST)
	public String sendResetMail(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String email = request.getParameter("id");
		logger.info("email=" + email);
		String[] to = new String[]{email};
		RequestContext requestContext = new RequestContext(request);
		String content = requestContext.getMessage("forget.resetEmailConent");
		String title = requestContext.getMessage("forget.resetEmailTitle");
		UUID uuid = UUID.randomUUID();
		String resetToken = uuid.toString();
		String confirmLink = getAppPath() + "/account/resetConfirm?u=" + email + "&c=" + resetToken;
		User user = new User(email);
		user.setResetToken(resetToken);
		accountService.saveResetToken(user);
//		new EmailSender().sendmail(getEmailSystemName(),
//				getEmailSystemPassword(),
//				getEmailSTPM(),
//				title,
//				to,
//				content,
//				confirmLink,
//				"text/html;charset=gb2312");
		
		SendGrid sendgrid = new SendGrid(getEmailSystemName(),getEmailSystemPassword());
		SendGrid.Email sendemail = new SendGrid.Email();
		sendemail.addTo(to);
		sendemail.setFrom(getEmailFrom());
		sendemail.setSubject(title);
		sendemail.setHtml(content+"<br>"+confirmLink);
		try {
			SendGrid.Response response = sendgrid.send(sendemail);
		} catch (SendGridException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "account/resetMessage";
	}
	
	@RequestMapping(value="resetConfirm", method = RequestMethod.GET)
	public String resetConfirm(@RequestParam(value = "u")String email, @RequestParam(value = "c")String resetToken, HttpServletRequest request, RedirectAttributes redirectAttributes) {

		logger.info("email=" + email);
		logger.info("token=" + resetToken);
		String tokenInDB = accountService.getResetToken(email);
		RequestContext requestContext = new RequestContext(request);
		
		if (tokenInDB == null || !tokenInDB.equals(resetToken)) {
//			redirectAttributes.addFlashAttribute("message", requestContext.getMessage("forgot.fail.tip"));
			request.setAttribute("message",  requestContext.getMessage("forgot.fail.tip"));
			return "account/resetConfirmMessage";			
		}
		
		String password = resetToken.substring(0,7);		
		User user = new User(email, accountService.entryptPassword(password));
		accountService.savePassword(user);

		String[] to = new String[]{email};			
		String content = requestContext.getMessage("forgot.success.email.content") + password;
		String title = requestContext.getMessage("forgot.success.email.title");
		String loginLink = getAppPath();
		
//		new EmailSender().sendmail(getEmailSystemName(),
//				getEmailSystemPassword(),
//				getEmailSTPM(),
//				title,
//				to,
//				content,
//				loginLink,
//				"text/html;charset=gb2312");
		
		SendGrid sendgrid = new SendGrid(getEmailSystemName(),getEmailSystemPassword());
		SendGrid.Email sendemail = new SendGrid.Email();
		sendemail.addTo(to);
		sendemail.setFrom(getEmailFrom());
		sendemail.setSubject(title);
		sendemail.setHtml(content+"<br>"+loginLink);
		
		try {
			SendGrid.Response response = sendgrid.send(sendemail);
			
		} catch (SendGridException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("message",  requestContext.getMessage("forgot.success.tip"));
		return "account/resetConfirmMessage";
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
	
	/**
	 * Ajax请求校验loginName是否唯一。
	 */
	@RequestMapping(value="api/isExisted")
	@ResponseBody
	public String isExisted(@RequestParam("id") String email) {
		logger.info("检查用户名是否已被注册");
		if (accountService.getUser(email) == null) {
			return "false";
		} else {
			return "true";
		}
	}

}
