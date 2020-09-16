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
			title : "对比区间",
			matrixCellId : "name",
			name : "name",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		}, {
			title : "平均运行时长",
			matrixCellId : "avg",
			name : "avg",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		}, {
			title : "最长时长",
			matrixCellId : "max",
			name : "max",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		}, {
			title : "最短时长",
			matrixCellId : "min",
			name : "min",
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