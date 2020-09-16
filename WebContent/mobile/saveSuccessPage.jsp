<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>表单</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
		window.onload=function(){
			Matrix.closeWindow();
		}
		
		</script>
</head>
<script type="text/javascript">
   matrix.SERVER_PATH='<%=request.getContextPath() %>';
</script>	

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 				ID:"MForm0",
 				name:"MForm0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden">
	<input name="iframewindowid" id='iframewindowid' type="hidden" value="Dialog001"/>

	

</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>


</div>

</body>
</html>