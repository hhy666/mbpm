<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<head>
			<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
		<script>
	function saveSelectItems() {
		var data=[];
		var catalogId=Matrix.getFormItemValue("catalogId");
		var catalogName=Matrix.getFormItemValue("catalogName");
		var dataType=Matrix.getFormItemValue("dataType");
		var dataTypeVal=disValue[dataType];
		if(catalogId!=null&&catalogId!=""&&catalogId.length>0){
			data.dataType=dataType;
			data.codeId=catalogId;
			data.info=dataTypeVal+'('+catalogId+')';
			data.infoStr=dataTypeVal+'('+catalogName+')';
			Matrix.closeWindow(data);
		}else{
			warn("请选择代码!");
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
	isc.Page.setEvent(isc.EH.LOAD, "", isc.Page.FIRE_ONCE);
</script>
		<script>
	var M_mform_01 = isc.MatrixForm.create( {
		ID : "M_mform_01",
		name : "M_mform_01",
		position : "absolute",
		action : "<%=request.getContextPath()%>/Logon.rform",
		canSelectText : true,
		fields : [ {
			name : '_mform_01_hidden_text',
			width : 0,
			height : 0,
			displayId : '_mform_01_hidden_text_div'
		} ]
	});
</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="_mform_01" name="_mform_01" eventProxy="M_mform_01"
				method="post" action="<%=request.getContextPath()%>/Logon.rform"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="_mform_01" value="_mform_01" />
				<input type="hidden" id="mode" name="mode" value="propertyedit" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="catalogId" name="catalogId" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
				<input type="hidden" id="matrix_form_datagrid__mform_01"
					name="matrix_form_datagrid__mform_01" value="" />
				<div type="hidden" id="_mform_01_hidden_text_div"
					name="_mform_01_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<input id="componentType" type="hidden" name="componentType"
					value="SelectItems" />
				<input id="parentType" type="hidden" name="parentType"
					value="DataCell" />
				<input id="level" type="hidden" name="level" />
				<table class="maintain_form_content" style="width: 100%;">
					<tr>
						<td class="maintain_form_label">
							<label id="j_id0" name="j_id0">
								类型：
							</label>
						</td>
						<td class="maintain_form_input">
							<div id="dataType_div" eventProxy="M_mform_01"
								class="matrixInline" style=""></div>
							<script>
	var MdataType_VM = [];
	var disValue={
		'code' : '基本代码',
		'custom' : '自定义代码'
	};
	var dataType = isc.ComboBoxItem.create( {
		ID : "MdataType",
		name : "dataType",
		editorType : "ComboBoxItem",
		displayId : "dataType_div",
		autoDraw : false,
		valueMap : [],
		value : "code",
		position : "relative",
		width : 300,
		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return Matrix.validateRegexp(Matrix.OtherProRegExp, value);
			},
			errorMessage : "不能包含怪字符"
		} ],
		changed : "",
		attrName : 'dataType',
		editorExit : 'Matrix.resetComponentProperty(item);'
	});
	M_mform_01.addField(dataType);
	MdataType_VM = [ 'code', 'custom'];
	MdataType.displayValueMap = disValue;
	MdataType.setValueMap(MdataType_VM);
	MdataType.setValue('code');
</script>
						</td>
					</tr>
					<tr>
						<td class="maintain_form_label">
							<label id="j_id1" name="j_id1">
								代码：
							</label>
						</td>
						<td class="maintain_form_input">
							<table id='catalogId_table' ,width:315
								style='width: 315px; height: 22px; table-layout: fixed; border-collapse: collapse; border-spacing: 0; padding: 0; margin: 0;'>
								<tr>
									<td style='padding: 0;'>
										<div id="catalogId_div" style='width: 100%; height: 100%'
											eventProxy="M_mform_01"></div>
									</td>
									<td
										style='width: 20px; height: 100%; text-align: center; padding: 0;'>
										<div id='catalogId_button_div'
											style='position: relative; width: 100%; height: 100%; vertical-align: middle;'
											class='matrixInline'>
											<script>
												isc.ImgButton.create( {
													ID : "McatalogId_button",
													name : "catalogId_button",
													displayId : "catalogId_button_div",
													showDisabled : false,
													showDisabledIcon : false,
													showDown : false,
													showDownIcon : false,
													showRollOver : false,
													showRollOverIcon : false,
													position : "relative",
													width : 16,
													height : 16,
													src : "[skin]/images/matrix/actions/query_advance.png"
												});
												McatalogId_button.click = function() {
											
													Matrix.showMask();
											
													var x = eval("Matrix.showWindow('catalogIdDialog');");
													if (x != null && x == false) {
														Matrix.hideMask();
														return false;
													}
													Matrix.hideMask();
												};
											</script>
										</div>
									</td>
								</tr>
							</table>
							<script>
	var catalogName = isc.TextItem.create( {
		ID : "McatalogName",
		name : "catalogName",
		editorType : "TextItem",
		displayId : "catalogId_div",
		width : "100%",
		position : "relative",
		autoDraw : false,
		attrName : 'catalogName',
		value : "",
		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return Matrix.validateRegexp(Matrix.OtherProRegExp, value);
			},
			errorMessage : "不能包含怪字符"
		} ],
		attrName : 'catalogName',
		canEdit : false
	});
	M_mform_01.addField(catalogName);
