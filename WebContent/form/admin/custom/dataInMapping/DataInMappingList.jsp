<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<script type="text/javascript">
	//添加
    function add(){
             var src = webContextPath+"/mapping/dataMapping_loadCopySet.action?oType=add";
             Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
    }
    //点击跳转
    function onClick(){
    var selectData= MDataGrid001.getSelection();
     if(selectData.size()!=0&&selectData!=null){
     //var uuid=selectData[0].uuid;
     var index = MDataGrid001.getFocusRow() ;
             var src = webContextPath+"/mapping/dataMapping_getListById.action?oType=update&uuid="+index;
             Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
     }
    }
    //删除
     function del(){
    		 var selectList=Matrix.getDataGridSelection('DataGrid001');
    		  if(selectList.size()!=1){
          		 Matrix.warn('请选择一行数据！');}
			else{
    		 var uuid=selectList[0].uuid;
             var data2 = {'data':{'uuid':uuid}};
							var url = "<%=request.getContextPath()%>/mapping/dataMapping_delete.action";
							dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
							   	 	Matrix.refreshDataGridData('DataGrid001');
							   	 	var src = "<%=request.getContextPath()%>/editor/common/empty.html";
												Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
						      	  
						    }else{
						    	parent.isc.say('删除失败');
						    }
						    
							},null);}
    }
    //上移
    function moveUp(){
    	//页面移动
    	var index = MDataGrid001.getFocusRow() ;  //获取所选中的数据 index
    	var dataGrid = Matrix.getMatrixComponentById("DataGrid001");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			if(dataGrid.getSelection() && dataGrid.getSelection().length>1){
				isc.warn("只能选择一条数据进行上移操作!");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			var listSize = recordData.getLength();
			if(recordIndex>0){
			    recordIndex--;
			    //获取下条数据记录
			    var afterRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex+1,afterRecord);
			}
		}
		//后台数据移动
    		 var selectList=Matrix.getDataGridSelection('DataGrid001');
    		  if(selectList.size()!=1){
          		 Matrix.warn('请选择一行数据！');}
			else{
    		 var uuid=selectList[0].uuid;
             var data2 = {'data':{'uuid':index}};
							var url = "<%=request.getContextPath()%>/mapping/dataMapping_moveUp.action";
							dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
							   	 
						    }else{
						    	parent.isc.say('删除失败');
						    }
						    
							},null);}
    }
    //下移
    function moveDown(){
    	var dataGrid = Matrix.getMatrixComponentById("DataGrid001");
    	var index = MDataGrid001.getFocusRow() ;  //获取所选中的数据 index
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			if(dataGrid.getSelection() && dataGrid.getSelection().length>1){
				isc.warn("只能选择一条数据进行下移操作!");
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
    		 var selectList=Matrix.getDataGridSelection('DataGrid001');
    		  if(selectList.size()!=1){
          		 Matrix.warn('请选择一行数据！');}
			else{
    		 var uuid=selectList[0].uuid;
             var data2 = {'data':{'uuid':index}};
							var url = "<%=request.getContextPath()%>/mapping/dataMapping_moveDown.action";
							dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
						    }else{
						    	parent.isc.say('删除失败');
						    }
						    
							},null);}
    }
  //  window.onload=function(){
    	//Matrix.refreshDataGridData('DataGrid001');
  //  }
</script>
	</head>
	<body>
		<div id='loading' name='loading' class='loading'>
			<script>Matrix.showLoading();</script>
		</div>

		<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",
		name:"Mform0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/mapping/dataMapping_loadDataGrid.action",
		canSelectText : true,
		fields : [ {
			name : 'form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'form0_hidden_text_div'
		} ]
	});
</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>/mapping/dataMapping_loadDataGrid.action"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<input type="hidden" id="uuid" name="uuid">
				<input type="hidden" id="catalogId" name="catalogId"
					value="${param.catalogId}" />
				<input type="hidden" id="formId" name="formId"
					value="${param.formId}" />
				<div id="HorizontalContainer001_div" class="matrixInline"
					style="width: 100%; height: 100%;; overflow: hidden;">
					<script>
	isc.HLayout.create( {
		ID : "MHorizontalContainer001",
		displayId : "HorizontalContainer001_div",
		position : "relative",
		height : "100%",
		width : "100%",
		align : "center",
		overflow : "auto",
		defaultLayoutAlign : "center",
		members : [ isc.MatrixHTMLFlow.create( {
			ID : "MHorizontalContainer001Panel1",
			width : '21%',
			height : "100%",
			canSelectText : true,
			overflow : "hidden",
			showResizeBar : true,
			contents : "<div id='HorizontalContainer001Panel1_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
		}), isc.HTMLPane.create( {
			ID : "MHorizontalContainer001Panel2",
			height : "100%",
			overflow : "hidden",
			showEdges : false,
			contentsType : "page",
			contentsURL : ""
		}) ],
		canSelectText : true
	});
