<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<html>
<head>
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=3,maximum-scale=5,user-scalable=yes">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<style type="text/css">
.scroll-wrapper {  
    -webkit-overflow-scrolling: touch;  
    overflow-y: scroll;  
    /* 提示: 请在此处加上需要设置的大小(dimensions)或位置(positioning)信息! */  
}  
.scroll-wrapper iframe {  
    /* 你自己指定的样式 */  
}  
</style>
</head>

<body>
   <% 
   String piid = request.getParameter("piid");
   %>
   <div id="imgDiv"  class="scroll-wrapper"  style="width:100%;height:100%;">
		<img style="height:500px;" id="diagram" src="<%=request.getContextPath()%>/processMonitorHelper?matrixMonitorKey=ProcessMonitor&matrixMonitorPiid=<%=piid %>" style="display:none; overflow:auto;width:100%;">
	</div>	
		
</body>

</html>