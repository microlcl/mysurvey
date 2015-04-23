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
		    <li><a href="#submitted" data-toggle="tab">参与问卷查看</a></li>
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
							    	<div class="bar" style="width: ${option.percent * 100}%"><fmt:formatNumber type="number" value="${option.percent * 100}" maxFractionDigits="2"/>%(${option.count}次)</div>
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
		   <div class="tab-pane fade" id="assignee">
		   		<c:if test="${survey.status=='P' || survey.status=='F'}">
				<form id="SendNotification" action="${ctx}/survey/sendNoti" method="post" class="form-horizontal">
					<div class="control-group">
						<label for="question" class="control-label formlabel">问卷完成状况:</label>
						<div class="controls">
							<div class="accordion-group" style="width: 500px;">
								<div class="accordion-heading">
									<center>
										<a href="#collapse" data-toggle="collapse"
											class="accordion-toggle"
											style="display: inline-block; word-wrap: break-word; text-decoration: none;">
											点击查看问卷完成状况 </a>
									</center>

								</div>
								<div class="accordion-body collapse" id="collapse">
								<div class="accordion-inner" style="padding-left: 260px">
									<select onchange="groupBy(this)" >
										<option value="1">显示全部</option>
										<option value="2">未完成</option>
										<option value="3">已完成</option>
									</select>
								</div>
									<c:forEach items="${surveyReceivers}" var="surveyReceiver" varStatus="status">
									<div id="${surveyReceiver.status}_${status.count}" class="accordion-inner" style="padding-left: 40px">
									 <c:choose>
									   <c:when test="${surveyReceiver.nickName=='' || surveyReceiver.nickName==null}">
									      ${surveyReceiver.userId}
									   </c:when>
									   <c:otherwise>
									      ${surveyReceiver.nickName}
									   </c:otherwise>
									 </c:choose>
									 <c:choose>
									   <c:when test="${surveyReceiver.status==0}">
									      <span  class="error" style="float:right;margin-right:140px">未完成</span>
									   </c:when >
									   <c:otherwise>
									      <span style="float:right;padding-right:10px"><i class="icon-ok"></i><font color="green" style="font-weight:bold;">已操作于</font>-- <fmt:formatDate value="${surveyReceiver.update_timeStamp}" pattern="yyyy/MM/dd  HH:mm"/></span>
									   </c:otherwise>
									   </c:choose>
									</div>
								</c:forEach>
									<c:if test="${(survey.status=='P')&& receivers!=''}">
									<input type="text" name="surveyId" value="${survey.id }" style="display:none;">
				                    <input type="text" name="subject" value="来自${survey.userId}的问卷调查：${survey.subject}的提醒" style="display:none;"> 
				                    <input type="text" name="receivers" value="${receivers }" style="display:none;">
				                    <input type="text" name="URL" value="${survey.paperURL }" style="display:none;">
									<div class="accordion-inner" id="0_sender">
									   <textarea name="desctription" style="width:340px;height:80px">Hi Dear<br>    请尽快完成调查，点击下方链接或将地址复制到浏览器地址栏中打开。<br>调查截止日期：   <fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/></textarea>
									   <input type="button" id="sendbtn" value="点击发送提醒" class="btn btn-warning" onclick="sendNoti()" style="height:80px">
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