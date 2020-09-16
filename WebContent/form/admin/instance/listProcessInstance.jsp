<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page
	import="com.matrix.api.MFExecutionService,com.matrix.api.identity.MFUser,com.matrix.client.ClientConstants"%>

<%
	MFExecutionService mfes = (MFExecutionService) session
			.getAttribute(ClientConstants.EXECUTION_SERVICE);
	MFUser user = mfes.getMFUser();
	String userId = user.getUserId();
%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程实例列表</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<script type="text/javascript">
	var formDefaultAction = "<%=request.getContextPath()%>/instance/processInstance_queryProcessInses.action";
	//提交查询
	function submitQueryByPage(){
	    Matrix.queryDataGridData('DataGrid0');
		Matrix.send("Form0");
	}	
	//重置查询框
	function resetQueryInput(){
		MqueryDesc.clearValue();
		MqueryPiid.clearValue();
	}
	//暂停流程实例
	function suspend(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要暂停的流程实例!');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var status = record.STATUS;
				var piid = record.PROCESS_INS_ID;
				if(status != "Running" && status!= "InError"){
	    			isc.warn("选择的流程实例当前状态下不能执行暂停操作！");
	    			return false;
	   			}
	   			
	   			if(piid!=null&&piid.length>0){
		   			var src = "<%=request.getContextPath()%>/form/admin/instance/deepSetPage.jsp";
		   			MDialog0.title ="设定是否包含子流程";
		   			MDialog0.piid = piid;
		   			MDialog0.procAction = "<%=request.getContextPath()%>/instance/processInstance_suspendProcessIns.action";
		   			MDialog0.initSrc = src;
		   			Matrix.showWindow("Dialog0");
	   			
	   			}
	   			
			}else{
				isc.warn('每次只能暂停一个流程实例！');
			}
		}
	
	}
	
	//恢复流程实例
	function resumeProcessIns(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var records = dataGrid.getSelection();
		
		if(records==null||records.length==0){
			isc.warn('请选择要恢复运行的流程实例!');
		}else{
			if(records.length==1){
				var recordStr = Matrix.itemsToJson(records[0],dataGrid);
				var record = isc.JSON.decode(recordStr);//获取选中数据
				var status = record.STATUS;
				var piid = record.PROCESS_INS_ID;
				if(status != "Suspended"){
	    			isc.warn("选择的流程实例当前状态下不能执行恢复运行操作！");
	    			return false;
	   			}
	   			
	   			if(piid!=null&&piid.length>0){
		   			var src = "<%=request.getContextPath()%>/form/admin/instance/deepSetPage.jsp";
		   			MDialog0.title ="设定是否包含子流程";
		   			MDialog0.piid = piid;
		   			MDialog0.procAction = "<%=request.getContextPath()%>/instance/processInstance_resumeProcessIns.action";
		   			MDialog0.initSrc = src;
		   			Matrix.showWindow("Dialog0");
	   			
	   			}
	   			
			}else{
				isc.warn('每次只能恢复运行一个流程实例！');
			}
		
		}
	}
	
	//弹出框 触发 暂停流程 范围选择
	function onDialog0Close(data, oType){
		if(oType==1){
			if(data!=null){
			    var isDeep = data;
				var piid = MDialog0.piid;
				MDialog0.piid =null;
				var procAction = MDialog0.procAction;
				MDialog0.procAction = null;
				var url = procAction+"?piid="+piid+"&isDeep="+isDeep;
				document.getElementById("Form0").action = url;
				Matrix.send("Form0");
				document.getElementById("Form0").action = formDefaultAction;
				return true;
			}
		
		}
		return true;
	}
	
	//终止流程实例
	function terminate(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordList = dataGrid.getSelection();
		var record =null;
		var status = null;
		var piid = null;
		
		if(recordList==null||recordList.length==0){
			isc.warn('请选择要终止的流程实例!');
			return false;
		}else{
		    var piids ="";
		    var flag = false;
			var recordListStr = Matrix.itemsToJson(recordList,dataGrid);
			var recordListJson = isc.JSON.decode("["+recordListStr+"]");//获取选中数据
			
			for(var i=0;i<recordListJson.length;i++){
					record = recordListJson[i];
					status = record.STATUS;
					
					piid = record.PROCESS_INS_ID;
					//完成的 流程实例 不可以被终止
					if(status!=null && !(status=="Running" || status=="InError" || status=="Suspended")){
					    
		    			flag = true;
		    			continue;
	    		    }
	    		    
	    		    if(piids!=""){
	    		       piids = piids + ",";
	    		    }
					piids = piids +piid;
			}
			
			//根据flag 和piids
			if(piids==""){
				if(flag){
					isc.warn("选择要终止的流程实例当前状态不能执行终止操作！");
	    			return false;
				}
				isc.warn("请选择要终止的流程实例！");
	    		return false;
			}
			
			isc.confirm('确定要终止选择的流程实例吗？',function(data){//true or null
		      if(data){
		        
		      	 var url = "<%=request.getContextPath()%>/instance/processInstance_terminateProcessIns.action?piids="+piids;
				 document.getElementById("Form0").action = url;
				 Matrix.send("Form0");
		         document.getElementById("Form0").action = formDefaultAction;                            		
		      }
                                    		 
        });
		
		}
	}
	
	//删除流程实例
	function  deleteProcessIns(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordList = dataGrid.getSelection();
		var record =null;
		var status = null;
		var piid = null;
		
		if(recordList==null||recordList.length==0){
			isc.warn('请选择要删除的流程实例！');
			return false;
		}else{
		    var piids ="";
		    var flag = false;
			var recordListStr = Matrix.itemsToJson(recordList,dataGrid);
			var recordListJson = isc.JSON.decode("["+recordListStr+"]");//获取选中数据
			
			for(var i=0;i<recordListJson.length;i++){
					record = recordListJson[i];
					status = record.STATUS;
					
					piid = record.PROCESS_INS_ID;
					//运行 暂停状态 不可以被删除
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
			
			//根据flag 和piids
			if(piids==""){
				if(flag){
					isc.warn("选择要删除的流程实例当前状态不能执行删除操作！");
	    			return false;
				}
				isc.warn("请选择要删除的流程实例！");
	    		return false;
			}
			
			isc.confirm('确定要删除选择的流程实例吗？',function(data){//true or null
		      if(data){
		        
		      	 var url = "<%=request.getContextPath()%>/instance/processInstance_deleteProcessIns.action?piids="+piids;
				 document.getElementById("Form0").action = url;
				 Matrix.send("Form0");
		         document.getElementById("Form0").action = formDefaultAction;                            		
		      }
                                    		 
        });
		
		}
	}
	//更新实例优先级
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
				var piid = record.PROCESS_INS_ID;
				var priority = record.PRIORITY;
				//中止 暂停 错误 完成状态下不可以设置优先级
				if(status=="InError" || status=="Terminated" || status=="Aborted" || status=="Completed"){
	    			isc.warn("选择的流程实例当前状态下不能设置优先级！");
	    			return false;
	   			 }
	   			
	   			if(piid!=null&&piid.length>0){
		   			var src = "<%=request.getContextPath()%>/form/admin/instance/prioritySetPage.jsp?priority="+priority;
		   			MDialog1.title ="设定流程实例优先级";
		   			MDialog1.piid = piid;
		   			MDialog1.procAction = "<%=request.getContextPath()%>/instance/processInstance_updateProcessInsPriority.action";
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
				var piid = MDialog1.piid;
				MDialog1.piid =null;
				var procAction = MDialog1.procAction;
				MDialog1.procAction = null;
				var url = procAction+"?piid="+piid+"&priority="+priority;
				document.getElementById("Form0").action = url;
				Matrix.send("Form0");
				document.getElementById("Form0").action = formDefaultAction;
				return true;
			}
		
		}
		return true;
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
		   			var url =webContextPath+"/monitor/MonitorViewer.jsp?piid="+piid;
		   			window.open(url,"监控流程");
		   			
