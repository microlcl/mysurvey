<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>编辑用户组</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		var message = "${errorMessage}";
		if(message != "") {
			alert(message);	
		}		
	})
	function addOption(){
		var optionDiv = '<span class="control-group" ><label for="question" class="control-label formlabel">联系人昵称:</label><input type="text" name="nickName">  &nbsp; &nbsp; id：<input type="text" placeholder="联系人id不能为空" name="userId">'
						+' <a href="javascript:void(0);" onclick="deleteOption(this)" title="删除"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a></div></div></span>';
		$("#options").append(optionDiv);
	}
	
	function deleteOption(obj){
		var _this = $(obj);
		$(_this).parent().remove();
	}
	
	function importCSV() {
		var fileName=document.getElementById("CSVfile").value;
		var type=fileName.substring(fileName.lastIndexOf(".")+1);
		if(type!="csv"){
			alert("文件格式不对，请重新选择CSV文件");
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
	<form  id="inputForm" onsubmit="return sub()" action="${ctx}/myGroup/updateGroup" method="post" class="form-horizontal" enctype="multipart/form-data">
	<div class="form">
	<h1>编辑用户组</h1>
	<table>
	 <tbody>
	  <tr valign="top">
	    <td>
	    <div id="warning-block" class="alert alert-error hide" style="width:300px;margin-left:130px"><strong>注意!</strong> 问题正在使用中，已有选项不可删除</div>
		<div class="control-group">
				<label for="question" class="control-label formlabel">群组名:</label>
				<div class="controls">
					<input type="hidden" name="id" value="${group.id}">
					<input type="text" id="groupName" name="groupName"  value="${group.groupName}" style="width:200px"  maxlength="32"/>
					<span id="groupName_error" class="error" style="display:none">请填写群组名!</span>
				</div>
		</div>
			<div class="control-group">
                    <label for="option" class="control-label formlabel">群组备注:</label>
                    <textarea name="comment" style="width:440px" maxlength="128">${group.comment }</textarea>
			</div>
<%-- 			<c:if test="${group.content != ''}"> --%>
			   <c:forEach items="${group.gitems}" var="member" varStatus="status">
				<span class="control-group" >
                       <label for="question" class="control-label formlabel">联系人昵称:</label><input type="text" value="${member[0]}" name="nickName"> &nbsp; &nbsp;  id：<input type="text" value="${member[1]}" name="userId">
						<a href="javascript:void(0);" onclick="deleteOption(this)" title="删除"><span style="margin:0px 0px -11px 5px" class="iconImg iconImg_delete"></span></a>
				</span>
			   </c:forEach>
<%-- 			</c:if>   --%>
			<div id="options"></div>
			
			<div class="control-group">
			     <label for="option" class="control-label formlabel">添加新联系人</label>  <a title="创建" onclick="addOption()" href="javascript:void(0);"><span class="iconImg iconImg_create" style="margin:0px 0px -11px" ></span></a>
			     <span id="groupContent_error" class="error" style="display:none">小组名单不能为空！</span>
			     <span id="groupId_error" class="error" style="display:none">请输入正确的联系人id！</span><br>
			</div>   
		    <input style="display:none;" name="content">
			<input type="file" id="CSVfile" name="CSVfile" onchange="importCSV()"style="padding-left:70px;width:60px" />
		<div id="option_error" style="padding-left:170px;display:none"></div>
		</td>
	  </tr>	
	  </tbody>
	</table>
		<div class="form-actions" style="padding-top:30px">
			<input id="submit_btn" class="btn btn-warning" type="submit" value="提交"/>&nbsp;	
			<input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/>
		</div>
	</div>
</form>
</body>
</html>