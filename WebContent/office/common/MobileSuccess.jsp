<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.matrix.faces.context.MFacesContext" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>提示页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<style type="text/css">
body{
font-family: "Microsoft YaHei", '微软雅黑', '宋体';
}
.hintWrap{ margin:0 auto;}
.clr {zoom:1;}
.hint{
	border:#ddd 0px solid;
/*	background:#f3f3f3;*/
	padding:50px 30px 30px 30px;
	margin:30px 0 50px 0;
	height: 150px;
}
.success_icon{margin:0 50px 0 100px;}
.success_icon img{width:75px; height:75px;}
.hint_cont{
	margin:10px 0 100px 0;
	font-size:14px;
	color:#4a4a4a;
}
.hint_cont h1{
	width:500px;
	font-size:24px;
}
.f_l {float:left;}
.color_success{color:#71a100; padding:0 5px;}
.hint_cont_in {
	font-size:14px;
	line-height:28px;
	margin:0 0 10px 0;
}
.hint_cont_in a{color:#fff; background:#f99100; text-decoration:none; font-weight:bolder; margin: 0 35px; padding: 5px 20px}
.hint_cont_in a:hover{color:#f99100; background:#fff; text-decoration:none; border:#f99100 1px solid;}
.clr:after {
    visibility: hidden;
    display: block;
    font-size: 0;
    content: " ";
    clear: both;
    height: 0;
}
</style>

  </head>
<script>
function loadJS(){
	var result = document.getElementById('result').value;
	if("true"==result){
		parent.window.location="<%=request.getContextPath() %>/app-list.jsp?type=newApp&parentId=flowRoot";
	}
}
</script>
  <body onLoad="loadJS();">
  <input type="hidden" id="result" name="result" value="<%=request.getAttribute("result") %>"/>
    <div class="hintWrap clr">
    
      <% 
  String result = (String)request.getAttribute("result"); 
   if("true".equals(result)){ 
 
    %>
  <div class="hint clr" style="background:#f3f3f3;text-align:center;">
        <div class="success_icon f_l"><br><br><img src="<%=basePath%>image/successful_128.png" /></div>
        <div class="hint_cont f_l">
            <h1>您已<span class="color_success">发送成功</span>！</h1>
            <div class="hint_cont_in">
               
                    <a href="javascript:parent.window.location='<%=request.getContextPath() %>/app-list.jsp?type=newApp&parentId=flowRoot';">关闭</a>
                    
                
            </div>
        </div>
        </div>
          <%
   }
    else if("false".equals(result)){ %>
     <div class="hint clr">
        <div class="error_icon f_l"><img src="<%=basePath%>image/error_512.png"></div>
        <div class="hint_cont hint_cont_error f_l">
            <h1>发送失败<br>请重新操作！</h1>
        </div>
    </div>
  </div>
  
  <%} else if("error1".equals(result)){ %>
   <div class="hint clr">
        <div class="error_icon f_l"><img src="<%=basePath%>image/error_512.png"></div>
        <div class="hint_cont hint_cont_error f_l">
            <h1>流程版本不存在或者未发布<br>请重新操作！</h1>
        </div>
  </div>
  <%}%>
    
  </div>
  </body>
</html>
