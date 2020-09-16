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
<title>触发事件列表</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	div{
		box-sizing: border-box;
		-webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
</style>
<script type="text/javascript">
	
	function updateNameAndStatus(name,status,index){
		var item = Matrix.getGridData('DataGrid001');   //所有数据
		var record = item[index];
		record.name = name;
		record.status = status;
		$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:record});
		//设置选中行变色,字体变无色
		var tableId = document.getElementById("DataGrid001_table");
		tableId.rows[parseInt(index)+1].classList.add("changeColor");
	}
	//optString 0添加  1修改
	//点击左边数据行，右边栏跳转到触发事件详细页面
	function forwardFrame(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
    	$(element).addClass('changeColor');
		
		var index = $(element).data('index'); //获得选中的行的index
		var src = "<%=request.getContextPath()%>/form/admin/custom/trigger/h5TriggerTabPage.jsp?index="+index+"&optString=1";
		document.getElementById('iframeContent').src = src;	
	}
	
	//添加触发事件
	function addTrigger(){
		Matrix.showMask2();
		$('.changeColor').removeClass('changeColor');
		var src = "<%=request.getContextPath()%>/form/admin/custom/trigger/h5TriggerTabPage.jsp?optString=0";
		document.getElementById('iframeContent').src = src;
		Matrix.hideMask2();
	}

	//上移触发事件
	function moveUpTrigger(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			
			if(index>0){
				var url = "<%=request.getContextPath()%>/trigger/formProcessor_moveUpTrigger.action";
				var synJson = {'index':index};
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
							
							//同时修改右侧详细信息页面的uuid
							var iframe = document.getElementById('iframeContent').contentWindow.document.getElementById('J_iframe').contentWindow;
							//iframe.document.getElementById('uuid').value = previousIndex;
						}
					}
				});		
			}else{
				Matrix.warn("首行数据不可上移！");
			}
		}else{
			Matrix.warn("请选择一条需要上移的触发事件!");
		}	
	}
	
	//下移触发事件
	function moveDownTrigger(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			
			if(index<listSize-1){
				var url = "<%=request.getContextPath()%>/trigger/formProcessor_moveDownTrigger.action";
				var synJson = {'index':index};
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
							
							//同时修改右侧详细信息页面的uuid
							var iframe = document.getElementById('iframeContent').contentWindow.document.getElementById('J_iframe').contentWindow;
							//iframe.document.getElementById('uuid').value = nextIndex;
			    		}
					}
				});
			}else{
				Matrix.warn("末行数据不可下移！");
			}	
		}else{
			Matrix.warn("请选择一条需要下移的触发事件!");
		}
	}
	
	//删除触发事件
	function delTrigger(){
		var select = $('#DataGrid001_table').find('tr.changeColor');
		if(select!=null && select.length>0){
			layer.confirm("确认删除？", {
			   btn: ['确定','取消'],  //按钮
			   closeBtn:0
	        },function(windowId){
	        	var parentNodeId = Matrix.getFormItemValue("parentNodeId");
	    		var item = Matrix.getGridData('DataGrid001');   //所有数据
	    		var listSize = item.length;      //长度
	        	var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
				var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
				
				var synJson = {'index':index};
				var url = "<%=request.getContextPath()%>/trigger/formProcessor_delTrigger.action";
				Matrix.sendRequest(url,synJson,function(data){
					if(data.data!=null){
						var result = isc.JSON.decode(data.data);
						if(result.result){
							Matrix.refreshDataGridData('DataGrid001');
							Matrix.say('删除成功！');
							//删除后详细信息页跳转到空白页面
							document.getElementById('iframeContent').src = "<%=request.getContextPath()%>/editor/common/empty.html";
						}
					}
				});	
				layer.close(windowId);
	        })
		}else{
			Matrix.warn("请选择一条数据!");
		}
	}
	
	//复制触发事件
	function copyTrigger(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var item = Matrix.getGridData('DataGrid001');   //所有数据
    		var listSize = item.length;      //长度
        	var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
			var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
			
	        var synJson = {'index':index};
			var url = "<%=request.getContextPath()%>/trigger/formProcessor_copyTrigger.action";
			Matrix.sendRequest(url,synJson,function(data){
				if(data.data!=null){
					var result = isc.JSON.decode(data.data);
					if(result.result){
				    	Matrix.refreshDataGridData('DataGrid001');
				    	Matrix.say('复制成功！');
				    }else{
				    	Matrix.say('复制失败！');
				    }
				}		    
			});	
		}else{
			Matrix.warn("请选择一条数据！");
		}
		
		
	}
</script>
</head>
<body>
	 <div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	 <div id="box" style="height:100%;">
	 	 <div id="left" style="height: 100%;width:30%;float:left;">
	   	 	 <div style="height: 30px;width: 100%;background: #F8F8F8;">
	   	 		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addTrigger();">
					<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="delTrigger();">
					<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 4px;">删除
				</button>	
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveUp" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveUpTrigger();">
					<img src="<%=path%>/resource/images/moveup.png" style="padding-right: 2px;">上移
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveDown" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveDownTrigger();">
					<img src="<%=path%>/resource/images/movedown.png" style="padding-right: 2px;">下移
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemCopy" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="copyTrigger();">
					<img src="<%=path%>/resource/images/relatarc.png" style="padding-right: 2px;">复制
				</button>
	   	 	</div>
	   		<div style="height: calc(100% - 30px);width: 100%;overflow: auto">
	   	 	   <form id="form0" name="form0" method="post">
		   	 		<table id="DataGrid001_table" style="width:100%;height:100%;">		
		   	 		
					</table>
					<script>
						$(document).ready(function() {   
							$("#DataGrid001_table").bootstrapTable({           
								classes: 'table table-hover table-no-bordered',
								method: "post", 
								contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
								url: "<%=request.getContextPath()%>/trigger/formProcessor_loadTriggerList.action", 
								search: false,    //是否启用搜索框
								sortable: false,  //是否启用排序
								pagination:false, //是否启用分页
								sidePagination: "server",   //指定服务器端分页
								//clickToSelect: true,    //设置true 将在点击行时,自动选择radiobox 和 checkbox
								//uniqueId: "uuid",
								formatLoadingMessage: function() {
						            return '请稍等，正在加载中...';
							    },
								formatNoMatches: function() {
						            return '无符合条件的记录';
						        },
							    columns: [       //列配置项							 											
							        {title:"名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
							        {title:"状态",field:"status",sortable:true,clickToSelect:true,editorType:'Text',type:'text',
							           formatter: function (value, row, index) {
							              if(value == '0') {
							                  return "启动";
							              }else if(value == '1'){
							                  return "停止";
							              }
							           }
									}
							    ],
							    //singleSelect:true,   //设置true将禁止多选
							    onClickRow:function(row, $element){   //点击行事件 跳转
							    	forwardFrame(row, $element);
								},
							});
					     });						
					</script>	
			    </form>
	   	 	</div>
	   	  </div>
	   	  <div id="line" style="height: 100%;width: 3px;overflow: hidden;float:left;background: #ebebeb;cursor: row-resize;"></div>
	   	  <div id="right" style="height: 100%;width: calc(70% - 3px);float:right;">
  	 	  	 <iframe id="iframeContent" style="width:100%;height:100%;" frameborder="0" src=""/>
  	     </div>
	  </div>
</body>
</html>