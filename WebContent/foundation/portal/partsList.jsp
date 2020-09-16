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
			function doubleClickUpdateFormVersion(record){
				MDialog1.initSrc="<%=request.getContextPath()%>/portal/partsAction_updateParts.action?uuid="+record.uuid;
				Matrix.showWindow('Dialog1');
			}
      		function showAddDialog(){
      			MDialog0.initSrc="<%=request.getContextPath()%>/portal/partsAction_addParts.action";
      			Matrix.showWindow('Dialog0');
      		}
      		function onDialog0Close(){
      			Matrix.refreshDataGridData('DataGrid001');
      		}
      		function onDialog1Close(){
      			Matrix.refreshDataGridData('DataGrid001');
      		}
      		function deleteParts(uuids){
      			isc.confirm(
						'确认删除?',
						function(value){
							if(value){
      							var url = "<%=request.getContextPath()%>/portal/partsAction_deleteParts.action";
								var newData = "{'uuid':'"+uuids+"'}";
								var synJson = isc.JSON.decode(newData);
								Matrix.sendRequest(url,synJson,function(data){
									if(data.data){
										var json = isc.JSON.decode(data.data);
										if(json.result==true){
											//MDataGrid001.removeSelectedData();
											Matrix.refreshDataGridData('DataGrid001');
										}
									}
							
								});
							}
						}
					);
      		}
</script>

</head>
<body >
	
<div id='loading' name='loading' class='loading'>
<script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
	ID:"Mform0",
	name:"Mform0",
	position:"absolute",
	action:"<%=request.getContextPath()%>/matrix.rform",
	fields:[{name:'form0_hidden_text',
			 width:0,
			 height:0,
			 displayId:'form0_hidden_text_div'
	}]});
</script>
<div
	style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/portal/partsAction_findAllParts.action"
	style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="form0" value="form0" /> 
	
	<input type="hidden"
	id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0"
	value="" />

<div type="hidden" id="form0_hidden_text_div"
	name="form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>

<input type="hidden" name="javax.matrix.faces.ViewState"
	id="javax.matrix.faces.ViewState" value="" />
<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>
<div style="padding-left: 5px;padding-top: 5px;">
			<image id="image001" style="width:40px;height:30px;display:inline-block;vertical-align:top;margin-right:8px;padding-left:5px;padding-bottom:8px;" name="image001" src="<%=request.getContextPath()%>/resource/images/collaborationthemespace.png" />
              <span id="label011" style="font-size:13px;vertical-align:bottom; " name="label011"/>门户管理&gt;部件管理</span>
			
		</div>
<div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:97%;position:relative;" >
				<script> 
					var MTabContainer001 = isc.TabSet.create({
							ID:"MTabContainer001",
							displayId:"TabContainer001_div",
							height: "100%",width: "100%",
							position: "relative",
							align: "center",
							tabBarPosition: "top",
							tabBarAlign: "left",
							showPaneContainerEdges: false,
							showTabPicker: false,
							showTabScroller: false,
							selectedTab: 1,
							tabBarControls : [
								isc.MatrixHTMLFlow.create({
									ID:"MTabBar001",
									width:"300px",
									contents:"<div id='TabBar001_div' style='text-align:right;' ></div>"}) 
								],
								tabs: [ {title: "部件管理",autoDraw: false,pane:isc.MatrixHTMLFlow.create({ID:"MTabPanel001",autoDraw: false,width: "100%",height: "100%",overflow: "hidden",contents:"<div id='TabPanel001_div' style='width:100%;height:100%'></div>"})} ] });document.getElementById('TabContainer001_div').style.display='';MTabPanel001.draw();isc.Page.setEvent("load","MTabContainer001.selectTab(0);");</script></div>
			<div id="TabPanel001_div2" style="width:100%;height:100%;overflow:hidden;" class="matrixInline">
			