</script>
				</div>
				<div id="HorizontalContainer001Panel1_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">
					<table class="query_form_content"
						style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
						<tr>
							<td class="query_form_toolbar" colspan="2">
								<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem003",
												icon:"[skin]/images/matrix/actions/add.png",
												title: "",showDisabledIcon:false,showDownIcon:false });
								MtoolBarItem003.click=function(){
												Matrix.showMask();
												var x = eval("add();");
												if(x!=null && x==false){
												Matrix.hideMask();
												return false;}Matrix.hideMask();
												}</script>
								<script>isc.ToolStripButton.create({
								ID:"MtoolBarItem001",
								icon:"[skin]/images/matrix/actions/delete.png",
								title: "",
								showDisabledIcon:false,
								showDownIcon:false });
								MtoolBarItem001.click=function(){
								var _preReturn = Matrix.validateDataGridSelection('DataGrid001');; 
								if(_preReturn !=null&&_preReturn == false){
								return false;}
								Matrix.showMask();
								if(!true){
								Matrix.hideMask();
								return false;}
								if(!Mform0.validate()){
								Matrix.hideMask();
								return false;}
								var vituralbuttonHidden = document.getElementById('matrix_command_id');
								if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
								var currentForm = document.getElementById('form0');
								var buttonHidden = document.createElement('input');
								buttonHidden.type='hidden';
								buttonHidden.name='matrix_command_id';
								buttonHidden.id='matrix_command_id';
								buttonHidden.value='toolBarItem001';
								currentForm.appendChild(buttonHidden);
								isc.confirm("确认删除所选数据？","if(value){del();Matrix.queryDataGridData('DataGrid001');var _mgr=Matrix.convertDataGridDataOfForm('form0');if(_mgr!=null&&_mgr==false){Matrix.hideMask();return false;}Matrix.send('form0',{'toolBarItem003':'删除'},function(data){ Matrix.update(data); });}else{Matrix.hideMask();return false;}");
								Matrix.hideMask();}
								</script>
								<script>
					isc.ToolStripButton.create({
							ID:"MToolBarItem002",
							icon:Matrix.getActionIcon("move_up"),
							title: "",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	moveUp();
							}
					 });
					 
					 isc.ToolStripButton.create({
							ID:"MToolBarItem004",
							icon:Matrix.getActionIcon("move_down"),
							title: "",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	moveDown();
							}
					 });
					 
			     	</script>
								<div id="QueryForm001_tb_div"
									style="width: 100%; height: 38px;; overflow: hidden;">
									<script>isc.ToolStrip.create({
										ID:"MQueryForm001_tb",
										displayId:"QueryForm001_tb_div",
										width: "100%",
										height: "100%",
										position: "relative",
										members: [ MtoolBarItem003,MtoolBarItem001,MToolBarItem002,MToolBarItem004] });if(MHorizontalContainer001Panel1)if(!MHorizontalContainer001Panel1.customMembers)MHorizontalContainer001Panel1.customMembers=[];MHorizontalContainer001Panel1.customMembers.add(MQueryForm001_tb);isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm001_tb.resizeTo(0,0);MQueryForm001_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"
								style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
								<div id="DataGrid001_div" class="matrixComponentDiv"
									style="width: 100%; height: 100%;">
									<script>  
				var MDataGrid001_DS=<%=request.getAttribute("list")%>;
				isc.MatrixListGrid.create({ID:"MDataGrid001",
				name:"DataGrid001",
				displayId:"DataGrid001_div",
				position:"relative",
				width:"100%",
				height:"100%",
				showAllRecords:true,
				fields:[{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,
				autoFitEvent:'none',width:2,canEdit:false,canFilter:false,
				autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){
				if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
				{title:"名称",matrixCellId:"mappingName",name:"mappingName",canEdit:false,showHover:true,editorType:'Text',type:'text'}
				],
				autoSaveEdits:false,
				isMLoaded:false,
				autoDraw:false,
				autoFetchData:true,
				selectionType:"single",
				selectionAppearance:"rowStyle",
				alternateRecordStyles:true,
				showRollOver:true,
				//showRecordComponents:true,
				alternateRecordStyles:true,
				canSort:true,
				autoFitFieldWidths:false,
				click:function(record, rowNum, colNum){onClick();(record, rowNum, colNum);},
				startLineNumber:1,
				editEvent:"doubleClick",
				canCustomFilter:true,
				exportCells:[{id:'mappingName',title:'名称'}
				],
				showRecordComponents:true,showRecordComponentsByCell:true});
				isc.MatrixDataSource.create({ID:'MDataGrid001_custom_filter_ds',fields:[{title:"名称",name:"mappingName",type:'text',editorType:'Text'}]});
				isc.FilterBuilder.create({ID:'MDataGrid001_custom_filter',dataSource:MDataGrid001_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
				isc.Button.create({ID:'MDataGrid001_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid001.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid001_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid001_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid001_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid001_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid001_custom_filter.resizeTo('100%','100%');MDataGrid001_custom_filter_window.hide();if(MHorizontalContainer001Panel1)if(!MHorizontalContainer001Panel1.customMembers)MHorizontalContainer001Panel1.customMembers=[];MHorizontalContainer001Panel1.customMembers.add(MDataGrid001);isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},
				isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}</script>
								</div>
								<input id="DataGrid001_data_entity"
									name="DataGrid001_data_entity" value="" type="hidden" />
							</td>

						</tr>
					</table>

				</div>
				<script>
	document.getElementById('HorizontalContainer001Panel1_div').appendChild(
			document.getElementById('HorizontalContainer001Panel1_div2'));
</script>
				<%-- 
				<script>
	function getParamsForMainDialog() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MMainDialog",
		id : "MainDialog",
		name : "MainDialog",
		autoCenter : true,
		position : "absolute",
		height : "50%",
		width : "50%",
		title : "",
		canDragReposition : false,
		showMinimizeButton : true,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
		showFooter : false
	});
</script>
				<script>
	MMainDialog.hide();
</script>--%>
			</form>
		</div>
		<script>
	
	isc.Window.create({
			ID:"MmainDialog2",
			id:"mainDialog2",
			name:"mainDialog2",
			autoCenter: true,
			position:"absolute",
			height: "95%",
			width: "70%",
			title: "test",
			canDragReposition: true,
			showMinimizeButton:false,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel","maximizeButton",
				"closeButton"
			]
			
			//initSrc:
			//src:
	});
	MmainDialog2.hide();
	</script>
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>
