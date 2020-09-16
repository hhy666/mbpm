<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>刷新树节点</title>
<script type="text/javascript">
   parent.Matrix.forceFreshTreeNode("Tree0", "<%=request.getParameter("parentNodeId")%>");
   window.location="<%=request.getContextPath()%>/form/admin/designer/designer.jsp";               
</script>

</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
</body>
</html>