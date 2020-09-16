<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<head>
	<jsp:include page="/foundation/common/taglib.jsp"/>
	<jsp:include page="/foundation/common/resource.jsp"/>	
			<script>
	//选择完触发节点后
	function complete() {
		var data = MDataGrid002.getSelection();
		if (data != null && data.length > 0) {
			Matrix.closeWindow(data[0]);
		} else {
			Matrix.warn("请选择触发节点！");
		}
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
		action : "/moffice2/matrix.rform",
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
				action="/moffice2/matrix.rform"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="d90e8c4e-4cd8-4370-bb66-2427cfcf8613" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				
				<table id="table001" class="tableLayout" style="width: 100%;">
					<tr id="tr001">
						<td id="td001" class="tdLayout" style="width: 100%;">
							<table class="query_form_content"
								style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
								<tr>
									<td class="query_form_toolbar" colspan="2">
										<div id="QueryForm002_tb_div"
											style="width: 100%; height: 38px;; overflow: hidden;">
											<script>
	isc.ToolStrip.create( {
		ID : "MQueryForm002_tb",
		displayId : "QueryForm002_tb_div",
		width : "100%",
		height : "100%",
		position : "relative",
		members : []
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
										<div id="DataGrid002_div" class="matrixComponentDiv"
											style="width: 100%; height: 350px;">
											<script>
	var MDataGrid002_DS = [ {
		activityName : '发起',
		adid : '432375828421'
	}, {
		activityName : '审批',
		adid : '049473191314'
	} ];
	isc.MatrixListGrid.create( {
		ID : "MDataGrid002",
		name : "DataGrid002",
		displayId : "DataGrid002_div",
		position : "relative",
		width : "100%",
		height : "100%",
		showAllRecords:true,
		fields : [ {
			title : "&nbsp;",
			name : "MRowNum",
			canSort : false,
			canExport : false,
			canDragResize : false,
			showDefaultContextMenu : false,
			autoFreeze : true,
			autoFitEvent : 'none',
			width : 45,
			canEdit : false,
			canFilter : false,
			autoFitWidth : false,
			formatCellValue : function(value, record, rowNum, colNum, grid) {
				if (grid.startLineNumber == null)
					return '&nbsp;';
				return grid.startLineNumber + rowNum;
			}
		}, {
			title : "触发节点名称",
			matrixCellId : "activityName",
			name : "activityName",
			canEdit : false,
			editorType : 'Text',
			type : 'text'
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
			id : 'activityName',
			title : '触发节点名称'
		} ],
		showRecordComponents : true,
		showRecordComponentsByCell : true
	});
	isc.MatrixDataSource.create( {
		ID : 'MDataGrid002_custom_filter_ds',
		fields : [ {
			title : "触发节点名称",
			name : "activityName",
			type : 'text',
			editorType : 'Text'
		} ]
	});
	isc.FilterBuilder.create( {
		ID : 'MDataGrid002_custom_filter',
		dataSource : MDataGrid002_custom_filter_ds,
		overflow : 'auto',
		topOperatorAppearance : "none"
	});
	isc.Button.create( {
		ID : 'MDataGrid002_custom_filter_btn',
		title : "确认",
		autoDraw : false,
		click : "MDataGrid002.hideCustomFilter()"
	});
	isc.Button.create( {
		ID : 'MDataGrid002_custom_filter_btn_reset',
		title : "重置",
		autoDraw : false,
		click : "MDataGrid002_custom_filter.clearCriteria()"
	});
	isc.Button.create( {
		ID : 'MDataGrid002_custom_filter_btn_cancel',
		title : "取消",
		autoDraw : false,
		click : "MDataGrid002_custom_filter_window.hide()"
	});
	isc.Window.create( {
		ID : 'MDataGrid002_custom_filter_window',
		title : "高级查询",
		autoCenter : true,
		overflow : "auto",
		isModal : true,
		autoDraw : true,
		height : 300,
		width : 500,
		canDragResize : true,
		showMaximizeButton : true,
		items : [ MDataGrid002_custom_filter ],
		showFooter : true,
		footerHeight : 20,
		footerControls : [ isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid002_custom_filter_btn, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid002_custom_filter_btn_reset, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid002_custom_filter_btn_cancel, isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}) ]
	});
	MDataGrid002_custom_filter.resizeTo('100%', '100%');
	MDataGrid002_custom_filter_window.hide();
	isc.Page
			.setEvent(
					isc.EH.LOAD,
					function() {
						MDataGrid002.isMLoaded = true;
						MDataGrid002.draw();
						MDataGrid002.setData(MDataGrid002_DS);
						MDataGrid002.resizeTo('100%', '100%');
						isc.Page
								.setEvent(
										isc.EH.RESIZE,
										function() {
											isc.Page
													.setEvent(
															isc.EH.RESIZE,
															"MDataGrid002.resizeTo(0,0);MDataGrid002.resizeTo('100%','100%');",
															null);
										}, isc.Page.FIRE_ONCE);
					}, isc.Page.FIRE_ONCE);
	if (Matrix.getDataGridIdsHiddenOfForm('form0')) {
		Matrix.getDataGridIdsHiddenOfForm('form0').value = Matrix
				.getDataGridIdsHiddenOfForm('form0').value + ',DataGrid002'
	}
</script>
										</div>
										<input id="DataGrid002_data_entity"
											name="DataGrid002_data_entity"
											value="office.flow.TriggerPoint" type="hidden" />
									</td>
								</tr>
							</table>

						</td>
					</tr>
					<tr id="tr002">
						<td id="td002" class="maintain_form_command" style="width: 100%;">
							<div id="button001_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>
	isc.Button.create( {
		ID : "Mbutton001",
		name : "button001",
		title : "确定",
		displayId : "button001_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		icon : "[skin]/images/matrix/actions/save.png",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton001.click = function() {
		Matrix.showMask();
		var x = eval("complete();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton001.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
							</div>
							<div id="button002_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>
	isc.Button.create( {
		ID : "Mbutton002",
		name : "button002",
		title : "取消",
		displayId : "button002_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		icon : "[skin]/images/matrix/actions/exit.png",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton002.click = function() {
		Matrix.showMask();
		var x = eval("Matrix.closeWindow();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton002.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
							</div>
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
