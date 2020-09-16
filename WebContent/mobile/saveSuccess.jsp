<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=2.5,user-scalable=yes"><!-- 移动端新闻公告 -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<title>welcome</title>
<script src="<%=request.getContextPath()%>/resource/mobile/mui.min.js"></script>
<script src="<%=request.getContextPath()%>/resource/mobile/app.js"></script>
<script src="<%=request.getContextPath()%>/resource/mobile/common.js"></script>

<script
	src="<%=request.getContextPath()%>/resource/mobile/matrix_mobile.js"></script>
<script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath()%>';
</script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resource/mobile/public.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resource/mobile/mui.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resource/mobile/matrix-base.css" />

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

#contentDiv{
	text-align: center;
	vertical-align: middle;
	width: 100%;
	height: 30%;
	margin-top:50px;
}
</style>
<script>
			
</script>
</head>
<script>
		 
		  function closeLoading(){
		    
		  	document.getElementById("loadingSpace").style.display="none";
		  	document.getElementById("loadingInfo").style.display="none";
		  	document.getElementById("content").style.display="block";
		  }
		  window.onload=function(){
		//返回按钮点击事件
			document.getElementById('backIcon').addEventListener('tap', function() {
					window.location.href = '<%=request.getContextPath() %>/mobile/flow-list.jsp?type=${param.type}';
				
			});
		  } 
		</script>
<body class="mui-fullscreen">

	<div class="scroll-wrapper mui-off-canvas-wrap mui-draggable "
		id="offCanvasWrapper">

		<div class="mui-inner-wrap">
			<div class="mui-content">
				<header class="mui-bar mui-bar-nav">
					<h1 class="mui-title">任务执行</h1>

				</header>
				<br> <br>

				<div id="datalist" class="mui-content mui-scroll-wrapper"
					style="top: 42px; overflow: hidden; width: 100%; height: 100%; background-color: #FFFFFF;"
					onchange="">



					<div id="loadingInfo" style="text-align: center; top: 50px;"></div>

					<div id="contentDiv" class="iframeDiv" style='margin-top:50px;'>
						<img alt="" src="../resource/mobile/Bitmap.png">
						<div style="font-family: PingFangSC-Regular;font-size: 24px;color: #000000;letter-spacing: 0.78px;">
						提交成功！
						</div>
					</div>
					<div ="wDiv" style="text-align: center; vertical-align: middle;">
						<!-- <a id="backIcon">
							<img  alt="" src="../mobile/Group.png">
						</a> -->
						<div id="backIcon" class='mui-btn mui-btn-primary'>
						返回
						</div>
					</div>
				</div>
				<div style="height: 30px;" />
			</div>
		</div>

	</div>
</body>

</html>