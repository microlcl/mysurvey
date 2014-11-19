<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>登录页</title>
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
				${user.name},您已经登陆了。
			</div>
		</c:if>
		<c:if test="${empty user.id}">
			<div class="control-group">
				<label for="loginName" class="control-label">名称:</label>
				<div class="controls">
					<input type="text" id="loginName" name="id"
						value="${username}" class="input-medium required" />
				</div>
			</div>
			<div class="control-group">
				<label for="plainPassword" class="control-label">密码:</label>
				<div class="controls">
					<input type="password" id="plainPassword" name="plainPassword"
						class="input-medium required" />
				</div>
			</div>

			<div class="control-group">
				<div class="controls">
					<label class="checkbox" for="rememberMe"><input
						type="checkbox" id="rememberMe" name="rememberMe" /> 记住我</label> <input
						id="submit_btn" class="btn btn-primary" type="submit" value="登录" />
					<a class="btn" href="${ctx}/account/register">注册</a> <span
						class="help-block">(DB里面已有的用户密码： 123456)
					</span>
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
