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
		background:#F8F8F8;
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
	function doubleClick2DeleteSelect(record){
/*		var items = MDataGrid005.getData();
		var newItem = [];
		if(record!=null){
			var recordId = record.userId;
			if(items!=null&&items.length>0){
				for(var i=0;i<items.length;i++){
					if(items[i].userId!=recordId){
						newItem.add(items[i]);
					}
				}
			}
		}
		MDataGrid005.setData(newItem);*/
	}
	function moveUp(){
		 //数据表格所有记录集合
        var items = Matrix.getAllDataGridData('DataGrid005');
         //获得选中的当前行
        var item = Matrix.getDataGridSelection('DataGrid005');
		if(item.length==1){
             var idx = MDataGrid005.getFocusRow(item);      
             if(idx!=0){
                 var targetItem=items.get(idx-1);
		    	 items.set(idx-1,item.get(0));
		    	 items.set(idx,targetItem);   
                 MDataGrid005.setData(items);
             }
         }else if(item.length==0){
                isc.warn("没有数据被选中，不能执行此操作。");
                return null;
         }else{
				isc.warn("只能选择一条数据进行上移操作!");
				return;
		}
	}
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
	function comfirmSelect(){
		var json = "";
		var way = document.getElementsByName("way");
		if(way!=null){
			if(way[0].checked){
				json = "{'flowType':'sequence',";//串行
			}else{
				json = "{'flowType':'split',";//默认是并行
			}
		}
		
		var items = MDataGrid005.getData();//获得所有选择的数据
		if(items!=null && items.length>0){
			var userIds = "";
			var userNames = "";
			for(var i= 0;i<items.length;i++){
				userIds+=items[i].userId;
				userNames+=items[i].userName;
				if(i!=items.length-1){
					userIds+=",";
					userNames+=",";
				}
				
			}
			json+="'userIds':'"+userIds+"',";
			json+="'userNames':'"+userNames+"'}";
		}else{
			Matrix.warn("请选择人员！");
			return;
		}
		var synJson = isc.JSON.decode(json);
		//json  flowType:xxx,userIds:xxx,userNames:xxx
		//Matrix.closeWindow(synJson);
		window.opener.addActivityCallBack(synJson);
		window.close();
		
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
					<!-- 标签页  机构/人员 -->
						<td id="td103" name="td103">
							<div class="main" style="width:100%;height:100%;">
    							<iframe id="main_iframe" src="tabPage.jsp" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>
						</td>
					<!-- 人员列表 -->
						<td id="td104" name="td104">
							<table id="table001" class="tableLayout" style="width:100%;height:100%;">
								<tr id="tr001">
									<td id="td001" class="tdLayout" colspan="3" rowspan="1" style="width:100%;height:94%;">
									<!-- 已选择的人员列表 -->
									<table style="width:100%;height:100%;"><tr><td style="width:100%;height:32px;">
							
										<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem001",
												icon:"[skin]/images/matrix/actions/move_up.png",
												title: "上移",
												showDisabledIcon:false,
												showDownIcon:false });
												MtoolBarItem001.click=function(){
													moveUp();
												}
										</script>
										<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem002",
												icon:"[skin]/images/matrix/actions/move_down.png",
												title: "下移",
												showDisabledIcon:false,
												showDownIcon:false });
												MtoolBarItem002.click=function(){
													moveDown();
												}
										</script>
										<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem003",	
												icon:"[skin]/images/matrix/actions/delete.png",
												title: "删除",showDisabledIcon:false,showDownIcon:false 
												});
												MtoolBarItem003.click=function(){
													var select  = MDataGrid005.getSelection();
													if(select!=null&& select.length>0){
														var record = select[0];
														doubleClick2DeleteSelect(record);
													}else{
														Matrix.warn("请先选择数据表格数据！");
													}
												}
										</script>
									<div id="QueryForm001_tb_div"  style="width:100%;height:32px;;overflow:hidden;"  ><script>isc.ToolStrip.create({ID:"MQueryForm001_tb",displayId:"QueryForm001_tb_div",width: "100%",height: "100%",position: "relative",members: [ MtoolBarItem001,MtoolBarItem002,MtoolBarItem003 ] });isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm001_tb.resizeTo(0,0);MQueryForm001_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div></td>
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
						{title:"编码",matrixCellId:"userId",name:"userId",canEdit:false,editorType:'InputHidden',type:'text'},
						{title:"姓名",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'}],
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
						exportCells:[{id:'userId',title:'编码'},{id:'userName',title:'姓名'}],
						showRecordComponents:true,showRecordComponentsByCell:true});
						isc.MatrixDataSource.create({ID:'MDataGrid005_custom_filter_ds',fields:[
						{title:"编码",name:"userId",type:'text',editorType:'InputHidden'},
						{title:"姓名",name:"userName",type:'text',editorType:'Text'}]});
						isc.FilterBuilder.create({ID:'MDataGrid005_custom_filter',dataSource:MDataGrid005_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
						isc.Button.create({ID:'MDataGrid005_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid005.hideCustomFilter()"});
						isc.Button.create({ID:'MDataGrid005_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid005_custom_filter.clearCriteria()"});
						isc.Button.create({ID:'MDataGrid005_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid005_custom_filter_window.hide()"});
						isc.Window.create({ID:'MDataGrid005_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid005_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid005_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid005_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid005_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid005_custom_filter.resizeTo('100%','100%');MDataGrid005_custom_filter_window.hide();isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid005.isMLoaded=true;MDataGrid005.draw();MDataGrid005.setData(MDataGrid005_DS);MDataGrid005.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid005.resizeTo(0,0);MDataGrid005.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid005'}</script></div>
		</td>							
		</tr></table>							
									</td>
								</tr>
								<tr id="tr002">
									<td id="td004" class="tdLayout" style="width:30%;height:32px;text-align:right;">
										<label id="label001" name="label001" id="label001">流转方式：</label>
									</td>
									<td id="td005" class="tdLayout" colspan="2" rowspan="1" style="width:70%;height:32px;">
									<!-- 流转方式单选按钮组 -->
										<span id="way_div" style="width:200px;"><table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;display: inline;" cellspacing="0" cellpadding="0">

<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="way_0_div" eventProxy="Mform0"></div>
<script> var way_0=isc.RadioItem.create({
					ID:"Mway_0",
					name:"way",
					editorType:"RadioItem",
					displayId:"way_0_div",
					value:"0",
					title:"串行",
					
					position:"relative",
					groupId:"way"
				});
				Mform0.addField(way_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="way_1_div" eventProxy="Mform0"></div>
<script> var way_1=isc.RadioItem.create({
					ID:"Mway_1",
					name:"way",
					editorType:"RadioItem",
					displayId:"way_1_div",
					value:"1",
					title:"并行",
					
					position:"relative",
					groupId:"way"
				});
				Mform0.addField(way_1);Mform0.setValue("way","0");</script></td>
</tr>

</table></span>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="tr102" name="tr102">
			<td id="td102" name="td102" style="width:100%;height:32px;">
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