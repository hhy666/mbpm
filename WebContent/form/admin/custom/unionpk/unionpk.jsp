<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'unionpk.jsp' starting page</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	</head>
	<script type="text/javascript">
	/*
	function addUser() {
		var grid0 = Matrix.getComponentById("DataGrid001");
		var selection0 = grid0.getSelection();
		if (selection0 != null && selection0.length > 0) {
			var grid1 = Matrix.getComponentById("DataGrid002");
			var newData = isc.JSON.decode(isc.JSON.encode(selection0));
			var list = new Array();
			var grid1data = grid1.getData();
			for ( var i = 0; i < newData.length; i++) {
				var data = newData[i];
				if (grid1data != null && grid1data.length > 0) {
					var containsFlag = false;
					for ( var j = 0; j < grid1data.length; j++) {
						var olddata = grid1data[j];
						if (olddata.propertyId== data.propertyId) {
							containsFlag = true;
							break;
						}
					}
					if (!containsFlag) {
						delete data[grid0.selection.selectionProperty];
						delete data["_recordComponents_" + grid0.ID];
						list.add(data);
					}
				} else {
					delete data[grid0.selection.selectionProperty];
					delete data["_recordComponents_" + grid0.ID];
					list.add(data);
				}
			}
			grid1.getData().addAll(list);
		}

	}
	function removeUser() {
		var grid1 = Matrix.getComponentById("DataGrid002");
		var selection1 = grid1.getSelection();
		if (selection1 != null && selection1.length > 0) {
			grid1.removeSelectedData();
		}
	}*/
	function saveUser() {
		var data = [];
		var unionPKText;
		var unionPKValue;
		Matrix.saveDataGridData("DataGrid001");
		var list=MDataGrid001.getData();
		if (list != null && list.length > 0) {
			for ( var i = 0; i < list.length; i++) {
				if(list[i].check==true){
					data.add(list[i]);
				}
			}
		}
		if (data != null && data.length > 0) {
			var result = isc.JSON.decode(isc.JSON.encode(data));
			for ( var j = 0; j < result.length; j++) {
				var item = result[j];
				if(j==0){
				unionPKText="{"+item.formData+"}";
				unionPKValue=item.propertyId;
				}else{
				unionPKText+="{"+item.formData+"}";
				unionPKValue+=item.propertyId;
				}
				var p1 = item.propertyId.split(".");
				var p2;
				if(j!=result.length-1){p2=result[j+1].propertyId.split(".")}
				if((j!=result.length-1)&&p1[0]!=p2[0]){
						unionPKText+=" ";
						unionPKValue+=" ";
				}else{
					if(j!=result.length-1){
						unionPKText+=",";
						unionPKValue+=",";
					}
				}
			}
			var closeData='{\"unionPKText\":\"';
				closeData+=unionPKText;
				closeData+='\",\"unionPKValue\":\"';
				closeData+=unionPKValue;
				closeData+='\"}';
				var json = eval("("+closeData+")");
			Matrix.closeWindow(json);
		} else {
			Matrix.closeWindow(null);
			return false;
		}
	}/**
	isc.Page.setEvent(isc.EH.KEY_PRESS, function() {
		var _key = isc.Event.getKey();
		if (_key == "Enter"
				&& MconditionValue == MconditionValue.form.getFocusItem()) {
			MtoolBarItem001.click();
		}
	});**/
</script>
	<body>
		<jsp:include page="/form/admin/common/loading.jsp" />
		<script>
	var Mform0 = isc.MatrixForm.create( {
		ID : "Mform0",
		name : "Mform0",
		position : "absolute",
		action : "/mofficeV3/matrix.rform",
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
			style="width: 100%; height: 100%; overflow: hidden; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="/mofficeV3/matrix.rform"
				style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;"
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
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<table id="table001" class="tableLayout"
					style="width: 100%; height: 100%;">
					<tr id="tr001">
									<td id="td006" colspan="2"
										style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
										<div id="DataGrid001_div" class="matrixComponentDiv"
											style="width: 100%; height: 100%;">
											<script>
	var MDataGrid001_DS =<%=request.getAttribute("source")%>;
	isc.MatrixListGrid.create( {
				ID : "MDataGrid001",
				name : "DataGrid001",
				displayId : "DataGrid001_div",
				position : "relative",
				width : "100%",
				height : "100%",
				showAllRecords:true,
				fields : [
						{
							title : "&nbsp;",
							name : "MRowNum",
							canSort : false,
							canExport : false,
							canDragResize : false,
							showDefaultContextMenu : false,
							autoFreeze : true,
							autoFitEvent : 'none',
							width : 45,
							canEdit : true,
							canFilter : false,
							autoFitWidth : false,
							formatCellValue : function(value, record, rowNum,
									colNum, grid) {
								if (grid.startLineNumber == null)
									return '&nbsp;';
								return grid.startLineNumber + rowNum;
							}
						}, {
							title : "表单数据",
							matrixCellId : "formData",
							name : "formData",
							canEdit : false,
							editorType : 'Text',
							width:'80%',
							type : 'text'
						},{
							title : "选择",
							matrixCellId : "check",
							name : "check",
							canEdit : true,
							editorType:'Checkbox',
							width:'20%',
							type : 'boolean'
		} ],
				autoSaveEdits : false,
				isMLoaded : false,
				autoDraw : false,
				autoFetchData : true,
				selectionType : "multiple",
				canDragSelect : true,
				alternateRecordStyles : true,
				showRollOver : true,
				canSort : true,
				canEdit : true,
				autoFitFieldWidths : false,
				recordDoubleClick : function(viewer, record, recordNum, field,
						fieldNum, value, rawValue) {
				},
				autoFitData : "true",
				autoFitMaxRecords : true,
				startLineNumber : 1,
				editEvent : "doubleClick",
				canCustomFilter : true,
				exportCells : [ {
					id : 'formData',
					title : '表单数据'
				} ],
				showRecordComponents : true,
				showRecordComponentsByCell : true
			});
	MDataGrid001.deleteItems = [];
	MDataGrid001.updateItems = [];
	MDataGrid001.insertItems = [];
	isc.MatrixDataSource.create( {
		ID : 'MDataGrid001_custom_filter_ds',
		fields : [ {
			title : "表单数据",
			name : "formData",
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
											name="DataGrid001_data_entity" value="foundation.org.User"
											type="hidden" />
										<input id="DataGrid001_cur_page_num"
											name="DataGrid001_cur_page_num" type="hidden" value="1" />
									
						</td>
						</tr>
					<tr id="tr002">
						<td id="td004" class="tdLayout" colspan="3"
							style="width: 100%; height: 30px; text-align: center;">
							<div id="button003_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>
	isc.Button.create( {
		ID : "Mbutton003",
		name : "button003",
		title : "确认",
		displayId : "button003_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton003.click = function() {
		Matrix.showMask();
		var x = eval("saveUser();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton003.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
							</div>
							<div id="button004_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>
	isc.Button.create( {
		ID : "Mbutton004",
		name : "button004",
		title : "关闭",
		displayId : "button004_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton004.click = function() {
		Matrix.showMask();
		var x = eval("Matrix.closeWindow();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton004.enable();
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
