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
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">

<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
<script src="${ctx}/static/nano/nano.js" type="text/javascript"></script>
<title><spring:message code="editquestion.title"/></title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#myquestion-tab").addClass("active");
		
		if($('input[name="questionType"]:checked').val() == "3"){
			$("#options").hide();
		}
			
		$("input:radio[name='questionType']").click(
			function(){
				if($('input[name="questionType"]:checked').val() == "3")
					$("#options").hide();
				else
					$("#options").show();
			}
		);
		
		$("input[name='question']").blur(
				function(){
					if ($(this).val() == ""){
						$("#question_error").show();
					}else
						$("#question_error").hide();
				}
		);
		
		$("#type"+"${question.questionType}").attr("checked",true);
		$("#inputForm").submit(function(){
			var result = true;
			if ($("input[name='question']").val() == ""){
				$("#question_error").show();
				result = false;
			}
			if($('input[name="questionType"]:checked').val() != "3"){
				if($("input[name='splitOptions']").length < 2){
					$("#option_error").html('<span class="error"><spring:message code="editquestion.option.error1"/></span>');
					$("#option_error").show();
					result = false;
				}else{
					$("input[name='splitOptions']").each(function(){
						if($(this).val() == ""){
							$("#option_error").html('<span class="error"><spring:message code="editquestion.option.error2"/></span>');
							$("#option_error").show();
							result = false;
						}
				    });
				}
			}

			return result;
		});
	});

	function addOption(){
		var optionDiv = '<div class="control-group"><label for="option" class="control-label formlabel" style="color:red">*</label><div class="controls"><input type="text" name="splitOptions" onblur="checkOptions()"  value="" style="width:400px" placeholder="<spring:message code="editquestion.splitoption"/>"  maxlength="64"/>'
						+' <a href="javascript:void(0);" onclick="deleteOption(this)" title="<spring:message code="editquestion.delete"/>"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a></div></div>';
		$("#options").append(optionDiv);
	}
	
	function deleteOption(obj){
		var _this = $(obj);
		$(_this).parent().parent().remove();
	}
	
	function clearOptions(){
		$('input[name="splitOptions"]').val("");
	}
	
	function checkOptions(){
		var allValue= true;
		$("input[name='splitOptions']").each(function(){
			if($(this).val() == ""){
				allValue = false;
			}
	    });
		
		if(allValue){
			$("#option_error").hide();
		}
		else{
			$("#option_error").html('<span class="error"><spring:message code="editquestion.option.error2"/></span>');
			$("#option_error").show();
		}
	}
</script>

</head>
<body>
<form id="inputForm" action="${ctx}/question/updateQuestion" method="post" class="form-horizontal">
	<div class="form">
	<h1><spring:message code="editquestion.title"/></h1>
	<table>
	 <tbody>
	  <tr valign="top">
	    <td>
	    <div id="warning-block" class="alert alert-error hide" style="width:300px;margin-left:130px"><strong><spring:message code="editquestion.warning1"/></strong> <spring:message code="editquestion.warning2"/></div>
		<div class="control-group">
				<label for="questionType" class="control-label required formlabel"><spring:message code="editquestion.type"/></label>
				<div class="controls">
					<label class="radio inline">
						<input id="type1" type="radio" name="questionType" value="1"><spring:message code="editquestion.type.radio"/>
					</label>
					<label class="radio inline">
						<input id="type2" type="radio" name="questionType" value="2" ><spring:message code="editquestion.type.multiselection"/>
					</label>
					<label class="radio inline">
						<input id="type3" type="radio" name="questionType" value="3" ><spring:message code="editquestion.type.openquestion"/>
					</label>
				</div>
		</div>	
		<div class="control-group">
				<label for="business_type" class="control-label formlabel"><spring:message code="editquestion.businesstype"/></label>
				<div class="controls">
					<input id="business_type" name="business_type" class="easyui-combotree" value="${question.business_type}" data-options="url:'${ctx}/category/api/getAll/getBusinessType',method:'get',required:false" style="width:200px;">
				</div>
		</div>
		<div class="control-group">
				<label for="question" class="control-label formlabel"><spring:message code="editquestion.questiontitle"/></label>
				<div class="controls">
					<input type="hidden" name="id" value="${question.id}">
					<input type="text" id="question" name="question"  value="${question.question}" style="width:440px"  maxlength="256"/>
					<span id="question_error" class="error" style="display:none"><spring:message code="editquestion.questiontitle.error"/></span>
				</div>
		</div>
		<div id="options">
			<div class="control-group">
				<label for="option" class="control-label formlabel"><spring:message code="editquestion.option"/></label>
				<div class="controls">
					<input type="button" onclick="clearOptions();" class="btn btn-info" value="<spring:message code="editquestion.option.clearoption"/>" style="margin-right: 50px;">
					<a title="<spring:message code="editquestion.option.addoption"/>" onclick="addOption()" href="javascript:void(0);"><span class="iconImg iconImg_create" style="margin:0px 0px -11px" ></span></a>
				</div>
			</div>
			<c:forEach items="${question.splitOptions}" var="questionOption" varStatus="status">
				<div class="control-group">
					<label for="option" class="control-label formlabel" style="color:red">*</label>
					<div class="controls">
						<input type="text" name="splitOptions" onblur="checkOptions()"  value="${questionOption}" style="width:400px" placeholder="<spring:message code="editquestion.splitoption"/>"  maxlength="64"/>
						<c:choose>
							<c:when test="${question.paperAnswered}">
								<script type="text/javascript">
									$("#warning-block").show();
								</script>
							</c:when>
							<c:otherwise>
						 		<a href="javascript:void(0);" onclick="deleteOption(this)" title="<spring:message code="editquestion.delete"/>"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
		</div>
		<div id="option_error" style="padding-left:170px;display:none"></div>
		</td>
		<td>
		 <c:choose>
		  <c:when test="${question.paperAnswered}"></c:when>
		  <c:when test="${question.paperUsed}">
			<div id="questionUsedAlert" class="alert" style="overflow: auto; margin-left: 100px; height: 250px; width: 300px;">
				<p><strong><spring:message code="editquestion.questionusedalert"/></strong></p>
				<ol id="papers" style="">
					<c:forEach items="${papers}" var="paper">
						<li><a href="${ctx}/paper/show/${paper.id}" id="showLink-${paper.id}" target="_blank">${paper.paperName}</a></li>
					</c:forEach>
				</ol>
			</div>
		  </c:when>
	     </c:choose>
		</td>
	  </tr>	
	  </tbody>
	</table>
		<div class="form-actions" style="padding-top:30px">
			<input id="submit_btn" class="btn btn-warning" type="submit" value="<spring:message code="editquestion.submit"/>"/>&nbsp;	
			<input id="cancel_btn" class="btn" type="button" value="<spring:message code="editquestion.back"/>" onclick="history.back()"/>
		</div>
	</div>
</form>
</body>
</html>