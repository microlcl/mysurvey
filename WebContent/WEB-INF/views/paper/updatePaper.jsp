<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>修改问卷</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/nano/nano.js" type="text/javascript"></script>
	<script>
		var position_question = 100;  //新增问题的起始position
		$(document).ready(function() {
			$("#paper-tab").addClass("active");
			
			var businessTypeId = ['${selectpaper.businessType.id}'];

			$("#questionsForm").validate({
				rules: {
					paperTitle: {
						rangelength: [1,64]
					}
				},
				
				messages: {
					paperTitle: {
						required: "请填写问卷名称"
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
				question.positionTest = position_question;
				console.log("你选择的问题的index是："+question_number);
				question.index = question_number;
				console.log("新增加的问题的position是" + question.position);
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
				position_question = position_question + 10;
				question_number ++;
			} );
			//$("input[name='selectedQuestionsOnPage']").attr('checked',true);
			$('#selected_questions').show();
			$('#delete_questions_button').show();
			$('#submit_btn').show();
			$('#cancel_btn').show();
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
			if(confirm('确定删除所有问题吗？')){
				console.log("删除所有问题！");
				$('#myaccordion1').empty();
				$('#selected_questions').hide();
				$('#submit_btn').hide();
				$('#cancel_btn').hide();
				$('#delete_questions_button').hide();
			}else{
				console.log("取消删除所有问题！");
			}
			
		}
	</script>

</head>
<body>
	<!-- resource 选择模态对话框 -->
	<%@ include file="../components/questionPopupWindow.jsp"%>
	<!-- 生成选项的JS模板 -->
	<div style="display:none" id="mytemplate1">
		<div class="accordion-group">
			<div class="accordion-heading">
				<ul class="inline">
						<li><input id="myq1_{id}" value="{id}" type="hidden" name="questions[{index}].id"/> </li>
						<li style="width: 680px;"><a class="accordion-toggle" data-toggle="collapse" data-parent="#myaccordion1" href="#collapse_{id}">Q{id}: {question}</a></li>
						<li>问题坐标：<input type="text" name="questions[{index}].position"  maxlength="64" class="required" placeholder="数字" style="width: 25px !important; margin-top: 10px;" value="{positionTest}"/></li>
						<li><a href="javascript:void(0);" onclick="deleteQuestion(this)" title="删除" style=""><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a></li>
				</ul>
			</div>
			<div id="collapse_{id}" class="accordion-body collapse">
				<div class="accordion-inner"> <div style="padding:0px 0px 0px 34px">{options}</div></div>
			</div>
		</div>
	</div>

	<div class="form">
		<h1><spring:message code="updatepaper.title"/></h1>
		<div style="padding:20px;">
			<form id="questionsForm" action="${ctx}/paper/update"  method="post" class="form-horizontal">
				<input id="paper_id" value="${selectpaper.id}" type="hidden" name="id"/>
				<div class="control-group">
					<label for="paperName" class="control-label"><spring:message code="updatepaper.papername"/></label>
					<div class="controls">						
						<input type="text" id="paperName" name="paperName"  maxlength="64" class="input-large required" placeholder="<spring:message code="updatepaper.papername.placeholder"/>" value="${selectpaper.paperName}"/>
					</div>
				</div>
				<div class="control-group">
					<label for="cc2" class="control-label"><spring:message code="updatepaper.papertype"/></label>					
					<div class="controls">	
						<input id="cc2" class="easyui-combobox" name="businessType.id" data-options="url:'${ctx}/category/api/getChildren/getBusinessType',method:'get',valueField:'id',textField:'text'" value="${selectpaper.businessType.id}"/>
					</div>
				</div>				
	
				<div class="control-group">
				<div class="controls">
				<button id="select_questions_button"  type="button" class="btn btn-warning" onclick="questionPopupWindow({callback:addQuestions})"><spring:message code="updatepaper.selectquestion"/></button>
				<button id="delete_questions_button"  type="button" class="btn btn-danger" onclick="removeAllQuestions();"><spring:message code="updatepaper.deleteallquestion"/></button>
				</div>
				</div>
				<div id="selected_questions" >
					
					<div class="accordion" style="border-color: transparent;  width: 80%; margin-left: 100px;"  id="myaccordion1">
						<c:forEach items="${selectpaper.questions}" var="question" varStatus="status">
							<c:if test="${question.trashed == 'F'}">
								<div class="accordion-group">
				                  	<div class="accordion-heading">
				                  		<ul class="inline">
											<li><input id="myq1_${question.id}" value="${question.id}" type="hidden" name="questions[${status.index}].id"/> </li>
											<li style="width: 680px;"><a class="accordion-toggle" data-toggle="collapse" data-parent="#myaccordion1" href="#collapse_${question.id}">Q${question.id}: ${question.question}</a></li>
											<li><spring:message code="updatepaper.questionposition"/><input type="text" name="questions[${status.index}].position"  maxlength="64" class="required" placeholder="<spring:message code="updatepaper.questionposition.placeholder"/>" style="width: 25px !important; margin-top: 10px;" value="${question.position}"/></li>
				                      		<li><a href="javascript:void(0);" onclick="deleteQuestion(this)" title="<spring:message code="updatepaper.deletequestion"/>" style=""><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a></li>
				                      	</ul>
				                   	</div>
								</div>
								<div id="collapse_${question.id}" class="accordion-body collapse">
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
							</c:if>
						</c:forEach>
					</div>
				</div>
			</form>
		</div>
		<div class="form-actions">
			<input id="submit_btn" class="btn btn-warning" type="submit" value="<spring:message code="updatepaper.submit"/>" onclick="$('#questionsForm').submit();" />&nbsp;	
			<input id="cancel_btn" class="btn" type="button" value="<spring:message code="updatepaper.back"/>" onclick="history.back()"/>
		</div>
	</div>

</body>
</html>