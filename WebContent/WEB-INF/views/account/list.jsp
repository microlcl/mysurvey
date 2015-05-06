<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>用户管理</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			$("#account-tab").addClass("active");
		});
	</script>

</head>

<body>
<div class="form" style="padding:20px;">
	<h1><spring:message code="account.title"/></h1>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>${message}</div>
	</c:if>
	
	<div class="row">
		<div class="span">
			<form class="form-search" action="#">
			 	<label><spring:message code="account.userid"/></label> <input type="text" name="search_id"   class="input-small"  value="${param.search_id}"> 
			    <label><spring:message code="account.email"/></label> <input type="text" name="search_email" class="input-small" value="${param.search_email}">
			    <label><spring:message code="account.role"/></label> <input type="text" name="search_role" class="input-small" value="${param.search_role}">
			    <label><spring:message code="account.dept"/></label><input name="search_department_id" class="easyui-combotree" value="${param.search_department_id}" data-options="url:'${ctx}/department/api/get',method:'get',required:false">
			   <mytag:PermssionTag functionId="F2-2"> <button type="submit" class="btn" id="search_btn"><i class="icon-search"></i></button></mytag:PermssionTag>
		    </form>
	    </div>
	    <tags:sort/>
	</div>	
			
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th><spring:message code="account.table.userid"/></th>
			<th><spring:message code="account.table.name"/></th>
			<th><spring:message code="account.table.email"/></th>
			<th><spring:message code="account.table.dept"/></th>
			<th><spring:message code="account.table.role"/></th>
			<th><spring:message code="account.table.status"/></th>
			<th><spring:message code="account.table.operation"/></th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${users.content}" var="user">
			<tr>
				<td>${user.id}&nbsp;</td>
				<td>${user.name}&nbsp;</td>
				<td>${user.email}&nbsp;</td>
				<td>${user.department.name}</td>
				<td>
				<c:forEach items="${user.roles}" var="role">
					${role.name}&nbsp;
				</c:forEach>
				</td>
				<td>${user.status}&nbsp;</td>
				<td>
						<mytag:PermssionTag functionId="F2-5"><a href="${ctx}/account/show/${user.id}" id="editLink-${user.id}"><i class="icon-pencil"></i> <spring:message code="account.edit"/></a></mytag:PermssionTag>
						<mytag:PermssionTag functionId="F2-3"><a href="${ctx}/account/show/userInfo/${user.id}" id="info-${user.id}"><i class="icon-pencil"></i> <spring:message code="account.show"/></a></mytag:PermssionTag>
				</td>
			</tr>
		</c:forEach>
		</tbody>		
	</table>
	<tags:pagination page="${users}" paginationSize="4"/>
</div>
<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
	
</div>
</body>
</html>
