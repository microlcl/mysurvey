<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<!-- combotreee -->
<!-- link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css"-->
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/mystyle.css">
<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="${ctx}/static/nano/nano.js" type="text/javascript"></script>

<style>
</style>
<div id="questionModalWindow" class="modal hide fade">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4><spring:message code="questionpopupwindow.title"/></h4>
	</div>
	<div class="modal-body">
		<!-- 模态对话框begin -->
		<div class="search-panel">
			<form class="form-search form-inline" action="#">
					<label><spring:message code="questionpopupwindow.type"/></label> 
					<input id="categorySelector" name="search_categoryId" class="easyui-combotree" multiple data-options="url:'${ctx}/category/api/getAll/getBusinessType',method:'get',required:false" style="width:200px;">	
						
					<div class="input-append">
					    <input class="span2" id="searchKeyword" type="text">
					    <button class="btn" style="border-radius:0px 4px 4px 0" type="button" onclick="search()" id="search_btn">Go!</button>
				    </div>
			</form>
		</div>

		<div class="accordion" style="border-color: transparent" id="myaccordion"></div>

		<div id="loadMore" class="pagination pagination-centered">
			<button class="btn btn-link" type="button" onclick="loadMore()"><spring:message code="questionpopupwindow.loadmore"/></button>
		</div>
		<!-- 模态对话框end -->
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal" aria-hidden="true""><spring:message code="questionpopupwindow.close"/></a> 
		<a href="#" class="btn btn-primary"	data-dismiss="modal" aria-hidden="true" onclick="getSelectedValue()"><spring:message code="questionpopupwindow.ok"/></a>
	</div>
</div>

<!-- 生成选项的JS模板 -->
<div style="display:none" id="mytemplate">
<div class="accordion-group">
	<div class="accordion-heading">
	<ul class="inline">
			<li><input id="myq_{id}" value="{id}" type="checkbox" name="selectedQuestions"/> </li>
			<li><a class="accordion-toggle" data-toggle="collapse" data-parent="#myaccordion" href="#collapse_{id}">Q{id}: {question}</a></li>
</ul>
	</div>
	<div id="collapse_{id}" class="accordion-body collapse">
		<div class="accordion-inner"> <div style="padding:0px 0px 0px 34px">{options}</div></div>
	</div>
</div>
</div>


<script>
	var currentPage = 0;
	var synchronizeFlag = true;
	
	//调用者输入参数
	var parameters = {};

	function search() {
		currentPage = 0;
		$('#myaccordion').empty();
		loadMore();
		return false;
	}

	function questionPopupWindow(obj) {
		parameters = obj;
		$('#questionModalWindow').modal({
			backdrop : false,
		});
		loadMore();

	}

	function loadMore() {
		if(!synchronizeFlag){
			alert("当前问题未加载完毕，请稍后再试！");
			return;
		}
		synchronizeFlag = false;
		
		var nextPage = currentPage + 1;
		console.log("next pageNum:" + nextPage);
		$.ajax({
			url : '${ctx}/question/api/search',
			type : 'get',
			data : {
				page : nextPage,
				search_categoryId:$('#categorySelector').combotree('getValues'),
				search_keyword : $('#searchKeyword').val(),
				search_trashed : 'F',
				search_userId : "${user.id}"
			},

			success : function(resp) {
				currentPage++;
				if (resp.lastPage) {
					$('#loadMore').hide();
				} else {
					$('#loadMore').show();
				}
				$.each(resp.content, function(i, question) {
					var mytemp = $('#mytemplate').html();
					var options = buildOptions(question);
					question.options = options;
					var myvalue = nano(mytemp,question);

					$('#myaccordion').append(myvalue);
					$('#myq_' + question.id).data('question', question);
				});
			}
		});
		synchronizeFlag = true;

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
	
	function getSelectedValue() {
		var result = {};
		result.parameters = parameters;
		result.questions = [];
		var selectedQuestions = $('input:checkbox[name="selectedQuestions"]:checked');
		if(!selectedQuestions.size())
			return ;
		
		$.each(selectedQuestions, function(i, question) {
			var mydata = $('#' + question.id).data('question');
			result.questions.push(mydata);
		});
		parameters.callback(result);
			
	}
</script>
