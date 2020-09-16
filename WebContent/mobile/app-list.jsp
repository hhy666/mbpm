<!DOCTYPE html>
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
<div id='matrixMask' name='matrixMask' style="background:#000; filter:alpha(opacity:0); opacity:0;" class='loading'></div>	        

    <div class="mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
         <!-- 侧滑菜单导航容器 -->
        <%@ include file="/mobile/menu-list.jsp"%>
        
        
		<div class="mui-inner-wrap">
		<div class="mui-content">
		 <header class="mui-bar mui-bar-nav">
                <ul id='backIcon'><div><i class='fa fa-angle-left' style='color: #fff;top: 2px;font-size: 30px;    position: absolute;'></i></div></ul>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <a id="searchAction" href="#offCanvasSide" class="mui-icon mui-action-search mui-icon-search mui-pull-right"></a>
                <h1 class="mui-title">协同事项</h1>
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
		<a id="newApp2" class="mui-control-item mui-active" href="#item3mobile">
				新建事项
			</a>
		<a id="createdApp" class="mui-control-item" href="#item3mobile">
				已发事项
			</a>
	</div>
	<br>
	<br>
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top:82px;" onchange="">
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
		   document.getElementById('newApp2').style.display = 'none';   //隐藏掉待发事项
		  
		   var type = "";
		   var parentId = "";
		   function initParam(){
	   	      type = matrix.getParam("type");
	   	      parentId = matrix.getParam("parentId");
		   }
		   window.onload = initParam();
		   
			var dataType = null;//列表数据类型
			var pullType = null;
			var first = true;
			
			//监听前一页点击
			document.getElementById('searchAction').addEventListener('tap',function(){
			    var value = document.getElementById('searchContent').style.display;
			    if(value == "none"){
					document.getElementById('searchContent').style.display="block";
					document.getElementById('datalist').style.top="72px";
				}else{	
					document.getElementById('searchContent').style.display="none";
					document.getElementById('datalist').style.top="42px";
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
			   
			   //如果当前已经是最后一行,什么也不做
			   if(totalPageNumValue != 0 && (totalPageNumValue <= startNum)){
			   		return;
			   	}	

			   document.getElementById("startNum").value = startNum;

	           clearData();
				pullupRefresh();
				
			});
			
			 //监听标签切换
		
			document.getElementById('newApp2').addEventListener('tap',function(){
			   type = "newApp";
			   parentId = "flowRoot";
			   var startNumValue = 0; 
			   document.getElementById("startNum").value = startNumValue;
			   
	           clearData();
				pullupRefresh();
			});
		
			document.getElementById('createdApp').addEventListener('tap',function(){
			   type = "createdApp";
			   var startNumValue = 0; 
			   document.getElementById("startNum").value = startNumValue;
	           clearData();
				pullupRefresh();
			});
			
			function newAppList(catalogId){
				type = "newApp";
				parentId = catalogId;
				clearData();
				loadData();
			}
			
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

				//var startNum = 0;
				//if(cells!=null && cells.length>0){
					//startNum = cells.length-1;
				//}
				var startNum = document.getElementById("startNum").value;
				
				dataType = type;
				if(dataType=="newCatalog"){
					//申请事项queryMyApplyItems
					var data = {};
					data["queryStartNum"] = startNum * matrix.DEFAULT_PAGE_SIZE;
//					data["queryStartNum"] = startNum * matrix.DEFAULT_PAGE_SIZE + 1;
					data["queryPageSize"] = matrix.DEFAULT_PAGE_SIZE;
					data["parentId"] = parentId;
					if(document.getElementById("queryKeyword").value!=null){
						data["queryKeyword"] = document.getElementById("queryKeyword").value;
					}
					matrix.sendRequest("<%=request.getContextPath()%>/mobile/apply_queryNewCatalogs.action",data,loadDataCallback);
					
				}else if(dataType=="newApp"){
					matrix.showMask();
				matrix.log("load page data .....newApp");
					//我的申请
					var data = {};
					data["queryStartNum"] = startNum * matrix.DEFAULT_PAGE_SIZE;
					data["queryPageSize"] = matrix.DEFAULT_PAGE_SIZE;
					data["parentId"] = parentId;
					if(document.getElementById("queryKeyword").value!=null){
						data["queryKeyword"] = document.getElementById("queryKeyword").value;
					}
					matrix.sendRequest("<%=request.getContextPath()%>/mobile/apply_queryNewApps.action",data,loadDataCallback);
				
				}else if(dataType=="createdApp"){
					matrix.showMask();
				matrix.log("load page data .....createdApp");
				
					//我的申请
					var data = {};
					data["queryStartNum"] = startNum * matrix.DEFAULT_PAGE_SIZE;
					data["queryPageSize"] = matrix.DEFAULT_PAGE_SIZE;
					if(document.getElementById("queryKeyword").value!=null){
						data["queryKeyword"] = document.getElementById("queryKeyword").value;
					}
					matrix.sendRequest("<%=request.getContextPath()%>/mobile/apply_queryCreatedApps.action",data,loadDataCallback);
				
				}else{
					setTimeout(function() {
						mui('#datalist').pullRefresh().endPullupToRefresh((true));
					}, 1000);
				}
			}
			
			//加载数据回调方法
			function loadDataCallback(response){
				
				if(response!=null && response.data!=null){
					var table = document.body.querySelector('.mui-table-view');
					var data = response.data;
					if(pullType==null || pullType=="up"){
						setTimeout(function() {
							for (var i = 0, len = data.length; i < len; i++) {
									var record = data[i];
									//上拉刷新，新纪录插到最后面；
									//matrix.log(record.templateName);
									if(record.piid || record.templateName)
										table.appendChild(getRecordHTML(record));
							}
							//设置当前页和总页数
							//var pageInfo = "";
							var curPageNum = response.curPageNum;
							var totalPageNum = response.totalPageNum;
							
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

							document.getElementById("page-info").innerText = "第"+(curPageNum)+"页/共"+totalPageNum+"页";
							document.getElementById("totalPageNum").value = totalPageNum;
						}, 1000);
					}else if(pullType=="down"){
						//下拉刷新，新纪录插到最前面；
							setTimeout(function() {
								for (var i = 0, len = data.length; i < len; i++) {
									var row = data[i];
									var li = document.createElement('li');
									li.className = 'mui-table-view-cell';
									li.innerHTML = '<a class="mui-navigate-right">' +row.title+'</a>';
									//下拉刷新，新纪录插到最前面；
									table.insertBefore(li, table.firstChild);

								}
								mui('#datalist').pullRefresh().endPulldownToRefresh(); //refresh completed\n
								if(data.length == 0){
									document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "没有更多数据了";
								}else{
									document.getElementById("mui-scroll").children[1].children[0].children[1].innerHTML = "";
								}
							}, 1000);
					}
				}
				matrix.hideMask();
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
                contentrefresh: "正在加载...", //可选，正在加载状态时，上拉加载控件上显示的标题内容
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
				var recordStr = "";
				if(dataType=="newCatalog"){
					//待办任务
					var exeUrl = "mobile/app-list.jsp?type=newApp&parentId"+record.mBizId;
					exeUrl = matrix.convertRequestUrl(exeUrl);
					//var exeUrl = "javascript:newAppList('"+record.mBizId+"');";//查看url
					
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell ';
					
					var row_title = document.createElement('a');
					row_title.className = "mui-navigate-right";
					row_title.href = exeUrl;
					//row_title.innerHTML = record.desc;
					row.appendChild(row_title);
					
					//图片
					var img = document.createElement('img');
					img.className = "mui-media-object mui-pull-left";
					img.setAttribute("style","max-width:29px;height:29px");
					img.src = "<%=request.getContextPath() %>/resource/mobile/pic1.jpg";
					row_title.appendChild(img);
					
					var contentDiv = document.createElement('div');
					contentDiv.className = "mui-media-body";
					row_title.appendChild(contentDiv);
					
					var nameSpan = document.createElement('b');
					//nameDiv.className = "mui-media-body";
					nameSpan.innerHTML = record.templateName;
					contentDiv.appendChild(nameSpan);
					return row;
					
				}else if(dataType=="newApp"){
					//发起流程单
					var exeUrl = "";//执行url
					exeUrl+="<%=request.getContextPath()%>/StartFlowForm.rform?fdid=";
					exeUrl+=record.fdid;
					exeUrl+="&pdid="+record.flowUuid;
					exeUrl+="&adid="+record.adid;
					exeUrl+="&formId="+record.fdid;
					exeUrl+="&mBizId="+record.mBizId;
					exeUrl+="&platId="+record.mBizId;
					exeUrl+="&mHtml5Flag=true";
					
					exeUrl = matrix.convertRequestUrl(exeUrl);
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell ';
					
					var row_title = document.createElement('a');
					row_title.className = "mui-navigate-right";
					row_title.href = exeUrl;
					//row_title.innerHTML = record.desc;
					row.appendChild(row_title);
					
					//图片
					var img = document.createElement('img');
					img.className = "mui-media-object mui-pull-left";
					img.setAttribute("style","max-width:29px;height:29px");
					var imgsrc = "<%=request.getContextPath()%>/resource/mobile/newWork.png";
					img.src = matrix.convertRequestUrl(imgsrc);
					row_title.appendChild(img);
					
					var contentDiv = document.createElement('div');
					contentDiv.className = "mui-media-body";
					row_title.appendChild(contentDiv);
					
					var nameSpan = document.createElement('b');
					//nameDiv.className = "mui-media-body";
					nameSpan.innerHTML = record.templateName;
					contentDiv.appendChild(nameSpan);


					return row;
				}else if(dataType=="createdApp"){
										//已发事项			
					var isCustom = record.isCustom;  //移动表单类型   1：原表单   2.自定义   3.不支持
					
					var exeUrl = "";
					exeUrl+="<%=request.getContextPath() %>/mobile/viewItem.jsp?fdid=";
					if(isCustom == '2'){
						exeUrl+=record.fdid + "_mobile";
					}else{
						exeUrl+=record.fdid;
					}	
				
					exeUrl+="&pdid="+record.pdid;
					exeUrl+="&adid="+record.adid;
					exeUrl+="&piid="+record.piid;
					exeUrl+="&type="+record.type;
					if(isCustom == '2'){
						exeUrl+="&formId="+record.fdid + "_mobile";
					}else{
						exeUrl+="&formId="+record.fdid;
					}	
					exeUrl+="&mBizId="+record.uuid;
					exeUrl+="&isMobile=true";
					exeUrl+="&matrix_view_flag=true";
					exeUrl+="&source=app";
					exeUrl = matrix.convertRequestUrl(exeUrl);
					
					var monitorUrl = "<%=request.getContextPath() %>/mobile/process-monitor.jsp?piid=";
					monitorUrl+=record.piid;
					monitorUrl = matrix.convertRequestUrl(monitorUrl);
	
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell mui-collapse mrow';
					
					var row_title = document.createElement('a');
					row_title.className = "mui-navigate-right";
					row_title.href = "#";
					//row_title.innerHTML = record.desc;
					row.appendChild(row_title);
					
					var img = document.createElement('img');
					img.className = "mui-media-object mui-pull-left";
					img.setAttribute("style","max-width:29px;height:29px");
					var imgsrc = "<%=request.getContextPath()%>/resource/mobile/yifa.png";
					img.src = matrix.convertRequestUrl(imgsrc);
					row_title.appendChild(img);
					
					var contentDiv = document.createElement('div');
					contentDiv.className = "mui-media-body";
					row_title.appendChild(contentDiv);
					
					var nameSpan = document.createElement('b');
					//nameDiv.className = "mui-media-body";
					nameSpan.innerHTML = record.title;
					contentDiv.appendChild(nameSpan);

					var userDiv = document.createElement('div');
					userDiv.className = "mui-media-body";
					row_title.appendChild(userDiv);

					var dateSpan = document.createElement('span');
					dateSpan.setAttribute("style","float:right;");
					dateSpan.innerHTML = record.startTime;
					userDiv.appendChild(dateSpan);
					
					var menu = document.createElement('ul'); 
					menu.className = "mui-table-view mui-table-view-chevron";
					row.appendChild(menu);
					
					var menu_item0 = document.createElement('li');
					menu_item0.className = "mui-table-view-cell";
					menu.appendChild(menu_item0);
					
					if(isCustom == 3){					
						var a_menu_item0 = document.createElement('a');
						a_menu_item0.className = "mui-navigate-right";
						a_menu_item0.href = "#";
						a_menu_item0.innerHTML = "查看(不支持移动表单)";
						a_menu_item0.setAttribute("style","color:red;");
						a_menu_item0.setAttribute("open-type","common-embed");
						a_menu_item0.setAttribute("headerTitle","查看(不支持移动表单)");
					}else{
						var a_menu_item0 = document.createElement('a');
						a_menu_item0.className = "mui-navigate-right";
						a_menu_item0.href = exeUrl;
						a_menu_item0.innerHTML = "查看";
						a_menu_item0.setAttribute("open-type","common-embed");
						a_menu_item0.setAttribute("headerTitle","查看");		
					}
					
					menu_item0.appendChild(a_menu_item0);
					
					//èåé¡¹-çæ§
					var menu_item1 = document.createElement('li');
					menu_item1.className = "mui-table-view-cell";
					menu.appendChild(menu_item1);
					
					//èåé¡¹-çæ§-é¾æ¥
					var a_menu_item1 = document.createElement('a');
					a_menu_item1.className = "mui-navigate-right";
					a_menu_item1.href = monitorUrl;
					a_menu_item1.innerHTML = "监控";
					a_menu_item1.setAttribute("open-type","common-embed");
					a_menu_item1.setAttribute("headerTitle","监控");
					menu_item1.appendChild(a_menu_item1);
					return row;
				}
				return recordStr;
			}
			
			
		</script>
		
	</body>

</html>