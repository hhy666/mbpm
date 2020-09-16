<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>多选部门（部门标签页详细）</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			function refreshDataGrid(node){
				var uuid = node.entityId;//树节点的主键
				Matrix.setFormItemValue('flag','refresh');
				Matrix.setFormItemValue('parentId',uuid);
				Matrix.refreshDataGridData("DataGrid001");
			}
	
		
		
		//检查是否重复
		function isEcho(newData,gridDataList){
			for(var i = 0;i<gridDataList.size();i++){
				var data = gridDataList[i];
				if(data.userId==newData.userId){
					return true;
				}
			}
			return false;
		}
		
		//单击数据表格数据 获得选中的数据
		function getSelection(){
			var select =  MTree001.getSelection();
			if(select!=null && select.length>0){
				var record = {};
				record.sequenceId = select[0].entityId;
				record.depName = select[0].text;
				record.type = select[0].type;
				record.depId = select[0].sid;
				parent.selectUser = record;
			}
		}
		
		
		//检查是否重复
		function isEcho(newData,gridDataList){
			for(var i = 0;i<gridDataList.size();i++){
				var data = gridDataList[i];
				if(data.depId==newData.depId){
					return true;
				}
			}
			return false;
		}
		//双击部门
		function doubleClick2SelectDept(){
			var select  = MTree001.getSelection();
			if(select!=null && select.length>0){
				var gridDataList = parent.MDataGrid005.getData();
				var newData = {};
				newData.sequenceId = select[0].entityId;
				newData.depName = select[0].text;
				newData.type = select[0].type;
				newData.depId = select[0].sid;
				var result = false;
				if(gridDataList!=null && gridDataList.size()>0){
					result = isEcho(newData,gridDataList);
				}
				if(!result){
					parent.MDataGrid005.addData(newData);
					parent.MDataGrid005.redraw();
				}
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
 				action:"<%=request.getContextPath()%>/select/user_loadOrgTreeNodeByCondition.action",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 					}]
 				
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/select/user_loadOrgTreeNodeByCondition.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="mid" name="mid">
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid001"/>
	<input type="hidden" id="flag" name ="flag" value="initLoad"/>
	<input type="hidden" id="parentId" name ="parentId"/>
	
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
	<tr id="tr001">
	<td id="td001" class="tdLayout" style="width:100%;height:50%;">
	
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
						cellHeight:25,
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
									//getSelection(node);
								//refreshDataGrid(node);
								//forwardPageByNodeType(node);
						},
						doubleClick:function(viewer, node, recordNum){
								doubleClick2SelectDept(node);//双击选择部门
								//refreshDataGrid(node);
								//forwardPageByNodeType(node);
						},
						getIcon:function(node){//根据节点类型返回不同类型的icon
						  return getNodeIconByType(node);
						}
						
					});
					
					
					
					isc.Page.setEvent(isc.EH.LOAD,"MTree001.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MTree001.resizeTo(0,0);MTree001.resizeTo('100%','100%');",null);</script></div></td>
</tr>

</table>

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