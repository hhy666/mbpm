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
</script>
<style type="text/css">
.imgHeaderButton, .headerButton, .sorterButton {
    background-color: #F5F5F5;
    /* color: gray; */
    color: black;
    font-weight: bold;
    font-size: 12px;
    /* border-bottom: 1px solid #bfbfbf; */
    border-left: 1px solid #ddd;
    border-right: none;
    border-bottom: 0px;
    padding-left: 0px;
    padding-right: 0px;
    /* height: 40px; */
    border-top: 1px solid #ddd;
}
.cellDark,.cellOverDark,.cellSelectedDark{background:#FFFFFF}
</style>
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
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="7d741943-5cd8-441f-8dba-126cfb07db62" />
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
						<td colspan="2"
							style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
							<div id="DataGrid001_div" class="matrixComponentDiv"
								style="width: 100%; height: 100%;">
								<script>
	var MDataGrid001_DS = <%=request.getAttribute("str")%>;
	isc.MatrixListGrid.create( {
		ID : "MDataGrid001",
		name : "DataGrid001",
		displayId : "DataGrid001_div",
		position : "relative",
		width : "100%",
		height : "100%",
		fields : [ {
			title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}}, {
			title : "时间",
			matrixCellId : "time",
			name : "time",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		}, {
			title : "统计",
			matrixCellId : "count",
			name : "count",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		}],
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
			id : 'time',
			title : '时间'
		}, {
			id : 'count',
			title : '统计'
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
				<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
				<input id="DataGrid001_data_entity" name="DataGrid001_data_entity" value="foundation.portal.Portal" type="hidden" />
		</td>
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