package com.eastteam.myprogram.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.eastteam.myprogram.entity.User;

@Component("AuthFilter")
public class AuthFilter implements Filter {
	
	private final String[] IGNORED_URLS = {
			"/category/api/search","/category/api/getAll","/category/api/getChildren",
			"/category/api/getAll/getBusinessType","/question/api/search",
			"/category/api/getAll/paperStatus",
			"/paper/api/search","/category/api/getChildren/getCaseStatus","/category/api/getChildren/getBusinessType","/paper/api/getQuestions",
			"/paper/api/searchAll",
			"/account/api/checkLoginName",
			"/account/register","/account/reset","/account/sendResetMail","/account/resetConfirm","/account/resetConfirmMessage"
		};
	
	private final String[] IGNORED_REG = {"/paper/api/getQuestions"};
	private final String LOGOUT_URL="/account/logout";
	
	private static Logger logger = LoggerFactory.getLogger(AuthFilter.class);
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest)request;
		HttpServletResponse httpServletResponse = (HttpServletResponse)response;
		String uri = WebUtils.getPathWithinApplication(httpServletRequest);
//		User user = accountService.getUser("userid1");
		logger.info("in filter: uri=" + uri);
		logger.info("in filter: uri with queries=" + WebUtils.getRequestUriWithQueries(httpServletRequest));
		String lastFullURL = WebUtils.getRequestUriWithQueries(httpServletRequest);
//		logger.info("in filter: full uri=" + httpServletRequest.getHeader("Referer"));
		
		if (ArrayUtils.contains(IGNORED_URLS, uri) || isIgnored(uri)) {
			logger.info("ignored in auth filter = " + uri);
			chain.doFilter(request, response);
		} else {
			if (uri.equalsIgnoreCase(LOGOUT_URL)) {
				logger.info("logout: invalidate session");
				httpServletRequest.getSession().invalidate();
			}
			User user = (User)httpServletRequest.getSession().getAttribute("user");
			if (user == null) {
				logger.info("没有登陆，即将跳转到登陆页面");	
				if (lastFullURL != null && !lastFullURL.equals("/account/logout")) {
					WebUtils.setLastVistURL(httpServletRequest, lastFullURL);
				}
				httpServletResponse.sendRedirect(WebUtils.getContextPath(httpServletRequest) + "/login");
				return;
			}
			
			if (isAccessable(uri, user)) {
				chain.doFilter(request, response);
			} else {
				// TODO 401 error，重定向到405 error 页面
				logger.info("没有授权访问此资源");	
//				httpServletResponse.setHeader("status", "404");
				
//				chain.doFilter(request, httpServletResponse);
				throw new AuthorizationException("auth failed:" + uri);
			}
		}
//		
		
		
	}
	
	private boolean isIgnored(String url) {
		boolean result = false;
		for (String ignoredReg : IGNORED_REG) {
			if (url.indexOf(ignoredReg) > -1) {
				result = true;
				break;
			}
		}
		
		return result;		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
	private boolean isAccessable(String uri, User user) {
		List<String> authorizedUriList = user.getAuthorizedUriList();
		
		if (authorizedUriList == null || authorizedUriList.isEmpty())
			return false;
		
		for (String authorizedUri : authorizedUriList) {
			if (!StringUtils.isBlank(authorizedUri) && StringUtils.startsWith(uri,authorizedUri.trim())) {
				return true;
			}
		}
		
		return false;		
	}

}
