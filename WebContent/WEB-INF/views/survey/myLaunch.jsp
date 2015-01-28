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

<title>我发起的调查</title>
</head>
<body>
	<div class="form">
		<h1>我发起的调查</h1>
		<div  style="padding:20px;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>调查名称</th>
					<th>调查状态</th>
					<th>更新时间</th>
					<th>被调查者</th>
					<th>截止日期</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${surveys.content}" var="survey">
					<tr>
						<td>${survey.subject}&nbsp;</td>
						<td>${survey.statusString}&nbsp;</td>
						<td>${survey.updateTimestamp}&nbsp;</td>
						<td>${survey.groupsString}&nbsp;</td>
						<td>${survey.deadlineTiemstamp}&nbsp;</td>
						<td>
							<mytag:PermssionTag functionId="F8-6"><a href="${ctx}/survey/show/${survey.id}" id="showLink-${survey.id}"><i class="icon-folder-open"></i> 查看</a>&nbsp;&nbsp;</mytag:PermssionTag>
							<c:if test="${survey.status=='R'}">	
							<mytag:PermssionTag functionId="F8-3"><a href="${ctx}/survey/publishSurvey/${survey.id}" id="editLink-${survey.id}"><i class="icon-edit"></i> 发布</a>&nbsp;&nbsp;</mytag:PermssionTag>
							</c:if>
							<c:if test="${survey.status=='P' || survey.status=='F'}">	
							<mytag:PermssionTag functionId="F8-4"><a href="#" id="deleteLink-${paper.id}"><i class="icon-remove"></i> 答案统计</a></mytag:PermssionTag>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>		
			</table>
		<tags:pagination page="${surveys}" paginationSize="4"/>
		</div>
	</div>
	<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
	
	</div>
</body>
</html>