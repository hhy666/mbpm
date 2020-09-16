<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>选择迁移代码位置</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>
<SCRIPT>var webContextPath = "<%=path %>";</SCRIPT>
<script type="text/javascript">
  $(function() {
  	  $("#button001").click(function(){
          Matrix.closeLayerWindow();
      });
      $("#button002").click(function(){
          var selecttree = $('#container').jstree().get_selected(true);
	      if(selecttree!=null&&selecttree.length>0){
	          var data={};
		      var node = $('#container').jstree().get_selected(true)[0]; 
			  var names = node.text;  
		      var ids = node.id;
		      if(ids=='root'){
		    	  layer.alert("请选择子目录！",{icon: 2});//icon1 对勾 2x
	              return false;
		      }
    	      data["ids"]=ids;
              data["names"]=names;
       		  data["oldUuid"]="${param.oldUuid}";
       		  data["parentNodeId"]="${param.parentNodeId}";
              Matrix.closeLayerWindow(data);
	      }else{
	          layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
              return false;
	      }
      });
   });
  </script>
  
<body>
  <style>
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
 </style>
  <table style="width:100%;height:100%;">
	  <tr>
		  <td style="width:100%;height:85%;    padding-bottom: 32px;">
		  	<div id="container" style="background:#fff;  font-size: 12px;height:100%;;overflow:auto;"></div>
		  	
				<script type="text/javascript">
					$(document).ready(function() {
						var tree=	$('#container').jstree({
							'core' : {
								'multiple' : false,
								'dblclick_toggle': false,
			    				'data' : {
									"url" : "<%=path%>/code/code_getCodeTree.action?oldUuid=${param.oldUuid}&parentNodeId=${param.parentNodeId}",
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
						
							'expand_selected_onload' : true, //选中项蓝色底显示  
		                	"checkbox": {
		                    	"keep_selected_style": true,//是否默认选中
		                    	"three_state": false,//父子级别级联选择
		                    	"tie_selection": true
		                	},
		                	"themes": { "theme": "default", "dots": false, "icons": false },  
		            		"plugins" : [ "themes", "json_data", "checkbox","crrm"]  ,
							'plugins' : ['contextmenu', "json_data"],
							'contextmenu' : false
						});
		
		      			$('#container').on('dblclick.jstree', function(e, datas) {
							var selecttree = $('#container').jstree().get_selected(true);
			        		if(selecttree!=null&&selecttree.length>0){
				                 var node = $('#container').jstree().get_selected(true)[0]; 
						         var name = node.text;  
				                 var id = node.id;
				                 var data = {};
				                 data["ids"]=id;
				                 data["names"]=name;
				                 data["oldUuid"]="${param.oldUuid}";
				                 data["parentNodeId"]="${param.parentNodeId}";
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
		  	</td>
	  </tr>
	  
	  <tr>
	  	<td class="cmdLayout">
	  		<button id="button002" class="x-btn ok-btn " type="button">确定</button>
	    	<button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button">取消</button>
		</td>
	  </tr>
  </table>
</body>
</html>