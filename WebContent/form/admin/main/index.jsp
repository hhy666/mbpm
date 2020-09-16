<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="com.matrix.client.foundation.function.action.FunctionHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="commonj.sdo.*"%>

<html>


<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link
	href="<%=request.getContextPath()%>/form/admin/main/css/bootstrap.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/form/admin/main/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/form/admin/main/css/animate.min.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/form/admin/main/css/style.min.css"
	rel="stylesheet">
</head>
<link href="<%=request.getContextPath()%>/form/admin/main/css/menu.css"
	rel="stylesheet">
</head>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/reset.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/style.css" />
<title>Matrix BPM Client</title>

<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>
<script>

	function setContent(url){
	 	document.getElementById('iframe0').src = url;
	}
	
	function changePortlet(id){
		if(id=='dep'){
		 	document.getElementById('depcontent').style.background  = "#7abee1";
		 	document.getElementById('companycontent').style.background  = "#1f91cd";
		 	//document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action";
		}else{
		 	document.getElementById('depcontent').style.background  = "#1f91cd";
		 	document.getElementById('companycontent').style.background  = "#7abee1";
		 	//document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action";
		}
	}
</script>

<%
	FunctionHelper helper = new FunctionHelper();
	List list = helper.loadChildrenFunctionByCustom();

	/*for(Iterator iter = list.iterator(); iter.hasNext(); ){
		DataObject data = (DataObject)iter.next();
		out.println("id:"+data.getString("functionId")+",name:"+data.getString("functionName"));
		
		List children = data.getList("children");
		for(Iterator iter2 = children.iterator(); iter2.hasNext(); ){
			DataObject data2 = (DataObject)iter2.next();
			out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));
			
		}
	}
	 */
%>

<body class="fixed-sidebar full-height-layout pace-done"
	style="overflow: hidden; background-color: #fff;">
<div class="shouye-title">
<div class="logo"><img
	src="<%=request.getContextPath()%>/resource/images/logo.png"></div>
<div class="shouye-title-right">
<p><span id="depcontent"><img 
	src="<%=request.getContextPath()%>/resource/images/icon.png"><a
	href="javascript:changePortlet('dep')">部门空间</a></span> <span id="companycontent"><img
	
	src="<%=request.getContextPath()%>/resource/images/icon1.png"><a
	href="javascript:changePortlet('company')">公司空间</a></span></p>
<h2><img
	src="<%=request.getContextPath()%>/resource/images/user.png"> <span>${userName}</span>
</h2>
<div class="right0"><img
	src="<%=request.getContextPath()%>/resource/images/grid.png"></div>
</div>
</div>
<div class="pace  pace-inactive">
<div class="pace-progress" data-progress-text="100%" data-progress="99"
	style="width: 100%;">
<div class="pace-progress-inner"></div>
</div>
<div class="pace-activity"></div>
</div>
<div id="wrapper"><!--左侧导航开始--> <nav
	class="navbar-default navbar-static-side" role="navigation">
<div class="nav-close"><i class="fa fa-times-circle"></i></div>
<div class="slimScrollDiv"
	style="position: relative; width: auto; height: 100%;">
<div class="sidebar-collapse"
	style="width: auto; height: 100%; background-color: #01517B;">
<div class="bback" style="background-color: #096da0;"></div>
<ul class="nav" id="side-menu" style="background-color: #01517B;">
	<!--   <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span><img alt="image" class="img-circle" src="<%=request.getContextPath()%>/form/admin/main/profile_small.jpg"></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="http://www.zi-han.net/theme/hplus/#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">Beaut-zihan</strong></span>
                                <span class="text-muted text-xs block">超级管理员</span>
                                </span>
                            </a>
                           
                        </div>
                        <div class="logo-element">H+
                        </div>
                    </li>
                     -->
	<%
		for (Iterator iter = list.iterator(); iter.hasNext();) {
			DataObject data = (DataObject) iter.next();
			//		out.println("id:"+data.getString("functionId")+",name:"+);
	%>
	<li><a href=""
		style="margin-top: 0px; font-family: 黑体; font-weight: normal; font-size: 14px;">
	<img src="<%=request.getContextPath()%>/form/admin/main/mmenu.png"
		style="widht: 18px; height: 18px; padding-right: 10px;"><%=data.getString("functionName")%>
	<!-- <span class="fa arrow"></span> --> </a>
	<ul class="nav nav-second-level collapse">

		<%
			List children = data.getList("children");
				for (Iterator iter2 = children.iterator(); iter2.hasNext();) {
					DataObject data2 = (DataObject) iter2.next();
					//out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));
					String url = request.getContextPath() + "/"
							+ data2.getString("functionValue");
		%>
		<li style="font-family: 黑体; font-weight: normal; font-size: 12px;"><a
			class="J_menuItem" href="javascript:setContent('<%=url %>')"
			data-index="0"><%=data2.getString("functionName")%></a></li>
		<%
			}
		%>

	</ul>

	</li>
	<%
		}
	%>


</ul>
</div>
<div class="slimScrollBar"
	style="width: 4px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 799px; background: rgb(0, 0, 0);"></div>
<div class="slimScrollRail"
	style="width: 4px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; opacity: 0.9; z-index: 90; right: 1px; background: rgb(51, 51, 51);"></div>
</div>
</nav> <!--左侧导航结束--> <!--右侧部分开始-->
<div id="page-wrapper" class="gray-bg dashbard-1">


<div class="row J_mainContent" id="content-main"><iframe
	class="J_iframe" style="overflow: hidden;" id="iframe0" name="iframe0"
	width="100%" height="100%" src="" frameborder="0"
	data-id="index_v1.html" seamless=""></iframe></div>
<!--   <div class="footer">
                <div class="pull-right">© 2004-2015 <a href="" target="_blank">华创动力科技</a>
                </div>
            </div>
           --></div>
<!--右侧部分结束--> <script
	src="<%=request.getContextPath()%>/form/admin/main/js/jquery.min.js"></script>
<script
	src="<%=request.getContextPath()%>/form/admin/main/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/form/admin/main/js/jquery.metisMenu.js"></script>
<script 
	src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
<script
	src="<%=request.getContextPath()%>/form/admin/main/js/hplus.min.js"></script>
<script
	src="<%=request.getContextPath()%>/form/admin/main/js/jquery.slimscroll.min.js"></script>
</body>

</html>