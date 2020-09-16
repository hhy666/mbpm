<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script>
			function getSelectData(){ //点击确定关闭窗口时
				debugger;
				var select = MDataGrid001.getSelection();
				if(select != null&&select.length>0){
					var data = select[0];
					var jsonStr = "{'pointId':'";
					jsonStr += data.pointId;
					jsonStr += "','pointName':'";
					jsonStr += data.pointName;
					jsonStr += "'}";
					Matrix.closeWindow(jsonStr);
				}else{
					Matrix.warn("请选择流程节点");
				}
			}
			function doubleClick(record){  // 双击选择
				Matrix.closeWindow(isc.JSON.encode(record));
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
		action : "<%=request.getContextPath()%>/trigger/checkPointAction_getPointList.action",
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
				action="<%=request.getContextPath()%>/trigger/checkPointAction_getPointList.action"
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
				
				<table class="maintain_form_content"
					style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
					<tr>
						<td colspan="2"
							style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
							<div id="DataGrid001_div" class="matrixComponentDiv"
								style="width: 100%; height: 100%;">
								<script>
	var MDataGrid001_DS = <%=request.getAttribute("jsonStr")%>;
	isc.MatrixListGrid.create( {
		ID : "MDataGrid001",
		name : "DataGrid001",
		displayId : "DataGrid001_div",
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
			title : "节点编码",
			matrixCellId : "pointId",
			name : "pointId",
			canEdit : false,
			editorType : 'Text',
			type : 'text'
		}, {
			title : "节点名称",
			matrixCellId : "pointName",
			name : "pointName",
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
			id : 'pointId',
			title : '节点编码'
		}, {
			id : 'pointName',
			title : '节点名称'
		} ],
		showRecordComponents : true,
		showRecordComponentsByCell : true,
		cellDoubleClick : function (record, rowNum, colNum){//双击事件
						  doubleClick(record);
		}
	});
	isc.MatrixDataSource.create( {
		ID : 'MDataGrid001_custom_filter_ds',
		fields : [ {
			title : "节点编码",
			name : "pointId",
			type : 'text',
			editorType : 'Text'
		}, {
			title : "节点名称",
			name : "pointName",
			type : 'text',
			editorType : 'Text'
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
	isc.Page
			.setEvent(
					isc.EH.LOAD,
					function() {
						MDataGrid001.isMLoaded = true;
						MDataGrid001.draw();
						MDataGrid001.setData(MDataGrid001_DS);
						MDataGrid001.resizeTo('100%', '100%');
						isc.Page
								.setEvent(
										isc.EH.RESIZE,
										function() {
											isc.Page
													.setEvent(
															isc.EH.RESIZE,
															"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",
															null);
										}, isc.Page.FIRE_ONCE);
					}, isc.Page.FIRE_ONCE);
	if (Matrix.getDataGridIdsHiddenOfForm('form0')) {
		Matrix.getDataGridIdsHiddenOfForm('form0').value = Matrix
				.getDataGridIdsHiddenOfForm('form0').value + ',DataGrid001'
	}
</script>
							</div>
							<input id="DataGrid001_data_entity"
								name="DataGrid001_data_entity"
								value="comprehensive.discuss.discussmodule.DiscussBoardBO"
								type="hidden" />
						</td>
					</tr>
	<tr id="j_id12" jsId="j_id12">
		<td id="j_id13" jsId="j_id13" class="maintain_form_command" colspan="2">
			
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormSubmitButton",
					name:"dataFormSubmitButton",
					title:"确认",
					displayId:"dataFormSubmitButton_div",
					position:"absolute",
					top:0,left:0,width:"100%",height:"100%",
					icon:Matrix.getActionIcon("save"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					getSelectData();
					
		            Matrix.hideMask();
            };</script></div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,left:0,width:"100%",height:"100%",
					icon:Matrix.getActionIcon("exit"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
					});
					MdataFormCancelButton.click=function(){
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
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>
