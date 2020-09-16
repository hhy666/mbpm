<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>交互式组件</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">
	//上下拖拉横线
	window.onload = function() {
		 var oBox = document.getElementById("box");
		 var oTop = document.getElementById("top");
		 var oBottom = document.getElementById("bottom");
		 var oLine = document.getElementById("line");
		oLine.onmousedown = function(e) {
			Matrix.showMask2();
			var disY = (e || event).clientY;
			oLine.top = oLine.offsetTop;
			document.onmousemove = function(e) {
				var iT = oLine.top + ((e || event).clientY - disY);
				var maxT = oBox.clientHeight - oLine.offsetHeight;
				oLine.style.margin = 0;
				iT < 0 && (iT = 0);
				iT > maxT && (iT = maxT);
				oLine.style.top = oTop.style.height = iT + "px";
				oBottom.style.height = oBox.clientHeight - iT + "px";
				return false
			};	
			document.onmouseup = function() {
				Matrix.hideMask2();
				document.onmousemove = null;
				document.onmouseup = null;	
				oLine.releaseCapture && oLine.releaseCapture()
			};
			oLine.setCapture && oLine.setCapture();
			return false
		};
	};
	//assistEventDetailPage.jsp辅助事件详细页面文本框改变事件调用
	function updateName(name,index){
		var item = Matrix.getGridData('DataGrid001');   //所有数据
		var record = item[index];
		record.name = name;
		$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:record});
		//设置选中行变色,字体变无色
		var tableId = document.getElementById("DataGrid001_table");
		tableId.rows[parseInt(index)+1].classList.add("changeColor");
	}

	//点击数据行，下边栏跳转到详细页面
	function forwardFrame(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
    	$(element).addClass('changeColor');
		
    	var executorInfo = row;    //选中行
		var data = Matrix.getGridData('DataGrid001');   //所有数据
		var index = 0;
		for(var i = 0;i<data.length;i++){
			if(executorInfo.name==data[i].name){
				index = i;
			}
		}
		var id = executorInfo.id;
		var entityId = Matrix.getFormItemValue("entityId");
		var src = "<%=request.getContextPath()%>/editor/flow/applicationTabPage.jsp?index="+index+"&entityId="+entityId+"&appdid="+id;
		document.getElementById('iframeContent').src = src;
	}
	
	//添加新交互式组件
	function addApplication(){
		Matrix.showMask2();
		var item = Matrix.getGridData('DataGrid001');   //所有数据
		var listSize = item.length;      //长度
		
		var entityId = Matrix.getFormItemValue('entityId');
		var url = "<%=request.getContextPath()%>"+"/editor/process_addApplication.action";
		Matrix.sendRequest(url,{'entityId':entityId,'i':listSize},function(data){
			if(data.data!=null){
				var newData = isc.JSON.decode(data.data);
				$('#DataGrid001_table').bootstrapTable('insertRow',{index:listSize,row:newData});   //插入新行
				
				//设置选中行变色,字体变无色
				var tableId = document.getElementById("DataGrid001_table");
				tableId.rows[listSize+1].classList.add("changeColor");	
				
				var id = newData.id;
				var src = "<%=request.getContextPath()%>/editor/flow/applicationTabPage.jsp?index="+listSize+"&entityId="+entityId+"&appdid="+id;
				document.getElementById('iframeContent').src = src;
				
				var nodeName = convertNodeName(entityId,listSize+1);      //新的节点名称  记录数加1
				parent.main_iframe.contentWindow.refreshTreeNodeById(nodeName);   //重命名节点名称
				Matrix.hideMask2();
			}
		});
	}
	
	
	//删除交互式组件
	function deleteApplication(){
		var select = $('#DataGrid001_table').find('tr.changeColor');
		var entityId = Matrix.getFormItemValue('entityId');
		var item = Matrix.getGridData('DataGrid001');   //所有数据
		var listSize = item.length;      //长度
		if(entityId == 'jhszj'){
			var message = "交互式组件";
		}else if(entityId == 'fjhszj'){
			var message = "非交互式组件";
		}
		if(select!=null && select.length>0){
			var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
			var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
			var name = record.name;
			var appdid = record.id;
			layer.confirm("确认删除"+name+"？", {
			   btn: ['确定','取消'],  //按钮
			   closeBtn:0
	        },function(windowId){
	        	var url = "<%=request.getContextPath()%>/editor/process_deleteApplication.action?appdid="+appdid;
	        	Matrix.sendRequest(url,{'appdid':record.id},function(data){
	        		if(data!=null && data.data!=''){
	        			var result = isc.JSON.decode(data.data);
						if(result.result){
							$('#DataGrid001_table').bootstrapTable('removeByUniqueId', record.id);  //删除选中行
							//删除后详细信息页跳转到空白页面
							document.getElementById('iframeContent').src = "<%=request.getContextPath()%>/editor/common/empty.html";
							
							var nodeName = convertNodeName(entityId,listSize-1);      //新的节点名称  记录数加1
							parent.main_iframe.contentWindow.refreshTreeNodeById(nodeName);   //重命名节点名称
						}else{
							Matrix.warn("未成功删除该"+message+"!");
						}
					}
				});	
				layer.close(windowId);
	        })
		}else{
			Matrix.warn("请选择一条需要删除的"+message+"!");
		}
	}
	

	function convertNodeName(nodeId,num){
		var nodeName;
		if (nodeId == "jhszj") { // 交互式组件
			nodeName = "交互式组件(" + num + ")";
		} else if (nodeId == "fjhszj") { // "非交互式组件
			nodeName = "非交互式组件(" + num + ")";
		} 
		return nodeName;
	}
