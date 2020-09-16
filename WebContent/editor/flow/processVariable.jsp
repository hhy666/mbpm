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
	<title>流程变量列表</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script type="text/javascript">
		//点击选择
		function singleClickSelect(row, element){
			$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
	    	$(element).addClass('changeColor');
		}
		
		//双击修改流程变量
		function doubleClickSelect(record){
			var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
			var index = $tr.data('index'); //获得选中的行的index
			
			var processVarId = record.id;
			Matrix.setFormItemValue('processVarId',processVarId);
			Matrix.setFormItemValue('index',index);
			
			parent.openEditFlowVarible(this,processVarId,index);      //editFlowProMainPage.jsp弹出
		}
		
		//添加流程变量
		function addVarible(){
			parent.openAddFlowVarible(this);     //editFlowProMainPage.jsp弹出
		}
		
		//修改流程变量
		function editVarible(){
			var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
			if($tr!=null && $tr.length==1){
				var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
				var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
				
				Matrix.setFormItemValue('processVarId',record.id);
				Matrix.setFormItemValue('index',index);
				
				var processVarId = Matrix.getFormItemValue('processVarId');
				var index = Matrix.getFormItemValue('index');
				parent.openEditFlowVarible(this,processVarId,index);      //editFlowProMainPage.jsp弹出
			}else{
				Matrix.warn("请选择一条流程变量!");
			}
		}
		
		//上移流程变量
		function moveUpVarible(){
			var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
			if($tr!=null && $tr.length==1){
				var index = $tr.data('index'); //获得选中的行的index
				var item = Matrix.getGridData('DataGrid001');   //所有数据
				var listSize = item.length;      //长度
				var record = item[index];  //当前选中行
			
				if(index>0){
					var url = "<%=request.getContextPath()%>/editor/process_moveUpFlowVarible.action";
					var json = "{'varibleId':'"+record.uuid+"'}";
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
				Matrix.warn("请选择一条需要上移的流程变量!");
			}
			
		}
		//下移流程变量
		function moveDownVarible(){
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
					var url = "<%=request.getContextPath()%>/editor/process_moveDownFlowVarible.action";
					var json = "{'varibleId':'"+record.uuid+"'}";
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
				Matrix.warn("请选择一条需要下移的流程变量!");
			}
		}

		//删除选择的流程变量
		function deleteVarible(){
			var select = $('#DataGrid001_table').find('tr.changeColor');
			if(select!=null && select.length>0){
				var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
				var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
				layer.confirm("确认删除"+record.name+"？", {
				   btn: ['确定','取消'],  //按钮
				   closeBtn:0
		        },function(windowId){
		        	var url = "<%=request.getContextPath()%>/editor/process_deleteFlowVarible.action";
		        	Matrix.sendRequest(url,{'varibleId':record.uuid},function(data){
						if(data.data!=null){    
							var result = isc.JSON.decode(data.data);
							if(result.result){
								//删除成功，刷新数据表格
								Matrix.refreshDataGridData('DataGrid001');      
							}else{
								Matrix.warn("未成功删除该流程变量!");
							}
						}
					});	
					layer.close(windowId);   //关闭询问窗口
		        })
				
			}else{
				Matrix.warn("请选择一条需要删除的流程变量!");
			}
		}
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1"style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="<%=request.getContextPath()%>/editor/process_getCurProcessVarible.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input name="processVarId" id="processVarId" type="hidden" >
		<input name="processdid" id="processdid" type="hidden" value="${param.processdid }"/>
		<input name="index" id="index" type="hidden" >
		
		<table id="table001" class="tableLayout" style="width:100%;height:100%">
			<tr>
				<td id="td001" class="tdLabelCls" style="width: 100%; height: 93%; text-align:left;">
					<table class="query_form_content" style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
						<tr>
							<td style="height: 30px;" colspan="2">
								<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addVarible();">
									<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
								</button>
								<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editVarible();">
									<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">编辑
								</button>
								<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveUp" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveUpVarible();">
									<img src="<%=path%>/resource/images/moveup.png" style="padding-right: 2px;">上移
								</button>
								<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveDown" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="moveDownVarible();">
									<img src="<%=path%>/resource/images/movedown.png" style="padding-right: 2px;">下移
								</button>
								<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="deleteVarible();">
									<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 4px;">删除
								</button>	
							</td>
						</tr>
						<tr>
							<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
								<table id="DataGrid001_table" style="width:100%;height:100%;">
								</table>
							
								<script>
								$(document).ready(function() {   
									$("#DataGrid001_table").bootstrapTable({           
										classes: 'table table-hover table-no-bordered',
										method: "post", 
										contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
										url: "<%=path%>/editor/process_getCurProcessVarible.action", 
										search: false,    //是否启用搜索框
										sortable: false,  //是否启用排序
										pagination:false, //是否启用分页
										sidePagination: "server",
										formatLoadingMessage: function() {
								            return '请稍等，正在加载中...';
									    },
										formatNoMatches: function() {
								            return '无符合条件的记录';
								        },
									    columns: [
									        {title:"主键",field:"uuid",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
									        {title:"编码",field:"id",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
									        {title:"名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
									        {title:"类型",field:"type",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},								
									    ],
									    onClickRow:function(row, $element){   //单击行事件
									    	singleClickSelect(row, $element);
										},
									    onDblClickRow:function(row){   //双击行事件
									    	doubleClickSelect(row);
										},
									});
							     });
								</script>
							</td>
						</tr>
					</table>
			   </td>
		</tr>
	</table>
 </form>			
</div>
</body>
</html>