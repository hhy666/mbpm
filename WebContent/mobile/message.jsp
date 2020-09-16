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
		<script src="<%=request.getContextPath() %>/resource/mobile/app.js"></script>
				<script src="<%=request.getContextPath() %>/resource/mobile/common.js"></script>
		
		<script src="<%=request.getContextPath() %>/resource/mobile/matrix_mobile.js"></script>
		
		<link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/public.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/mui.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/matrix-base.css" />
		
		<style type="text/css">
.scroll-wrapper {  
    -webkit-overflow-scrolling: touch;  
    overflow-y: scroll;  
    /* 提示: 请在此处加上需要设置的大小(dimensions)或位置(positioning)信息! */  
}  
.scroll-wrapper iframe {  
    /* 你自己指定的样式 */  
}  
.demo-iframe-holder {  
  position: fixed;   
  right: 0;   
  bottom: 0;   
  left: 0;  
  top: 0;  
  -webkit-overflow-scrolling: touch;  
  overflow-y: scroll;  
}  
  
.demo-iframe-holder iframe {  
  height: 100%;  
  width: 100%;  
}  
</style>
		<style type="text/css">
			#backIcon{
		    position: fixed;
		    top: 0;
		    left: 0px;
		    z-index: 999999;
		    margin: 6px 25px 6px 0px;
		    width: 70px;
		    padding: 0;
		    height: 34px;
		    padding-left: 15px;
		}
		</style>
	</head>

	<body>
<%
  String messageId = request.getParameter("messageId");
%>	

<script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath() %>';
</script>	        
    
 	<body class="mui-fullscreen" >
	        
    <div class="scroll-wrapper mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
         <!-- 侧滑菜单导航容器 -->
        <%@ include file="/mobile/menu-list.jsp"%>
        
        
		<div class="mui-inner-wrap">
		<div class="mui-content" style="height:calc(100% - 44px)">
		 <header class="mui-bar mui-bar-nav">
                <!-- <a class="mui-icon mui-action-back mui-icon-back mui-pull-left"></a> -->
                <ul id='backIcon'><div><i class='fa fa-angle-left' style='color: #fff;top: 2px;font-size: 30px;    position: absolute;'></i></div></ul>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <h1 class="mui-title">消息详情</h1>
                 <script type="text/javascript">
                document.getElementById('backIcon').addEventListener('tap', function() {
                	var messageId = "<%=messageId%>";
					window.location.href = '<%=request.getContextPath() %>/mobile/message-list.jsp?messageId='+messageId+'&type=unReaded';
           		});
                </script>
            </header>
            
            	<br>
	<br>
			<div id="datalist" class="scroll-wrapper" style="top: 42px;overflow:hidden;width:100%;height:100%;background-color:#FFFFFF;" onchange="">
	
	
		
				  <iframe id="formContent" style="width: 100%; height: 100%;border:0;" src="<%=request.getContextPath() %>/mobile/message_infoMessage.action?messageId=<%=messageId%>"/>  
		

		</div>
		</div>
			
</div>			
			
	</body>

</html>