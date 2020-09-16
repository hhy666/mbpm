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
				<script src="<%=request.getContextPath() %>/resource/mobile/common.js"></script>
		
		<script src="<%=request.getContextPath() %>/resource/mobile/matrix_mobile.js"></script>
		<script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath() %>';
</script>	
		
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/public.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/mui.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/matrix-base.css" />
<% 
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
	if(fdid == null)
		fdid = "";
	String platId = request.getParameter("platId");
	String viewFlag = request.getParameter("matrix_view_flag");
	
%>		
		<script>
		 
		  function closeLoading(){
		    
		  	document.getElementById("loadingSpace").style.display="none";
		  	document.getElementById("loadingInfo").style.display="none";
		  	document.getElementById("content").style.display="block";
		  }
		  
		  
		</script>
		<%
		//System.out.println("/MobileFlowForm.rform?formId="+fdid+"&mBizId="+platId+"&piid="+piid+"&ptid="+ptid+"&taskId="+taskId+"&pdid="+pdid+"&mFlowBizId="+mBizId+"&atid="+atid+"&aiid="+aiid+"&adid="+adid);
		%>
			<script>
			
			function init(){
			
		      //监听标签切换
			document.getElementById('form').addEventListener('tap',function(){
				var url = "<%=request.getContextPath() %>/MobileFlowForm.rform?formId=<%=fdid%>&mBizId=<%=platId%>&piid=<%=piid%>&ptid=<%=ptid%>&taskId=<%=taskId%>&pdid=<%=pdid%>&mFlowBizId=<%=mBizId%>&atid=<%=atid%>&aiid=<%=aiid%>&adid=<%=adid%>&matrix_view_flag=<%=viewFlag%>";
				if("null" == '<%=fdid%>' || "CkeditorList" == '<%=fdid%>' || 'EditCkEditor' == '<%=fdid%>'){
					url = "<%=request.getContextPath() %>/TextFlowForm.rform?formId=<%=fdid%>&mBizId=<%=platId%>&piid=<%=piid%>&ptid=<%=ptid%>&taskId=<%=taskId%>&pdid=<%=pdid%>&mFlowBizId=<%=mBizId%>&atid=<%=atid%>&aiid=<%=aiid%>&adid=<%=adid%>&matrix_view_flag=<%=viewFlag%>";
					
				}	
		       document.getElementById("content").src=url;
   		   });

			document.getElementById('comment').addEventListener('tap',function(){
	           var url = "<%=request.getContextPath() %>/office/flow/OpinionList.jsp?is_mobile=true&piid=<%=piid%>";
		       document.getElementById("content").src=url;

 			});

			document.getElementById('attach').addEventListener('tap',function(){
	           var url = "<%=request.getContextPath() %>/office/flow/AttachList.jsp?mFlowBizId=<%=mBizId%>";
		       document.getElementById("content").src=url;
			});
		
		var url2 = "<%=request.getContextPath() %>/MobileFlowForm.rform?formId=<%=fdid%>&mBizId=<%=platId%>&piid=<%=piid%>&ptid=<%=ptid%>&taskId=<%=taskId%>&pdid=<%=pdid%>&mFlowBizId=<%=mBizId%>&atid=<%=atid%>&aiid=<%=aiid%>&adid=<%=adid%>&matrix_view_flag=<%=viewFlag%>";
		if("null" == '<%=fdid%>' || "CkeditorList" == '<%=fdid%>' || 'EditCkEditor' == '<%=fdid%>')
			url2 = "<%=request.getContextPath() %>/TextFlowForm.rform?formId=<%=fdid%>&mBizId=<%=platId%>&piid=<%=piid%>&ptid=<%=ptid%>&taskId=<%=taskId%>&pdid=<%=pdid%>&mFlowBizId=<%=mBizId%>&atid=<%=atid%>&aiid=<%=aiid%>&adid=<%=adid%>&matrix_view_flag=<%=viewFlag%>";

       document.getElementById("content").src=url2;
		}	
			
		</script>
	</head>

	<body onload="init();" class="mui-fullscreen" >
	        
             <!-- 侧滑导航根容器 -->
    <div class="mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
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
                <a class="mui-icon mui-action-back mui-pull-left"></a>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <h1 class="mui-title">任务执行</h1>

<%                 
                if("true".equals(hasDoc)){
                	%>
              <button class="mui-btn mui-btn-positive mui-pull-right">正文</button>
<%                	                	
                }
%>
            </header>
           <br>
           <br>
            
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 42px;overflow:hidden;width:100%;height:100%;background-color:#FFFFFF;" onchange="">
	<div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
		<a id="form" class="mui-control-item mui-active" href="#item3mobile">
				表单
			</a>
		<a id="comment" class="mui-control-item" href="#item3mobile">
				意见	
			</a>
		<a id="attach" class="mui-control-item" href="#item3mobile">
				正文附件	
			</a>
	</div>
	
<!-- 			   <div id="loadingSpace" style="height:50px;"></div>  -->
			   
			   
			<div id="loadingInfo" style="text-align:center;top:50px;"></div>
		
				 <iframe id="content" style="width: 250vw; height: 250vh;;border:0;transform: scale(0.4);transform-origin: 0 0;" ></iframe> 
			</div>
			<div style="height:30px;"/>
		</div>
		</div>
			
</div>			
			</div>	
	</body>

</html>