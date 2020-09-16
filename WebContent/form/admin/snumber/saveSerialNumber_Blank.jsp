<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<title>流水号添加成功时回显</title>
<script type="text/javascript">
	
	function initPage(){
		var  dataObj = ${requestScope.jsonStr};
		if(dataObj!=null){
			
			Matrix.closeWindow(dataObj);
		
		}
	
	}
	
	
</script>

</head>
<body onload="initPage()">
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${requestScope.iframewindowid}">
		

</body>
</html>