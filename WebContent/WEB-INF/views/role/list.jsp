<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
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
<div class="form" >
	<h1>权限管理</h1>
	<table class="table table-hover">
    	<thead>
    		<tr><th>角色</th><th>用户</th><th>操作</th></tr>
    	</thead>
    	<tbody>
    		<c:forEach items="${userRoles}" var="ur" varStatus="as">
	    		<tr>
	    			<td>${ur.roleName}</td>
	    			<td>${ur.userId}</td>
	    			<td><a class="btn" href="${ctx}/role/remove?userId=${ur.userId}&roleId=${ur.roleId}">删除</a></td>
    			</tr>
			</c:forEach>
    	</tbody>
	</table>
	<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
		<input id="submit_btn" style="height: 40px !important;width: 130px !important;" class="btn" type="button" value="新增" onclick="showNew()"/>
	</div>
</div>
</body>
</html>