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
<title>辅助事件各列表页面</title>
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
		var id = executorInfo.id;//这里需要根据数据表格的Field改变
		var activityId = Matrix.getFormItemValue('activityId');
		var containerId = Matrix.getFormItemValue('containerId');
		var parentNodeId = Matrix.getFormItemValue('parentNodeId');//树节点 创建时、完成时。。。。。
		var src = "<%=request.getContextPath()%>/editor/activity/assistEventTabPage.jsp?entityId="+id+"&parentNodeId="+parentNodeId+"&index="+index+"&containerId="+containerId+"&activityId="+activityId+"";
		document.getElementById('iframeContent').src = src;
		
			
	}
	
	//添加新辅助事件
	function addNewAssistEvent(){
		Matrix.showMask2();
		var parentNodeId = Matrix.getFormItemValue("parentNodeId");
		var item = Matrix.getGridData('DataGrid001');   //所有数据
		var listSize = item.length;      //长度
		
		var activityId = Matrix.getFormItemValue('activityId');
		var containerId = Matrix.getFormItemValue('containerId');
		var url = "<%=request.getContextPath()%>"+"/editor/editor_addNewAssistEvent.action";
		Matrix.sendRequest(url,{'parentNodeId':parentNodeId,'i':listSize,'activityId':activityId,'containerId':containerId},function(data){
			if(data.data!=null){
				var newData = isc.JSON.decode(data.data);
				$('#DataGrid001_table').bootstrapTable('insertRow',{index:listSize,row:newData});   //插入新行
				
				//设置选中行变色,字体变无色
				var tableId = document.getElementById("DataGrid001_table");
				tableId.rows[listSize+1].classList.add("changeColor");	
				
				var id = newData.id;
				var src = "<%=request.getContextPath()%>/editor/activity/assistEventTabPage.jsp?entityId="+id+"&parentNodeId="+parentNodeId+"&index="+listSize+"&containerId="+containerId+"&activityId="+activityId+"";
				document.getElementById('iframeContent').src = src;
				
				var nodeName = convertNodeName(parentNodeId,listSize+1);      //新的节点名称  记录数加1
				parent.main_iframe.contentWindow.refreshTreeNodeById(nodeName);   //重命名节点名称
				Matrix.hideMask2();
			}
		});
	}
	
	//上移辅助事件
	function moveUpAssistEvent(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			var activityId = Matrix.getFormItemValue('activityId');
			var containerId = Matrix.getFormItemValue('containerId');
			var entityId = Matrix.getFormItemValue("parentNodeId");
			
			if(index>0){
				var url = "<%=request.getContextPath()%>/editor/editor_moveUpAssistEvent.action";
				var json = "{'index':'"+index+"','containerId':'"+containerId+"','activityId':'"+activityId+"','entityId':'"+entityId+"'}";
				var synJson = isc.JSON.decode(json);
				Matrix.sendRequest(url,synJson,function(data){
					if(data!=null && data.data!=''){
						var result = isc.JSON.decode(data.data);
						if(result.result){  //上移成功
							//上移更新行
							var previousIndex = index - 1;  //上一行的index
							var previousRecord = item[previousIndex];   //上一行的数据
							
							var str = JSON.stringify(previousRecord);
							var rowObj = JSON.parse(str);
							
							$("#DataGrid001_table").bootstrapTable('updateRow',{index:previousIndex,row:record});
							$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:rowObj});
							
							var tableId = document.getElementById("DataGrid001_table");
							tableId.rows[previousIndex+1].classList.add("changeColor");	
							
						}
					}
				});		
			}else{
				Matrix.warn("首行数据不可上移！");
			}
		}else{
			Matrix.warn("请选择一条需要上移的辅助事件!");
		}	
	}
	
	//下移辅助事件
	function moveDownAssistEvent(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			
			var activityId = Matrix.getFormItemValue('activityId');
			var entityId = Matrix.getFormItemValue("parentNodeId");
			var containerId = Matrix.getFormItemValue('containerId');
			
			if(index<listSize-1){
				var url = "<%=request.getContextPath()%>/editor/editor_moveDownAssistEvent.action";
				var json = "{'activityId':'"+activityId+"','containerId':'"+containerId+"','entityId':'"+entityId+"','index':'"+index+"'}";
				var synJson = isc.JSON.decode(json);
				Matrix.sendRequest(url,synJson,function(data){
					if(data!=null && data.data!=''){
						var result = isc.JSON.decode(data.data);
						if(result.result){   //下移成功
							//下移更新行
							var nextIndex = index + 1;  //下一行的index
							var nextRecord = item[nextIndex];   //下一行的数据
							
							var str = JSON.stringify(nextRecord);
							var rowObj = JSON.parse(str);
							
							$("#DataGrid001_table").bootstrapTable('updateRow',{index:nextIndex,row:record});
							$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:rowObj});
							
							var tableId = document.getElementById("DataGrid001_table");
							tableId.rows[nextIndex+1].classList.add("changeColor");	
			    		}
					}
				});
			}else{
				Matrix.warn("末行数据不可下移！");
			}	
		}else{
			Matrix.warn("请选择一条需要下移的辅助事件!");
		}
	}
	
	//删除辅助事件
	function delAssistEvent(){
		var parentNodeId = Matrix.getFormItemValue("parentNodeId");
		var item = Matrix.getGridData('DataGrid001');   //所有数据
		var listSize = item.length;      //长度
		
		var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
		var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
		var id = record.id;
		var activityId = Matrix.getFormItemValue('activityId');
		var url = "<%=request.getContextPath()%>"+"/editor/editor_deleteAssistEventById.action";
		Matrix.sendRequest(url,{'assistEventId':id,'activityId':activityId},function(data){
			if(data.data!=null){
				var result = isc.JSON.decode(data.data);
				if(result.result){
					$('#DataGrid001_table').bootstrapTable('removeByUniqueId', id);  //删除选中行
					//删除后详细信息页跳转到空白页面
					document.getElementById('iframeContent').src = "<%=request.getContextPath()%>/editor/common/empty.html";
					
					var nodeName = convertNodeName(parentNodeId,listSize-1);      //新的节点名称  记录数加1
					parent.main_iframe.contentWindow.refreshTreeNodeById(nodeName);   //重命名节点名称
				}
			}
		});	
	}
	
	function convertNodeName(nodeId,num){
		var nodeName;
		if (nodeId == "cjs") { // 创建时
			nodeName = "创建时(" + num + ")";
		} else if (nodeId == "wcs") { // 完成时
			nodeName = "完成时(" + num + ")";
		} else if (nodeId == "zts") { // 暂停时
			nodeName = "暂停时(" + num + ")";
		} else if (nodeId == "hfs") { // 恢复时
			nodeName = "恢复时(" + num + ")";
		} else if (nodeId == "zzs") { // 终止时
			nodeName = "终止时(" + num + ")";
		} else if (nodeId == "chs") { // 撤回时
			nodeName = "撤回时(" + num + ")";
		} else if (nodeId == "gqs") { // 过期时
			nodeName = "过期时(" + num + ")";
		} else if (nodeId == "cbs") { // 催办时
			nodeName = "催办时(" + num + ")";
		} else if (nodeId == "hts") { // 回退时
			nodeName = "回退时(" + num + ")";
		} else if (nodeId == "drwcs") { // 单人完成时
			nodeName = "单人完成时(" + num + ")";
		} else if (nodeId == "yhdys") { // 用户自定义
			nodeName = "用户自定义(" + num + ")";
		}
		return nodeName;
	}
