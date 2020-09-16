<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<title></title>
	<style type="text/css">
#td103 {
	width: 35%;
	height: 100%;
	border: 2px #dedede solid;
}

#td104 {
	width: 65%;
	height: 100%;
	border: 2px #dedede solid;
}
/**表格的背景色**/
</style>
	<head>
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
		<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
		
		<script type="text/javascript">
var flag=false;
var selectUser = [];
var allData;
	/**function doubleClick2DeleteSelect(record){
		var items = MDataGrid005.getData();
		var newItem = [];
		if(record!=null){
			var reName = record.name;
			if(items!=null&&items.length>0){
				for(var i=0;i<items.length;i++){
					if(items[i].name!=reName){
						newItem.add(items[i]);
					}
				}
			}
		}
		MDataGrid005.setData(newItem);
	}**/
	//点击“>”按钮添加数据
	function addUser(){
		//main_iframe.contentWindow.setData();
		/**
		if(flag==true){
		MDataGrid005.setData([]);
		Matrix.refreshDataGridData("DataGrid005");
			flag=false;
		}**/
		 //var parentWindow=document.getElementById("main_iframe").contentDocument;
		 selectUser=[];
		 selectUser=document.getElementById("main_iframe").contentDocument.getElementsByTagName("iframe")[0].contentWindow.getSelection();
		if(selectUser!=null){
			var items = MDataGrid005.getData();
			for(var i=0;i<selectUser.length;i++){
			var result = isEcho(selectUser[i],items);
			if(!result){
				MDataGrid005.addData(selectUser[i]);
				MDataGrid005.redraw();
			}
			}
			//selectUser = [];
		}
	}
	//检查是否重复
	function isEcho(newData,gridDataList){
		for(var i = 0;i<gridDataList.size();i++){
			var data = gridDataList[i];
			if(data.formId==newData.formId){
				return true;
		}
		}
		return false;	
	}
		
	function removeUser(){
		var select = MDataGrid005.getSelection();
		if(select!=null && select.length>0){
			var items = MDataGrid005.getData();
			if(items!=null && items.length>0){
				for(var i = 0;i<items.length;i++){
					if(items[i].formId == select[0].formId){
						//items.remove(select[0]);
						Matrix.deleteDataGridData("DataGrid005");
						break;
					}
				}
			}
			
			MDataGrid005.setData(items);
			MDataGrid005.redraw();
		}
	}
	
	//确认选择
	function comfirmSelect(){
	Matrix.saveDataGridData("DataGrid005");
		var sublist='';
		var selectedItems = MDataGrid005.getData();
		if(selectedItems!=null && selectedItems.size()>0){
		var num=0;
			for(var i=0;i<selectedItems.size();i++){
			var arr=selectedItems[i].formId.split(".");
			if(arr[0]!='${param.formFlag}')
			{
				if(num==0){
					sublist=arr[0]
					num++;
				}
				if(arr[0]!=sublist){
				num++;
				}
			}
			}
			if(num>1){
				warn("只能选择一个子表下的数据");
			}else{
				parent.data =selectedItems; 
				parent.showListName=[];
				Matrix.closeWindow(selectedItems);
			}
		}else{
			Matrix.closeWindow(true);
		}
		
	}
	//下移
    function moveDown(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid005");
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
	}
//上移
    function moveUp(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid005");
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
	}
	function addAll(){
	if(allData!=null&&allData!=""&&allData!="null"){
	var items = MDataGrid005.getData();
			for(var i=0;i<allData.length;i++){
			var result = isEcho(allData[i],items);
			if(!result){
				MDataGrid005.addData(allData[i]);
				MDataGrid005.redraw();
			}
			}

	}
	}
	function delAll(){
	
	Matrix.getMatrixComponentById('DataGrid005').setData([]);
	MDataGrid005.redraw();
	
	}
</script>
	</head>
	<body style="overflow: hidden;">

		<div id='loading' name='loading' class='loading'>
			<script>Matrix.showLoading();</script>
		</div>
		<script> var Mform0=isc.MatrixForm.create({
	ID:"Mform0",
	name:"Mform0",
	position:"absolute",
	action:"",
	fields:[{name:'form0_hidden_text',
			 width:0,
			 height:0,
			 displayId:'form0_hidden_text_div'
	}]});
