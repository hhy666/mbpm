<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>流程属性结构树</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			//树节点单击事件 跳转到相应的页面
			function forwardPageByNode1(node){
				var entityId = node.entityId;//树节点id
				var activityId = Matrix.getFormItemValue('activityId');
				var parentNodeId = node.parentNodeId;
				if(entityId=='jbxx'){		 //基本信息
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/process_getCurProcessBasicPageInfo.action?processdid="+processdid;
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/process_getCurProcessBasicPageInfo.action?processdid="+processdid;
				}else if(entityId == 'lcbl'){//流程变量
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/process_getCurProcessVarible.action?processdid="+processdid;
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/process_getCurProcessVarible.action?processdid="+processdid;
				}else if(entityId == 'lcgl'){//流程管理
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/process_getCurProcessAdminList.action?processdid="+processdid;
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/process_getCurProcessAdminList.action?processdid="+processdid;
				}else if(entityId == 'jhsj'){//交互数据
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/";
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/";
				}else if(parentNodeId == 'fzsj'){//辅助事件
					var nodeId = node.entityId;
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/process_getAssistEventsById.action?entityId="+entityId+"&nodeId="+nodeId;
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/process_getAssistEventsById.action?entityId="+entityId+"&nodeId="+nodeId;
				}else if(parentNodeId == 'lctx'){//流程提醒
//				    parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/process_getProcessRemindById.action?entityId="+entityId+"&parentNodeId="+parentNodeId;
				    parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/process_getProcessRemindById.action?entityId="+entityId+"&parentNodeId="+parentNodeId;
				
				}else if(entityId == 'lcsx'){//流程时限
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/process_getCurProcessDuration.action";
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/process_getCurProcessDuration.action";
				}else if(entityId == 'kzsx'){//扩展属性
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/flow/expandAttributesTabPage.jsp";
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/flow/expandAttributesTabPage.jsp";
				}else if(entityId == 'gjsx'){//高级属性
//					parent.main_iframe1.src = "<%=request.getContextPath()%>/editor/process_getAdvancePropertyInfo.action";
					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/process_getAdvancePropertyInfo.action";
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
	<input type="hidden" id="processdid" name="processdid" value="${param.processdid }"/>
	<input type="hidden" id="activityId" name="activityId" value="${param.activityId }"/>
	<input type="hidden" id="type" name="type" value="${param.type }"/>
	
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