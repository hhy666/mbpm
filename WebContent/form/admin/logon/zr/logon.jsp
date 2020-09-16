<!DOCTYPE HTML>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="textml; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/form/admin/logon/zr/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/form/admin/logon/zr/css/style.css">
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<title>登录</title>
<script> 
		if (window != top) {
			top.location.href = location.href;
		}
	   function login()
	   {
	   	  if(!MForm0.validate()){
	   	  	return false;
	   	  }
	   	  Matrix.convertFormItemValue('Form0');
	      document.getElementById('Form0').submit();
	   }
	</script>
<script type="text/javascript">
	function check(){
		var invalidUser = document.getElementById("invalidUser");
		if(invalidUser!=null){
			invalidUser.style.display="none";
		}
	}
</script>
<style>
	#Form0{
		width:100%;
		height:100%;
	}
</style>
</head>
<body>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/logon/logon_logon.action">
	<div class="box">
	 <!--
		<div class="logo">
			<img src="<%=request.getContextPath()%>/form/admin/logon/zr/img/logo.png">
		</div>
	 -->
		<div class="content">
			<div class="title">
				<img src="<%=request.getContextPath()%>/form/admin/logon/zr/img/icon.png">
				<p>办公系统登录</p>
			</div>
			<div class="content1">
				<div style="padding-top:36px;">
					<img src="<%=request.getContextPath()%>/form/admin/logon/zr/img/person.png">
					<input type="text" placeholder="请输入用户名" id="logonName" name="logonName" autocomplete="off" onfocus="check()"/>
					<%
					   Object InvalidUser = request.getAttribute("InvalidUser");
					   if (InvalidUser != null) {
					%>
					<label id="invalidUser" class="logonDIV_matrix" style="color:red;font-size:10px;height:32px;line-height:32px;">无效用户!</label>
					<%}else{%>
					<%} %>
				</div>
				<div>
					<img src="<%=request.getContextPath()%>/form/admin/logon/zr/img/lock.png">
					<input type="password" placeholder="请输入密码" id="password" name="password" autocomplete="off"/>
				</div>
				<div>
					<img src="<%=request.getContextPath()%>/form/admin/logon/zr/img/tag.png">
					<input type="text" placeholder="请输入验证" style="width:106px;" autocomplete="off"/>
					<img src="<%=request.getContextPath()%>/form/admin/logon/zr/img/yan.png" style="margin-top:0.5px;margin-left:38px;">
				</div>
				<button id="submitBtn" type="submit">系统登录</button>
			</div>
		</div>
	</div>
</form>
</body>
</html>