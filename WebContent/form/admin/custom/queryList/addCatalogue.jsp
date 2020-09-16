<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>添加子目录!</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />

		<script type="text/javascript">
		window.onload=function(){
			var type='${codeNode.type}';
			if(type=='0'&&type!=null&&type!=""){
				Mname.setDisabled(true);
			}
		}
	//添加或保存操作 提交
	function addOrUpdateCodeSubmit() {
		//处理 id 和 mid 
		var name = Matrix.getMatrixComponentById("name").getValue();
		document.getElementById("id").value = name;
		//操作类型
		var oType = "${param.oType}";
		var form0 = document.getElementById('Form0');
		if (oType != null && "add" == oType) {//添加
			form0.submit();
		} else if (oType != null && "update" == oType) {//更新
			form0.action = "query/code_updateCode.action"
			form0.submit();
		}

	}
</script>

	</head>
	<body>
		<jsp:include page="/form/admin/common/loading.jsp" />
		<div id="j_id1" jsId="j_id1"
			style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
			<script>
	var MForm0 = isc.MatrixForm.create( {
		ID : "MForm0",
		name : "MForm0",
		position : "absolute",
		action : "",
		fields : [ {
			name : 'Form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'Form0_hidden_text_div'
		} ]
	});
</script>
			<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
				action="query/code_addCode.action" style="margin: 0px; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="Form0" value="Form0" />
				<input type="hidden" id="parentNodeId" name="parentNodeId"
					value="${param.parentNodeId}" />
				<!-- add or update -->
				<input type="hidden" id="oType" name="oType" value="${param.oType}" />

				<input type="hidden" id="parentUUID" name="parentUUID"
					value="${codeNode.parentId}" />
				<!-- id 需要和显示值mid处理好 -->
				<input type="hidden" id="id" name="id" value="${codeNode.id}" />
				<input type="hidden" id="uuid" name="uuid" value="${codeNode.uuid}" />
				<input type="hidden" id="type" name="type" value="${codeNode.type}" />
				<input type="hidden" id="order" name="order"
					value="${codeNode.index}" />
				<input type="hidden" id="tenantId" name="tenantId"
					value="${codeNode.tenantId}" />

				<div type="hidden" id="Form0_hidden_text_div"
					name="Form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
				<div id="tabContainer0_div" class="matrixComponentDiv"
					style="width: 100%; height: 100%;; position: relative;">
					<script>
	var MtabContainer0 = isc.TabSet
			.create( {
				ID : "MtabContainer0",
				displayId : "tabContainer0_div",
				height : "100%",
				width : "100%",
				position : "relative",
				align : "center",
				tabBarPosition : "top",
				tabBarAlign : "left",
				showPaneContainerEdges : false,
				showTabPicker : true,
				showTabScroller : true,
				selectedTab : 1,
				tabBarControls : [ isc.MatrixHTMLFlow.create( {
					ID : "MtabContainer0Bar0",
					width : "300px",
					contents : "<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
				}) ],
				tabs : [ {
					title : ("add" == "${param.oType}") ? "添加子目录" : "更新子目录",
					pane : isc.MatrixHTMLFlow
							.create( {
								ID : "MtabContainer0Panel0",
								width : "100%",
								height : "100%",
								overflow : "hidden",
								contents : "<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"
							})
				} ]
			});
	document.getElementById('tabContainer0_div').style.display = 'none';
	MtabContainer0.selectTab(0);
	isc.Page.setEvent("load", "MtabContainer0.selectTab(0);");
</script>
				</div>
				<div id="tabContainer0Bar0_div2" style="text-align: right"
					class="matrixInline"></div>
				<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(
			document.getElementById('tabContainer0Bar0_div2'));
</script>
				<div id="tabContainer0Panel0_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">
					<div style="text-valign: center; position: relative">
						<table id="j_id3" jsId="j_id3" class="maintain_form_content">
							<tr id="j_id9" jsId="j_id9">
								<td id="j_id10" jsId="j_id10" class="maintain_form_label"
									colspan="1" rowspan="1" style="text-align: left; width: '20%'">
									<label id="j_id11" name="j_id11" style="margin-left: 10px">
										名称：
									</label>
								</td>
								<td id="j_id12" jsId="j_id12" class="maintain_form_input"
									colspan="1" rowspan="1">
									<div id="name_div" eventProxy="MForm0"
										class="matrixInline matrixInlineIE" style=""></div>
									<script>
	var name2 = isc.TextItem.create( {
		ID : "Mname",
		name : "name",
		editorType : "TextItem",
		displayId : "name_div",
		position : "relative",
		value : "${codeNode.name}",
		width : 290,
		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return inputNameValidate(item, validator, value, record);
			},
			errorMessage : "名称不能为空!"
		} ]
	});
	MForm0.addField(name2);
</script>
									<span id="MultiLabel1"
										style="width: 19px; height: 20px; color: #FF0000">*</span>
									<span id="nameEchoMessage" style="color: #FF0000">${idEchoMessage}</span>
								</td>
							</tr>

							<tr id="j_id20" jsId="j_id20">
								<td id="j_id21" jsId="j_id21" class="maintain_form_label"
									colspan="1" rowspan="1" style="text-align: left; width: '20%'">
									<label id="j_id22" name="j_id22" style="margin-left: 10px">
										描述：
									</label>
								</td>
								<td id="j_id23" jsId="j_id23" class="maintain_form_input"
									colspan="1" rowspan="1">
									<div id="desc_div" eventProxy="MForm0" class="matrixInline"
										style=""></div>
									<script>
	var desc = isc.TextAreaItem.create( {
		ID : "Mdesc",
		name : "desc",
		editorType : "TextAreaItem",
		displayId : "desc_div",
		position : "relative",
		value : "${codeNode.desc}",
		width : 290,
		height : 100
	});
	MForm0.addField(desc);
</script>
								</td>
							</tr>

							<tr id="j_id27" jsId="j_id27">
								<td id="j_id28" jsId="j_id28" class="maintain_form_command"
									colspan="2" rowspan="1">
									<div id="dataFormSubmitButton_div"
										class="matrixInline matrixInlineIE"
										style="position: relative; width: 100px; height: 22px;">
										<script>
	isc.Button.create( {
		ID : "MdataFormSubmitButton",
		name : "dataFormSubmitButton",
		title : "保存",
		displayId : "dataFormSubmitButton_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		icon : Matrix.getActionIcon("save"),
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	MdataFormSubmitButton.click = function() {
		Matrix.showMask();
		//表单验证
		if (!MForm0.validate()) {
			Matrix.hideMask();
			return false;
		}

		//异步重复验证

		addOrUpdateCodeSubmit();

		Matrix.hideMask();
	};
</script>
									</div>
								</td>
							</tr>
						</table>
					</div>


				</div>
				<script>
	document.getElementById('tabContainer0Panel0_div').appendChild(
			document.getElementById('tabContainer0Panel0_div2'));
	document.getElementById('tabContainer0_div').style.display = '';
</script>
			</form>
			<script>
	MForm0.initComplete = true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
</script>
		</div>

	</body>
</html>