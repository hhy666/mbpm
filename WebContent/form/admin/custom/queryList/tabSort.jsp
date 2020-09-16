<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>表单</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
		
		<script type="text/javascript">
		
		
		</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 				ID:"MForm0",
 				name:"MForm0",
 				position:"absolute",
 				action:"/form",//
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
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="mid" name="mid">
	
	<!-- 子页面的隐藏字段 -->
	<input type="hidden" id="name" name="name" >
	<input type="hidden" id="desc" name="desc" >
	<!-- 授权列表 子页面的隐藏字段 -->
	<input type="hidden" id="formUuid" name="formUuid" >
	
	
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
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
				selectedTab: 3,
				tabBarControls : [
					isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"10px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;width:50%;' ></div>"
					})
				 ],
				 tabs: [ 
				 	{title: "表单数据",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel3",height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	}
				 	
				  ] 
		});
	document.getElementById('tabContainer0_div').style.display='none';
	MtabContainer0.selectTab(0);
	isc.Page.setEvent("load","MtabContainer0.selectTab(0);");//MtabContainer0.removeTab(MtabContainer0.tabs.length-1);
	</script>
</div>
<div id="tabContainer0Bar0_div2" style="text-align: right;width:50%;" class="matrixInline">

</div>
<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
	MtabContainer0Panel3.setContentsURL('<%=request.getContextPath()%>/query/query_loadSort.action?mBizId=${param.mBizId}&formId=${param.formId}');
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