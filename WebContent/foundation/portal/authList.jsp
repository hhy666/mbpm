<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
	//------------------------------------------------------------------------------
		//删除----
      		function deleteAuth(list){
      			var newdata="";
      			for(var i=0;i<list.length;i++){
      				if(i==list.length-1){
      					newdata+=list[i].uuid;
      				}else{
      					newdata+=list[i].uuid;
      					newdata+=",";
      				}
      			}
      			newdata = "{'uuids':'"+newdata+"'}";
      			var synJson = isc.JSON.decode(newdata);
      			var url = "<%=request.getContextPath()%>/portal/portalAction_deleteAuth.action";
      			Matrix.sendRequest(url,synJson,function(data){
      				var json = isc.JSON.decode(data.data);
      				if(json.result == true){
	      				Matrix.refreshDataGridData("DataGrid001");
      				}else{
      					isc.warn("删除未成功!");
      				}
      			});
      		}
</script>
<script type="text/javascript">

	//点击 “+”按钮 时，页面弹出选择管理员窗口
	function selectAuth(){
		MDialog3.initSrc=
					"<%=request.getContextPath()%>/portal/portalAction_selectAuth.action"		
		Matrix.showWindow('Dialog3');
	}
	//-------------------------------------
	function onDialog3Close(data,oType){
	 if(data!=null){
	 	 data.portaluuid=getPortaluuid();
		 var jsonObj = isc.JSON.decode(isc.JSON.encode(data)); 
	     var dataGrid = Matrix.getMatrixComponentById("DataGrid001");
		 var opType = MDialog3.opType;
	     var synJson = {'data':data};
		 var url = '<%=request.getContextPath()%>/portal/portalAction_saveAuth0.action';
	         Matrix.sendRequest(url,synJson,function(result){
	         	var dataStr = result.data;
	         	if(dataStr!=null){
	         		var dataJson = isc.JSON.decode(dataStr);
	         		if(dataJson.message==true){
	        			Matrix.refreshDataGridData('DataGrid001');
	         		}else{
	         			isc.warn('添加失败');
	         		}
	         	}
	         
	         });
   
		}
	}
	function getPortaluuid(){
		return document.getElementById("portaluuid").value;
	}
		//--------------------------------
</script>
</head>
<body >
	
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
	ID:"Mform0",
	name:"Mform0",
	position:"absolute",
	fields:[{name:'form0_hidden_text',
			 width:0,
			 height:0,
			 displayId:'form0_hidden_text_div'
	}]});
</script>
<div
	style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/portal/portalAction_authList.action"
	style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="form0" value="form0" /> 
	<input type="hidden"
	id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0"
	value="" />
	<input type="hidden" name="portaluuid" id="portaluuid" value="${param.portaluuid }">
<div type="hidden" id="form0_hidden_text_div"
	name="form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>

<input type="hidden" name="javax.matrix.faces.ViewState"
	id="javax.matrix.faces.ViewState" value="" />
<input type="hidden" name="dataGridId"
	id="dataGridId" value="DataGrid001" />

