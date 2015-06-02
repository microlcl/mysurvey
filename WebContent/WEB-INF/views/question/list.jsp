<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<!-- combotreee -->
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">

<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">

<title><spring:message code="question.title"/></title>
</head>
<body>
<div class="form" >
	<h1><spring:message code="question.title"/></h1>

 	<div class=" onefield" style="height:40px !important; text-align: right !important;padding-top: 7px;margin-left:20px;background-color: white;">
			<form style="padding-left:10px;">
				<span  style="float:left;">
				<spring:message code="question.type"/><input id="cc" name="search_categoryId" class="easyui-combotree" value="${param.search_categoryId}" multiple data-options="url:'${ctx}/category/api/getAll/getBusinessType',method:'get',required:false" style="width:200px;">	 
				&nbsp; &nbsp;<input type="text" name="search_keyword" value="${param.search_keyword}" style="width:400px;margin-bottom: 0px;margin-left:10px;" placeholder="<spring:message code="question.searchkeyword"/>">
				<button type="submit" class="btn" id="search_btn_test"><i class="icon-search"></i></button>
				<mytag:PermssionTag functionId="F7-5">
					<label class="checkbox inline" style="margin-left:20px">									
			   			<spring:message code="question.myquestion"/><input value="${user.id}" type="checkbox" <c:if test="${!empty param.search_userId}">checked</c:if> name="search_userId"/>
			   		</label>
		   		</mytag:PermssionTag>
		   		<mytag:PermssionTag noFunctionId="F7-5">
		   			<input type="hidden" name="search_userId" value="${user.id}" />
		   		</mytag:PermssionTag>
			    <mytag:PermssionTag functionId="F7-2"><button type="button" class="btn btn-success" onclick="location.href='${ctx}/question/addQuestion/'" style="margin-left: 20px;"><i class="icon-plus" style="margin-right: 5px;"></i><spring:message code="question.addquestion"/></button></mytag:PermssionTag>
				<tags:sort/>
				</span>
			</form>
	</div>
	<div id="error-block"></div>
	<div style="padding:20px;">
	<div id="questions" class="accordion">
		<c:forEach items="${questions.content}" var="question" varStatus="status">
			<div class="accordion-group">
                  <div class="accordion-heading">
                  	<span style="padding-left:8px">Q${status.index+1+(pageNumber-1)*5}：</span>
                    <a href="#collapse_${status.index+1+(pageNumber-1)*5}" data-parent="#questions" data-toggle="collapse" class="accordion-toggle" style="display: inline-block; word-wrap: break-word; width: 700px;text-decoration: none;">
                      	${question.question}<c:if test="${question.paperAnswered}"><span style="color:#FF0000"><spring:message code="question.isusing"/></span></c:if>
                    </a>
                    <span><a target="_blank" style="display: inline-block; word-wrap: break-word; width: 150px " href="${ctx}/account/show/userInfo/${question.creater.id}">${question.creater.name}</a></span>
                    <span style="float: right; padding: 8px 20px 8px 10px;">
                    	
                    	<mytag:PermssionTag functionId="F7-3"><a href="${ctx}/question/editQuestion/question_${question.id}"><i class="icon-edit"></i><spring:message code="question.edit"/></a></mytag:PermssionTag>
                    	<mytag:PermssionTag functionId="F7-4">
                    	<c:choose>
                    		<c:when test="${question.paperAnswered}">
                    			<a href="javascript:void(0);" onclick="errorAlert()"><i class="icon-remove-circle"></i><spring:message code="question.delete"/></a>
                    		</c:when>
                    		<c:otherwise>
                    			<a href="javascript:void(0);" onclick="questionDeletePopupWindow(${question.id})"><i class="icon-remove-circle"></i><spring:message code="question.delete"/></a>
                    		</c:otherwise>
                    	</c:choose>
                    	</mytag:PermssionTag>
                    </span>
                   </div>
                  <div class="accordion-body collapse" id="collapse_${status.index+1+(pageNumber-1)*5}">
                    <div class="accordion-inner" style="padding-left:55px">
						<c:if test="${question.questionType == '1'}">
							<c:forEach items="${question.splitOptions}" var="splitOption">
								<label class="radio">
									<input type="radio" name="questionOption" >
										${splitOption}
								</label>
							</c:forEach>
						</c:if>
						<c:if test="${question.questionType == '2'}">
							<c:forEach items="${question.splitOptions}" var="splitOption">
								<label class="checkbox">
									<input type="checkbox" name="questionOption" >
										${splitOption}
								</label>
							</c:forEach>
						</c:if>
						<c:if test="${question.questionType == '3'}">
							<textarea></textarea>
						</c:if>
                    </div>
                  </div>
            </div>
		</c:forEach>
	</div>
	<tags:pagination page="${questions}" paginationSize="4"/>
	</div>
</div>
<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
<div id="questionDeleteModalWindow" class="modal hide fade">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4><spring:message code="question.deletewarning"/></h4>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal" aria-hidden="true""><spring:message code="question.deletewarning.close"/></a> 
		<a id="deleteBtn" href="" class="btn btn-primary"><spring:message code="question.deletewarning.ok"/></a>
	</div>
</div>
</div>
    <script type="text/javascript">
 	   $(document).ready(function() {
			$("#myquestion-tab").addClass("active");
 	   });
    
		var categoryIds = [];
		<c:forEach items="${categories}" var="category">
			categoryIds.push('${category}');
		</c:forEach>
		$("#cc").combotree({ 
			onLoadSuccess:function(node){//数据加载成功触发 
				$("#cc").combotree('setValues', categoryIds);
			}
		});
		
		function errorAlert(){
			var errorDiv = '<div class="alert alert-error" style="width:250px;margin-bottom:-10px;margin-left:20px"><button type="button" class="close" data-dismiss="alert">×</button><strong><spring:message code="question.erroralert1"/></strong> <spring:message code="question.erroralert2"/></div>';
			$("#error-block").empty();
			$("#error-block").append(errorDiv);
		}
		
		function questionDeletePopupWindow(id) {
			var questionId = id;
			$('#questionDeleteModalWindow').modal();
			$('#deleteBtn').attr('href','${ctx}/question/deleteQuestion/question_' + questionId);
		}
	</script>
</body>
</html>
