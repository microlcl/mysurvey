<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<!-- combotreee -->
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">

<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
<script>
$(document).ready(function() {
	
	var surveyStatus = [];
	<c:forEach items="${surveyStatus}" var="surveyStatus">
		surveyStatus.push('${surveyStatus}');
	</c:forEach>
	$("#cc").combotree({ 
		onLoadSuccess:function(node){//数据加载成功触发 
			$("#cc").combotree('setValues', surveyStatus);
		},
		onBeforeSelect:function(node){ 
			var tree = $(this).tree;
			var isLeaf = tree('isLeaf', node.target);
			console.log("isLeaf=" + isLeaf);
			return isLeaf;
		}
	});
});
</script>

<title><spring:message code="survey.myparticipation.title"/></title>
</head>
<body>
	<div class="form">
		<h1><spring:message code="survey.myparticipation.title"/></h1>
		<div class=" onefield" style="height:40px !important; text-align: right !important;padding-right: 10px;padding-top: 7px;margin-left:20px;background-color: white;">
			<form style="padding-left:10px;">
				<span  style="float:left;">
					<spring:message code="survey.myparticipation.status"/>
					<input id="cc" class="easyui-combotree" data-options="url:'${ctx}/category/api/getAll/surveyStatus',method:'get',required:false" style="width:200px;" name="search_surveyStatus" value="${param.search_surveyStatus}" />
					&nbsp; &nbsp; &nbsp; &nbsp;<spring:message code="survey.myparticipation.name"/><input type="text" name="search_keyword" value="${param.search_keyword}" style="width:400px;margin-bottom: 0px;margin-left:10px;" placeholder="<spring:message code="survey.myparticipation.name.placeholder"/>">
					<button type="submit" class="btn" id="search_btn_test"><i class="icon-search"></i></button>
				</span>
			</form>
		</div>
		
		<c:if test="${not empty message}">
		   <div id="message" style="margin-left:20px;margin-top:20px;width:80%;" class="alert alert-error input-medium controls"><button data-dismiss="alert" class="close">×</button>${message}</div>
		</c:if>
		
		<div  style="padding:20px;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th><spring:message code="survey.myparticipation.surveyname"/></th>
					<th><spring:message code="survey.myparticipation.surveystatus"/></th>
					<th><spring:message code="survey.myparticipation.updatetime"/></th>
					<th><spring:message code="survey.myparticipation.initiator"/></th>
					<th><spring:message code="survey.myparticipation.deadline"/></th>
					<th><spring:message code="survey.myparticipation.operation"/></th>
				</tr>
				</thead>
				<tbody>
				<c:set var="nowDate" value="<%=new Date() %>"/>
				<c:forEach items="${surveys.content}" var="survey">
					<tr>
						<td>${survey.subject}&nbsp;</td>
						<td>${survey.statusString}&nbsp;</td>
						<td><fmt:formatDate value="${survey.updateTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/>&nbsp;</td>
						<td>${survey.userId}&nbsp;</td>
						<td><fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/>&nbsp;</td>
						<td>
							<mytag:PermssionTag functionId="F8-6">
								<a href="${ctx}/survey/accessSurvey/${survey.id}" id="showLink-${survey.id}"><i class="icon-folder-open"></i><spring:message code="survey.myparticipation.show"/>
								<c:if test="${survey.deadlineTimestamp > nowDate}"><spring:message code="survey.myparticipation.canedit"/></c:if>
								<c:if test="${survey.deadlineTimestamp <= nowDate}"><spring:message code="survey.myparticipation.expire"/></c:if>
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