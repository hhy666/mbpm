<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
    <title>编辑表单</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>

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

			var dateType = $('#dateType').val(); //期限类型
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
			var dateType = $("#dateType").val(); //期限类型;//期限类型
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
				document.getElementById('button003_div').style.display = "";
			} else {
				document.getElementById('button003_div').style.display = "none";
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
			var flowOrDoc = Matrix.getFormItemValue('flowOrDoc');
			if (flowOrDoc != 1)
				paramId = "402881e84efc96f1014efc98d6f40001";
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
		//查看表单
		function checkForm() {
			/* var formId = Matrix.getFormItemValue('popupSelectDialog002Val');
			if (formId != null && formId != "") {
				var json = "{'formId':'" + formId + "',";
				json += "'matrix_user_command':'checkFormId'}";
				var url = webContextPath + '/matrix.rform?matrix_send_request=true&matrix_form_tid=' + document.getElementById("matrix_form_tid").value;
				var jsonData = isc.JSON.decode(json);
				Matrix.sendRequest(url, jsonData, function(data) {
					if (data != null && data.data != '') {
						var result = isc.JSON.decode(data.data);
						if (result.result) {
							Matrix.showWindow('Dialog1');
						} else {
							Matrix.warn("该表单没有发布，请联系管理员发布表单！");
							return false;
						}
					}
				});
			} */
			var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
			var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
			var iTop = 0; //获得窗口的垂直位置;
			var iLeft = 0; //获得窗口的水平位置;
			var src="<%=request.getContextPath()%>/form/formInfo_loadFormMainPage.action?nodeUuid=${param.catalogId }&type=1&parentNodeId=4028846f598c539001598c893e10000a_form&processType=2";
			openCtpWindow({'url':src,'title':'编辑表单'});
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
	<input type='hidden' id='validateType' name='validateType' value='jquery' />
	<div id='matrixMask' name='matrixMask' class='matrixMask' style='display:none;'> </div>

	<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;padding:3px;zoom:1" id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/matrix.rform" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<input type="hidden" id="mode" name="mode" value="debug" />
			<input type="hidden" name="is_mobile_request" />
			<input type="hidden" name="mHtml5Flag" value="true" />
			<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
			<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
			<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
			<table id="table001" class="tableLayout" style="width:100%;">
				<tr id="tr001">
					<td id="td001" class="maintain_form_label" style="width:20%;"><label id="label001" name="label001" id="label001" class="control-label ">
模板名称</label></td>
					<td id="td002" class="tdLayout" colspan="3" rowspan="1" style="width:80%;">
						<div id="input001_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:90%; "> <input id="input001" name="input001" maxlength="100" type="text" required class="form-control " style=" width:100%;height:100%;padding-left: 5px;" maxlength="100" minlength="1" autocomplete="off" /> </div>
					</td>
				</tr>
				<tr id="tr002">
					<td id="td005" class="maintain_form_label" style="width:20%;"><label id="label002" name="label002" id="label002" class="control-label ">
表单类型</label></td>
					<td id="td006" class="tdLayout" colspan="3" rowspan="1" style="width:80%;"><span id="radioGroup005_div" class="matrixInline" style="width:390px;"><table border="0" style="margin:0px;padding: 0px;display: inline;width:390px;height:100%;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:97px;"><input type="radio" class="box" id="radioGroup005_0" name="radioGroup005" value="4" checked />&nbsp<label style="color:black;font-weight:normal">普通表单</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:97px;"><input type="radio" class="box" id="radioGroup005_1" name="radioGroup005" value="1" />&nbsp<label style="color:black;font-weight:normal">Word</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:97px;"><input type="radio" class="box" id="radioGroup005_2" name="radioGroup005" value="2" />&nbsp<label style="color:black;font-weight:normal">Excel</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:97px;"><input type="radio" class="box" id="radioGroup005_3" name="radioGroup005" value="3" />&nbsp<label style="color:black;font-weight:normal">富文本编辑器</label></td>
</tr>
</tbody>
</table></span>
					</td>
				</tr>
				<tr id="tr003">
					<td id="td003" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label003" name="label003" id="label003" class="control-label ">
包含表单</label></td>
					<td id="td004" class="tdLayout" colspan="3" style="width:80%"><span id="radioGroup003_div" class="matrixInline" style="width:200px;"><table border="0" style="margin:0px;padding: 0px;display: inline;width:200px;height:100%;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><input type="radio" class="box" id="radioGroup003_0" name="radioGroup003" value="0" />&nbsp<label style="color:black;font-weight:normal">否</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><input type="radio" class="box" id="radioGroup003_1" name="radioGroup003" value="1" checked />&nbsp<label style="color:black;font-weight:normal">是</label></td>
</tr>
</tbody>
</table></span>
					</td>
				</tr>
				<tr id="tr004">
					<td id="td011" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label004" name="label004" id="label004" class="control-label ">
关联表单</label></td>
					<td id="td012" class="tdLayout" colspan="3" rowspan="1" style="width:80%;">
						<table id="table002" class="tableLayout" style="width:100%;">
							<tr id="tr005">
								<td id="td009" class="tdLayout" style="width:80%;border-right:0px">
									<div class="col-md-12 input-group default-width " style="width:80%;"> <input id="popupSelectDialog002" name="popupSelectDialog002" type="text" readonly="readonly " class="form-control has-feedback-right " style=" width:100%;height:100%;" /><span class="input-group-addon addon-udSelect udSelect"><i class="fa fa-search" " aria-hidden="true" ></i></span></div>
									<script>
										function getParamsForpopupSelectDialog002() {
											var params = '&';
											var value;
											value = null;
											try {
												value = eval("getParamId();");
											} catch (error) {
												value = "getParamId();"
											}
											if (value != null) {
												value = "paramId=" + value;
												params += value;
											}
											return params;
										}

										function popupSelectDialog002Open(data) {
											var params = getParamsForpopupSelectDialog002();
											if (data.popupSelectDialog002Var != null && data.popupSelectDialog002Var != 'null') {
												var pageii = layer.open(data.popupSelectDialog002Var);
											} else {
												layer.target = data;
												var pageii = layer.open({
													id: 'popupSelectDialog002',
													type: 2,
													
													title: ['选择表单', 'font-weight:bold', 'font-size: 12px'],
													closeBtn: 1,
													shadeClose: false,
													area: ['45%', '85%'],
													content: '<%=request.getContextPath() %>/SelectForm.rform?mHtml5Flag=true&iframewindowid=popupSelectDialog002' + params
												});
											}
										}

										function onpopupSelectDialog002Close(data) {

											if (data == null) return true;
											if ((typeof data == 'string') && data.constructor == String) data = eval('(' + data + ')');
											if (data['extr2'] != null) {
												Matrix.setFormItemValue('formUuid', data['extr2']);
											} else {
												Matrix.setFormItemValue('formUuid', '');
											}
											if (data['text'] != null) {
												Matrix.setFormItemValue('popupSelectDialog002', data['text']);
											} else {
												Matrix.setFormItemValue('popupSelectDialog002', '');
											}
											if (data['extr2'] != null) {
												Matrix.setFormItemValue('popupSelectDialog002Val', data['extr2']);
											} else {
												Matrix.setFormItemValue('popupSelectDialog002Val', '');
											}
											var result = selectFormCallback();
											if (result != null) return result;
										}
									</script>
								</td>
								<td id="td010" class="tdLayout" style="width:20%;border-left:0px;"><button type="button" id="button003" class="x-btn ok-btn" onclick="checkForm();">查看</button></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr id="tr006">
					<td id="td013" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label005" name="label005" id="label005" class="control-label ">
关联流程</label></td>
					<td id="td014" class="tdLayout" colspan="3" style="width:849px;">
						<div class="col-md-12 input-group default-width " style="width:80%;"> <input id="popupSelectDialog001" name="popupSelectDialog001" type="text" readonly="readonly " class="form-control has-feedback-right " style=" width:100%;height:100%;" /><span class="input-group-addon addon-udSelect udSelect"><i class="fa fa-search" " aria-hidden="true" ></i></span></div>
						<script>
							function getParamsForpopupSelectDialog001() {
								var params = '&';
								var value;
								value = null;
								try {
									value = eval("getParamId();");
								} catch (error) {
									value = "getParamId();"
								}
								if (value != null) {
									value = "paramId=" + value;
									params += value;
								}
								return params;
							}

							function popupSelectDialog001Open(data) {
								var params = getParamsForpopupSelectDialog001();
								if (data.popupSelectDialog001Var != null && data.popupSelectDialog001Var != 'null') {
									var pageii = layer.open(data.popupSelectDialog001Var);
								} else {
									layer.target = data;
									var pageii = layer.open({
										id: 'popupSelectDialog001',
										type: 2,
										
										title: ['选择流程', 'font-weight:bold', 'font-size: 12px'],
										closeBtn: 1,
										shadeClose: false,
										area: ['40%', '80%'],
										content: '<%=request.getContextPath() %>/SelectProcess.rform?mHtml5Flag=true&iframewindowid=popupSelectDialog001' + params
									});
								}
							}

							function onpopupSelectDialog001Close(data) {

								if (data == null) return true;
								if ((typeof data == 'string') && data.constructor == String) data = eval('(' + data + ')');
								if (data['extr2'] != null) {
									Matrix.setFormItemValue('flowUuid', data['extr2']);
								} else {
									Matrix.setFormItemValue('flowUuid', '');
								}
								if (data['text'] != null) {
									Matrix.setFormItemValue('popupSelectDialog001', data['text']);
								} else {
									Matrix.setFormItemValue('popupSelectDialog001', '');
								}
								if (data['extr2'] != null) {
									Matrix.setFormItemValue('popupSelectDialog001Val', data['extr2']);
								} else {
									Matrix.setFormItemValue('popupSelectDialog001Val', '');
								}
							}
						</script>
					</td>
				</tr>
				<tr id="tr007">
					<td id="td007" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label006" name="label006" id="label006" class="control-label ">
支持自由流</label></td>
					<td id="td008" class="tdLayout" colspan="3" style="width:80%;"><span id="radioGroup101_div" class="matrixInline" style="width:200px;height:30px;"><table border="0" style="margin:0px;padding: 0px;display: inline;width:200px;height:30px;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;;height:15px;"><input type="radio" class="box" id="radioGroup101_0" name="radioGroup101" value="1" checked />&nbsp<label style="color:black;font-weight:normal">是</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;;height:15px;"><input type="radio" class="box" id="radioGroup101_1" name="radioGroup101" value="0" />&nbsp<label style="color:black;font-weight:normal">否</label></td>
</tr>
</tbody>
</table></span>
					</td>
				</tr>
				<tr id="tr008">
					<td id="td015" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label007" name="label007" id="label007" class="control-label ">
预归档位置</label></td>
					<td id="td016" class="tdLayout" colspan="3" style="width:849px;">
						<div class="col-md-12 input-group default-width " style="width:80%;"> <input id="popupSelectDialog004" name="popupSelectDialog004" type="text" readonly="readonly " class="form-control has-feedback-right " style=" width:100%;height:100%;" /><span class="input-group-addon addon-udSelect udSelect"><i class="fa fa-search" " aria-hidden="true" ></i></span></div>
						<script>
							function getParamsForpopupSelectDialog004() {
								var params = '&';
								var value;
								return params;
							}

							function popupSelectDialog004Open(data) {
								var params = getParamsForpopupSelectDialog004();
								if (data.popupSelectDialog004Var != null && data.popupSelectDialog004Var != 'null') {
									var pageii = layer.open(data.popupSelectDialog004Var);
								} else {
									layer.target = data;
									var pageii = layer.open({
										id: 'popupSelectDialog004',
										type: 2,
										
										title: ['选择归档位置', 'font-weight:bold', 'font-size: 12px'],
										closeBtn: 1,
										shadeClose: false,
										area: ['80%', '85%'],
										content: '<%=request.getContextPath() %>/SelectArchivePostion.rform?mHtml5Flag=true&iframewindowid=popupSelectDialog004' + params
									});
								}
							}
						</script>
					</td>
				</tr>
				<tr id="tr009">
					<td id="td017" class="maintain_form_label" colspan="1" style="width:20%;"><label id="label008" name="label008" id="label008" class="control-label ">
是否公开</label></td>
					<td id="td014" class="maintain_form_input2" colspan="3" rowspan="1" style="width:80%;"><span id="radioGroup006_div" class="matrixInline" style="width:200px;"><table border="0" style="margin:0px;padding: 0px;display: inline;width:200px;height:100%;" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><input type="radio" class="box" id="radioGroup006_0" name="radioGroup006" value="1" checked />&nbsp<label style="color:black;font-weight:normal">是</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><input type="radio" class="box" id="radioGroup006_1" name="radioGroup006" value="0" />&nbsp<label style="color:black;font-weight:normal">否</label></td>
</tr>
</tbody>
</table></span>
					</td>
				</tr>
				<tr id="tr017">
					<td id="td040" class="maintain_form_label2" colspan="1" style="width:20%;"><label id="label008" name="label008" id="label008" class="control-label ">
授权信息</label></td>
					<td id="td041" colspan="3" rowspan="1" style="width:836px;">
						<div id="inputTextArea002_div" class="col-md-12 input-group " style="width:79%;height:150px; "> <textarea id="inputTextArea002" name="inputTextArea002" " class="form-control " style=" width:100%;height:150px; " readonly="readonly " ></textarea></div><img id="imgButton001 "  name="imgButton001 "  src="matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query.png " width="18 " height="18 "  onclick="openAuthWindow(); "></td>
</tr>
<tr id="tr018 "><td id="td042 " class="maintain_form_label2 " colspan="1 " style="width:20%; "><label id="label022 " name="label022 " id="label022 " class="control-label ">
是否为系统类型</label></td>
<td id="td043 " class="tdLayout " colspan="3 " rowspan="1 " style="width:836px; "><span id="radioGroup001_div " class="matrixInline " style="width:200px; " required="required "><table border="0 " style="margin:0px;padding: 0px;display: inline;width:200px;height:100%; " cellspacing="0 " cellpadding="0 ">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px; "><input type="radio " class="box " id="radioGroup001_0 " name="radioGroup001 " value="1 " />&nbsp<label style="color:black;font-weight:normal ">系统类型</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px; "><input type="radio " class="box " id="radioGroup001_1 " name="radioGroup001 " value="2 " checked required />&nbsp<label style="color:black;font-weight:normal ">应用类型</label></td>
</tr>
</tbody>
</table></span>
</td>
</tr>
<tr id="tr010 "><td id="td018 " class="maintain_form_label " colspan="1 " style="width:20%; "><label id="label010 " name="label010 " id="label010 " class="control-label ">
模板状态</label></td>
<td id="td019 " class="tdLayout " colspan="1 " style="width:30% "><span id="radioGroup002_div " class="matrixInline " style="width:200px; "><table border="0 " style="margin:0px;padding: 0px;display: inline;width:200px;height:100%; " cellspacing="0 " cellpadding="0 ">
<tbody>
<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px; "><input type="radio " class="box " id="radioGroup002_0 " name="radioGroup002 " value="1 " checked />&nbsp<label style="color:black;font-weight:normal ">启用</label></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px; "><input type="radio " class="box " id="radioGroup002_1 " name="radioGroup002 " value="0 " />&nbsp<label style="color:black;font-weight:normal ">停用</label></td>
</tr>
</tbody>
</table></span>
</td>
<td id="td020 " class="maintain_form_label " rowspan="1 " style="width:20%; "><label id="label011 " name="label011 " id="label011 " class="control-label ">
记录历史版本</label></td>
<td id="td021 " class="tdLayout " rowspan="1 " style="width:30% "><div id="comboBox001_div " class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; " > <select class="form-control " id="comboBox001 " name="comboBox001 " tabindex="-1 " style=" width:100%;height:100%; " onchange=" " ><option id="0 " name="0 " value="0 " selected >否</option><option id="1 " name="1 " value="1 ">是</option></select></div> 
<script>
	$(document).ready(function() {
		$("#comboBox001 ").select2({
			placeholder: '',
			minimumResultsForSearch: -1
		});
	});
</script>
</td>
</tr>
<tr id="tr011 "><td id="td022 " class="maintain_form_label " colspan="1 " style="width:20%; "><label id="label012 " name="label012 " id="label012 " class="control-label ">
期限类型</label></td>
<td id="td023 " class="tdLayout " colspan="1 " style="width:318px; "><div id="dateType_div " class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; " > <select class="form-control " id="dateType " name="dateType " tabindex="-1 " style=" width:100%;height:100%; " onchange="setDate(); " ><option></option><option id="1 " name="1 " value="1 ">时</option><option id="2 " name="2 " value="2 ">天</option><option id="3 " name="3 " value="3 ">月</option><option id="4 " name="4 " value="4 ">自定义</option></select></div> 
<script>
	$(document).ready(function() {
		$("#dateType ").select2({
			placeholder: '',
			minimumResultsForSearch: -1,
			allowClear: true
		});
	});
</script>
</td>
<td id="td024 " class="maintain_form_label " colspan="1 " style="width:20%; "><label id="label013 " name="label013 " id="label013 " class="control-label ">
期限值</label><label id="label015 " name="label015 " id="label015 " class="control-label ">
过期时间</label></td>
<td id="td025 " class="tdLayout " colspan="1 " style="width:317px; "><div id="input002_div " class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:200px; "> <input id="input002 " name="input002 " type="text " class="form-control " style=" width:100%;height:100%;padding-left: 5px; " autocomplete="off " /> </div><div id="inputDate001_div " class="date-default-width col-md-12 input-prepend input-group " style="display: inline-table; vertical-align: middle; "><input id='inputDate001' name='inputDate001' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;' onClick="laydate({istime:false, format: 'YYYY年MM月DD日'}) "/><span class="input-group-addon addon-udSelect udSelect " onClick="laydate({elem: '#inputDate001',istime:false, format: 'YYYY年MM月DD日'}) "><i class="fa fa-calendar "></i></span></div><label id="hour " name="hour " id="hour " class="control-label ">
时</label><label id="day " name="day " id="day " class="control-label ">
天</label><label id="month " name="month " id="month " class="control-label ">
月</label></td>
</tr>
<tr id="tr013 "><td id="td030 " class="maintain_form_label " colspan="1 " style="width:20% "><label id="label009 " name="label009 " id="label009 " class="control-label ">
模板描述</label></td>
<td id="td031 " class="tdLayout " colspan="3 " rowspan="1 " style="width:849px; "><div id="inputTextArea001_div " class="col-md-12 input-group " style="width:95%; "> <textarea id="inputTextArea001 " name="inputTextArea001 " " class="form-control " style=" width:100%;height:90px;"></textarea>
						</div>
					</td>
				</tr>
				<tr id="tr014">
					<td id="td027" class="tdLayout" colspan="1" style="width:140px;">&nbsp;</td>
					<td id="td028" class="tdLayout" colspan="3" style="width:705px;">&nbsp;</td>
				</tr>
				<tr id="tr012">
					<td id="td026" class="cmdLayout" colspan="4" rowspan="1" style="width:100%;"><button type="button" id="button001" class="x-btn ok-btn " onclick="button001onclick();"><img src="resource/images/submit.png" style="padding-right: 3px;">保存</button>
						<script>
							function button001onclick() {
								document.getElementById("button001").disabled = true;
								if (!true) {
									document.getElementById("button001").disabled = false;
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
								var _mgr = $('#form0').serialize();
								if (_mgr != null && _mgr == false) {
									return false;
								}
								var result = true;
								result = Matrix.validateForm("form0");
								if (!result) {
									document.getElementById("button001").disabled = false;
									return false;
								} else {
									Matrix.send('form0', {
										'button001': '保存'
									}, function(data) {
										Matrix.update(data);
										parent.Matrix.refreshDataGridData('DataGrid001');
										Matrix.closeWindow();
									});
								}
							}
						</script><button type="button" id="button002" class="x-btn ok-btn " onclick="Matrix.closeWindow();"><img src="resource/images/return.png" style="padding-right: 3px;">取消</button></td>
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
				var Dialog0Var = null;
				Dialog0Var = {
					id: 'Dialog0',
					type: 2,
					
					title: ['授权信息', 'font-weight:bold', 'font-size: 12px'],
					closeBtn: 1,
					shadeClose: false,
					area: ['65%', '90%'],
					content: '<%=request.getContextPath() %>/MixSelect.rform?iframewindowid=Dialog0&mHtml5Flag=true' + getParamsForDialog0()
				};

				function Dialog0Open(data) {
					layer.target = data;
					var params = getParamsForDialog0();
					if (data.Dialog0Var != null && data.Dialog0Var != 'null') {
						var pageii = layer.open(data.Dialog0Var);
					} else {
						var pageii = layer.open({
							id: 'Dialog0',
							type: 2,
							
							title: ['授权信息', 'font-weight:bold', 'font-size: 12px'],
							closeBtn: 1,
							shadeClose: false,
							area: ['65%', '90%'],
							content: '<%=request.getContextPath() %>/MixSelect.rform?iframewindowid=Dialog0&mHtml5Flag=true' + params
						});
					}
				}
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
				var Dialog1Var = null;
				Dialog1Var = {
					id: 'Dialog1',
					type: 2,
					
					title: ['表单信息', 'font-weight:bold', 'font-size: 12px'],
					closeBtn: 1,
					shadeClose: false,
					area: ['80%', '90%'],
					content: '<%=request.getContextPath() %>/TempPreviewPage.rform?iframewindowid=Dialog1&mHtml5Flag=true' + getParamsForDialog1()
				};

				function Dialog1Open(data) {
					layer.target = data;
					var params = getParamsForDialog1();
					if (data.Dialog1Var != null && data.Dialog1Var != 'null') {
						var pageii = layer.open(data.Dialog1Var);
					} else {
						var pageii = layer.open({
							id: 'Dialog1',
							type: 2,
							
							title: ['表单信息', 'font-weight:bold', 'font-size: 12px'],
							closeBtn: 1,
							shadeClose: false,
							area: ['80%', '90%'],
							content: '<%=request.getContextPath() %>/TempPreviewPage.rform?iframewindowid=Dialog1&mHtml5Flag=true' + params
						});
					}
				}
			</script>
			<script>
				function getParamsForSerialNumber0() {
					var params = '&';
					var value;
					return params;
				}
				var SerialNumber0Var = null;

				function SerialNumber0Open(data) {
					layer.target = data;
					var params = getParamsForSerialNumber0();
					if (data.SerialNumber0Var != null && data.SerialNumber0Var != 'null') {
						var pageii = layer.open(data.SerialNumber0Var);
					} else {
						var pageii = layer.open({
							id: 'SerialNumber0',
							type: 2,
							
							title: ['选择公文文号', 'font-weight:bold', 'font-size: 12px'],
							closeBtn: 1,
							shadeClose: false,
							area: ['50%', '50%'],
							content: '<%=request.getContextPath() %>/number/serialNumber_selectSerialNumbers.action?iframewindowid=SerialNumber0&mHtml5Flag=true' + params
						});
					}
				}
			</script>
			<script>
				function getParamsForSerialNumber1() {
					var params = '&';
					var value;
					return params;
				}
				var SerialNumber1Var = null;

				function SerialNumber1Open(data) {
					layer.target = data;
					var params = getParamsForSerialNumber1();
					if (data.SerialNumber1Var != null && data.SerialNumber1Var != 'null') {
						var pageii = layer.open(data.SerialNumber1Var);
					} else {
						var pageii = layer.open({
							id: 'SerialNumber1',
							type: 2,
							
							title: ['选择内部文号', 'font-weight:bold', 'font-size: 12px'],
							closeBtn: 1,
							shadeClose: false,
							area: ['50%', '50%'],
							content: '<%=request.getContextPath() %>/number/serialNumber_selectSerialNumbers.action?iframewindowid=SerialNumber1&mHtml5Flag=true' + params
						});
					}
				}
			</script><input id="tempId" type="hidden" name="tempId" /><input id="tempType" type="hidden" name="tempType" /><input id="tempCls" type="hidden" name="tempCls" /><input id="mBizId" type="hidden" name="mBizId" /><input id="allIds" type="hidden" name="allIds" /><input id="startType" type="hidden" name="startType" /><input id="wordTempId" type="hidden" name="wordTempId" /><input id="vbaTempId" type="hidden" name="vbaTempId" /><input id="flowOrDoc" type="hidden" name="flowOrDoc" /><input id="docType" type="hidden" name="docType" /><input id="position" type="hidden" name="position" /><input id="oldName" type="hidden" name="oldName" /><input id="type" type="hidden" name="type" value="2" /><input id="securityIds" type="hidden" name="securityIds" /><input id="index" type="hidden" name="index" /><input id="popupSelectDialog002Val" type="hidden" name="popupSelectDialog002Val" /><input id="popupSelectDialog001Val" type="hidden" name="popupSelectDialog001Val" />
		</form>
	</div>
	<script>
		$(document).ready(function() {
			setFormStyle();;
		})
	</script>
</body>

</html>