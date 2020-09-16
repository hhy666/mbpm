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
<title>数据校验H5列表</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">
	//点击数据行
	function forwardFrame(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
    	$(element).addClass('changeColor');
	}
	
	//添加数据校验
	function addValidator(){
		layer.open({
	    	id:'Dialog0',
			type : 2,
			
			title : ['添加验证器'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '80%' ],
			content : "<%=request.getContextPath() %>/form/admin/designer/h5AddDataValidator.jsp?iframewindowid=Dialog0&opType=add"
		});		
	}
	
	//添加编辑关闭时触发
	function onDialog0Close(data) {
		if(data){
			var jsonObj = isc.JSON.decode(data);
			var opType = jsonObj.opType;
		    var validatorType = jsonObj.validatorType;//validator type
		    var validData = jsonObj.data;
		    var errorMessage = validData.errorMessage;
		    //根据类别来拼接字符串{'name':'','desc':''}
		    //['email', 'postCode', 'mobileTelephone', 'identityCard', 'precision', 'regexp', 
		    //'length', 'longRange', 'doubleRange', 'jsFunction', 'jsExpression']
		   
		    var recordData = null;//验证器信息
		    
		    if (validatorType == "precision") { //精度验证器
		  		  recordData = "{\"precision\":\""+validData.precision+"\",\"errorMessage\":\""+errorMessage+"\"}";
		  		  
		    } else if ((validatorType == 'regexp') || (validatorType == 'jsExpression')) { //正则表达式，js表达式
		    	  recordData = "{\"expression\":\""+validData.expression+"\",\"errorMessage\":\""+errorMessage+"\"}";
		    		
		    } else if (validatorType == 'jsFunction') { //js方法
		    	  recordData = "{\"functionName\":\""+validData.functionName+"\",\"errorMessage\":\""+errorMessage+"\"}";
		    		
		    } else if ((validatorType == 'length') || (validatorType == 'longRange') || (validatorType == 'doubleRange')) {
				  recordData = "{\"minValue\":\""+validData.minValue+"\",\"maxValue\":\""+validData.maxValue+"\",\"errorMessage\":\""+errorMessage+"\"}";
				  	
		    } else { //only errorMessage input
		    	  recordData = "{\"errorMessage\":\""+errorMessage+"\"}";
		    }
			//发送异步请求,{'actionType':'','validatorType':'','data':''}
			var url = "<%=request.getContextPath() %>/designer/formValidatorDesign_saveH5DataValidators.action";
			
			debugger;
			var componentId = $('#componentId').val();
			var componentType = $('#componentType').val();
			if (opType == "add") { //添加操作
			     var synJson = {'actionType':opType,'componentId':componentId,'componentType':componentType,'validatorType':validatorType,'data':recordData};	
		         Matrix.sendRequest(url,synJson,function(data){
		        	 Matrix.refreshDataGridData('DataGrid001');
		         });
		    	
		    } else if (opType == "update") { //更新操作
		    	var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
				if($tr!=null && $tr.length==1){
					var index = $tr.data('index'); //获得选中的行的index			
				    var synJson = {'actionType':opType,'rowNum':index,'componentId':componentId,'componentType':componentType,'validatorType':validatorType,'data':recordData};		  	
	 				Matrix.sendRequest(url,synJson,function(data){
	 					Matrix.refreshDataGridData('DataGrid001');
			        });
				}
				 
		    }
		}
	}
	
	//编辑数据校验
	function editValidator(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');
		if($tr!=null && $tr.length>0){
			var index = $tr.data('index'); //获得选中的行的index
			var componentId = $('#componentId').val();
			var componentType = $('#componentType').val();
			layer.open({
		    	id:'Dialog0',
				type : 2,
				
				title : ['编辑验证器'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '70%', '80%' ],
				content : "<%=request.getContextPath() %>/designer/formValidatorDesign_getH5UpdateValidator.action?iframewindowid=Dialog0&opType=update&componentId="+componentId+"&componentType="+componentType+"&rowNum="+index+""
			});		
		}else{
			Matrix.warn("请选择一条数据!");
		}
		
	}
	
	
	//上移数据校验
	function moveUpValidator(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
		
			var componentId = $('#componentId').val();
			var componentType = $('#componentType').val();
			if(index>0){
				var url = "<%=request.getContextPath()%>/designer/formValidatorDesign_saveH5DataValidators.action";
				var json = "{'rowNum':'"+index+"','actionType':'up','componentId':'"+componentId+"','componentType':'"+componentType+"'}";
				var synJson = isc.JSON.decode(json);
				Matrix.sendRequest(url,synJson,function(data){
					if(data.data == 'upSuccess'){   //上移成功					
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
				});		
			}else{
				Matrix.warn("首行数据不可上移！");
			}
		}else{
			Matrix.warn("请选择一条需要上移的数据校验!");
		}	
	}
	
	//下移数据校验
	function moveDownValidator(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			
			var componentId = $('#componentId').val();
			var componentType = $('#componentType').val();
			if(index<listSize-1){
				var url = "<%=request.getContextPath()%>/designer/formValidatorDesign_saveH5DataValidators.action";
				var json = "{'rowNum':'"+index+"','actionType':'down','componentId':'"+componentId+"','componentType':'"+componentType+"'}";
				var synJson = isc.JSON.decode(json);
				Matrix.sendRequest(url,synJson,function(data){
					if(data.data == 'downSuccess'){  //下移成功						  
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
				});
			}else{
				Matrix.warn("末行数据不可下移！");
			}	
		}else{
			Matrix.warn("请选择一条需要下移的数据校验!");
		}
	}
	
	//删除数据校验
	function delValidator(){
		var select = $('#DataGrid001_table').find('tr.changeColor');
		if(select!=null && select.length>0){
			var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
			var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
			
			var componentId = $('#componentId').val();
			var componentType = $('#componentType').val();
			layer.confirm("确认删除"+record.validatorName+"？", {
			   btn: ['确定','取消'],  //按钮
			   closeBtn:0
	        },function(windowId){
	        	var url = "<%=request.getContextPath()%>/designer/formValidatorDesign_saveH5DataValidators.action";
				Matrix.sendRequest(url,{'rowNum':index,'actionType':'delete','componentId':componentId,'componentType':componentType},function(data){
					if(data.data == 'deleteSuccess'){  //删除成功	
						Matrix.say('删除成功');
						Matrix.refreshDataGridData('DataGrid001');	
					}
				});	
				layer.close(windowId);   //关闭询问窗口
	        })
		}else{
			Matrix.warn("请选择一条数据!");
		}
	}

