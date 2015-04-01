<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:if test="${not empty user.id}">

	<div id="leftbar" class="span2">
		<h1>菜单</h1>
		<div class="submenu">
			<p class="flip">
				<mytag:PermssionTag functionId="">
					<a id="">我的调查</a>
				</mytag:PermssionTag>
			</p>
			<div class="panel" style="display: none;">
					<a  href="${ctx}/myGroup/list">我的用户组</a>
			</div>
			
			<div class="panel" style="display: none;">
					<a href="${ctx}/survey/myLaunch">我发起的调查</a>
			</div>

			<div class="panel" style="display: none;">
					<a href="${ctx}/survey/myParticipation">我参与的调查</a>
			</div>
			
			<div class="panel" style="display: none;">
					<a href="${ctx}/paper/list?search_userId=${user.id}&sortType=creat_timestamp DESC">我的问卷</a>
			</div>
			<div class="panel" style="display: none;">
					<a href="${ctx}/question/list?search_userId=${user.id}">我的问题</a>
			</div>

			<mytag:PermssionTag functionId="F7-1">
				<a id="question-tab" href="${ctx}/question/list">问题管理</a>
			</mytag:PermssionTag>
			<mytag:PermssionTag functionId="F8-1">
				<a id="paper-tab" href="${ctx}/paper/list">调查问卷</a>
			</mytag:PermssionTag>
		</div>
	</div>
</c:if>
