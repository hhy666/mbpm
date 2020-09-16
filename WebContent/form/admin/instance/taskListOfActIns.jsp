

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>任务列表</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">
	

		// 转交任务
		function transferTask() {
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			var record = dataGrid.getSelectedRecord();
			if(record!=null){
				var taskId = record.taskId;
				var taskType = record.taskType;
				
				 if(taskType!=1){
			    	isc.warn("该分派类型的任务不能转交！");
			    	return false;
		        }
		        var status = record.status;
		        
		        if(status!=1&&status!=2){
		        	isc.warn("该状态的任务项不能转交！");
			    	return false;
		        }
		        
		        var operation = "1";//转交
		        selectuser(taskId,operation);
				return ;
			}else{
				isc.warn('请选择要转交的工作任务项！');
				return false;
			}
		  
		}
		
		
		//选用户
		function selectuser(taskId,operation){
			 var url = "<%=request.getContextPath()%>/common/userSelected_loadUserTreePage.action";
//			 var url = "<%=request.getContextPath()%>/form/admin/instance/SelectUserList.jsp";
			 MDialogSelectUser.taskId = taskId;
			 MDialogSelectUser.operation = operation;//标识 转交和从新分配
			 MDialogSelectUser.initSrc = url;
			
			 Matrix.showWindow("DialogSelectUser");
			 return ;
		}
			//选用户2
		function selectuser2(aiid,operation){
			 //var url = "<%=request.getContextPath()%>/common/userSelected_loadUserTreePage.action";
//			 var url = "<%=request.getContextPath()%>/form/admin/instance/SelectUserList.jsp";
			var url = "<%=request.getContextPath()%>/common/userSelect.jsp";
			 MDialogSelectUser.operation = operation;//标识 转交和从新分配
			 MDialogSelectUser.initSrc = url;
			 MDialogSelectUser.aiid = aiid;
			 Matrix.showWindow("DialogSelectUser");
			 return ;
		}
		//选择用户回调
		function onDialogSelectUserClose(data, oType){
//			if(data!=null&&data.length>0){
			if(data!=null){
				//var userObj = isc.JSON.decode(data);
				//var userObj = data;
				var operation =MDialogSelectUser.operation;
				var aiid = document.getElementById("aiid").value;
				//var userId = userObj.id;
				var userId = data.userId;
				var taskId = null;
				if(operation=="1"){//转交任务
						var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
					    var record = dataGrid.getSelectedRecord();
						taskId = record.taskId;
				}
				if(taskId!=null&&taskId.trim().length>0){
					if(operation=="1"){//转交任务
						 var url = "<%=request.getContextPath()%>/instance/activityInsAction_transferTask.action?targetUserId="+userId+"&taskId="+taskId;
						 document.getElementById("Form0").action = url;
						 Matrix.send("Form0");
					}
				}else if(operation=="2"){//重新分配
						var url = "<%=request.getContextPath()%>/instance/activityInsAction_reassignTask.action?newOwner="+userId+"&aiid="+aiid;
						 document.getElementById("Form0").action = url;
						 
						 Matrix.send("Form0");
						
				}	 
			
			}
			return true;
		}
		
		// 重新分派任务
		function reassignTask(){
		var aiid = document.getElementById("aiid").value;
	
		        var operation = "2";//重新分派
		        selectuser2(aiid,operation);
			
			}
		
		
		// 删除工作任务
		function deleteTask(){
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			var record = dataGrid.getSelectedRecord();
			if(record!=null){
				var taskId = record.taskId;
				var taskType = record.taskType;
				 if(taskType!=1){
			    	isc.warn("该分派类型的任务是范围的任务项，不能删除！");
			    	return false;
		        }
		        
		         isc.confirm('确定要删除该任务吗?',function(data){//true or null
			      if(data){
			      
					Matrix.deleteDataGridData("DataGrid0");
								        
			        var url = "<%=request.getContextPath()%>/instance/activityInsAction_deleteTask.action?taskId="+taskId;
					document.getElementById("Form0").action = url;
					Matrix.send("Form0");
					
			      }
                                    		 
        		});
		        
		        
			
			}else{
				isc.warn('请选择要删除的工作任务项！');
				return false;
			}
		
		}
		
		// 取消检出工作任务
		function releaseTask(){
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			var record = dataGrid.getSelectedRecord();
			if(record!=null){
				var taskId = record.taskId;
				var status = record.status;
		        
		        if(status!=2){
		        	isc.warn("该工作任务当前状态不能执行取消检出操作！");
			    	return false;
		        }
		        
		        var url = "<%=request.getContextPath()%>/instance/activityInsAction_releaseTask.action?taskId="+taskId;
				document.getElementById("Form0").action = url;
				Matrix.send("Form0");
		        
			
			}else{
				isc.warn('请选择要取消检出的工作任务！');
				return false;
			}
		}
