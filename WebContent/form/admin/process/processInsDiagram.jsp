<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程实例监控图</title>
</head>
<body>
<div style="overflow:auto;width:100%;height:100%;">
<img src="<%=request.getContextPath()%>/processMonitorHelper?matrixMonitorKey=ProcessMonitor&matrixMonitorPiid=${param.piid}"/>
</div>
</body>
</html>