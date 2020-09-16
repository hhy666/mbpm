<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>多选人员（部门标签页详细）</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			function refreshDataGrid(node){
				var uuid = node.entityId;//树节点的主键
				Matrix.setFormItemValue('flag','refresh');
				Matrix.setFormItemValue('parentId',uuid);
				Matrix.refreshDataGridData("DataGrid001");
			}
	
		//双击部门下的人员
			function doubleClick2Select(record){
				var selectType = Matrix.getFormItemValue("selectType");
				if(selectType=='multi'){//多选用户
				 	var select  = MDataGrid001.getSelection();
					if(select!=null && select.length>0){
						var gridDataList = parent.parent.MDataGrid005.getData();
						var newData = {};
						newData.userId = select[0].userId;
						newData.userName = select[0].userName;
						newData.type = select[0].type;
						newData.userNo = select[0].userNo;
						var result = false;
						if(gridDataList!=null && gridDataList.size()>0){
							result = isEcho(newData,gridDataList);
						}
						if(!result){
							parent.parent.MDataGrid005.addData(newData);
							parent.parent.MDataGrid005.redraw();
						}
					}
				}else if(selectType=='single'){
					if(record!=null){
						//单选的时候  调用框架页面的saveUser来代替双击事件
						parent.parent.select = record;
						parent.parent.saveUser();
					}
				}
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
			var select =  MDataGrid001.getSelection();
			var selectType = Matrix.getFormItemValue('selectType');
			if(selectType=='multi'){
				if(select!=null && select.length>0){
					var record = select[0];
					parent.parent.selectUser = record;
				}
			}else if(selectType=='single'){
				if(select!=null && select.length>0){
					parent.parent.select = select[0];
				}
			}
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
 				//<%=request.getContextPath()%>/mobile/flowEdit_loadOrgTreeNodeByCondition.action
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
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid }">
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid001"/>
	<input type="hidden" id="flag" name ="flag" value="initLoad"/>
	<input type="hidden" id="parentId" name ="parentId"/>
	<input type="hidden" id="selectType" name="selectType" value="${param.selectType }"/>
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
						cellHeight:25,
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
								refreshDataGrid(node);
								//forwardPageByNodeType(node);
						},
						doubleClick:function(viewer, node, recordNum){
								//doubleClick2SelectDept(node);//双击选择部门
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
<tr id="tr002"><td id="td002" class="tdLayout" style="width:100%;height:50%;">
<input id="QueryField001" type="hidden" name="QueryField001" />
<table class="query_form_content" 
	style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	<tr>
	<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;">
	<div id="DataGrid001_div" class="matrixComponentDiv" style="width:100%;height:100%;">
	<script> var MDataGrid001_DS=<%=request.getAttribute("list")%>;
		isc.MatrixListGrid.create({
			ID:"MDataGrid001",name:"DataGrid001",
			displayId:"DataGrid001_div",
			position:"relative",
			width:"100%",
			height:"100%",
			fields:[
				{title:"用户名称",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'}],
			autoSaveEdits:false,
			isMLoaded:false,
			autoDraw:false,
			autoFetchData:true,
			selectionType:"single",
			showAllRecords:true,
			selectionAppearance:"rowStyle",
			canDragSelect:true,
			alternateRecordStyles:true,
			showRollOver:true,canSort:true,
			showHeader:false,autoFitFieldWidths:false,
			recordClick:function(){getSelection();},
			cellDoubleClick:function(record, rowNum, colNum){doubleClick2Select(record);(record, rowNum, colNum);},
			editEvent:"doubleClick",canCustomFilter:true,exportCells:[{id:'userName',title:'用户名称'},{title:"人员编码",name:"userId",type:'text',editorType:'Text'},
						 		{title:"登陆名称",name:"logonName",type:'text',editorType:'Text'}],
			showRecordComponents:true,showRecordComponentsByCell:true});
			isc.MatrixDataSource.create(
				{ID:'MDataGrid001_custom_filter_ds',
				fields:[{title:"用户名称",name:"userName",type:'text',editorType:'Text'}]});
			isc.FilterBuilder.create({
						 	ID:'MDataGrid001_custom_filter',
						 	dataSource:MDataGrid001_custom_filter_ds,
						 	topOperatorAppearance:"none"
						 });
						 isc.Button.create({
						 	ID:'MDataGrid001_custom_filter_btn',
						 	title:"确认",
						 	autoDraw:false,
						 	click:"MDataGrid001.hideCustomFilter()"
						 });
						 isc.Button.create({
						 	ID:'MDataGrid001_custom_filter_btn_cancel',
						 	title:"取消",
						 	autoDraw:false,
						 	click:"MDataGrid001_custom_filter_window.hide()"
						 });
						 isc.Window.create({
						 	ID:'MDataGrid001_custom_filter_window',
						 	title:"高级查询",
						 	autoCenter:true,
						 	overflow:"auto",
						 	isModal:true,
						 	autoDraw:false,
						 	height:300,
						 	width:500,
						 	canDragResize:true,
						 	showMaximizeButton:true,
						 	items: [MDataGrid001_custom_filter],
						 	showFooter:true,
						 	footerHeight:20,
						 	footerControls:[
						 		isc.HTMLFlow.create({
						 			width:'30%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		}),
						 		MDataGrid001_custom_filter_btn,
						 		isc.HTMLFlow.create({
						 			width:'5%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		}),
						 		MDataGrid001_custom_filter_btn_cancel,
						 		isc.HTMLFlow.create({
						 			width:'30%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		})
						 	]
						 });
						 isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');
						 isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
						 if(Matrix.getDataGridIdsHiddenOfForm('form0')){
						 	Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
			</script>
	</td>
	
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