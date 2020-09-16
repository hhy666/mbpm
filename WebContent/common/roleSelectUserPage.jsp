<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>按角色选择人员</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			//单击树节点 刷新数据表格
			function refreshDataGrid(node){
				var uuid = node.id;//树节点的主键
				Matrix.setFormItemValue('flag','refresh');
				Matrix.setFormItemValue('parentId',uuid);
				Matrix.refreshDataGridData("DataGrid003");
			}
			
			//双击部门下的人员
			function doubleClick2Select(record){
				var selectType = Matrix.getFormItemValue("selectType");
				if(selectType=='multi'){//多选用户
				 	var select  = MDataGrid003.getSelection();
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
					//单选的时候  调用框架页面的saveUser来代替双击事件
					if(record!=null){
						parent.parent.select = record;
						parent.parent.saveUser();
					}
				}
			}
			//单击数据表格数据 获得选中的数据
			function getSelection(){
				var selectType = Matrix.getFormItemValue("selectType");
				var select =  MDataGrid003.getSelection();
				if(selectType=='multi'){//多选用户
					if(select!=null && select.length>0){
						var record = select[0];
						parent.parent.selectUser = record;
					}
				}else if(selectType=='single'){
					if(select!=null && select.length>0){
						var record = select[0];
						parent.parent.select = record;
					}
				}
				
			}
		/*
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
			var select =  MDataGrid003.getSelection();
			if(select!=null && select.length>0){
				var record = select[0];
				parent.parent.selectUser = record;
			}
		}
		*/
		
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
 				action:"<%=request.getContextPath()%>/select/user_loadRoleTreeNodeByCondition.action",
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
	action="<%=request.getContextPath()%>/select/user_loadRoleTreeNodeByCondition.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="mid" name="mid">
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid003"/>
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid }">
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
	<div id="DataGrid003_div" class="matrixComponentDiv"
					style="width: 100%; height: 100%;"><script> var MDataGrid003_DS=<%=request.getAttribute("list")%>;
					isc.MatrixListGrid.create({
					ID:"MDataGrid003",
					name:"DataGrid003",
					displayId:"DataGrid003_div",
					position:"relative",
					width:"100%",height:"100%",
					fields:[
					{title:"用户名称",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'}
					],
					autoSaveEdits:false,
					isMLoaded:false,
					autoDraw:false,
					autoFetchData:true,
					selectionType:"single",
					selectionAppearance:"rowStyle",
					showAllRecords:true,
					canDragSelect:true,
					alternateRecordStyles:true,
					showRollOver:true,
					canSort:true,
					showHeader:false,
					autoFitFieldWidths:false,
					recordClick:function(){getSelection();},
					cellDoubleClick:function(record, rowNum, colNum){doubleClick2Select(record);(record, rowNum, colNum);},
					editEvent:"doubleClick",
					canCustomFilter:true,exportCells:[{id:'userName',title:'用户名称'}],
					showRecordComponents:true,
					showRecordComponentsByCell:true});
					isc.MatrixDataSource.create({
						ID:'MDataGrid003_custom_filter_ds',
						fields:[
						{title:"用户名称",name:"userName",type:'text',editorType:'Text'}]});
					isc.FilterBuilder.create({
						ID:'MDataGrid003_custom_filter',
						dataSource:MDataGrid003_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
					isc.Button.create({
						ID:'MDataGrid003_custom_filter_btn',
						title:"确认",
						autoDraw:false,
						click:"MDataGrid003.hideCustomFilter()"});
					isc.Button.create({
						ID:'MDataGrid003_custom_filter_btn_reset',
						title:"重置",
						autoDraw:false,
						click:"MDataGrid003_custom_filter.clearCriteria()"});
					isc.Button.create({
						ID:'MDataGrid003_custom_filter_btn_cancel',
						title:"取消",
						autoDraw:false,
						click:"MDataGrid003_custom_filter_window.hide()"});
					isc.Window.create({
						ID:'MDataGrid003_custom_filter_window',
						title:"高级查询",
						autoCenter:true,
						overflow:"auto",
						isModal:true,
						autoDraw:true,
						height:300,width:500,
						canDragResize:true,
						showMaximizeButton:true,
						items: [MDataGrid003_custom_filter],
						showFooter:true,footerHeight:20,
						footerControls:[
							isc.HTMLFlow.create({
								width:'30%',
								contents:"&nbsp;",
								autoDraw:false
							}),
							MDataGrid003_custom_filter_btn,
							isc.HTMLFlow.create({
								width:'5%',contents:"&nbsp;",autoDraw:false}),
							MDataGrid003_custom_filter_btn_reset,
							isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),
							MDataGrid003_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});
						MDataGrid003_custom_filter.resizeTo('100%','100%');
						MDataGrid003_custom_filter_window.hide();
						isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid003.isMLoaded=true;MDataGrid003.draw();MDataGrid003.setData(MDataGrid003_DS);MDataGrid003.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid003.resizeTo(0,0);MDataGrid003.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid003'}</script></div>
							
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