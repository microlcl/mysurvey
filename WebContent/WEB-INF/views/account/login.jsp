<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title><spring:message code="login.title"/></title>
</head>
<%
String flag="";
String name = "";
String password = "";
try{ 
    Cookie[] cookies=request.getCookies(); 
    if(cookies!=null){ 
    for(int i=0;i<cookies.length;i++){ 
        if(cookies[i].getName().equals("cookie_user")){ 
        String value =  cookies[i].getValue();
        if(value!=null&&!"".equals(value)){
            name=cookies[i].getValue().split("-")[0]; 
            if(cookies[i].getValue().split("-")[1]!=null && !cookies[i].getValue().split("-")[1].equals("null")){
            	password=cookies[i].getValue().split("-")[1]; 
            	flag="1";
            }
                     
           }
           } 
       request.setAttribute("username",name); 
       request.setAttribute("passward",password); 
   } 
   } 
}catch(Exception e){ 
   e.printStackTrace(); 
} 
%> 	
            
<body>
	<br/><br/><br/><br/>
	<form id="loginForm" action="${ctx}/login" method="post"
		class="form-horizontal">
		<c:if test="${not empty message}">
			<div id="message" class="alert alert-error input-medium controls"><button data-dismiss="alert" class="close">×</button>${message}</div>
		</c:if>
		<c:if test="${not empty user.id}">
			<div class="alert alert-error input-medium controls">
				<button class="close" data-dismiss="alert">×</button>
				${user.name}<spring:message code="login.alert"/>
			</div>
		</c:if>
		<c:if test="${empty user.id}">
			<div class="control-group">
				<label for="loginName" class="control-label"><spring:message code="login.username"/></label>
				<div class="controls">
					<input type="text" id="loginName" name="id"
						value="${username}" class="input-medium required" />
				</div>
			</div>
			<div class="control-group">
				<label for="plainPassword" class="control-label"><spring:message code="login.password"/></label>
				<div class="controls">
					<input type="password" id="plainPassword" name="plainPassword" value="<%=password %>"
						class="input-medium required" />
				</div>
			</div>

			<div class="control-group">
				<div class="controls">
					<label class="checkbox" for="rememberMe"><input
						type="checkbox" id="rememberMe" name="rememberMe" <%if(flag!=null && flag.equals("1") ){%> checked  <%}%> /> <spring:message code="login.rememberme"/></label> 
						<c:if test="${useLDAP != 'true'}">
						<label><a href="${ctx}/account/reset"">Forgot password</a></label>
						</c:if>
						<input
						id="submit_btn" class="btn btn-primary" type="submit" value='<spring:message code="login.signin"/>' />
						<c:if test="${useLDAP != 'true'}">
						<a class="btn" href="${ctx}/account/register">Sign Up</a>
						</c:if>
						
				</div>
			</div>
		</c:if>
	</form>
	
	<script>
		$(document).ready(function() {
			$("#loginForm").validate();
		});
	</script>

</body>
</html>
