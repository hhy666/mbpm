<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
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
		<style>
			.mrow{}
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
                <a id="searchAction" href="#offCanvasSide" class="mui-icon mui-action-search mui-icon-search mui-pull-right"></a>
                <h1 id="title" class="mui-title">文档中心</h1>
                <script type="text/javascript">
					//返回按钮点击事件
					document.getElementById('backIcon').addEventListener('tap', function() {					
						window.location.href = '<%=request.getContextPath() %>/mobile/archive-list.jsp?type=catalog&parentId=root';								
					});
				</script>
            </header>
			<div id="searchContent" class="mui-input-row mui-search" style="top: 42px;z-index:999;display:none;">
			    <input  id="startNum" type="hidden" value="0">
			    <input  id="totalPageNum" type="hidden" value="0">
				<input  id="queryKeyword" type="search" class="mui-input-clear mui-pull-left" placeholder="查询">
			</div>
		<br>
	<br>
	
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 42px;" onchange="">
				<div class="mui-scroll">
					<ul id="datatable" class="mui-table-view mui-table-view-chevron"></ul>
				</div>
			</div>
            <div class="mui-backdrop" style="display:none;"></div>
			
			<footer class="mui-bar .mui-bar-footer" style="bottom:0px;text-align:center;">
  <ul class="mui-pager">
		<li>
			<a id="page-pre" href="#">
					上一页
				</a>
		</li>
		<li id="page-info">
					第1页/共 页
		</li>
		<li>
			<a id="page-next" href="#">
					下一页
				</a>
		</li>
		
	</ul>
  <span  class="mui-action mui-action-previous mui-icon mui-icon-back"></span>
  <span class="mui-number">1/2</span>
		<span class="mui-action mui-action-next mui-icon mui-icon-forward"></span>
            </footer>


		</div>
		</div>
		
		</div>
		<script>
			
		
		   var type = "";
		   var parentId = "";
		   function initParam(){
	   	      type = matrix.getParam("type");
	   	      parentId = matrix.getParam("parentId");
		   }

		   window.onload = initParam();
		   
			var dataType = null;
			var pullType = null;
			var first = true;
			
			
			document.getElementById('searchAction').addEventListener('tap',function(){
			    var value = document.getElementById('searchContent').style.display;
			    if(value == "none"){
					document.getElementById('searchContent').style.display="block";
					document.getElementById('datalist').style.top="82px";
				}else{	
					document.getElementById('searchContent').style.display="none";
					document.getElementById('datalist').style.top="42px";
				}	
			});	

			document.getElementById('page-pre').addEventListener('tap',function(){
			   var startNumValue = document.getElementById("startNum").value;
			   if(startNumValue == 0)
			   		return;

			   var startNum = parseInt(startNumValue) - 1;
			   document.getElementById("startNum").value = startNum;
				
	           clearData();
				pullupRefresh();
			});
		
			document.getElementById('page-next').addEventListener('tap',function(){
			   var startNumValue = document.getElementById("startNum").value;
			   var totalPageNumValue = document.getElementById("totalPageNum").value;
			   
			   var startNum = parseInt(startNumValue) + 1;
			   
			   if(totalPageNumValue != 0 && (totalPageNumValue <= startNum)){
			   		return;
			   	}	
			   	
			   document.getElementById("startNum").value = startNum;

	           clearData();
				pullupRefresh();
				
			});
		
			document.getElementById('page-next').addEventListener('tap',function(){
			   var startNumValue = document.getElementById("startNum").value;
			   var totalPageNumValue = document.getElementById("totalPageNum").value;
			   
			   if(totalPageNumValue != 0 && (totalPageNumValue == (startNumValue+1) ))
			   		return;

			   startNumValue = parseInt(startNumValue) + 1;
			   document.getElementById("startNum").value = startNumValue;

	           clearData();
				pullupRefresh();
			   
			});
		
			function initData(){
				  first = true;
				  clearData();
				  mui('#datalist').pullRefresh().endPullupToRefresh(false);
				  mui('#datalist').pullRefresh().pullupLoading();
				  mui('#datalist').pullRefresh().endPullupToRefresh(true);
			}
			
			function clearData(){
				  var table = document.body.querySelector('.mui-table-view');
				  while(table.hasChildNodes()){
				      table.removeChild(table.lastChild);
				  }
			}
			
			function loadData(){
				
			
				matrix.log("load page data .....");
				var table = document.body.querySelector('.mui-table-view');
				var cells = document.body.querySelectorAll('.mui-table-view-cell');
				//var startNum = 0;
				//if(cells!=null && cells.length>0){
					//startNum = cells.length-1;
				//}
				var startNum = document.getElementById("startNum").value;
				
				dataType = type;
				if(dataType=="archive"){
					var data = {};
					data["queryStartNum"] = startNum * matrix.DEFAULT_PAGE_SIZE;
					data["queryPageSize"] = matrix.DEFAULT_PAGE_SIZE;
					data["parentId"] = parentId;
					if(document.getElementById("queryKeyword").value!=null){
						data["queryKeyword"] = document.getElementById("queryKeyword").value;
					}
					matrix.sendRequest("<%=request.getContextPath()%>/mobile/archive_queryArchives.action",data,loadDataCallback);
				
				}else{
					setTimeout(function() {
						mui('#datalist').pullRefresh().endPullupToRefresh((true));
					}, 1000);
				}
			}
			
			function loadDataCallback(response){
				matrix.log("load page data call back .....");
				if(response!=null && response.data!=null){
					var table = document.body.querySelector('.mui-table-view');
					var data = response.data;
					var totalPageNumValue = response.totalPageNum;
					
					if(pullType==null || pullType=="up"){
						setTimeout(function() {
							for (var i = 0, len = data.length; i < len; i++) {
									var record = data[i];
									table.appendChild(getRecordHTML(record));
							}
							//var pageInfo = "";
							var curPageNum = response.curPageNum;
							var totalPageNum = response.totalPageNum;
							document.getElementById("page-info").innerText = "第"+(curPageNum)+"页/共"+totalPageNum+"页";
							document.getElementById("totalPageNum").value = totalPageNum;
							
							if(first){
								var cells = document.body.querySelectorAll('.mrow');
								
								if(cells.length<matrix.DEFAULT_PAGE_SIZE){
									matrix.log(1111);
									mui('#datalist').pullRefresh().endPullupToRefresh(true); 
								}
								first = false;
							}else{
								mui('#datalist').pullRefresh().endPullupToRefresh((data.length==0));
							}
						}, 1000);
					}else if(pullType=="down"){
							setTimeout(function() {
								for (var i = 0, len = data.length; i < len; i++) {
									var row = data[i];
									var li = document.createElement('li');
									li.className = 'mui-table-view-cell';
									li.innerHTML = '<a class="mui-navigate-right">' +row.title+'</a>';
									table.insertBefore(li, table.firstChild);
								}
								mui('#datalist').pullRefresh().endPulldownToRefresh(); //refresh completed\n
								
							}, 1000);
					}
					
				
				}
			}
			
			/**
			 */
			function pulldownRefresh() {
					pullType = "down";
					loadData();
			}
			
			/**
			 */
			function pullupRefresh() {
				matrix.log("pull up refresh .....");
				pullType = "up";
				loadData();
			}
			
			mui.init({
			
			
				swipeBack: false,
				pullRefresh: {
					container: '#datalist',
//					down: {
//						callback: pulldownRefresh
//					},
					up: {
                contentrefresh: "正在加载...", //å¯éï¼æ­£å¨å è½½ç¶ææ¶ï¼ä¸æå è½½æ§ä»¶ä¸æ¾ç¤ºçæ é¢åå®¹
						callback: pullupRefresh
					}
				}
			});
			
			document.getElementById("queryKeyword").addEventListener('keyup', function(e) {
				//console.log(e.which || e.keyCode);
				var keyCode = (e.which || e.keyCode);
				if(keyCode==13){
				   document.getElementById("startNum").value = 0;
				  initData();
				}
			});
			
			if (mui.os.plus) {
				mui.plusReady(function() {
					setTimeout(function() {
						mui('#datalist').pullRefresh().pullupLoading();
					}, 1000);
				});
			} else {
				mui.ready(function() {
					mui('#datalist').pullRefresh().pullupLoading();
				});
				
			}
			
			/*注:
			c_type    1:文档   2.文档夹  3.归档的文档
			c_archive_type   1 word 2 execl 3 html 4.附件文档
			c_main_type   1.非关联文档    2.关联文档
			c_subType   1.公文  2.文档  3.协同  4.归档新闻  5.归档公告 
			*/
			function getRecordHTML(record){
				var type = record.type;    //1:文档   2.文档夹  3.归档的文档
				var mainType = record.mainType;   //主类型  1.非关联文档    2.关联文档
				var subType = record.subType;    //子类型  1.公文  2.文档  3.协同  4.归档新闻  5.归档公告
				var archiveType = record.archiveType;  //不是关联文档时并且是文档类型时 (mainType==1 && subType==2)又分    1. word 2.execl 3.html 4.附件文档
				
				if(dataType=="archive"){   //文档列表
					var exeUrl = "";
					if(type == 1 || type == 3){ //普通文档    归档的文档(新闻或公告归档)
					    if(mainType == 2){ //关联文档(包含普通协同和新闻公告)
					    	exeUrl+="<%=request.getContextPath()%>"+record.lookUrl;
					    	exeUrl+="&type=archive&parentId="+parentId+"";
					    }else{	//非关联文档(html文档或附件文档)
							exeUrl+="<%=request.getContextPath()%>/mobile/archive.jsp?";
							exeUrl+="uuid=";
							exeUrl+=record.uuid;
							exeUrl+="&archiveType="+archiveType+"&parentId="+parentId+"&isMobile=true";
					    }
					    exeUrl = matrix.convertRequestUrl(exeUrl);
					}else if(type == 2){ //文档夹(没有文档夹了 不需要了)
						exeUrl+="<%=request.getContextPath()%>/mobile/archive-list.jsp?type=archive&parentId=";
						exeUrl+=record.uuid;
					}
					
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell mui-collapse mrow';
					
					var row_title = document.createElement('a');
					row_title.className = "mui-navigate-right";
					row_title.href = exeUrl;
					//row_title.innerHTML = record.desc;
					row.appendChild(row_title);
					
					var img = document.createElement('img');
					img.className = "mui-media-object mui-pull-left";
					//文件夹图标
					var imgsrc = "<%=request.getContextPath()%>/resource/mobile/catalog.png";   
					if(type!=2){    //非文档夹
						//文档图标
						imgsrc = "<%=request.getContextPath()%>/resource/mobile/doc.jpg";   
					}
					img.src = matrix.convertRequestUrl(imgsrc);
					row_title.appendChild(img);
					
					var contentDiv = document.createElement('div');
					contentDiv.className = "mui-media-body";
					row_title.appendChild(contentDiv);
					
					var nameSpan = document.createElement('b');
					//nameDiv.className = "mui-media-body";
					nameSpan.innerHTML = record.name;
					contentDiv.appendChild(nameSpan);

					if(type!=2){    //非文档夹
						var userDiv = document.createElement('div');
						userDiv.className = "mui-media-body";
						row_title.appendChild(userDiv);
	
						var nameSpan = document.createElement('span');
						nameSpan.innerHTML = record.createDate;
						userDiv.appendChild(nameSpan);
						
						var dateSpan = document.createElement('span');
						dateSpan.setAttribute("style","float:right;");
						dateSpan.innerHTML = record.archiveSize+"k";
						userDiv.appendChild(dateSpan);
					}
					return row;
					
				}
			}
			
			
		</script>
		
	</body>

</html>