<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
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
		border:3px #dedede solid;
	}
	#td104{
		width:65%;
		height:100%;
		border:3px #dedede solid;
	}
	/**表格的背景色**/
	
	
</style>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
var selectUser = null;
	function doubleClick2DeleteSelect(record){
		var items = MDataGrid005.getData();
		var newItem = [];
		if(record!=null){
			var recordId = record.sequenceId;
			if(items!=null&&items.length>0){
				for(var i=0;i<items.length;i++){
					if(items[i].sequenceId!=recordId){
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
		document.getElementById("main_iframe").contentWindow.getSelection();
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
			if(data.sequenceId==newData.sequenceId){
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
					if(items[i].userNo == select[0].userNo){
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
	debugger;
		var selectedItems = MDataGrid005.getData();
		var depNames = "";
		var depIds = "";
		if(selectedItems!=null && selectedItems.length>0){
		for(var i=0;i<selectedItems.length;i++){
			depIds +=selectedItems[i].sequenceId;
				depNames +=selectedItems[i].depName;
				if(i<selectedItems.length-1){
					depIds+=",";
					depNames +=" ";	
				}
		}
		var data = {};
		data["depIds"] = depIds;
		data["depNames"] = depNames;
		data.clientId = document.getElementById('clientId').value;
		data.id = document.getElementById('id2').value;
		Matrix.closeWindow(data);
			
		}else{
		Matrix.warn("请选择部门！");
		return false;
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
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid }"/> 
	<input name="clientId" id="clientId" type="hidden"  value="${param.clientId}"/>
	<input name="id2" id="id2" type="hidden" value="${param.id}"/>
	<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	<table id="table101" name="table101" style="width:100%;height:100%;">
		<tr id="tr101" name="tr101">
			<td id="td101" name="td101" style="width:100%;height:94%;">
				<table id="table102" name="table102" style="width:100%;height:100%;">
					<tr>
					<!-- 标签页  机构/人员/角色 -->
						<td id="td103" name="td103" style="width:35%;">
							<div class="main" style="width:100%;height:100%;">
    							<iframe id="main_iframe" src="deptInfoTree.jsp" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>
						</td>
						<td id="td111" name="td111" style="width:5%;">
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
						<td id="td104" name="td104" style="width:60%;">
							<table id="table001" class="tableLayout" style="width:100%;height:100%;">
								<tr id="tr001">
									<td id="td001" class="tdLayout" colspan="3" rowspan="1" style="width:100%;height:94%;">
									<!-- 已选择的部门列表 -->
									<table style="width:100%;height:100%;"><tr><td style="width:100%;height:30px;">
							
										
									<div id="QueryForm002_tb_div"  style="width:100%;height:30px;;overflow:hidden;"  >
									<script>isc.ToolStrip.create({
											ID:"MQueryForm002_tb",
											displayId:"QueryForm002_tb_div",
											width: "100%",height:"100%",
											position: "relative",
											members: [ 
												isc.MatrixHTMLFlow.create({
													ID:"Mlabel002",
													contents:"<div  id='Mlabel002_div'  style='width:100px; margin-top:9px;'  class='toolBarItemOutputLabel' >&nbsp;选择结果</div>"}) ] });
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
							{title:"部门名称",matrixCellId:"depName",name:"depName",canEdit:false,editorType:'Text',type:'text'}
							//{title:"部门编码",matrixCellId:"depId",name:"depId",canEdit:false,editorType:'InputHidden',type:'text'}
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
						exportCells:[{id:'depId',title:'部门编码'},{id:'depName',title:'部门名称'}],
						showRecordComponents:true,showRecordComponentsByCell:true});
						isc.MatrixDataSource.create({ID:'MDataGrid005_custom_filter_ds',fields:[
						{title:"部门编码",name:"depId",type:'text',editorType:'InputHidden'},
						{title:"部门名称",name:"depName",type:'text',editorType:'Text'}
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
			<td id="td102" name="td102" style="width:100%;height:30px;" colspan="3">
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