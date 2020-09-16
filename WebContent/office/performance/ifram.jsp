<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>混合选择</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<style>
#div1_div {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 60px;
}
</style>
<script type="text/javascript">
debugger;

</script>
	</head>
	<body>
	<!-- <iframe src="<%=request.getContextPath()%>/PerforTempletTree.rform?iframewindowid=selectTemplet" width="100%" height="100%"  > -->
	<object data="<%=request.getContextPath()%>/PerforTempletTree.rform" width="100%" height="100%"></object> 
	</body>
</html>
