<!DOCTYPE html>
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

 <link href="<%=request.getContextPath()%>/form/admin/main/css/bootstrap.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/form/admin/main/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/form/admin/main/css/animate.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/form/admin/main/css/style.min.css" rel="stylesheet"></head>
    <link href="<%=request.getContextPath()%>/form/admin/main/css/menu.css" rel="stylesheet"></head>
    
<title>Matrix BPM Client</title>

<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>


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

<body class="fixed-sidebar full-height-layout gray-bg  pace-done" style="overflow:hidden"><div class="pace  pace-inactive"><div class="pace-progress" data-progress-text="100%" data-progress="99" style="width: 100%;">
  <div class="pace-progress-inner"></div>
</div>
<div class="pace-activity"></div></div>
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="slimScrollDiv" style="position: relative; width: auto; height: 100%;"><div class="sidebar-collapse" style="width: auto; height: 100%;">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
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
                    
                    <%

	for(Iterator iter = list.iterator(); iter.hasNext(); ){
		DataObject data = (DataObject)iter.next();
//		out.println("id:"+data.getString("functionId")+",name:"+);
		
		
%>
                    <li>
                        <a href="">
                           
							<img src="<%=request.getContextPath()%>/form/admin/main/pay.png" style="widht:10px;height:10px;padding-right:20px;">
                            <span class="nav-label"><%=data.getString("functionName")%></span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level collapse">
                        
                        <%

		List children = data.getList("children");
		for(Iterator iter2 = children.iterator(); iter2.hasNext(); ){
			DataObject data2 = (DataObject)iter2.next();
			//out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));
%>
                            <li>
                                <a class="J_menuItem" href="" data-index="0"><%=data2.getString("functionName") %></a>
                            </li>
<%
			
		}
		
%>

                        </ul>

                    </li>
<%} %>                  
                 

                </ul>
            </div><div class="slimScrollBar" style="width: 4px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 799px; background: rgb(0, 0, 0);"></div><div class="slimScrollRail" style="width: 4px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; opacity: 0.9; z-index: 90; right: 1px; background: rgb(51, 51, 51);"></div></div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href=""><i class="fa fa-bars"></i> </a>
                        <form role="search" class="navbar-form-custom" method="post" action="http://www.zi-han.net/theme/hplus/search_results.html">
                            <div class="form-group">
                                <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">
                            </div>
                        </form>
                    </div>
                    <ul class="nav navbar-top-links navbar-right">
                       
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="http://www.zi-han.net/theme/hplus/#">
                                <i class="fa fa-bell"></i> <span class="label label-primary">8</span>
                            </a>
                           
                        </li>
                        <li class="hidden-xs">
                            <a href="http://www.zi-han.net/theme/hplus/index_v1.html" class="J_menuItem" data-index="0"><i class="fa fa-cart-arrow-down"></i> 购买</a>
                        </li>
                        <li class="dropdown hidden-xs">
                            <a class="right-sidebar-toggle" aria-expanded="false">
                                <i class="fa fa-tasks"></i> 主题
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" style="overflow:hidden;" name="iframe0" width="100%" height="100%" src="<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action" frameborder="0" data-id="index_v1.html" seamless=""></iframe>
            </div>
            <div class="footer">
                <div class="pull-right">© 2004-2015 <a href="" target="_blank">华创动力科技</a>
                </div>
            </div>
        </div>
        <!--右侧部分结束-->
 <script src="<%=request.getContextPath()%>/form/admin/main/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/form/admin/main/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/form/admin/main/js/jquery.metisMenu.js"></script>
    <script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
    <script src="<%=request.getContextPath()%>/form/admin/main/js/hplus.min.js"></script>
    <script src="<%=request.getContextPath()%>/form/admin/main/js/jquery.slimscroll.min.js"></script>
</body>

</html>