<table  class="query_form_content"
	style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
	<tr>
		
		<td class="query_form_toolbar" colspan="2"><script> 
				var QueryField001=isc.TextItem.create({
					ID:"MQueryField001",
					name:"QueryField001",
					editorType:"TextItem",
					displayId:"QueryField001_div",
					position:"relative"});
					Mform0.addField(QueryField001);
					</script>
					<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem001",
						icon:"<%=request.getContextPath()%>/resource/images/new.png",
						title: "添加",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem001.click=function(){
					Matrix.showMask();
					//弹出窗口
					selectAuth();
					Matrix.hideMask();
					}
					</script>
					 <script>
 <%--------------------Dialog2添加管理员窗口--------------------------%>
                                function getParamsForDialog3() {
                                    var params='&';
                                    var value;
                                    return params;
                                } 
                                isc.Window.create({
                                    ID: "MDialog3",
                                    id:"Dialog3",
                                    name:"Dialog3",
                                    autoCenter: true,
                                    position: "absolute",
                                    height:"95%",
                                    width:"90%",
                                    title: "选择管理员",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel","closeButton"],
                                    targetDialog:'Dialog3'
                                });
                            </script>
                            <script>
                                MDialog3.hide();
                            </script>
					<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem002",
							title:"删除",
							icon:"<%=request.getContextPath()%>/resource/images/delete.png",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem002.click=function(){
							//getSelection()得到当前选中对象，存放到集合中
							var list = MDataGrid001.getSelection();
							//集合中有这个对象，就能删除
							if(list != null){
								isc.confirm("确认删除?",function(value){
									if(value){
										//执行此方法
										deleteAuth(list);
									}
								});
							}else{
								isc.say("未选中权限！");
							}
						}
					</script>
					<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem003",
							title:"关闭",
							icon:"<%=request.getContextPath()%>/resource/images/return.png",
							showDisabledIcon:false,
							showDownIcon:false 
						
						});
						MtoolBarItem003.click=function(){
							Matrix.closeWindow();
						}
					</script>
		<div id="QueryForm22ebd2f6234d499cb105c9482a7a6c41_tb_div"
			style="width: 100%; height: 30px;; overflow: hidden;">
			<script>
			isc.ToolStrip.create({
				ID:"MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb",
				displayId:"QueryForm22ebd2f6234d499cb105c9482a7a6c41_tb_div",
				width: "100%",height: "100%",position: "relative",
				members: [ 
					MtoolBarItem001,
					MtoolBarItem002,
					MtoolBarItem003,
					] });isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb.resizeTo(0,0);MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div>
		</td>
	</tr>
	<tr >
		<td colspan="2"
			style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
		<div id="DataGrid001_div" class="matrixComponentDiv"
			style="width: 100%; height: 100%;">
			<script> var MDataGrid001_DS=<%=request.getAttribute("lists")%>;
			isc.MatrixListGrid.create({
			ID:"MDataGrid001",
			name:"DataGrid001",
			displayId:"DataGrid001_div",
			position:"relative",
			width:"100%",
			height:"100%",
			fields:[
			{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
			{title:"类型",matrixCellId:"type",name:"type",canEdit:false,editorType:'Text',type:'text',valueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'},displayValueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'}},
			{title:"用户名称",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'},
			{title:"部门名称",matrixCellId:"depName",name:"depName",canEdit:false,editorType:'Text',type:'text'},
			{title:"角色名称",matrixCellId:"roleName",name:"roleName",canEdit:false,editorType:'Text',type:'text'}],
			autoSaveEdits:false,
			isMLoaded:false,
			autoDraw:false,
			autoFetchData:true,
			selectionType:"multiple",
			selectionAppearance:"rowStyle",
			alternateRecordStyles:true,
			canSort:true,
			autoFitFieldWidths:false,
			cellDoubleClick:function(record, rowNum, colNum){
				updateRecord();
				(record, rowNum, colNum);
			},
			startLineNumber:1,
			canEdit:true,
			editEvent:"doubleClick",
			canCustomFilter:true,
			exportCells:[
				{id:'type',title:'类型'},
				{id:'userName',title:'用户名称'},
				{id:'depName',title:'部门名称'},
				{id:'roleName',title:'角色名称'}],
			showRecordComponents:true,
			showRecordComponentsByCell:true
			});
			isc.MatrixDataSource.create({
					ID:'MDataGrid001_custom_filter_ds',
					fields:[
					{title:"类型",name:"type",valueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'},
					displayValueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'},
					type:'text',editorType:'Text'},
					{title:"用户名称",name:"userName",type:'text',editorType:'Text'},
					{title:"部门名称",name:"depName",type:'text',editorType:'Text'},
					{title:"角色名称",name:"roleName",type:'text',editorType:'Text'}]});
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
						footerControls:[isc.HTMLFlow.create(
							{width:'30%',contents:"&nbsp;",autoDraw:false}
						),
						MDataGrid001_custom_filter_btn,
						isc.HTMLFlow.create(
							{width:'5%',contents:"&nbsp;",autoDraw:false}
						),
						MDataGrid001_custom_filter_btn_cancel,
						isc.HTMLFlow.create(
							{width:'30%',contents:"&nbsp;",autoDraw:false}
						)]});
						isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}</script>
			</div>
		<input id="DataGrid001_data_entity" name="DataGrid001_data_entity"
			value="foundation.portal.PortalAuth" type="hidden" /></td>
	</tr>
	</div><input id="matrix_matrix_dataGrid_DataGrid001" name="matrix_matrix_dataGrid_DataGrid001" type="hidden" value="DataGrid001" /><input id="DataGrid001_all_rows" name="DataGrid001_all_rows" type="hidden" /><input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" /><input id="DataGrid001_data_entity" name="DataGrid001_data_entity" value="hgdxlc.common.lcmlgl.FlowAuth" type="hidden" /></td>
</tr>
</table>
</form>
</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
</body>
</html>
