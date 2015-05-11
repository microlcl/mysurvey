<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title><spring:message code="survey.publishsurvey.title"/></title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
    <link rel="stylesheet" media="all" type="text/css" href="Styles/jquery-ui-1.8.14.custom.css" />
    
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dateTimePicker/jquery.datetimepicker.css"/>
    <script src="${ctx}/static/dateTimePicker/jquery.js" type="text/javascript"></script>
    <script src="${ctx}/static/dateTimePicker/jquery.datetimepicker.js" type="text/javascript"></script>
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/nano/nano.js" type="text/javascript"></script>
	
	<script >
		function getDeadline() {
			$('#datetimepicker7').datetimepicker();
		}
		
		function checkAnonymous(){
		    var  check=document.getElementById("isAnonymousCheck");
		    var alertInfo="<br><strong><font color='red'><spring:message code="survey.publishsurvey.anonymousalert"/></font></strong>";
		    if(check.checked){
		      $('#isAnonymous').val('T');
		      $('#description').val($('#description').val()+alertInfo);
		    }else{
		      $('#isAnonymous').val('F');
		      $('#description').val($('#description').val().replace(alertInfo,""));
		    }
		}
		
		function markGroup(obj){
		    var tab= $(obj);
		    var mark=tab.find('i');
		    if(mark.css("display")=='none'){
		       mark.css("display","");
		    }else{
		        mark.css("display","none");
		    }
		}
		
		function formatAndCheckAndSend(){
		    var _surveyGroup = "";
		    $("input[name='groupid']").each(function(){
		       var mark=$(this).parent().find('i');
		       if(mark.css('display')!='none' && $(this).val()!=""){
		          _surveyGroup += $(this).val()+",";
 		       }
		    });
		    $("#surveyGroup").val(_surveyGroup);
		    if($("#datetimepicker7").val()==""){
		       $("#ddateEmptyError").show();
		       $("#ddateInvalidError").hide();
		       $("#subjectError").hide();
		       $("#groupError").hide();
		    }else if(deaddateVerification($("#datetimepicker7").val())){
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").show();
		        $("#subjectError").hide();
		        $("#groupError").hide();
		    }else if($("#surveySubject").val()==""){
		        $("#subjectError").show();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").hide();
// 		    }else if(_surveyGroup==""){
// 		        $("#subjectError").hide();
// 		        $("#ddateEmptyError").hide();
// 		        $("#ddateInvalidError").hide();
// 		        $("#groupError").show();
		    }else{
		        $("#subjectError").hide();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").hide();
		        $("#surveyForm").submit();
		        $("#action-bar").hide();
		        $("#submitOK").show();
		    }
		}
		
		function formatAndCheckAndSave(){
		    var _surveyGroup = "";
		    $("input[name='groupid']").each(function(){
		       var mark=$(this).parent().find('i');
		       if(mark.css('display')!='none' && $(this).val()!=""){
		          _surveyGroup += $(this).val()+",";
 		       }
		    });
		    $("#surveyGroup").val(_surveyGroup);
		    if($("#datetimepicker7").val()==""){
		       $("#ddateEmptyError").show();
		       $("#ddateInvalidError").hide();
		       $("#subjectError").hide();
		       $("#groupError").hide();
		    }else if(deaddateVerification($("#datetimepicker7").val())){
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").show();
		        $("#subjectError").hide();
		        $("#groupError").hide();
		    }else if($("#surveySubject").val()==""){
		        $("#subjectError").show();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").hide();
		    }else if(_surveyGroup==""){
		        $("#subjectError").hide();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").show();
		    }else{
		        $("#subjectError").hide();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").hide();
		        $("#act").val("save");
		        $("#surveyForm").submit();
		        $("#action-bar").hide();
		        $("#submitOK").show();
		    }
		}
		
		function formatAndCheckAndSaveUpdate(){
		    var _surveyGroup = "";
		    $("input[name='groupid']").each(function(){
		       var mark=$(this).parent().find('i');
		       if(mark.css('display')!='none' && $(this).val()!=""){
		          _surveyGroup += $(this).val()+",";
 		       }
		    });
		    $("#surveyGroup").val(_surveyGroup);
		    if($("#datetimepicker7").val()==""){
		       $("#ddateEmptyError").show();
		       $("#ddateInvalidError").hide();
		       $("#subjectError").hide();
		       $("#groupError").hide();
		    }else if(deaddateVerification($("#datetimepicker7").val())){
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").show();
		        $("#subjectError").hide();
		        $("#groupError").hide();
		    }else if($("#surveySubject").val()==""){
		        $("#subjectError").show();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").hide();
		    }else if(_surveyGroup==""){
		        $("#subjectError").hide();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").show();
		    }else{
		        $("#subjectError").hide();
		        $("#ddateEmptyError").hide();
		        $("#ddateInvalidError").hide();
		        $("#groupError").hide();
		        $("#act").val("update");
		        $("#surveyForm").submit();
		        $("#action-bar").hide();
		        $("#submitOK").show();
		    }
		}
		
		function deaddateVerification(time){
		   var enddate=time.replace("/","").replace("/","").replace(" ","").replace(":","");
		   var year=new Date().getFullYear();
		   var month=checkNumbers(new Date().getMonth()+1);
		   var day=checkNumbers(new Date().getDate());
		   var hour=checkNumbers(new Date().getHours());
		   var minutes=checkNumbers(new Date().getMinutes());
		   var now=year.toString()+month.toString()+day.toString()+hour.toString()+minutes.toString();
		 //  alert(enddate+"    "+now);
		   return enddate<=now;
		}
		
		function checkNumbers(arg){
		    if(arg<10){
		       arg="0"+arg.toString();
		       return arg;
		    }
		    else return arg;
		}
		
		function sendNoti(){
		   $("#sendbtn").val("请稍等...");
		   $("#sendbtn").attr("disabled","disabled");
		   $("#SendNotification").submit();
		}
		
	</script>
