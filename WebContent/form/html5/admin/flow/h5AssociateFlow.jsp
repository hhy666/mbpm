<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="utf-8" />
			<%@ include file="/form/html5/admin/html5Head.jsp"%>
				<style>
				</style>
		</head>

		<body> <input type="hidden" id="validateType" name="validateType" value="jquery" />
		<div class="container-fluid" style="height:100%;">
			<div class="row" style="height:100%;">
				<div class="col-xs-3" style=" padding:0px;">
					<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;padding:3px;zoom:1" id="context">
						<form id="form0" name="form0" eventProxy="Mform0" method="post" action="/mofficeV3/matrix.rform" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded"> <input type="hidden" name="form0" value="form0" /> <input type="hidden" id="mode" name="mode" value="debug" /> <input type="hidden" name="is_mobile_request" /> <input type="hidden" name="mHtml5Flag" value="true" /> <input type="hidden" id="matrix_form_tid" name="matrix_form_tid" /> <input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
							<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div> <input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
							<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
								<tr style="height:0px;">
									<td class="query_form_toolbar" colspan="2">
										<div id="QueryForm001_tb" style=" width:100%;height:38px;" class="x_panel panel_color">
											<button type="button" id="toolBarItem003" class="btn  btn-default toolBarItem" style=" " onclick="toolBarItem003onclick();">添加</button>
											<script>
											function toolBarItem003onclick() {
												layer.open({
											    	id:'layerAddFlow',
													type : 2,//iframe 层
													
													title : ['选择流程'],
													closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
													shadeClose: false, //开启遮罩关闭
													area : [ '50%', '80%' ],
													content : '<%=request.getContextPath()%>/form/html5/admin/logon/matrix/html5SelectFormOrFLow.jsp?iframewindowid=layerAddFlow&rootCode=flowdesign&queryType=7',
													//end	: function(){
													//	$('#container').jstree(true).refresh_node(node);
													//}
												});
											}
											
											function onlayerAddFlowClose(data){
												$('#DataGrid001_table').bootstrapTable('prepend', data);
												
											}
											</script>
											<button type="button" id="toolBarItem0031" class="btn  btn-default toolBarItem" style=" " onclick="toolBarItem0031onclick();">删除</button>
											<script>
											function toolBarItem0031onclick() {
												var selections = $("#DataGrid001_table").bootstrapTable('getSelections');
												for(var selection in selections ){
													$("#DataGrid001_table").bootstrapTable('remove',{field:'id',values:[selections[selection].id]});
												}
											}
											</script>
											<button type="button" id="toolBarItem0032" class="btn  btn-default toolBarItem" style=" " onclick="toolBarItem0032onclick();">编辑</button>
											<script>
											function toolBarItem0032onclick() {
												layer.open({
													id:"layerFlowEdit",
													type:2,
													
													title : ['流程编辑'],
													closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
													shadeClose: false, //开启遮罩关闭
													area : [ '90%', '80%' ],
													content : '<%=request.getContextPath()%>/form/admin/composite/modelEditPage.jsp',
												});
											}
											</script>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
										<table id="DataGrid001_table" style="width:100%;height:100%;"></table>
										<script>
										$(document).ready(function() {
											$("#DataGrid001_table").bootstrapTable({
												classes: 'table table-hover table-no-bordered',
												method: "post",
												url: "/matrix.rform?mHtml5Flag=true&MATRIX_REFRESH_FORM_ID=form0&matrix_command_id=loadData&X-Requested-With=XMLHttpRequest&REFRESH_COMPONENT_IDS=DataGrid001,&matrix_form_tid=null",
												showToggle: false,
												sortable: false,
												height:$(window).height(),
												pagination: false,
												sidePagination: "server",
												clickToSelect: true,
												formatLoadingMessage: function() {
													return '请稍等，正在加载中...';
												},
												formatNoMatches: function() {
													return '无符合条件的记录';
												},
												columns: [{
													field:'checked',
													checkbox : true
												},{
													title: "序号",
													width: '8px',
													formatter: function(value, row, index) {
														return index+1;
													}
												}, {
													title: "ID",
													field: "id",
													visible: false,/* 该行隐藏 */
													type: 'text'
												}, {
													title: "编码",
													field: "formId",
													type: 'text'
												}, {
													title: "名称",
													field: "name",
													type: 'text'
												}],
												singleSelect: false
											});
										});
										
										$("#DataGrid001_table").on('dbl-click-row.bs.table',function (e, row, ele,field){
											$("#InfoIframe").attr("src",'<%=path %>/form/admin/process/mainProcess.jsp?processId='+row.formId+'&processTmplId='+row.id+'&entityId='+row.id+'&parentNodeId='+row.parentId+'&type=17&processType=');
										})
										</script>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="col-xs-9" style="height:100%; padding:0px;">
					<iframe id="InfoIframe" style="width:100%;height:100%; " frameborder="0" src="" ></iframe>
				</div>
			</div>
		</div>
		</body>

		</html>