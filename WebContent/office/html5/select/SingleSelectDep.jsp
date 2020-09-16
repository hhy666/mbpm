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
    <title>单选部门页面</title>
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
	.select-member li {
	    cursor: pointer;
	    margin: 0 10px 0 10px;
	    white-space: nowrap;
	    line-height: 24px;
	    list-style-type: none
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
	.udSelect{
			border-radius: 0px;
	}
    </style>
    <script type="text/javascript">
	  $(function() {
	  	  $("#cancel").click(function(){
	          Matrix.closeLayerWindow();
	      });
	      $("#confirm").click(function(){
	    	  if(document.getElementById('container').style.display == 'none'){
	    		  	var selectLi = $("#depSelect").children("li.changeColor");
	    		    if(selectLi.length>0){
	    		    	var names = selectLi.text(); 
	 	                var ids = selectLi.attr('id');
	 	                var data = {};
	 	                data["ids"]=ids;
	 		            data["names"]=names;
	 		            data["clientId"]="${param.clientId}";
	 		       		data["id"]="${param.id}";
	 	                Matrix.closeLayerWindow(data);    
	    		    }else{
				        layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
			            return false;
				    }	    		     
	    	  }else{
	    		  var selecttree = $('#container').jstree().get_selected(true);
			      if(selecttree!=null&&selecttree.length>0){
			          var data={};
				      var node = $('#container').jstree().get_selected(true)[0]; 
					  var names = node.text;  
				      var ids = node.id;
		    	      data["ids"]=ids;
		              data["names"]=names;
		              data["clientId"]="${param.clientId}";
		       		  data["id"]="${param.id}";
		              Matrix.closeLayerWindow(data);
			      }else{
			          layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
		              return false;
			      }
	    	  }          
	      });
	      var tree=	$('#container').jstree({
				'core' : {
					'multiple' : false,
	  				'data' : {
						"url" : webContextPath+"/select/SelectAction_getDepTree.action",
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
			
	      	//双击
			$('#container').on('dblclick.jstree', function(e, datas) {
				var selecttree = $('#container').jstree().get_selected(true);
      			if(selecttree!=null&&selecttree.length>0){
	                 var node = $('#container').jstree().get_selected(true)[0]; 
			         var names = node.text;  
	                 var ids = node.id;
	                 var data = {};
	                 data["ids"]=ids;
		             data["names"]=names;
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
	  
	  
		//根据部门名称搜索
		function searchDept(){ 	
			Matrix.showMask2();
			var depName = $('#depKeyWord').val();
			if(depName == ''){
				Matrix.hideMask2();
				$('#container').css('display','block');
				$('#depResult').css('display','none');
				return;
			}
			$('#container').css('display','none');
			$('#depResult').css('display','block');
			
			$.ajax({  
	            url: "<%=path %>/select/SelectAction_getAllDept.action",  
	            type: "post",  
	            dataType: "json",  
	            data: {"depName" : depName}, 
	            async:false, 
	            success: function (datass) {
	            if(datass!=null&&datass!=""){
	                var arr = datass.depData;  
	                if(arr!=null&&arr.length>0){
	                     //有部门数据
	                    var listring = "";
	                    for (var i in arr) {  
	                        var jsonObj =arr[i];  	                     
	                        listring += "<li id=\"" + jsonObj.depId + "\" >" + jsonObj.depName + "</li>";                      
	                    }                    
	                    $("#depSelect").html(listring);  
	                    
	                    $("#depSelect").on("click","li",function(){         			   
	         	            $(this).addClass("changeColor").siblings().removeClass("changeColor");	         	                	            
	                    });
	                    
	                    $("#depSelect").on("dblclick","li",function(){    
	                    	var names = $("#depSelect").children("li.changeColor").text(); 
		   	                var ids = $("#depSelect").children("li.changeColor").attr('id');
		   	                var data = {};
		   	                data["ids"]=ids;
		   		            data["names"]=names;
		   		            data["clientId"]="${param.clientId}";
		   		       		data["id"]="${param.id}";
		   	                Matrix.closeLayerWindow(data);              	
	                    });
	           
	                }else{
	                    //无部门数据
	                     $("#depSelect").html("");
	                } 
	                Matrix.hideMask2();
	            }
	            },  
	            error: function (msg) {  
	            	Matrix.hideMask2();
	                layer.msg("出错了！");  
	            }  
      		}); 
		}
	  </script>
</head>
<body>
	<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
 	<div style="position: absolute;height: 100%;width: 100%;overflow: hidden;">
 		<div id="depSearch" class="input-group">							
			<input id="depKeyWord" name="depKeyWord" type="text" class="form-control" style="height:30px;" onkeydown="if(event.keyCode == 13)searchDept()" placeholder="请输入部门名称">
       		 <span class="input-group-addon addon-udSelect udSelect" onclick="searchDept();"><i class="fa fa-search"></i></span>
         </div>
 		<div id="container" style="height:calc(100% - 86px); width:100%;overflow: auto;background: #fff; font-size: 12px;">
  	    </div>
  	    <div id="depResult" class="select-tree" style="display: none">
			<ul class="select-member" id="depSelect"></ul>        
		</div>
  	    <div class="cmdLayout">
			<button id="confirm" class="x-btn ok-btn" type="button">确定</button>
			<button id="cancel" class="x-btn cancel-btn" type="button" style="margin-left:5px;">取消</button>
		</div>
 	</div>
</body>
</html>
