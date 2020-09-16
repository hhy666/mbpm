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
	//重置搜索框与列表
	function refreshQuery(){
		document.getElementById('queryActPIID').value = '';
		document.getElementById('queryActAIID').value = '';
		document.getElementById('queryActName').value = '';
		document.getElementById('queryActDesc').value = '';
		Matrix.refreshDataGridData('DataGrid001');
	}
	
	//暂停活动实例
	function suspendActivityIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var status = select[0].STATUS;
				var aiid = select[0].ACTIVITY_INS_ID;
				var activityType = select[0].ACTIVITY_TYPE;
				if(activityType=="4"){
					if(status=="Ready"||status=="Claimed"||status=="Running"){
						var url = "<%=path%>/instance/activityInsAction_suspendActIns.action?aiid="+aiid;
			   			Matrix.sendRequest(url, null, function(data){
			   				Matrix.refreshDataGridData('DataGrid001');
			   			});
					}else{
						Matrix.warn("该状态的人工活动实例不允许执行暂停操作！");
						return false;
					}
				}else{
					Matrix.warn("只有人工活动实例可执行暂停操作，请重新选择！");
					return false;
				}
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要暂停的人工活动实例！");
		}
	}
	
	//恢复活动实例
	function resumeActivityIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var status = select[0].STATUS;
				var aiid = select[0].ACTIVITY_INS_ID;
				var activityType = select[0].ACTIVITY_TYPE;
				if(activityType=="4"){
					if(status == "Suspended"){
		   				var url = "<%=path%>/instance/activityInsAction_resumeActIns.action?aiid="+aiid;
		   				Matrix.sendRequest(url, null, function(data){
			   				Matrix.refreshDataGridData('DataGrid001');
			   			});
					}else{
						Matrix.warn("只有暂停状态下的人工活动实例可执行恢复操作！");
		    			return false;
		   			}
				}else{
					Matrix.warn("只有人工活动实例可执行恢复操作，请重新选择！");
					return false;
				}
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要恢复的人工活动实例！");
		}
	}
	
	
	//终止流程实例
	function terminateActivityIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var aiid = select[0].ACTIVITY_INS_ID;
				var status = select[0].STATUS;
				var activityType = select[0].ACTIVITY_TYPE;
				if(activityType=="4"){
					if(status!="Completed"&&status!="Terminated"){
						Matrix.confirm('确定要终止选择的人工活动实例吗？',function(data){
							if(!data){
								var url = "<%=request.getContextPath()%>/instance/activityInsAction_terminateActIns.action?aiid="+aiid;
								Matrix.sendRequest(url, null,function(data){
									Matrix.refreshDataGridData('DataGrid001');	
								});
							}
						});
		   		    }else{
						Matrix.warn("该状态下的人工活动实例不允许执行终止操作！！");
		    			return false;
					}
				}else{
				   Matrix.warn("只有人工活动实例可执行终止操作，请重新选择！");
		    	   return false;
				}
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要终止的人工活动实例！");
		}
	}
	
	
	//强制重启
	function forceRestart(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var aiid = select[0].ACTIVITY_INS_ID;
				var status = select[0].STATUS;
					if(status!="Completed"){
			    		Matrix.warn("选择的活动实例当前状态不能执行强制重启操作！");
			    		return false;
					}else{
						var url = "<%=path%>/instance/activityInsAction_forceRestartActIns.action?aiid="+aiid;
						Matrix.sendRequest(url, null,function(data){
							Matrix.refreshDataGridData('DataGrid001');	
						});
					}
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要重启的活动实例！");
		}
	}
	
	//强制回退
	function goback(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var aiid = select[0].ACTIVITY_INS_ID;
				var status = select[0].STATUS;
				//if(activityType=="4"){
					if(status=="Executed" || status=="Claimed" 
				    	|| status=="Completed" || status=="Terminated"){
			    		Matrix.warn("选择的活动实例当前状态不能执行强制回退操作！");
			    		return false;
					}else{
						var url = "<%=path%>/instance/activityInsAction_gobackActIns.action?aiid="+aiid;
						Matrix.sendRequest(url, null,function(data){
							Matrix.refreshDataGridData('DataGrid001');	
						});
					}
				/* }else{
				   Matrix.warn("只有人工活动实例可执行回退操作，请重新选择！");
		    	   return false;
				} */
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要回退的活动实例！");
		}
	}
	
	//强制完成
	function forceFinish(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var aiid = select[0].ACTIVITY_INS_ID;
				var adid = select[0].ACTIVITY_DEF_ID;
				var piid = select[0].PROCESS_INS_ID;
				var ptid = select[0].PROCESS_TMPL_ID;
				var status = select[0].STATUS;
				//if(activityType=="4"){
					if(status!="Ready" && status!="Executed" && status!="Claimed"){
			    		Matrix.warn("选择的活动实例当前状态不能执行强制完成操作！");
			    		return false;
					}else{
						layer.open({
							type:2,
							title:['强制完成活动实例'],
							area:['50%','60%'],
							content:"<%=path%>/instance/activityInsAction_getForceFinishInfo.action?iframewindowid=Finish&aiid="+aiid+"&adid="+adid+"&piid="+piid+"&ptid="+ptid
						});		
					}
				/* }else{
				   Matrix.warn("只有人工活动实例可执行回退操作，请重新选择！");
		    	   return false;
				} */
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要强制完成的的活动实例！");
		}
	}
	
	
	//强制完成回调
	function onFinishClose(data){
		if(data!=null){
			var url = "<%=path%>/instance/activityInsAction_forceFinishActIns.action";
			var params = "aiid="+data.aiid+"&transType="+data.transType+"&actDid="+data.actDid+"&transDid="+data.transDid;
			var src = url +'?'+ params;
			Matrix.sendRequest(src,null,function(data){
				Matrix.refreshDataGridData('DataGrid001');
			});
		}
	}
	
	//删除活动实例
	function deleteActivityIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var aiid = select[0].ACTIVITY_INS_ID;
				var url = "<%=path%>/instance/activityInsAction_deleteActIns.action?aiid="+aiid;
				Matrix.sendRequest(url, null,function(data){
					Matrix.refreshDataGridData('DataGrid001');	
				});
				/* }else{
				   Matrix.warn("只有人工活动实例可执行回退操作，请重新选择！");
		    	   return false;
				} */
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要删除的活动实例！");
		}
	}
	
	//任务列表
	function queryTask(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			var aiid = select[0].ACTIVITY_INS_ID;
			var status = select[0].STATUS;
	    	layer.open({
	    		type:2,
	    		title:['任务项列表'],
	    		area:['80%','95%'],
	    		content:"<%=path%>/instance/activityInsAction_queryTasks.action?iframewindowid=Task&aiid="+aiid+"&actStatus="+status
	    		
	    	});
		}else{
			isc.warn('请选择活动实例！');
			return false;
		}
	}
	
	//更新活动列表优先级
	function updatePriority(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var aiid = select[0].ACTIVITY_INS_ID;
				var status = select[0].STATUS;
				var priority = select[0].PRIORITY;
				//if(activityType=="4"){
					if(status=="InError" || status=="Terminated"|| status=="Executed" || status=="Completed"){
			    		Matrix.warn("选择的活动实例当前状态不能执行更新优先级操作！");
			    		return false;
					}else{
						layer.open({
			   				type:2,
			   				title:['设定活动实例优先级'],
			   				area:['50%','50%'],
			   				content:'<%=path%>/instance/processInstance_processInsPriorityRefreshto.action?iframewindowid=Priority&aiid='+aiid +'&priority='+priority
			   			});
					}
				/* }else{
				   Matrix.warn("只有人工活动实例可执行回退操作，请重新选择！");
		    	   return false;
				} */
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要更新优先级的活动实例！");
		}
	}
	
	//更新优先级回调
	function onPriorityClose(data, oType){
		if(oType==1){
			if(data!=null){
				var priority = data.priority;
				var aiid = data.aiid;
				var url ="<%=path%>/instance/activityInsAction_updateActInsPriority.action?aiid="+aiid+"&priority="+priority;
				Matrix.sendRequest(url,null,function(){
					Matrix.refreshDataGridData('DataGrid001');
				});
			}
		}
	}
	
	//监控活动实例
	function monitorProcessIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.lenght=1){
				var piid = select[0].PROCESS_INS_ID;
				//中止 暂停 错误 完成状态下不可以设置优先级
				if(piid!=null&&piid.length>0){
					var url ="<%=path%>/monitor/MonitorViewer.jsp?piid="+piid;
		   			window.open(url,"监控流程");
				}
			}else{
				Matrix.warn("只能选中一条活动实例！");
			}
		}else{
			Matrix.warn("请选中要监控的的活动实例！");
		}
	}
	
	//双击查看详细信息
	function viewDetail(aiid) {
		if(aiid!=null && aiid.trim().length>0){
			 layer.open({
					type:2,
					title:['流程实例详细信息'],
					area:['70%','90%'],
					content:"<%=path%>/instance/activityInsAction_loadActInsDetailMain.action?aiid="+aiid+"&detailType=activityIns"
				});		
		}
	}
	
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="padding-left:10px;margin: 0px; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
	    <input type="hidden" name="Form0" value="Form0" />
	    <input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
	    <input type="hidden" name="processDID" id="processDID" value="${requestScope.processDID}" />
	    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
		<div style="display: block;padding-top: 15px;height: 150px">
		    <table class="query_form_content" style="width: 100%; height: 100%;">
				<tr>
					<td style="" colspan="2">
						<table id="table001" jsId="table001" class="query_form_content" style="">
							<tr id="tr001" jsId="tr001" style="">
								<td id="td001" jsId="td001" class="query_form_label" colspan="1" rowspan="1">
									<label id="label001" name="label001"> 流程实例编码： </label>
								</td>
								<td id="td002" jsId="td002" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryActPIID" id="queryActPIID" >
									</div>
								</td>
								<td id="td003" jsId="td003" class="query_form_label" colspan="1" rowspan="1">
									<label id="label002" name="label002"> 活动实例编码： </label>
								</td>
								<td id="td004" jsId="td004" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryActAIID" id="queryActAIID" >
									</div>
								</td>
							</tr>
							<tr id="tr002" jsId="tr002" style="">
								<td id="td005" jsId="td005" class="query_form_label" colspan="1" rowspan="1">
									<label id="label003" name="label003"> 活动名称： </label>
								</td>
								<td id="td006" jsId="td006" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryActName" id="queryActName" >
									</div>
								</td>
								<td id="td007" jsId="td007" class="query_form_label" colspan="1" rowspan="1">
									<label id="label004" name="label004"> 描述： </label>
								</td>
								<td id="td008" jsId="td008" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryActDesc" id="queryActDesc" >
									</div>
								</td>
							</tr>
							<tr id="tr003" jsId="tr003" style="">
								<td class="td009" style="height: 10%;text-align:center;padding:10px;" colspan="4" >
									<div id="button1" class="matrixInline">
										<input type="button" class="x-btn ok-btn " value="查询" onclick="Matrix.refreshDataGridData('DataGrid001')">
									</div>
									<div id="button2" class="matrixInline">
										<input type="button" class="x-btn ok-btn " value="重置" onclick="refreshQuery()">
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
	    </div>
	    <div style="display: block;height: calc(100% - 150px - 54px);overflow: auto">
  			<table id="DataGrid001_table" style="width:100%;height:100%;">
				<script>
					$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/instance/activityInsAction_h5QueryActivityInses.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: true,
							clickToSelect: true, 
							sortable: false,   
							pagination: true,
							onDblClickRow:function(row){
								viewDetail(row.ACTIVITY_INS_ID);
							},
							queryParams: function(params){
								var param = {
									offset: params.offset,
									limit:params.limit,
								}
								param["queryActPIID"] = document.getElementById('queryActPIID').value;
								param["queryActAIID"] = document.getElementById('queryActAIID').value;
								param["queryActName"] = document.getElementById('queryActName').value;
								param["queryActDesc"] = document.getElementById('queryActDesc').value;
					            var form = document.getElementById('Form0');
					            var tagElements = form.getElementsByTagName('input');
					            for (var j = 0; j < tagElements.length; j++) {
					                param[tagElements[j].name] = tagElements[j].value;
					            };
								return param;
							},
							//singleSelect:true,
							//sortable:false,
							pageSize:10,
							pageList:[10,20,30,40],
							formatLoadingMessage: function() {
				            return '请稍等，正在加载中...';
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
								field:'ACTIVITY_INS_ID',
								title:'活动实例编码',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'ACTIVITY_NAME',
								title:'活动名称',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'DESCRIPTION',
								title:'描述',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'RECEIVED_DATE',
								title:'启动时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'EXPIRED_DATE',
								title:'完成期限',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'COMPLETED_DATE',
								title:'完成时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'PRIORITY',
								title:'优先级',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == 0) {
									    text = "普通";
									} else if (value == 1) {
									    text = "中级";
									} else if (value == 2) {
									    text = "高级";
									} else if (value == 3) {
									    text = "特级";
									}
									return text;
								}
							},{
								field:'STATUS',
								title:'状态',
								editorType:'Text',
								width:'5%',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == "Running") {
									    text = "运行";
									} else if (value == "Suspended") {
									    text = "暂停";
									} else if (value == "Completed") {
									    text = "完成";
									} else if (value == "Terminated") {
									    text = "终止";
									} else if (value == "Ready"){
										text = "就绪";
									} else if (value == "Claimed"){
										text = "锁定";
									} 
									return text;
								}
							}]
						});
					});
				</script>
			</table>
	    </div>
	    <div>
    		<table class="query_form_content" style="width: 100%; height: 100%;">
    			<tr>
    				<td class="cmdLayout" style="left:0px;text-align: -webkit-center;">
			    		<div id="button000" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="暂停" onclick="suspendActivityIns()">
						</div>
						<div id="button001" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="恢复" onclick="resumeActivityIns()">
						</div>
						<div id="button002" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="终止" onclick="terminateActivityIns()">
						</div>
						<div id="button003" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="强制重启" onclick="forceRestart()">
						</div>
						<!-- <div id="button004" class="matrixInline" style="position: relative; width: 85px; height: 30px;">
							<input type="button" class="x-btn ok-btn " value="回退" style="position:absolute;top:0;left:0;width:100%;height: 100%" onclick="goback()">
						</div> -->
						<div id="button005" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="强制完成" onclick="forceFinish()">
						</div>
						<div id="button006" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="删除" onclick="deleteActivityIns()">
						</div>
						<div id="button007" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="任务列表" onclick="queryTask()">
						</div>
						<div id="button008" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="优先级" onclick="updatePriority()">
						</div>
						<div id="button009" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="监控" onclick="monitorProcessIns()">
						</div>
					</td>
				</tr>
			</table>
	    </div>
	</form>
</body>
</html>