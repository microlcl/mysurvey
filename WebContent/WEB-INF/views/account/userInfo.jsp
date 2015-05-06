<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>用户管理</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/styles/form.css">
	

</head>

<body>
	<div class="form">
		<h1><spring:message code="userinfo.title"/></h1>
		<div style="padding:20px;">
		<table class="table table-striped table-bordered table-condensed">
			<tbody>
				<tr>
					<td style="width:80px" class="formlabel"><spring:message code="userinfo.loginname"/></td>
					<td style="color:#A1A1A1">${infoUser.name}</td>
				</tr>
				<tr>
					<td class="formlabel" ><spring:message code="userinfo.sex"/></td>
					<td style="color:#A1A1A1">${infoUser.sex}</td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.email"/></td>
					<td style="color:#A1A1A1">${infoUser.email}</td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.phonenum"/></td>
					<td style="color:#A1A1A1">${infoUser.phoneNum}</td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.address"/></td>
					<td style="color:#A1A1A1">${infoUser.address}</td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.hometown"/></td>
					<td style="color:#A1A1A1">${infoUser.hometown}</td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.birthday"/></td>
					<td style="color:#A1A1A1"><fmt:formatDate value="${infoUser.birthday}" pattern="yyyy-MM-dd"/> </td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.status"/></td>
					<td style="color:#A1A1A1">${infoUser.status}</td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.dept"/></td>
					<td style="color:#A1A1A1">${infoUser.department.name}</td>
				</tr>
				<tr>
					<td style="padding-top: 13px;" class="formlabel"><spring:message code="userinfo.role"/></td>
					<td style="color:#A1A1A1">
					<div class="controls" style="width:500px">
					<c:forEach items="${infoUser.roles}" var="userRole">
						<label class="checkbox inline" style="width:80px;margin-left:0">
							<input type="checkbox" name="role" id="role" value="${userRole.id}" checked="true" disabled="true">${userRole.name}
						</label>
					</c:forEach>
					</div>
					</td>
				</tr>
				<tr>
					<td class="formlabel"><spring:message code="userinfo.comment"/></td>
					<td style="color:#A1A1A1">${infoUser.comment}</td>
				</tr>
			</tbody>
		</table>
		</div>
			<div class="form-actions">
				<input id="cancel_btn" class="btn" type="button" value="<spring:message code="userinfo.back"/>" onclick="history.back()"/>
			</div>
   </div>


	<script type="text/javascript">
	
	$("input[name='sex'][value=${infoUser.sex}]").prop("checked", true);
	$("input[name='status'][value=${infoUser.status}]").prop("checked", true);

	</script>
</body>
</html>
