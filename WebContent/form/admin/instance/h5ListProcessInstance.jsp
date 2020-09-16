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
		document.getElementById('queryPiid').value = '';
		document.getElementById('queryDesc').value = '';
		Matrix.refreshDataGridData('DataGrid001');
	}
	
	//暂停
	function suspendProcessIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.lenght=1){
				var status = select[0].STATUS;
				var piid = select[0].PROCESS_INS_ID;
				if(status != "Running" && status!= "InError"){
					Matrix.warn("该状态的流程实例不允许执行暂停操作！");
	    			return false;
				}
				
				if(piid!=null&&piid.length>0){
		   			layer.open({
		   				type:2,
		   				title:['设定是否包含子流程'],
		   				area:['50%','50%'],
		   				content:'<%=path%>/instance/processInstance_suspendRefreshto.action?iframewindowid=Suspend&piid='+piid
		   			});
				}
			}else{
				Matrix.warn("只能选中一条流程实例！");
			}
		}else{
			Matrix.warn("请选中要暂停的流程实例！");
		}
	}
	
	//暂停确认后提交数据
	function onSuspendClose(data,oType){
		if(oType==1){
			if(data!=null){
				var url = "<%=path%>/instance/processInstance_suspendProcessIns.action";
				Matrix.sendRequest(url,data,function(data){
					Matrix.refreshDataGridData('DataGrid001');
				});
			}
		}
		return true;
	}
	
	
	//恢复流程实例
	function resumeProcessIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.lenght=1){
				var status = select[0].STATUS;
				var piid = select[0].PROCESS_INS_ID;
				if(status != "Suspended"){
					Matrix.warn("该状态的流程实例不允许执行恢复操作！");
	    			return false;
				}
	   			if(piid!=null&&piid.length>0){
	   				layer.open({
		   				type:2,
		   				title:['设定是否包含子流程'],
		   				area:['50%','50%'],
		   				content:'<%=path%>/instance/processInstance_resumeRefreshto.action?iframewindowid=Resume&piid='+piid
		   			});
	   				
	   			}
	   			
			}else{
				Matrix.warn("只能选中一条流程实例！");
			}
		}else{
			Matrix.warn("请选中要恢复的流程实例！");
		}
	}
	
	//恢复确认后提交数据
	function onResumeClose(data,oType){
		if(oType==1){
			if(data!=null){
				var url = "<%=path%>/instance/processInstance_resumeProcessIns.action";
				Matrix.sendRequest(url,data,function(data){
					Matrix.refreshDataGridData('DataGrid001');
				});
			}
		}
		return true;
	}
	
	
	//终止流程实例
	function terminateProcessIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			var piids = "";
			var flag = false;
			for(var i=0;i<select.length;i++){
				var status = select[i].STATUS;
				var piid = select[i].PROCESS_INS_ID;
				if(status!=null && !(status=="Running" || status=="InError" || status=="Suspended")){
	    			flag = true;
	    			continue;
    		    }
				   if(piids!=""){
	    		       piids = piids + ",";
	    		    }
					piids = piids +piid;
   			}
			if(piids==""){
				if(flag){
					Matrix.warn("该状态的流程实例不允许执行终止操作！");
	    			return false;
				}
			}
			Matrix.confirm('确定要终止选择的流程实例吗？',function(data){
				if(!data){
					var url = "<%=path%>/instance/processInstance_terminateProcessIns.action?piids="+piids;
					Matrix.sendRequest(url, null,function(data){
						Matrix.refreshDataGridData('DataGrid001');
					});
				}
			});
		}else{
			Matrix.warn("请选中要终止的流程实例！");
		}
	}
	
	//删除流程实例
	function deleteProcessIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			var piids = "";
			var flag = false;
			for(var i=0;i<select.length;i++){
				var status = select[i].STATUS;
				var piid = select[i].PROCESS_INS_ID;
				if(status!=null && !(status=="InError" || status=="Terminated" 
					|| status=="Aborted" || status=="Completed")){
	    			flag = true;
	    			continue;
    		    }
				   if(piids!=""){
	    		       piids = piids + ",";
	    		    }
					piids = piids +piid;
   			}
			if(piids==""){
				if(flag){
					Matrix.warn("该状态的流程实例不允许执行删除操作！！");
	    			return false;
				}
			}
			Matrix.confirm('确定要删除选择的流程实例吗？',function(data){
				if(!data){
					var url = "<%=path%>/instance/processInstance_deleteProcessIns.action?piids="+piids;
					Matrix.sendRequest(url, null,function(data){
						Matrix.refreshDataGridData('DataGrid001');
					});
				}
			});
		}else{
			Matrix.warn("请选中要删除的流程实例！");
		}
	}
	
	//更新实例优先级
	function updatePriority(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.lenght=1){
				var status = select[0].STATUS;
				var piid = select[0].PROCESS_INS_ID;
				var priority = select[0].PRIORITY;
				//中止 暂停 错误 完成状态下不可以设置优先级
				if(status=="InError" || status=="Terminated" || status=="Aborted" || status=="Completed"){
	    			Matrix.warn("该状态的流程实例不允许执行设置优先级操作！");
	    			return false;
	   			 }
				
				if(piid!=null&&piid.length>0){
		   			layer.open({
		   				type:2,
		   				title:['设定流程实例优先级'],
		   				area:['50%','50%'],
		   				content:'<%=path%>/instance/processInstance_processInsPriorityRefreshto.action?iframewindowid=Priority&piid='+piid +'&priority='+priority
		   			});
				}
			}else{
				Matrix.warn("只能选中一条流程实例！");
			}
		}else{
			Matrix.warn("请选中要更改优先级的流程实例！");
		}
	}
	
	//更新优先级提交数据
	function onPriorityClose(data,oType){
		if(oType==1){
			if(data!=null){
				var url = "<%=path%>/instance/processInstance_updateProcessInsPriority.action";
				Matrix.sendRequest(url,data,function(data){
					Matrix.refreshDataGridData('DataGrid001');
				});
			}
		}
		return true;
	}
	
	//监控流程实例
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
				Matrix.warn("只能选中一条流程实例！");
			}
		}else{
			Matrix.warn("请选中要监控的的流程实例！");
		}
	}
	
	//迁移流程实例
	function upgradeProcessIns(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.lenght=1){
				var status = select[0].STATUS;
				var piid = select[0].PROCESS_INS_ID;
				var ptid = select[0].PROCESS_TMPL_ID;
				var pdid = select[0].PROCESS_DEF_ID;
				if(status != "Running"){
	    			isc.warn("该状态的流程实例不允许执行迁移操作！");
	    			return false;
	   			}
				if(piid!=null&&piid.length>0){
					layer.open({
						type:2,
						title:['流程迁移实例'],
						area:['80%','90%'],
						content:'<%=path%>/process/processTmplAction_querySelectedPkgTemplates.action?iframewindowid=Upgrade&upgradePkgTmplId=' + ptid + '&processId=' + pdid
					});				
				}
			}else{
				Matrix.warn("只能选中一条流程实例！");
			}
		}else{
			Matrix.warn("请选中要迁移的的流程实例！");
		}
	}
	
	function onUpgradeClose(){
		
		
	}
	
	//播放流程实例
	function videoProcess(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.lenght=1){
				var piid = select[0].PROCESS_INS_ID;
				if(piid!=null&&piid.length>0){
					layer.open({
						type:2,
						title:['播放流程实例'],
						area:['60%','80%'],
						content:'<%=path%>/process/processTmplAction_designProcess.action?simulationType=1&piid='+piid
					});				
				}
			}else{
				Matrix.warn("只能选中一条流程实例！");
			}
		}else{
			Matrix.warn("请选中要播放的的流程实例！");
		}
	}
	
	
	//双击查看流程实例详细
	function viewDetail(piid) {
		if(piid!=null && piid.trim().length>0){
			layer.open({
				type:2,
				title:['流程实例详细信息'],
				area:['70%','90%'],
				content:"<%=path%>/instance/processInstance_loadProcInsDetailMainPage.action?piid="+piid+"&detailType=processIns"
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
		<div style="display: block;padding-top: 15px;height: 110px">
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
										<input class="form-control" type="text" style="" name="queryPiid" id="queryPiid" >
									</div>
								</td>
								<td id="td003" jsId="td003" class="query_form_label" colspan="1" rowspan="1">
									<label id="label002" name="label002"> 描述： </label>
								</td>
								<td id="td004" jsId="td004" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryDesc" id="queryDesc" >
									</div>
								</td>
							</tr>
							<tr id="tr002" jsId="tr002" style="">
								<td class="td005" style="height: 10%;text-align:center;padding:10px;" colspan="4" >
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
	    <div style="display: block;height: calc(100% - 110px - 54px);overflow: auto">
  			<table id="DataGrid001_table" style="width:100%;height:100%;">
				<script>
					$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/instance/processInstance_h5QueryProcessInses.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: true,
							clickToSelect: true, 
							sortable: false,   
							pagination: true,
							onDblClickRow:function(row){
								viewDetail(row.PROCESS_INS_ID);
							},
							queryParams: function(params){
								var param = {
									offset: params.offset,
									limit:params.limit,
									processDID:document.getElementById('processDID').value
								}
								param["queryPiid"] = document.getElementById('queryPiid').value;
								param["queryDesc"] = document.getElementById('queryDesc').value;
					            var form = document.getElementById('Form0');
					            var tagElements = form.getElementsByTagName('input');
					            for (var j = 0; j < tagElements.length; j++) {
					                param[tagElements[j].name] = tagElements[j].value;
					            };
								return param;
							},
							//singleSelect:true,
							//sortable:false,
							pageSize:20,
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
								field:'PROCESS_INS_ID',
								title:'流程实例编码',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'DESCRIPTION',
								title:'描述',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'STARTED_DATE',
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
							<input type="button" class="x-btn ok-btn " value="暂停" onclick="suspendProcessIns()">
						</div>
						<div id="button001" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="恢复" onclick="resumeProcessIns()">
						</div>
						<div id="button002" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="终止" onclick="terminateProcessIns()">
						</div>
						<div id="button003" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="删除" onclick="deleteProcessIns()">
						</div>
						<div id="button004" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="优先级" onclick="updatePriority()">
						</div>
						<div id="button005" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="监控" onclick="monitorProcessIns()">
						</div>
						<div id="button006" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="迁移" onclick="upgradeProcessIns()">
						</div>
						<!-- 
						<div id="button007" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="重置" onclick="refreshQuery()">
						</div>
						 -->
					</td>
				</tr>
			</table>
	    </div>
	</form>
</body>
</html>