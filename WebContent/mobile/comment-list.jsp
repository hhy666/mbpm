<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
   	<script src="<%=request.getContextPath() %>/resource/mobile/mui.min.js"></script>
		<script src="<%=request.getContextPath() %>/resource/mobile/app.js"></script>
				<script src="<%=request.getContextPath() %>/resource/mobile/common.js"></script>
		
		<script src="<%=request.getContextPath() %>/resource/mobile/matrix_mobile.js"></script>
		
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/public.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/mui.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/mobile/matrix-base.css" />
		<style>
			.mrow{}
		</style>

   
	</head>

	<body>
	    <input type="hidden" value="${param.piid}">
		<div class="mui-content">
			<div id="datalist" class="mui-content mui-scroll-wrapper" onchange="">
				<div class="mui-scroll">
					<ul id="datatable" class="mui-table-view mui-table-view-chevron"></ul>
				</div>
			</div>
		</div>
		<script>
			var piid = null;
			var dataType = null;
			
			/**
			 * 上拉加载具体业务实现
			 */
			function pullupRefresh() {
				matrix.log("pull up refresh start....");
				pullType = "up";
				loadData();
			}
			
			mui.init({
				swipeBack: false,
				pullRefresh: {
					container: '#datalist',
					up: {
						contentrefresh: '正在加载......',
						callback: pullupRefresh
					}
				}
			});
			
			//初始数据
			function initData(){
				  clearData();
				  //加载
				  mui('#datalist').pullRefresh().endPullupToRefresh(false);
				  mui('#datalist').pullRefresh().pullupLoading();
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
				if(dataType=="comment"){
					//加载意见
					if(piid!=null){
						var data = {};
						var piid = document.getElementById("piid").value;
						data["piid"] = piid;
						data["isSubmit"] = 1;
						matrix.sendRequest("<%=request.getContextPath()%>/mobile/comment_queryComment.action",data,loadDataCallback);
					}
				}else if(dataType=="internalMessage"){
						//加载站内消息
						var data = {};
						matrix.sendRequest("<%=request.getContextPath()%>/mobile/message_queryInternalMessage.action",data,loadDataCallback);
				}
				
			}
			
			
			function getRecordHTML(record){
				
				if(dataType=="comment"){
					//处理意见
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell mui-media';
					
					var  rowBody = document.createElement('div');
					rowBody.className = "mui-media-body";
					row.appendChild(rowBody);
					
					var rowDesc = document.createElement('div');
					rowDesc.innerHTML = record.userName+"("+record.lastupdateDate+")";
					rowBody.appendChild(rowDesc);
					
					var rowDetail = document.createElement('p');
					rowDetail.className = "mui-ellipsis";
					rowDetail.innerHTML = (record.contentValue==null||record.contentValue=='null'||record.contentValue=="")?"无":record.contentValue;
					rowBody.appendChild(rowDetail);

					return row;
				}else if(dataType=="internalMessage"){
					//处理站内消息
					var row = document.createElement('li');
					row.className = 'mui-table-view-cell';
					
					var row_title = document.createElement('a');
					row_title.className = "mui-navigate-right";
					var isReaded = record.isReaded;
					if(isReaded==0){
						//未读
						row_title.innerHTML = "<div style='' >" +record.subjectValue+"("+record.createdDate+")"+ "</div>";
					}else{
						//已读
						row_title.innerHTML = record.subjectValue+"("+record.createdDate+")";
					}
					row_title.setAttribute("open-type","common-content");
					row_title.setAttribute("data-type","internalMessage");
					row_title.setAttribute("entityId",record.messageId);
					row_title.setAttribute("headerTitle","消息详情");
					row.appendChild(row_title);
					return row;
				}
				
					
			}
			
			//加载数据回调方法
			function loadDataCallback(response){
				if(response!=null && response.data!=null){
					matrix.log('load data callback.....');
					var table = document.body.querySelector('.mui-table-view');
					var data = response.data;
					setTimeout(function() {
						matrix.log('load data length....#'+data.length);
						for (var i = 0, len = data.length; i < len; i++) {
								var record = data[i];
								//上拉刷新，新纪录插到最后面；
								table.appendChild(getRecordHTML(record));
						}
						mui('#datalist').pullRefresh().endPullupToRefresh(true);
					}, 1500);
				}
			}
			
			//打开主页面窗口菜单
			var index = null;//主页面
			function openMenu () {
				!index&&(index = mui.currentWebview.parent());
				mui.fire(index,"menu:open");	
			}

			

			if (mui.os.plus) {
				mui.plusReady(function() {
					setTimeout(function() {
						initTemplates();
					}, 1000);
				});
			} else {
				mui.ready(function() {
					initTemplates();
				});
				
			}
			
			mui('#datatable').on('tap', 'a', function() {
				var id = this.getAttribute('href');
				if(id=="#"){
					return;
				}
				var type = this.getAttribute("open-type");
				var title = this.getAttribute("headerTitle");
				if(type=="common-content"){
					//获得模板
					var template = getTemplate('common-list');
					var commonList = template.content;
					//初始数据
					mui.fire(commonList,'loaddata',{entityId:this.getAttribute("entityId"),dataType:this.getAttribute("data-type")});
					//获得共用父模板
					var headerWebview = template.header;
					mui.fire(headerWebview,'updateHeader',{title:title});
					
					headerWebview.show('slide-in-right', 150);
				}
				
			});
			
			
			
			
			
			
		</script>
		
	</body>

</html>