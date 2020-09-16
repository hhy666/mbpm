<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>多活动实例列表</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="">
		font{
			font-size:14px;
			margin-left:10px;
			font-weight:bold;
		}
		#td001{
			width:100%;
			height:30px;
			background:#F8F8F8;
		}
	</style>
	<script type="text/javascript">
		//保存
		function saveData(){
			debugger;
			var str = "[";
			var data = Matrix.getGridData('DataGrid001');
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					str+="{\\'variableId\\':\\'"+data[i].name+"\\',";
					str+="\\'token\\':\\'"+data[i].seperatFlag+"\\'}";
					if(data[i].name!=data[data.length-1].name){
						str+=",";
					}
				}
			}
			str+="]";
			var activityId = Matrix.getFormItemValue("activityId");
			var containerId = Matrix.getFormItemValue("containerId");
			var json = "{'data':'"+str+"','activityId':'"+activityId+"','containerId':'"+containerId+"'}";
			var synJson = isc.JSON.decode(json);
			var url = "<%=request.getContextPath()%>/editor/editor_saveMultiActIns.action";
			Matrix.sendRequest(url,synJson,function(){
			
			});
		}
		//失去焦点时保存数据表格数据
		window.onblur = function(){
			saveData();
		}
		//获得焦点时设置为编辑状态
		window.onfocus = function(){
			Matrix.setFormItemValue('editFlag','edit');
		}
		
		//点击选择
		function singleClickSelect(row, element){
			$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
			$(element).addClass('changeColor');
		}
		
		//添加多活动实例窗口
		function addInstances(){
			var containerId = $('#containerId').val();
			var activityId = $('#activityId').val();
			parent.openMultActivityInstances(this,containerId,activityId);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//修改多活动实例窗口
		function editInstances(){
			var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
			var index = $tr.data('index'); //获得选中的行的index
			Matrix.setFormItemValue('index',index);
			var activityId = Matrix.getFormItemValue('activityId');
			if($tr!=null && $tr.length==1){
				var activityId = Matrix.getFormItemValue('activityId');
				parent.openEditInstances(this,activityId,index);     //loadBasicActivityTreeNodePage.jsp弹出
			}else{
				Matrix.warn('请先选择一条数据!');
			}
		}
		
		//双击修改多活动实例窗口
		function doubleClickSelect(record){
			var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
			var index = $tr.data('index'); //获得选中的行的index
			Matrix.setFormItemValue('index',index);
			var activityId = Matrix.getFormItemValue('activityId');
			parent.openEditInstances(this,activityId,index);     //loadBasicActivityTreeNodePage.jsp弹出
		
		}		
		
		//删除
		function delInstances(){
			var select = $('#DataGrid001_table').find('tr.changeColor');
			if(select!=null && select.length>0){
				var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
				var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
				var activityId = Matrix.getFormItemValue('activityId');
				layer.confirm("确认删除"+record.name+"？", {
				   btn: ['确定','取消'],  //按钮
				   closeBtn:0
		        },function(windowId){
					var url = "<%=request.getContextPath()%>"+"/editor/editor_deleteMultiActIns.action";
					Matrix.sendRequest(url,{'activityId':activityId,'index':index},function(data){
						if(data.data!=null){
							var result = isc.JSON.decode(data.data);
							if(result.flag){
								Matrix.refreshDataGridData('DataGrid001');
							}
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
<div id="j_id1" jsId="j_id1"style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_getCurActivityEditProperty.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input name="data" id="data" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="index" id="index" type="hidden" />
	
	<table id="table001" class="tableLayout" style="width: 100%; height: 100%;">
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width: 100%; height:30px; text-align:left;"><font>多活动实例</font></td>
		</tr>
		<tr id="tr002">
			<td id="td002" class="tdLabelCls" style="width: 100%; height: 93%; text-align:left;">
				<table class="query_form_content" style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
					<tr>
						<td style="height: 30px;" colspan="2">
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addInstances();">
								<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editInstances();">
								<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">修改
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="delInstances();">
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
									url: "<%=path%>/editor/editor_getCurActivityMultiActInsInfos.action", 
									search: false,    //是否启用搜索框
									sortable: false,  //是否启用排序
									pagination:false, //是否启用分页
									sidePagination: "server",
									queryParams: queryParams,   //传参
									formatLoadingMessage: function() {
							            return '请稍等，正在加载中...';
								    },
									formatNoMatches: function() {
							            return '无符合条件的记录';
							        },
								    columns: [
								        {title:"变量名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
								        {title:"分隔符",field:"seperatFlag",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
								    ],
								    onClickRow:function(row, $element){   //单击行事件
								    	singleClickSelect(row, $element);
									},
								    onDblClickRow:function(row){   //双击行事件
								    	doubleClickSelect(row);
									},
								});
						     });
							
							 function queryParams(params) {
							      var temp = {   
							    	  data: $("#data").val(),
							          activityId: $("#activityId").val(),
							          type:$("#type").val(),
							          processdid:$("#processdid").val(),
							          containerType:$("#containerType").val(),
							          containerId:$("#containerId").val()							 
							      };
							      return temp;
							 };
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