<!DOCTYPE HTML>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.api.MFExecutionService"%>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <title>Matrix BPM</title>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="renderer" content="webkit"> 
    <script src='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></script>
   <%--  <script src="<%=request.getContextPath()%>/logonrs/jquery.js"></script> --%>
    <script src="<%=request.getContextPath()%>/logonrs/jquery.base64.js"></script>
    <script src="<%=request.getContextPath()%>/logonrs/jquery.cookie.js"></script>
    <!-- <script type="text/javascript" src="http://down.admin5.com/demo/code_pop/19/150/js/jquery.SuperSlide.2.1.1.js"></script> -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/logonrs/jquery.SuperSlide.2.1.3.js"></script>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/logonrs/layui.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/logonrs/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/logonrs/commonHeader.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/logonrs/commonFooter.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/logonrs/iconfont.css">
    <!--[if lt IE 9]>
        <script src="../../../../base/js/html5shiv.js"></script>
        <script src="../../../../base/js/html5.min.js"></script>
        <script src="../../../../base/js/respond.min.js"></script>
    <![endif]-->
<link rel="stylesheet" href="<%=request.getContextPath()%>/logonrs/beforlogin.css">
<script src="<%=request.getContextPath()%>/logonrs/reqConfig.js"></script>
	<script src="<%=request.getContextPath()%>/logonrs/beforlogin.js"></script>
	
    <script src="<%=request.getContextPath()%>/logonrs/layui.js"></script>
    <script src="<%=request.getContextPath()%>/logonrs/public.js"></script>
    <script src="<%=request.getContextPath()%>/logonrs/titleName.js"></script>
    <script src="<%=request.getContextPath()%>/logonrs/docassistant.js"></script>
    <script src="<%=request.getContextPath()%>/logonrs/common.js"></script>
    <script src="<%=request.getContextPath()%>/logonrs/common_opt.js"></script>
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/css/css/reset.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/css/css/css.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/css/css/banner.css">
   	<link id="layuicss-layer" rel="stylesheet" href="<%=request.getContextPath()%>/logonrs/layer.css" media="all">
	
	   
	
<script type="text/javascript">
$(document).ready(function(){

	$(".prev,.next").hover(function(){
		$(this).stop(true,false).fadeTo("show",0.9);
	},function(){
		$(this).stop(true,false).fadeTo("show",0.4);
	});
	
	 $(".banner-box").slide({
		titCell:".hd ul",
		mainCell:".bd ul",
		effect:"fold",
		interTime:3500,
		delayTime:300,
		autoPlay:true,
		autoPage:true, 
		trigger:"click" 
	}); 
});
</script>
<script>
	$(document).ready(function(){
		jQuery.navlevel2 = function(level1,dytime) {
			
			  $(level1).mouseenter(function(){
				  varthis = $(this);
				  delytime=setTimeout(function(){
					varthis.find('ul').slideDown();
				},dytime);
				
			  });
			  $(level1).mouseleave(function(){
				 clearTimeout(delytime);
				 $(this).find('ul').slideUp();
			  });
			  
			};
		$.navlevel2("li.mainlevel",200);
	});
	
	if (window != top) {
		top.location.href = location.href;
	}


	function login()
	{
		  var userAgent = navigator.userAgent.toLowerCase();  //取得浏览器的userAgent字符串   
		  if ((userAgent.indexOf('mozilla') == 0 && 
		        userAgent.indexOf('applewebkit') > 0 && 
		        userAgent.indexOf("edge") == -1 && 
		            userAgent.toLowerCase().indexOf("chrome/") > 0) 
		            || userAgent.indexOf("mac")>0){
		     document.getElementById('isChrome').value= "true";
		  }
		  
		 /*  if(!MForm0.validate()){
		  	return false;
		  } */
		  Matrix.convertFormItemValue('Form0');
		  
	  
	   document.getElementById('Form0').submit();
	}
	
	function reImg(){
			if(document.getElementById("invalidUser"))
        	document.getElementById("invalidUser").style.display ="none";
     	 var img = document.getElementById("img");  
        img.src = "<%=request.getContextPath()%>/ImageServlet?d="+ Math.random(); 
}
</script>
</head>
<%
	//request.getSession().setAttribute("ExecutionService", null);
	//MFormContext.setUser(null);
	
	String isChrome = (String)request.getAttribute("isChrome");
	if(isChrome!=null && "false".equals(isChrome)){
%>
		 <script> 
		 	alert('设计人员或管理员请使用谷歌浏览器~!');
		 </script>
		 
<%
	}
