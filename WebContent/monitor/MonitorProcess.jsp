<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://huachuangpower.com/tags-mbpm" prefix="mbpm"%>
<%@ page import="com.matrix.client.ClientConstants,
    com.matrix.api.MFExecutionService,
    com.matrix.api.identity.MFUser
    "%>
<%
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
%>
<html>
<head>
	<link href="css/matrixProcessMonitor.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/matrixProcessMonitor.js"></script>
    <jsp:include page="/form/admin/common/resource.jsp" />
	<title>查看实例图形</title>
	<!-- 处理监控数据 -->
	<%
		//从Session中取到流程服务对象
	    MFExecutionService service = (MFExecutionService) session.getAttribute(ClientConstants.EXECUTION_SERVICE);

		String piid = request.getParameter("piid"); // 流程实例编码
		
		// 流程播放需要参数其他参数
	    String params = "";
		MFUser user = service.getMFUser();
		String userId = user.getUserId();
		String sessionId = service.getSessionId();
	    String contextPath = request.getContextPath();
		if(contextPath!=null && contextPath.startsWith("/")){
	    	contextPath = contextPath.substring(1);
	    }
	    //String serverIp = request.getLocalAddr();
		String url = request.getRequestURL().toString();
		//String serverIp = url.substring(url.indexOf("//")+2,url.indexOf(":",url.indexOf("//"))); 
		String serverIp = request.getServerName();
	    int serverPort = request.getServerPort();
	    params +="serverIp="+serverIp;
	    params +="&contextPath="+contextPath;
	    params +="&sessionId="+sessionId;
	    params +="&userId="+userId;
	    params +="&serverPort="+serverPort;
	    params +="&simulationType=1";
		    
	%>
	<script language="javascript">
		// 播放流程实例
		function videoProcess(){
		    var piid = "<%=piid%>";
		    if(piid==null || piid.length==0){
		    	return false;
		    }
		    var params = "<%=params%>";
		    params = params + "&piid="+piid;
			var url = "<%=request.getContextPath()%>/monitor/flex/MatrixDesigner.jsp?"+params;
			var iHeight = 500;
			var iWidth = 700;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  		var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
	  		var property = "toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, status=no, width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop;
			window.open( url, "播放流程实例", property);
		}
	</script>
	
</head>

<body>
	<table class="monitor_table">
		<tr>
			<td class="monitor_content">
					<mbpm:monitor id="monitor1" userId="<%=userId %>" piid="${param.piid}" type="${param.type}"  executionService='ExecutionService' closeIcon="images/close.gif"/>
			</td>
		</tr>
		<tr>
			<td class="monitor_toolbar">
				<INPUT class="buttonbg" style="width: 40px; height: 23px;"
					onclick="videoProcess();" type=button value="播放" name="video">&nbsp;&nbsp;
				<INPUT class="buttonbg" style="width: 40px; height: 23px;"
					onclick="parent.Matrix.closeWindow();" type=button value="关闭" name="close">
			</td>
		</tr>
	</table>
	<br>

</body>
</html>
