<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title><spring:message code="updategroup.title"/></title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#mygroup-tab").addClass("active");
		var message = "${errorMessage}";
		if(message != "") {
			alert(message);	
		}		
	})
	function addOption(){
		var optionDiv = '<div class="control-group" ><label for="question" class="control-label formlabel"><spring:message code="updategroup.nickname"/></label><div class="controls"><input type="text" name="nickName"> &nbsp; <spring:message code="updategroup.id"/> &nbsp; <input type="text" placeholder="<spring:message code="updategroup.id.error"/>" name="userId">'
						+' <a href="javascript:void(0);" onclick="deleteOption(this)" title="<spring:message code="updategroup.deleteoption"/>"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a></div></div>';
		$("#options").append(optionDiv);
	}
	
	function deleteOption(obj){
		var _this = $(obj);
		$(_this).parent().parent().remove();
	}
	
	function importCSV() {
		var fileName=document.getElementById("CSVfile").value;
		var type=fileName.substring(fileName.lastIndexOf(".")+1);
		if(type!="csv"){
			alert("<spring:message code="updategroup.importcsv.error1"/>");
		}else{
			var _content="";
			var i=0;
			var form = document.forms['inputForm'];
			form.action = '${ctx}/myGroup/importGroup';
			$("input[name='userId']").each(function(){
				_content+=$("input[name='nickName']").get(i).value+"^"+$(this).val()+"|";
				i++;
			});
			if(!_content=="") {
				$("input[name='content']").val(_content);
			}
			form.submit();
		}		
	}
	
	
      function sub(){
	   var i=0;
	   var _content="";
	   $("input[name='userId']").each(function(){
	   if($(this).val().match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)){
                _content+=$("input[name='nickName']").get(i).value+"^"+$(this).val()+"|";
	             $("#groupId_error").hide();
	            i++;
	   }else{
	      _content="idError";
	      $("#groupId_error").show();
	      return false;
	   }
	   });
	   
	   
	   if(_content==""){
	       $("#groupContent_error").show();
	       return false;
	   }else if(_content=="idError"){
	       return false;
	   }else{
	       $("input[name='content']").val(_content);
	       $("#groupContent_error").hide();
	   }

	   if ($("input[name='groupName']").val() == "") {
				$("#groupName_error").show();
				return false;
			} else{
			    $("#groupName_error").hide();
			}
				
		return true;
	};
	
	
	
	</script>
</head>
<body>
<c:choose>


<c:when test="${group.trashed =='F' }">
	<form  id="inputForm" onsubmit="return sub()" action="${ctx}/myGroup/updateGroup" method="post" class="form-horizontal" enctype="multipart/form-data"  >
	<div class="form" >
	<h1><spring:message code="updategroup.title"/></h1>
	<table>
	
	 <tbody>
	  <tr valign="top">
	    <td>
	   
	    <div id="warning-block" class="alert alert-error hide" style="width:300px;margin-left:130px"><strong><spring:message code="updategroup.warning1"/></strong> <spring:message code="updategroup.warning2"/></div>
		<div class="control-group">
				<label for="question" class="control-label formlabel"><spring:message code="updategroup.groupname"/></label>
				<div class="controls">
					<input type="hidden" name="id" value="${group.id}">
					<input type="text" id="groupName" name="groupName"  value="${group.groupName}" style="width:200px"  maxlength="32"/>
					<span id="groupName_error" class="error" style="display:none"><spring:message code="updategroup.groupname.error"/></span>
				</div>
		</div>
			<div class="control-group">
                    <label for="option" class="control-label formlabel"><spring:message code="updategroup.comment"/></label>
                    <div class="controls">
                    <textarea name="comment" style="width:440px" maxlength="128">${group.comment }</textarea>
					</div>
			</div>
<%-- 			<c:if test="${group.content != ''}"> --%>
			   <c:forEach items="${group.gitems}" var="member" varStatus="status">
				<div class="control-group" >
                       <label for="question" class="control-label formlabel"><spring:message code="updategroup.nickname"/></label>
  						<div class="controls">
						<input type="text" value="${member[0]}" name="nickName"> &nbsp;
						<spring:message code="updategroup.id"/> &nbsp; <input type="text" value="${member[1]}" name="userId">
						<a href="javascript:void(0);" onclick="deleteOption(this)" title="<spring:message code="updategroup.deleteoption"/>"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a>
						</div>
				</div>
			   </c:forEach>
<%-- 			</c:if>   --%>
			<div id="options"></div>
			
			<div class="control-group">
			     <label for="option" class="control-label formlabel"><spring:message code="updategroup.addoption"/></label>  <a title="<spring:message code="updategroup.add"/>" onclick="addOption()" href="javascript:void(0);"><span class="iconImg iconImg_create" style="margin:0px 0px -11px" ></span></a>
			     <span id="groupContent_error" class="error" style="display:none"><spring:message code="updategroup.groupcontent.error"/></span>
			     <span id="groupId_error" class="error" style="display:none"><spring:message code="updategroup.groupid.error"/></span><br>
			</div>   
		    <input style="display:none;" name="content">
		    <input title="<spring:message code="updategroup.importnotes"/>" type="button" value="<spring:message code="updategroup.import"/>" style="margin-left:70px;width:60px;" onclick="CSVfile.click()"/>
			<input type="file" id="CSVfile" name="CSVfile" onchange="importCSV()"style="width:0px;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;" size="0"  />
		<div id="option_error" style="padding-left:170px;display:none"></div>
		</td>
	  </tr>	
	  </tbody>
	</table>
		<div class="form-actions" style="padding-top:30px">
			<input id="submit_btn" class="btn btn-warning" type="submit" value="<spring:message code="updategroup.submit"/>"/>&nbsp;	
			<input id="cancel_btn" class="btn" type="button" value="<spring:message code="updategroup.cancel"/>" onclick="history.back()"/>
		</div>
	</div>
</form>
</c:when>
<c:otherwise>
<h2><spring:message code="group.trashed"/></h2>
<p><a href="javascript:window.history.back();"><spring:message code="error.back"/></a></p>
</c:otherwise>
</c:choose>
</body>
</html>