</head>
<body>
	<div class="form">
		<h1><spring:message code="survey.publishsurvey.title"/>:&nbsp ${paper.paperName }</h1>
		<div class="alert hide" id="warning-block">
	  	   <strong><spring:message code="survey.publishsurvey.warning1"/> </strong><spring:message code="survey.publishsurvey.warning2"/>
		</div>
		<div style="padding:20px;">
			
			<c:set var="toId" value="${paper.id }"/>
			<c:if test="${isPublish }">
				<c:set var="toId" value="${survey.id }"/>
			</c:if>
			
			<form id="surveyForm" name="surveyForm" action="${ctx}/survey/surveyAction/${toId}" method="post" class="form-horizontal">
				<c:if test="${isPublish} "><input type="hidden" id="surveyId" name="surveyId" value="${survey.id }"></c:if>
				<div class="control-group">
					<label for="question" class="control-label formlabel"><spring:message code="survey.publishsurvey.subject"/></label>
					<div class="controls">						
						<input type="text" id="surveySubject" name="subject"  maxlength="128" class="input-large required" placeholder="<spring:message code="survey.publishsurvey.subject.placeholder"/>" <c:if test="${survey.status=='1-0-3-1' || survey.status=='1-0-3-2'}">disabled="disabled"</c:if> <c:if test="${survey.subject!=null }">value="${survey.subject }"</c:if> />
						 <span id="subjectError" class="error" style="display:none"><spring:message code="survey.publishsurvey.subject.error"/></span>
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel"><spring:message code="survey.publishsurvey.paperdetail"/></label>
					<div class="controls">						
						<a href="${ctx}/paper/show/${paper.id}" id="showLink-${paper.id}"><i class="icon-folder-open"></i> <spring:message code="survey.publishsurvey.paperdetail.btn"/></a>
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel"><spring:message code="survey.publishsurvey.anonymous"/></label>
					<div class="controls">
					   <input type="checkbox" <c:if test="${survey.status=='1-0-3-1' || survey.status=='1-0-3-2'}">disabled="disabled"</c:if> <c:if test="${survey.isAnonymous=='T' }">checked="checked"</c:if> id="isAnonymousCheck" onclick="checkAnonymous()" >
					   <input type="text" id="isAnonymous" <c:if test="${survey.isAnonymous=='T' }">value="T"</c:if><c:if test="${survey.isAnonymous=='F' }">value="F"</c:if> name="isAnonymous" style="display:none;">
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel"><spring:message code="survey.publishsurvey.deadline"/></label>
					<div class="controls">
					   <input type="text" <c:if test="${survey.status=='1-0-3-1' || survey.status=='1-0-3-2'}">disabled="disabled"</c:if> id="datetimepicker7" <c:if test="${survey.deadlineTimestamp!=null }"> value="<fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy/MM/dd HH:mm"/>"</c:if> name="deadlineTimestamp" readonly="readonly" placeholder="<spring:message code="survey.publishsurvey.deadline.placeholder"/>" onclick="getDeadline()"  />
					   <span id="ddateEmptyError" class="error" style="display:none"><spring:message code="survey.publishsurvey.deadline.emptyerror"/></span>
					   <span id="ddateInvalidError" class="error" style="display:none"><spring:message code="survey.publishsurvey.deadline.invaliderror"/></span>
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel"><spring:message code="survey.publishsurvey.description"/></label>					
					<div class="controls">
					    <textarea id="description" <c:if test="${survey.status=='1-0-3-1' || survey.status=='1-0-3-2'}">disabled="disabled"</c:if> name="description" style="width:440px" maxlength="128"><c:if test="${survey.description!=null }">${survey.description }</c:if><c:if test="${survey.description==null }">Hi Dear:<br>    <spring:message code="survey.publishsurvey.description.text"/></c:if></textarea>
					</div>
				</div>	
				<div class="control-group">
				<label for="question" class="control-label formlabel"><spring:message code="survey.publishsurvey.groups"/></label>		
				<c:if test="${survey.status=='1-0-3-1' || survey.status=='1-0-3-2'}"><div class="controls"><input type="text" disabled="disabled" value="${survey.groupsString }"></div></c:if>
				 <c:if test="${survey.status!='1-0-3-1' && survey.status!='1-0-3-2'}">
					 <div class="controls" style="width:550px">
					  <c:forEach items="${groups}"  var="group" varStatus="status">
					    <div class="btn" onclick="markGroup(this)" style="margin-top:5px" id="group_${group.id }">${group.groupName}<i class="icon-ok" style="width:20px;display:${group.flagString};"></i><input type="text" value="${group.id }" id="groupid" name="groupid" style="display:none;"></div>
					  </c:forEach>
					 </div>
					 <span id="groupError" class="error" style="display:none"><spring:message code="survey.publishsurvey.groups.error"/></span>
					 </c:if>
				</div>
				<div class="control-group">
			    <c:if test="${survey.status=='1-0-3-1'}">
				<label for="question" class="control-label formlabel"><spring:message code="survey.publishsurvey.url"/></label>
				    <div class="controls" style="width:550px">
				   ${url}
				    </div>
				</c:if>	 
				</div>
				<input type="text" name="surveyGroup" id="surveyGroup" style="display:none;">
				<input type="hidden" name="isPublish" id="isPublish" value="${isPublish }">
				<input type="hidden" name="act" id="act" value="">
				<input type="hidden" name="status" id="act" value="${survey.status }">
			</form>
		</div>
		<div id="action-bar" class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
			<c:if test="${survey.status==null}">
			<input id="submit_btn" class="btn btn-warning"  type="button" value="<spring:message code="survey.publishsurvey.send"/>" onclick="formatAndCheckAndSend();" />&nbsp;&nbsp;&nbsp;
			<input id="submit_btn" class="btn btn-success"  type="button" value="<spring:message code="survey.publishsurvey.save"/>" onclick="formatAndCheckAndSave();" />	
			</c:if>
			<c:if test="${survey.status=='1-0-3-0'}">
			<input id="submit_btn" class="btn btn-warning"  type="button" value="<spring:message code="survey.publishsurvey.send"/>" onclick="formatAndCheckAndSend();" />&nbsp;&nbsp;&nbsp;
			<input id="submit_btn" class="btn btn-success"  type="button" value="<spring:message code="survey.publishsurvey.saveupdate"/>" onclick="formatAndCheckAndSaveUpdate();" />	
			</c:if>
			
			<input id="cancel_btn" class="btn" type="button" value="<spring:message code="survey.publishsurvey.back"/>" onclick="history.back()"/>
		</div>
		<center><span id="submitOK" style="display:none;"><h3><spring:message code="survey.publishsurvey.wait"/></h3></span></center>
	</div>
</body>
</html>