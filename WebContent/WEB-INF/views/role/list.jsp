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
<div class="form">
	<h1>权限管理</h1>
	
	<div style="padding-left:30px;padding-top:20px">
	<a href="#newUserRole" role="button" class="btn" data-toggle="modal" style="margin-bottom:30px">赋予角色</a>
	<div id="newUserRole" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3>角色赋予</h3>
		</div>
		<div class="modal-body">
			<form id="newForm" action="${ctx}/role/add">
	    		用户ID: <input type="text" name="userId"><br/>
	    		赋予角色:
				<select name="roleId">
		    		<c:forEach items="${roles }" var="role">
						<option value="${role.id}">${role.name }</option>	    			
		    		</c:forEach>
	    		</select>
    		</form>
		</div>
		<div class="modal-footer">
			<a href="#" onclick="new function(){$('#newForm').submit();return null;}" class="btn btn-primary">提交</a>
			<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		</div>
	</div>
	
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
	</div>
</div>
<div class="form-actions" style="margin-top:-30px;">
</div>
</body>
</html>