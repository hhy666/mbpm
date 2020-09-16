<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<html>
<head>
    <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=4,user-scalable=yes">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

    <title>welcome</title>
		<script src="<%=request.getContextPath() %>/resource/mobile/mui.min.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/app.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/zepto.min.js"></script>
		
		<script src="<%=request.getContextPath() %>/resource/mobile/matrix_mobile.js"></script>
		
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/public.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/mui.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/matrix-base.css" />
		<style>
			.mrow{}
		</style>
		
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
  	        
    
<div class="mui-inner-wrap">
<div class="mui-off-canvas-wrap mui-draggable" id="offCanvasWrapper">
		<div class="mui-inner-wrap"></div></div>
		<div class="mui-content">
		 <header class="mui-bar mui-bar-nav">
                <a class="mui-icon mui-action-back mui-icon-back mui-pull-left"></a>
              
                <h1 class="mui-title">流程运行图</h1>
                <% 
                String piid = request.getParameter("piid");
                %>
            </header>
			<div id="datalist" class="mui-content mui-scroll-wrapper scroll-wrapper" style="top: 42px;overflow:auto;width:100%;" onchange="">
				<iframe src="processDiagram.jsp?piid=<%=piid %>" style="width: 250vw; height: 250vh;;border:0;transform: scale(0.4);transform-origin: 0 0;"></iframe>
			</div>
           
		</div>
		</div>

</div>	
			<script>
		      //var piid = matrix.getParam("piid");
	   	      //document.getElementById("diagram").src="<%=request.getContextPath()%>/processMonitorHelper?matrixMonitorKey=ProcessMonitor&matrixMonitorPiid="+piid;
	   	      //document.getElementById("diagram").style.display="block";
		</script>
	</body>

</html>