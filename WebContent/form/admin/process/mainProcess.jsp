<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page
	import="com.matrix.engine.foundation.domain.PkgTemplateKeyInfoVO,
		java.text.SimpleDateFormat,
		com.matrix.api.MFExecutionService,
   		com.matrix.api.template.PublicationStatus,
   		com.matrix.api.identity.*,
		com.matrix.client.TextUtils,
		com.matrix.form.admin.common.utils.*,
		com.matrix.engine.foundation.config.OrganizationTable,
		com.matrix.engine.foundation.config.MFSystemProperties,
		com.matrix.api.config.RunModeType,
		com.matrix.client.ClientConstants,
		java.util.*,
		com.matrix.form.admin.common.utils.CommonUtil"%>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>协同流程</title>
<jsp:include page="/form/admin/common/resource.jsp"/>
</head>
<body style="padding:5px;">
<jsp:include page="/form/admin/common/loading.jsp"/>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<%
	MFExecutionService mfes = (MFExecutionService)session.getAttribute(ClientConstants.EXECUTION_SERVICE);

	int phase = CommonUtil.getCurPhase();
	boolean isScene = false;
	//设计开发和调整优化阶段  流程是一样的---lpz----
	if(phase==4||phase==3){
		isScene = true;
	}
	//if(phase==4){
	//	isScene = true;
	//}
	
	
	// 获得产品模式
	//RunModeType modeType = mfes.getMFConfig().getRunModeType();
	//boolean isProductMode = false;
	//if(modeType.getValue()==RunModeType.PRODUCT_TYPE){
	//	isProductMode = true;
	//}
	MFUser user = mfes.getMFUser();
	String userId = user.getUserId();
	int releasedType = PublicationStatus.RELEASED_TYPE;
	int underReleasedType = PublicationStatus.UNDER_REVISION_TYPE;
	
	//String processId = request.getParameter("processId");
	//String parentNodeId = request.getParameter("parentNodeId");
	
	boolean isAdmin = CommonUtil.isAdmin(mfes);
	
	// 获得设计器所需要的其他参数
	String sessionId = mfes.getSessionId();
	//OrganizationTable orgTable = MFSystemProperties.getInstance().getOrganizationTable();
	//String orgId = orgTable.getDepParentIdDefault();
	//String roleRootId = orgTable.getRoleParentIdDefault();
	//boolean isTreeType = orgTable.getRoleIsTreeFlag();
    //String roleViewType = "grid"; 
	//if(isTreeType)
	//	 roleViewType = "tree"; 
//    String contextPath = request.getContextPath().substring(1);
    String contextPath = "";
 	//String serverIp = request.getLocalAddr();
	String serverIp = request.getServerName();
    int serverPort = request.getServerPort();
    //String returnUrl = "process/process_queryPkgTemplates.action";//获得客户端发送请求的完整url
    
    String params = "";
  //  params +="serverIp="+serverIp;
 //   params +="&contextPath="+contextPath;
  //  params +="&sessionId="+sessionId;
 //   params +="&userId="+userId;
   // params +="&serverPort="+serverPort;
   // params +="&mode=design";
   
   
    
