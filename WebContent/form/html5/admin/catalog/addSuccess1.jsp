<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>成功页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script src="<%=path%>/resource/html5/js/jquery.min.js"></script>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
  </head>
  
  <body>
    <script>
    	$(function(){
    		debugger;
    		if(window.parent.$('#container').length > 0){
	    		var nodeid = window.parent.$('#container').jstree(true).get_selected()[0];//当前节点id
	    		var newNode = '${toNewNode }';//新节点id
	    		if(newNode != ''){//是否刷新新节点
	    			window.parent.$('#container').jstree(true).refresh_node(newNode);
	    		}
	    		var refreshParent = '${refreshParent }';//是否刷新父节点
	    		if(refreshParent != ''){
	    			var parentId = window.parent.$('#container').jstree(true).get_parent(nodeid);
	    			window.parent.$('#container').jstree(true).refresh_node(parentId);
	    		}
	    		if(newNode == '' && refreshParent == ''){//仅刷新当前节点
		    		window.parent.$('#container').jstree(true).refresh_node(nodeid);
	    		}
    		}
    		var index = parent.layer.getFrameIndex(window.name);
    		parent.Matrix.success('操作成功！');
			parent.layer.close(index);
    	})
    </script>
  </body>
</html>
