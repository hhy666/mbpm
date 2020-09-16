<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="org.python.core.exceptions"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="javax.matrix.faces.context.MFacesContext"%>
<%@page import="com.matrix.form.admin.custom.trigger.model.FormTrigger"%>
<%@page import="com.matrix.form.admin.custom.helper.CommonHelper"%>

<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<head>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<script>
    //点击添加按钮
    function clickAdd(){
    		
    		Matrix.refreshDataGridData('DataGrid001');
            var src = webContextPath+"/trigger/formProcessor_loadEventInfoPage.action?optString=0";
            Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
     }
    function postDelete(){
       var src = webContextPath+"/form/admin/custom/trigger/blankPage.jsp";
            Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src); 
    }
    function deleteSelection(){
    	var url = "<%=request.getContextPath()%>/trigger/formProcessor_delete.action";
    	
    	alert('deleteSelection...');
    }
    //点击数据行触发的方法
    function onCellClick(){
        var select = MDataGrid001.getSelection();
        if(select != null && select.length > 0){
            var index = MDataGrid001.getFocusRow() ;
            var src = webContextPath+"/trigger/formProcessor_loadEventInfoPage.action?index="+index+"&optString=1";
            Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
        }
    }
    function loadFreshPage(index){
   		var record = MDataGrid001.getData()[index];
   		record._selection_1=true;
        var src = webContextPath+"/trigger/formProcessor_loadEventInfoPage.action?index="+index+"&optString=1";
        Matrix.getMatrixComponentById("HorizontalContainer001Panel2").setContentsURL(src);
    }
    function moveUp(){
    	var index = MDataGrid001.getFocusRow() ;  //获取所选中的数据 index
    	if(index == 0){
    		return;
    	}else{
    		var recordData = MDataGrid001.getData();  //获取 DataGrid001 下的所有数据
    		var selectedRecord = MDataGrid001.getSelection()[0];  //获取所选数据
    		var beforeRecord = recordData.get(index-1); //获取所选数据的前一条数据
    		recordData.set(index-1,selectedRecord);  //与前一个 record 互换位置
    		recordData.set(index,beforeRecord);
    		var url = "<%=request.getContextPath()%>/trigger/formProcessor_moveUp.action";
    		var param = "{'index':'"+index+"'}";
    		var synJson = isc.JSON.decode(param);
    		Matrix.sendRequest(url,synJson,function(){
    			
    		});
    	}
    }
    
    function moveDown(){
    	var index = MDataGrid001.getFocusRow() ;  //获取所选中的数据 index
    	var recordData = MDataGrid001.getData(); 
    	if(index == recordData.length-1){
    		return;
    	}
    	var selectedRecord = MDataGrid001.getSelection()[0];  //获取所选数据
   		var afterRecord = recordData.get(index+1); //获取所选数据的后一条数据
   		recordData.set(index+1,selectedRecord);  //与前一个 record 互换位置
   		recordData.set(index,afterRecord);
   		var url = "<%=request.getContextPath()%>/trigger/formProcessor_moveDown.action";
    		var param = "{'index':'"+index+"'}";
    		var synJson = isc.JSON.decode(param);
    		Matrix.sendRequest(url,synJson,function(){
    			
    		});
    }
    function copyData(){
		 var selectList=Matrix.getDataGridSelection('DataGrid001');
		 if(selectList.size()!=1){
          		 Matrix.warn('请选择一行数据！');
		 }else{
			 var index = MDataGrid001.getFocusRow() ;
	         var data2 = {'data':{'index':index}};
							var url = "<%=request.getContextPath()%>/trigger/formProcessor_copyData.action";
							dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	Matrix.refreshDataGridData('DataGrid001');
						    }else{
						    	parent.isc.say('复制失败');
						    }
						    
							},null);
		}
}
    