%>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 96%">
<form id="processForm" name="processForm">

	<input type="hidden" id="processId" name="processId" value="${param.processId}">
	<input type="hidden" id="pdid" name="pdid" value="${param.processId}">
	<input type="hidden" id="pkgTid" name="pkgTid" value="">
	<input type="hidden" id="entityId" name="entityId" value="${param.entityId}">
	<input type="hidden" id="processTmplId" name="processTmplId" value="${param.processTmplId}">
	<input type="hidden" id="parentNodeId" name="parentNodeId" value="${param.processId}">
	<input type="hidden" id="processType" name="processType" value="${param.processType}">
	<input type="hidden" id="isScene" name="isScene" value="<%=isScene %>">
	<input type="hidden" id="fromTmplList" name="fromTmplList" value="true">
	<input type="hidden" id="tempCls" name="tempCls" value="${param.tempCls }">
	
	
	<!-- 流程设计需要
	 -->
	<input id="simulationType" name="simulationType" type="hidden" value="0">
		
	<script>
	
		isc.TabSet.create({
		 	ID:"MtabContainer0",
		 	height: "100%",
		 	width: "100%",
		 	align: "center",
		 	tabBarPosition: "top",
		 	tabBarAlign: "left",
		 	showPaneContainerEdges: false,
		 	showTabPicker: true,
		 	showTabScroller: true,
		 	selectedTab: 0,
		    tabs: [ 
			    	{
			    	title: "流程列表",
			    	pane:isc.HTMLPane.create({
			    	     ID:"MtabContainer0Panel0",
			    	     width: "100%",
			    	     height: "100%",
			    	     overflow: "auto",
			    	     showEdges:false,
			    	     contentsType:"page",
			    	     contentsURL:""
			    	  	})
			    	 },
			    	 
			    	 {title: "流程信息",
			    	  pane:isc.HTMLPane.create({
			    	     ID:"MtabContainer0Panel2",
			    	     width: "100%",height: "100%",
			    	     overflow: "auto",
			    	     showEdges:false,
				 		autoDraw: false,
			    	     contentsType:"page",
			    	     contentsURL:""
			    	  	})
			    	 }
		    	 ] 
		 });
		 
		 var processType = document.getElementById('processType').value;
		 
		 var processListURL = webContextPath+"/process/processTmplAction_queryPkgTemplates.action?processId=${param.processId}&tempCls=${param.tempCls}";
		 if(processType!=null&&processType.length>0){
		 	processListURL+="&processType="+processType;
		 }
		 var ruleListURL = webContextPath+"/process/ruleAction_queryRules.action?processId=${param.processId}";
		 var processInfoURL = webContextPath+"/catalog_getCatalogById.action?entityId=${param.processTmplId}&parentNodeId=${param.parentNodeId}&type=${param.type}";
		 var phase = "<%=phase%>";
		
		 if(phase=="2"||phase=="3"||phase=="4"){
			/* MtabContainer0.addTab({
			    	  title: "规则列表",
			    	  pane:isc.HTMLPane.create({
			    	     ID:"MtabContainer0Panel1",
			    	     width: "100%",
			    	     height: "100%",
			    	     overflow: "auto",
			    	     showEdges:false,
				 		 autoDraw: false,
			    	     contentsType:"page",
			    	     contentsURL:""
			    	    
			    	  	})
			    	 },1);
		 
				 MtabContainer0Panel1.setContentsURL(ruleListURL);
		 */
		 }
		 
		 
		 
		 MtabContainer0Panel0.setContentsURL(processListURL);
		 MtabContainer0Panel2.setContentsURL(processInfoURL);
		 
		 var parentNodeId = "${param.parentNodeId}";
		 var processId = "${param.processId}";
		 var endtityId = "${param.entityId}";
		 
		 var userId = "<%=userId %>";
		 var isAdmin = <%=isAdmin %>;
		 var releasedType = <%=releasedType %>;
		 var underReleasedType = <%=underReleasedType %>;
		 var sessionId =  "<%=sessionId %>";
		 var serverIp =  "<%=serverIp %>";
		 var serverPort = "<%=serverPort %>";
		 var contextPath = "<%=contextPath %>";
		 var isScene = "<%=isScene %>";
		
		 
		if(isAdmin){
			MtabContainer0.removeTab(1);
		}

		 //流程模板仿真参数
		 var simulationParams = "<%=params%>"+"&simulationType=2";
		 
		 
		 //刷新协同流程目录节点
		 function refreshProcessCatalogTreeNode(){
		 	parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
		 }
		 
		 //判断是否是新增流程
		 var isNewProcess =  "${isNewProcess}";
		 if(isNewProcess=="true"){
		 	refreshProcessCatalogTreeNode();
		 }
		 
		 //创建流程
		 function createProcess(){
		 	var processType = document.getElementById("processType").value;
 			var action = webContextPath+"/process/processTmplAction_createProcessTmpl.action?processType="+processType;
			document.getElementById("processForm").action=action;
			document.getElementById("processForm").submit();
		 }
		 
		  //复制流程
		 function copyProcess(pkgTid){
		 	document.getElementById("pkgTid").value=pkgTid;
 			var action = webContextPath+"/process/processTmplAction_copyProcessTmpl.action";
			document.getElementById("processForm").action=action;
			document.getElementById("processForm").submit();
		 }
		 
		 //导入BPMN 
		 isc.MatrixWindow.create({
		    ID: "MImportBPMNWindow",
		    id: "ImportBPMNWindow",
		    title: "导入BPMN流程文件",
		    autoCenter: true,
		    width:400,
		    height:200,
		    isModal: true,		
		    showModalMask: false,
			modalMaskOpacity:0,
		    autoDraw: false,
		    showMinimizeButton:false,
		    initSrc:webContextPath+"/form/admin/process/importBPMN.jsp?processId=${param.processId}",
		    src:webContextPath+"/form/admin/process/importBPMN.jsp?processId=${param.processId}"
		});
 		 function importBPMN(){
 			//表单导入窗口
 			if(MImportBPMNWindow){
				MImportBPMNWindow.show();
			}
 		 }
 		 
 		 function onImportBPMNWindowClose(pkgTid){
 		 	if(pkgTid!=null && pkgTid.trim().length>0){
	 			document.getElementById("pkgTid").value=pkgTid;
	 			var action = webContextPath+"/process/processTmplAction_designProcess.action";
				document.getElementById("processForm").action=action;
				document.getElementById("processForm").submit();
 		 	}
 		 	return true;
 		 }
		 
		 
		 
		  //设计流程
		 function designProcess(pkgTid){
		 	var processType = document.getElementById("processType").value;
 			var action = webContextPath+"/process/processTmplAction_designProcess.action?processType="+processType;
			document.getElementById("pkgTid").value=pkgTid;
			document.getElementById("processForm").action=action;
			document.getElementById("processForm").submit();

	/*	 var ptid = pkgTid;
         var pdid = document.getElementById('pdid'); 
    	   var url ="<%=request.getContextPath()%>/editor/flowdesigner.jsp?pdid="+pdid+"&ptid="+ptid+"&containerType=process&containerId="+pdid+"&mode=flow&amp;fromDB=true";
			var width = screen.availWidth * 0.8;  
	        var height = screen.availHeight * 0.8;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 
	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
			window.open(url,'设计流程',windowFeatures);
		*/	
		 }
		 
		 // 删除流程模板 
		 function validateDeleteProcess(record) {
			var owner = record.owner;
   			var states = record.status;
   			
   			if(isAdmin){
   				return true;
   			}
   			/* 发布状态
   			if(states==releasedType){
  				if(tmplTIDs==""){
  					tmplTIDs = ptid;
  				}else{
 					tmplTIDs = tmplTIDs + "," + ptid;
   				}
   				continue;
   			}*/
   			// 非发布状态，判断当前操作人员
			if(owner==null || owner.trim().length==0 || userId==owner){
  			}else{
  				return false;
  			}
			return true;
		}
		 
	</script>
</form>

</div>	


</body>
</html>