<%@ page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="commonj.sdo.DataObject"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
<script type="text/javascript">
	$(function(){
		debugger;
		var message = '<%=request.getAttribute("message")%>';
		if(message!=null && message!=''){
			if(message == '导入成功'){
				parent.hideList();
				parent.refreshData();
				parent.layer.alert(message);
				var index = parent.layer.getFrameIndex(window.name);
				parent.layer.close(index)
			}else{
				parent.layer.alert(message);
				var index = parent.layer.getFrameIndex(window.name);
				parent.layer.close(index)
			}
		}
	})
</script>
</head>
<body>
</body>
</html>
