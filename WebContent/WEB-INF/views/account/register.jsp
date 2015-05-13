<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title><spring:message code="register.title"/></title>
	<link href="${ctx}/static/bootstrap/2.3.2/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

</head>

<body>
	<form id="inputForm" action="${ctx}/account/register" method="post" class="form-horizontal">
		<fieldset>
			<legend><small><spring:message code="register.title"/></small></legend>
			<div class="control-group">
				<label for="loginName" class="control-label"><spring:message code="register.loginname"/></label>
				<div class="controls">
					<input type="email" id="id" name="id" maxlength="64" placeholder="abc@gmail.com" class="input-large required"/>
				</div>
			</div>
			<div class="control-group">
				<label for="name" class="control-label"><spring:message code="register.name"/></label>
				<div class="controls">
					<input type="text" id="name" name="name" maxlength="64" class="input-large required"/>
				</div>
			</div>
			<div class="control-group">
				<label for="plainPassword" class="control-label"><spring:message code="register.password"/></label>
				<div class="controls">
					<input type="password" id="plainPassword" name="plainPassword" maxlength="32" class="input-large required"/>
				</div>
			</div>
			<div class="control-group">
				<label for="confirmPassword" class="control-label"><spring:message code="register.confirmpassword"/></label>
				<div class="controls">
					<input type="password" id="confirmPassword" name="confirmPassword" class="input-large required" equalTo="#plainPassword"/>
				</div>
			</div>
	
	
			<div class="form-actions">
				<input id="submit_btn" class="btn btn-primary" type="submit" value="<spring:message code="register.submit"/>"/>&nbsp;	
				<input id="cancel_btn" class="btn" type="button" value="<spring:message code="register.back"/>" onclick="history.back()"/>
			</div>
		</fieldset>
	</form>
	
	<script type="text/javascript">
		$(document).ready(function() {
			//聚焦第一个输入框
			$("#loginName").focus();
			//为inputForm注册validate函数
			$("#inputForm").validate({
				rules: {
					id: {
						rangelength: [2,64],
						remote: {
							url:"${ctx}/account/api/checkLoginName"
						}
					},
					name: {
						rangelength: [2,64]
					},
					plainPassword: {
						required: true,
						rangelength: [5,32]
					}
				},
				messages: {
					id: {
						rangelength: jQuery.validator.format("登录名必须在 {0} 和 {1} 个字符之间"),
						remote: "用户登录名已存在"
					},
					name: {
						rangelength: jQuery.validator.format("用户名必须在 {0} 和 {1} 个字符之间")
					},
					plainPassword: {
						rangelength: jQuery.validator.format("密码长度必须在 {0} 和 {1} 个字符之间")
					}
				}
			});
		});

	</script>
</body>
</html>
