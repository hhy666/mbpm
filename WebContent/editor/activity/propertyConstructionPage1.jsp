<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>属性结构页面</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			//树节点单击事件
			function forwardPageByNode1(node){
				var entityId = node.entityId;//树节点id
				var activityId = Matrix.getFormItemValue('activityId');
				var optType = Matrix.getFormItemValue('optType');
				var parentNodeId = node.parentNodeId;
				if(entityId=='jbxx'){//基本信息
					var custom = Matrix.getFormItemValue('custom');
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getCurActivityBasicInfo.action?entityId="+entityId+"&activityId="+activityId+"&custom="+custom;
				}else if(entityId=='rwfp'){//任务分派
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getCurActivityTaskAssignInfo.action?entityId="+entityId+"&activityId="+activityId;
				}else if(entityId=='hdsx'){//活动时限
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getCurActivityDuration.action?entityId="+entityId+"&activityId="+activityId;
				}else if(entityId=='baohan'){//包含
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getActivityExecutorInfo.action?entityId="+entityId+"&activityId="+activityId;
				}else if(entityId=='paichu'){//排除
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getActivityNotExecutorInfo.action?entityId="+entityId+"&activityId="+activityId;
				}else if(entityId=='kzsx'){//扩展属性
					parent.main_iframe1.src  = "<%=request.getContextPath()%>/editor/activity/expandPropertyTabPage.jsp?entityId="+entityId+"&activityId="+activityId;
				}else if(entityId=='gjsx'){//高级属性
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getAdvancePropertyInfo.action?entityId="+entityId+"&activityId="+activityId;
				}else if(parentNodeId=='fzsj'){//辅助事件
					var nodeId = node.entityId;
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getAssistEventsById.action?entityId="+entityId+"&activityId="+activityId+"&nodeId="+nodeId;
				}else if(parentNodeId=='rwtx'){
					//活动提醒 根据点击的节点不同查询不同的提醒方式
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getActivityRemindById.action?entityId="+entityId+"&activityId="+activityId+"&parentNodeId="+parentNodeId+"&optType="+optType;
				}else if(entityId == 'dhdsl'){//多活动实例
					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/editor_getCurActivityMultiActInsInfos.action?entityId="+entityId+"&activityId="+activityId;
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
 				name:"MForm0",
 				position:"absolute",
 				//
 				action:"<%=request.getContextPath()%>/editor/unit_getEditInfoByUnit.action",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/editor/unit_getEditInfoByUnit.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input type="hidden" id="flag" name ="flag" value="initLoad"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="X-Requested-With" name="X-Requested-With" value="XMLHttpRequest">
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid004">
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/><input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input type="hidden" id="optType" name="optType" value="${param.optType }"/>
	
	
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
		<tr id="tr001">
			<td id="td001" class="tdLayout" style="width:100%;height:100%;">
				<!-- 属性结构树td -->
										<div id="Tree001_div" class="matrixComponentDiv">
	<script> isc.MatrixTree.create({	
								ID:"MTree001_DS",
						   		modelType:"children",
								ownerType:"tree",
								formId:"Form0",
								autoOpenRoot:true,
								ownerId:"Tree001",
								childrenProperty:"children",
								nameProperty:"text",
								root:{
									id:"RootTreeNode",
									entityId:"RootTreeNode",
									text:"RootTreeNode",
									type:0
								}
						});
		
		isc.MatrixTreeGrid.create({
						ID:"MTree001",
						name:"MTree001",
						height:"100%",
						width:"100%",
						displayId:"Tree001_div",
						position:"relative",
						showHeader:false,
						showHover:false,
						showCellContextMenus:true,
						leaveScrollbarGap:false,
						canAutoFitFields:true,
						wrapCells:false,
						fixedRecordHeights:true,
						selectionType:"single",
						selectionAppearance:"rowStyle",
						folderIcon:Matrix.getActionIcon("node"),
						data:MTree001_DS,
						autoFetchData:true,
						showOpenIcons:false,
						closedIconSuffix:'',
						showPartialSelection:false,
						cascadeSelection:false,
						border:0,
						onMoveUpAction:"true",
						onMoveDownAction:"true", 
						nodeContextClick:function(viewer, node, recordNum){
						               assignNodeMenu(viewer, node, recordNum);
						 
						},
						nodeClick:function(viewer, node, recordNum){
								//refreshDataGrid(node);
								
								forwardPageByNode1(node);
						},
						getIcon:function(node){//根据节点类型返回不同类型的icon
						  return getNodeIconByType(node);
						}
						
					});
					
					
					
					isc.Page.setEvent(isc.EH.LOAD,"MTree001.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MTree001.resizeTo(0,0);MTree001.resizeTo('100%','100%');",null);</script></div>
			</td>
		</tr>
	</table>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>


</div>

</body>
</html>