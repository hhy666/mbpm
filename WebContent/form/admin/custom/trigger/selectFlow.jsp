<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<head>
		<jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>

		<script>
	//点击确认按钮
	function selectedTemp() {
		var select = MTree001.getSelection();
		if (select != null) {
			if (!select[0].isFolder) {
				var uuid = select[0].entityId;//选中的树节点的主键
				var formDid = select[0].extr1;//选中的树节点的类型
				var name = select[0].text;//树节点名称
				var pdid = select[0].extr2;//流程定义编码
				var json = "{'uuid':'" + uuid + "','formId':'" + formDid
						+ "','name':'" + name + "','pdid':'" + pdid + "'}";
				var data = isc.JSON.decode(json);
				Matrix.closeWindow(data);
			} else {
				Matrix.warn('请选择流程！');
			}
		} else {
			Matrix.warn('请选择流程！');
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
		action : "<%=path%>/matrix.rform",
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
				action="<%=path%>/matrix.rform"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="e0ef489a-cde9-4fac-8e68-28b17111c6b3" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				
				<table id="table001" class="tableLayout"
					style="width: 100%; height: 100%">
					<tr id="tr001">
						<td id="td001" class="tdLayout"
							style="width: 100%; height: 90%; border-bottom: 0px;">
							<div id="Tree001_div" class="matrixComponentDiv">
								<script>
	isc.MatrixTree.create( {
		ID : "MTree001_DS",
		modelType : "children",
		ownerType : "tree",
		formId : "form0",
		autoOpenRoot : false,
		ownerId : "Tree001",
		childrenProperty : "children",
		nameProperty : "text",
		root : {
			id : "RootTreeNode",
			entityId : "RootTreeNode",
			text : "RootTreeNode"
		}
	});
	isc.Page.setEvent('load', 'MTree001_DS.openFolder(MTree001_DS.root)',
			isc.Page.FIRE_ONCE);
	isc.MatrixTreeGrid.create( {
		ID : "MTree001",
		name : "Tree001",
		displayId : "Tree001_div",
		position : "relative",
		showHeader : false,
		showCellContextMenus : true,
		leaveScrollbarGap : false,
		data : MTree001_DS,
		autoFetchData : true,
		canAutoFitFields : true,
		showHover : false,
		showRoot : false,
		wrapCells : false,
		fixedRecordHeights : true,
		selectionType : "single",
		selectionAppearance : "rowStyle",
		showSelectedStyle : true,
		showOpenIcons : false,
		closedIconSuffix : '',
		showPartialSelection : false,
		cascadeSelection : false,
		border : 0,
		showRollOver : false
	});
	isc.Page.setEvent(isc.EH.LOAD, "MTree001.resizeTo('100%','100%');");
	isc.Page.setEvent(isc.EH.RESIZE,
			"MTree001.resizeTo(0,0);MTree001.resizeTo('100%','100%');", null);
</script>
							</div>
						</td>
					</tr>
					<tr id="tr002">
						<td id="td002" class="cmdLayout">
							<div id="button001_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>
	isc.Button.create( {
		ID : "Mbutton001",
		name : "button001",
		title : "确认",
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
		var x = eval("selectedTemp();");
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