</script>
</head>
<body>
	 <div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	 <div id="box" style="height:100%;">
	   	 	 <div style="height: 30px;width: 100%;background: #F8F8F8;">
	   	 		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addValidator();">
					<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editValidator();">
					<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">修改
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveUp" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveUpValidator();">
					<img src="<%=path%>/resource/images/moveup.png" style="padding-right: 2px;">上移
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveDown" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveDownValidator();">
					<img src="<%=path%>/resource/images/movedown.png" style="padding-right: 2px;">下移
				</button>
				<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="delValidator();">
					<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 4px;">删除
				</button>	
	   	 	</div>
	   		<div style="height: calc(100% - 30px);width: 100%;overflow: auto">
	   	 	   <form id="form0" name="form0" method="post">
	   	 	   		<!-- 组件编码  管理实施时不为空-->
	   	 	   		<input name="componentId" id="componentId" type="hidden" value="${param.componentId}"/>
	   	 	   		<!-- 组件类型  设计开发时不为空 -->
	   	 	   		<input name="componentType" id="componentType" type="hidden" value="${param.componentType}"/>
	   	 	   		
		   	 		<table id="DataGrid001_table" style="width:100%;height:100%;">		
					</table>
					<script>
						$(document).ready(function() {   
							$("#DataGrid001_table").bootstrapTable({           
								classes: 'table table-hover table-no-bordered',
								method: "post", 
								contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
								url: "<%=request.getContextPath()%>/designer/formValidatorDesign_getH5DataValidators.action", 
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
							        {title:"名称",field:"validatorName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
							        {title:"描述",field:"desc",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
							    ],
							    //singleSelect:true,   //设置true将禁止多选
							    onClickRow:function(row, $element){   //点击行事件 跳转
							    	forwardFrame(row, $element);
								},
								onDblClickRow:function(row){   //双击行事件
									editValidator();
								},
							});
					     });
						
						 function queryParams(params) {
						      var temp = {   
						    	  componentId: $('#componentId').val(),
						    	  componentType: $('#componentType').val()		    	  
						      };
						      return temp;
						 };
					</script>	
			    </form>
			</div>
	  </div>
</body>
</html>