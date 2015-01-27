<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
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
		    if(check.checked){
		      $('#isAnonymous').val('T');
		    }else{
		      $('#isAnonymous').val('F');
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
		    $("#surveyForm").submit();
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
			<form id="surveyForm" action="${ctx}/survey/publishAndSaveSurvey/${paper.id}" method="post" class="form-horizontal">
				<div class="control-group">
					<label for="question" class="control-label formlabel">问卷主题:</label>
					<div class="controls">						
						<input type="text" id="surveySubject" name="subject"  maxlength="128" class="input-large required" placeholder="0~128个字符" />
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel">是否匿名调查:</label>
					<div class="controls">
					   <input type="checkbox" id="isAnonymousCheck" onclick="checkAnonymous()" >
					   <input type="text" id="isAnonymous" value="F" name="isAnonymous" style="display:none;">
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel">调查截止日期:</label>
					<div class="controls">
					   <input type="text" id="datetimepicker7" name="deadlineTiemstamp" readonly="true" placeholder="双击选择时间与日期" onclick="getDeadline()"  />
					</div>
				</div>
				<div class="control-group">
					<label for="question" class="control-label formlabel">调查描述:</label>					
					<div class="controls">
					    <textarea name="description" style="width:440px" maxlength="128"></textarea>
					</div>
				</div>	
				<div class="control-group">
				<label for="question" class="control-label formlabel">请选择调查的群组:</label>		
				 <div class="controls" style="width:550px">
				  <c:forEach items="${groups}"  var="group" varStatus="status">
				    <div class="btn" onclick="markGroup(this)" >${group.groupName}<i class="icon-ok" style="width:20px;display :none;"></i><input type="text" value="${group.id }" id="groupid" name="groupid" style="display:none;"></div>
				  </c:forEach>
				 </div>
				</div>
				<input type="text" name="surveyGroup" id="surveyGroup" style="display:none;">
			</form>
		</div>
		<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
			<input id="submit_btn" class="btn btn-warning"  type="button" value="提交" onclick="formatAndCheck();" />&nbsp;	
			<input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/>
		</div>
	</div>

</body>
</html>