<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%response.setStatus(200);%>

<%
	Throwable ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");

	//记录日志
	Logger logger = LoggerFactory.getLogger("500.jsp");
	logger.error(ex.getMessage(), ex);
%>
<!DOCTYPE html>
<html>
<head>
	<title><spring:message code="error.500.title"/></title>
</head>

<body>
	<h2><spring:message code="error.500.body"/></h2>
</body>
</html>
