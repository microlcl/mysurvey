<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://com.eastteam.myprogram/mytaglib" prefix="mytag" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:if test="${not empty user.id}">

	<div id="leftbar" class="span2" style="width:180px;">
		<h1><spring:message code="menu.mydashboard"/></h1>
		<div class="submenu">
			<a id="mygroup-tab" href="${ctx}/myGroup/list"><spring:message code="menu.mygroup"/></a>
			<a id="mylaunch-tab" href="${ctx}/survey/myLaunch"><spring:message code="menu.mylaunch"/></a>
			<a id="" href="${ctx}/survey/myParticipation"><spring:message code="menu.myparticipation"/></a>
			<a id="myparticipation-tab" href="${ctx}/paper/list?search_userId=${user.id}"><spring:message code="menu.mypaper"/></a>
			<a id="myquestion-tab" href="${ctx}/question/list?search_userId=${user.id}"><spring:message code="menu.myquestion"/></a>
		</div>
		<mytag:PermssionTag functionId="F21">
			<h1><spring:message code="menu.admin"/></h1>
				<div class="submenu">	
					<a id="role-tab" href="${ctx}/role/all"><spring:message code="menu.admin.role"/></a>
					<!-- 		
					<a id="question-tab" href="${ctx}/question/list"><spring:message code="menu.admin.question"/></a>
					<a id="paper-tab" href="${ctx}/paper/list"><spring:message code="menu.admin.paper"/></a>
					 -->
				</div>
		</mytag:PermssionTag>
	</div>
</c:if>
