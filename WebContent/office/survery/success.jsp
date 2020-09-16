<%@page import="com.matrix.form.render.util.RenderKitUtils"%>
<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService" %>
<%@page import="java.util.List" %>
<%@page import="java.util.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.ArrayList" %>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.*"%>
<%@page import="java.util.Map"%>
<%@page import="com.matrix.office.investigation.common.CommonHelper"%>
<!DOCTYPE HTML>

<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<title>提交调查成功页面</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<link href="<%=request.getContextPath()%>/office/survery/survey.css" rel="stylesheet" type="text/css"/>
</head>
<script language=javascript src='<%=request.getContextPath()%>/resource/js/office.js'></script>
<%
  boolean flag = RenderKitUtils.isMobile();   //是否手机表单
  String parentId = request.getParameter("parentId");    //所在栏目编码
%>	
<script type="text/javascript">
	window.onload=function(){
		debugger;
		var flag = <%=flag%>;
		if(flag){   //是手机表单
			var parentId = "<%=parentId%>";
			top.location.href = '<%=request.getContextPath() %>/mobile/survery-list.jsp?type=survery&parentId='+parentId+'&is_mobile_request=true';
		}else{
			window.close();
		}
	}
</script>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />

<script>
 var Mform0=isc.MatrixForm.create({
 				ID:"Mform0",
 				name:"Mform0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  </script>
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/investigation/investigation_saveInvestigationQuestion.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	

</form>
</body>
</html>