//		   			var iHeight = 600;
	//				var iWidth = 820;
		//		    var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
			//		var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
				//	var property = "height="+iHeight+", width="+iWidth+",top="+iTop+",left="+iLeft+",toolbar=no, resizable=yes,menubar=no,scrollbars=yes, location=no, status=no,title=no"
		   			//window.open(url, "流程实例监控图", property);
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
	
	
	
	//查看流程实例详细
	function viewDetail(piid) {
		if(piid!=null && piid.trim().length>0){
			 var src = "<%=request.getContextPath()%>/instance/processInstance_loadProcInsDetailMainPage.action?piid="+piid+"&detailType=processIns";
			 MDialogViewDetail.initSrc = src;
			 Matrix.showWindow('DialogViewDetail');
		}
	}
	
	
	</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"Form0",
	 		position:"absolute",
	 				
	 		action:"<%=request.getContextPath()%>/instance/processInstance_queryProcessInses.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/instance/processInstance_queryProcessInses.action"
	style="margin: 0px; overflow: auto; width: 100%; height: 100%;" 
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" /> <input type="hidden" name="dataGridId"
	id="dataGridId" value="DataGrid0" /> <input type="hidden"
	name="processDID" id="processDID" value="${requestScope.processDID}" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>




<table class="query_form_content" style="width: 100%; height: 100%;">
	<tr>
		<td style="height: 100px;" colspan="2">
		<table id="j_id5" jsId="j_id5" class="query_form_content">
			<tr id="j_id6" jsId="j_id6" style="">
				<td id="j_id7" jsId="j_id7" class="query_form_label" colspan="1"
					rowspan="1"><label id="j_id8" name="j_id8"> 流程实例编码： </label></td>
				<td id="j_id9" jsId="j_id9" class="query_form_input" colspan="1"
					rowspan="1">
				<div id="queryPiid_div" eventProxy="MForm0" class="matrixInline"
					style=""></div>
				<script>
			                var queryPiid = isc.TextItem.create({
			                    ID: "MqueryPiid",
			                    name: "queryPiid",
			                    editorType: "TextItem",
			                    displayId: "queryPiid_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: "100%"
			                });
			                MForm0.addField(queryPiid);
			            </script></td>
				<td id="j_id11" jsId="j_id11" class="query_form_label" colspan="1"
					rowspan="1"><label id="j_id12" name="j_id12"> 描述： </label></td>
				<td id="j_id13" jsId="j_id13" class="query_form_input" colspan="1"
					rowspan="1">
				<div id="queryDesc_div" eventProxy="MForm0" class="matrixInline"
					style=""></div>
				<script>
			                var queryDesc = isc.TextItem.create({
			                    ID: "MqueryDesc",
			                    name: "queryDesc",
			                    editorType: "TextItem",
			                    displayId: "queryDesc_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: "100%"
			                });
			                MForm0.addField(queryDesc);
			            </script></td>
			</tr>
			<tr id="j_id15" jsId="j_id15">
				<td id="j_id16" jsId="j_id16" class="query_form_command" colspan="4"
					rowspan="1">
				<div id="j_id17_div" class="matrixInline matrixInlineIE"
					style="position: relative;; width: 100px;; height: 22px;"><script>
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
			                </script></div>
				<div id="j_id18_div" class="matrixInline matrixInlineIE"
					style="position: relative;; width: 100px;; height: 22px;"><script>
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
			                </script></div>
				</td>
			</tr>
		</table>


		</td>
	</tr>

	<!-- 数据表格 -->
	<tr id="j_id7" jsId="j_id7">

		<td id="j_id9" jsId="j_id9" rowspan="1" colspan="2"
			style="border-style: none;">
		<div id="DataGrid0_div" class="matrixComponentDiv"
			style="width: 100%; height: 100%;"><script>
		 	
							 	
				isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:true,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
	                        viewDetail(record.PROCESS_INS_ID);
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
						   {title:'流程实例编码',name:'PROCESS_INS_ID'}
						   ,
						   {title:'描述',width:'20%',name:'DESCRIPTION'}
						   ,
						   {title:'启动时间',width:'15%',name:'STARTED_DATE'}
						   ,
						   {title:'完成期限',width:'15%',name:'EXPIRED_DATE'}
						   ,
						   {title:'完成时间',width:'15%',name:'COMPLETED_DATE'}
						   ,
						   {title:'优先级',name:'PRIORITY',width:'6%',
						   valueMap:{'0':'普通','1':'中级','2':'高级','3':'特级'}}
						   ,
						   {
						   	 title:'状态',
						  	 name:'STATUS',
						  	 width:'6%',
						     valueMap:{'Running':'运行','Suspended':'暂停','Completed':'完成','Terminated':'终止'}},
						     {title:'模板ID',width:'20%',name:'PROCESS_TMPL_ID',hidden:true},
						      {title:'模板ID',width:'20%',name:'PROCESS_DEF_ID',hidden:true}
						     
						     
						  
					 
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
				
				MDataGrid0.setData(${requestScope.insListData});
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
	     
	
	
			</script></div>
		<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
		</td>
	</tr>

	<tr id="j_id40" jsId="j_id40">
		<td class="toolStrip"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;"><span
			id="DataPaginator0" class="paginator"><span
			id="DataPaginator0:status" class="paginator_status"></span></span> <script>
                                                isc.Page.setEvent("load", "Matrix.fillDataPaginator('DataPaginator0',${requestScope.curPageNum},${requestScope.totalPageNum},${requestScope.pageSize},'DataGrid0',${requestScope.totalSize})", isc.Page.FIRE_ONCE);
                                            </script></td>
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
                                            </script></td>
	</tr>


	<tr id="j_id35" jsId="j_id35">
		<td id="j_id36" jsId="j_id36" class="Toolbar" colspan="2" rowspan="1"
			align="center" style="border-style: none; height: 25px;"
			height="25px">
		<div id="CommandButton0_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
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
                                    </script></div>
		<div id="CommandButton1_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
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
                                    </script></div>
		<div id="CommandButton2_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
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
                                    </script></div>
		<div id="CommandButton3_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
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
                                    </script></div>

		<div id="CommandButton4_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
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
                                    </script></div>
		<div id="CommandButton5_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
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
                                    </script></div>
		<div id="CommandButton6_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
                                        isc.Button.create({
                                            ID: "MCommandButton6",
                                            name: "CommandButton6",
                                            title: "迁移",
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
                                            upgrade();//迁移
                                            Matrix.hideMask();
                                        };
                                    </script></div>
		<div id="CommandButton7_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
                                        isc.Button.create({
                                            ID: "MCommandButton7",
                                            name: "CommandButton7",
                                            title: "播放",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton7_div",
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
                                        MCommandButton7.click = function() {
                                            Matrix.showMask();
                                             videoProcess();
                                            Matrix.hideMask();
                                        };
                                    </script></div>
		</td>
	</tr>
	<tr>
		<td style="height: 5px"></td>
	</tr>

</table>

</form>
<script type="text/javascript">
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
		ID:"MDialogUpgrade",
		id:"DialogUpgrade",
		name:"DialogUpgrade",
		autoCenter: true,
		position:"absolute",
		height: "450",
		width: "520",
		title: "迁移流程实例",
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
	MDialogUpgrade.hide();
	
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
	
	//迁移弹出框
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

</script> <script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script></div>
</body>
</html>