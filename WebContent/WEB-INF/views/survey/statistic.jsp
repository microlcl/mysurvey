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

function groupBy(obj){
		
   $(".accordion-inner").each(function(){
       var id=$(this).attr('id');
       if(id){
        var jud=id.split("_");
        if(obj.value==3){
        if(jud[0]==0){
	          $(this).hide();
	       }else{
	          $(this).show();
	       }
	       }else if(obj.value==2){
	         if(jud[0]==1){
	          $(this).hide();
	       }else{
	          $(this).show();
	       }
	       }else{
	           $(this).show();
	       }
       }
   });
}

</script>
<title><spring:message code="survey.statistic.title"/></title>
</head>
<body>
<div class="form">
	<h1><spring:message code="survey.statistic.statistic"/> ${survey.subject} 
	   <br> <spring:message code="survey.statistic.initiator"/>${survey.userId} &nbsp&nbsp&nbsp <spring:message code="survey.statistic.deadline"/><fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/>
	</h1>
	<div  style="padding:20px;">
		<ul class="nav nav-tabs" id="titleTab">
		    <li class="active"><a href="#statistic" data-toggle="tab"><spring:message code="survey.statistic.statistictab"/></a></li>
		    <li><a href="#submitted" data-toggle="tab"><spring:message code="survey.statistic.seeparticipation"/></a></li>
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
							    	<div class="bar" style="width: ${option.percent * 100}%"><fmt:formatNumber type="number" value="${option.percent * 100}" maxFractionDigits="2"/>%(${option.count}<spring:message code="survey.statistic.count"/>)</div>
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
		   <div class="tab-pane fade" id="submitted">
		   		<c:if test="${survey.status=='P' || survey.status=='F'}">
				<form id="SendNotification" action="${ctx}/survey/sendNoti" method="post" class="form-horizontal">
					<div class="control-group">
						<label for="question" class="control-label formlabel"><spring:message code="survey.statistic.finishcondition"/></label>
						<div class="controls">
							<div class="accordion-group" style="width: 500px;">
								<div class="accordion-heading">
									<center>
										<a href="#collapse" data-toggle="collapse"
											class="accordion-toggle"
											style="display: inline-block; word-wrap: break-word; text-decoration: none;">
											<spring:message code="survey.statistic.finishcondition.button"/> </a>
									</center>

								</div>
								<div class="accordion-body collapse" id="collapse">
								<div class="accordion-inner" style="padding-left: 260px">
									<select onchange="groupBy(this)" >
										<option value="1"><spring:message code="survey.statistic.groupby1"/></option>
										<option value="2"><spring:message code="survey.statistic.groupby2"/></option>
										<option value="3"><spring:message code="survey.statistic.groupby3"/></option>
									</select>
								</div>
									<c:forEach items="${surveyReceivers}" var="surveyReceiver" varStatus="status">
									<div id="${surveyReceiver.status}_${status.count}" class="accordion-inner" style="padding-left: 40px">
									 <c:choose>
									   <c:when test="${surveyReceiver.nickName=='' || surveyReceiver.nickName==null}">
									      <c:choose>
										   <c:when test="${surveyReceiver.status==0}">
										   	<c:if test="${survey.isAnonymous=='T' }">
										   		*****
										   	</c:if>
										   	<c:if test="${survey.isAnonymous!='T' }">
										   		${surveyReceiver.userId}
										   	</c:if>
										   </c:when >
										   <c:otherwise>
										      <a class="btn" href="${ctx}/survey/accessSurvey/${survey.id}?userId=${surveyReceiver.userId}">
										      	<c:if test="${survey.isAnonymous=='T' }">
											   		*****
											   	</c:if>
											   	<c:if test="${survey.isAnonymous!='T' }">
											   		${surveyReceiver.userId}
											   	</c:if>
										      </a>
										   </c:otherwise>
										   </c:choose>
									   </c:when>
									   <c:otherwise>
									      <c:choose>
										   <c:when test="${surveyReceiver.status==0}">
										   		<c:if test="${survey.isAnonymous=='T' }">
											   		*****
											   	</c:if>
											   	<c:if test="${survey.isAnonymous!='T' }">
											   		${surveyReceiver.nickName}
											   	</c:if>
										   </c:when >
										   <c:otherwise>
										      <a class="btn" href="${ctx}/survey/accessSurvey/${survey.id}?userId=${surveyReceiver.userId}">
											  	<c:if test="${survey.isAnonymous=='T' }">
											   		*****
											   	</c:if>
											   	<c:if test="${survey.isAnonymous!='T' }">
											   		${surveyReceiver.nickName}
											   	</c:if>
											  </a>
										   </c:otherwise>
										   </c:choose>
									   </c:otherwise>
									 </c:choose>
									 <c:choose>
									   <c:when test="${surveyReceiver.status==0}">
									      <span  class="error" style="float:right;margin-right:140px"><spring:message code="survey.statistic.unfinished"/></span>
									   </c:when >
									   <c:otherwise>
									      <span style="float:right;padding-right:10px"><i class="icon-ok"></i><font color="green" style="font-weight:bold;"><spring:message code="survey.statistic.operationtime"/></font>-- <fmt:formatDate value="${surveyReceiver.update_timeStamp}" pattern="yyyy/MM/dd  HH:mm"/></span>
									   </c:otherwise>
									   </c:choose>
									</div>
								</c:forEach>
									<c:if test="${(survey.status=='P')&& receivers!=''}">
									<input type="text" name="surveyId" value="${survey.id }" style="display:none;">
				                    <input type="text" name="subject" value="<spring:message code="survey.statistic.subject1"/>${survey.userId}<spring:message code="survey.statistic.subject2"/>${survey.subject}<spring:message code="survey.statistic.subject3"/>" style="display:none;"> 
				                    <input type="text" name="receivers" value="${receivers }" style="display:none;">
				                    <input type="text" name="URL" value="${survey.paperURL }" style="display:none;">
									<div class="accordion-inner" id="0_sender">
									   <textarea name="desctription" style="width:340px;height:80px">Hi Dear<br>    <spring:message code="survey.statistic.description"/><br><spring:message code="survey.statistic.surveydeadline"/>   <fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/></textarea>
									   <input type="button" id="sendbtn" value="<spring:message code="survey.statistic.sendbtn"/>" class="btn btn-warning" onclick="sendNoti()" style="height:80px">
									</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</form>
			</c:if>
		   </div>
		</div>
    </div>
</div>
<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
</div>
</body>
</html>