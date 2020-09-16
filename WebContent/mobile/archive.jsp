<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

    <title>welcome</title>
    	<script src="<%=request.getContextPath() %>/resource/html5/js/jquery.min.js"></script>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
 		<script src='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/mui.min.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/app.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/common.js"></script>
		
		<script src="<%=request.getContextPath() %>/resource/mobile/matrix_mobile.js"></script>
		
		<link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/public.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/mui.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/matrix-base.css" />
		<script>
		  function closeLoading(){
		  	document.getElementById("loadingSpace").style.display="none";
		  	document.getElementById("loadingInfo").style.display="none";
		  	document.getElementById("formContent").style.display="block";
		  }
		  
		  
		</script>
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
<%
  String uuid = request.getParameter("uuid");
  String parentId = request.getParameter("parentId");
  String archiveType = request.getParameter("archiveType");     //3.html文档   4.附件文档
%>	

<script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath() %>';
</script>	

		<body class="mui-fullscreen" >
	      
    <div class="mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
        <!-- 侧滑菜单导航容器 -->
        <%@ include file="/mobile/menu-list.jsp"%>
        
		<div class="mui-inner-wrap">
		<div class="mui-content">
		 <header class="mui-bar mui-bar-nav">
                <!-- <a class="mui-icon mui-action-back mui-icon-back mui-pull-left"></a> -->
                <ul id='backIcon'><div><i class='fa fa-angle-left' style='color: #fff;top: 2px;font-size: 30px;    position: absolute;'></i></div></ul>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <h1 class="mui-title">文档详情</h1>
                 <script type="text/javascript">       	    
					//返回按钮点击事件
					 document.getElementById('backIcon').addEventListener('tap', function() {
						 var parentId = "<%=parentId%>";
						 if(parentId!='' && parentId!='null'){
							 window.location.href = '<%=request.getContextPath() %>/mobile/archivedetail-list.jsp?type=archive&parentId='+parentId+'';
						 }
					 });
				</script>
            </header>
            
            	<br>
	<br>
            
		<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 42px;overflow:hidden;width:100%;height:100%;background-color:#FFFFFF;" onchange="">
	      <div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
		    <a id="document" class="mui-control-item mui-active" href="#item3mobile">
				正文
			</a>
		    <a id="attach" class="mui-control-item" href="#item3mobile">
				附件	
			</a>
	      </div>
	      <script>
	      	var archiveType = "<%=archiveType%>";  //3.html文档   4.附件文档
			if(archiveType == 4){
			   document.getElementById('document').style.display = 'none';
				 
			}
		     //监听标签切换
			document.getElementById('document').addEventListener('tap',function(){
			 var url = "<%=request.getContextPath() %>/ShowArchiveContentServlet?uuid=<%=uuid%>";
		       document.getElementById("content").src=url;
			});

			document.getElementById('attach').addEventListener('tap',function(){
	           var url3 = "<%=request.getContextPath() %>/QueryShowArchiFileServlet?relativeId=<%=uuid%>";
		       document.getElementById("content").src=url3;
			});   
		</script>
		  <%
		  String archiveType1 = request.getParameter("archiveType");     //3.html文档   4.附件文档
		  	if("4".equals(archiveType1)){   //附件文档
		  %>
		  	<iframe id="content" style="width:100%;height:100%;border:0;" src="<%=request.getContextPath() %>/QueryShowArchiFileServlet?relativeId=<%=uuid%>"/>
		  <%		
		  	}else{
		  %>  
		  	<iframe id="content" style="width:100%;height:100%;border:0;" src="<%=request.getContextPath() %>/ShowArchiveContentServlet?uuid=<%=uuid%>"/>		
		  <%
		  	}
		  %>  	
		</div>
	  </div>
</div>			
	</body>

</html>