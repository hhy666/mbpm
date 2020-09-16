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
	#td102{
		background:#dedede;
		text-align:center;
	}
	#table101{
		/**border:3px #dedede solid;*/
	}
	#td103{
		width:35%;
		height:100%;
		border:2px #dedede solid;
	}
	#td104{
		width:65%;
		height:100%;
		border:2px #dedede solid;
	}
	/**表格的背景色**/
	
	
</style>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
var selectUser = null;
var flag=false;
window.onload=function(){
				debugger;
	if(parent.parent.parent.parent.customCondition!=null&&parent.parent.parent.parent.customCondition.length>0){
		MDataGrid005.setData(parent.parent.parent.parent.customCondition);
			Matrix.refreshDataGridData("DataGrid005");
			flag=true;
			}
		}
	function doubleClick2DeleteSelect(record){
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
	}
	//点击“>”按钮添加数据
	function addUser(){
		//main_iframe.contentWindow.setData();
		if(flag==true){
		MDataGrid005.setData([]);
		Matrix.refreshDataGridData("DataGrid005");
		flag=false;
		}
		if(selectUser!=null){
			var items = MDataGrid005.getData();
			var result = isEcho(selectUser,items);
			if(!result){
				MDataGrid005.addData(selectUser);
				MDataGrid005.redraw();
			}
			selectUser = null;
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
						items.remove(select[0]);
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
		var num=0;
		var selectedItems = MDataGrid005.getData();
		if(selectedItems!=null && selectedItems.size()>0){
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
		parent.parent.parent.parent.customCondition=[];
			Matrix.closeWindow(selectedItems);}
		}else{
			warn("请选择数据!");
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
</script>
</head>
<body style="overflow:hidden;">
	
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>
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
<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid005"/>
	<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
	<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	<table id="table101" name="table101" style="width:100%;height:100%;">
		<tr id="tr101" name="tr101">
			<td id="td101" name="td101" style="width:100%;height:94%;">
				<table id="table102" name="table102" style="width:100%;height:100%;">
					<tr>
					<!-- 标签页  机构/人员/角色 -->
						<td id="td103" name="td103" style="width:45%;">
							<div class="main" style="width:100%;height:100%;">
    							<iframe id="main_iframe" src="tabPage.jsp?formId=${param.formId}&flag=${param.flag}" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>
						</td>
						<td id="td111" name="td111" style="width:10%;">
						<div id="button003_div" class="matrixInline" style="width:32px;;position:relative;;height:22px;">
							<script>isc.Button.create({
											ID:"Mbutton003",
											name:"button003",
											title:">",
											displayId:"button003_div",
											position:"absolute",
											top:0,left:0,width:"100%",
											height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});
											Mbutton003.click=function(){
												Matrix.showMask();
												var x = eval("addUser();");
												if(x!=null && x==false){
													Matrix.hideMask();
													Mbutton002.enable();
													return false;
												}
												Matrix.hideMask();
											};
							</script>
						</div>
						<label id="label001" name="label001" id="label001"> <br/><br/></label>
					<div id="button004_div" class="matrixInline" style="width:32px;;position:relative;;height:22px;">
						<script>isc.Button.create({
									ID:"Mbutton004",
									name:"button004",
									title:"<",
									displayId:"button004_div",
									position:"absolute",
									top:0,left:0,width:"100%",
									height:"100%",
									showDisabledIcon:false,
									showDownIcon:false,
									showRollOverIcon:false
								});
								Mbutton004.click=function(){
									Matrix.showMask();
									var x = eval("removeUser();");
									if(x!=null && x==false){
										Matrix.hideMask();
										Mbutton001.enable();
										return false;
									}
									Matrix.hideMask();
								};
						</script>
					</div>
						</td>
					<!-- 人员列表 -->
						<td id="td104" name="td104" style="width:45%;">
							<table id="table001" class="tableLayout" style="width:100%;height:100%;">
								<tr id="tr001">
									<td id="td001" class="tdLayout" colspan="3" rowspan="1" style="width:100%;height:94%;">
									<!-- 已选择的人员列表 -->
									<table style="width:100%;height:100%;"><tr><td style="width:100%;height:30px;">
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
									<div id="QueryForm002_tb_div"  style="width:100%;height:30px;;overflow:hidden;"  >
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
<tr><td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;height:94%"><div id="DataGrid005_div" class="matrixComponentDiv" style="width:100%;height:100%;">
					<script> var MDataGrid005_DS=[];
					isc.MatrixListGrid.create({
						ID:"MDataGrid005",
						name:"DataGrid005",
						displayId:"DataGrid005_div",
						position:"relative",
						width:"100%",
						height:"100%",
						showAllRecords:true,
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                        		doubleClick2DeleteSelect(record);
                     		},
						fields:[
						{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
						{title:"表单数据",matrixCellId:"name",name:"name",canEdit:false,editorType:'Text',type:'text'},
						//{title:"工号",matrixCellId:"userNo",name:"userNo",canEdit:false,editorType:'InputHidden',type:'text'}
						//{title:"类型",matrixCellId:"type",name:"type",canEdit:false,editorType:'Text',type:'text',valueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'}}
						],
						
						autoSaveEdits:false,
						isMLoaded:false,
						autoDraw:false,
						autoFetchData:true,
						selectionType:"single",
						selectionAppearance:"rowStyle",
						alternateRecordStyles:true,showRollOver:true,
						canSort:false,autoFitFieldWidths:false,
						startLineNumber:1,editEvent:"doubleClick",
						canCustomFilter:false,
						exportCells:[{id:'formId',title:'表单号'},{id:'userName',title:'姓名'}],
						showRecordComponents:true,showRecordComponentsByCell:true});
						isc.MatrixDataSource.create({ID:'MDataGrid005_custom_filter_ds',fields:[
						{title:"表单数据",name:"name",type:'text',editorType:'Text'},
						//{title:"姓名",name:"userName",type:'text',editorType:'Text'}
						//{title:"类型",name:"type",type:'text',editorType:'Text'}
						]});
						isc.FilterBuilder.create({ID:'MDataGrid005_custom_filter',dataSource:MDataGrid005_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
						isc.Button.create({ID:'MDataGrid005_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid005.hideCustomFilter()"});
						isc.Button.create({ID:'MDataGrid005_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid005_custom_filter.clearCriteria()"});
						isc.Button.create({ID:'MDataGrid005_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid005_custom_filter_window.hide()"});
						isc.Window.create({ID:'MDataGrid005_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid005_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid005_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid005_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid005_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid005_custom_filter.resizeTo('100%','100%');MDataGrid005_custom_filter_window.hide();isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid005.isMLoaded=true;MDataGrid005.draw();MDataGrid005.setData(MDataGrid005_DS);MDataGrid005.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid005.resizeTo(0,0);MDataGrid005.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid005'}</script></div>
		</td>							
		</tr></table>							
			</td>
		</tr>
		</table>
		</td></tr>
								
		<tr id="tr102" name="tr102">
			<td id="td102" name="td102" style="width:100%;height:32px;" class="cmdLayout" colspan="3">
				<div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
					<script>
						isc.Button.create({
							ID:"Mbutton001",
							name:"button001",
							title:"确认",
							displayId:"button001_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton001.click=function(){
							Matrix.showMask();
							comfirmSelect();
							Matrix.hideMask();
							};
						</script>
					</div>
					<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
						<script>
							isc.Button.create({
								ID:"Mbutton002",
								name:"button002",
								title:"关闭",
								displayId:"button002_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								icon:"[skin]/images/matrix/actions/delete.png",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton002.click=function(){
								Matrix.showMask();
								//window.close();
								Matrix.closeWindow();
								Matrix.hideMask();
							};
						</script>
					</div>	
			</td>	
		</tr>
	
	</table>
			
			
</form>
</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>