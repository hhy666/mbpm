<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询业务对象</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	

</script>
</head>
<body style="padding:5px;">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 96%">
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
<style>
html{
   touch-action:none;
}
</style>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="/entity"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" id="entityId" name="entityId" value="${param.entityId}" />
	<input type="hidden" id="entityType" name="entityType" value="${param.entityType}" />
	<input type="hidden" id="moduleId" name="moduleId" value="${param.moduleId}" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
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
				selectedTab: 0,
				tabBarControls : [
					isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"300px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
					})
				 ],
				 tabs: [ 
				 	{
				 	title: "属性",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel0",
				 		height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	},
				 	
				 			
				 	 {title: "基本信息",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel3",
				 		height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	},
				 	{title: ''}
				 	
				  ] 
		});
	document.getElementById('tabContainer0_div').style.display='none';MtabContainer0.selectTab(0);
	isc.Page.setEvent("load","MtabContainer0.selectTab(0);MtabContainer0.removeTab(MtabContainer0.tabs.length-1);");
	</script>
</div>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
</script>
<script>
	var isQueryType = ${param.entityType eq 2};
	if(isQueryType){
		MtabContainer0.addTab ({title: "内容",pane:isc.HTMLPane.create({
				 			ID:"MtabContainer0Panel1",
				 			height: "100%",
				 			overflow: "hidden",
				 			autoDraw: false,
				 			showEdges:false,
				 			contentsType:"page",
				 			contentsURL:""})
				 	 },1);
		//内容 			 	 
		MtabContainer0Panel1.setContentsURL('<%=request.getContextPath()%>/dentity/entityAction_loadQueryObjContent.action?entityId=${param.entityId}&entityPath=${param.entityPath}&entityType=${param.entityType}&moduleId=${param.moduleId}&moduleClsPath=${param.moduleClsPath}');
				 	 
	}

	//基本信息
	MtabContainer0Panel3.setContentsURL('<%=request.getContextPath()%>/dentity/entityAction_loadBasicMsg.action?entityId=${param.entityId}&entityPath=${param.entityPath}&entityType=${param.entityType}&moduleId=${param.moduleId}&moduleClsPath=${param.moduleClsPath}');
    //查询对象属性标签页
	MtabContainer0Panel0.setContentsURL('<%=request.getContextPath()%>/dentity/entityAction_loadBOPropList.action?entityId=${param.entityId}&entityPath=${param.entityPath}&entityType=${param.entityType}&moduleId=${param.moduleId}&moduleClsPath=${param.moduleClsPath}');
	document.getElementById('tabContainer0_div').style.display='';
</script>
</form>
<script>
	MForm0.initComplete=false;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>