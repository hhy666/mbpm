<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>

<%@ page
	import="com.matrix.engine.foundation.domain.PkgTemplateKeyInfoVO,
		java.text.SimpleDateFormat,
		com.matrix.api.MFExecutionService,
   		com.matrix.api.template.PublicationStatus,
   		com.matrix.api.identity.*,
		com.matrix.client.TextUtils,
		com.matrix.form.admin.common.utils.*,
		com.matrix.engine.foundation.config.OrganizationTable,
		com.matrix.engine.foundation.config.MFSystemProperties,
		com.matrix.api.config.RunModeType,
		com.matrix.client.ClientConstants,
		java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style>
html{
	width:100%;
	height:100%;
}
body{
	width:100%;
	height:100%;
}
</style>
</head>
<%
	MFExecutionService mfes = (MFExecutionService)session.getAttribute(ClientConstants.EXECUTION_SERVICE);
	
	// 获得产品模式
	RunModeType modeType = mfes.getMFConfig().getRunModeType();
	boolean isProductMode = false;
	if(modeType.getValue()==RunModeType.PRODUCT_TYPE){
		isProductMode = true;
	}
	MFUser user = mfes.getMFUser();
	String userId = user.getUserId();
	int releasedType = PublicationStatus.RELEASED_TYPE;
	//String processType = request.getParameter("processType");
	String processId = request.getParameter("processId");
	String parentNodeId = request.getParameter("parentNodeId");
	
	boolean isAdmin = CommonUtil.isAdmin(mfes);
	
	// 获得设计器所需要的其他参数
	String sessionId = mfes.getSessionId();
	OrganizationTable orgTable = MFSystemProperties.getInstance().getOrganizationTable();
	String orgId = orgTable.getDepParentIdDefault();
	String roleRootId = orgTable.getRoleParentIdDefault();
	boolean isTreeType = orgTable.getRoleIsTreeFlag();
	String roleViewType = "grid"; 
	if(isTreeType)
		 roleViewType = "tree"; 
	String contextPath = request.getContextPath().substring(1);
		//String serverIp = request.getLocalAddr();
	//String url = request.getRequestURL().toString();
	String serverIp = request.getServerName();
	int serverPort = request.getServerPort();
	String returnUrl = "form/admin/process/mainProcess.jsp";//获得客户端发送请求的完整url
	
	String isScene = request.getParameter("isScene");//是否为优化阶段或者场景进入
	String fromTmplList = request.getParameter("fromTmplList");//是否从列表进入
	//如果从场景进入无退出
	if((!"true".equalsIgnoreCase(fromTmplList)) && "true".equalsIgnoreCase(isScene)){
		returnUrl = null;
	}
	
	boolean isZR = com.matrix.form.util.CommonUtil.isZR();
	if(isZR){
		isScene = null;
	}
	
	String pkgTid = request.getParameter("pkgTid");
	if(pkgTid==null || pkgTid.trim().length()==0){
		Object obj = request.getAttribute("pkgTid");
		if(obj!=null){
			pkgTid = obj.toString();
		}
	}
	//String mode = request.getParameter("mode");
	String mode = CommonUtil.getModeOfProcess();
	
	//String returnUrl = request.getParameter("returnUrl");
	String processTmplId = request.getParameter("processTmplId");
	//String parentNodeId = request.getParameter("parentNodeId");
	//String sessionId = request.getParameter("sessionId");
	//String orgId = request.getParameter("orgId");
	//String roleRootId = request.getParameter("roleRootId");
	//String roleViewType = request.getParameter("roleViewType");
	//String contextPath = request.getContextPath();
	//if(contextPath!=null && contextPath.startsWith("/")){
	//    contextPath = contextPath.substring(1);
	//}
	//String serverIp = request.getParameter("serverIp");
	//String userId = request.getParameter("userId");
	String simulationType = request.getParameter("simulationType");
	//int serverPort = request.getServerPort();
	String piid = request.getParameter("piid");
	String processType = (String)request.getAttribute("processType");
	StringBuffer sb = new StringBuffer();
	if(serverIp!=null && serverIp.trim().length()>0){
		sb.append("&serverIp=" + serverIp);
	}
	if(serverPort!=0 && serverPort!=-1){
		sb.append("&serverPort=" + serverPort);
	}
	if(contextPath!=null && contextPath.trim().length()>0){
		sb.append("&contextPath=" + contextPath);
	}
	if(returnUrl!=null && returnUrl.trim().length()>0){
		sb.append("&returnUrl=" + returnUrl);
	}
	if(sessionId!=null && sessionId.trim().length()>0){
		sb.append("&sessionId=" + sessionId);
	}
	if(orgId!=null && orgId.trim().length()>0){
		sb.append("&orgId=" + orgId);
	}
	if(userId!=null && userId.trim().length()>0){
		sb.append("&userId=" + userId);
	}
	if(roleRootId!=null && roleRootId.trim().length()>0){
		sb.append("&roleRootId=" + roleRootId);
	}
	if(roleViewType!=null && roleViewType.trim().length()>0){
		sb.append("&roleViewType=" + roleViewType);
	}
	if(processTmplId!=null && processTmplId.trim().length()>0){
		sb.append("&processTmplId=" + processTmplId);
	}
	if(parentNodeId!=null && parentNodeId.trim().length()>0){
		sb.append("&parentNodeId=" + parentNodeId);
	}
	if(pkgTid!=null && pkgTid.trim().length()>0){
		sb.append("&pkgTid=" + pkgTid);
	}
	if(mode!=null && mode.trim().length()>0){
		sb.append("&mode="+mode);
	}
	if(simulationType!=null && simulationType.trim().length()>0){
		sb.append("&simulationType="+simulationType);
	}
	if(piid!=null && piid.trim().length()>0){
		sb.append("&piid="+piid);
	}
	if(isScene!=null && isScene.trim().length()>0){
		sb.append("&isScene="+isScene);
	}
	if(processType!=null && processType.trim().length()>0){
		sb.append("&processType="+processType);
	}
	System.out.println("***************** Designer params start **************************");
	System.out.println("params:::"+sb.toString());
	System.out.println("***************** Designer params end **************************");
	String url = request.getContextPath()+"/form/admin/process/flex/MatrixDesigner.jsp?&" + sb.toString();
	System.out.println("url is:"+url);
%>
<script>
    
	window.location.href = "<%=url%>";
</script>
<body>
	<input type="hidden" name="processType" id="processType" value="${param.processType }"/>
<!-- 
	<iframe id="designerFrame" src="<%=url %>" frameborder=0 style="height:100%;width:100%;" height="100%" width="100%"></iframe>
 --> 
</body>
</html>