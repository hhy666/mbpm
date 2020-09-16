<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>

     <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

    <title>welcome</title>
		<script src="<%=request.getContextPath() %>/resource/mobile/mui.min.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/app.js"></script>
				<script src="<%=request.getContextPath() %>/resource/mobile/common.js"></script>
		
		<script src="<%=request.getContextPath() %>/resource/mobile/matrix_mobile.js"></script>
		
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
		<script>
		  function closeLoading(){
		  	//document.getElementById("loadingSpace").style.display="none";
		  	//document.getElementById("loadingInfo").style.display="none";
		  	document.getElementById("formContent").style.display="block";
		  }
		  
		  
		</script>
		<script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath() %>';
</script>	
		
	</head>
<%
   String fdid = request.getParameter("fdid");
   String pdid = request.getParameter("pdid");
   String adid = request.getParameter("adid");
   String platId = request.getParameter("platId");
   
   //TextFlowStartForm
   String startFormId = "StartFlowForm";
   if("CkeditorList".equals(fdid) || "EditCkEditor".equals(fdid)){
	   startFormId = "TextFlowStartForm";
   }
%>
	<body class="mui-fullscreen" >
	        
         <!-- 侧滑导航根容器 -->
    <div class="scroll-wrapper mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
        <!-- 菜单容器 -->
        <aside class="mui-off-canvas-left">
            <div class="mui-scroll-wrapper">
                <div class="mui-scroll">
                    <!-- 菜单具体展示内容 -->
                    <div class="user-info">
	<a href="javascript:;">
			<img class="mui-media-object mui-pull-left" src="/Public/assets/images/logo.png">
			<div class="mui-media-body">
				Matrix Office
			</div>
		</a>
		
	<ul  class="mui-table-view2 mui-table-view-chevron mui-table-view-inverted">	
		<li class="mui-table-view-cell">
		<a href="home.jsp" class="mui-navigate-right mui-ellipsis">首页 <span class="left-desc">Home</span></a>
	</li>
	<li class="mui-table-view-cell">
		<a id="newApp" href="app-list.jsp?type=newApp&parentId=flowRoot" class="mui-navigate-right mui-ellipsis">协同事项</a>
	</li>
	<li class="mui-table-view-cell">
		<a href="flow-list.jsp?type=readyTask" class="mui-navigate-right mui-ellipsis">任务中心</a>
	</li>
	<li class="mui-table-view-cell">
		<a href="archive-list.jsp?type=catalog&parentId=root" class="mui-navigate-right mui-ellipsis">文档中心</a>
	</li>
	<li class="mui-table-view-cell">
		<a href="news-list.jsp?type=catalog&parentId=" class="mui-navigate-right mui-ellipsis">新闻</a>
	</li>
	<li class="mui-table-view-cell">
		<a href="notice-list.jsp?type=catalog&parentId=" class="mui-navigate-right mui-ellipsis">公告</a>
	</li>
</ul>
	</div>

                </div>
            </div>
        </aside>
        
        
		<div class="mui-inner-wrap">
		<div class="mui-content">
		 <header class="mui-bar mui-bar-nav">
                <a class="mui-icon mui-action-back mui-icon-back mui-pull-left"></a>
                <a id="offCanvasShow" hrTextFlowStartForm.rform?mHtml5Flag=true&pdid=defaultFlow&type=3&sysType=2&adid=432375828421&authId=402881895668eada015668ffed6d0003ef="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <h1 class="mui-title">发起自由流</h1>
                
        
            </header>
            
            	<br>
	<br>
            
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 42px;overflow:hidden;width:100%;height:100%;background-color:#FFFFFF;" onchange="">
			
			   <div id="loadingInfo" class="scroll-wrapper" style="text-align:center;top:50px;"></div>
				 <iframe id="formContent" style="width:100%;height:100%;border:0;transform-origin: 0 0;" src="<%=request.getContextPath() %>/TextFlowStartForm.rform?mHtml5Flag=true&pdid=defaultFlow&type=3&sysType=2&adid=432375828421&authId=402881895668eada015668ffed6d0003"/>  
			</div>	
		   </div>
		</div>
</div>
</div>			
	</body>

</html>