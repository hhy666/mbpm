<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

    <title>welcome</title>
				<script src="<%=request.getContextPath() %>/resource/mobile/mui.min.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/public.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/mui.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/matrix-base.css" />
		<script src="<%=request.getContextPath() %>/resource/mobile/matrix_mobile.js"></script>

		
    <script type="text/javascript">
		
    		var loginFail = function(response) {
    		}
    
    		var loginSuccess = function(response) {
//				if (dataType === 'json') {
//					response = JSON.stringify(response);
//				} 

				window.location.href='<%=request.getContextPath() %>/mobile/home.jsp';
				if(response!=null){
					if(response.result==true){
						window.location.href='<%=request.getContextPath() %>/mobile/home.jsp';
					}else{
						alert('非法用户!');
						window.location.href='<%=request.getContextPath() %>/login.jsp';
					}
				}else{
					alert('服务器无响应，请与管理员联系');
				}
				return;
			};
    		function login(){
				var uname = document.getElementById("userName").value;				
				var upassword = document.getElementById("password").value;
				if(uname==null || uname.trim().length==0){
					return false;
				}
				if(upassword==null || upassword.trim().length==0){
					return false;
				}
				var data = {};
				data.logonName = uname;
				data.password = upassword;
				matrix.sendRequest("<%=request.getContextPath()%>/mobile/auth_logon.action",data,loginSuccess, loginFail);
					
    		}
    		
    		function logout(){
    		}	
    		
    		
    </script>
    
</head>
<!--<body class="login-body">-->
<body style="">	
     <!-- <img src="resource/mobile/backgroud.png" class="logo" style="width:100%;height:100%;z-index:-10000;"/> -->
     <div style="width:100%;height:100%;background-image:url(<%=request.getContextPath() %>/resource/mobile/homeBack.png)">
       <form id="form0" action="task-list-ready.html">
       	
        	<table class="login" style="backgroundcolor:#000;" >
        		<tr><td>&nbsp;</td></tr>
        		
        	 	<tr>
        			<td class="login-row ">
					<div class="login-logo">
					</div>
        			</td>
        		</tr>
       		
        		<tr>
        			<td class="login-row">
        				<div class="login-img"><img style="width:80%;height:50px;" src="<%=request.getContextPath() %>/resource/mobile/logo.png" /></div>
        			</td>
        		</tr>
        		<tr>
        			<td class="login-row login-input" >
        			

        			<div class="mui-input-row" >
						<input id="userName" style="width:80%;"  class="mui-input-clear" type="text" required="required" placeholder="登录名">
					</div>
					<div class="mui-input-row" >
						<input id="password"  style="width:80%;" type="password" class="mui-input-clear" placeholder="密码">
					</div>
        		</td></tr>
        		
        		<tr><td style="height:20px;">&nbsp;</td></tr>
        		<tr>
        			<td class="login-row" >
        			<div class="mui-input-row" >
						<button type="button" style="width:40%;" class="mui-btn mui-btn-primary " onclick="login()">登录</button>
						<button type="button" style="width:40%;" class="mui-btn mui-btn-primary " onclick="reset()">重置</button>
					</div>
        		</td></tr>
        		<tr><td>&nbsp;</td></tr>
        	</table>
			
        </form>
       <script>
       	/*	var ipParam = matrix.getParam("ipValue");
      		var ipValue = matrix.getCookie('ipValue');
       		if (ipParam !== 'null' && ipParam !== null || ipParam !== undefined || ipParam !== '') {
       			document.getElementById('ipValue').value = ipParam;
       			document.getElementById('ipDiv').style.display="none";
       		}else
       		if (ipValue !== 'null' && ipValue !== null || ipValue !== undefined || ipValue !== '') {
       			document.getElementById('ipValue').value = ipValue;
       			document.getElementById('ipDiv').style.display="none";
       		}
       	*/
       </script>
       
      
</body>
</html>