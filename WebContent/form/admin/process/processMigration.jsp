<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>

<script type="text/javascript">
	var temp = 0;
	function checkNull(){
		for(var i=1;i<=temp;i++){
			var id = "oldId"+i;
			var data = document.getElementById(id).value;
			if(data==null||data!=undefined||data!=""){
				alert("选项不能为空！");
				return false;
			}
		}
		
	}	
		/* var temp1 = document.getElementById("comboBox001").value;
		var temp2 = document.getElementById("comboBox002").value;
		var temp3 = document.getElementById("comboBox003").value;
		if(temp1!=null&&temp1!=undefined&&temp1!=""){
			if(temp2!=null&&temp2!=undefined&&temp2!=""){
				if(temp3!=null&&temp3!=undefined&&temp3!=""){
					return true;
				}
				alert("选项不能为空！");
				return false;
			}
			alert("选项不能为空！");
			return false;
		}
		alert("选项不能为空！");
		return false; */
	function pass(){
			$.ajax({
				type:'post',
				data:{pageCur:'1',pageNum:'2'}, //当前页：1，数量：2（参数根据后台要求）
				url:'/process/processTmplAction_upgradePkgTmpl.action',
				success : function(){
					
				}
			});
	}
</script>
</head>
<body>
	<input type='hidden' id='validateType' name='validateType'
		value='jquery' />
	<div id='matrixMask' name='matrixMask' class='matrixMask'
		style='display: none;'></div>

	<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1"	id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="get"
			action="#"
			style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
			enctype="application/x-www-form-urlencoded">
			<input type="hidden" id="processId" name="processId" value="${param.processId}">
			<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid0">
			<input type="hidden" id="upgradePkgTmplId" name="upgradePkgTmplId" value="${upgradePkgTmplId}">
			<input type="hidden" id="upgradeTargetPkgTmplId" name="upgradeTargetPkgTmplId" value="${upgradeTargetPkgTmplId}">
			<input type="hidden" name="form0" value="form0" /> 
			<input type="hidden" name="is_mobile_request" /> 
			<input type="hidden" name="mAuthScopeId" /> 
			<input type="hidden" name="listPkg" value="${listPkg}"  /> 
			<input type="hidden" id="iframewindowid" name="iframewindowid" value="${iframewindowid}">
			<input type="hidden" id="mHtml5Flag" name="mHtml5Flag" value="true" /> 
			<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" value="4d1579a5-af5b-4361-aa58-77d81300b3d1" /> 
			<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
			<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" /> 
			<input type="hidden" name="mQuerySetConditions" id="mQuerySetConditions" />
			<table id="table001" class="tableLayout" style="width: 90%;">
				<div>
					<tr id="tr101">
						<td id="td101" align="center" class="tdLayout" style="width: 322px; background:#b5dbeb">
							<label id="label101" name="label101" id="label101" class="control-label" style="font-weight:blod;">
								序号
							</label>
						</td>
						<td id="td103" align="center" class="tdLayout" style="width: 322px; background:#b5dbeb">
							<label id="label102" name="label102" id="label102" class="control-label " style="font-weight:blod;">
								目标版本环节
							</label>
						</td>
						<td id="td102" align="center" class="tdLayout" style="width: 322px; background:#b5dbeb">
							<label id="label101" name="label101" id="label101" class="control-label" style="font-weight:blod;">
								当前版本环节
							</label>
						</td>
					</tr>
					<c:forEach items="${listTaget}" var="li" varStatus="status">
						<tr>
							<td align="center" class="tdLayout" style="width: 5%; ">
								<label>
									${status.index+1}
								</label>
							</td>
							<td align="center" class="tdLayout" style="width: 50%;background:rgb(244,244,244);">
							<input type="hidden" id="newId${status.index+1}" name="newId${status.index+1}" value="${li.adid}"/>
								<option value="${li.adid}">${li}</option>
							</td>
							<td>
								<div class="input-group default-width  col-md-12 "	style="width:100%;display: inline-table; vertical-align: middle;">
								<select class="form-control" tabindex="-1" style="width: 100%; height: 100%;" onchange="" name="oldId${status.index+1}" id="oldId${status.index+1}">
								<option selected="selected" disabled="disabled"  style='display: none' value=''></option>
									<c:forEach items="${listPkg}" var="lii" varStatus="status1">
											<option value="${lii.adid}">${lii}</option>
									</c:forEach>
									<script>
										var a = document.getElementById('oldId${status.index+1}');
										/* window.arrayObj = new Array();
										arrayObj.push(a); */
										var ops = a.options;
										
										temp++;
											for(var i=0;i<ops.length;i++){
												if(ops[i]!=null){
													if(ops[i].innerHTML=="${li.name}"){
														ops[i].selected = true;
													}
												}
											}
											//document.getElementById('flag').value += 1;
										
									</script>
								</div> 
							<td>
						</tr>
					</c:forEach>
				</div>
				<tr id="tr004">
					<td  class="cmdLayout" id="td007" class="tdLayout" colspan="3" rowspan="1" style="text-align: center;">
						<button
							type="button" id="button001" class="x-btn ok-btn " onclick="button001onclick();">
							确认
						</button>
						<button
							type="button" id="button002" class="x-btn ok-btn " onclick="button002onclick();">
							关闭
						</button>
						<script>
							function button001onclick() {
								for(var i=1;i<=temp;i++){
									var id = "oldId"+i;
									var data = document.getElementById(id).value;
									if(data==null||data==undefined||data==""){
										alert("选项不能为空！");
										return false;
									}else{
										var upgradeTargetPkgTmplId = document.getElementById('upgradeTargetPkgTmplId').value;
										var upgradePkgTmplId = document.getElementById('upgradePkgTmplId').value;
										var url = "<%=path%>/process/processTmplAction_upgradePkgTmpl.action?upgradeTargetPkgTmplId="+ upgradeTargetPkgTmplId + "&upgradePkgTmplId=" + upgradePkgTmplId;
										document.getElementById('form0').action = url;
										document.getElementById('form0').submit();
										parent.parent.Matrix.warn('迁移成功！');
										Matrix.closeWindow();
										//var iframewindowid = document.getElementById('iframewindowid').value;
										//parent.Matrix.getMatrixComponentById(iframewindowid).hide();
									}
								}
				 			}
							function button002onclick(){
								Matrix.closeWindow();
							}
						</script>
					</td>
				</tr>
			</table>

		</form>
	</div>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/jquery.inputmask.bundle.min.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/icheck.min.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/select2.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/content.min.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/layer.min.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/autosize.min.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/clockpicker.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/jquery.hotkeys/jquery.hotkeys.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/css/google-code-prettify/src/prettify.js'></SCRIPT>
	<SCRIPT
		SRC='<%=path %>/resource/html5/js/validator.js'></SCRIPT>
	<script
		src='<%=path %>/resource/html5/js/jstree.min.js'></script>
	<script
		src='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>
</body>
</html>