</script>
</head>

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto;">
<script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="aiid" id="aiid" value="${param.aiid}" />
	<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
	<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
    
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
</div>

<table id="table0css" jsId="table0css" class="maintain_form_content"
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
	
	<tr id="j_id5" jsId="j_id5">
		
		<td id="td13874300245170" jsId="td13874300245170" style="height:100%"
			class="maintain_form_input" colspan="1" rowspan="1" style="vertical-align:top">
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
	                        viewDetail(record.PROCESS_INS_ID);
	                     },
						fields:[
						/*
						{//行号
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
						   },*/
						   
						   {title:'任务项编码',name:'taskId'}
						   ,
						   {title:'分派方式',name:'taskType',width:'8%'}
						   ,
						   {title:'用户',name:'userName',width:'10%'}
						   ,
						   {title:'部门',name:'depName',width:'10%'}
						   ,
						   {title:'角色',name:'roleName'}
						   ,
						   {title:'拥有者',name:'ownerName',width:'10%'}
						   ,
						   {title:'状态',name:'status',width:'6%'}
						    ,
						   {title:'接收时间',name:'receivedDate'}
						    ,
						   {title:'完成时间',name:'expiredDate'}
						  
						   
					 
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
	              canDragSelect: false,
	              editEvent: "click",
				  showRecordComponents:true,
				  showRecordComponentsByCell:true,
				  canEditCell2:function(rowNum, colNum){
	                   return this.Super("canEditCell", arguments);//默认处理
				  } 
				});
				if("${requestScope.tasksJson}".length>0){
					MDataGrid0.setData(${requestScope.tasksJson});
				}
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
	     
	
			</script>
		</div>
		<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
		
		
		</td>
	</tr>
	
	<tr id="j_id9" jsId="j_id9" height="20px">
		<td id="j_id10" jsId="j_id10" class="maintain_form_input" 
			rowspan="1"> <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem0",
                                    icon:Matrix.getActionIcon("copy"),
                                    title: "转交任务",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem0.click = function() {
                                    Matrix.showMask();
                                   transferTask();
                                    Matrix.hideMask();
                                }
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem1",
                                    icon:Matrix.getActionIcon("copy"),
                                    title: "重新安排",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem1.click = function() {
                                    Matrix.showMask();
                                    reassignTask();
                                    Matrix.hideMask();
                                }
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem2",
                                    icon:Matrix.getActionIcon("copy"),
                                    title: "取消锁定",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem2.click = function() {
                                    Matrix.showMask();
                                   releaseTask();
                                    Matrix.hideMask();
                                }
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem3",
                                    icon:Matrix.getActionIcon("delete"),
                                    title: "删除",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem3.click = function() {
                                    Matrix.showMask();
                                    deleteTask();
                                    Matrix.hideMask();
                                }
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem4",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "关闭",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem4.click = function() {
                                    Matrix.showMask();
                                    Matrix.closeWindow(null,0);
                                    Matrix.hideMask();
                                }
                            </script>
                            
		<div id="ToolBar0_div" style="width: 100%; overflow: hidden;"><script>
                                    isc.ToolStrip.create({
                                        ID: "MToolBar0",
                                        displayId: "ToolBar0_div",
                                        width: "100%",
                                        height: "*",
                                        position: "relative",
                                        align: "center",
                                         members: [MToolBarItem0,MToolBarItem1,MToolBarItem2,MToolBarItem3,MToolBarItem4]
                                    });
                                    isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                </script></div>
		</td>
	</tr>
</table>
<script>
   //转交任务弹出框
	isc.Window.create({
		ID:"MDialogSelectUser",
		id:"DialogSelectUser",
		name:"DialogSelectUser",
		targetDialog:"ProcInsTarget",
		autoCenter: true,
		position:"absolute",
		height: "400",
		width: "500",
		title: "选择用户",
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
	MDialogSelectUser.hide();   
	          
</script>
	
	</form>
<script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script></div>
 
</body>

</html>
</span>


