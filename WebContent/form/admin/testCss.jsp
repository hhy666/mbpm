
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.matrix.client.foundation.function.action.FunctionHelper" %>
<%@ page import="java.util.*" %>
<%@ page import="commonj.sdo.*" %>

<html>


<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Matrix BPM Client</title>

<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>

<body>
<div id='loading' name='loading' class='loading'>
<!-- <div class='loading-indicator'></div> -->
<script>Matrix.showLoading();</script>
</div>
<%

	FunctionHelper helper = new FunctionHelper();
	List list = helper.loadChildrenFunctionByCustom();
	
	for(Iterator iter = list.iterator(); iter.hasNext(); ){
		DataObject data = (DataObject)iter.next();
		out.println("id:"+data.getString("functionId")+",name:"+data.getString("functionName"));
		
		List children = data.getList("children");
		for(Iterator iter2 = children.iterator(); iter2.hasNext(); ){
			DataObject data2 = (DataObject)iter2.next();
			out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));
			
		}
	}
		
%>


</body>

</html>