<table  class="query_form_content"
	style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
	<tr>
		
		<td class="query_form_toolbar" colspan="2" ><script> 
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
						ID:"MtoolBarItem086a485a05344794be9751286cbbe694",
						icon:"<%=request.getContextPath()%>/resource/images/query.png",
						title: "查询",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem086a485a05344794be9751286cbbe694.click=function(){
						Matrix.showMask();
						Matrix.refreshDataGridData('DataGrid001');
						Matrix.hideMask();}</script>
						
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
						showAddDialog();
						Matrix.hideMask();
					}
					</script>
					<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItemEdit",
						icon:"<%=request.getContextPath()%>/resource/images/edit.png",
						title: "修改",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItemEdit.click=function(){
						Matrix.showMask();
						var record = MDataGrid001.getSelection();
						if(record.length==1){
							doubleClickUpdateFormVersion(record[0]);
						}else{
							Matrix.warn("请先选中一条数据!");
						}
						
						Matrix.hideMask();
					}
					</script>
					<script>
                                function getParamsForDialog0() {
                                    var params = '&';
                                    var value;
                                    return params;
                                } 
                                isc.Window.create({
                                    ID: "MDialog0",
                                    id:"Dialog0",
                                    name:"Dialog0",
                                    autoCenter: true,
                                    position: "absolute",
                                    height:"450px",
                                    width:"500px",
                                    title: "添加部件信息",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel","closeButton"]
                                });
                            </script>
                            <script>
                                MDialog0.hide();
                            </script>
                            <script>
                                function getParamsForDialog1() {
                                    var params = '&';
                                    var value;
                                    return params;
                                } 
                                isc.Window.create({
                                    ID: "MDialog1",
                                    id:"Dialog1",
                                    name:"Dialog1",
                                    autoCenter: true,
                                    position: "absolute",
                                    height:"450px",
                                    width:"500px",
                                    title: "修改部件信息",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel","closeButton"]
                                });
                            </script>
                            <script>
                                MDialog1.hide();
                            </script>
					<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem002",
						icon:"<%=request.getContextPath()%>/resource/images/delete.png",
						title: "删除",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem002.click=function(){
						var select = MDataGrid001.getSelection();
						if(select.length>0&&select!=null){
							var uuids="";
							for(var i=0;i<select.length;i++){
								if(i!=select.length-1){
									uuids+=select.get(i).uuid;
									uuids+=",";
								}else{
									uuids+=select.get(i).uuid;
								}
							}
							deleteParts(uuids)
						}else{
							isc.warn('请选择数据!');
						}
					
					}
					</script>
		<div id="QueryForm22ebd2f6234d499cb105c9482a7a6c41_tb_div"
			style="width: 100%; height: 40px;; overflow: hidden;position:absolute;top:0px;">
			<script>
			isc.ToolStrip.create({
				ID:"MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb",
				displayId:"QueryForm22ebd2f6234d499cb105c9482a7a6c41_tb_div",
				width: "100%",height: "100%",position: "relative",
				members: [ 
				isc.MatrixHTMLFlow.create({
					ID:"MQueryField001_Label",
					contents:"<div  id='MQueryField001_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >标题</div>"}),
					isc.MatrixHTMLFlow.create({ID:"QueryField001",
					contents:"<div id='QueryField001_div' eventProxy='Mform0' class='toolBarItemInputText' ></div>"}),
					MtoolBarItem086a485a05344794be9751286cbbe694,
					MtoolBarItem001,
					
					MtoolBarItemEdit,
					MtoolBarItem002
					
					] });isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb.resizeTo(0,0);MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div>
		</td>
	</tr>
	<tr>
		<td colspan="2"
			style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
		<div id="DataGrid001_div" class="matrixComponentDiv"
			style="width: 100%;">
			<script> 
			var MDataGrid001_DS=<%=request.getAttribute("lists")%>;
			isc.MatrixListGrid.create({
			ID:"MDataGrid001",name:"DataGrid001",displayId:"DataGrid001_div",position:"relative",width:"100%",height:"100%",
			<%-- 双击事件 --%>
			recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                        doubleClickUpdateFormVersion(record);
                     },
			fields:[
			
			{title:"序号",
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
				//计算行数
				formatCellValue:function(value, record, rowNum, colNum,grid){
					if(grid.startLineNumber==null)
						return '&nbsp;';
					return grid.startLineNumber+rowNum;
				}},
			{title:"标题",matrixCellId:"title",name:"title",canEdit:false,editorType:'Text',type:'text'},
			{title:"部件链接",matrixCellId:"urlValue",name:"urlValue",canEdit:false,editorType:'Text',type:'text'},
			{title:"默认宽度",matrixCellId:"width",name:"width",canEdit:false,editorType:'Text',type:'text'},
			{title:"默认高度",matrixCellId:"height",name:"height",canEdit:false,editorType:'Text',type:'text'},
			{title:"默认行数",matrixCellId:"rows",name:"rows",canEdit:false,editorType:'Text',type:'text'},
			{title:"默认列数",matrixCellId:"cols",name:"cols",canEdit:false,editorType:'Text',type:'text'},
			{title:"状态",matrixCellId:"status",name:"status",canEdit:false,editorType:'Text',type:'text',valueMap:{'0':'已启用','1':'已禁用'}}
			],
			autoSaveEdits:false,
			isMLoaded:false,
			autoDraw:false,
			autoFetchData:true,
			selectionType:"multiple",
			selectionAppearance:"rowStyle",
			alternateRecordStyles:true,
			canSort:true,
			autoFitFieldWidths:false,
			startLineNumber:1,
			editEvent:"doubleClick",
			canCustomFilter:false,
			exportCells:[
				{id:'title',title:'名称'},
				{id:'urlValue',title:'部件地址'},
				{id:'content',title:'部件内容'},
				{id:'imgValue',title:'图标样式'},
				{id:'status',title:'状态'}
			],
			showRecordComponents:true,
			showRecordComponentsByCell:true
			});
			isc.Page.setEvent(
			isc.EH.LOAD,
			function(){
			MDataGrid001.isMLoaded=true;
			MDataGrid001.draw();
			MDataGrid001.setData(MDataGrid001_DS);
			MDataGrid001.resizeTo('100%','100%');
			isc.Page.setEvent(
			isc.EH.RESIZE,
			function(){
			isc.Page.setEvent(
			isc.EH.RESIZE,
			"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},
			isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
			if(Matrix.getDataGridIdsHiddenOfForm('form0')){
				Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
			</script>
			<script>
				var	curPageNum = <%=request.getAttribute("curPageNum")%>;
				var totalPageNum = <%=request.getAttribute("totalPageNum")%>;
				var totalSize = <%=request.getAttribute("totalSize")%>;
			isc.Page.setEvent("load","Matrix.fillDataPaginator('blpageDataGrid001',"+curPageNum+","+totalPageNum+",5,'DataGrid001',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			<script>
			isc.Page.setEvent("load","Matrix.fillDataPaginator('brpageDataGrid001',"+curPageNum+","+totalPageNum+",5,'DataGrid001',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			</div>
					<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
					<input id="DataGrid001_data_entity" name="DataGrid001_data_entity"
						value="foundation.portal.Parts" type="hidden" /></td>
	</tr>
	<tr style="width: 100%;height:35px;">
		<td class="toolStrip"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;">
			<span id="blpageDataGrid001" class="paginator">
				<span id="blpageDataGrid001:status" class="paginator_status">
				</span>
			</span>
		</td>
		<td class="toolStrip" 
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align:right; margin: 0px; padding: 0px;">
			<span id="brpageDataGrid001" class="paginator" style="float:right;">
				<span id="brpageDataGrid001:first" class="paginator_first">
					<img id="brpageDataGrid001_fI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/first_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:previous" class="paginator_previous">
					<img id="brpageDataGrid001_pI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/pre_gray.gif" border="0" line-height="30px"/>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:go" class="paginator_go" >
					<span class="go_prefix" line-height="30px">
						第
					</span>
					<span id="brpageDataGrid001:goText" class="paginator_go_text" line-height="30px">
					</span>
					<span class="go_suffix" line-height="30px">
						页
					</span>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:next" class="paginator_next">
					<img id="brpageDataGrid001_nI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/next_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:last" class="paginator_last" line-height="30px">
					<img id="brpageDataGrid001_lI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/last_gray.gif"	border="0" line-height="30px"/>
				</span>
				<span class="paginator_clean" line-height="30px">
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:refresh" class="paginator_refresh" line-height="30px">
					<a href="javascript:#"></a>
				</span>
				<span>
					&nbsp;&nbsp;
				</span>
				<span id="DataGrid001_brpageDataGrid001_dynamic_perpage_count_div" eventProxy="Mform0" class="matrixInline" line-height="30px">
				</span>
			<script>var DataGrid001_brpageDataGrid001_dynamic_perpage_count=
				isc.SelectItem.create({ID:"MDataGrid001_brpageDataGrid001_dynamic_perpage_count",
									   name:"DataGrid001_brpageDataGrid001_dynamic_perpage_count",
									   paginator:"brpageDataGrid001",
									   editorType:"SelectItem",
									   width:80,
									   displayId:"DataGrid001_brpageDataGrid001_dynamic_perpage_count_div",
									   value:"0",
									   valueMap:{'0':'每页记录','10':'每页10条','20':'每页20条','30':'每页30条','40':'每页40条','50':'每页50条','-1':'全部数据'}});
									   Mform0.addField(DataGrid001_brpageDataGrid001_dynamic_perpage_count);
									   MDataGrid001_brpageDataGrid001_dynamic_perpage_count.observe(MDataGrid001_brpageDataGrid001_dynamic_perpage_count,
									   "changed",
									   "Matrix.dynamicPagingDataGridData('DataGrid001','brpageDataGrid001',MDataGrid001_brpageDataGrid001_dynamic_perpage_count.getValue())");
			 </script>
		</span>
	</td>
	</tr>
</table>
</div>

</form>
</div>
<script>document.getElementById('TabPanel001_div').appendChild(document.getElementById('TabPanel001_div2'));</script><div id="TabBar001_div2" style="text-align:right"  class="matrixInline"></div>
<script>document.getElementById('TabBar001_div').appendChild(document.getElementById('TabBar001_div2'));</script><script>document.getElementById('TabContainer001_div').style.display='';</script>

<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
</body>
</html>
