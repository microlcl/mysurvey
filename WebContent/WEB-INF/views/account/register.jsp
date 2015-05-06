<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>用户注册</title>
	<link href="${ctx}/static/bootstrap/2.3.2/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/static/easyui/mytree.css">
	<script src="${ctx}/static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

</head>

<body>
	<form id="inputForm" action="${ctx}/account/register" method="post" class="form-horizontal">
		<fieldset>
			<legend><small><spring:message code="register.title"/></small></legend>
			<div class="control-group">
				<label for="loginName" class="control-label"><spring:message code="register.loginname"/></label>
				<div class="controls">
					<input type="text" id="id" name="id" maxlength="64" class="input-large required"/>
				</div>
			</div>
			<div class="control-group">
				<label for="name" class="control-label"><spring:message code="register.name"/></label>
				<div class="controls">
					<input type="text" id="name" name="name" maxlength="64" class="input-large required"/>
				</div>
			</div>
			<div class="control-group">
				<label for="plainPassword" class="control-label"><spring:message code="register.password"/></label>
				<div class="controls">
					<input type="password" id="plainPassword" name="plainPassword" maxlength="32" class="input-large required"/>
				</div>
			</div>
			<div class="control-group">
				<label for="confirmPassword" class="control-label"><spring:message code="register.confirmpassword"/></label>
				<div class="controls">
					<input type="password" id="confirmPassword" name="confirmPassword" class="input-large required" equalTo="#plainPassword"/>
				</div>
			</div>
			<div class="control-group">
				<label for="sex" class="control-label"><spring:message code="register.sex"/></label>
				<div class="controls">
					<label class="radio inline">
						<input type="radio" name="sex" id="sex" value="男" checked><spring:message code="register.sex.male"/>
					</label>
					<label class="radio inline">
						<input type="radio" name="sex" id="sex" value="女" ><spring:message code="register.sex.female"/>
					</label>
				</div>
			</div>	
            <div class="control-group">
  				  <label class="control-label" for="email"><spring:message code="register.email"/></label>
  				  <div class="controls">
   				     <input type="email" id="email" name="email" required="" maxlength="64" placeholder="abc@gmail.com" class="input-large">
                  </div>
            </div>	
			<div class="control-group">
				<label for="phoneNum" class="control-label"><spring:message code="register.phonenum"/></label>
				<div class="controls">
					<input type="text" id="phoneNum" name="phoneNum" maxlength="20" class="input-large" />
				</div>
			</div>
						<div class="control-group">
				<label for="address" class="control-label"><spring:message code="register.address"/></label>
				<div class="controls">
					<input type="text" id="address" name="address"  maxlength="64"class="input-large" />
				</div>
			</div>			
		    <div class="control-group">
				<label for="hometown" class="control-label"><spring:message code="register.hometown"/></label>
				<div class="controls">
					<input type="text" id="hometown" name="hometown" class="input-large"  maxlength="64"/>
				</div>
			</div>			
			<div class="control-group">
                <label for="userBirthday" class="control-label"><spring:message code="register.birthday"/></label>
                <div class="input-append date form_date" style="margin-left:20px" >
                    <input size="16" type="text" id="userBirthday" name="userBirthday" style="width:160px"  readonly>
                    <span class="add-on"><i class="icon-remove"></i></span>
					<span class="add-on"><i class="icon-th"></i></span>
                </div>
				<input type="hidden" id="dtp_input2" value="" /><br/>
				
            </div>	
			<div class="form-actions">
				<input id="submit_btn" class="btn btn-primary" type="submit" value="<spring:message code="register.submit"/>"/>&nbsp;	
				<input id="cancel_btn" class="btn" type="button" value="<spring:message code="register.back"/>" onclick="history.back()"/>
			</div>
		</fieldset>
	</form>
	
	<script type="text/javascript">
		$(document).ready(function() {
			//聚焦第一个输入框
			$("#loginName").focus();
			//为inputForm注册validate函数
			$("#inputForm").validate({
				rules: {
					id: {
						rangelength: [2,64],
						remote: {
							url:"${ctx}/account/checkLoginName"
						}
					},
					name: {
						rangelength: [2,64]
					},
					plainPassword: {
						required: true,
						rangelength: [5,32]
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
				},
				messages: {
					id: {
						rangelength: jQuery.validator.format("登录名必须在 {0} 和 {1} 个字符之间"),
						remote: "用户登录名已存在"
					},
					name: {
						rangelength: jQuery.validator.format("用户名必须在 {0} 和 {1} 个字符之间")
					},
					plainPassword: {
						rangelength: jQuery.validator.format("密码长度必须在 {0} 和 {1} 个字符之间")
					},
					phoneNum: {
						rangelength: jQuery.validator.format("号码长度必须在 {0} 和 {1} 个字符之间")
					},
					address: {
						rangelength: jQuery.validator.format("地址长度必须在 {0} 和 {1} 个字符之间")
					},
					hometown: {
						rangelength: jQuery.validator.format("籍贯长度必须在 {0} 和 {1} 个字符之间")
					}
				}
			});
		});
		
	$('.form_date').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  true,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0,
		format: 'yyyy-mm-dd',
		pickerPosition: "top-right"
    });
	</script>
</body>
</html>
