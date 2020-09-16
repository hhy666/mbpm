<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>表单设计</title>
<script> 
		window.onload = function(){
			debugger;
			var type = '<%=request.getParameter("opType")%>';
			alert(type);
			var opType = document.getElementById("opType").value;
			var parentNodeId = document.getElementById("parentNodeId").value;
			parent.refreshCurTreeNode(opType,parentNodeId);
		}
	//window.location.href="<%=request.getContextPath()%>/form.dform";
</script>
</head>
<body>
<input type="hidden" name="opType" id="opType" value="${param.opType }"/>
<input type="hidden" name="parentNodeId" id="parentNodeId" value="${param.parentNodeId }"/>
<input type="hidden" name="processType" id="processType" value="${param.processType }">
<% 
response.sendRedirect(request.getContextPath()+"/form.dform?isScene="+request.getParameter("isScene")+"&opType="+request.getParameter("opType")+"&parentNodeId="+request.getParameter("parentNodeId")+"&processType="+request.getParameter("processType"));
%>


</body>
</html>