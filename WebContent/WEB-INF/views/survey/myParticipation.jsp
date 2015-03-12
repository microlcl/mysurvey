<%@page import="java.util.Date"%>
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

<title>我参与的调查</title>
</head>
<body>
	<div class="form">
		<h1>我参与的调查</h1>
		<div  style="padding:20px;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>调查名称</th>
					<th>调查状态</th>
					<th>更新时间</th>
					<th>发起人</th>
					<th>截止日期</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="nowDate" value="<%=new Date() %>"/>
				<c:forEach items="${surveys.content}" var="survey">
					<tr>
						<td>${survey.subject}&nbsp;</td>
						<td>${survey.statusString}&nbsp;</td>
						<td>${survey.updateTimestamp}&nbsp;</td>
						<td>${survey.userId}&nbsp;</td>
						<td>${survey.deadlineTimestamp}&nbsp;</td>
						<td>
							<mytag:PermssionTag functionId="F8-6">
								<a href="${ctx}/survey/accessSurvey/${survey.id}" id="showLink-${survey.id}"><i class="icon-folder-open"></i>查看
								<c:if test="${survey.deadlineTimestamp > nowDate}">(可修改)</c:if>
								<c:if test="${survey.deadlineTimestamp <= nowDate}">(已截止)</c:if>
								</a>&nbsp;&nbsp;
							</mytag:PermssionTag>
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