</script>
	</head>
	<body>
		<div id='loading' name='loading' class='loading'>
			<script>Matrix.showLoading();</script>
		</div>
		<script> 
	var Mform0=isc.MatrixForm.create({
		ID:"Mform0",
		name:"Mform0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/trigger/formProcessor_refreshList.action",
		canSelectText: true,
		fields:[{
			name:'form0_hidden_text',
			width:0,height:0,
			displayId:'form0_hidden_text_div'
			}]
		});
	</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>/trigger/formProcessor_refreshList.action"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" id="mode" name="mode" value="debug" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				
				<div id="HorizontalContainer001_div" class="matrixInline"
					style="width: 100%; height: 100%;; overflow: hidden;">
					<script>
			isc.HLayout.create({
				ID:"MHorizontalContainer001",
				displayId:"HorizontalContainer001_div",
				position: "relative",
				height: "100%",
				width: "100%",
				align: "center",
				overflow: "auto",
				defaultLayoutAlign: "center",
				members:[
					isc.MatrixHTMLFlow.create({
						ID:"MHorizontalContainer001Panel1",
						width: '20%',
						height: "100%",
						canSelectText: true,
						overflow: "hidden",
						showResizeBar:true,
						contents:"<div id='HorizontalContainer001Panel1_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
						}),
					isc.HTMLPane.create({
						ID:"MHorizontalContainer001Panel2",
						height: "100%",
						overflow: "hidden",
						showEdges:false,
						contentsType:"page",
						contentsURL:""})
					],
					canSelectText: true });
		</script>
				</div>
				<div id="HorizontalContainer001Panel1_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">
					<table class="query_form_content"
						style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
						<tr>
							<td class="query_form_toolbar" colspan="2">
								<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem001",
							icon:"[skin]/images/matrix/actions/add.png",
							title: "",
							showDisabledIcon:false,
							showDownIcon:false });
						MtoolBarItem001.click=function(){Matrix.showMask();
						var x = eval("clickAdd();");
						if(x!=null && x==false){
							Matrix.hideMask();
							return false;
						}Matrix.hideMask();}
						</script>
								<script>
							isc.ToolStripButton.create({
								ID:"MtoolBarItem003",
								icon:"[skin]/images/matrix/actions/delete.png",
								title: "",
								showDisabledIcon:false,
								showDownIcon:false });	
								MtoolBarItem003.click=function(){
								var _preReturn = Matrix.validateDataGridSelection('DataGrid001');
								if (_preReturn != null && _preReturn == false) {
									return false;
								}
								Matrix.showMask();
								if(!true){
									Matrix.hideMask();
									return false;
								}
								if(!Mform0.validate()){
									Matrix.hideMask();
									return false;
								}
								var vituralbuttonHidden = document.getElementById('matrix_command_id');
								if(vituralbuttonHidden)
								vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
								var currentForm = document.getElementById('form0');
								var buttonHidden = document.createElement('input');
								buttonHidden.type='hidden';
								buttonHidden.name='matrix_command_id';
								buttonHidden.id='matrix_command_id';
								buttonHidden.value='toolBarItem003';
								currentForm.appendChild(buttonHidden);
								isc.confirm("确认删除信息？","if(value){var select = MDataGrid001.getSelection();if(select != null && select.length > 0){var index = MDataGrid001.getFocusRow();var url = \"<%=request.getContextPath()%>/trigger/formProcessor_delete.action\";var data = \"{'index':'\"+index+\"'}\";var synJson = isc.JSON.decode(data);Matrix.sendRequest(url,synJson,function(){Matrix.refreshDataGridData('DataGrid001');postDelete();});}}else{Matrix.hideMask();return false;}");
								Matrix.hideMask();}
								</script>
								<script>
									isc.ToolStripButton.create({
										ID:"MtoolBarItem004",
										icon:"[skin]/images/matrix/actions/move_up.png",
										title: "",
										showDisabledIcon:false,
										showDownIcon:false });
									MtoolBarItem004.click=function(){Matrix.showMask();
									var x = eval("moveUp();");
									if(x!=null && x==false){
										Matrix.hideMask();
										return false;
									}Matrix.hideMask();}
								</script>
								<script>
									isc.ToolStripButton.create({
										ID:"MtoolBarItem005",
										icon:"[skin]/images/matrix/actions/move_down.png",
										title: "",
										showDisabledIcon:false,
										showDownIcon:false });
									MtoolBarItem005.click=function(){Matrix.showMask();
									var x = eval("moveDown();");
									if(x!=null && x==false){
										Matrix.hideMask();
										return false;
									}Matrix.hideMask();}
								</script>
								<!-- 数据复制 -->
								<script>
									isc.ToolStripButton.create({
								 		ID:"MtoolBarItem006",
										icon:Matrix.getActionIcon("copy"),
										title: "",
										showDisabledIcon:false,
										showDownIcon:false });
									MtoolBarItem006.click=function(){Matrix.showMask();
										var x = eval("copyData();");
										if(x!=null && x==false){
											Matrix.hideMask();
									   	    return false;
									   	}Matrix.hideMask();
									}
								</script>
								<div id="QueryForm001_tb_div"
									style="width: 100%; height: 38px;; overflow: hidden;">
									<script>isc.ToolStrip.create({
										ID:"MQueryForm001_tb",
										displayId:"QueryForm001_tb_div",
										width: "100%",
										height: "100%",
										position: "relative",
										members: [ MtoolBarItem001,MtoolBarItem003,MtoolBarItem004,MtoolBarItem005,MtoolBarItem006 ] });
										if(MHorizontalContainer001Panel1)
										if(!MHorizontalContainer001Panel1.customMembers)
										MHorizontalContainer001Panel1.customMembers=[];
										MHorizontalContainer001Panel1.customMembers.add(MQueryForm001_tb);
										isc.Page.setEvent(isc.EH.RESIZE,function(){
											isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm001_tb.resizeTo(0,0);MQueryForm001_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);
									</script>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"
								style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
								<div id="DataGrid001_div" class="matrixComponentDiv"
									style="width: 100%; height: 100%;">
									<%
										CommonHelper comHelper = new CommonHelper(); 
										List<FormTrigger> triggerList = comHelper.getTriggerModels();
										String dataSource = null;
										if(triggerList != null && triggerList.size()>0){
											JSONArray jsonArray = JSONArray.fromObject(triggerList);
											dataSource = jsonArray.toString();
										}else{
											dataSource = "[]";
										}
									 %>
									<script>
										var displayValueMap = {'1':'停止','0':'启动'};
										var MDataGrid001_DS=<%=dataSource%>;
										isc.MatrixListGrid.create({
											ID:"MDataGrid001",
											name:"DataGrid001",
											displayId:"DataGrid001_div",
											position:"relative",
											width:"100%",
											height:"100%",
											showAllRecords:true,
											fields:[{  
												title:"&nbsp;",
												name:"MRowNum",
												canSort:false,
												canExport:false,
												canDragResize:false,
												showDefaultContextMenu:false,
												autoFreeze:true,
												autoFitEvent:'none',
												width:5,
												canEdit:false,
												canFilter:false,
												autoFitWidth:false,
												formatCellValue:function(value, record, rowNum, colNum,grid){
													if(grid.startLineNumber==null)
														return '&nbsp;';return grid.startLineNumber+rowNum;}},
												{title:"名称",
												matrixCellId:"name",
												name:"name",
												canEdit:false,
												editorType:'Text',
												type:'text',
												showHover : true,
												width : "80%"},
												{title:"状态",
												matrixCellId:"status",
												name:"status",
												canEdit:false,
												editorType:'Text',
												type:'text',
												valueMap:['0','1'],
					  							autoFetchDisplayMap:true,
					  							showHover:false,
					  							editorProperties:{
					  								displayValueMap: displayValueMap
					  							},
					  							formatCellValue:function(value, record, rowNum, colNum,grid){
					  							if(value==null){
					  								return "";
					  							}
					  							return displayValueMap[value];
					  							}
					  							}],
												autoSaveEdits:false,
												canHover : true,
												isMLoaded:false,
												autoDraw:false,
												autoFetchData:true,
												selectionType:"single",
												selectionAppearance:"rowStyle",
												alternateRecordStyles:false,
												showRollOver:true,
												canSort:false,
												autoFitFieldWidths:false,
												cellClick:function(record, rowNum, colNum){onCellClick();
												(record, rowNum, colNum);},
												startLineNumber:1,
												editEvent:"doubleClick",
												canCustomFilter:true,
												exportCells:[{
													id:'name',title:'名称'},
													{id:'status',title:'状态'}],
												showRecordComponents:true,
												showRecordComponentsByCell:true});
												isc.MatrixDataSource.create({
													ID:'MDataGrid001_custom_filter_ds',
													fields:[{
														title:"名称",
														name:"name",
														type:'text',
														editorType:'Text'},
														{title:"状态",
														name:"status",
														type:'text',
														editorType:'Text'}]
													});
													
													
													
													
												isc.FilterBuilder.create({
													ID:'MDataGrid001_custom_filter',
													dataSource:MDataGrid001_custom_filter_ds,
													overflow:'auto',
													topOperatorAppearance:"none"});
													isc.Button.create({
														ID:'MDataGrid001_custom_filter_btn',
														title:"确认",
														autoDraw:false,
														click:"MDataGrid001.hideCustomFilter()"});
												isc.Button.create({
													ID:'MDataGrid001_custom_filter_btn_reset',
													title:"重置",
													autoDraw:false,
													click:"MDataGrid001_custom_filter.clearCriteria()"});
												isc.Button.create({
													ID:'MDataGrid001_custom_filter_btn_cancel',
													title:"取消",
													autoDraw:false,
													click:"MDataGrid001_custom_filter_window.hide()"});
												isc.Window.create({
													ID:'MDataGrid001_custom_filter_window',
													title:"高级查询",
													autoCenter:true,
													overflow:"auto",
													isModal:true,
													autoDraw:true,
													height:300,
													width:500,
													canDragResize:true,
													showMaximizeButton:true,
													items: [MDataGrid001_custom_filter],
													showFooter:true,
													footerHeight:20,
													footerControls:[isc.HTMLFlow.create({
														width:'30%',
														contents:"&nbsp;",
														autoDraw:false}),
														MDataGrid001_custom_filter_btn,
														isc.HTMLFlow.create({
															width:'5%',
															contents:"&nbsp;",
															autoDraw:false}),
															MDataGrid001_custom_filter_btn_reset,
														isc.HTMLFlow.create({
																width:'5%',
																contents:"&nbsp;",
																autoDraw:false}),
																MDataGrid001_custom_filter_btn_cancel,
														isc.HTMLFlow.create({
																width:'30%',
																contents:"&nbsp;",
																autoDraw:false})]});
															MDataGrid001_custom_filter.resizeTo('100%','100%');
															MDataGrid001_custom_filter_window.hide();
															if(MHorizontalContainer001Panel1)
															if(!MHorizontalContainer001Panel1.customMembers)
															MHorizontalContainer001Panel1.customMembers=[];
															MHorizontalContainer001Panel1.customMembers.add(MDataGrid001);
															isc.Page.setEvent(isc.EH.LOAD,function(){
																MDataGrid001.isMLoaded=true;
																MDataGrid001.draw();
																MDataGrid001.setData(MDataGrid001_DS);
																MDataGrid001.resizeTo('100%','100%');
																isc.Page.setEvent(isc.EH.RESIZE,function(){
																	isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},
																	isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
																	if(Matrix.getDataGridIdsHiddenOfForm('form0'))
																		{Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
										</script>
									<script>
											isc.Page.setEvent("load","Matrix.fillDataPaginator('blpageDataGrid001',1,1,5,'DataGrid001',4)",isc.Page.FIRE_ONCE);
										</script>
									<script>
											isc.Page.setEvent("load","Matrix.fillDataPaginator('brpageDataGrid001',1,1,5,'DataGrid001',4)",isc.Page.FIRE_ONCE);
										</script>
								</div>
								<input id="DataGrid001_selections" name="DataGrid001_selections"
									type="hidden" />
								<input id="DataGrid001_data_entity"
									name="DataGrid001_data_entity"
									value="office.flow.TriggerEventBO" type="hidden" />
							</td>
						</tr>
					</table>

				</div>
				<script>document.getElementById('HorizontalContainer001Panel1_div').appendChild(document.getElementById('HorizontalContainer001Panel1_div2'));</script>
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
	
</body>
		<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
	</body>
</html>

