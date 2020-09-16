<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>实体业务对象</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>

</head>
<body style="padding:5px;">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 				ID:"MForm0",
 				name:"MForm0",
 				position:"absolute",
 				action:"/entity",//保存实体
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="/entity"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" id="entityUuid" name="entityUuid" value="${param.entityUuid}" />
	<input type="hidden" name="parentNodeId" value="parentNodeId" value="${param.parentNodeId}" />
	<!-- 记录子页面选择的服务 -->
	<input type="hidden" id="selectedServiceName" name="selectedServiceName"/>
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState"
	id="javax.faces.ViewState" value="j_id107:j_id108" />
	 <input type="hidden" id="matrix_current_page_id" name="matrix_current_page_id" value="/console/entitymanager/AddEntity" />
<div id="tabContainer0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;">
	
	<script> 
		var MtabContainer0 = isc.TabSet.create({
				ID:"MtabContainer0",
				displayId:"tabContainer0_div",
				height: "100%",
				width: "100%",
				position: "relative",
				align: "center",
				tabBarPosition: "top",
				tabBarAlign: "left",
				showPaneContainerEdges: false,
				showTabPicker: true,
				showTabScroller: true,
				selectedTab:0,
				tabSelected:function(tabNum, tabPane, ID, tab, name){
						
				       if(tabPane.ID=="MtabContainer0Panel0"){
					      var serviceName = document.getElementById("selectedServiceName").value;
					      MtabContainer0Panel0.setContentsURL('<%=request.getContextPath()%>/logic/logicInfo_loadServiceLogicDesc.action?serviceLocation='+serviceName);
				       }
				},
				tabBarControls : [
					isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"300px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
					})
				 ],
				 tabs: [ 
				 	{title: "基本信息",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel3",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	},{
				 	title: "服务描述",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel0",
				 		height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	}
				  ] 
		});
	document.getElementById('tabContainer0_div').style.display='none';MtabContainer0.selectTab(0);
	</script>
</div>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
	MtabContainer0Panel3.setContentsURL("<%=request.getContextPath()%>/logic/logicInfo_loadLogicBasicMsg.action?mid=${logicInfo.mid}&parentNodeId=${param.parentNodeId}&isCommon=${param.isCommon}");
	
	
	document.getElementById('tabContainer0_div').style.display='';
	
</script>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>