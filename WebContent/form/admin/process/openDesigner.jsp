<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://huachuangpower.com/tags-mbpm" prefix="mbpm"%>
<%@ page import="com.matrix.client.*,
    com.matrix.api.*,
    com.matrix.api.template.process.ProcessTemplate,
    com.matrix.api.identity.*"%>

<%@page import="com.matrix.api.instance.task.Task;"%>
<html>
<head>
<link href="css/monitor.css" rel="stylesheet" type="text/css">
	<link href="css/matrixProcessMonitor.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/matrixProcessMonitor.js"></script>
	<title>流程定制</title>

</head>

<body>
	<%
	 MFExecutionService service = (MFExecutionService) session.getAttribute(ClientConstants.EXECUTION_SERVICE);
     int serverPort =  request.getServerPort();
		try{
			String ptid = request.getParameter("ptid");
			String pdid = request.getParameter("pdid");
			String adid = request.getParameter("adid");
			String processType = request.getParameter("processType");
			String sessionId = service.getSessionId();
			String serverIp = request.getServerName();
			String userId = service.getMFUser().getUserId();
			if(ptid == null || ptid.trim().length()==0){
				ProcessTemplate procTmpl= service.getTemplateService().getLatestProcessTemplateByDID(pdid);
				ptid = procTmpl.getPTID();
			}
            String url = request.getContextPath()+"/form/admin/process/flex/MatrixDesigner.jsp?mode=custom&serverIp="+serverIp+"&contextPath=moffice&sessionId="+sessionId+"&userId="+userId+"&serverPort="+serverPort+"&processType="+processType;
			url = url+"&pkgTid="+ptid+"&adid="+adid;
			System.out.println("url22 is:"+url);
			out.println("url22 is:"+url);

			response.sendRedirect(url);
		}catch(Exception e){
			e.printStackTrace();
		}
		    
	%>

</body>
</html>


