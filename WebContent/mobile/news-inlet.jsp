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
<div id='matrixMask' name='matrixMask' style="background:#000; filter:alpha(opacity:0); opacity:0;display:none;" class='loading'></div>	        
    <div class="mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
      <!-- 侧滑菜单导航容器 -->
        <%@ include file="/mobile/menu-list.jsp"%>
        
	<div class="mui-inner-wrap">
		<div class="mui-content">
		 <header class="mui-bar mui-bar-nav">
                <ul id='backIcon' ><div><i class='fa fa-angle-left' style='color: #fff;top: 2px;font-size: 30px;    position: absolute;'></i></div></ul>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <a id="searchAction" href="#offCanvasSide" class="mui-icon mui-action-search mui-icon-search mui-pull-right"></a>
                <h1 class="mui-title">新闻</h1>
                <script type="text/javascript">
					//返回按钮点击事件
						document.getElementById('backIcon').addEventListener('tap', function() {
								window.location.href = '<%=request.getContextPath() %>/mobile/home.jsp';
						});
				</script>
            </header>
			<div id="searchContent" class="mui-input-row mui-search" style="top: 42px;z-index:999;display:none;">
			    <input  id="startNum" type="hidden" value="0">
			    <input  id="totalPageNum" type="hidden" value="0">
				<input  id="queryKeyword" type="search" class="mui-input-clear mui-pull-left" placeholder="请输入关键字查询">
			</div>
			<div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted" style="top:42px;">
		<a id="newslist" class="mui-control-item" href="#item3mobile">
				所有新闻
			</a>
		<a id="newscolumn" class="mui-control-item" href="#item3mobile">
				新闻栏目
			</a>
	</div>
	<br>
	<br>
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 82px;" onchange="">
				<div id="mui-scroll" class="mui-scroll">
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
		   function initParam(){
	   	      type = matrix.getParam("type");
	   	      var newslist = document.getElementById('newslist');
	   	      var newscolumn = document.getElementById('newscolumn');
	   	      if(type == 'newslist'){
	   	    	 newslist.classList.add('mui-active');
	   	      }else if(type == 'newscolumn'){
	   	    	newscolumn.classList.add('mui-active');
	   	      }
		   }
		   window.onload = initParam();
		   
			var dataType = null;//列表数据类型
			var pullType = null;
			var first = true;
			
			//监听前一页点击
			document.getElementById('searchAction').addEventListener('tap',function(){
			    var value = document.getElementById('searchContent').style.display;
			    if(value == "none"){
					document.getElementById('searchContent').style.display="block";
					
					//document.getElementById('sliderSegmentedControl').style.top="82px";
					//document.getElementById('datalist').style.top="122px";
				}else{	
					document.getElementById('searchContent').style.display="none";
					//document.getElementById('sliderSegmentedControl').style.top="42px";
					//document.getElementById('datalist').style.top="82px";
				}	
			});	
			
			//监听前一页点击
			document.getElementById('page-pre').addEventListener('tap',function(){
			   var startNumValue = document.getElementById("startNum").value;
			   if(startNumValue == 0)
			   		return;

			   var startNum = parseInt(startNumValue) - 1;
			   document.getElementById("startNum").value = startNum;
				
	           clearData();
				pullupRefresh();
			});
		
		    //监听后一页点击
			document.getElementById('page-next').addEventListener('tap',function(){
			   var startNumValue = document.getElementById("startNum").value;
			   var totalPageNumValue = document.getElementById("totalPageNum").value;
			   
			   var startNum = parseInt(startNumValue) + 1;
			   
			    //如果当前已经是最后一行,什么也不做
			   if(totalPageNumValue != 0 && (totalPageNumValue <= startNum)){
			   		return;
			   	}	

			   document.getElementById("startNum").value = startNum;

	           clearData();
				pullupRefresh();
				
			});
			
			//监听标签切换
			document.getElementById('newslist').addEventListener('tap',function(){
			   type = "newslist";
			   var startNumValue = 0; 
			   document.getElementById("startNum").value = startNumValue;
			   
	           clearData();
				pullupRefresh();
			});
			document.getElementById('newscolumn').addEventListener('tap',function(){
				type = "newscolumn";
				var startNumValue = 0; 
				document.getElementById("startNum").value = startNumValue;
				   
		        clearData();
				pullupRefresh();
			});
		
			//初始数据
			function initData(){
				  first = true;
				  clearData();
				  //加载
				  mui('#datalist').pullRefresh().endPullupToRefresh(false);
				  mui('#datalist').pullRefresh().pullupLoading();
				  mui('#datalist').pullRefresh().endPullupToRefresh(true);
				  document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "";
			}
			
			//清空原有数据
			function clearData(){
				  var table = document.body.querySelector('.mui-table-view');
				  while(table.hasChildNodes()){
				      table.removeChild(table.lastChild);
				  }
			}
			
			//加载数据
			function loadData(){
			
				matrix.log("load page data .....");
				
				document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "正在加载...";
				
				var table = document.body.querySelector('.mui-table-view');
				var cells = document.body.querySelectorAll('.mui-table-view-cell');
				var startNum = document.getElementById("startNum").value;
				
				dataType = type;
				if(dataType=="newslist" ){        //新闻列表
					matrix.showMask();
					var data = {};
					data["queryStartNum"] = startNum * matrix.DEFAULT_PAGE_SIZE;
					data["queryPageSize"] = matrix.DEFAULT_PAGE_SIZE;
					data["queryType"] = dataType;
					if(document.getElementById("queryKeyword").value!=null){
						data["queryKeyword"] = document.getElementById("queryKeyword").value;
					}
					matrix.sendRequest("<%=request.getContextPath()%>/mobile/news_queryAllNews.action",data,loadDataCallback);

				}else if(dataType=="newscolumn"){    //新闻栏目
					matrix.showMask();
					var data = {};
					data["queryStartNum"] = startNum * matrix.DEFAULT_PAGE_SIZE;
					data["queryPageSize"] = matrix.DEFAULT_PAGE_SIZE;
					data["queryType"] = dataType;
					if(document.getElementById("queryKeyword").value!=null){
						data["queryKeyword"] = document.getElementById("queryKeyword").value;
					}
					matrix.sendRequest("<%=request.getContextPath()%>/mobile/news_queryCatalogs.action",data,loadDataCallback);

				}else{
					setTimeout(function() {
						mui('#datalist').pullRefresh().endPullupToRefresh((true));
					}, 1000);
				}
			}
			
			//加载数据回调方法
			function loadDataCallback(response){
				matrix.log("load page data call back .....");
				if(response!=null && response.data!=null){
					var table = document.body.querySelector('.mui-table-view');
					var data = response.data;
					if(pullType==null || pullType=="up"){
						setTimeout(function() {
							for (var i = 0, len = data.length; i < len; i++) {
									var record = data[i];
									//上拉刷新，新纪录插到最后面；
									table.appendChild(getRecordHTML(record));
							}
							//设置当前页和总页数
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
							if(data.length == 0){
								document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "没有更多数据了";
							}else{
								document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "";
							}
							
							matrix.hideMask();

						}, 1000);
					}else if(pullType=="down"){
						//下拉刷新，新纪录插到最前面；
							setTimeout(function() {
								for (var i = 0, len = data.length; i < len; i++) {
									var row = data[i];
									var li = document.createElement('li');
									li.className = 'mui-table-view-cell';
									li.innerHTML = '<a class="mui-navigate-right">' +row.title+'</a>';
									//下拉刷新，新纪录插到最前面；
									table.insertBefore(li, table.firstChild);
								}
								mui('#datalist').pullRefresh().endPulldownToRefresh(); //refresh completed\n
								if(data.length == 0){
									document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "没有更多数据了";
								}else{
									document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "";
								}
								matrix.hideMask();
							}, 1000);
					}
				}
			}
			
			/**
			 * 下拉刷新具体业务实现
			 */
			function pulldownRefresh() {
					pullType = "down";
					loadData();
			}
			
			/**
			 * 上拉加载具体业务实现
			 */
			function pullupRefresh() {
				matrix.log("pull up refresh .....");
				pullType = "up";
				document.getElementById('datalist').innerHtml="testtest";
				loadData();
			}
			
			mui.init({
			
			
				swipeBack: false,
				pullRefresh: {
					container: '#datalist',
					down: {
//                		contentrefresh:  "正在加载...", //可选，正在加载状态时，上拉加载控件上显示的标题内容
//						callback: pulldownRefresh
					},
					up: {
                		contentrefresh:  "正在加载...", //可选，正在加载状态时，上拉加载控件上显示的标题内容
						callback: pullupRefresh
					}
				}
			});
			
			//添加检索键监听
			document.getElementById("queryKeyword").addEventListener('keyup', function(e) {
				//console.log(e.which || e.keyCode);
				var keyCode = (e.which || e.keyCode);
				if(keyCode==13){
				  //检索键key值
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
			
			function getRecordHTML(record){
				if(dataType=="newslist"){    //新闻列表
					//å¾åä»»å¡
					var exeUrl = "";//æ§è¡url
					exeUrl+="<%=request.getContextPath()%>/mobile/news.jsp?";
					exeUrl+="mBizId=";
					exeUrl+=record.mBizId;
					exeUrl = matrix.convertRequestUrl(exeUrl);
					
					
					
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell mui-collapse mrow';
					
					var row_title = document.createElement('a');
					row_title.className = "mui-navigate-right";
					row_title.href = exeUrl;
//					row_title.href = "#";
					//row_title.innerHTML = record.desc;
					row.appendChild(row_title);
					
					//å¾ç
					var img = document.createElement('img');
					img.className = "mui-media-object mui-pull-left";
					var imgsrc = "<%=request.getContextPath()%>/resource/mobile/cover_5.png";
					img.src = matrix.convertRequestUrl(imgsrc);
					row_title.appendChild(img);
					
					var contentDiv = document.createElement('div');
					contentDiv.className = "mui-media-body";
					row_title.appendChild(contentDiv);
					
					var nameSpan = document.createElement('b');
					//nameDiv.className = "mui-media-body";
					nameSpan.innerHTML = record.name;
					contentDiv.appendChild(nameSpan);

					var userDiv = document.createElement('div');
					userDiv.className = "mui-media-body";
					row_title.appendChild(userDiv);

					var nameSpan = document.createElement('span');
					nameSpan.innerHTML = record.pubDepName;
					userDiv.appendChild(nameSpan);
					
					var dateSpan = document.createElement('span');
					dateSpan.setAttribute("style","float:right;");
					dateSpan.innerHTML = record.time;
					userDiv.appendChild(dateSpan);
					

					return row;
				}else if(dataType=="newscolumn"){  //新闻栏目
					//æ ç®
					var exeUrl = "<%=request.getContextPath()%>/mobile/news-list.jsp?type=news&parentId="+record.mBizId;
					//var exeUrl = "javascript:newsList('"+record.mBizId+"');";//æ¥çurl
					exeUrl = matrix.convertRequestUrl(exeUrl);
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell ';
					
					var row_title = document.createElement('a');
					row_title.className = "mui-navigate-right";
					row_title.href = exeUrl;
					//row_title.innerHTML = record.desc;
					row.appendChild(row_title);
					
					//å¾ç
					var img = document.createElement('img');
					img.className = "mui-media-object mui-pull-left";
					img.setAttribute("style","max-width:29px;height:29px");
					var imgsrc = "<%=request.getContextPath()%>/resource/mobile/news.png";
					img.src = matrix.convertRequestUrl(imgsrc);
					row_title.appendChild(img);
					
					var contentDiv = document.createElement('div');
					contentDiv.className = "mui-media-body";
					row_title.appendChild(contentDiv);
					
					var nameSpan = document.createElement('b');
					//nameDiv.className = "mui-media-body";
					nameSpan.innerHTML = record.name;
					contentDiv.appendChild(nameSpan);

					return row;
				}
			}
			
			
		</script>
		
	</body>

</html>