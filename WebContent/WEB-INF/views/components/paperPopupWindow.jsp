<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<style type="text/css">
	.tdSpace {
		padding-left:100px;
	}
</style>
<div id="paperModalWindow" class="modal hide fade">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4>调查问卷选择</h4>
	</div>
	<div class="modal-body">
		<!-- 模态对话框begin -->
		<div class="search-panel">
			<form class="form-search form-inline" action="#">
				<label>类别：</label> 
		
				<input id="paperPupup_businessType"
				class="span1 easyui-combobox"
				data-options="url:'${ctx}/category/api/getChildren/getBusinessType',method:'get',valueField:'id',textField:'text'" value="${businessTypeId}" <c:if test="${not empty businessTypeId}">readonly</c:if>>
	
				<label>表单：</label> 
		
				<input id="paperPupup_formType"
				class="span1 easyui-combobox"
				data-options="url:'${ctx}/category/api/getChildren/getFormType',method:'get',valueField:'id',textField:'text'" value="${formType}" <c:if test="${not empty formType}">readonly</c:if>>
	
				
				<div class="input-append">
				    <input class="span2" id="searchKeyword" type="text" placeholder="问卷名称/描述">
				    <button class="btn" style="border-radius:0px 4px 4px 0" type="button" onclick="search()" id="search_btn">Go!</button>
				</div>
			</form>
		</div>

		<div class="accordion" style="border-color: transparent" id="myaccordion"></div>

		<div id="loadMore" class="pagination pagination-centered">
			<button class="btn btn-link" type="button" onclick="loadMore()">加载更多...</button>
		</div>
		<!-- 模态对话框end -->
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal" aria-hidden="true"">关闭</a> 
		<a href="#" class="btn btn-primary"	data-dismiss="modal" aria-hidden="true" onclick="getSelectedValue()">确定</a>
	</div>
</div>

<!-- 生成选项的JS模板 -->
<div style="display:none" id="mytemplate">
<div class="accordion-group">
	<div class="accordion-heading" onclick="test({id})">
		<ul class="inline" style="margin-bottom:0px">
			<li><input id="paper_{id}" value="{id}" type="radio" name="selectedPaper"/> </li>
			<li><a class="accordion-toggle" data-toggle="collapse" data-parent="#myaccordion" href="#collapse_{id}">{id}: {paperName}</a></li>
	</div>
	<div id="collapse_{id}" class="accordion-body collapse">
	  <div class="accordion-inner" style="padding-left:55px">
			<div  style="padding:20px;" id="questions_{id}">
			</div>
	  </div>
	</div>
</div>
</div>
<script>
	var currentPage = 0;

	//调用者输入参数
	var parameters = {};
	function search() {
		currentPage = 0;
		$('#myaccordion').empty();
		loadMore();
		return false;
	}

	function paperPopupWindow(obj) {
		$('#myaccordion').empty();
		parameters = obj;
		$('#paperModalWindow').modal({
			backdrop : false,
		});
		loadMore();

	}

	var paperList = [];
	function loadMore() {
		var nextPage = currentPage + 1;
		console.log("next pageNum:" + nextPage);
		$.ajax({
			url : '${ctx}/paper/api/searchAll',
			type : 'get',
			data : {
				page : nextPage,
				search_keyword : $('#searchKeyword').val(),
				search_businessType : $('#paperPupup_businessType').combobox('getValue'),
				search_formType : $('#paperPupup_formType').combobox('getValue')
			},

			success : function(resp) {
				currentPage++;
				if (resp.lastPage) {
					$('#loadMore').hide();
				} else {
					$('#loadMore').show();
				}
				$.each(resp.content, function(i, paper) {
					var mytemp = $('#mytemplate').html();
					var myvalue = nano(mytemp,paper);

					$('#myaccordion').append(myvalue);
					$('#paper_' + paper.id).data('paper', paper);
					//loadPaper(paper.id, "questions_"+paper.id);
				});
			}
		});

	}

	
	function getSelectedValue() {
		var result = {};
		result.parameters = parameters;
		result.paper = [];
		var selectedPaper = $('input:radio[name="selectedPaper"]:checked').val();		
		var mydata = $('#paper_' + selectedPaper).data('paper');
		result.paper.push(mydata);
		parameters.callback(result);
			
	}
	
	function test(paperId) {
		console.log("paper Id: " + paperId);
		loadPaper(paperId, "questions_" + paperId);
	}
</script>
