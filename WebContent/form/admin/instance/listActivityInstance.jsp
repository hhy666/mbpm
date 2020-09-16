<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>活动实例列表</title>
	<jsp:include page="/form/admin/common/taglib.jsp"/>
	<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
	var formDefaultAction = "<%=request.getContextPath()%>/instance/activityInsAction_queryActivityInses.action";
	//提交查询
	function submitQueryByPage(){
	    Matrix.queryDataGridData('DataGrid0');
		Matrix.send("Form0");
	}
	//重置查询输入框
	function  resetQueryInput(){
	 	MqueryActPIID.clearValue();
		MqueryActAIID.clearValue();
		MqueryActName.clearValue();
		MqueryActDesc.clearValue();
	 	
	}	
	//暂停活动实例 ACTIVITY_TYPE
	function suspend(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要暂停的人工活动实例！');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var aiid = record.ACTIVITY_INS_ID;
				if(aiid!=null&&aiid.trim().length>0){
					var activityType = record.ACTIVITY_TYPE;
					if(activityType=="4"){
						var status = record.STATUS;
						if(status=="Ready"||status=="Claimed"||status=="Running"){
							var url = "<%=request.getContextPath()%>/instance/activityInsAction_suspendActIns.action?aiid="+aiid;
							document.getElementById("Form0").action = url;
							Matrix.send("Form0");
							document.getElementById("Form0").action = formDefaultAction;
						}else{
			    			isc.warn("该状态的人工活动实例不允许执行暂停操作！");
			    			return false;
						
						}
					
					}else{
					   isc.warn("只有人工活动实例可执行暂停操作，请重新选择！");
			    	   return false;
					}
				
				}else{
					 isc.warn("请选择要暂停的人工活动实例！");
			    	  return false;
				}
			
			}
	
		}
	}
	//恢复流程实例
	function resumeProcessIns(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要恢复的人工活动实例！');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var aiid = record.ACTIVITY_INS_ID;
				if(aiid!=null&&aiid.trim().length>0){
					var activityType = record.ACTIVITY_TYPE;
					if(activityType=="4"){
						var status = record.STATUS;
						if(status=="Suspended"){
							var url = "<%=request.getContextPath()%>/instance/activityInsAction_resumeActIns.action?aiid="+aiid;
							document.getElementById("Form0").action = url;
							Matrix.send("Form0");
							document.getElementById("Form0").action = formDefaultAction;
						}else{
			    			isc.warn("只有暂停状态下的人工活动实例可执行恢复操作！");
			    			return false;
						
						}
					
					}else{
					   isc.warn("只有人工活动实例可执行恢复操作，请重新选择！");
			    	   return false;
					}
				
				}else{
					 isc.warn("请选择要恢复的人工活动实例！");
			    	  return false;
				}
			
			}
	
		}
	}
	
	
	//终止流程实例
	function terminate(){
	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要终止的人工活动实例！');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var aiid = record.ACTIVITY_INS_ID;
				if(aiid!=null&&aiid.trim().length>0){
					var activityType = record.ACTIVITY_TYPE;
					if(activityType=="4"){
						var status = record.STATUS;
						if(status!="Completed"){
							var url = "<%=request.getContextPath()%>/instance/activityInsAction_terminateActIns.action?aiid="+aiid;
							document.getElementById("Form0").action = url;
							Matrix.send("Form0");
							document.getElementById("Form0").action = formDefaultAction;
						}else{
			    			isc.warn("该状态下的人工活动实例不允许执行终止操作！");
			    			return false;
						
						}
					
					}else{
					   isc.warn("只有人工活动实例可执行终止操作，请重新选择！");
			    	   return false;
					}
				
				}else{
					 isc.warn("请选择要终止的人工活动实例！");
			    	  return false;
				}
			
			}
	
		}
	}
	
	// 强制重启
	function forceRestart(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要重启的活动实例！');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var aiid = record.ACTIVITY_INS_ID;
				if(aiid!=null&&aiid.trim().length>0){
					var status = record.STATUS;
					if(status!="Completed"){
			    		isc.warn("选择的活动实例当前状态不能执行强制重启操作！");
			    		return false;
						
					}else{
						var url = "<%=request.getContextPath()%>/instance/activityInsAction_forceRestartActIns.action?aiid="+aiid;
						document.getElementById("Form0").action = url;
						Matrix.send("Form0");
						document.getElementById("Form0").action = formDefaultAction;
					}
				
				}else{
					 isc.warn("请选择要重启的活动实例！");
			    	  return false;
				}
			
			}
	
		}
	
	
	}
	
	
	// 强制回退
	function goBack() {
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			var aiid = record.ACTIVITY_INS_ID;
			var status = record.STATUS;
			 if(status=="Executed" || status=="Claimed" 
	    	|| status=="Completed" || status=="Terminated"){
		    	isc.warn("选择的活动实例当前状态不能执行强制回退操作！");
		    	return false;
	        }
	        var url = "<%=request.getContextPath()%>/instance/activityInsAction_gobackActIns.action?aiid="+aiid;
			document.getElementById("Form0").action = url;
			Matrix.send("Form0");
			document.getElementById("Form0").action = formDefaultAction;
		
		}else{
			isc.warn('请选择要回退的活动实例！');
			return false;
		}
		
	}
	
	// 强制完成 
	function forceFinish() {
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			var aiid = record.ACTIVITY_INS_ID;
			var status = record.STATUS;
			 if(status!="Ready" && status!="Executed" && status!="Claimed"){
		    	isc.warn("选择的活动实例当前状态不能执行强制完成操作！");
		    	return false;
	        }
	        
	         var adid = record.ACTIVITY_DEF_ID;
	   		 var piid = record.PROCESS_INS_ID;
	    	 var ptid = record.PROCESS_TMPL_ID;
	    	 
	        var url = "<%=request.getContextPath()%>/instance/activityInsAction_getForceFinishInfo.action?aiid="+aiid+"&adid="+adid+"&piid="+piid+"&ptid="+ptid;
	        MDialog0.title ="强制完成活动实例";
		   	MDialog0.aiid = aiid;
		  
		   	MDialog0.initSrc = url;
		   	Matrix.showWindow("Dialog0");
	        
		}else{
			isc.warn('请选择要完成的活动实例！');
			return false;
		}
	
	}
	//强制完成 弹出框回调
	function onDialog0Close(data, oType){
		var aiid = MDialog0.aiid;
		if(aiid!=null){
			var action ="<%=request.getContextPath()%>/instance/activityInsAction_forceFinishActIns.action"; 
			if(data!=null){
				var params = "aiid="+aiid+"&transType="+data.transType+"&actDid="+data.actDid+"&transDid="+data.transDid;
				action = action+"?"+params;
				
				document.getElementById("Form0").action = action;
				Matrix.send("Form0");
				document.getElementById("Form0").action = formDefaultAction;
				return true;
			}
		}
	
		MDialog0.aiid = null;
		return true;
	}
	
	//删除流程实例
	function  deleteProcessIns(){
	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要删除的人工活动实例！');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var aiid = record.ACTIVITY_INS_ID;
				if(aiid!=null&&aiid.trim().length>0){
					var url = "<%=request.getContextPath()%>/instance/activityInsAction_deleteActIns.action?aiid="+aiid;
					document.getElementById("Form0").action = url;
					Matrix.send("Form0");
					document.getElementById("Form0").action = formDefaultAction;
				
				}else{
					 isc.warn("请选择要删除的人工活动实例！");
			    	  return false;
				}
			
			}
	
		}
	}
	
	
	
	//更新活动列表优先级
	function updatePriority(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn("请选择要设置优先级的流程实例！");
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var status = record.STATUS;
				var aiid = record.ACTIVITY_INS_ID;
				var priority = record.PRIORITY;
				//中止 暂停 错误 完成状态下不可以设置优先级
				if(status=="InError" || status=="Terminated"|| status=="Executed" || status=="Completed"){
	    			isc.warn("选择的流程实例当前状态下不能设置优先级！");
	    			return false;
	   			 }
	   			
	   			if(aiid!=null&&aiid.trim().length>0){
		   			var src = "<%=request.getContextPath()%>/form/admin/instance/prioritySetPage.jsp?priority="+priority;
		   			MDialog1.title ="设定流程实例优先级";
		   			MDialog1.aiid = aiid;
		   			MDialog1.initSrc = src;
		   			Matrix.showWindow("Dialog1");
		   			
	   			
	   			}
	   			
			}else{
				isc.warn('每次只能为一个流程实例设置优先级！');
			}
		
		}
	
	}
	
	//设置流程优先级 弹出框关闭触发
	function onDialog1Close(data, oType){
		if(oType==1){
			if(data!=null){
			    var priority = data;
				var aiid = MDialog1.aiid;
				var url ="<%=request.getContextPath()%>/instance/activityInsAction_updateActInsPriority.action?aiid="+aiid+"&priority="+priority;
				
				document.getElementById("Form0").action = url;
				Matrix.send("Form0");
				document.getElementById("Form0").action = formDefaultAction;
				
				MDialog1.aiid =null;
				return true;
			}
		
		}
		return true;
	}
	
	
	// 查看任务列表
	function queryTask(){
		//MDialogTaskList
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			var aiid = record.ACTIVITY_INS_ID;
			var status = record.STATUS;
	    	 
	        var url = "<%=request.getContextPath()%>/instance/activityInsAction_queryTasks.action?aiid="+aiid+"&actStatus="+status;
	        MDialogTaskList.title ="任务项列表";
		   //MDialog0.aiid = aiid;
		  
		   	MDialogTaskList.initSrc = url;
		   	Matrix.showWindow("DialogTaskList");
	        
		}else{
			isc.warn('请选择活动实例！');
			return false;
		}
	
	}
	
	
	
	//监控流程实例
	function monitorProcessIns(){
	    //MDialogMonitor
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn("请选择要监控的流程实例！");
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				
				var piid = record.PROCESS_INS_ID;
	   			
	   			if(piid!=null&&piid.length>0){
		   			//var src = "<%=request.getContextPath()%>/form/admin/instance/prioritySetPage.jsp?piid="+piid;
		   			var url =webContextPath+"/monitor/MonitorViewer.jsp?piid="+piid;
//		   			MDialogMonitor.title ="流程实例监控图";
		   			//MDialogMonitor.initSrc = src;
		   			//Matrix.showWindow("MDialogMonitor");
		   			 window.open(url,"监控流程");
	   			   
	   			}else{
	   				isc.warn("请选择要监控的流程实例！");
	   			}
	   			
			}else{
				isc.warn('每次只能监控一个流程实例！');
			}
		
		}
	
	}
	//流程实例迁移
	function upgrade(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要迁移的流程实例！');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var status = record.STATUS;
				var piid = record.PROCESS_INS_ID;
				var ptid = record.PROCESS_TMPL_ID;
				var pdid = record.PROCESS_DEF_ID;
				if(status != "Running"){
	    			isc.warn("选择的流程实例当前状态不能执行迁移操作！");
	    			return false;
	   			}
	   			
	   			if(piid!=null&&piid.length>0){
		   			var src = "<%=request.getContextPath()%>/process/processTmplAction_querySelectedPkgTemplates.action?upgradePkgTmplId=" + ptid + "&processId=" + pdid;
		   			
		   			MDialogUpgrade.piid = piid;
		   			MDialogUpgrade.initSrc = src;
		   			Matrix.showWindow("DialogUpgrade");
	   			
	   			}else{
	   				isc.warn('请选择要迁移的流程实例！');
	   			}
	   			
			}else{
				isc.warn('每次只能迁移一个流程实例！');
			}
		
		}
	
	}
	//关闭弹出框  迁移
	function onDialogUpgradeClose(data, oType){
		var targetPtid = data;
		//dojo.byId(curFormId).action = "processInsAction_upgradeProcessIns.action?piid=" + piid + "&targetPtid=" + targetPtid;
		if(targetPtid!=null && targetPtid.trim().length>0){
			var piid = MDialogUpgrade.piid;
			MDialogUpgrade.piid = null;
			var url = "<%=request.getContextPath()%>/instance/processInstance_upgradeProcessIns.action?piid=" + piid + "&targetPtid=" + targetPtid;
			document.getElementById("Form0").action = url;
			Matrix.send("Form0");
			document.getElementById("Form0").action = formDefaultAction;
			return true;
		}
		
		return true;
	}
	
	//播放流程
	function videoProcess(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要播放的流程实例！');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var status = record.STATUS;
				var piid = record.PROCESS_INS_ID;
				
	   			if(piid!=null&&piid.length>0){
		   		    
		   			var src = "<%=request.getContextPath()%>/process/processTmplAction_designProcess.action?simulationType=1&piid="+piid;
		   			
		   			MDialogVideo.initSrc = src;
		   			Matrix.showWindow("DialogVideo");
	   			
	   			}else{
	   				isc.warn('请选择要播放的流程实例！');
	   			}
	   			
			}else{
				isc.warn('每次只能播放一个流程实例！');
			}
		
		}
	
	}
	
	function onDialogVideoClose(data,oType){
		return true;
	}
	
	
	
	//查看活动实例详细
	function viewDetail(aiid) {
		if(aiid!=null && aiid.trim().length>0){
			 var src = "<%=request.getContextPath()%>/instance/activityInsAction_loadActInsDetailMain.action?aiid="+aiid+"&detailType=activityIns";
			 MDialogViewDetail.initSrc = src;
			 Matrix.showWindow('DialogViewDetail');
		}
	}
	
	
	</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"Form0",
	 		position:"absolute",
	 				
	 		action:"<%=request.getContextPath()%>/instance/activityInsAction_queryActivityInses.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
	  action="<%=request.getContextPath()%>/instance/activityInsAction_queryActivityInses.action" 
	  style="margin:0px;overflow:auto;width:100%;height:100%;"
	   enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
