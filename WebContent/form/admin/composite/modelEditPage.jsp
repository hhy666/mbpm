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
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/office.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/html5/js/jquery.min.js"></script>
	<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
	<style>
		.tdLayout {
			border: 1px solid #cccccc;
		}
	</style>
	<script>
		var authUser = null;
		//页面加载初始方法
		function setFormStyle() {
			//默认显示项	
			document.getElementById('tr003').style.display = ''; //包含表单tr
			document.getElementById('tr004').style.display = ''; //关联表单tr

			var formType = document.getElementsByName('radioGroup005'); //表单类型  ： 1 word 2 excel 3 ckeditor 4 普通表单 
			var items = document.getElementsByName('radioGroup003'); //是否包含表单
			if (formType[3].checked || formType[1].checked || formType[2].checked) {
				document.getElementById('tr003').style.display = 'none'; //包含表单tr
				document.getElementById('tr004').style.display = 'none'; //关联表单tr

			} else if (formType[0].checked) {
				document.getElementById('tr003').style.display = ''; //包含表单tr
				document.getElementById('tr004').style.display = ''; //关联表单tr

			}
			var sys = document.getElementsByName('radioGroup001');
			if (formType[0].checked && sys[0].checked) {
				//普通类型+系统类型  不用必填关联流程
				MpopupSelectDialog001.setRequired(false);
			} else {
				MpopupSelectDialog001.setRequired(true);
			}

			var isPublic = document.getElementsByName('radioGroup006'); //是否公开
			if (isPublic[0].checked) {

				document.getElementById('tr017').style.display = 'none'; //授权信息tr
			} else {
				document.getElementById('tr017').style.display = ''; //授权信息tr
			}

			var dateType = MdateType.getValue(); //期限类型
			if (dateType == '4') { //自定义

				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = 'none'; //期限值
				document.getElementById('inputDate001_div').style.display = ''; //自定义日期
				document.getElementById('label015').style.display = ''; //时间
				document.getElementById('label013').style.display = 'none' //值

			} else if (dateType == '1') {
				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = ''; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值

			} else if (dateType == '2') {
				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = ''; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值
			} else if (dateType == '3') {
				document.getElementById('month').style.display = ''; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值
			} else {
				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值
			}

		}
		//是否是系统类型
		function checkFormType() {
			var formType = document.getElementsByName('radioGroup005'); //表单类型  ： 1 word 2 excel 3 ckeditor 4 普通表单 
			if (formType[0].checked) {
				//普通类型+系统类型  不用必填关联流程
				MpopupSelectDialog001.setRequired(false);
			} else {
				MpopupSelectDialog001.setRequired(true);
			}

		}
		//设置是否包含表单
		function setIsContainForm() {
			var formType = document.getElementsByName('radioGroup005'); //表单类型  ： 1 普通表单  2 word  3  excel  4 ckeditor
			if (formType[3].checked || formType[1].checked || formType[2].checked) {
				document.getElementById('tr003').style.display = 'none'; //包含表单tr
				document.getElementById('tr004').style.display = 'none'; //关联表单tr
			} else if (formType[0].checked) {
				document.getElementById('tr003').style.display = ''; //包含表单tr
				document.getElementById('tr004').style.display = ''; //关联表单tr
				containForm();

				var sys = document.getElementsByName('radioGroup001');
				if (sys[0].checked) {
					//普通类型+系统类型  不用必填关联流程
					MpopupSelectDialog001.setRequired(false);
				} else {
					MpopupSelectDialog001.setRequired(true);
				}
			}
		}
		//是否包含表单onchange
		function containForm() {
			var items = document.getElementsByName('radioGroup003');
			if (items[1].checked) { //包含表单
				//显示关联表单
				document.getElementById('tr004').style.display = "";

			} else {
				document.getElementById('tr004').style.display = "none";
			}
		}

		//授权信息弹出框关闭回调
		function onDialog0Close(data) {
			if (data != null) {
				var allIds = data.allIds;
				var allNames = data.allNames;
				Matrix.setFormItemValue('securityIds', allIds);
				Matrix.setFormItemValue('inputTextArea002', allNames);

			} else {
				Matrix.setFormItemValue('securityIds', "");
				Matrix.setFormItemValue('inputTextArea002', "");
			}

		}

		//onchang事件
		function setDate() {
			var dateType = MdateType.getValue(); //期限类型;//期限类型
			if (dateType == '4') { //自定义

				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = 'none'; //期限值
				document.getElementById('inputDate001_div').style.display = ''; //自定义日期
				document.getElementById('label015').style.display = ''; //时间
				document.getElementById('label013').style.display = 'none' //值

			} else if (dateType == '1') {
				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = ''; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值

			} else if (dateType == '2') {
				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = ''; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值		
			} else if (dateType == '3') {
				document.getElementById('month').style.display = ''; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值
			} else {
				document.getElementById('month').style.display = 'none'; //月
				document.getElementById('day').style.display = 'none'; //天
				document.getElementById('hour').style.display = 'none'; //时
				document.getElementById('input002_div').style.display = ''; //期限值
				document.getElementById('inputDate001_div').style.display = 'none'; //自定义日期
				document.getElementById('label015').style.display = 'none'; //时间
				document.getElementById('label013').style.display = '' //值
			}


		}

		//选择表单回调
		function selectFormCallback() {

			var formValue = Matrix.getFormItemValue('popupSelectDialog002');
			if (formValue != null && formValue != '' && formValue.length > 0) {
				Matrix.setFormItemValue('containForm', '1'); //选择了表单  
				//显示查看按钮
			//	document.getElementById('button003_div').style.display = "";
			} else {
			//	document.getElementById('button003_div').style.display = "none";
			}

		}
		//选择预归档位置回调
		function onpopupSelectDialog004DialogClose(data) {
			if (data != null) {
				var uuid = data.uuid;
				var name = data.name;
				Matrix.setFormItemValue('popupSelectDialog004', name);
				Matrix.setFormItemValue('position', uuid);
			}
		}

		function setSecurityEnable() {
			var isPublic = document.getElementsByName('radioGroup006'); //是否公开
			if (isPublic[0].checked) {

				document.getElementById('tr017').style.display = 'none'; //授权信息tr
			} else {
				document.getElementById('tr017').style.display = ''; //授权信息tr
				MinputTextArea002.redraw();
			}
		}

		function getParamId() {
			var paramId = "402881e84efc96f1014efc9912e20002";
		//	var flowOrDoc = Matrix.getFormItemValue('flowOrDoc');
		//	if (flowOrDoc != 1)
		//		paramId = "402881e84efc96f1014efc98d6f40001";
			return paramId;
		}

		function checkTemplateName() {
			var s = Matrix.getFormItemValue('input001');
			var pattern = /^[a-zA-Z0-9_()（）\u4e00-\u9fa5\-]+$/;
			if (pattern.test(s)) {
				return true;
			} else {
				return false;
			}
		}
		//编辑表单
		function checkForm() {
			var formId = Matrix.getFormItemValue('popupSelectDialog002Val');
			if (formId != null && formId != "") {
				var json = "{'formId':'" + formId + "',";
				json += "'matrix_user_command':'checkFormId'}";
				var url = webContextPath + '/matrix.rform?matrix_send_request=true&matrix_form_tid=' + document.getElementById("matrix_form_tid").value;
				var jsonData = isc.JSON.decode(json);
				Matrix.sendRequest(url, jsonData, function(data) {
					if (data != null && data.data != '') {
						var result = isc.JSON.decode(data.data);
						if (result.result) {
							var field = document.getElementById('entityId').value;
							var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
							var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
							var iTop = 0; //获得窗口的垂直位置;
							var iLeft = 0; //获得窗口的水平位置;
							var src="<%=request.getContextPath() %>/form/formInfo_loadFormMainPage.action?nodeUuid="+field+"&type=1&processType=2&isComposite=1";
							openCtpWindow({'url':src,'title':'编辑表单'});
						} else {
							Matrix.warn("该表单没有发布，请联系管理员发布表单！");
							return false;
						}
					}
				});
			}else{
				Matrix.warn("请选择表单！");
				return false;
			} 
			<%-- var field = document.getElementById('entityId').value;
			var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
			var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
			var iTop = 0; //获得窗口的垂直位置;
			var iLeft = 0; //获得窗口的水平位置;
			var src="<%=request.getContextPath() %>/form/formInfo_loadFormMainPage.action?nodeUuid="+field+"&type=1&processType=2";
			openCtpWindow({'url':src,'title':'编辑表单'}); --%>
		}
		
		//编辑流程
		function checkFormFlow() {
			var formId = Matrix.getFormItemValue('popupSelectDialog001Val');
			if (formId != null && formId != "") {
				 var json = "{'formId':'" + formId + "',";
				json += "'matrix_user_command':'checkFormId'}";
				var url = webContextPath + '/matrix.rform?matrix_send_request=true&matrix_form_tid=' + document.getElementById("matrix_form_tid").value;
				var jsonData = isc.JSON.decode(json);
				Matrix.sendRequest(url, jsonData, function(data) {
					if (data != null && data.data != '') {
						var result = isc.JSON.decode(data.data);
						if (result.result) {
							var field = document.getElementById('entityId').value;
							var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
							var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
							var iTop = 0; //获得窗口的垂直位置;
							var iLeft = 0; //获得窗口的水平位置;
							var src="<%=request.getContextPath() %>/editor/flowdesigner.jsp?pdid="+formId+"&ptid=9f1b1468-f935-4f3a-97bc-54fdf6180f0a&containerType=process&containerId="+formId+"&mode=flow&initFlag=true&processType=2";
							openCtpWindow({'url':src,'title':'编辑表单'});
						 } else {
							Matrix.warn("该表单没有发布，请联系管理员发布表单！");
							return false;
						}
					}
				}); 
			}else{
				Matrix.warn("请选择流程！");
				return false;
			} 
		}

		function openAuthWindow() {
			var areaIds = Matrix.getFormItemValue('securityIds');
			var areaName = Matrix.getFormItemValue('inputTextArea002');
			if (areaIds != null && areaIds != "" && areaIds != "null") {
				parent.authUser = {};
				parent.authUser.areaName = areaName
				parent.authUser.areaIds = areaIds;
			}
			Matrix.showWindow('Dialog0');
		}
	</script>
