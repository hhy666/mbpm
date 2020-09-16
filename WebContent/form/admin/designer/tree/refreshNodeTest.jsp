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
        var parentNodeId = "${requestScope.parentNodeId}";
        var treeGrid = parent.MTree0;
	    var addNodeId = "${requestScope.id}";//新添加id
        treeGrid.isFresh = true;
        treeGrid.addNodeId = addNodeId;
   		parent.Matrix.forceFreshTreeNode("Tree0",parentNodeId);//强制刷新节点

	
        
</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="absoluteLayout1" jsId="absoluteLayout1"
	style="position: absolute; _layout: xylayout; width: 100%; height: 100%">
<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<div style="position:relative;">
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 400px;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="respType" id="respType" value="${requestScope.respType}"/>
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>



</form>
</div>
<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>

</body>
</html>