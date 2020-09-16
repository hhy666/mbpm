<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<script>var webContextPath="<%=path%>";</script>
    <base href="<%=basePath%>">
    <title>单选角色页面</title>
    <link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
	<link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path %>/css/themes/default/style.min.css" />
    <link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
	
	<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<script src="<%=path %>/resource/html5/js/bootstrap.min.js"></script>
	<script src="<%=path %>/resource/html5/js/jstree.min.js"></script>
	<script src="<%=path %>/resource/html5/js/layer.min.js"></script>
	<script src='<%=path %>/resource/html5/js/matrix_runtime.js'></script>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
	<script src="<%=path %>/resource/html5/js/demo.js"></script>
    
    <style type="text/css">
     body, ul{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	 }
	 div, ul{
		box-sizing: border-box;
	 }
   	 .footer{
		vertical-align:middle;
		background: #F8F8F8;
		border-top:1px solid #e5e5e5;
		color:#fff;width:100%;
		position: fixed;
		bottom: 0px;
		padding: 14px 15px 15px;
		margin-bottom: 0; 
		text-align: right;
	}
	.jstree-default .jstree-hovered{
		 background:none;
		 border-radius:0px;
     	 color: blue;
    	 text-decoration: underline;
 		 box-shadow:none
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
    	background: url("<%=path %>/office/html5/image/openfoldericon.png") no-repeat #fff;
        background-position: 50% 50%;
    	background-size: auto;
	}
	.jstree-default .jstree-node-offline {
    	background: url("<%=path %>/office/html5/image/foldericon.png") no-repeat #fff;
       	background-position: 50% 50%;
    	background-size: auto;
	} 
	::-webkit-scrollbar {    
	    width:4px;  
	    height:4px;   
	}  
    </style>
    <script type="text/javascript">
	  $(function() {
	  	  $("#cancel").click(function(){
	          Matrix.closeLayerWindow();
	      });
	      $("#confirm").click(function(){
	          var selecttree = $('#container').jstree().get_selected(true);
		      if(selecttree!=null&&selecttree.length>0){
		          var data={};
			      var node = $('#container').jstree().get_selected(true)[0]; 
				  var names = node.text;  
			      var ids = node.id;
			      if(node.id.toLowerCase()=="rolemgr"){
	                  layer.alert("请选择角色！",{icon: 2});
	                  return;
	              }
	    	      data["ids"]=ids;
	              data["names"]=names;
	              data["clientId"]="${param.clientId}";
	       		  data["id"]="${param.id}";
	              Matrix.closeLayerWindow(data);
		      }else{
		          layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
	              return false;
		      }
	      });
	      var tree=	$('#container').jstree({
				'core' : {
					'multiple' : false,
					'dblclick_toggle': false,
  					'data' : {
						"url" : webContextPath+"/select/SelectAction_getRoleTree.action",
						"data" : function(node) {
							return {
								"root" : node.id ==="#"?"0":node.id
							};
						},
						"dataType" : "json",
						"type":"post"
					},
					'themes' : {
						'icons' : true
					}
				},
				"plugins" : [ "themes", "json_data", "crrm","wholerow"],
				'contextmenu' : false
			});

			$('#container').on('dblclick.jstree', function(e, datas) {
				var selecttree = $('#container').jstree().get_selected(true);
      			if(selecttree!=null&&selecttree.length>0){
	                 var node = $('#container').jstree().get_selected(true)[0]; 
			         var name = node.text;  
	                 var id = node.id;
	                 if(id.toLowerCase()=="rolemgr"){
	                 	layer.alert("请选择角色！",{icon: 2});
	                 	return;
	                 }
	                 var data = {};
	                 data["ids"]=id;
	                 data["names"]=name;
	                 data["clientId"]="${param.clientId}";
		       		 data["id"]="${param.id}";
	                 Matrix.closeLayerWindow(data);
	            }
			});
			//展开时候图标设置
			$('#container').on('open_node.jstree', function(e, datas) {  
	   			var nodeId = datas.node.id; 
	   			$('#container').jstree(true).set_icon(nodeId, "jstree-node-online");
				// tree.set_icon(node,"jstree-node-offline");
			});
			    //收拢时候图标设置
			    $('#container').on('close_node.jstree', function(e, datas) {  
			     	var nodeId = datas.node.id; 
			     	$('#container').jstree(true).set_icon(nodeId, "jstree-node-offline");
			    	// tree.set_icon(node,"jstree-node-offline");
			});
	   });
	  </script>
</head>
<body>
 	<div style="position: absolute;height: 100%;width: 100%;overflow: hidden;">
 		<div id="container" style="height:calc(100% - 54px); width:100%;overflow: auto;background: #fff; font-size: 12px;">
  	    </div>
  	    <div class="cmdLayout">
			<button id="confirm" class="x-btn ok-btn" type="button">确定</button>
			<button id="cancel" class="x-btn cancel-btn" type="button" style="margin-left:5px;">取消</button>
		</div>
 	</div>
</body>
</html>
