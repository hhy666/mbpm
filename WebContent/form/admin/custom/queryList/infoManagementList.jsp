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
		<%--弹出新增信息--%>
	function showAddDialog(){
		MDialog0.initSrc="<%=request.getContextPath()%>/query/infor_addInfor.action";
		Matrix.showWindow('Dialog0');
	}
	<%--新增信息窗口关闭 刷新数据表格--%>
	function onDialog0Close(){
		Matrix.refreshDataGridData('DataGrid001');
	}
	<%--弹出更新信息--%>
    function UpdateForm(){
    	Matrix.refreshDataGridData('DataGrid001');
    		 var selectData=Matrix.getDataGridSelection('DataGrid001');
    		 if(selectData.size()==0||selectData.size()>1){
          		 Matrix.warn('请选择一行数据！');}
			else{
    		 var uuid=selectData[0].uuid;
		MDialog1.initSrc="<%=request.getContextPath()%>/query/infor_updateInfor.action?uuid="+uuid;	
		Matrix.showWindow('Dialog1');
		}	
	}
	<%--更新信息关闭 刷新数据表格--%>
	function onDialog1Close(){
		Matrix.refreshDataGridData('DataGrid001');
	}
		</script>
	</head>
	<body>
		<div id='loading' name='loading' class='loading'>
			<script>
	Matrix.showLoading();
