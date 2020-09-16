<!DOCTYPE HTML >
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在此处插入标题</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"<%=request.getContextPath()%>/form/formInfo_getFormVersions.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="get"
	action="<%=request.getContextPath()%>/process/processTmplAction_processMigrationPkgTmplId.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
	<input type="hidden" name="Form0" value="Form0" /> 
	<input type="hidden" id="processId" name="processId" value="${param.processId}">
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid0">
	<input type="hidden" id="upgradePkgTmplId" name="upgradePkgTmplId" value="${upgradePkgTmplId}">
	<input type="hidden" id="upgradeTargetPkgTmplId" name="upgradeTargetPkgTmplId" value="${upgradeTargetPkgTmplId}">
	<input type="hidden" id="selection" name="selection" value="${selection}">
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${iframewindowid}">
	

<table id="dataTable" jsId="dataTable" cellpadding="0px"
	cellspacing="0px" style="width: 100%; height: 100%;">
	<tr>
		<td style="border-style: none; width: 100%;">
			<div id="DataGrid0_div" class="matrixComponentDiv"
				style="width: 100%; height: 100%;">
				<script>
					var gridData = eval(${pkgTmpls}); 
					isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:true,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
						fields:[
						  {title:"名称",	name:"PACKAGE_NAME"},
						  {title:"版本",name:"RH_VERSION"},
						  {title:"最后更新时间",name:"PKG_SUBMIT_TIME"},
						  {title:"状态",name:"RH_PUB_STATUS" },
						  {title:"当前操作人", name:"PACKAGE_OWNER"},
						  {title:"最后更新人",name:"PKG_SUBMIT_ID"}
						],
						data:gridData,
						autoFetchData:true,
						alternateRecordStyles:true,
						canAutoFitFields:false,
						canEdit:false,
						selectionType: "single"
					});
					isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			 		
			 		//确认选中流程模板
			 		function selectPkgTmpl(data){
			 			//var url = webContextPath+"/process/processTmplAction_processMigrationPkgTmplId.action";
			 			//document.getElementById('Form0').action=url;
			 			var selection = MDataGrid0.getSelection();
			 			if(selection==null || selection.length==0){
			 				isc.warn("请选择要迁移的流程模板！");
			 				return false;
			 			}
			 			<%-- var url = <%=request.getContextPath()%>+"/process/processTmplAction_processMigrationPkgTmplId.action"
			 			Matrix.sendRequest(url,data,
								function(response){
									if("true"==response.data){
		  								isc.say("迁移流程模板成功！");
									}else{
		  								isc.warn("迁移流程模板失败！");
									}
								},
								function(){
		  							isc.warn("迁移流程模板失败！");
		  							return false;
								}
							); --%>
						var record = selection[0];
			 			var upgradeTargetPkgTmplId = record.pkgTid;
			 			document.getElementById('upgradeTargetPkgTmplId').value = upgradeTargetPkgTmplId;
						var src = webContextPath+"/process/processTmplAction_processMigrationPkgTmplId.action";
						document.getElementById('Form0').action = src;
			 			document.getElementById('Form0').submit();
			 			
					/*	var pkgTmplId = "";
			 			var records = MDataGrid0.getSelection();
			 			if(records==null || records.length==0){
			 				isc.warn("没有选中的流程模板！");
			 				return false;
			 			}
			 			var record = records[0];
			 			Matrix.closeWindow(record);
			 		*/	//var url = webContextPath+"/process/processTmplAction_processMigrationPkgTmplId.action";
			 			//Matrix.sendRequest(url);
			 		}
				</script>
			</div>
		</td>
	</tr>
	<tr>
		<td styl="heigth:25px" class="maintain_form_command">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;width: 100px; height: 22px;">
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
					showRollOverIcon:false,
					click:function(){
						Matrix.showMask();
						selectPkgTmpl();
			            Matrix.hideMask();
           			}
			});
			</script>
		</div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;width: 100px;; height: 22px;">
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
					showRollOverIcon:false,
					click:function(){
						Matrix.showMask();
					    Matrix.closeWindow();
						Matrix.hideMask();
					}
				});
				</script>
			</div>
		</td>
	</tr>
</table>
</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</body>
</html>