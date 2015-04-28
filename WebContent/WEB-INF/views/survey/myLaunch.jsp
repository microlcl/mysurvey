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

<title>我发起的调查</title>
</head>
<body>
	<div class="form">
		<h1><spring:message code="survey.mylaunch.title"/></h1>
		<div class=" onefield" style="height:40px !important; text-align: right !important;padding-right: 10px;padding-top: 7px;margin-left:20px;background-color: white;">
			<form style="padding-left:10px;">
				<span  style="float:left;">
					<spring:message code="survey.mylaunch.status"/>
					<input id="cc" class="easyui-combotree" data-options="url:'${ctx}/category/api/getSurveyStatus',method:'get',required:false" style="width:200px;" name="search_surveyStatus" value="${param.search_surveyStatus}" />
					&nbsp; &nbsp; &nbsp; &nbsp;<spring:message code="survey.mylaunch.name"/><input type="text" name="search_keyword" value="${param.search_keyword}" style="width:400px;margin-bottom: 0px;margin-left:10px;" placeholder="<spring:message code="survey.mylaunch.name.placeholder"/>">
					<button type="submit" class="btn" id="search_btn_test"><i class="icon-search"></i></button>
				</span>
			</form>
		</div>
		
		<div  style="padding:20px;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th><spring:message code="survey.mylaunch.surveyname"/></th>
					<th><spring:message code="survey.mylaunch.surveystatus"/></th>
					<th><spring:message code="survey.mylaunch.updatetime"/></th>
					<th><spring:message code="survey.mylaunch.informant"/></th>
					<th><spring:message code="survey.mylaunch.deadline"/></th>
					<th><spring:message code="survey.mylaunch.operation"/></th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${surveys.content}" var="survey">
					<tr>
						<td>${survey.subject}&nbsp;</td>
						<td>${survey.statusString}&nbsp;</td>
						<td><fmt:formatDate value="${survey.updateTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/>&nbsp;</td>
						<td><a href="${ctx}/myGroup/list"> ${survey.groupsString}</a>&nbsp;</td>
						<td><fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/>&nbsp;</td>
						<td>
							<c:if test="${survey.status!='R'}">	
							<mytag:PermssionTag functionId="F8-6"><a href="${ctx}/survey/surveyDetail/${survey.id}" id="showLink-${survey.id}"><i class="icon-folder-open"></i> <spring:message code="survey.mylaunch.show"/></a>&nbsp;&nbsp;</mytag:PermssionTag>
							</c:if>
							<c:if test="${survey.status=='R'}">	
							<mytag:PermssionTag functionId="F8-3"><a href="${ctx}/survey/surveyDetail/${survey.id}" id="editLink-${survey.id}"><i class="icon-edit"></i> <spring:message code="survey.mylaunch.show"/><spring:message code="survey.mylaunch.canpublish"/></a>&nbsp;&nbsp;</mytag:PermssionTag>
							</c:if>
							<%-- <c:if test="${survey.status=='P' || survey.status=='F'}"> --%>	
							<mytag:PermssionTag functionId="F8-4"><a href="${ctx}/survey/statistic/${survey.id}" id="deleteLink-${paper.id}"><i class="icon-remove"></i> <spring:message code="survey.mylaunch.answers"/></a></mytag:PermssionTag>
							<%-- </c:if> --%>
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