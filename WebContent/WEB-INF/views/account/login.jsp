<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title><spring:message code="login.title"/></title>
</head>

<body>
	<br/><br/><br/><br/>
	<form id="loginForm" action="${ctx}/login" method="post"
		class="form-horizontal">
		<c:if test="${not empty message}">
			<div id="message" class="alert alert-error input-medium controls"><button data-dismiss="alert" class="close">×</button>${message}</div>
		</c:if>
		<c:if test="${not empty user.id}">
			<div class="alert alert-error input-medium controls">
				<button class="close" data-dismiss="alert">×</button>
				${user.name}<spring:message code="login.alert"/>
			</div>
		</c:if>
		<c:if test="${empty user.id}">
			<div class="control-group">
				<label for="loginName" class="control-label"><spring:message code="login.username"/></label>
				<div class="controls">
					<input type="text" id="loginName" name="id"
						value="${username}" class="input-medium required" />
				</div>
			</div>
			<div class="control-group">
				<label for="plainPassword" class="control-label"><spring:message code="login.password"/></label>
				<div class="controls">
					<input type="password" id="plainPassword" name="plainPassword"
						class="input-medium required" />
				</div>
			</div>

			<div class="control-group">
				<div class="controls">
					<label class="checkbox" for="rememberMe"><input
						type="checkbox" id="rememberMe" name="rememberMe" /> <spring:message code="login.rememberme"/></label> <input
						id="submit_btn" class="btn btn-primary" type="submit" value='<spring:message code="login.signin"/>' />
						<a class="btn" href="${ctx}/account/register">Sign Up</a>
				</div>
			</div>
		</c:if>
	</form>
	
	<script>
		$(document).ready(function() {
			$("#loginForm").validate();
		});
	</script>

</body>
</html>