</head>

<body>
	<div id='matrixMask' name='matrixMask' class='matrixMask' style='display:none;'> </div>
	<div id='loading' name='loading' class='loading'>
		<script>
			Matrix.showLoading();
		</script>
	</div>
	<script>
		isc.Page.setEvent(isc.EH.LOAD, "setFormStyle();", isc.Page.FIRE_ONCE);
	</script>
	<script>
		var Mform0 = isc.MatrixForm.create({
			ID: "Mform0",
			name: "Mform0",
			position: "absolute",
			action: "<%=request.getContextPath() %>/matrix.rform",
			canSelectText: true,
			fields: [{
				name: 'form0_hidden_text',
				width: 0,
				height: 0,
				displayId: 'form0_hidden_text_div'
			}]
		});
	</script>
	<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;padding:3px;zoom:1" id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/matrix.rform" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<input type="hidden" name="is_mobile_request" />
			<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" value="3b54d7d8-07c3-45f5-8245-d6959fa2075c" />
			<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
			<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
			<table id="table001" class="tableLayout" style="width:100%;">
				<tr id="tr001">
					<td id="td001" class="maintain_form_label" style="width:20%;"><label id="label001" name="label001" id="label001" style="white-space:nowrap;">
模板名称</label></td>
					<td id="td002" class="tdLayout" colspan="3" rowspan="1" style="width:80%;">
						<div id="input001_div" eventProxy="Mform0" class="matrixInline" style="width:80%;"></div>
						<script>
							var input001 = isc.TextItem.create({
								ID: "Minput001",
								name: "input001",
								editorType: "TextItem",
								displayId: "input001_div",
								position: "relative",
								autoDraw: false,
								textBoxStyle: "textItem required ",
								width: "100%",
								length: 100,
								validators: [{
									type: "custom",
									condition: function(item, validator, value, record) {
										return Matrix.validateLength(1, 100, value);
									},
									errorMessage: "模板名称不能为空且不能多于100个字符！"
								}, {
									type: "custom",
									condition: function(item, validator, value, record) {
										return checkTemplateName(item, validator, value, record);
									},
									errorMessage: "模板名称必须为：中文、英文字母、数字、'-'和'_'"
								}],
								required: true
							});
							Mform0.addField(input001);
						</script>
					</td>
				</tr>
				<tr id="tr002">
					<td id="td005" class="maintain_form_label" style="width:20%;"><label id="label002" name="label002" id="label002" style="white-space:nowrap;">
