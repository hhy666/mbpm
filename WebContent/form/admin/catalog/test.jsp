<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>目录管理</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	//上移操作	
	function onMoveUpRecord(){
	    
		var dataGrid = Matrix.getMatrixComponentById("MTree0");
		
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			if(recordIndex>0){
			    recordIndex--;
			    //获取上条数据记录
			    var preRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex+1,preRecord);
			    
			}
		}
	}
    
    
    
    //下移操作	
	function onMoveDownRecord(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			var listSize = recordData.getLength();
			if(recordIndex<listSize-1){
			    recordIndex++;
			    //获取上条数据记录
			    var afterRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex-1,afterRecord);
			}
		}
	}

</script>

</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
				ID:"MForm0",
				name:"MForm0",
				position:"absolute",
				action:"<%=request.getContextPath()%>/catalog_manageTree.action",
				fields:[{
					name:'Form0_hidden_text',
					width:0,height:0,
					displayId:'Form0_hidden_text_div'
					}]
	});
	
</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="./catalog_manageTree.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	
	<input type="hidden" name="Form0" value="Form0" />
	
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id9:j_id10" /> 
<input type="hidden" id="matrix_current_page_id" name="matrix_current_page_id" value="/console/testmodule/DynamicTree" />
<div id="Tree0_div" class="matrixComponentDiv" style="width: 270px; height: 282px;; position: relative;">
	
	<script> 
	  //定义树json对象格式
		isc.MatrixTree.create({
			 ID:"MTree0_DS",
			 modelType:"children",
			 ownerType:"tree",
			 formId:"Form0",
			 autoOpenRoot:false,
			 ownerId:"Tree0",
			 
			 childrenProperty:"children",
			 nameProperty:"text",
			 root:{
			 	id:"RootTreeNode",
			 	entityId:"RootTreeNode",
			 	text:"RootTreeNode"
			 }
		});		
		isc.Page.setEvent('load','MTree0_DS.openFolder(MTree0_DS.root)',isc.Page.FIRE_ONCE);
		
		isc.MatrixTreeGrid.create({
			ID:"MTree0",
			name:"Tree0",
			displayId:"Tree0_div",
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
			//后台接收data
			data:MTree0_DS,
			autoFetchData:true,
			showOpenIcons:false,
			closedIconSuffix:'',
			showPartialSelection:false,
			cascadeSelection:false,
			border:0
		});
		
		isc.Page.setEvent(isc.EH.LOAD,"MTree0.resizeTo('100%','100%');");
		isc.Page.setEvent(isc.EH.RESIZE,"MTree0.resizeTo(0,0);MTree0.resizeTo('100%','100%');",null);		
	</script>	
	</div>
</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
<script>
    //右键菜单定义
	isc.Menu.create({
		ID:"MTreeMenu0",
		autoDraw:false,
		showShadow:true,
		shadowDepth:10,
		data: [
			{title:"添加",icon:Matrix.getActionIcon("add"),click:""},
			{title:"删除",icon:Matrix.getActionIcon("delete"),click:"Matrix.removeUpTreeNode(target)"},
			{title:"刷新",icon:Matrix.getActionIcon("refresh"),click:"Matrix.refreshTreeNode(target)"},
			{title:"上移",icon:Matrix.getActionIcon("move_up"),click:"Matrix.moveUpTreeNode(target)"},
			{title:"下移",icon:Matrix.getActionIcon("move_down"),click:"Matrix.moveDownTreeNode(target)"}
		 ]
	  });
	  </script>
	</div>
</body>
</html>