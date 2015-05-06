<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%response.setStatus(200);%>

<!DOCTYPE html>
<html>
<head>
	<title>401 - 未授权</title>
</head>

<body>
	<h2><spring:message code="error.401.title"/></h2>
	<p><a href="<c:url value="/"/>"><spring:message code="error.401.link"/></a></p>
</body>
</html>