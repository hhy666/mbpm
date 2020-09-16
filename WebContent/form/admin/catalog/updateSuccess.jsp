<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix= "c"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>更新成功!</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
   		parent.Matrix.forceFreshTreeNode("Tree0","<%=request.getParameter("parentNodeId")%>");

</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="absoluteLayout1" jsId="absoluteLayout1"
	style="position: absolute; _layout: xylayout; width: 100%; height: 100%">
<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 400px;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState"
	id="javax.faces.ViewState" value="j_id1:j_id2" /> 
	<input type="hidden" id="matrix_current_page_id" name="matrix_current_page_id"
	    value="/console/catalog/AddSuccess" />
<div id="titlePanel2_div" class="matrixComponentDiv"
	style="width: 447px; height: 142px; _layout: xylayout; position: relative; left: 20%; top: 35%"><script>
	isc.Window.create({
		ID:"MtitlePanel2",
		displayId:"titlePanel2_div",
		height: "100%",
		width: "100%",
		title: "提示信息",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:false,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal: false,
		headerControls:[
			"headerIcon",
			"headerLabel"
		],
		items : [
			isc.MatrixHTMLFlow.create({
			ID:"Mj_id1",
			contents:"<div id='j_id1_div' class='matrixInline' style='width:100%;height:100%;overflow:auto;'/>"
			}) 
		]
	 });</script>
	 
	 </div>
<div id="j_id1_div2" style="width: 100%; height: 100%; overflow: auto;"
	class="matrixInline">
<table id="table0" jsId="table0" cellpadding="0px" cellspacing="0px"
	height="100%" width="100%">
	<tr id="tr12453067449211" jsId="tr12453067449211">
		<td id="td12453067449211" jsId="td12453067449211" align="center"
			colspan="1" rowspan="1">
			<label id="OutputLabel0"
			name="OutputLabel0" id="OutputLabel0"> <span>${statusMessage}</span><span>成功!</span></label></td>
	</tr>
</table>
</div>
<script>Matrix.appendChild('j_id1_div','j_id1_div2');</script></form>

<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>

</body>
</html>