</script>
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action=""
				style="margin: 0px; overflow: hidden; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
		<div style="width: 100%; height: 100%; overflow: hidden; position: absolute;">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" id="dataGridId" name="dataGridId"
					value="DataGrid005" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<div style="width:100%;height:calc(100% - 48px);">
					<table id="table101" name="table101" style="width: 100%; height: 100%;">
					<tr id="tr101" name="tr101">
						<td id="td101" name="td101" style="width: 100%; height: 94%;">
							<table id="table102" name="table102"
								style="width: 100%; height: 100%;">
								<tr>
									<!-- 标签页  机构/人员/角色 -->
									<td id="td103" name="td103" style="width: 30%;">
										<div class="main" style="width: 100%; height: 100%;">
											<iframe id="main_iframe" src="<%=request.getContextPath()%>/form/admin/custom/utilization/tabPage.jsp?formId=${param.formId}&flag=${param.flag}"
												style="width: 100%; height: 100%;" frameborder="0"></iframe>
										</div>
									</td>

									<td id="td111" name="td111" width="10%" style="margin:0;padding:0;text-align:center;">
									<table id="table202" name="table202"
								style="width: 100%; height: 200px;">
							<tr id="tr201">
								<td id="td201" width="100%" >
									<div class="x-btn ok-btn" onclick="addAll();" style="width:22px;">
										<span>>></span>
									</div>
								</td>
							</td>
										
							<tr id="tr202">
								<td id="td202" width="100%">
									<div class="x-btn ok-btn" onclick="addUser();" style="width:22px;">
										<span>></span>
									</div>									
								</td>
							</tr>
							<tr id="tr203">
								<td id="td203" width="100%">
									<div class="x-btn ok-btn" onclick="removeUser();" style="width:22px;">
										<span><</span>										
									</div>									
								</td>
							</tr>
							<tr id="tr204">
								<td id="td204" width="100%">
									<div class="x-btn ok-btn" onclick="delAll();" style="width:22px;">
										<span><<</span>										
									</div>									
								</td>
							</tr>
							</table>
										</td>
									<!-- 人员列表 -->
									<td id="td104" name="td104" style="width: 60%;">
										<table id="table001" class="tableLayout"
											style="width: 100%; height: 100%;">
											<tr id="tr001">
												<td id="td001" colspan="3" rowspan="1"
													style="width: 100%; height: 94%;">
													<!-- 已选择的人员列表 -->
													<table style="width: 100%; height: 100%;">
														<tr>
															<td style="width: 100%; height: 30px;">
																<script>
					isc.ToolStripButton.create({
							ID:"MToolBarItem1",
							icon:Matrix.getActionIcon("move_up"),
							title: "上移",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	moveUp();
							}
					 });
					 
					 isc.ToolStripButton.create({
							ID:"MToolBarItem2",
							icon:Matrix.getActionIcon("move_down"),
							title: "下移",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	moveDown();
							}
					 });
					 
			     	</script>
																<div id="QueryForm002_tb_div"
																	style="width: 100%; height: 30px;; overflow: hidden;">
																	<script>isc.ToolStrip.create({
											ID:"MQueryForm002_tb",
											displayId:"QueryForm002_tb_div",
											width: "100%",height:"100%",
											position: "relative",
											members: [ 
												MToolBarItem1,
		    		   							"separator",
		    		   							MToolBarItem2,
											 ] });
												isc.Page.setEvent(isc.EH.RESIZE,function(){
													isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm002_tb.resizeTo(0,0);MQueryForm002_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);
									</script>
																</div>

															</td>
														</tr>
														<tr>
															<td colspan="2"
																style="border-style: none; width: 100%; margin: 0px; padding: 0px; height: 94%">
																<div id="DataGrid005_div" class="matrixComponentDiv"
																	style="width: 100%; height: 100%;">
																	<script> var MDataGrid005_DS=[];
						isc.MatrixListGrid.create( {
		ID:"MDataGrid005",
		name:"DataGrid005",
		canSort:false,
		width:"100%",
		height:"100%",
		displayId:"DataGrid005_div",
		position:"relative",
		width:'40%',
		showAllRecords:true,
		canHover:true,
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
		{title:"表单数据",matrixCellId:"name",name:"name",canEdit:false,editorType:'Text',type:'text'},  
		/*
		{title:"显示风格",
		 matrixCellId:"style",
		 name:"style",
	     canEdit:true,
	     editorType:'Text',
	     type:'text',
	     width:'20%',
		 editorProperties:{
			//是否可用
				isDisabled:function isc_FormItem_isDisabled(){
									var _2=this.form;_3=_2.grid;
									debugger;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _7 =_4.enType;
												var lengthList =[1,6,8,13,14];
												if((_7 &&lengthList.contains(_7))){
													return true;
				  			 						
										  		}
										  	}
										}
										var _1=this.disabled;
										if(!_1){
											if(this.parentItem!=null)
												_1=this.parentItem.isDisabled();
											else{
												_1=this.form.isDisabled();
												if(!_1&&this.containerWidget!=this.form)
												_1=this.containerWidget.isDisabled()
											}
										}
										return _1
									}}
	},
	{
			title : "选项",
			matrixCellId : "options",
			name : "options",
			canEdit:true,
			editorType:'PopupSelect',
			type:'text',
			width:'20%',
			///showHover:false,
			editorProperties:{
				isDisabled:function isc_FormItem_isDisabled(){
					debugger;
										var _2=this.form;_3=_2.grid;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _7 =_4.edType;
												if((_7 && _7!='comboBox')&&(_7 && _7!='radioGroup')&&(_7 && _7!='checkBoxGroup')&&(_7 && _7!='multiFilteringSelect')){
													
													return true;
				  			 					
										  		}else{
										  			return true;
										  		}
										  	}
										}
										var _1=this.disabled;
										if(!_1){
											if(this.parentItem!=null)
												_1=this.parentItem.isDisabled();
											else{
												_1=this.form.isDisabled();
												if(!_1&&this.containerWidget!=this.form)
												_1=this.containerWidget.isDisabled()
											}
										}
										return _1
									}
			}
			
			},{
			title : "宽度",
			matrixCellId : "width",
			name : "width",
			canEdit : true,
			editorType : 'Text',
			type : 'text',
			showHover:false,
			width : 30,
			validators:[{
					      		    type:"custom",
					      		    condition:function(item, validator, value, record){
					      		    	debugger;
					      		         var reg = new RegExp(/^(100|[1-9]?\d(\.\d\d?)?)%$/);
					      		         var num = new RegExp(/^[1-9]\d*$/);
					      		        //根据数据类型决定
					      		        if(value!=null&&value!=""){
					      		        if(reg.test(value)){			
					      		       			return true;
					      		        
					      		        }else{//不可用时 不校验
					      		       		 if(num.test(value)){
					      		       		 	return true;
					      		       		 }else{
					      		       		 errorMessage:"只能输入百分比或正整数!";
					      		        		return false;
					      		        	}
					      		        }
					      		        }
					      		     },
					      		     errorMessage:"只能输入百分比或正整数!"
				      		 }]
		}
		*/	
		],

		autoSaveEdits:false,
			  autoFetchData:true,
			  alternateRecordStyles:true,
			  showDefaultContextMenu:false,
			  canAutoFitFields:false,
			  startLineNumber:1,
			  isMLoaded : false,
			  canEdit:true,
			  selectionType: "multiple",
			  selectionAppearance : "rowStyle",
              canDragSelect: true,
              editEvent: "click",
			  showRecordComponents : true,
				showRecordComponentsByCell : true,
		exportCells : [ {
			id : 'name',
			title : '名称'
		}, {
			id : 'style',
			title : '显示风格'
		}, {
			id : 'options',
			title : '选项'
		}, {
			id : 'width',
			title : '宽度'
		}],
		showRecordComponents : true,
		showRecordComponentsByCell : true
	});
	isc.MatrixDataSource.create( {
		ID : 'MDataGrid005_custom_filter_ds',
		fields : [ {
			title : "名称",
			name : "name",
			type : 'text',
			editorType : 'Text'
		},  {
			title : "显示风格",
			name : "style",
			type : 'text',
			editorType : 'Text'
			},{
			title : "选项",
			name : "options",
			type : 'boolean',
			editorType : 'PopupSelect'
			},{
			title : "宽度",
			name : "width",
			type : 'text',
			editorType : 'Text'
			}]
	});
	isc.FilterBuilder.create( {
		ID : 'MDataGrid005_custom_filter',
		dataSource : MDataGrid005_custom_filter_ds,
		overflow : 'auto',
		topOperatorAppearance : "none"
	});
	isc.Button.create( {
		ID : 'MDataGrid005_custom_filter_btn',
		title : "确认",
		autoDraw : false,
		click : "MDataGrid005.hideCustomFilter()"
	});
	isc.Button.create( {
		ID : 'MDataGrid005_custom_filter_btn_reset',
		title : "重置",
		autoDraw : false,
		click : "MDataGrid005_custom_filter.clearCriteria()"
	});
	isc.Button.create( {
		ID : 'MDataGrid005_custom_filter_btn_cancel',
		title : "取消",
		autoDraw : false,
		click : "MDataGrid005_custom_filter_window.hide()"
	});
	isc.Window.create( {
		ID : 'MDataGrid005_custom_filter_window',
		title : "高级查询",
		autoCenter : true,
		overflow : "auto",
		isModal : true,
		autoDraw : true,
		height : 300,
		width : 500,
		showHover:true,
		canDragResize : true,
		showMaximizeButton : true,
		items : [ MDataGrid005_custom_filter ],
		showFooter : true,
		footerHeight : 20,
		footerControls : [ isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid005_custom_filter_btn, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid005_custom_filter_btn_reset, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid005_custom_filter_btn_cancel, isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}) ]
	});
	MDataGrid005_custom_filter.resizeTo('100%', '100%');
	MDataGrid005_custom_filter_window.hide();
	isc.Page.setEvent(isc.EH.LOAD,function(){
						 	MDataGrid005.isMLoaded=true;
						 	MDataGrid005.draw();
						 	MDataGrid005.setData(MDataGrid005_DS);
						 	MDataGrid005.resizeTo('100%','100%');
						 isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid005.resizeTo(0,0);MDataGrid005.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
						 if(Matrix.getDataGridIdsHiddenOfForm('form0')){
						 	Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid005'}
			</script>
																</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>									
							</table>
							</td>
							</tr>
							</table>
							</div>
							<div class="cmdLayout" style="width: calc(100% - 29px);">
								<div class="x-btn ok-btn" onclick="comfirmSelect();">
									<span>确认</span>
								</div>
								<div class="x-btn cancel-btn" onclick="Matrix.closeWindow();">
									<span>取消</span>
								</div>
							</div>		
						</div>					
					</form>
					
							<script>
function getParamsForDataGrid005_optionsDialog(grid,record,rowNum,columnNum){
var params='&';
var value;
return params;
}
isc.Window.create({
ID:"MDataGrid005_optionsDialog",
id:"DataGrid005_optionsDialog",
name:"DataGrid005_optionsDialog",
position:"absolute",
height: "85%",
width: "70%",
title: "选项",
autoCenter: true,
animateMinimize: false,
canDragReposition: true,
//targetDialog: "CodeMain",
showHeaderIcon:false,
showTitle:true,
showMinimizeButton:false,
showMaximizeButton:true,
showCloseButton:true,
showModalMask: false,
isModal:true,
autoDraw: false,
getParamsFun:getParamsForDataGrid005_optionsDialog,
initSrc:"<%=request.getContextPath()%>/form/admin/custom/queryList/options.jsp",
src:"<%=request.getContextPath()%>/form/admin/custom/queryList/options.jsp" });
function onDataGrid005_optionsDialogClose(data) {
		var record=Matrix.getDataGridSelection('DataGrid005');	
		var dataGrid = Matrix.getMatrixComponentById('DataGrid005');
		var editRowNum = dataGrid.getEditRow();	
		if (data == null)
			return true;
		if (data!= null) {
			record.options=data.info;
			dataGrid.setEditValue(editRowNum,"codeId",data.codeId);
			dataGrid.setEditValue(editRowNum,"dataType",data.dataType);
			dataGrid.setEditValue(editRowNum,"options",data.info);
				MDataGrid005.redraw();
			
		}

	}
</script>
							<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
<script type="text/javascript">
		   window.onload=function(){
				debugger;
				Matrix.saveDataGridData("DataGrid005");
				var selectedItems = MDataGrid005.getData();
				if(selectedItems==null || selectedItems.size()==0){
				if(parent.parent.showListName!=null&&parent.parent.showListName.length>0){
					var a = JSON.stringify(parent.parent.showListName);
					var b = JSON.parse(a);
					MDataGrid005.setData(b);
					Matrix.refreshDataGridData("DataGrid005");
					flag=true;
				}
			}
		}
</script>
	</body>
</html>