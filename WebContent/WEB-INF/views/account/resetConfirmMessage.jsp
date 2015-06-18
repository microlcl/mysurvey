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
	<form id="inputForm" action="" method="post" class="form-horizontal">

		<fieldset>
			<legend><small><spring:message code="forgot.title"/></small></legend>
					<div class="alert alert-info  controls">
			${message}
		</div>
					<div class="control-group">
				<div class="controls">
						<a class="btn" href="${ctx}/login">Sign In</a>
				</div>
			</div>

		</fieldset>
	</form>

</body>
</html>
