<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<!-- combotreee -->
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">

<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">

<title>权限管理</title>
</head>
<body>
<div class="form">
	<h1><spring:message code="role.title"/></h1>
	
	<div style="padding-left:30px;padding-top:20px">
	<a href="#newUserRole" role="button" class="btn" data-toggle="modal" style="margin-bottom:30px"><spring:message code="role.newrole"/></a>
	<div id="newUserRole" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3><spring:message code="role.rolegiven"/></h3>
		</div>
		<div class="modal-body">
			<form id="newForm" action="${ctx}/role/add">
	    		<spring:message code="role.userid"/> <input type="text" name="userId"><br/>
	    		<spring:message code="role.endowrole"/>
				<select name="roleId">
		    		<c:forEach items="${roles }" var="role">
						<option value="${role.id}">${role.name }</option>	    			
		    		</c:forEach>
	    		</select>
    		</form>
		</div>
		<div class="modal-footer">
			<a href="#" onclick="new function(){$('#newForm').submit();return null;}" class="btn btn-primary"><spring:message code="role.submit"/></a>
			<button class="btn" data-dismiss="modal" aria-hidden="true"><spring:message code="role.close"/></button>
		</div>
	</div>
	
	<table class="table table-hover">
    	<thead>
    		<tr><th><spring:message code="role.role"/></th><th><spring:message code="role.user"/></th><th><spring:message code="role.operation"/></th></tr>
    	</thead>
    	<tbody>
    		<c:forEach items="${userRoles}" var="ur" varStatus="as">
	    		<tr>
	    			<td>${ur.roleName}</td>
	    			<td>${ur.userId}</td>
	    			<td><a class="btn" href="${ctx}/role/remove?userId=${ur.userId}&roleId=${ur.roleId}"><spring:message code="role.delete"/></a></td>
    			</tr>
			</c:forEach>
    	</tbody>
	</table>
	</div>
</div>
<div class="form-actions" style="margin-top:-30px;">
</div>
</body>
</html>