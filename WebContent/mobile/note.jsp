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
  String uuid = request.getParameter("mBizId");
  String parentId = request.getParameter("parentId");
  String type = request.getParameter("type");
  String operation = request.getParameter("operation");  //文档中心html文档中查看关联文档时隐藏掉头部标题
%>		        
    <script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath() %>';
</script>	
    
  	<body class="mui-fullscreen" >
	        
    <div class="mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
        <!-- 侧滑菜单导航容器 -->
        <%@ include file="/mobile/menu-list.jsp"%>
          
		<div class="mui-inner-wrap">
		<div class="mui-content" style="height:calc(100% - 44px)">
		 <header class="mui-bar mui-bar-nav">
                <!-- <a class="mui-icon mui-action-back mui-icon-back mui-pull-left"></a> -->
                <ul id='backIcon'><div><i class='fa fa-angle-left' style='color: #fff;top: 2px;font-size: 30px;    position: absolute;'></i></div></ul>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <h1 class="mui-title">公告详情</h1>
                <script type="text/javascript">
                var operation = "<%=operation%>";
                if(operation == 'display'){
                	document.getElementById('headTitle').style.display = 'none';
                }
                document.getElementById('backIcon').addEventListener('tap', function() {
                	var type = "<%=type%>";
                	var parentId = "<%=parentId%>";
                	if(type == 'archive'){   //文档列表查看
                		if(parentId!='' && parentId!='null'){
                			window.location.href = '<%=request.getContextPath() %>/mobile/archivedetail-list.jsp?type=archive&parentId='+parentId+'';
                		}
                	}else{
                		if(parentId!='' && parentId!='null'){
                    		window.location.href = '<%=request.getContextPath() %>/mobile/notice-list.jsp?type=notice&parentId='+parentId+'&is_mobile_request=true';
                    	}else{
                    		window.location.href = '<%=request.getContextPath() %>/mobile/notice-inlet.jsp?type=noticelist';
                    	}
                	}
           		});
                </script>
           
            </header>
            
            <%
            	if(operation == null || operation.trim().length() == 0){
            %>
            <br>
			<br>
			<%
				}
			%>
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 42px;overflow:hidden;width:100%;height:100%;background-color:#FFFFFF;" onchange="">
	
	
			<div id="loadingInfo" style="text-align:center;top:50px;"></div>
				  <iframe id="formContent" style="width:100%;height:100%;border:0;" src="<%=request.getContextPath() %>/CustomerVelocityServlet?mBizId=<%=uuid%>&type=1&isPreview=true&status=1"/>  
			</div>

		</div>
		</div>
			
</div>			
			
	</body>

</html>