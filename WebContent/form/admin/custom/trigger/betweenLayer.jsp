<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>

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
		debugger;
			document.getElementById('dataCopyStr').value = parent.document.getElementById("dataCopyStr").value;
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
    <form id="Form0" action="<%=request.getContextPath()%>/trigger/dataCopy_loadCopySet.action?targetFormId=${param.targetFormId}" method="post" name="myForm">
    	<input name="operateType" id="operateType" type="hidden" value = '<%=request.getParameter("operateType")%>'/>
    	<input name="optString" id="optString" type="hidden" value='<%=request.getParameter("optString")%>'/>
    	<input name="targetFormId" id="targetFormId" type="hidden" value = '<%=request.getParameter("targetFormId")%>' />
    	<input name="dataCopyStr" id="dataCopyStr" type="hidden" />
    	<input name="iframewindowid" id="iframewindowid" type="hidden" value="<%=request.getParameter("iframewindowid") %>" />
    </form>
    <script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>
  </body>
</html>