%>
<body>
    
    <div class="layui-header czmyheader" style="height: 17%">
        <a class="layui-logo"><img class="logo" src="<%=request.getContextPath()%>/resource/images/logo2.png" alt="" style="width: 250px;height: 40px;position:absolute;top:10px"></a>
    </div>

<div class="loginbg" style="height: 71%" >
<!-- style="background-image: url('./resource/test/0.jpg')" -->
<div class="banner-box">
 <form class="loginBox layui-form" id="Form0" name="Form0" method="post" action="<%=request.getContextPath()%>/logon/logon_logon.action">
        <div class="layui-input-block">
            <i class="iconfont icon-yonghu"></i>
            <input type="text" placeholder="请输入用户名" id="logonName" name="logonName" autocomplete="off" required onfocus=""/>
					<%
					   Object InvalidUser = request.getAttribute("InvalidUser");
					   if (InvalidUser != null) {
					%>
					<label id="invalidUser" style="color:red;font-size:10px;height:32px;line-height:32px;">无效</label>
					<%}else{%>
					<%} %>
        </div>
        <div class="layui-input-block">
            <i class="iconfont icon-xiugaimima"></i>
			<input class="inputCls" type="password" placeholder="请输入密码" id="password" name="password" autocomplete="off" required/>
					<%
					   Object InvalidPsd = request.getAttribute("InvalidPsd");
					   if (InvalidPsd != null) {
					%>
					<label id="invalidUser" class="logonDIV_matrix" style="color:red;font-size:10px;height:32px;line-height:32px;">无效</label>
					<%}else{%>
					<%} %>        
		</div>
		<div class="layui-input-block">
            	<i class="iconfont icon-xiugaimima"></i>
				<input type="text" id="code" name="code" placeholder="请输入验证码" required style="width:88px;" />
				<a href="javascript:reImg();"><img id="img" src="<%=request.getContextPath()%>/ImageServlet?d=<%=System.currentTimeMillis() %>" style="vertical-align: top;height:26px;margin-top:2px;margin-left:10px;"></a>
					<%
					   Object InvalidCode = request.getAttribute("InvalidCode");
					
					   if (InvalidCode != null) {
					%>
					<label id="invalidUser" class="logonDIV_matrix" style="color:red;font-size:10px;height:32px;line-height:32px;margin-left:40px">错误验证码!</label>
					<%}else{%>
					<%} %>
			</div>
        <div class="layui-input-block mr78" style="width:160px;">
            <button onclick="javascript:login();" class="layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="login">登录</button>
        </div>
        <input type="hidden" id="isChrome" name="isChrome" value="false"/>
    </form>
	<div class="bd">
        <ul>          	    
            <li style="background:#1f5ee8">
                <div class="m-width"  style="width:100%;">
                <a href="javascript:void(0);"><img  style="width:100%;" src="<%=request.getContextPath()%>/resource/images/0-0.jpg" /></a>
                </div>
            </li>
            <li style="background:#74c5e6">
                <div class="m-width"  style="width:100%;">
                <a href="javascript:void(0);"><img  style="width:100%;" src="<%=request.getContextPath()%>/resource/images/0-2.jpg" /></a>
                </div>
            </li>
            <li style="background:#dcf6fb;">
                <div class="m-width"  style="width:100%;">
                <a href="javascript:void(0);"><img  style="width:100%;" src="<%=request.getContextPath()%>/resource/images/0-3.jpg" /></a>
                </div>
            </li>
            <li style="background:#003bf4">
                <div class="m-width"  style="width:100%;">
                <a href="javascript:void(0);"><img  style="width:100%;" src="<%=request.getContextPath()%>/resource/images/0-4.jpg" /></a>
                </div>
            </li>  
        </ul>
    </div>
<div class="banner-btn">
     
        <div class="hd">
	        <ul>
		        <li class="">1</li>
		        <li class="">2</li>
		        <li class="">3</li>
		        <li class="on">4</li>
	        </ul>
        </div>
    </div>
</div>
</div>
<footer>
    <p>Copyright © 北京华创动力科技有限公司</p>
</footer>
  
</body></html>