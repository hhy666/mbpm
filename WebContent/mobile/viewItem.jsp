<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>

       <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=2.5,user-scalable=yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

    <title>welcome</title>
		<script src="<%=request.getContextPath() %>/resource/mobile/mui.min.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/app.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/zepto.min.js"></script>
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
<% 
	String type = request.getParameter("type");
	String parentId = request.getParameter("parentId");
	String operation = request.getParameter("operation");  //文档中心html文档中查看关联文档时隐藏掉头部标题

    String hasDoc = request.getParameter("hasDoc");
	String taskId = request.getParameter("taskId");
	String piid = request.getParameter("piid");
	String pdid = request.getParameter("pdid");
	String ptid = request.getParameter("ptid");
	String adid = request.getParameter("adid");
	String atid = request.getParameter("atid");
	String aiid = request.getParameter("aiid");
	String mBizId = request.getParameter("mBizId");
	String fdid = request.getParameter("fdid");
	String viewFlag = request.getParameter("matrix_view_flag");

%>		
		<script>
		
		  function closeLoading(){
		  	document.getElementById("loadingSpace").style.display="none";
		  	document.getElementById("loadingInfo").style.display="none";
		  	document.getElementById("content").style.display="block";
		  }
		  
		  
		</script>
		
			<script>
			
			function init(){
		      //监听标签切换
			document.getElementById('form').addEventListener('tap',function(){
	           var url = "<%=request.getContextPath() %>/<%=fdid%>.rform?mFlowBizId=<%=mBizId%>&piid=<%=piid%>&pdid=<%=pdid%>&matrix_view_flag=true&mHtml5Flag=true&mode=print";
				if('<%=pdid%>' == 'defaultFlow')
				   url = "<%=request.getContextPath() %>/TextFlowServlet?mFlowBizId=<%=mBizId%>";
		       document.getElementById("content").src=url;

   		   });

			document.getElementById('comment').addEventListener('tap',function(){
	           var url = "<%=request.getContextPath() %>/office/flow/OpinionList.jsp?is_mobile=true&piid=<%=piid%>";
		       document.getElementById("content").src=url;

 			});

			document.getElementById('attach').addEventListener('tap',function(){
	           var url = "<%=request.getContextPath() %>/mobile/downloadFile.jsp?isDocFile=${param.type }&mFlowBizId=<%=mBizId%>";
		       document.getElementById("content").src=url;
			});
		
			var url2 = "<%=request.getContextPath() %>/<%=fdid%>.rform?mFlowBizId=<%=mBizId%>&piid=<%=piid%>&pdid=<%=pdid%>&matrix_view_flag=true&mHtml5Flag=true&mode=print";
			if('<%=pdid%>' == 'defaultFlow')
			   url2 = "<%=request.getContextPath() %>/TextFlowServlet?mFlowBizId=<%=mBizId%>";
		       document.getElementById("content").src=url2;
		}	
			
		</script>
		<style type="text/css">
			#backIcon{
		    position: fixed;
		    top: 0;
		    left: 0px;
		    z-index: 999999;
		    margin: 6px 25px 6px 0px;
		    width: 60px;
		    padding: 0;
		    height: 34px;
		    padding-left: 15px;
		}
		</style>
	</head>
<script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath() %>';
</script>	

	<body class="mui-fullscreen" onload="init();">
	        
    <div class="mui-off-canvas-wrap mui-draggable scroll-wrapper" id="offCanvasWrapper">
         <!-- 侧滑菜单导航容器 -->
        <%@ include file="/mobile/menu-list.jsp"%>
    
<div class="mui-inner-wrap" >
<div class="mui-off-canvas-wrap mui-draggable" id="offCanvasWrapper">
		<div class="mui-inner-wrap"></div></div>
		<div class="mui-content" >
		 <header class="mui-bar mui-bar-nav" id="headTitle">
                <!-- <a class="mui-icon mui-action-back mui-icon-back mui-pull-left"></a> -->
                <ul id='backIcon' ><div><i class='fa fa-angle-left' style='color: #fff;top: 2px;font-size: 30px;    position: absolute;'></i></div></ul>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <h1 class="mui-title">事项查看</h1>

<%                 
                if("true".equals(hasDoc)){
                	%>
              <button class="mui-btn mui-btn-positive mui-pull-right">正文</button>
<%                	                	
                }
%>
			<script type="text/javascript">			
				//返回按钮点击事件
					document.getElementById('backIcon').addEventListener('tap', function() {
						var type = "<%=type%>";
	                	var parentId = "<%=parentId%>";
	                	if(type == 'archive'){   //文档列表查看
	                		if(parentId!='' && parentId!='null'){
	                			window.location.href = '<%=request.getContextPath() %>/mobile/archivedetail-list.jsp?type=archive&parentId='+parentId+'';
	                		}
	                	}else{
	                		if('app' == '${param.source }'){
								window.location.href = '<%=request.getContextPath() %>/mobile/app-list.jsp?type=createdApp&parentId=flowRoot';
							}else if('flow' == '${param.source }'){
								window.location.href = '<%=request.getContextPath() %>/mobile/flow-list.jsp?type=readyTask';
							}
	                	}
						
						
					});
			</script>
            </header>
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 42px;overflow:hidden;width:100%;height:100%;background-color:#FFFFFF;" onchange="">
	<div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
		<a id="form" class="mui-control-item mui-active" href="#item3mobile">
				表单
			</a>
		<a id="comment" class="mui-control-item" href="#item3mobile">
				意见	
			</a>
		<a id="attach" class="mui-control-item" href="#item3mobile">
				附件	
			</a>
	</div>
	
			
			   
			<div id="loadingInfo" class="scroll-wrapper" style="text-align:center;top:50px;height:100%;">
				 <iframe id="content" style="width: 100%; height: 100%; border:0;" ></iframe> 
			</div>

		</div>
		</div>
			
</div>			
		<script type="text/javascript">
				 var operation = "<%=operation%>";
	             if(operation == 'display'){
	             	document.getElementById('headTitle').style.display = 'none';
	             	document.getElementById('datalist').style.top = '0px';
	             }
		
		</script>	
	</body>

</html>