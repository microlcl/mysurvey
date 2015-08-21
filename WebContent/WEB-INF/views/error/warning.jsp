<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%response.setStatus(200);%>

<!DOCTYPE html>
<html>
<head>
	<title><spring:message code="error.401.title"/></title>
</head>

<body>
	<h2><spring:message code="error.warning"/></h2>
	<p><a href="javascript:window.history.back();"><spring:message code="error.back"/></a></p>
</body>
</html>