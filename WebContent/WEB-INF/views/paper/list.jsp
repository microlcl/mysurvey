<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title><spring:message code="paper.title"/></title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			$("#paper-tab").addClass("active");
			
			$("a[id^='deleteLink']").click(function(){
				
			//	if(confirm("你确定要废弃此问卷吗？"))
			//	{
			//		console.log("确定废弃此问卷");
			//	}
			//	else
			//	{
			//		return false;
			//	}
			}) ;
			

			
			var statusId = [];
			<c:forEach items="${status}" var="category">
				statusId.push('${category}');
			</c:forEach>
			$("#cc1").combotree({ 
				onLoadSuccess:function(node){//数据加载成功触发 
					$("#cc1").combotree('setValues', statusId);
				},
				onBeforeSelect:function(node){ 
					var tree = $(this).tree;
					var isLeaf = tree('isLeaf', node.target);
					console.log("isLeaf=" + isLeaf);
					return isLeaf;
				}
			});
			
			var businessTypeId = [];
			<c:forEach items="${businessType}" var="category">
				businessTypeId.push('${category}');
			</c:forEach>
			$("#cc2").combotree({ 
				onLoadSuccess:function(node){//数据加载成功触发 
					$("#cc2").combotree('setValues', businessTypeId);
				},
				onBeforeSelect:function(node){ 
					var tree = $(this).tree;
					var isLeaf = tree('isLeaf', node.target);
					console.log("isLeaf=" + isLeaf);
					return isLeaf;
				}
			});

		});

	</script>

</head>
<body>
	<div class="form">
		<h1><spring:message code="paper.title"/></h1>
		<div class=" onefield" style="height:40px !important; text-align: right !important;padding-right: 10px;padding-top: 7px;margin-left:20px;background-color: white;">
			<form style="padding-left:10px;">
				<span  style="float:left;">
					<spring:message code="paper.status"/>
					<input id="cc1" class="easyui-combotree" data-options="url:'${ctx}/category/api/getAll/paperStatus',method:'get',required:false" style="width:200px;" name="search_categoryId1" value="${param.search_categoryId}" />
					&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="paper.type"/>
					<input id="cc2" class="easyui-combotree" data-options="url:'${ctx}/category/api/getAll/getBusinessType',method:'get',required:false" style="width:200px;" name="search_categoryId2" value="${param.search_categoryId}"/>
					<mytag:PermssionTag functionId="F8-7">
						<label class="checkbox inline" style="margin-left:20px">									
			   			<spring:message code="paper.mypaper"/><input value="${user.id}"  type="checkbox" <c:if test="${!empty param.search_userId}">checked</c:if> name="search_userId"/>
			   			</label>
		   			</mytag:PermssionTag>
		   			<mytag:PermssionTag noFunctionId="F8-7">
		   				<input type="hidden" name="search_userId" value="${user.id}" />
		   			</mytag:PermssionTag>
					<mytag:PermssionTag functionId="F8-2"><button type="button" class="btn btn-success" onclick="location.href='${ctx}/paper/add/'" style="margin-left: 20px;"><i class="icon-plus" style="margin-right: 5px;"></i><spring:message code="paper.create"/></button></mytag:PermssionTag>
					<!-- 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="${ctx}/paper/add/" style="padding: 5px; background-color: #DADADA;border-radius: 4px 4px 4px 4px;line-height: 30px; font-weight: bold;">
						<i class="icon-plus-sign"></i>&nbsp;新增问卷
					</a>
					 -->
				</span>
				<input type="text" name="search_keyword" value="${param.search_keyword}" style="width:150px;margin-bottom: 0px;margin-left:10px;" placeholder="<spring:message code="paper.search.keyword"/>">
				<button type="submit" class="btn" id="search_btn_test"><i class="icon-search"></i></button>
			</form>
		</div>
		<c:if test="${not empty message}">
		   <div id="message" style="margin-left:20px;margin-top:20px;" class="alert alert-error input-medium controls"><button data-dismiss="alert" class="close">×</button>${message}</div>
		</c:if>
		<div  style="padding:20px;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th><spring:message code="paper.papername"/></th>
					<th><spring:message code="paper.papertype"/></th>
					<th><spring:message code="paper.paperstatus"/></th>
					<th><spring:message code="paper.operation"/></th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${papers.content}" var="paper">
					<tr>
						<td>${paper.paperName}&nbsp;</td>
						<td>${paper.businessType.name}&nbsp;</td>						
						<td>${paper.status.name}&nbsp;</td>
						<td>
							<mytag:PermssionTag functionId="F8-6"><a href="${ctx}/paper/show/${paper.id}" id="showLink-${paper.id}"><i class="icon-folder-open"></i> <spring:message code="paper.show"/></a>&nbsp;&nbsp;</mytag:PermssionTag>
							<mytag:PermssionTag functionId="F8-3"><a href="${ctx}/paper/edit/${paper.id}" id="editLink-${paper.id}"><i class="icon-edit"></i> <spring:message code="paper.edit"/></a>&nbsp;&nbsp;</mytag:PermssionTag>
							<c:if test="${paper.status.id!='1-0-1-2'}">	
							<mytag:PermssionTag functionId="F8-4"><a href="${ctx}/paper/delete/${paper.id}" id="deleteLink-${paper.id}"><i class="icon-remove"></i><spring:message code="paper.delete"/></a></mytag:PermssionTag>
							</c:if>
							<c:if test="${paper.status.id!='1-0-1-1'}">
							<!-- 		<mytag:PermssionTag functionId="F8-5"><button type="button" class="btn btn-danger" id="publishbutton-${paper.id}" onclick="location.href='${ctx}/paper/publish/${paper.id}'" style="padding: 0 12px !important; margin-left: 20px;"><i class="icon-share-alt" style="margin-right: 5px;"></i>发布问卷</button></mytag:PermssionTag> -->
								<mytag:PermssionTag functionId="F8-5"><a href="${ctx}/survey/createSurvey/${paper.id}" id="showLink-${paper.id}"><i class="icon-share-alt"></i> <spring:message code="paper.createsurvey"/></a></mytag:PermssionTag>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>		
			</table>
			<tags:pagination page="${papers}" paginationSize="4"/>
		</div>
	</div>
	<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
	
	</div>
</body>
</html>