</script>
							<script>
	function getParamsForcatalogIdDialog() {
		var params = '&';
		var value;
		value = null;
		try {
			value = eval("id");
		} catch (error) {
			value = "id"
		}
		if (value != null) {
			value = "id=" + value;
			params += value;
		}
		return params;
	}
	isc.Window.create( {
		ID : "McatalogIdDialog",
		id : "catalogIdDialog",
		name : "catalogIdDialog",
		position : "absolute",
		height : "80%",
		width : "450px",
		title : "选择代码类别",
		autoCenter : true,
		animateMinimize : false,
		canDragReposition : true,
		showHeaderIcon : false,
		showTitle : true,
		showMinimizeButton : false,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		isModal : true,
		autoDraw : false,
		getParamsFun : getParamsForcatalogIdDialog,
		initSrc : "<%=request.getContextPath()%>/common/commonCode_loadSelectCodeTreePage.action",
		src : "<%=request.getContextPath()%>/common/commonCode_loadSelectCodeTreePage.action",
		attrName : 'catalogId',
		editorExit : 'Matrix.resetComponentProperty(item);'
	});
	function oncatalogIdDialogClose(data) {

		if (data == null)
			return true;
		if (isc.isA.String(data))
			data = isc.JSON.decode(data);
		
		if (data['id'] != null) {
			var mform = Matrix.getMatrixComponentById('_mform_01');
			var field = mform.getField('catalogName');
			if (field != null) {
				mform.setValue('catalogName', data['text']);
				Matrix.setFormItemValue('catalogId', data['id']);
				if (field.editorExit != null
						&& isc.isA.Function(field.editorExit))
					field.editorExit(mform, field);
			} else {
				field = document.getElementById('catalogId');
				if (field != null) {
					field.value = data['id']
				}
			}
		}

	}
</script>
						</td>
					</tr>
							<script>
	var itemLabel = isc.TextItem.create( {
		ID : "MitemLabel",
		name : "itemLabel",
		editorType : "TextItem",
		displayId : "itemLabel_div",
		width : "100%",
		position : "relative",
		autoDraw : false,
		attrName : 'itemLabel',
		editorExit : 'Matrix.resetComponentProperty(item);',
		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return Matrix.validateRegexp(Matrix.OtherProRegExp, value);
			},
			errorMessage : "不能包含怪字符"
		} ],
		attrName : 'itemLabel',
		editorExit : 'Matrix.resetComponentProperty(item);'
	});
	M_mform_01.addField(itemLabel);
</script>
							<script>
	function getParamsForitemLabelDialog() {
		var params = '&';
		var value;
		value = null;
		try {
			value = eval("list");
		} catch (error) {
			value = "list"
		}
		if (value != null) {
			value = "command=" + value;
			params += value;
		}
		value = null;
		params += '&';
		try {
			value = eval("propertyedit");
		} catch (error) {
			value = "propertyedit"
		}
		if (value != null) {
			value = "mode=" + value;
			params += value;
		}
		value = null;
		params += '&';
		try {
			value = eval("Matrix.getFormItemValue('entity')");
		} catch (error) {
			value = "Matrix.getFormItemValue('entity')"
		}
		if (value != null) {
			value = "entity=" + value;
			params += value;
		}
		value = null;
		params += '&';
		try {
			value = eval("select");
		} catch (error) {
			value = "select"
		}
		if (value != null) {
			value = "page=" + value;
			params += value;
		}
		return params;
	}
	isc.Window.create( {
		ID : "MitemLabelDialog",
		id : "itemLabelDialog",
		name : "itemLabelDialog",
		position : "absolute",
		height : "90%",
		width : "450px",
		title : "选择显示名称",
		autoCenter : true,
		animateMinimize : false,
		canDragReposition : false,
		showHeaderIcon : false,
		showTitle : true,
		showMinimizeButton : false,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		isModal : true,
		autoDraw : false,
		getParamsFun : getParamsForitemLabelDialog,
		initSrc : "<%=request.getContextPath()%>/form.daction?componentType=DataProperty",
		src : "<%=request.getContextPath()%>/form.daction?componentType=DataProperty",
		attrName : 'itemLabel',
		editorExit : 'Matrix.resetComponentProperty(item);'
	});
	function onitemLabelDialogClose(data) {

		if (data == null)
			return true;
		if (isc.isA.String(data))
			data = isc.JSON.decode(data);
		if (data['mid'] != null) {
			var mform = Matrix.getMatrixComponentById('_mform_01');
			var field = mform.getField('itemLabel');
			if (field != null) {
				mform.setValue('itemLabel', data['mid']);
				if (field.editorExit != null
						&& isc.isA.Function(field.editorExit))
					field.editorExit(mform, field);
			} else {
				field = document.getElementById('itemLabel');
				if (field != null) {
					field.value = data['mid']
				}
			}
		}

	}
</script>
						</td>
					</tr>
					<tr>
						<td class="cmdLayout" colspan="2">
							<div id="ToolBarItem0_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({
								ID:"MToolBarItem0",
								name:"ToolBarItem0",
								title:"保存",
								displayId:"ToolBarItem0_div",
								position:"absolute",
								top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});MToolBarItem0.click=function(){Matrix.showMask();var x = eval("saveSelectItems();");if(x!=null && x==false){Matrix.hideMask();MToolBarItem0.enable();return false;}Matrix.hideMask();};</script>
							</div>
							<div id="ToolBarItemd_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({ID:"MToolBarItemd",name:"ToolBarItemd",title:"关闭",displayId:"ToolBarItemd_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});MToolBarItemd.click=function(){Matrix.showMask();var x = eval("Matrix.closeWindow();");if(x!=null && x==false){Matrix.hideMask();MToolBarItemd.enable();return false;}Matrix.hideMask();};</script>
							</div>
						</td>
					</tr>
				</table>

			</form>
		</div>
		<script>M_mform_01.initComplete=true;M_mform_01.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"M_mform_01.redraw()",null);},isc.Page.FIRE_ONCE);</script>
	</body>
</html>
