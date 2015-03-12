<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>调查问卷</title>
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
		<h1>调查问卷</h1>
		<div class=" onefield" style="height:40px !important; text-align: right !important;padding-right: 10px;padding-top: 7px;margin-left:20px;background-color: white;">
			<form style="padding-left:10px;">
				<span  style="float:left;">
					问卷状态：
					<input id="cc1" class="easyui-combotree" data-options="url:'${ctx}/category/api/getAll/paperStatus',method:'get',required:false" style="width:200px;" name="search_categoryId1" value="${param.search_categoryId}" />
					&nbsp;&nbsp;&nbsp;&nbsp;问卷类型：
					<input id="cc2" class="easyui-combotree" data-options="url:'${ctx}/category/api/getAll/getBusinessType',method:'get',required:false" style="width:200px;" name="search_categoryId2" value="${param.search_categoryId}"/>
					<mytag:PermssionTag functionId="F8-2"><button type="button" class="btn btn-success" onclick="location.href='${ctx}/paper/add/'" style="margin-left: 20px;"><i class="icon-plus" style="margin-right: 5px;"></i>新建问卷</button></mytag:PermssionTag>
					<!-- 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="${ctx}/paper/add/" style="padding: 5px; background-color: #DADADA;border-radius: 4px 4px 4px 4px;line-height: 30px; font-weight: bold;">
						<i class="icon-plus-sign"></i>&nbsp;新增问卷
					</a>
					 -->
				</span>
				<input type="text" name="search_keyword" value="${param.search_keyword}" style="width:150px;margin-bottom: 0px;margin-left:10px;" placeholder="输入关键字搜索">
				<button type="submit" class="btn" id="search_btn_test"><i class="icon-search"></i></button>
			</form>
		</div>
		<div  style="padding:20px;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>问卷名称</th>
					<th>问卷类型</th>
					<th>应用表单</th>
					<th>问卷状态</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${papers}" var="paper">
					<tr>
						<td>${paper.paperName}&nbsp;</td>
						<td>${paper.businessType.name}&nbsp;</td>
						<td>${paper.formType.name}&nbsp;</td>
						<td>${paper.status.name}&nbsp;</td>
						<td>
							<mytag:PermssionTag functionId="F8-6"><a href="${ctx}/paper/show/${paper.id}" id="showLink-${paper.id}"><i class="icon-folder-open"></i> 查看</a>&nbsp;&nbsp;</mytag:PermssionTag>
							<mytag:PermssionTag functionId="F8-3"><a href="${ctx}/paper/edit/${paper.id}" id="editLink-${paper.id}"><i class="icon-edit"></i> 修改</a>&nbsp;&nbsp;</mytag:PermssionTag>
							<c:if test="${paper.status.id!='1-0-1-2'}">	
							<mytag:PermssionTag functionId="F8-4"><a href="${ctx}/paper/delete/${paper.id}" id="deleteLink-${paper.id}"><i class="icon-remove"></i>废弃</a></mytag:PermssionTag>
							</c:if>
							<c:if test="${paper.status.id!='1-0-1-1'}">
							<!-- 		<mytag:PermssionTag functionId="F8-5"><button type="button" class="btn btn-danger" id="publishbutton-${paper.id}" onclick="location.href='${ctx}/paper/publish/${paper.id}'" style="padding: 0 12px !important; margin-left: 20px;"><i class="icon-share-alt" style="margin-right: 5px;"></i>发布问卷</button></mytag:PermssionTag> -->
								<mytag:PermssionTag functionId="F8-5"><a href="${ctx}/survey/createSurvey/${paper.id}" id="showLink-${paper.id}"><i class="icon-share-alt"></i> 创建调查</a></mytag:PermssionTag>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>		
			</table>
		</div>
	</div>
	<div class="form-actions" style="min-height: 23px;margin-top: 0 !important;">
	
	</div>
</body>
</html>