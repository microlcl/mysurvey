<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<!-- combotreee -->
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">

<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">

<title>答案统计</title>
</head>
<body>
<div class="form">
	<h1>答案统计： ${survey.subject} 
	   <br> 发起人：${survey.userId} &nbsp&nbsp&nbsp 截止日期：<fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/>
	</h1>
	<div  style="padding:20px;">
		<ul class="nav nav-tabs" id="titleTab">
		    <li class="active"><a href="#statistic" data-toggle="tab">答案统计</a></li>
		    <li><a href="#assignee" data-toggle="tab">参与人员</a></li>
	    </ul>
	    
	    <div id="titleTabContent" class="tab-content" style="padding:20px;">
		   <div class="tab-pane fade in active" id="statistic">
		      <c:forEach items="${questions}" var="question" varStatus="status">
		      	<div id="question" >
                  <div class="accordion-heading">
                  	<span style="padding-left:8px" id="question_${question.id }">Q${status.count}：</span>
                      	${question.question}
                   </div>
                    <div class="accordion-inner" style="padding-left:55px">
						<c:if test="${question.questionType != '3'}">
							<c:forEach items="${question.options}" var="option" varStatus="as">
								<c:choose>
									<c:when test="${as.index % 4 == 0 }">
										<c:set var="barClass" value="progress progress-info"/>
									</c:when>
									<c:when test="${as.index % 4 == 1 }">
										<c:set var="barClass" value="progress progress-success"/>
									</c:when>
									<c:when test="${as.index % 4 == 2 }">
										<c:set var="barClass" value="progress progress-warning"/>
									</c:when>
									<c:otherwise>
										<c:set var="barClass" value="progress progress-danger"/>
									</c:otherwise>								
								</c:choose>
								<label class="radio">
									${option.content}
								</label>
							    <div class="${barClass }">
							    	<div class="bar" style="width: ${option.percent * 100}%"><fmt:formatNumber type="number" value="${option.percent * 100}" maxFractionDigits="2"/>% - ${option.count}</div>
							    </div>
							</c:forEach>
						</c:if>
						<c:if test="${question.questionType == '3'}">
							<textarea id="_answer">${question.openAnswer}</textarea>
						</c:if>
                    </div>
                   </div>
		      </c:forEach>
		   </div>
		   <div class="tab-pane fade" id="assignee">
		   		<c:forEach items="${answerIds}" var="id" varStatus="as">
		   			<c:set var="answererName" value="${id}"/>
		   			<c:if test="${survey.isAnonymous == 'T' }">
		   				<c:set var="answererName" value="******"/>
		   			</c:if>
		   			    <table class="table table-hover">
		   			    	<thead>
		   			    		<tr><th>参与人</th><th>问卷链接</th></tr>
		   			    	</thead>
		   			    	<tbody>
		   			    		<tr>
		   			    			<td>${answererName }</td>
		   			    			<td><a class="btn" href="${ctx}/survey/accessSurvey/${survey.id}?userId=${id}">点击查看</a></td>
		   			    		</tr>
		   			    	</tbody>
					    </table>
		   		</c:forEach>
		   </div>
		</div>
    </div>
</div>
<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
</div>
</body>
</html>