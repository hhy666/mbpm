<!DOCTYPE HTML>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="textml; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/reset.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/style.css" />
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<title>登录</title>
<script type="text/javascript">
	if (window != top) {
			top.location.href = location.href;
		}
	   function login()
	   {
	   	  
	   	  //document.getElementById('iframesignon').contentWindow.login(document.all.logonName.value, document.all.password.value);
	   	   
	      document.getElementById('Form0').submit();
	   }
	   
	function check(){
		var invalidUser = document.getElementById("invalidUser");
		if(invalidUser!=null){
			invalidUser.style.display="none";
		}
	}
	
	function submit(){
	    alert("aaaaaaaaaaa");
		document.getElementById("Form0").submit();
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
<div class="deng">
<div class="deng1">
<div class="deng1-b">
	<div class="deng-content">
		<div class="deng-left">
			<img src="<%=request.getContextPath()%>/resource/images/img.png">
			<div class="deng-left-p">
				<h1>智能协同办公系统</h1>
				<span>ZHINENGXIETONGBANGONGXITONG</span>
			</div>
		</div>
		<div class="deng-right">
			<p>
				<span>login</span>
				<img src="<%=request.getContextPath()%>/resource/images/location.png">
			</p>
			<div >
				<img src="<%=request.getContextPath()%>/resource/images/person.png">
				<input type="text" placeholder="请输入用户名" id="logonName" name="logonName" autocomplete="off" required onfocus="check()"/>
					<%
					   Object InvalidUser = request.getAttribute("InvalidUser");
					   if (InvalidUser != null) {
					%>
					<label id="invalidUser" style="color:red;font-size:10px;height:32px;line-height:32px;">无效</label>
					<%}else{%>
					<%} %>
			</div>
			<div>					
				<img src="<%=request.getContextPath()%>/resource/images/lock.png">
				<input class="inputCls" type="password" placeholder="请输入密码" id="password" name="password" autocomplete="off" required/>
					<%
					   Object InvalidPsd = request.getAttribute("InvalidPsd");
					   if (InvalidPsd != null) {
					%>
					<label id="invalidUser" class="logonDIV_matrix" style="color:red;font-size:10px;height:32px;line-height:32px;">无效</label>
					<%}else{%>
					<%} %>
			</div>
				<div>
				<img src="<%=request.getContextPath()%>/resource/images/tag.png">
				<input type="text" id="code" name="code" placeholder="请输入验证码" required style="width:128px;float:left;margin-left:10px;" />
				<a href="javascript:submit();"><img src="<%=request.getContextPath()%>/ImageServlet?d=<%=System.currentTimeMillis() %>" style="float:left;height:26px;margin-top:2px;margin-left:10px;"></a>
					<%
					   Object InvalidCode = request.getAttribute("InvalidCode");
					   if (InvalidCode != null) {
					%>
					<label id="invalidUser" class="logonDIV_matrix" style="color:red;font-size:10px;height:32px;line-height:32px;">错误验证码!</label>
					<%}else{%>
					<%} %>
			</div>
			<button type="button" onclick="login();">登录系统</button>
		</div>
	</div>
</div>	
</form>

<div style="display:none;" id="signon"><iframe
	id="iframesignon" name="iframesignon"
	width="0px" height="0px" src="<%=request.getContextPath() %>/testlogon.html" frameborder="0"></iframe></div>
	
</body>
</html>