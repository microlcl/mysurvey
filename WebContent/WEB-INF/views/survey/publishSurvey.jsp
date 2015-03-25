<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>发布问卷</title>
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
		    var alertInfo="<br><strong><font color='red'>*此调查为匿名调查</font></strong>";
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
		
		function formatAndCheck(){
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
		<h1>发布问卷:&nbsp ${paper.paperName }</h1>
		<div class="alert hide" id="warning-block">
	  	   <strong>注意: </strong>请选择业务类型和表单类型。
		</div>
		<div style="padding:20px;">
			
			<c:set var="toId" value="${paper.id }"/>
			<c:if test="${isPublish }">
				<c:set var="toId" value="${survey.id }"/>
			</c:if>
			
			<form id="surveyForm" action="${ctx}/survey/surveyAction/${toId}" method="post" class="form-horizontal">
				<c:if test="${isPublish} "><input type="hidden" id="surveyId" name="surveyId" value="${survey.id }"></c:if>
				<div class="control-group">
					<label for="question" class="control-label formlabel">问卷主题:</label>
					<div class="controls">						
						<input type="text" id="surveySubject" name="subject"  maxlength="128" class="input-large required" placeholder="0~128个字符" <c:if test="${survey.status=='P' || survey.status=='F'}">disabled="disabled"</c:if> <c:if test="${survey.subject!=null }">value="${survey.subject }"</c:if> />
						 <span id="subjectError" class="error" style="display:none">请输入调查主题</span>
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel">问卷详情:</label>
					<div class="controls">						
						<a href="${ctx}/paper/show/${paper.id}" id="showLink-${paper.id}"><i class="icon-folder-open"></i> 点击查看查看问卷</a>
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel">是否匿名调查:</label>
					<div class="controls">
					   <input type="checkbox" <c:if test="${survey.status=='P' || survey.status=='F'}">disabled="disabled"</c:if> <c:if test="${survey.isAnonymous=='T' }">checked="checked"</c:if> id="isAnonymousCheck" onclick="checkAnonymous()" >
					   <input type="text" id="isAnonymous" <c:if test="${survey.isAnonymous=='T' }">value="T"</c:if><c:if test="${survey.isAnonymous=='F' }">value="F"</c:if> name="isAnonymous" style="display:none;">
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel">调查截止日期:</label>
					<div class="controls">
					   <input type="text" <c:if test="${survey.status=='P' || survey.status=='F'}">disabled="disabled"</c:if> id="datetimepicker7" <c:if test="${survey.deadlineTimestamp!=null }">value=<fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/></c:if> name="deadlineTimestamp" readonly="true" placeholder="双击选择时间与日期" onclick="getDeadline()"  />
					   <span id="ddateEmptyError" class="error" style="display:none">请设定调查截止日期！</span>
					   <span id="ddateInvalidError" class="error" style="display:none">请设定有效的截止日期！</span>
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel">调查描述:</label>					
					<div class="controls">
					    <textarea id="description" <c:if test="${survey.status=='P' || survey.status=='F'}">disabled="disabled"</c:if> name="description" style="width:440px" maxlength="128"><c:if test="${survey.description!=null }">${survey.description }</c:if><c:if test="${survey.description==null }">Hi Dear:<br>    您收到一份调查问卷，请点击下方链接或复制地址到浏览器中开始</c:if></textarea>
					</div>
				</div>	
				<div class="control-group">
				<label for="question" class="control-label formlabel">调查的群组:</label>		
				<c:if test="${survey.status=='P' || survey.status=='F'}"><div class="controls"><input type="text" disabled="disabled" value="${survey.groupsString }"></div></c:if>
				 <c:if test="${survey.status!='P' && survey.status!='F'}">
					 <div class="controls" style="width:550px">
					  <c:forEach items="${groups}"  var="group" varStatus="status">
					    <div class="btn" onclick="markGroup(this)" style="margin-top:5px" id="group_${group.id }">${group.groupName}<i class="icon-ok" style="width:20px;display:${group.flagString};"></i><input type="text" value="${group.id }" id="groupid" name="groupid" style="display:none;"></div>
					  </c:forEach>
					 </div>
					 <span id="groupError" class="error" style="display:none">请勾选需要调查的群组</span>
					 </c:if>
				</div>
				<input type="text" name="surveyGroup" id="surveyGroup" style="display:none;">
				<input type="hidden" name="isPublish" id="isPublish" value="${isPublish }">
			</form>

			<c:if test="${survey.status=='P' || survey.status=='F' || survey.status=='N' }">
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
								 <c:forEach items="${ gitems}" var="gitem" varStatus="">
									<div class="accordion-inner" style="padding-left: 40px">
									 <c:choose>
									   <c:when test="${gitem[0]=='' }">
									      ${gitem[1]}
									   </c:when>
									   <c:otherwise>
									      ${gitem[0]}
									   </c:otherwise>
									 </c:choose>
									 <c:choose>
									   <c:when test="${gitem[2]==0}">
									      <span  class="error" style="float:right;margin-right:140px">未完成</span>
									   </c:when >
									   <c:otherwise>
									      <span style="float:right;padding-right:10px"><i class="icon-ok"></i><font color="green" style="font-weight:bold;">已完成于</font>-- ${gitem[3]}</span>
									   </c:otherwise>
									   </c:choose>
									   
									</div>
								</c:forEach>
									<c:if test="${(survey.status=='P' || survey.status=='N')&& receivers!=''}">
									<input type="text" name="surveyId" value="${survey.id }" style="display:none;">
				                    <input type="text" name="subject" value="来自${survey.userId}的问卷调查：${survey.subject}的提醒" style="display:none;"> 
				                    <input type="text" name="receivers" value="${receivers }" style="display:none;">
				                    <input type="text" name="URL" value="${survey.paperURL }" style="display:none;">
									<div class="accordion-inner">
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
		<div id="action-bar" class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
			<c:if test="${survey.status!='P' && survey.status!='F'}"><input id="submit_btn" class="btn btn-warning"  type="button" value="提交" onclick="formatAndCheck();" />&nbsp;	</c:if>
			<input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/>
		</div>
		<center><span id="submitOK" style="display:none;"><h3>请稍等...</h3></span></center>
	</div>
</body>
</html>