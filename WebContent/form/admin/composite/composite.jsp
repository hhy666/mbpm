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
	</head>
	<script type="text/javascript">
	var alertFlag = true;//判断是否需要弹出离开提示
	 window.onbeforeunload=function() { 
		 if(alertFlag){
			var result = window.event.returnValue="确认要退出当前设计页面吗?"; 
		 }else{
			 alertFlag = true;
		 }
	} 
	
		window.onload=function(){
		//	var isFormTemplate = '${param.isFormTemplate }';
		//	var parentNodeId = '${param.parentNodeId}';
		//	if(isFormTemplate == ''){
		//		parent.$('#container').jstree(true).refresh_node(parentNodeId);
		//	}
			//MTabContainer001.removeTab(3);  //先暂时移除掉子表单这个标签页
		}
		
		var authUser={};
		var showListName=[];
		var sortName=[];
		var userInputCondition=[];

	</script>
	<body>
		<div id='matrixMask' name='matrixMask' class='matrixMask' style='display:none;'> </div>
		<div id='loading' name='loading' class='loading'>
			<script>
				Matrix.showLoading();
			</script>
		</div>
	
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
				<input type="hidden" id="mode" name="mode" value="debug" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
				<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
				<div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;">
					<script>
						var MTabContainer001 = isc.TabSet.create({
							ID: "MTabContainer001",
							displayId: "TabContainer001_div",
							height: "100%",
							width: "100%",
							position: "relative",
							align: "center",
							canSelectText: true,
							tabBarPosition: "top",
							tabBarAlign: "left",
							showPaneContainerEdges: false,
							showTabPicker: false,
							showTabScroller: false,
							selectedTab: 0,
							tabBarControls: [isc.MatrixHTMLFlow.create({
								ID: "MTabBar001",
								width: "300px",
								contents: "<div id='TabBar001_div' style='text-align:right;' ></div>"
							})],
							tabs: [{
								id:"basic",
								title: "基本信息",
								autoDraw: false,
								canSelectText: true,
								pane: isc.HTMLPane.create({
									ID: "MTabPanel001",
									height: "100%",
									overflow: "hidden",
									autoDraw: false,
									showEdges: false,
									contentsType: "page",
									contentsURL: ""
								})
							}, {
								id:"formDesigner",
								title: "表单设计",
								autoDraw: false,
								canSelectText: true,
							//	disabled : true,
								pane: isc.HTMLPane.create({
									ID: "MTabPanel006",
									height: "100%",
									overflow: "hidden",
									autoDraw: false,
									showEdges: false,
									contentsType: "page",
									contentsURL: ""
								})
							}, {
								id:"formSec",
								title: "表单权限",
								autoDraw: false,
								canSelectText: true,
								pane: isc.HTMLPane.create({
									ID: "MTabPanel002",
									height: "100%",
									overflow: "hidden",
									autoDraw: false,
									showEdges: false,
									contentsType: "page",
									contentsURL: ""
								})
							}, 
							/*
							{
								id:"childForm",
								title: "子表单",
								autoDraw: false,
								canSelectText: true,
								pane: isc.HTMLPane.create({
									ID: "MTabPanel007",
									height: "100%",
									overflow: "hidden",
									autoDraw: false,
									showEdges: false,
									contentsType: "page",
									contentsURL: "<%=request.getContextPath() %>/SubFormEdit.rform?templateId=${mBizId }"
								})
							},
							*/
							{
								id:"flowDesigner",
								title: "流程设计",
								autoDraw: false,
								canSelectText: true,
								pane: isc.HTMLPane.create({
									ID: "MTabPanel005",
									height: "100%",
									overflow: "hidden",
									autoDraw: false,
									showEdges: false,
									contentsType: "page",
									contentsURL: ""
								})
							}, {
								id:"utilization",
								title: "应用设置",
								autoDraw: false,
								canSelectText: true,
								pane: isc.HTMLPane.create({
									ID: "MTabPanel003",
									height: "100%",
									overflow: "hidden",
									autoDraw: false,
									showEdges: false,
									contentsType: "page",
									contentsURL: ""
								})
							}, {
								id:"query",
								title: "查询设置",
								autoDraw: false,
								canSelectText: true,
								pane: isc.HTMLPane.create({
									ID: "MTabPanel004",
									height: "100%",
									overflow: "hidden",
									autoDraw: false,
									showEdges: false,
									contentsType: "page",
									contentsURL: ""
								})
							}],
							tabSelected:function(tabNum, tabPane, ID, tab){
								if(tab.id == "formSec"){//表单权限
									var nodeId = document.getElementById('formUuid').value;
									MTabPanel002.setContentsURL('<%=request.getContextPath() %>/security/formSecurity_loadSecurityIndex.action?catalogId='+nodeId);
								}else if(tab.id == "flowDesigner"){//流程设计
									var flowId = document.getElementById('flowId').value;
									var formId = document.getElementById('nodeId').value;
									var formUuid= document.getElementById('formUuid').value;
									var parentId = '${mBizId}';
									MTabPanel005.setContentsURL('<%=request.getContextPath() %>/FlowModelManager.rform?mHtml5Flag=true&formId1='+formId+'&flowId1='+flowId+'&parentId1='+parentId+'&formUuid='+formUuid+'&flowOrDoc=${param.flowOrDoc}&type=${param.type}&tempCls=${param.tempCls }&startType=0&id=${param.mid }&docType=${param.docType}&processType='+('${param.tempCls}'=='3'?'':'${param.tempCls}'));
									//MTabPanel005.setContentsURL('<%=request.getContextPath() %>/FlowModelManager.rform?formId1='+formId+'&flowId1='+flowId+'&parentId1='+parentId+'&formUuid='+formUuid+'&flowOrDoc=${param.flowOrDoc}&type=${param.type}&tempCls=${param.tempCls }&startType=0&id=${param.mid }&docType=${param.docType}&processType='+('${param.tempCls}'=='3'?'':'${param.tempCls}'));
								}else if(tab.id == "utilization"){//应用设置
									/* var appId = document.getElementById('appId').value;
									var appFormId = document.getElementById('appFormId').value;
									var appParentId = document.getElementById('appParentId').value; */
									var catalogId = '${mBizId}';//将模板id作为节点id
									var formId = document.getElementById('nodeId').value;
									MTabPanel003.setContentsURL('<%=request.getContextPath() %>/utilization/utili_loadDataGridData.action?catalogId='+catalogId+'&formId='+formId);
								}else if(tab.id == "query"){//查询设置
									/* var queryId = document.getElementById('queryId').value;
									var queryFormId = document.getElementById('queryFormId').value;
									var queryParentId = document.getElementById('queryParentId').value; */
									var catalogId = '${mBizId}';//将模板id作为节点id
									var formId = document.getElementById('nodeId').value;
									MTabPanel004.setContentsURL('<%=request.getContextPath() %>/query/query_loadDataGridData.action?catalogId='+catalogId+'&formId='+formId);
								}
							},
							tabDeselected:function(tabNum, tabPane, ID, tab, newTab){
								var selectTabNum = this.getTabNumber(newTab);
								var nodeId = document.getElementById('formUuid').value;
								if(nodeId == ""){
//									Matrix.warn('请选择表单！');
									return false;
								}
								/* if(newTab.id == "utilization"){
									var appId = document.getElementById('appId').value;
									if(appId == ""){
										Matrix.warn("请选择应用设置项！")
										return false;
									}
								}else if(newTab.id == "query"){
									var queryId = document.getElementById('queryId').value;
									if(queryId == ""){
										Matrix.warn("请选择查询设置项！")
										return false;
									}
								} */
								
								//判断是否从表单设计页面切走,是则提示
								if(tab.id == "formDesigner"){
									var confmesg = confirm("系统可能不会保存您所做的更改。");
									if(!confmesg){
										return false;
									}
								}
								
								//从基本信息页面或子表单进入表单设计
						//		if((tab.id == "basic" && newTab.id == "formDesigner") || (tab.id == "childForm" && newTab.id == "formDesigner")){//表单设计
								if(newTab.id == "formDesigner") {//表单设计		
									MTabPanel006.setContentsURL('<%=request.getContextPath() %>/form/formInfo_loadFormMainPage.action?nodeUuid='+nodeId+'&type=1&processType='+('${param.tempCls}'=='3'?'':'${param.tempCls}'));
								}
							}
						});
						document.getElementById('TabContainer001_div').style.display = 'none';
						MTabContainer001.selectTab(0);
						var templateType = '${param.tempCls}';
						if(templateType == '1'){
							MTabContainer001.removeTab(6);
							MTabContainer001.removeTab(5);
						}else if(templateType == '3'){
							MTabContainer001.removeTab(3);  //底表不需要流程设计
						}
					</script>
				</div>
				<script>
					MTabPanel001.setContentsURL('<%=request.getContextPath() %>/CompositeModel.rform?mBizId=${mBizId }&flowOrDoc=${param.flowOrDoc}&type=${param.type}&tempCls=${param.tempCls }&startType=0&id=${param.mid }&docType=${param.docType}&mHtml5Flag=true');
				</script>
				<div id="TabBar001_div2" style="text-align:right" class="matrixInline"></div>
				<input id="flowId" type="hidden">
				<input id="formUuid" type="hidden">
				<input id="nodeId" type="hidden">
				<input id="formId" type="hidden">
				<!-- <input id='appId' type='hidden'>
				<input id='queryId' type='hidden'>
				<input id='queryParentId' type='hidden'>
				<input id='appParentId' type='hidden'>
				<input id='appFormId' type="hidden">
				<input id="queryFormId" type="hidden"> -->
				<input id='checkBoxValue' type="hidden">
				<script>
					document.getElementById('TabBar001_div').appendChild(document.getElementById('TabBar001_div2'));
				</script>
				<script>
					document.getElementById('TabContainer001_div').style.display = '';
				</script>
			</form>
		</div>
		<script>
			Mform0.initComplete = true;
			Mform0.redraw();
			isc.Page.setEvent(isc.EH.RESIZE, function() {
				isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
			}, isc.Page.FIRE_ONCE);
		</script>
		
		<script>
	
	isc.Window.create({
			ID:"MCodeMain",
			id:"CodeMain",
			name:"CodeMain",
			autoCenter: true,
			position:"absolute",
			height: "90%",
			width: "90%",
			title: "test",
			canDragReposition: true,
			showMinimizeButton:false,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel",
				"closeButton"
			]
			
			//initSrc:
			//src:
	});
	MCodeMain.hide();
	
	function refreshParentNode(){
		var parentNodeId = '${param.parentNodeId}';
		parent.$('#container').jstree(true).refresh_node(parentNodeId);
	}
	</script>
	</body>
</html>