</script>
		</div>

		<script>
	var Mform0 = isc.MatrixForm.create( {
		ID : "Mform0",
		name : "Mform0",
		position : "absolute",
		action : "<%=request.getContextPath()%>/query/infor_loadDataGridData.action",
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
				action="<%=request.getContextPath()%>/query/infor_loadDataGridData.action"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" id="mode" name="mode" value="debug" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<table class="query_form_content"
					style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
					<tr>
						<td class="query_form_toolbar" colspan="2">
							<script>
	var QueryField001 = isc.TextItem.create( {
		ID : "MQueryField001",
		name : "QueryField001",
		editorType : "TextItem",
		displayId : "QueryField001_div",
		position : "relative",
		autoDraw : false
	});
	Mform0.addField(QueryField001);
</script>
							<script>
	isc.ToolStripButton.create( {
		ID : "MtoolBarItem001",
		icon : "[skin]/images/matrix/actions/query.png",
		title : "查询",
		showDisabledIcon : false,
		showDownIcon : false
	});
	MtoolBarItem001.click = function() {
		Matrix.showMask();
		var x = eval("Matrix.refreshDataGridData('DataGrid001');");
		if (x != null && x == false) {
			Matrix.hideMask();
			return false;
		}
		Matrix.hideMask();
	}
</script>
							<script>
	isc.ToolStripButton.create( {
		ID : "MtoolBarItem002",
		icon : "[skin]/images/matrix/actions/add.png",
		title : "新建",
		showDisabledIcon : false,
		showDownIcon : false
	});MtoolBarItem002.click=function(){
						Matrix.showMask();
						showAddDialog();
						Matrix.hideMask();
					}
</script>
							<script>
	isc.ToolStripButton.create( {
		ID : "MtoolBarItem003",
		icon : "[skin]/images/matrix/actions/edit.png",
		title : "修改",
		showDisabledIcon : false,
		showDownIcon : false
	});
	MtoolBarItem003.click=function(){
						Matrix.showMask();
						UpdateForm();
						Matrix.hideMask();
					}
</script>
							<script>
	isc.ToolStripButton.create( {
		ID : "MtoolBarItem004",
		icon : "[skin]/images/matrix/actions/delete.png",
		title : "删除",
		showDisabledIcon : false,
		showDownIcon : false
	});
	MtoolBarItem004.click = function() {
		var select = MDataGrid001.getSelection();
						if(select.length>0&&select!=null){
							var ids ="";
							for(var i=0;i<select.length;i++){
								if(i!=select.length-1){
									ids+=select.get(i).uuid;
									ids+=",";
								}else{
									ids+=select.get(i).uuid;
								}
							}
							isc.confirm('确认删除?',function(value){
								if(value){
									var url = "<%=request.getContextPath()%>/query/infor_deleteInformation.action";
									var newData = "{'uuid':'"+ids+"'}";
									var synJson = isc.JSON.decode(newData);
									Matrix.sendRequest(url,synJson,function(data){
												if(data.data){
													var json = isc.JSON.decode(data.data);
													if(json.result==true){
														Matrix.refreshDataGridData('DataGrid001');
													}
												}
											});
								}
							});
						}else{
							isc.warn('请选择数据!');
							return;
						}
					
					}
</script>
							<script>
	isc.ToolStripButton.create( {
		ID : "MtoolBarItem005",
		icon : "[skin]/images/matrix/actions/excute.png",
		title : "启用",
		showDisabledIcon : false,
		showDownIcon : false
	});
	MtoolBarItem005.click=function(){
							var select = MDataGrid001.getSelection();
							if(select.length>0&&select!=null){
								if(select.length>1){
									isc.warn("只能选择一条数据!");
									return;
								}else{
								var uuid = select.get(0).uuid;
								var url = "<%=request.getContextPath()%>/query/infor_enable.action";
									var newData = "{'uuid':'"+uuid+"'}";
									var synJson = isc.JSON.decode(newData);
									Matrix.sendRequest(url,synJson,function(data){
												if(data.data){
													var json = isc.JSON.decode(data.data);
													if(json.result==true){
														Matrix.refreshDataGridData('DataGrid001');
													}
												}
											});}
							}else{
								isc.warn("请先选中数据!");
							}
						}
</script>
							<script>
	isc.ToolStripButton.create( {
		ID : "MtoolBarItem006",
		icon : "[skin]/images/matrix/actions/excute.png",
		title : "停用",
		showDisabledIcon : false,
		showDownIcon : false
	});
	MtoolBarItem006.click = function() {
		var select = MDataGrid001.getSelection();
							if(select.length>0&&select!=null){
								if(select.length>1){
									isc.warn("只能选择一条数据!");
									return;
								}else{
								var uuid = select.get(0).uuid;
								var url = "<%=request.getContextPath()%>/query/infor_disable.action";
									var newData = "{'uuid':'"+uuid+"'}";
									var synJson = isc.JSON.decode(newData);
									Matrix.sendRequest(url,synJson,function(data){
												if(data.data){
													var json = isc.JSON.decode(data.data);
													if(json.result==true){
														Matrix.refreshDataGridData('DataGrid001');
													}
												}
											});}
							}else{
								isc.warn("请先选中数据!");
							}
						}
</script>
							<div id="QueryForm002_tb_div"
								style="width: 100%; height: 38px;; overflow: hidden;">
								<script>
	isc.ToolStrip.create( {
		ID : "MQueryForm002_tb",
		displayId : "QueryForm002_tb_div",
		width : "100%",
		height : "100%",
		position : "relative",
		members : [ isc.MatrixHTMLFlow.create( {
			ID : "MQueryField001_Label",
			contents : "<div  id='MQueryField001_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >表单名称</div>"
		}), isc.MatrixHTMLFlow.create( {
			ID : "QueryField001",
			contents : "<div id='QueryField001_div' eventProxy='Mform0' style='margin-top:4px;width:150px;' class='toolBarItemInputText' ></div>"
		}), MtoolBarItem001, MtoolBarItem002, MtoolBarItem003, MtoolBarItem004,
				MtoolBarItem005, MtoolBarItem006 ]
	});
	isc.Page
			.setEvent(
					isc.EH.RESIZE,
					function() {
						isc.Page
								.setEvent(
										isc.EH.RESIZE,
										"MQueryForm002_tb.resizeTo(0,0);MQueryForm002_tb.resizeTo('100%','100%');",
										null);
					}, isc.Page.FIRE_ONCE);
</script>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"
							style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
							<div id="DataGrid001_div" class="matrixComponentDiv"
								style="width: 100%; height: 100%;">
								<script>
	var MDataGrid001_DS = <%=request.getAttribute("infoManagementList")%>;
	isc.MatrixListGrid.create( {
		ID : "MDataGrid001",
		name : "DataGrid001",
		displayId : "DataGrid001_div",
		position : "relative",
		width : "100%",
		height : "100%",
		showAllRecords:true,
		fields : [ {
			title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}}, {
			title : "表单名称",
			matrixCellId : "formName",
			name : "formName",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		}, {
			title : "所属人",
			matrixCellId : "personal",
			name : "personal",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		}, {
			title : "状态",
			matrixCellId : "status",
			name : "status",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text',
			displayValueMap:{'0':'不可用','1':'可用'}
		}, {
			title : "制作时间",
			matrixCellId : "makingTime",
			name : "makingTime",
			canEdit : false,
			editorType : 'DateItem',
			width:'20%',
			type : 'date'
		}, {
			title : "修改时间",
			matrixCellId : "editTime",
			name : "editTime",
			canEdit : false,
			editorType : 'DateItem',
			width:'20%',
			type : 'date'
		} ],
		autoSaveEdits : false,
		isMLoaded : false,
		autoDraw : false,
		autoFetchData : true,
		selectionType : "single",
		selectionAppearance : "rowStyle",
		alternateRecordStyles : true,
		showRollOver : true,
		canSort : true,
		autoFitFieldWidths : false,
		startLineNumber : 1,
		editEvent : "doubleClick",
		canCustomFilter : true,
		exportCells : [ {
			id : 'formName',
			title : '表单名称'
		}, {
			id : 'personal',
			title : '所属人'
		}, {
			id : 'status',
			title : '状态'
		}, {
			id : 'makingTime',
			title : '制作时间'
		}, {
			id : 'editTime',
			title : '修改时间'
		} ],
		showRecordComponents : true,
		showRecordComponentsByCell : true
	});
	isc.MatrixDataSource.create( {
		ID : 'MDataGrid001_custom_filter_ds',
		fields : [ {
			title : "表单名称",
			name : "formName",
			type : 'text',
			editorType : 'Text'
		}, {
			title : "所属人",
			name : "personal",
			type : 'text',
			editorType : 'Text'
		}, {
			title : "状态",
			name : "status",
			type : 'text',
			editorType : 'Text'
		}, {
			title : "制作时间",
			name : "makingTime",
			type : 'date',
			editorType : 'DateItem'
		}, {
			title : "修改时间",
			name : "editTime",
			type : 'date',
			editorType : 'DateItem'
		} ]
	});
	isc.FilterBuilder.create( {
		ID : 'MDataGrid001_custom_filter',
		dataSource : MDataGrid001_custom_filter_ds,
		overflow : 'auto',
		topOperatorAppearance : "none"
	});
	isc.Button.create( {
		ID : 'MDataGrid001_custom_filter_btn',
		title : "确认",
		autoDraw : false,
		click : "MDataGrid001.hideCustomFilter()"
	});
	isc.Button.create( {
		ID : 'MDataGrid001_custom_filter_btn_reset',
		title : "重置",
		autoDraw : false,
		click : "MDataGrid001_custom_filter.clearCriteria()"
	});
	isc.Button.create( {
		ID : 'MDataGrid001_custom_filter_btn_cancel',
		title : "取消",
		autoDraw : false,
		click : "MDataGrid001_custom_filter_window.hide()"
	});
	isc.Window.create( {
		ID : 'MDataGrid001_custom_filter_window',
		title : "高级查询",
		autoCenter : true,
		overflow : "auto",
		isModal : true,
		autoDraw : true,
		height : 300,
		width : 500,
		canDragResize : true,
		showMaximizeButton : true,
		items : [ MDataGrid001_custom_filter ],
		showFooter : true,
		footerHeight : 20,
		footerControls : [ isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid001_custom_filter_btn, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid001_custom_filter_btn_reset, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid001_custom_filter_btn_cancel, isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}) ]
	});
	MDataGrid001_custom_filter.resizeTo('100%', '100%');
	MDataGrid001_custom_filter_window.hide();
	isc.Page.setEvent(isc.EH.LOAD,function(){
						 	MDataGrid001.isMLoaded=true;
						 	MDataGrid001.draw();
						 	MDataGrid001.setData(MDataGrid001_DS);
						 	MDataGrid001.resizeTo('100%','100%');
						 isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
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
							<input id="DataGrid001_selection" name="DataGrid001_selection"
								type="hidden" />
							<input id="DataGrid001_data_entity"
								name="DataGrid001_data_entity" value="foundation.portal.Portal"
								type="hidden" />
						</td>
					</tr>
					<tr style="width: 100%; height: 35px;">
						<td class="toolStrip"
							style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;">
							<span id="blpageDataGrid001" class="paginator"> <span
								id="blpageDataGrid001:status" class="paginator_status"> </span>
							</span>
						</td>
						<td class="toolStrip"
							style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align: right; margin: 0px; padding: 0px;">
							<span id="brpageDataGrid001" class="paginator"
								style="float: right;"> <span id="brpageDataGrid001:first"
								class="paginator_first"> <img id="brpageDataGrid001_fI"
										src="<%=request.getContextPath()%>/matrix/resource/images/paginator/first_gray.gif"
										border="0" line-height="30px" /> </span> <span
								id="brpageDataGrid001:previous" class="paginator_previous">
									<img id="brpageDataGrid001_pI"
										src="<%=request.getContextPath()%>/matrix/resource/images/paginator/pre_gray.gif"
										border="0" line-height="30px" /> </span> <span
								class='paginator_separator'> <img
										src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
										border="0" line-height="30px" /> </span> <span
								id="brpageDataGrid001:go" class="paginator_go"> <span
									class="go_prefix" line-height="30px"> 第 </span> <span
									id="brpageDataGrid001:goText" class="paginator_go_text"
									line-height="30px"> </span> <span class="go_suffix"
									line-height="30px"> 页 </span> </span> <span
								class='paginator_separator'> <img
										src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
										border="0" line-height="30px" /> </span> <span
								id="brpageDataGrid001:next" class="paginator_next"> <img
										id="brpageDataGrid001_nI"
										src="<%=request.getContextPath()%>/matrix/resource/images/paginator/next_gray.gif"
										border="0" line-height="30px" /> </span> <span
								id="brpageDataGrid001:last" class="paginator_last"
								line-height="30px"> <img id="brpageDataGrid001_lI"
										src="<%=request.getContextPath()%>/matrix/resource/images/paginator/last_gray.gif"
										border="0" line-height="30px" /> </span> <span
								class="paginator_clean" line-height="30px"> </span> <span
								class='paginator_separator'> <img
										src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
										border="0" line-height="30px" /> </span> <span
								id="brpageDataGrid001:refresh" class="paginator_refresh"
								line-height="30px"> <a href="javascript:#"></a> </span> <span>
									&nbsp;&nbsp; </span> <span
								id="DataGrid001_brpageDataGrid001_dynamic_perpage_count_div"
								eventProxy="Mform0" class="matrixInline" line-height="30px">
							</span> <script>var DataGrid001_brpageDataGrid001_dynamic_perpage_count=
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
			 </script> </span>
						</td>
					</tr>
				</table>
				<script>
	function getParamsForDialog0(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		autoCenter: true,
		position:"absolute",
		height: "70%",
		width: "50%",
		title: "新增信息",
		canDragReposition: true,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
				<script>MDialog0.hide();
		</script>
				<script>
	function getParamsForDialog1(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog1",
		id:"Dialog1",
		name:"Dialog1",
		autoCenter: true,
		position:"absolute",
		height: "70%",
		width: "50%",
		title: "更新信息",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
				<script>MDialog1.hide();
		</script>
			</form>
		</div>
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>