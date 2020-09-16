<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/foundation/common/taglib.jsp" />
<jsp:include page="/foundation/common/resource.jsp" />
<title>门户预览</title>
</head>
<body>
<script>
	isc.PortalLayout.create({
	    width: "100%",
	    height: "100%",
	    showColumnMenus:false,
	    //columnBorder:"0",
	    portlets: [
	       [
	         ${partsItems}
	       ]
	    ]
	});
</script>
</body>
</html>