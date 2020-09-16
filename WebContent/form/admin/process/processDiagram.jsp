<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>协同流程</title>
</head>
<body>
<div style="overflow:auto;width:100%;height:100%;">
<% 

  String pdid = request.getParameter("flowDid");
  if(pdid.endsWith(".form")){
	  pdid = pdid.substring(0, pdid.length()-5);
  }
  String ptid = request.getParameter("ptid");
%>

<img src="<%=request.getContextPath()%>/processMonitorHelper?matrixMonitorKey=ProcessMonitor&matrixMonitorPdid=<%=pdid%>&matrixMonitorPtid=<%=ptid%>"/>
</div>
</body>
</html>