</script>
</head>
<body>
	 <div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	 <div id="box" style="height:100%;">
	 	<div id="top" style="height: 40%;width:100%;">
	   	 	<div style="height: 33px;width: 100%;background: #F8F8F8;border-bottom: 1px solid #cccccc;">
	   	 		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addApplication();">
					<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="deleteApplication();">
					<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 4px;">删除
				</button>		
	   	 	</div>
	   	 	<div style="height: calc(100% - 33px);width: 100%;overflow: auto">
	   	 	   <form id="form0" name="form0" method="post">
	   	 	   		<input type="hidden" id="entityId" name="entityId" value="${param.entityId}" />
					<input type="hidden" id="appdid" name="appdid" value="${param.appdid}" />
		   	 		<table id="DataGrid001_table" style="width:100%;height:100%;">		
					</table>
					<script>
						$(document).ready(function() {   
							$("#DataGrid001_table").bootstrapTable({           
								classes: 'table table-hover table-no-bordered',
								method: "post", 
								contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
								url: "<%=request.getContextPath()%>/editor/process_getCurApplication.action", 
								search: false,    //是否启用搜索框
								sortable: false,  //是否启用排序
								pagination:false, //是否启用分页
								sidePagination: "server",   //指定服务器端分页
								queryParams: queryParams,   //传参
								showHeader: false,    //是否显示列头
								//clickToSelect: true,    //设置true 将在点击行时,自动选择radiobox 和 checkbox
								uniqueId: "id",
								formatLoadingMessage: function() {
						            return '请稍等，正在加载中...';
							    },
								formatNoMatches: function() {
						            return '无符合条件的记录';
						        },
							    columns: [       //列配置项		
							        {title:"编码",field:"id",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
							        {title:"名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
							    ],
							    //singleSelect:true,   //设置true将禁止多选
							    onClickRow:function(row, $element){   //点击行事件 跳转
							    	forwardFrame(row, $element);
								},
							});
					     });
						 function queryParams(params) {
						      var temp = {   
						    	 entityId:$("#entityId").val()				    	
						      };
						      return temp;
						 };
					</script>	
			    </form>
	   	 	</div>
	   	 </div>
	   	 <div id="line" style="height: 1%;width: 100%;overflow: hidden;background: #ebebeb;cursor: row-resize;"></div>
	  	  <div id="bottom" style="height: 59%;width:100%;">
	  	 	  <iframe id="iframeContent" style="width:100%;height:100%;" frameborder="0" src=""/>
	  	   </div>
	  </div>
</body>
</html>