流程实例名称</label></td>
					<td id="td006" class="tdLayout" colspan="3" rowspan="1" style="width:80%;">
						<div id="input0012_div" eventProxy="Mform0" class="matrixInline" style="width:80%;"></div>
						<script>
							var input0012 = isc.TextItem.create({
								ID: "Minput0012",
								name: "input0012",
								editorType: "TextItem",
								displayId: "input0012_div",
								position: "relative",
								autoDraw: false,
								textBoxStyle: "textItem required ",
								width: "100%",
								length: 100,
								validators: [{
									type: "custom",
									condition: function(item, validator, value, record) {
										return Matrix.validateLength(1, 100, value);
									},
									errorMessage: "流程实例名称不能为空且不能多于100个字符！"
								}, {
									type: "custom",
									condition: function(item, validator, value, record) {
										return checkTemplateName(item, validator, value, record);
									},
									errorMessage: "流程实例名称必须为：中文、英文字母、数字、'-'和'_'"
								}],
								required: true
							});
							Mform0.addField(input0012);
						</script>
					</td>
				</tr>
				<tr id="tr007">
					<td id="td007" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label006" name="label006" id="label006" style="white-space:nowrap;">
支持自由流</label></td>
					<td id="td008" class="tdLayout" colspan="3" style="width:80%;"><span id="radioGroup101_div" class="matrixInline" style="width:200px;height:30px;"><table border="0" style="margin:0px;padding: 0px;display: inline;width:200px;height:30px;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;;height:15px;"><div id="radioGroup101_0_div" eventProxy="Mform0"></div><script> var radioGroup101_0=isc.RadioItem.create({ID:"MradioGroup101_0",name:"radioGroup101",editorType:"RadioItem",displayId:"radioGroup101_0_div",value:"1",title:"是",position:"relative",groupId:"radioGroup101",disabled:false,autoDraw:false});Mform0.addField(radioGroup101_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;;height:15px;"><div id="radioGroup101_1_div" eventProxy="Mform0"></div><script> var radioGroup101_1=isc.RadioItem.create({ID:"MradioGroup101_1",name:"radioGroup101",editorType:"RadioItem",displayId:"radioGroup101_1_div",value:"0",title:"否",position:"relative",groupId:"radioGroup101",disabled:false,autoDraw:false});Mform0.addField(radioGroup101_1);Mform0.setValue("radioGroup101","1");</script></td>
</tr>
</tbody>
</table></span>
					</td>
				</tr>
				<tr id="tr008">
					<td id="td015" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label007" name="label007" id="label007" style="white-space:nowrap;">
预归档位置</label></td>
					<td id="td016" class="tdLayout" colspan="3" style="width:849px;">
						<table id='popupSelectDialog004_table' style='width:80%;height:22px;table-layout:fixed;border-collapse:collapse;border-spacing:0;padding:0;margin:0;'>
							<tr>
								<td style='padding:0;'>
									<div id="popupSelectDialog004_div" style='width:100%;height:100%' eventProxy="Mform0"></div>
								</td>
								<td style='width:20px;height:100%;text-align:center;padding:0;'>
									<div id='popupSelectDialog004_button_div' style='position:relative;width:100%;height:100%;vertical-align:middle;' class='matrixInline'><img id='popupSelectDialog004_button' src='<%=request.getContextPath() %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query_advance.png' onclick='onpopupSelectDialog004Click();' /></div>
								</td>
							</tr>
						</table>
						<script>
							function onpopupSelectDialog004Click() {

								Matrix.showMask();

								var x = eval("Matrix.showWindow('popupSelectDialog004Dialog');");
								if (x != null && x == false) {
									Matrix.hideMask();
									return false;
								}
								Matrix.hideMask();
							};
						</script>
						<script>
							var popupSelectDialog004 = isc.TextItem.create({
								ID: "MpopupSelectDialog004",
								name: "popupSelectDialog004",
								editorType: "TextItem",
								displayId: "popupSelectDialog004_div",
								width: "100%",
								position: "relative",
								autoDraw: false,
								canEdit: false
							});
							Mform0.addField(popupSelectDialog004);
						</script>
						<script>
							function getParamsForpopupSelectDialog004Dialog() {
								var params = '&';
								var value;
								return params;
							}
							isc.Window.create({
								ID: "MpopupSelectDialog004Dialog",
								id: "popupSelectDialog004Dialog",
								name: "popupSelectDialog004Dialog",
								position: "absolute",
								height: "85%",
								width: "80%",
								title: "选择归档位置",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon: false,
								showTitle: true,
								showMinimizeButton: false,
								showMaximizeButton: false,
								showCloseButton: true,
								showModalMask: false,
								isModal: true,
								autoDraw: false,
								getParamsFun: getParamsForpopupSelectDialog004Dialog,
								initSrc: "<%=request.getContextPath() %>/SelectArchivePostion.rform",
								src: "<%=request.getContextPath() %>/SelectArchivePostion.rform"
							});
						</script>
					</td>
				</tr>
				<tr id="tr009">
					<td id="td017" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label008" name="label008" id="label008" style="white-space:nowrap;">
是否公开</label></td>
					<td id="td014" class="maintain_form_input2" colspan="3" rowspan="1" style="width:80%;"><span id="radioGroup006_div" class="matrixInline" style="width:200px;"><table border="0" style="margin:0px;padding: 0px;display: inline;width:200px;height:100%;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="radioGroup006_0_div" eventProxy="Mform0"></div><script> var radioGroup006_0=isc.RadioItem.create({ID:"MradioGroup006_0",name:"radioGroup006",editorType:"RadioItem",displayId:"radioGroup006_0_div",value:"1",title:"是",position:"relative",groupId:"radioGroup006",disabled:false,autoDraw:false,changed:"setSecurityEnable();",changed:"setSecurityEnable();"});Mform0.addField(radioGroup006_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="radioGroup006_1_div" eventProxy="Mform0"></div><script> var radioGroup006_1=isc.RadioItem.create({ID:"MradioGroup006_1",name:"radioGroup006",editorType:"RadioItem",displayId:"radioGroup006_1_div",value:"0",title:"否",position:"relative",groupId:"radioGroup006",disabled:false,autoDraw:false,changed:"setSecurityEnable();",changed:"setSecurityEnable();"});Mform0.addField(radioGroup006_1);Mform0.setValue("radioGroup006","1");</script></td>
</tr>
</tbody>
</table></span>
					</td>
				</tr>
				<tr id="tr017">
					<td id="td040" class="maintain_form_label2" colspan="1" style="width:20%;"><label id="label008" name="label008" id="label008" style="white-space:nowrap;">
授权信息</label></td>
					<td id="td041" colspan="3" rowspan="1" style="width:836px;">
						<div id="inputTextArea002_div" eventProxy="Mform0" class="matrixInline" style="width:79%;"></div>
						<script>
							var inputTextArea002 = isc.TextAreaItem.create({
								ID: "MinputTextArea002",
								name: "inputTextArea002",
								editorType: "TextAreaItem",
								displayId: "inputTextArea002_div",
								position: "relative",
								autoDraw: false,
								width: '79%',
								height: 150
							});
							Mform0.addField(inputTextArea002);
							MinputTextArea002.setCanEdit(false);
						</script>
						<script>
							isc.ImgButton.create({
								ID: "MimgButton001",
								name: "imgButton001",
								showDisabled: false,
								showDisabledIcon: false,
								showDown: false,
								showDownIcon: false,
								showRollOver: false,
								showRollOverIcon: false,
								position: "relative",
								width: 18,
								height: 18,
								src: "[skin]/images/matrix/actions/query.png"
							});
							var imgButton001_flag = false;
							MimgButton001.click = function() {
								Matrix.showMask();
								var x = eval("openAuthWindow();");
								if (x != null && x == false) {
									Matrix.hideMask();
									return false;
								}
							}
						</script>
					</td>
				</tr>
				<tr id="tr018">
					<td id="td042" class="maintain_form_label2" colspan="1" style="width:20%;"><label id="label022" name="label022" id="label022" style="white-space:nowrap;">
是否为系统类型</label></td>
					<td id="td043" class="tdLayout" colspan="3" rowspan="1" style="width:836px;"><span id="radioGroup001_div" class="matrixInline" style="width:200px;" required="required"><table border="0" style="margin:0px;padding: 0px;display: inline;width:200px;height:100%;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="radioGroup001_0_div" eventProxy="Mform0"></div><script> var radioGroup001_0=isc.RadioItem.create({ID:"MradioGroup001_0",name:"radioGroup001",editorType:"RadioItem",displayId:"radioGroup001_0_div",value:"1",title:"系统类型",position:"relative",groupId:"radioGroup001",disabled:false,autoDraw:false,click:"checkFormType();",click:"checkFormType();"});Mform0.addField(radioGroup001_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="radioGroup001_1_div" eventProxy="Mform0"></div><script> var radioGroup001_1=isc.RadioItem.create({ID:"MradioGroup001_1",name:"radioGroup001",editorType:"RadioItem",displayId:"radioGroup001_1_div",value:"2",title:"应用类型",position:"relative",groupId:"radioGroup001",disabled:false,autoDraw:false,click:"checkFormType();",validators:[{type:"custom",condition:function(item, validator, value, record){return Matrix.validateGroupRequired(item, validator, value, record);},errorMessage:isc.FormItem.getPrototype().requiredFieldMessage}],click:"checkFormType();"});Mform0.addField(radioGroup001_1);Mform0.setValue("radioGroup001","2");</script></td>
</tr>
</tbody>
</table></span>
					</td>
				</tr>
				<tr id="tr010">
					<td id="td018" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label010" name="label010" id="label010" style="white-space:nowrap;">
模板状态</label></td>
					<td id="td019" class="tdLayout" colspan="1" style="width:30%"><span id="radioGroup002_div" class="matrixInline" style="width:200px;"><table border="0" style="margin:0px;padding: 0px;display: inline;width:200px;height:100%;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="radioGroup002_0_div" eventProxy="Mform0"></div><script> var radioGroup002_0=isc.RadioItem.create({ID:"MradioGroup002_0",name:"radioGroup002",editorType:"RadioItem",displayId:"radioGroup002_0_div",value:"1",title:"启用",position:"relative",groupId:"radioGroup002",disabled:false,autoDraw:false});Mform0.addField(radioGroup002_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="radioGroup002_1_div" eventProxy="Mform0"></div><script> var radioGroup002_1=isc.RadioItem.create({ID:"MradioGroup002_1",name:"radioGroup002",editorType:"RadioItem",displayId:"radioGroup002_1_div",value:"0",title:"停用",position:"relative",groupId:"radioGroup002",disabled:false,autoDraw:false});Mform0.addField(radioGroup002_1);Mform0.setValue("radioGroup002","1");</script></td>
</tr>
</tbody>
</table></span>
					</td>
					<td id="td020" class="maintain_form_label" rowspan="1" style="width:20%;"><label id="label011" name="label011" id="label011" style="white-space:nowrap;">
记录历史版本</label></td>
					<td id="td021" class="tdLayout" rowspan="1" style="width:30%">
						<div id="comboBox001_div" eventProxy="Mform0" class="matrixInline" style="width:100%;"></div>
						<script>
							var McomboBox001_VM = [];
							var comboBox001 = isc.SelectItem.create({
								ID: "McomboBox001",
								name: "comboBox001",
								editorType: "SelectItem",
								displayId: "comboBox001_div",
								autoDraw: false,
								valueMap: [],
								value: "0",
								position: "relative"
							});
							Mform0.addField(comboBox001);
							McomboBox001_VM = ['0', '1'];
							McomboBox001.displayValueMap = {
								'0': '否',
								'1': '是'
							};
							McomboBox001.setValueMap(McomboBox001_VM);
							McomboBox001.setValue('0');
						</script>
					</td>
				</tr>
				<tr id="tr011">
					<td id="td022" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label012" name="label012" id="label012" style="white-space:nowrap;">
期限类型</label></td>
					<td id="td023" class="tdLayout" colspan="1" style="width:318px;">
						<div id="dateType_div" eventProxy="Mform0" class="matrixInline" style="width:100%;"></div>
						<script>
							var MdateType_VM = [];
							var dateType = isc.SelectItem.create({
								ID: "MdateType",
								name: "dateType",
								editorType: "SelectItem",
								displayId: "dateType_div",
								autoDraw: false,
								valueMap: [],
								position: "relative",
								changed: "setDate();"
							});
							Mform0.addField(dateType);
							MdateType_VM = ['', '1', '2', '3', '4'];
							MdateType.displayValueMap = {
								'': '',
								'1': '时',
								'2': '天',
								'3': '月',
								'4': '自定义'
							};
							MdateType.setValueMap(MdateType_VM);
							MdateType.setValue(null);
						</script>
					</td>
					<td id="td024" class="maintain_form_label" colspan="1" style="width:20%; "><label id="label013" name="label013" id="label013" style="white-space:nowrap;">
期限值</label><label id="label015" name="label015" id="label015" style="white-space:nowrap;">
过期时间</label></td>
					<td id="td025" class="tdLayout" colspan="1" style="width:317px;">
						<div id="input002_div" eventProxy="Mform0" class="matrixInline" style=""></div>
						<script>
							var input002 = isc.TextItem.create({
								ID: "Minput002",
								name: "input002",
								editorType: "TextItem",
								displayId: "input002_div",
								position: "relative",
								autoDraw: false,
								width: 200
							});
							Mform0.addField(input002);
						</script>
						<div id="inputDate001_div" eventProxy="Mform0" class="matrixInline" style="width:100%;"></div>
						<script>
							var MinputDate001_value = null;
							var inputDate001 = isc.DateItem.create({
								ID: "MinputDate001",
								name: "inputDate001",
								value: MinputDate001_value,
								type: "date",
								displayId: "inputDate001_div",
								paseDateFun: function(value, formatPattern) {
									return Matrix.parseDate(value, formatPattern);
								},
								dateFormatter: function(_1) {
									return Matrix.formatDate(this, MinputDate001.formatPattern);
								},
								formatPattern: "yyyy年MM月dd日",
								autoDraw: false,
								useTextField: true,
								enforceDate: true,
								position: "relative",
								validators: [{
									type: "custom",
									condition: function(item, validator, value, record) {
										return item.validateDateValue(value);
									},
									errorMessage: isc.DateItem.getPrototype().invalidDateStringMessage
								}],
								startDate: new Date(1900, 0, 1),
								endDate: new Date(2050, 0, 1)
							});
							Mform0.addField(inputDate001);
						</script><label id="hour" name="hour" id="hour" style="white-space:nowrap;">
时</label><label id="day" name="day" id="day" style="white-space:nowrap;">
天</label><label id="month" name="month" id="month" style="white-space:nowrap;">
月</label></td>
				</tr>
				<tr id="tr013">
					<td id="td030" class="maintain_form_label" colspan="1" style="width:20%"><label id="label009" name="label009" id="label009" style="white-space:nowrap;">
模板描述</label></td>
					<td id="td031" class="tdLayout" colspan="3" rowspan="1" style="width:849px;">
						<div id="inputTextArea001_div" eventProxy="Mform0" class="matrixInline" style="width:95%;"></div>
						<script>
							var inputTextArea001 = isc.TextAreaItem.create({
								ID: "MinputTextArea001",
								name: "inputTextArea001",
								editorType: "TextAreaItem",
								displayId: "inputTextArea001_div",
								position: "relative",
								autoDraw: false,
								width: '95%'
							});
							Mform0.addField(inputTextArea001);
						</script>
					</td>
				</tr>
				<tr id="tr014">
					<td id="td027" class="tdLayout" colspan="1" style="width:140px;border:0;">&nbsp;</td>
					<td id="td028" class="tdLayout" colspan="3" style="width:705px;border:0;">&nbsp;</td>
				</tr>
				<tr id="tr012">
					<td id="td026" class="cmdLayout" colspan="4" rowspan="1" style="width:100%;">
						<div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
							<script>
								isc.Button.create({
									ID: "Mbutton001",
									name: "button001",
									title: "保存",
									displayId: "button001_div",
									position: "absolute",
									top: 0,
									left: 0,
									width: "100%",
									height: "100%",
									showDisabledIcon: false,
									showDownIcon: false,
									showRollOverIcon: false
								});
								Mbutton001.click = function() {
									Mbutton001.disable();
									Matrix.showMask();
									if (!true) {
										Matrix.hideMask();
										Mbutton001.enable();
										return false;
									}
									if (!Mform0.validate()) {
										Matrix.hideMask();
										Mbutton001.enable();
										return false;
									}
									var vituralbuttonHidden = document.getElementById('matrix_command_id');
									if (vituralbuttonHidden) vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
									var currentForm = document.getElementById('form0');
									var buttonHidden = document.createElement('input');
									buttonHidden.type = 'hidden';
									buttonHidden.name = 'matrix_command_id';
									buttonHidden.id = 'matrix_command_id';
									buttonHidden.value = 'button001';
									currentForm.appendChild(buttonHidden);
									var _mgr = Matrix.convertDataGridDataOfForm('form0');
									if (_mgr != null && _mgr == false) {
										Matrix.hideMask();
										return false;
									}
									Matrix.send('form0', {
										'button001': '保存'
									}, function(data) {
										Matrix.update(data);
										parent.Matrix.refreshDataGridData('DataGrid001');
										Matrix.closeWindow();
									});
									Matrix.hideMask();
								};
							</script>
						</div>
						<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
							<script>
								isc.Button.create({
									ID: "Mbutton002",
									name: "button002",
									title: "取消",
									displayId: "button002_div",
									position: "absolute",
									top: 0,
									left: 0,
									width: "100%",
									height: "100%",
									showDisabledIcon: false,
									showDownIcon: false,
									showRollOverIcon: false
								});
								Mbutton002.click = function() {
									var x = eval("Matrix.closeWindow();");
									if (x != null && x == false) {
										Matrix.hideMask();
										Mbutton002.enable();
										return false;
									}
								};
							</script>
						</div>
					</td>
				</tr>
			</table>
			<script>
				function getParamsForDialog0() {
					var params = '&';
					var value;
					value = null;
					try {
						value = eval("update");
					} catch (error) {
						value = "update"
					}
					if (value != null) {
						value = "add=" + value;
						params += value;
					}
					return params;
				}
				isc.Window.create({
					ID: "MDialog0",
					id: "Dialog0",
					name: "Dialog0",
					autoCenter: true,
					position: "absolute",
					height: "90%",
					width: "65%",
					title: "授权信息",
					canDragReposition: false,
					targetDialog: "Security",
					showMinimizeButton: true,
					showMaximizeButton: false,
					showCloseButton: true,
					showModalMask: false,
					modalMaskOpacity: 0,
					isModal: true,
					autoDraw: false,
					headerControls: ["headerIcon", "headerLabel", "closeButton"],
					getParamsFun: getParamsForDialog0,
					initSrc: "<%=request.getContextPath() %>/MixSelect.rform",
					src: "<%=request.getContextPath() %>/MixSelect.rform",
					showFooter: false
				});
			</script>
			<script>
				MDialog0.hide();
			</script>
			<script>
				function getParamsForDialog1() {
					var params = '&';
					var value;
					value = null;
					try {
						value = eval("Matrix.getFormItemValue('formUuid')");
					} catch (error) {
						value = "Matrix.getFormItemValue('formUuid')"
					}
					if (value != null) {
						value = "mBizId=" + value;
						params += value;
					}
					value = null;
					params += '&';
					try {
						value = eval("Matrix.getFormItemValue('popupSelectDialog002Val')");
					} catch (error) {
						value = "Matrix.getFormItemValue('popupSelectDialog002Val')"
					}
					if (value != null) {
						value = "formDid=" + value;
						params += value;
					}
					value = null;
					params += '&';
					try {
						value = eval("Matrix.getFormItemValue('popupSelectDialog001Val')");
					} catch (error) {
						value = "Matrix.getFormItemValue('popupSelectDialog001Val')"
					}
					if (value != null) {
						value = "flowDid=" + value;
						params += value;
					}
					value = null;
					params += '&';
					try {
						value = eval("true");
					} catch (error) {
						value = "true"
					}
					if (value != null) {
						value = "matrix_view_flag=" + value;
						params += value;
					}
					return params;
				}
				isc.Window.create({
					ID: "MDialog1",
					id: "Dialog1",
					name: "Dialog1",
					autoCenter: true,
					position: "absolute",
					height: "90%",
					width: "80%",
					title: "表单信息",
					canDragReposition: false,
					targetDialog: "mainDialog",
					showMinimizeButton: true,
					showMaximizeButton: true,
					showCloseButton: true,
					showModalMask: false,
					modalMaskOpacity: 0,
					isModal: true,
					autoDraw: false,
					headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
					getParamsFun: getParamsForDialog1,
					initSrc: "<%=request.getContextPath() %>/TempPreviewPage.rform",
					src: "<%=request.getContextPath() %>/TempPreviewPage.rform",
					showFooter: false
				});
			</script>
			<script>
				MDialog1.hide();
			</script>
			<script>
				function getParamsForSerialNumber0() {
					var params = '&';
					var value;
					return params;
				}
				isc.Window.create({
					ID: "MSerialNumber0",
					id: "SerialNumber0",
					name: "SerialNumber0",
					autoCenter: true,
					position: "absolute",
					height: "50%",
					width: "50%",
					title: "选择公文文号",
					canDragReposition: false,
					showMinimizeButton: true,
					showMaximizeButton: false,
					showCloseButton: true,
					showModalMask: false,
					modalMaskOpacity: 0,
					isModal: true,
					autoDraw: false,
					headerControls: ["headerIcon", "headerLabel", "closeButton"],
					getParamsFun: getParamsForSerialNumber0,
					initSrc: "<%=request.getContextPath() %>/number/serialNumber_selectSerialNumbers.action",
					src: "<%=request.getContextPath() %>/number/serialNumber_selectSerialNumbers.action",
					showFooter: false
				});
			</script>
			<script>
				MSerialNumber0.hide();
			</script>
			<script>
				function getParamsForSerialNumber1() {
					var params = '&';
					var value;
					return params;
				}
				isc.Window.create({
					ID: "MSerialNumber1",
					id: "SerialNumber1",
					name: "SerialNumber1",
					autoCenter: true,
					position: "absolute",
					height: "50%",
					width: "50%",
					title: "选择内部文号",
					canDragReposition: false,
					showMinimizeButton: true,
					showMaximizeButton: false,
					showCloseButton: true,
					showModalMask: false,
					modalMaskOpacity: 0,
					isModal: true,
					autoDraw: false,
					headerControls: ["headerIcon", "headerLabel", "closeButton"],
					getParamsFun: getParamsForSerialNumber1,
					initSrc: "<%=request.getContextPath() %>/number/serialNumber_selectSerialNumbers.action",
					src: "<%=request.getContextPath() %>/number/serialNumber_selectSerialNumbers.action",
					showFooter: false
				});
			</script>
			<script>
				MSerialNumber1.hide();
			</script><input id="tempId" type="hidden" name="tempId" /><input id="tempType" type="hidden" name="tempType" /><input id="tempCls" type="hidden" name="tempCls" /><input id="mBizId" type="hidden" name="mBizId" /><input id="allIds" type="hidden" name="allIds" /><input id="startType" type="hidden" name="startType" /><input id="wordTempId" type="hidden" name="wordTempId" /><input id="vbaTempId" type="hidden" name="vbaTempId" /><input id="flowOrDoc" type="hidden" name="flowOrDoc" /><input id="docType" type="hidden" name="docType" /><input id="position" type="hidden" name="position" /><input id="oldName" type="hidden" name="oldName" /><input id="type" type="hidden" name="type" value="2" /><input id="securityIds" type="hidden" name="securityIds" /><input id="index" type="hidden" name="index" /><input id="popupSelectDialog002Val" type="hidden" name="popupSelectDialog002Val" /><input id="popupSelectDialog001Val" type="hidden" name="popupSelectDialog001Val" />
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