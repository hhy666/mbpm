<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<jsp:include page="/form/admin/common/taglib.jsp" />
	<jsp:include page="/form/admin/common/resource.jsp" />
	<script type="text/javascript">
		window.onload = function(){	
			document.getElementById("formulaSetId").value = parent.document.getElementById("controlSet").value;
			document.myForm.submit();
		}
	</script>
  </head>
  
  <body>
  <jsp:include page="/form/admin/common/loading.jsp"/>
	<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto">
<script> 
var MForm0=isc.MatrixForm.create({
			ID:"MForm0",
			name:"MForm0",
			position:"absolute",
			action:"",
			fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]
		});</script>
    <form id="Form0" action="<%=request.getContextPath()%>/security/formSecurity_loadAdvancedSet.action?formUuid=${param.formUuid}" method="post" name="myForm">
    	<input name="formulaSetId" id="formulaSetId" type="hidden" />
    	<input name="setType" id="setType" type="hidden" /> <!-- 公式设置类型 -->
    	<input name="iframewindowid" id="iframewindowid" type="hidden" value="<%=request.getParameter("iframewindowid") %>" />
    	<input name="formUuid" id="formUuid" type="hidden" value="<%=request.getParameter("formUuid") %>" />
    </form>
    <script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>
  </body>
</html>
