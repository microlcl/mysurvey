<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>用户组管理</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script>
		 function checkName(){
		   if($('#groupName').val()==""){
		      $('#groupName_error').show();
		      return false;
		   }else{
		      $('#groupName_error').hide();
		      return true;
		   }
		}

	</script>

</head>
<body>
<div class="form" >
	<h1>用户组管理</h1>

 	<div class=" onefield" style="height:40px !important; text-align: right !important;padding-top: 7px;margin-left:20px;background-color: white;">
		<form style="padding-left:10px;" action="${ctx}/myGroup/saveGroup" method="post" onsubmit="return checkName()">
				<span  style="float:left;">
				新建用户组：
				&nbsp; &nbsp;<input type="text" id="groupName" name="groupName" style="width:400px;margin-bottom: 0px;margin-left:10px;" placeholder="请输入新群组名称">
				<span id="groupName_error" class="error" style="display:none">请填写群组名!</span>
				<button type="submit" class="btn btn-success" style="margin-left: 20px;"><i class="icon-plus" style="margin-right: 5px;"></i>添加用户组</button>
				</span>
		</form>	
	</div>
	<div id="error-block"></div>
	<div style="padding:20px;">
	<div id="groups" class="accordion" >
		<c:forEach items="${groups}" var="group" varStatus="status">
			<div  class="accordion-group" >
                  <div class="accordion-heading" >
                     <a  href="#collapse_${status.index+1}"  data-toggle="collapse" class="accordion-toggle" style="display: inline-block; word-wrap: break-word; width: 800px;text-decoration: none;">
                  	    <span style="padding-left:8px">Group: 
                  	    <strong>
                  	    &nbsp ${group.groupName} <c:if test="${fn:length(group.groupMembers) == null }">(空用户组，请编辑用户组)</c:if>
                  	    </strong>
                  	     &nbsp&nbsp  ${group.comment} 
                  	    <br>
                  	             &nbsp&nbsp更新时间： <fmt:formatDate value="${group.editDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 
                  	    </span>
                     </a> 
                    <span style="float: right;padding: 5px;" >
                    	<button  onclick="location.href='${ctx}/myGroup/toUpdateGroup/${group.id}'"><i class="icon-edit"></i>修改群组</button>
                    	<button  onclick="groupDeletePopupWindow(${group.id})"><i class="icon-remove"></i>删除本组</button>
                    </span>
                  </div>
                  <div class="accordion-body collapse" id="collapse_${status.index+1}">
                    <c:forEach items="${group.groupMembers}" var="member" varStatus="item_status">
                       <div class="accordion-inner" style="padding-left:55px">
						 ${member.nickName}&nbsp&nbsp&nbsp ${member.userId}
                       </div>
                     </c:forEach>
                  </div>
            </div>
            
		</c:forEach>
	</div>
	</div>
</div>
<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">



<div id="groupDeleteModalWindow" class="modal hide fade">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4>确定删除该群组吗？</h4>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal" aria-hidden="true"">关闭</a> 
		<a id="deleteBtn" href="" class="btn btn-primary">确定</a>
	</div>
</div>
</div>
    <script type="text/javascript">
 	   $(document).ready(function() {
			$("#question-tab").addClass("active");
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
		
		function groupDeletePopupWindow(id) {
			var group_id = id;
			$('#groupDeleteModalWindow').modal();
			$('#deleteBtn').attr('href','${ctx}/myGroup/deleteGroup/group_'+group_id);
		}
	</script>
</body>
</html>