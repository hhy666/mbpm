<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.api.MFExecutionService"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML><html><head><meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style>
			.jstree-default .jstree-hovered {
				background: none;
				border-radius: 0px;
				color: blue;
				text-decoration: underline;
				box-shadow: none
			}
			
			.jstree-default .jstree-clicked {
				background: #DDDDDD;
				border-radius: 0px;
				box-shadow: none;
			}
			
			.jstree-anchor {
				padding: 0 4px 0 0px;
			}
			
			.jstree-default .jstree-node-online {
				background: url("<%=path%>/office/html5/image/openfoldericon.png")
					no-repeat #fff;
				background-position: 50% 50%;
				background-size: auto;
			}
			
			.jstree-default .jstree-node-offline {
				background: url("<%=path%>/office/html5/image/foldericon.png") no-repeat
					#fff;
				background-position: 50% 50%;
				background-size: auto;
			}
		</style>
</head>
<body>
<div class="container-fluid" style="height:100%;">
	<div class="row" style="height:8%;margin-right: -15px;margin-left: -15px;"> 
		<img height="100%" width="100%" src="<%=request.getContextPath()%>/resource/images/top.png"> 
		<div  style=" position: absolute; z-index: 4; top:10px; right:15px; color: black; ">
		欢迎您，<%=((MFExecutionService)request.getSession().getAttribute("ExecutionService")).getMFUser().getUserName() %>
		</div >
		<div style=" position: absolute; z-index: 4; top:27px; right:15px;  " >
			<a href="<%=request.getContextPath() %>/logon/logon_logoff.action" style="color: red" >注销</a>
		</div>
	</div>
	<div class="row" style="height:92%;margin-right: -15px; margin-left: -15px; ">
		<div id="col1" class="col-lg-2 col-xs-2 col-sm-2 col-md-2	" style="height:100%; padding: 0px;border-right: inset;border-right-width: 1px;">
			<iframe id="catalogIframe" style="width:100%;height:100%;" frameborder="0" src="<%=request.getContextPath()%>/form/html5/admin/logon/matrix/html5Catalog.jsp" ></iframe>
		</div>
		<div class="col-lg-10 col-xs-10 col-sm-10 col-md-10" style="height:100%; padding:0px;">
			<iframe id="InfoIframe" style="width:100%;height:100%; " frameborder="0" src="<%=request.getContextPath()%>/form/admin/logon/matrix/welcome.jsp" ></iframe>
		</div>
	</div>
</div>
</body>
</html>
