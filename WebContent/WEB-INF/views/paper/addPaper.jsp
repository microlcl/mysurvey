<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>调查问卷</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/nano/nano.js" type="text/javascript"></script>
	<script>
		var position = 10;  //新增问题的起始position
		$(document).ready(function() {
			$("#paper-tab").addClass("active");
			$("#questionsForm").validate({
				rules: {
					paperName: {
						rangelength: [1,64]
					},
					"businessType.id" : {
						required: true,
					}
				},
				
				messages: {
					paperName: {
						required: "<spring:message code="addpaper.papername.message"/>"
					},
					"businessType.id": {
						required: "<spring:message code="addpaper.businesstype.message"/>"
					}
				}
			});
			
		
		});
		
		var question_number = ($("input[name^='questions']").length/2) + 10;
		function addQuestions(result) {

			question_number = question_number + 5;
			console.log("in callback function");
			console.log(result);
			console.log("你选择的问题的数目是：" + result.questions.length);
			$.each(result.questions, function(i,question){
				question.position = position;
				question.index = question_number;
				console.log("你选择的问题的index是："+question_number);
				if($('#myq1_'+question.id).length > 0) {
					return true;
				}
				console.log("你选择的问题"+i+"是：" + question.question);
				var mytemp = $('#mytemplate1').html();
				var options = buildOptions(question);
				question.options = options;
				var myvalue = nano(mytemp,question);

				$('#myaccordion1').append(myvalue);
				$('#myq1_' + question.id).data('question', question);
				position = position + 10;
				question_number ++;
			} );
			//$("input[name='selectedQuestionsOnPage']").attr('checked',true);
			$('#selected_questions').show();
			$('#submit_btn').show();
			$('#cancel_btn').show();
			$('#delete_questions_button').show();
		}
		function buildOptions(question) {
			var result = '';
			var questionType = question.questionType;
			var radioBoxTemp = '<label class="radio"><input type="radio" name="questionOption" >{option}</label>';
			var checkBoxTemp = '<label class="checkbox"><input type="checkbox" name="questionOption" >{option}</label>';

			$.each(question.splitOptions, function(i,option){
				var data = {};
				data.option = option;
				if (questionType == 1) {
					result = result + nano(radioBoxTemp, data);
				}
				else if (questionType == 2) {
					result = result + nano(checkBoxTemp, data);
				} else {};
			});
			
			return result;

		}
		function deleteQuestion(obj){
			var question = $(obj);
			$(question).parent().parent().parent().parent().remove();
			if(($("input[name^='questions']").length/2) < 2) {
				$('#selected_questions').hide();
				$('#submit_btn').hide();
				$('#cancel_btn').hide();
				$('#delete_questions_button').hide();
			}
		}
		function removeAllQuestions(){
			$('#myaccordion1').empty();
			$('#selected_questions').hide();
			$('#submit_btn').hide();
			$('#cancel_btn').hide();
			$('#delete_questions_button').hide();
			
		}
		
		function submitForm(){
			if ($('#businessType').combobox('getValue')) {
				$("#warning-block").hide();
				$('#questionsForm').submit();
			}else {
				$("#warning-block").show();

			}
		}
	</script>

</head>
<body>
	<div class="form">
		<h1><spring:message code="addpaper.title"/></h1>
		<div class="alert hide" id="warning-block">
	  	   <strong><spring:message code="addpaper.warning1"/> </strong><spring:message code="addpaper.warning2"/>
		</div>
		<div style="padding:20px;">
			<form id="questionsForm" action="${ctx}/paper/save" method="post" class="form-horizontal">
				<div class="control-group">
					<label for="paperName" class="control-label"><spring:message code="addpaper.papername"/></label>
					<div class="controls">						
						<input type="text" id="paperName" name="paperName"  maxlength="64" class="input-large required" placeholder="<spring:message code="addpaper.papername.placeholder"/>" value="${selectpaper.paperName}"/>
					</div>
				</div>
				<div class="control-group">
					<label for="businessType" class="control-label"><spring:message code="addpaper.businesstype"/></label>					
					<div class="controls">	
						<input id="businessType" class="easyui-combobox" name="businessType.id" data-options="url:'${ctx}/category/api/getChildren/getBusinessType',method:'get',valueField:'id',textField:'text'" value="${selectpaper.businessType.id}"/>
					</div>
				</div>				

				<button id="select_questions_button" style="height: 40px !important;width: 180px !important; margin-top: 10px;" type="button" class="btn btn-warning" id="search_btn" onclick="questionPopupWindow({callback:addQuestions})"><spring:message code="addpaper.selectquestion"/></button>
				<button id="delete_questions_button" style="height: 40px !important;width: 180px !important; margin-top: 10px; margin-left:40px; display:none;" type="button" class="btn btn-danger" id="delete_btn" onclick="removeAllQuestions();"><spring:message code="addpaper.deletequestion"/></button>
				<div id="selected_questions" style="display: none;">
					<label style="width: 100%;font-weight: bold;line-height: 30px;text-align: left; padding-left: 20px;"><spring:message code="addpaper.showselectedquestions"/></label>
					<div class="accordion" style="border-color: transparent;  width: 80%; margin-left: 100px;"  id="myaccordion1">
					</div>
				</div>
			</form>
		</div>
		<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
			<input id="submit_btn" class="btn btn-warning" style="display: none;" type="button" value="<spring:message code="addpaper.submit"/>" onclick="submitForm();" />&nbsp;	
			<input id="cancel_btn" class="btn"  style="display: none;" type="button" value="<spring:message code="addpaper.back"/>" onclick="history.back()"/>
		</div>
	</div>
	<!-- resource 选择模态对话框 -->
	<%@ include file="../components/questionPopupWindow.jsp"%>
	<!-- 生成选项的JS模板 -->
	<div style="display:none" id="mytemplate1">
		<div class="accordion-group">
			<div class="accordion-heading">
				<ul class="inline">
						<li><input id="myq1_{id}" value="{id}" type="hidden" name="questions[{index}].id"/> </li>
						<li style="width: 680px;"><a class="accordion-toggle" data-toggle="collapse" data-parent="#myaccordion1" href="#collapse_{id}">Q{id}: {question}</a></li>
						<li><spring:message code="addpaper.questionposition"/><input type="text" name="questions[{index}].position"  maxlength="64" class="required" placeholder="<spring:message code="addpaper.questionposition.placeholder"/>" style="width: 25px !important; margin-top: 10px;" value="{position}"/></li>
						<li><a href="javascript:void(0);" onclick="deleteQuestion(this)" title="<spring:message code="addpaper.delete"/>" style=""><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a></li>
				</ul>
			</div>
			
			<div id="collapse_{id}" class="accordion-body collapse">
				<div class="accordion-inner"> <div style="padding:0px 0px 0px 34px">{options}</div></div>
			</div>
		</div>
	</div>
</body>
</html>