<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>用户管理</title>
	<link href="${ctx}/static/bootstrap/2.3.2/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
</head>

<body>

	<form id="inputForm" action="${ctx}/account/save/profile" method="post" class="form-horizontal">
		<fieldset>
			<legend><small><spring:message code="updateuserinfo.title"/></small></legend>
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success input-medium controls">				
					<button data-dismiss="alert" class="close">×</button>
					${message}
				</div>
			</c:if>
			<div class="control-group">
				<label for="id" class="control-label"><spring:message code="updateuserinfo.loginname"/></label>
				<div class="controls">
					<input type="text" id="id" name="id"  value="${updateUser.id}" class="input-large" readonly/>
				</div>
			</div>	
			<div class="control-group">
				<label for="name" class="control-label"><spring:message code="updateuserinfo.name"/></label>
				<div class="controls">
					<input type="text" id="name" name="name"  value="${updateUser.name}" maxlength="64" class="input-large required" />
				</div>
			</div>	
 			<div class="control-group">
				<label for="plainPassword" class="control-label"><spring:message code="updateuserinfo.password"/></label>
				<div class="controls">
					<input type="password" id="plainPassword" name="plainPassword" maxlength="32" class="input-large required"/>
				</div>
			</div>
			<div class="control-group">
				<label for="confirmPassword" class="control-label"><spring:message code="updateuserinfo.confirmpassword"/></label>
				<div class="controls">
					<input type="password" id="confirmPassword" name="confirmPassword" class="input-large required" equalTo="#plainPassword"/>
				</div>
			</div>

			<div class="control-group">
				<label for="sex" class="control-label required"><spring:message code="updateuserinfo.sex"/></label>
				<div class="controls">
					<label class="radio inline">
						<input type="radio" name="sex" id="sex" value="男" ><spring:message code="updateuserinfo.male"/>
					</label>
					<label class="radio inline">
						<input type="radio" name="sex" id="sex" value="女" ><spring:message code="updateuserinfo.female"/>
					</label>
				</div>
			</div>	
            <div class="control-group">
  				  <label class="control-label" for="email"><spring:message code="updateuserinfo.email"/></label>
  				  <div class="controls">
   				     <input type="email" id="email" name="email" required="" value="${updateUser.email}" maxlength="64" class="input-large">
                  </div>
            </div>	
			<div class="control-group">
				<label for="phoneNum" class="control-label"><spring:message code="updateuserinfo.phonenum"/></label>
				<div class="controls">
					<input type="text" id="phoneNum" name="phoneNum" class="input-large " maxlength="20" value="${updateUser.phoneNum}" />
				</div>
			</div>
			<div class="control-group">
				<label for="address" class="control-label"><spring:message code="updateuserinfo.address"/></label>
				<div class="controls">
					<input type="text" id="address" name="address" class="input-large " maxlength="64" value="${updateUser.address}" />
				</div>
			</div>			
		    <div class="control-group">
				<label for="hometown" class="control-label"><spring:message code="updateuserinfo.hometown"/></label>
				<div class="controls">
					<input type="text" id="hometown" name="hometown" class="input-large " maxlength="64" value="${updateUser.hometown}" />
				</div>
			</div>			
			<div class="control-group">
                <label for="userBirthday" class="control-label"><spring:message code="updateuserinfo.birthday"/></label>
                <div class="input-append date form_date" style="margin-left:20px" >
                    <input size="16" type="text" id="userBirthday" name="userBirthday" style="width:160px" value="<fmt:formatDate value='${updateUser.birthday}' pattern='yyyy-MM-dd'/>" readonly>
                    <span class="add-on"><i class="icon-remove"></i></span>
					<span class="add-on"><i class="icon-th"></i></span>
                </div>
				<input type="hidden" id="dtp_input2" value="" /><br/>
				
            </div>				
			<div class="control-group">
				<label for="status" class="control-label"><spring:message code="updateuserinfo.status"/></label>
				<div class="controls">
					<label style="padding-top: 5px;color:#A1A1A1">
						${updateUser.status}
					</label>									
				</div>
			</div>	
			<div class="control-group">
				<label for="department_id" class="control-label"><spring:message code="updateuserinfo.dept"/></label>
				<div class="controls">
					<label style="padding-top: 5px;color:#A1A1A1">${updateUser.department.name}</label>
				</div>
			</div>	
	
			<div class="control-group">
				<label for="role" class="control-label required"><spring:message code="updateuserinfo.role"/></label>
				<div class="controls" style="width:500px">
					<c:forEach items="${updateUser.roles}" var="userRole">
						<label class="checkbox inline" style="width:80px;margin-left:0">
							<input type="checkbox" name="role" id="role" value="${userRole.id}" checked="true" disabled="true">${userRole.name}
						</label>
					</c:forEach>
				</div>
			</div>	
					
			<div class="control-group">
				<label for="comment" class="control-label"><spring:message code="updateuserinfo.comment"/></label>
				<div class="controls">
					<textarea id="comment" name="comment" maxlength="128" class="input-large" >${updateUser.comment}</textarea>
				</div>
			</div>	
			
			<div class="form-actions">
				<input id="submit_btn" class="btn btn-primary" type="submit" value="<spring:message code="updateuserinfo.submit"/>"/>&nbsp;	
				<input id="cancel_btn" class="btn" type="button" value="<spring:message code="updateuserinfo.back"/>" onclick="history.back()"/>
			</div>
		</fieldset>
	</form>

	<script type="text/javascript">
	$('.form_date').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  true,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0,
		format: 'yyyy-mm-dd'
    });
	$(document).ready(function() {
			//聚焦第一个输入框
			$("#updateUsername").focus();
			//为inputForm注册validate函数
			$("#inputForm").validate({
				rules: {
					name: {
						rangelength: [1,64]
					},
					plainPassword: {
						required: true,
						rangelength: [5,32]
					},
					sex: {
                        required: function (element) {
                            return $("input:radio[name='sex']:checked").val() != "";
                        }
                    },
                    phoneNum: {
						rangelength: [2,20]
					},
					address: {
						rangelength: [2,64]
					},
					hometown: {
						rangelength: [2,64]
					},
					comment: {
                    	rangelength: [0,128]
                    }
				},
				messages: {
					name: {
						rangelength: jQuery.validator.format("用户名必须在 {0} 和 {1} 个字符之间")
					},
					plainPassword: {
						rangelength: jQuery.validator.format("密码长度必须在 {0} 和 {1} 个字符之间")
					},
					sex: {
                        required: "请选择性别!"
                    },
                    phoneNum: {
						rangelength: jQuery.validator.format("号码长度必须在 {0} 和 {1} 个字符之间")
					},
					address: {
						rangelength: jQuery.validator.format("地址长度必须在 {0} 和 {1} 个字符之间")
					},
					hometown: {
						rangelength: jQuery.validator.format("籍贯长度必须在 {0} 和 {1} 个字符之间")
					},
				},
				errorElement: "span",
				errorPlacement: function (error, element) {
	                if(element.is(":radio")||element.is(":checkbox"))
                 	   error.appendTo(element.parent().parent());   
	                else
	                	error.insertAfter(element); 
               
        	    }
			});

			 
	});
	$("input[name='sex'][value=${updateUser.sex}]").prop("checked", true);
//	$("input[name='status'][value=${updateUser.status}]").prop("checked", true);

	</script>
</body>
</html>