<input type="hidden" name="processDID" id="processDID" value="${requestScope.processDID}" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
			style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>




<table class="query_form_content" style="width:100%;height:100%;">
	<tr>
		<td style="height:120px;" colspan="2">
			<table id="j_id5" jsId="j_id5" class="query_form_content">
			
			   
			    <tr id="j_id6" jsId="j_id6" style="">
			        <td id="j_id7" jsId="j_id7" class="query_form_label" colspan="1" rowspan="1">
			            <label id="j_id8" name="j_id8">
			                流程实例编码：
			            </label>
			        </td>
			        <td id="j_id9" jsId="j_id9" class="query_form_input" colspan="1" rowspan="1">
			            <div id="queryActPIID_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var queryActPIID = isc.TextItem.create({
			                    ID: "MqueryActPIID",
			                    name: "queryActPIID",
			                    editorType: "TextItem",
			                    displayId: "queryActPIID_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: "100%"
			                });
			                MForm0.addField(queryActPIID);
			            </script>
			        </td>
			        <td id="j_id11" jsId="j_id11" class="query_form_label" colspan="1" rowspan="1">
			            <label id="j_id12" name="j_id12">
			               活动实例编码：
			            </label>
			        </td>
			        <td id="j_id13" jsId="j_id13" class="query_form_input" colspan="1" rowspan="1">
			            <div id="queryActAIID_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var queryActAIID = isc.TextItem.create({
			                    ID: "MqueryActAIID",
			                    name: "queryActAIID",
			                    editorType: "TextItem",
			                    displayId: "queryActAIID_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: "100%"
			                });
			                MForm0.addField(queryActAIID);
			            </script>
			        </td>
			    </tr>
			    
			     <tr id="j_id6" jsId="j_id6" style="">
			        <td id="j_id7" jsId="j_id7" class="query_form_label" colspan="1" rowspan="1">
			            <label id="j_id8" name="j_id8">
			                活动名称：
			            </label>
			        </td>
			        <td id="j_id9" jsId="j_id9" class="query_form_input" colspan="1" rowspan="1">
			            <div id="queryActName_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var queryActName = isc.TextItem.create({
			                    ID: "MqueryActName",
			                    name: "queryActName",
			                    editorType: "TextItem",
			                    displayId: "queryActName_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: "100%"
			                });
			                MForm0.addField(queryActName);
			            </script>
			        </td>
			        <td id="j_id11" jsId="j_id11" class="query_form_label" colspan="1" rowspan="1">
			            <label id="j_id12" name="j_id12">
			               描述：
			            </label>
			        </td>
			        <td id="j_id13" jsId="j_id13" class="query_form_input" colspan="1" rowspan="1">
			            <div id="queryActDesc_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var queryActDesc = isc.TextItem.create({
			                    ID: "MqueryActDesc",
			                    name: "queryActDesc",
			                    editorType: "TextItem",
			                    displayId: "queryActDesc_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: "100%"
			                });
			                MForm0.addField(queryActDesc);
			            </script>
			        </td>
			    </tr>
			    
			    
			    <tr id="j_id15" jsId="j_id15">
			        <td id="j_id16" jsId="j_id16" class="query_form_command" colspan="4" rowspan="1">
			            <div id="j_id17_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
			                <script>
			                    isc.Button.create({
			                        ID: "Mj_id17",
			                        name: "j_id17",
			                        title: "查询",
			                        panelID: "Mj_id2",
			                        displayId: "j_id17_div",
			                        position: "absolute",
			                        top: 0,
			                        left: 0,
			                        width: "100%",
			                        height: "100%",
			                        icon: Matrix.getActionIcon("query"),
			                        showDisabledIcon: false,
			                        showDownIcon: false,
			                        showRollOverIcon: false
			                    });
			                    Mj_id17.click = function() {
			                        Matrix.showMask();
			                       
			                        if(!MForm0.validate()) {
			                            Matrix.hideMask();
			                            return false;
			                        }
			                        submitQueryByPage();
			                        
			                        Matrix.hideMask();
			                    };
			                </script>
			            </div>
			            <div id="j_id18_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
			                <script>
			                    isc.Button.create({
			                        ID: "Mj_id18",
			                        name: "j_id18",
			                        title: "重置",
			                        panelID: "Mj_id2",
			                        displayId: "j_id18_div",
			                        position: "absolute",
			                        top: 0,
			                        left: 0,
			                        width: "100%",
			                        height: "100%",
			                        icon: Matrix.getActionIcon("exit"),
			                        showDisabledIcon: false,
			                        showDownIcon: false,
			                        showRollOverIcon: false
			                    });
			                    Mj_id18.click = function() {
			                        Matrix.showMask();
			                        resetQueryInput();
			                        Matrix.hideMask();
			                    };
			                </script>
			            </div>
			        </td>
			    </tr>
			</table>
		
		
		</td>
	</tr>
	
   <!-- 数据表格 -->
   <tr id="j_id7" jsId="j_id7">
				
		<td id="j_id9" jsId="j_id9"  rowspan="1" colspan="2" style="border-style:none;">
						<div id="DataGrid0_div" class="matrixComponentDiv" style="width:100%;height:100%;">
			<script>
		 	
							 	
				isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:true,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
	                        viewDetail(record.ACTIVITY_INS_ID);
	                     },
						fields:[{//行号
							title:"&nbsp;",
							name:"MRowNum",
							canSort:false,
							canExport:false,
							canDragResize:false,
							showDefaultContextMenu:false,
							autoFreeze:true,
							autoFitEvent:'none',
							width:45,
							canEdit:false,
							canFilter:false,
							autoFitWidth:false,
							formatCellValue:function(value, record, rowNum, colNum,grid){
									if(grid.startLineNumber==null)return '&nbsp;';
									return grid.startLineNumber+rowNum;
							}
						   },
						   {title:'活动实例编码',name:'ACTIVITY_INS_ID'}
						   ,
						   {title:'活动名称',width:'10%',name:'ACTIVITY_NAME'}
						   ,
						   {title:'描述',width:'15%',name:'DESCRIPTION'}
						   ,
						   {title:'启动时间',width:'10%',name:'RECEIVED_DATE'}
						   ,
						   {title:'完成期限',width:'10%',name:'EXPIRED_DATE'}
						   ,
						    {title:'完成时间',width:'10%',name:'COMPLETED_DATE'}
						   ,
						   
						   
						   {title:'优先级',name:'PRIORITY',width:'6%',
						   valueMap:{'0':'普通','1':'中级','2':'高级','3':'特级'}}
						   ,
						   {
						   	 title:'状态',
						  	 name:'STATUS',
						  	 width:'6%',
						     valueMap:{'Running':'运行','Suspended':'暂停','Completed':'完成','Terminated':'终止','Ready':'就绪'}
						   }
						   ,
						   {title:'活动类型',name:'ACTIVITY_TYPE',hidden:true},
						   {title:'活动定义编码',name:'ACTIVITY_DEF_ID',hidden:true},
						   {title:'流程编码',name:'PROCESS_INS_ID',hidden:true},
						   {title:'流程模板id',name:'PROCESS_TMPL_ID',hidden:true}
						   
		
						     
					 
					 ],
				  //设置UI组件和扩展组件关联关系
				  
				  autoSaveEdits:false,
				  autoFetchData:true,
				  alternateRecordStyles:true,
				  showDefaultContextMenu:false,
				  canAutoFitFields:false,
				  startLineNumber:1,
				  canEdit:false,
				  selectionType: "multiple",
	              canDragSelect: true,
	              editEvent: "click",
				  showRecordComponents:true,
				  showRecordComponentsByCell:true,
				  canEditCell2:function(rowNum, colNum){
	                   return this.Super("canEditCell", arguments);//默认处理
				  } 
				});
				
				MDataGrid0.setData(${requestScope.actInsData});
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
	     
	
	
			</script>
		</div>
		<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
		
		
		</td>
	</tr>
	
	<tr id="j_id40" jsId="j_id40">
                                        <td class="toolStrip"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;"><span
			id="DataPaginator0" class="paginator"><span
			id="DataPaginator0:status" class="paginator_status"></span></span> <script>
                                                isc.Page.setEvent("load", "Matrix.fillDataPaginator('DataPaginator0',${requestScope.curPageNum},${requestScope.totalPageNum},${requestScope.pageSize},'DataGrid0',${requestScope.totalSize})", isc.Page.FIRE_ONCE);
                                            </script>
                                        </td>
                                          <td class="toolStrip" align="right"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align: right; margin: 0px; padding: 0px;"><span
			id="DataPaginator1" class="paginator"><span
			id="DataPaginator1:first" class="paginator_first"><img
			id="DataPaginator1_fI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/first.gif"
			border="0" /></span><span id="DataPaginator1:previous"
			class="paginator_previous"><img id="DataPaginator1_pI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/pre.gif"
			border="0" /></span><span class='paginator_separator'><img
			src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
			border="0" /></span><span id="DataPaginator1:go" class="paginator_go"><span
			class="go_prefix">第</span><span id="DataPaginator1:goText"
			class="paginator_go_text"></span><span class="go_suffix">页</span></span><span
			class='paginator_separator'><img
			src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
			border="0" /></span><span id="DataPaginator1:next" class="paginator_next"><img
			id="DataPaginator1_nI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/next.gif"
			border="0" /></span><span id="DataPaginator1:last" class="paginator_last"><img
			id="DataPaginator1_lI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/last.gif"
			border="0" /></span><span class="paginator_clean"></span><span
			class='paginator_separator'><img
			src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
			border="0" /></span><span id="DataPaginator1:refresh"
			class="paginator_refresh"></span><span>&nbsp;&nbsp;</span> </span> <script>
                                             isc.Page.setEvent("load", "Matrix.fillDataPaginator('DataPaginator1',${requestScope.curPageNum},${requestScope.totalPageNum},${requestScope.pageSize},'DataGrid0',${requestScope.totalSize})", isc.Page.FIRE_ONCE);
                                            </script>
                                        </td>
                 </tr>
	
                                    
					<tr id="j_id35" jsId="j_id35">
                            	<td id="j_id36" jsId="j_id36" class="Toolbar" colspan="2" rowspan="1" align="center"
                           	 	style="border-style:none;height:25px;" height="25px">
                           			 <div id="CommandButton0_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton0",
                                            name: "CommandButton0",
                                            title: "暂停",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton0_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("add"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton0.click = function() {
                                            Matrix.showMask();
                                     
                                            if (!MForm0.validate()) {
                                                Matrix.hideMask();
                                                return false;
                                            }
                                            suspend();//暂停流程实例
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton1_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton1",
                                            name: "CommandButton1",
                                            title: "恢复",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton1_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("refresh"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton1.click = function() {
                                            Matrix.showMask();
                                     
                                            if (!MForm0.validate()) {
                                                Matrix.hideMask();
                                                return false;
                                            }
                                            resumeProcessIns();
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton2_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton2",
                                            name: "CommandButton2",
                                            title: "终止",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton2_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("add"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton2.click = function() {
                                            Matrix.showMask();
                                            terminate();//终止操作 支持多选
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton21_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton21",
                                            name: "CommandButton21",
                                            title: "强制重启",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton21_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("copy"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton21.click = function() {
                                            Matrix.showMask();
                                             forceRestart();
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div><div id="CommandButton22_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton22",
                                            name: "CommandButton22",
                                            title: "回退",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton22_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("copy"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton22.click = function() {
                                            Matrix.showMask();
                                            terminate();//终止操作 支持多选
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div><div id="CommandButton23_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton23",
                                            name: "CommandButton23",
                                            title: "强制完成",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton23_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("add"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton23.click = function() {
                                            Matrix.showMask();
                                            forceFinish();//终止操作 单选
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton3_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton3",
                                            name: "CommandButton3",
                                            title: "删除",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton3_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("delete"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton3.click = function() {
                                            Matrix.showMask();
                                     		deleteProcessIns();//删除流程实例
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton6_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton6",
                                            name: "CommandButton6",
                                            title: "任务列表",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton6_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("copy"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton6.click = function() {
                                            Matrix.showMask();
                                            queryTask();
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton4_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton4",
                                            name: "CommandButton4",
                                            title: "优先级",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton4_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("add"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton4.click = function() {
                                            Matrix.showMask();
                                     		updatePriority();
                                           
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton5_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton5",
                                            name: "CommandButton5",
                                            title: "监控",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton5_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("query"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton5.click = function() {
                                            Matrix.showMask();
                                       
                                            monitorProcessIns();//监控
                                            
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                
                            </td>
                        </tr>
						<tr><td style="height:5px"></td></tr>

</table>

</form>
<script type="text/javascript">
    //强制完成弹出框
	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "400",
		title: "",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialog0.hide();
	
	
	isc.Window.create({
		ID:"MDialog1",
		id:"Dialog1",
		name:"Dialog1",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "400",
		title: "",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialog1.hide();
	
	//监控弹出框
	isc.Window.create({
		ID:"MDialogMonitor",
		id:"DialogMonitor",
		name:"DialogMonitor",
		autoCenter: true,
		position:"absolute",
		height: "700",
		width: "520",
		title: "流程监控",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialogMonitor.hide();
	
	
	//upgrade()
	
	//迁移弹出框
	isc.Window.create({
		ID:"MDialogTaskList",
		id:"DialogTaskList",
		name:"DialogTaskList",
		autoCenter: true,
		position:"absolute",
		height: "450",
		width: "850",
		title: "任务列表",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialogTaskList.hide();
	
	//迁移弹出框
	isc.Window.create({
		ID:"MDialogVideo",
		id:"DialogVideo",
		name:"DialogVideo",
		autoCenter: true,
		position:"absolute",
		height: "500",
		width: "600",
		title: "播放流程实例",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialogVideo.hide();
	
	
	//ViewDetail
	
	//详情弹出框
	isc.Window.create({
		ID:"MDialogViewDetail",
		id:"DialogViewDetail",
		name:"DialogViewDetail",
		autoCenter: true,
		position:"absolute",
		height: "420",
		width: "600",
		title: "流程实例详细信息",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialogViewDetail.hide();

</script>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
</body>
</html>