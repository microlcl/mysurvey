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
<title>创建问题</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#question-tab").addClass("active");
		$("input[name='questionType'][value=${question.questionType}]").prop("checked", true);
		
		if($('input[name="questionType"]:checked').val() == "3"){
			$("#options").hide();
		}
			
		$("input:radio[name='questionType']").click(
			function(){
				if($('input[name="questionType"]:checked').val() == "3"){
					$("#options").hide();
					$("#option_error").hide();
				}
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
		
		$("#inputForm").submit(function(){
			var result = true;
			if ($("input[name='question']").val() == ""){
				$("#question_error").show();
				result = false;
			}
			if($('input[name="questionType"]:checked').val() != "3"){
				if($("input[name='splitOptions']").length < 2){
					$("#option_error").html('<span class="error">至少填写两个选项!</span>');
					$("#option_error").show();
					result = false;
				}else{
					$("input[name='splitOptions']").each(function(){
						if($(this).val() == ""){
							$("#option_error").html('<span class="error">请填完所有选项!</span>');
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
		var optionDiv = '<div class="control-group"><label for="option" class="control-label formlabel" style="color:red">*</label><div class="controls"><input type="text" name="splitOptions" onblur="checkOptions()"  value="" style="width:400px" placeholder="至少填写两个选项"  maxlength="64"/>'
						+' <a href="javascript:void(0);" onclick="deleteOption(this)" title="删除"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a></div></div>';
		$("#options").append(optionDiv);
	}
	
	function deleteOption(obj){
		var _this = $(obj);
		$(_this).parent().parent().remove();
		checkOptions();
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
			$("#option_error").html('<span class="error">请填完所有选项!</span>');
			$("#option_error").show();
		}
	}
</script>

</head>
<body>
<form id="inputForm" action="${ctx}/question/saveQuestion" method="post" class="form-horizontal">
	<div class="form">
		<h1><spring:message code="addquestion.title"/></h1>
		<div class="control-group">
				<label for="questionType" class="control-label required formlabel"><spring:message code="addquestion.questiontype"/></label>
				<div class="controls">
					<label class="radio inline">
						<input type="radio" name="questionType" value="1" checked><spring:message code="addquestion.questiontype.radio"/>
					</label>
					<label class="radio inline">
						<input type="radio" name="questionType" value="2" ><spring:message code="addquestion.questiontype.multiselection"/>
					</label>
					<label class="radio inline">
						<input type="radio" name="questionType" value="3" ><spring:message code="addquestion.questiontype.openquestion"/>
					</label>
				</div>
		</div>	
		<div class="control-group">
				<label for="business_type" class="control-label formlabel"><spring:message code="addquestion.businesstype"/></label>
				<div class="controls">
					<input id="business_type" name="business_type" class="easyui-combotree" value="1-0-2" data-options="url:'${ctx}/category/api/getAll/getBusinessType',method:'get',required:false" style="width:200px;">
				</div>
		</div>
		<div class="control-group">
				<label for="question" class="control-label formlabel"><spring:message code="addquestion.questiontitle"/></label>
				<div class="controls">
					<input type="text" id="question" name="question" value="" style="width:600px"  maxlength="256"/>
					<span id="question_error" class="error" style="display:none"><spring:message code="addquestion.questiontitle.error"/></span>
				</div>
		</div>
		<div id="options">
			<div class="control-group">
				<label for="option" class="control-label formlabel"><spring:message code="addquestion.option"/></label>
				<div class="controls">
					<input type="button" onclick="clearOptions();" class="btn btn-info" value="<spring:message code="addquestion.option.clearoption"/>" style="margin-right: 50px;">
					<a title="<spring:message code="addquestion.option.addoption"/>" onclick="addOption()" href="javascript:void(0);"><span class="iconImg iconImg_create" style="margin:0px 0px -11px" ></span></a>
				</div>
			</div>
			<div class="control-group">
				<label for="option" class="control-label formlabel" style="color:red">*</label>
				<div class="controls">
					<input type="text" name="splitOptions" onblur="checkOptions()"  value="" style="width:400px" placeholder="<spring:message code="addquestion.splitoption"/>"  maxlength="64"/>
					<a href="javascript:void(0);" onclick="deleteOption(this)" title="<spring:message code="addquestion.delete"/>"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a>
				</div>
			</div>
			<div class="control-group">
				<label for="option" class="control-label formlabel" style="color:red">*</label>
				<div class="controls">
					<input type="text" name="splitOptions" onblur="checkOptions()"  value="" style="width:400px" placeholder="<spring:message code="addquestion.splitoption"/>"  maxlength="64"/>
					<a href="javascript:void(0);" onclick="deleteOption(this)" title="<spring:message code="addquestion.delete"/>"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a>
				</div>
			</div>
		</div>
		<div id="option_error" style="padding-left:170px;display:none"></div>
		<div class="form-actions" style="padding-top:30px">
			<input id="submit_btn" class="btn btn-warning" type="submit" value="<spring:message code="addquestion.submit"/>"/>&nbsp;	
			<input id="cancel_btn" class="btn" type="button" value="<spring:message code="addquestion.back"/>" onclick="history.back()"/>
		</div>	
	</div>
</form>
</body>
</html>