<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>回答问卷</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script>
		
		function fillData(){
		   $("div[id='question']").each(function(){
             if($(this).find("input[name='type']").val() == 1){
                $(this).find($("input[type='radio']:checked")).each(function(){
                $(this).parent().parent().parent().find("input[id='answer']").val($(this).val());
                });
             }else if($(this).find("input[name='type']").val() == 2){
                 var _answer="";
                $(this).find($("input[type='checkbox']:checked")).each(function(){
                 _answer+=$(this).val()+",";
                });
                $(this).find("#answer").val(_answer);
             }else{
               $(this).find("#answer").val($(this).find("#_answer").val());
             }
             
		   });
		}
		
		
		function checkForm(){
		    var flag=1;
		    $("div[id='question']").each(function(){
		      if($(this).find("#answer").val().length == 0 || $(this).find("#answer").val()==""){
		        $(this).find("#nullAlert").show();
		        flag=0;
		        window.location.hash =  "#question_"+$(this).find("#questionId").val();
		        return false;
		      }else{
		        $(this).find("#nullAlert").hide();
		      }
		   });
		   
		   if(flag==0){
		      return false;
		   }else{
		      return true;
		   }		     
		}
		
		function sumbitForm(){
		   fillData();
		   if(checkForm()){
		     $("#actionForm").submit();
		   }
		}
		
		
	</script>

</head>
<body>
	<div class="form">
	  <h1>回答问卷： ${survey.subject} 
	   <br> 发起人：${survey.userId} &nbsp&nbsp&nbsp 截止日期：<fmt:formatDate value="${survey.deadlineTimestamp}" pattern="yyyy年MM月dd日   HH:mm"/>
	  </h1>
	  <form id="actionForm" action="${ctx}/survey/saveAction" method="post">
	  <input type="text" id="surveyId" name="surveyId" value="${survey.id}" style="display:none;" />
	  <input type="text" id="paperId" name="paperId" value="${survey.paperId}" style="display:none;" />
		<div  style="padding:20px;">
			<c:forEach items="${questions}" var="question" varStatus="status">
			   <c:if test="${question.trashed == 'F'}">
			     <div id="question" >
                  <div class="accordion-heading">
                    <span id="nullAlert" class="error" style="display:none;">请完成此问题</span>
                  	<span style="padding-left:8px" id="question_${question.id }">Q${status.count}：</span>
                      	${question.question}
                   </div>
                   <input type="text" value="${question.questionType}" name="type" style="display:none;"/>
                    <div class="accordion-inner" style="padding-left:55px">
						<c:if test="${question.questionType == '1'}">
							<c:forEach items="${question.splitOptions}" var="splitOption" varStatus="as">
								<label class="radio">
									<input type="radio" name="questionOption_${question.id}" value="${as.index+1}" >
										${splitOption}
								</label>
							</c:forEach>
						</c:if>
						<c:if test="${question.questionType == '2'}">
							<c:forEach items="${question.splitOptions}" var="splitOption" varStatus="as">
								<label class="checkbox">
									<input type="checkbox" name="questionOption" value="${as.index+1}">
										${splitOption}
								</label>
							</c:forEach>
						</c:if>
						<c:if test="${question.questionType == '3'}">
							<textarea id="_answer"></textarea>
						</c:if>
                    </div>
	               <input type="text" id="questionId" name="questionId_${question.id}" value="${question.id}" style="display:none;" />
	               <input type="text"  id="answer" name="answer_${question.id}" style="display:none;"/>
                   </div>
                 </c:if>
			</c:forEach>
		</div>
      </form>
	<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
		<input id="submit_btn" style="height: 40px !important;width: 130px !important;" class="btn" type="button" value="提交" onclick="sumbitForm()"/>
	</div>
	</div>	
</body>
</html>