<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title><spring:message code="forgot.title"/></title>
	<link href="${ctx}/static/bootstrap/2.3.2/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>


</head>

<body>
	<form id="inputForm" action="${ctx}/account/sendResetMail" method="post" class="form-horizontal">

		<fieldset>
			<legend><small><spring:message code="forgot.title"/></small></legend>
					<div class="alert alert-info  controls">
			<button class="close" data-dismiss="alert">×</button>
			<spring:message code="forget.tips"/>
		</div>
			<div class="control-group">
				<label for="id" class="control-label"><spring:message code="register.loginname"/></label>
				<div class="controls">
					<input type="email" id="id" name="id" maxlength="64" placeholder="abc@gmail.com" class="input-large required"/>
				</div>
			</div>
	
			<div class="form-actions">
				<input id="submit_btn" class="btn btn-primary" type="submit" value="<spring:message code="forgot.submit"/>"/>&nbsp;	
				<input id="cancel_btn" class="btn" type="button" value="<spring:message code="forgot.back"/>" onclick="history.back()"/>
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
						remote: {
							url:"${ctx}/account/api/isExisted"
						}
					},
				},
				messages: {
					id: {
						remote: "The login name doesn't exist."
					}
				}
			});
		});

	</script>
</body>
</html>
