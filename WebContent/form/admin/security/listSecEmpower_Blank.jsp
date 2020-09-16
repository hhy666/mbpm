<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<%@ page import="com.matrix.form.admin.common.utils.CompTypeConstant"%>
<%
	String curUser = CommonUtil.getFormUser();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<title>授权占位页面</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />

	</head>

	<body>
		<jsp:include page="/form/admin/common/loading.jsp" />
		<script>
            var M_mform_01 = isc.MatrixForm.create({
                ID: "M_mform_01",
                name: "M_mform_01",
                position: "absolute",
                action: "<%=request.getContextPath()%>/Logon.jsp",
                fields: [{
                    name: '_mform_01_hidden_text',
                    width: 0,
                    height: 0,
                    displayId: '_mform_01_hidden_text_div'
                }]
            });
        </script>
		<div
			style="width: 100%; height: 100%; overflow: hidden; position: relative;">
			<form id="_mform_01" name="_mform_01" eventProxy="M_mform_01"
				method="post" action="<%=request.getContextPath()%>/Logon.jsp"
				style="margin: 0px; position: relative; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<div type="hidden" id="_mform_01_hidden_text_div"
					name="_mform_01_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;">
				</div>
				<table
					style="width: 100%; height: 100%; overflow: hidden; cellpadding: collapse; cellspacing: 0px; border-collapse: collapse; border-spacing: 0px;">
					<tr>
						<td colspan="2"
							style="border-style: none; width: 100%; height: 25; overflow: hidden;">
							<script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem0",
                                    icon: Matrix.getActionIcon("save"),
                                    title: "保存",
                                    showDisabledIcon: false,
                                    showDownIcon: false,
                                    disabled:true
                                });
                                MToolBarItem0.click = function() {
                                   
                                }
                            </script>
							<div id="DataGrid0_QF_tb_div"
								style="width: 100%; height: 38px;; overflow: hidden;">
								<script>
                                    isc.ToolStrip.create({
                                        ID: "MDataGrid0_QF_tb",
                                        displayId: "DataGrid0_QF_tb_div",
                                        width: "100%",
                                        height: "100%",
                                        position: "relative",
                                        align:"right",
                                        members: [MToolBarItem0]
                                    });
                                    isc.Page.setEvent(isc.EH.RESIZE,
                                    function() {
                                        isc.Page.setEvent(isc.EH.RESIZE, "MDataGrid0_QF_tb.resizeTo(0,0);MDataGrid0_QF_tb.resizeTo('100%','100%');", null);
                                    },
                                    isc.Page.FIRE_ONCE);
                                </script>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"
							style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
							<div id="DataGrid0_div" class="matrixComponentDiv"
								style="width: 100%; height: 100%;">
								<script>
                                    var MDataGrid0_DS = [];
                                    isc.MatrixListGrid.create({
                                        ID: "MDataGrid0",
                                        name: "DataGrid0",
                                        displayId: "DataGrid0_div",
                                        position: "relative",
                                        width: "100%",
                                        height: "100%",
                                        fields: [
                                        {
                                            title: "&nbsp;",
                                            name: "MRowNum",
                                            canSort: false,
                                            canExport: false,
                                            canDragResize: false,
                                            showDefaultContextMenu: false,
                                            autoFreeze: true,
                                            autoFitEvent: 'none',
                                            width: '10%',
                                            canEdit: false,
                                            canFilter: false,
                                            autoFitWidth: false,
                                            formatCellValue: function(value, record, rowNum, colNum, grid) {
                                                if (grid.startLineNumber == null) return '&nbsp;';
                                                return grid.startLineNumber + rowNum;
                                            }
                                        },
                                        {
                                            title: "控件名称",
                                            matrixCellId: "j_id0",
                                            name: "componentName",
                                            canSort: false,
                                            canEdit: false,
                                            width:'20%',
                                            editorType: 'Text',
                                            type: 'text',
                                            formatCellValue: function(value, record, rowNum, colNum, grid) {
                                                return Matrix.formatter(value, 'normal', 'null', record, rowNum, colNum, grid);
                                            }
                                        },
                                        {
                                            title: "控件类型",
                                            matrixCellId: "j_id1",
                                            name: "componentType",
                                            canSort: false,
                                            canEdit: false,
                                            width:'20%',
                                            editorType: 'Text',
                                            type: 'text',
                                            formatCellValue: function(value, record, rowNum, colNum, grid) {
                                                return Matrix.formatter(value, 'normal', 'null', record, rowNum, colNum, grid);
                                            }
                                        },
                                        {
                                            title: "可显示",
                                            matrixCellId: "j_id2",
                                            name: "isDisplay",
                                            canEdit: true,
                                            width: '10%',
                                            type: 'boolean',
                                            changed: function(form, item, value) {
                                                displayChanged(form, item, value);
                                            }
                                        },
                                        {
                                            title: "可编辑",
                                            matrixCellId: "j_id3",
                                            name: "isEdit",
                                            canEdit: true,
                                            width: '10%',
                                            type: 'boolean',
                                            changed: function(form, item, value) {
                                                editChanged(form, item, value);
                                            }
                                        },
                                        // 必填项  -----lpz------
                                         {
                                            title: "必填项",
                                            matrixCellId: "j_id4",
                                            name: "isRequired",
                                            canEdit: true,
                                            width: '10%',
                                            type: 'boolean',
                                            changed: function(form, item, value) {
                                                requiredToWrite(form, item, value);
                                            }
                                        },
                                        {
										    title: "默认值",
										    matrixCellId: "j_id5",
										    name: "isBusOper",
										    canEdit: true,
										    width: '10%',
										    canHide:true,
										    type: 'boolean'
										}
										
										
							<%
										
									try{
										if(com.matrix.form.admin.common.utils.CommonUtil.getCurPhase()==CompTypeConstant.PHASE_CUSTOMIZE){%>
										,{//操作设置的伪列
											title:"操作设置",
											matrixCellId:"DataCell001",
											name:"col6",
											canSort:false,
											canFilter:false,
											canEdit:false,
											canExport:false,
											formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.conditionFormatter(value,[{_value:'设置',_link:'javascript:show(\''+record.appId+' \');',_condition:true,_type:'link_type'}],record, rowNum, colNum,grid);},displayType:"Custom_Type"}
										<%}
										}catch(Exception e){
											e.printStackTrace();
										}finally {
    										
										}
										
										%>
										],
                                        autoSaveEdits: false,
                                        isLoaded: false,
                                        autoDraw: false,
                                        autoFetchData: true,
                                        selectionType: "single",
                                        selectionAppearance: "rowStyle",
                                        alternateRecordStyles: true,
                                        canSort: false,
                                        autoFitFieldWidths: false,
                                        startLineNumber: 1,
                                        showHeaderContextMenu: false,
                                        canEdit: false,
                                        editEvent: "click",
                                        exportCells: [{
                                            id: 'j_id0',
                                            title: '控件名称'
                                        },
                                        {
                                            id: 'j_id1',
                                            title: '控件类型'
                                        },
                                        {
                                            id: 'j_id2',
                                            title: '可显示'
                                        },
                                        {
                                            id: 'j_id3',
                                            title: '可编辑'
                                        },
                                        {
                                            id: 'j_id4',
                                            title: '必填项'
                                        }],
                                        showRecordComponents: true,
                                        showRecordComponentsByCell: true
                                    });
                                    isc.Page.setEvent(isc.EH.LOAD,
                                    function() {
                                        MDataGrid0.isLoaded = true;
                                        MDataGrid0.draw();
                                      // MDataGrid0.setData(MDataGrid0_DS);
                                        MDataGrid0.resizeTo('100%', '100%');
                                        isc.Page.setEvent(isc.EH.RESIZE,
                                        function() {
                                            isc.Page.setEvent(isc.EH.RESIZE, "MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');", null);
                                        },
                                        isc.Page.FIRE_ONCE);
                                    },
                                    isc.Page.FIRE_ONCE);
                                    if (Matrix.getDataGridIdsHiddenOfForm('_mform_01')) {
                                        Matrix.getDataGridIdsHiddenOfForm('_mform_01').value = Matrix.getDataGridIdsHiddenOfForm('_mform_01').value + ',DataGrid0'
                                    }
                                </script>
							</div>
							<input id="matrix_Logon_dataGrid_DataGrid0"
								name="matrix_Logon_dataGrid_DataGrid0" type="hidden"
								value="DataGrid0" />
							<input id="DataGrid0_data_entity" name="DataGrid0_data_entity"
								type="hidden" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script>
        	var curMode = "<%=curUser%>	_";

	M_mform_01.initComplete = true;
	M_mform_01.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "M_mform_01.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>

	</body>

</html>