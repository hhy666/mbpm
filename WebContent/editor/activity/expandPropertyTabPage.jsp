<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>扩展属性页面</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style type="">
		font{
			font-size:14px;
			margin-left:10px;
			font-weight:bold;
		}
		#td001{
			width:100%;
			height:30px;
			background:#F8F8F8;
		}
		</style>
		<script type="text/javascript">
			
		</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var Mform0=isc.MatrixForm.create({
 				ID:"Mform0",
 				name:"Mform0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input type="hidden" name="entityId" id="entityId" value="${param.entityId }"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/><input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
<table id="table001" class="tableLayout"
	style="width: 100%; height: 100%;">
	<tr id="tr001">
		<td id="td001" class="tdLayout" style="width: 100%;"><font>扩展属性</font></td>
	</tr>
	<tr id="tr002">
		<td id="td002" class="tdLayout" style="width: 100%; height: 93%">
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
				selectedTab: 2,
				tabBarControls : [
					isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"30px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
					})
				 ],
				 tabs: [ 
				 	{
				 	title: "实例属性",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel0",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	}/**,{
				 	title: "模板属性",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel1",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	}*/
				  ] 
		});
	document.getElementById('tabContainer0_div').style.display='none';MtabContainer0.selectTab(0);
	isc.Page.setEvent("load","MtabContainer0.selectTab(0);");
	</script>
</div>
</td>
	</tr>
</table>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
	
	MtabContainer0Panel0.setContentsURL('<%=request.getContextPath()%>/editor/editor_getInsPropertyList.action?entityId=${param.entityId}&activityId=${param.activityId}&containerId=${param.containerId}');
	//MtabContainer0Panel1.setContentsURL('<%=request.getContextPath()%>/editor/editor_getTemplPropertyList.action?entityId=${param.entityId}&flag=2&activityId=${param.activityId}');
	document.getElementById('tabContainer0_div').style.display='';
</script></td>
	</tr>
</table>

</form>
<script>
	Mform0.initComplete=true;Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);
</script>


</div>

</body>
</html>