<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script type="text/javascript">

	//转交
	function transferTask() {
		var select = Matrix.getGridSelections("DataGrid001");
		if(select!=null&&select.length>0){
			var taskId = select[0].taskId;
			var taskType = select[0].taskType;
	        var status = select[0].status;
			 if(taskType!=1){
		    	Matrix.warn("该分派类型的任务不能转交！");
		    	return false;
	        }
	        if(status!=1&&status!=2){
	        	Matrix.warn("该状态的任务项不能转交！");
		    	return false;
	        }
	        var operation = "1";//转交
	        selectuser(taskId,operation);
		}else{
		Matrix.warn('请选择要转交的工作任务项！');
			return false;
		}
	  
	}
	
	function selectuser(taskId,operation){
		document.getElementById('operation').value = operation;
		if(taskId!=null){
			document.getElementById('taskId').value = taskId;
		}
		layer.open({
			type:2,
			title:['选择用户'],
			area:['100%','99%'],
			content:"<%=path%>/common/userSelected_h5LoadUserTreePage.action?iframewindowid=ProcInsTarget"
		});
	}
	
	// 重新分派任务
	function reassignTask(){
		var select = Matrix.getGridSelections("DataGrid001");
		//if(select!=null&&select.length>0){
	        var operation = "2";//重新分派
	        selectuser(null,operation);
		//}else{
		//Matrix.warn('请选择要分派的工作任务项！');
			//return false;
		//}
	}
	
	
	function onProcInsTargetClose(data,oType){
		if(data!=null){
			//var userObj = isc.JSON.decode(data);
			//var userObj = data;
			var operation =document.getElementById('operation').value;
			var aiid = document.getElementById("aiid").value;
			//var userId = userObj.id;
			var userId = data.ids;
			var taskId = null;
			if(operation=="1"){//转交任务
				taskId = document.getElementById('taskId').value;
				var url = "<%=path%>/instance/activityInsAction_transferTask.action?targetUserId="+userId+"&taskId="+taskId+"&aiid="+aiid;
				Matrix.sendRequest(url,null,function(){
					Matrix.refreshDataGridData('DataGrid001');
				});
			}else if(operation=="2"){//重新分配
				var url = "<%=path%>/instance/activityInsAction_reassignTask.action?newOwner="+userId+"&aiid="+aiid;
				Matrix.sendRequest(url,null,function(){
					Matrix.refreshDataGridData('DataGrid001');
				});
			}	 
		}
		return true;
	}
	
	
	// 删除工作任务
	function deleteTask(){
		var select = Matrix.getGridSelections("DataGrid001");
		if(select!=null&&select.length>0){
			var taskId = select[0].taskId;
			var taskType = select[0].taskType;
			 if(taskType!=1){
		    	Matrix.warn("该分派类型的任务是范围的任务项，不能删除！");
		    	return false;
	        }
	         Matrix.confirm('确定要删除该任务吗?',function(data){//true or null
		      if(!data){
		    	  
		        var url = "<%=path%>/instance/activityInsAction_deleteTask.action?taskId="+taskId;
		        window.location.href = url;	
				Matrix.say("删除成功");
		      }
    		});
		}else{
			Matrix.warn('请选择要删除的工作任务项！');
			return false;
		}
	}
	
	
	// 取消检出工作任务
	function releaseTask(){
		var select = Matrix.getGridSelections("DataGrid001");
		if(select!=null&&select.length>0){
			var taskId = select[0].taskId;
			var status = select[0].status;
	        if(status!=2){
	        	Matrix.warn("该工作任务当前状态不能执行取消检出操作！");
		    	return false;
	        }
	        var url = "<%=path%>/instance/activityInsAction_releaseTask.action?taskId="+taskId;
			Matrix.sendRequest(url,null,function(){
				Matrix.refreshDataGridData('DataGrid001');
				Matrix.warn("取消成功");
			});
		}else{
			Matrix.warn('请选择要取消检出的工作任务！');
			return false;
		}
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post"	action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="Form0" value="Form0" />
		<input type="hidden" name="taskId" id="taskId" value="${taskId}" />
		<input type="hidden" name="tasksJson" id="tasksJson" value="${tasksJson}" />
		<input type="hidden" name="aiid" id="aiid" value="${param.aiid}" />
		<input type="hidden" name="operation" id="operation" />
		<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
		<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
		<div style="display: block;">
  			<table id="DataGrid001_table" style="width:100%;height:100%;">
				<script>
					$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/instance/activityInsAction_h5QueryTasks.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: true,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							//sortable:false,
							pageSize:20,
							//pageList:[10,20,30,40],
							formatLoadingMessage: function() {
				            return '请稍等，正在加载中...';
					        },
					        queryParams: function(params){
					        	var temp = {
				        			aiid : document.getElementById('aiid').value,
					        	}
					        	return temp;
					        },
					        formatNoMatches: function() {
					            return '无符合条件的记录';
					        },
							columns:[{
								title:' ',
					            checkbox: true
					        },{
								title:'序号',
								 formatter: function (value, row, index) { 
									var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
									var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
			                            return pageSize * (pageNumber - 1) + index + 1;  
			                        }
							},{
								field:'taskId',
								title:'任务编码项',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'taskType',
								title:'分派方式',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){
									var text = '-';
									if (value == 1) {
									    text = "分派";
									} else if (value == 2) {
									    text = "委托";
									} else if (value == 3) {
									    text = "转交";
									} else if (value == 4) {
									    text = "浏览";
									} else if (value == 5) {
									    text = "协作";
									}
									return text;
								}
							},{
								field:'userName',
								title:'用户',
								width:'10%',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'depName',
								title:'部门',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'roleName',
								title:'角色',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'ownerName',
								title:'拥有者',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'status',
								title:'状态',
								width:'10%',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){
									var text = '-';
									if (value == 1) {
									    text = "就绪";
									} else if (value == 2) {
									    text = "锁定";
									} else if (value == 3) {
									    text = "完成";
									} else if (value == 4) {
									    text = "终止";
									} else if (value == 6) {
									    text = "协作";
									}
									return text;
								}
							},{
								field:'receivedDate',
								title:'接收时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'expiredDate',
								title:'完成时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							}]
						});
					});
				</script>
			</table>
	    </div>
	    <div style="display: block;">
	    	<table class="query_form_content" style="width: 100%; height: 100%;">
    			<tr>
    				<td class="cmdLayout" style="text-align: -webkit-center;left: 0px;right: 0px">
			    		<div id="button000" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="转交任务" onclick="transferTask()">
						</div>
						<div id="button001" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="重新安排" onclick="reassignTask()">
						</div>
						<div id="button002" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="取消锁定" onclick="releaseTask()">
						</div>
						<div id="button003" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="删除" onclick="deleteTask()">
						</div>
						<div id="button004" class="matrixInline">
							<input type="button" class="x-btn cancel-btn " value="关闭" onclick="Matrix.closeWindow()">
						</div> 
					</td>
				</tr>
			</table>
	    </div>
	</form>
</body>
</html>