package com.eastteam.myprogram.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

public class WebUtils {
	
	public static final String INCLUDE_REQUEST_URI_ATTRIBUTE = "javax.servlet.include.request_uri";
    public static final String INCLUDE_CONTEXT_PATH_ATTRIBUTE = "javax.servlet.include.context_path";
	public static final String LAST_VISIT_URL_KEY = "lastVistURI";
    /**
     * Return the request URI for the given request
     *
     * @param request current HTTP request
     * @return the request URI
     */
    public static String getRequestUri(HttpServletRequest request) {
        String uri = (String) request.getAttribute(INCLUDE_REQUEST_URI_ATTRIBUTE);
        if (uri == null) {
            uri = request.getRequestURI();
        }
        return uri;
    }
    
    public static String getRequestUriWithQueries(HttpServletRequest request) {
    	String queryString = request.getQueryString();
    	if(StringUtils.isNotBlank(queryString)) {
    		queryString = "?" + queryString; 
    	} else {
    		queryString = "";
    	}

    	return getPathWithinApplication(request) + queryString;
    }    
    
    public static String getContextPath(HttpServletRequest request) {
        String contextPath = (String) request.getAttribute(INCLUDE_CONTEXT_PATH_ATTRIBUTE);
        if (contextPath == null) {
            contextPath = request.getContextPath();
        }
        if ("/".equals(contextPath)) {
            // Invalid case, but happens for includes on Jetty: silently adapt it.
            contextPath = "";
        }
        
        return contextPath;
    }
    
    public static String getPathWithinApplication(HttpServletRequest request) {
        String contextPath = getContextPath(request);
        String requestUri = getRequestUri(request);
        if (StringUtils.startsWithIgnoreCase(requestUri, contextPath)) {
            // Normal case: URI contains context path.
            String path = requestUri.substring(contextPath.length());
            return (StringUtils.isNotBlank(path) ? path : "/");
        } else {
            // Special case: rather unusual.
            return requestUri;
        }
    }
    
    public static String getRealPath(HttpSession session) {
    	return session.getServletContext().getRealPath("");
    }
    
    public static void setLastVistURL(HttpServletRequest request, String lastURI) {
    	request.getSession().setAttribute(LAST_VISIT_URL_KEY, lastURI);
    }
    
    public static String getLastVistURL(HttpSession session) {
    	return (String)session.getAttribute(LAST_VISIT_URL_KEY);
    }
    
    public static void removeLasVistURL(HttpSession session) {
    	session.removeAttribute(LAST_VISIT_URL_KEY);
    }

}