</script>
</head>
<body>
	 <div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	 <div id="box" style="height:100%;">
	 	 <div id="top" style="height: 40%;width:100%;">
	   	 	 <div style="height: 30px;width: 100%;background: #F8F8F8;">
	   	 		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addNewAssistEvent();">
					<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveUp" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveUpAssistEvent();">
					<img src="<%=path%>/resource/images/moveup.png" style="padding-right: 2px;">上移
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveDown" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveDownAssistEvent();">
					<img src="<%=path%>/resource/images/movedown.png" style="padding-right: 2px;">下移
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="delAssistEvent();">
					<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 4px;">删除
				</button>	
	   	 	</div>
	   		<div style="height: calc(100% - 30px);width: 100%;overflow: auto">
	   	 	   <form id="form0" name="form0" method="post">
	   	 	   	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
				<input name="type" id="type" type="hidden" value="${param.type}"/>
				<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
				<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
				<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
				<input name="parentNodeId" id="parentNodeId" type="hidden" value="${param.entityId }"/>
					
		   	 		<table id="DataGrid001_table" style="width:100%;height:100%;">		
					</table>
					<script>
						$(document).ready(function() {   
							$("#DataGrid001_table").bootstrapTable({           
								classes: 'table table-hover table-no-bordered',
								method: "post", 
								contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
								url: "<%=request.getContextPath()%>/editor/editor_getAssistEventsById.action", 
								search: false,    //是否启用搜索框
								sortable: false,  //是否启用排序
								pagination:false, //是否启用分页
								sidePagination: "server",   //指定服务器端分页
								queryParams: queryParams,   //传参
								//clickToSelect: true,    //设置true 将在点击行时,自动选择radiobox 和 checkbox
								uniqueId: "id",
								formatLoadingMessage: function() {
						            return '请稍等，正在加载中...';
							    },
								formatNoMatches: function() {
						            return '无符合条件的记录';
						        },
							    columns: [       //列配置项							 
							        {
							         title : '序号',
							         align: "center",
							         width: 50,
							         formatter: function (value, row, index) {
							        	  //获取每页显示的数量
							        	  var pageSize=$('#DataGrid001_table').bootstrapTable('getOptions').pageSize;  
							        	  //获取当前是第几页  
							        	  var pageNumber=$('#DataGrid001_table').bootstrapTable('getOptions').pageNumber;
							        	  //返回序号，注意index是从0开始的，所以要加上1
							        	  return pageSize * (pageNumber - 1) + index + 1;
							          }				 
								    },            
							        {title:"事件编码",field:"id",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
							        {title:"事件名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
							    ],
							    //singleSelect:true,   //设置true将禁止多选
							    onClickRow:function(row, $element){   //点击行事件 跳转
							    	forwardFrame(row, $element);
								},
							});
					     });
						
						 function queryParams(params) {
						      var temp = {   
						          activityId: $("#activityId").val(),
						          type:$("#type").val(),
						          processdid:$("#processdid").val(),
						          containerType:$("#containerType").val(),
						          containerId:$("#containerId").val(),
						          entityId:$("#parentNodeId").val()
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