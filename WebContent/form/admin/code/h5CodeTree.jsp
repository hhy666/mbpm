<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>代码管理树</title>
<style type="text/css">
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
	var nodeAll;
	function refreshRoot(){
		var curTree = jQuery.jstree.reference('#container');
		var node = curTree.get_node('root');
		curTree.refresh_node(node);
	}
	
	function refreshTree(){
    	$('#container').jstree(true).refresh_node(nodeAll);
	}
	
	function parentRefreshTree(){
		//$('#container').data('jstree', false).empty();
		var paentNode =$('#container').jstree(true).get_parent(nodeAll);
    	$('#container').jstree(true).refresh_node(paentNode);
    	//$('#container').jstree.deselect_all(true);

	}
	function modifyCodeNode(target){
		node = target;
	    var type = target.original.type;
	    var uuid = target.original.id;
	    var mId = target.original.mId;
	    if(type==0){//根节点 更新后刷新自身
	    	return false;
	    }else if(type==1){//子目录
	    	var src = '<%=path%>/code/code_loadUpdateCodePage.action?uuid='+uuid+'&parentNodeId='+mId+'&oType=update&type='+type;
			document.getElementById('InfoIframe').src =	src;
		}else if(type==2){//基本类型
			var src = '<%=path%>/code/code_loadUpdateBasicMainPage.action?entityId='+uuid+'&parentNodeId='+mId+'&type='+type;
			document.getElementById('InfoIframe').src =	src;
	    }else if(type==3){//自定义类型
	    	var src = '<%=path%>/code/code_loadUpdateCustomMainPage.action?uuid='+uuid+'&parentNodeId='+mId+'&type='+type;
			document.getElementById('InfoIframe').src =	src;
	    }
	    
	}
	
	//右键添加子节点
	function addCodeNode(target, type){	
		var src = "<%=path%>/code/code_loadAddCodePage.action?parentUUID="+target.original.id+"&oType=add&type="+type;
		document.getElementById('InfoIframe').src =	src;
	}
	
	function deleteCodeNode(target){
		var src = "<%=path%>/code/code_deleteCode.action?entityId="+target.original.id+"&type="+target.original.type+"&oType=del";
		document.getElementById('InfoIframe').src =	src;
	}
	
	//迁移时弹出选择窗口
	 function transferBasic(target){
		 var oldUuid = target.original.id;
		 var parentNodeId = target.parent;
		 layer.open({
		    	id:'layer01',
				type : 2,
				title : ['选择迁移位置'],
				area : [ '40%', '80%' ],
				content : "<%=path%>/office/html5/select/SelectCode.jsp?iframewindowid=Transfer&parentNodeId="+parentNodeId+"&oldUuid="+oldUuid
		});
    }
	
	//迁移回调
     function onTransferClose(data,parentId){
    	 if(data!=null){
    		 var uuid = data.ids;
    		 var oldUuid = data.oldUuid;
    		 var parentNodeId = data.parentNodeId;
    		 
    		 var url = "<%=request.getContextPath()%>/code/code_remove.action?uuid="+uuid+"&oldUuid="+oldUuid;
    		 Matrix.sendRequest(url,null,function(data){
    			 var callbackStr = data.data;
    			 var callbackJson = isc.JSON.decode(callbackStr);
    			 if(callbackJson.result=='true'){ 
    				var curTree = jQuery.jstree.reference("#container");
    				var node = curTree.get_node("root");
					$('#container').jstree(true).refresh_node(node);
    				Matrix.info("迁移成功");
    			 }
    	   })
    	 }
     }
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<div id="HorizontalContainer001" class="page page-full animation-fade page-data-tables" style="height:100%;">
		    <div id="HorizontalContainer001Panel1" class="page-aside" style="width:18%;height: 100%;overflow:hidden;">
		    	<div style="background-color:rgb(248, 248, 248);width:100%;height:30px;">
					<div style="height: 30px;padding: 7px;font-weight:bold;padding-left:30px;">目录树</div>
				</div>
				<div style="width:100%;height:calc(100% - 30px);overflow:auto">
			    	<table style="width:100%;height:100%;;margin:0px;">
			    		<tr>
							<td>
								<div id="container" style="background: #fff; font-size: 12px; height: 100%;">
									<script type="text/javascript">
										$(document).ready(function(){
											var tree = $('#container').jstree({
												'core':{
													'multiple':false,
													'data':{
														'url': '<%=path %>/code/code_h5LoadCodeTree.action',
														'data':function(node){
															return {
																"root" : node.id ==="#"?"root":node.id,
															};
														},
														'dataType' : 'json',
														'type':'post'
													},
												},
												"plugins" : ["themes", "json_data","crrm","contextmenu","wholerow"],
												"contextmenu" :{
													"items" : onType
												}
											});
									
										
											//单击流程	
							    			$("#container").on("select_node.jstree",function(e, data){
							    				var node = data.node;
							    				var uuid = node.original.id;
							    				var mId = node.original.mId;
							    				var type = node.original.type;
												var parentNodeId = $('#container').jstree('get_parent',node.id);//刷新用
												var parentNode =$('#container').jstree(true).get_parent(node);
												nodeAll = parentNode;
												if(uuid){
													modifyCodeNode(node);
												}
							    			}).jstree();
											
							    			//展开时候图标设置
							    			$('#container').on('open_node.jstree', function(e, data) {  
							    	   			var nodeId = data.node.id; 
							    	   			$('#container').jstree(true).set_icon(nodeId, "jstree-node-online");
							    				// tree.set_icon(node,"jstree-node-offline");
							    			});
							    			//收拢时候图标设置
							    			$('#container').on('close_node.jstree', function(e, data) {  
							    			    var nodeId = data.node.id; 
							    			    $('#container').jstree(true).set_icon(nodeId, "jstree-node-offline");
							    			    // tree.set_icon(node,"jstree-node-offline");
							    			});
										});
									</script>
								</div>
							</td>
						</tr>
			    	</table> 
			    </div>	
		    	<script type="text/javascript">
		    		var onType = function(data){
		    			//根节点右键菜单
		    			var typeRoot = {
		    				"create":null,  
		    				"rename":null,  
		    				"ccp":null,
		    				"newsubdirectory":{
		    					"label":"新建子目录",
		    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
		    					"action":function(data){
		    						var node = $('#container').jstree('get_node',data.reference[0]);
		    						nodeAll = node;
		    						addCodeNode(node,1);
		    					}
		    				},
		    				"refresh":{
		    					"label":"刷新",
		    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/refresh.png", 
		    					"action":function(data){
		    						var node = $('#container').jstree('get_node',data.reference[0]);
		    						$('#container').jstree(true).refresh_node(node);
		    					}
		    				}
		    			};
		    			
		    			
		    			var typeChild = {
			    				"create":null,  
			    				"rename":null,  
			    				"ccp":null,
			    				"newsubdirectory":{
			    					"label":"新建子目录",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						nodeAll = node;
			    						addCodeNode(node,1);
			    					}
			    				},
			    				"newBasic":{
			    					"label":"新建基本类型",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						nodeAll = node;
			    						addCodeNode(node,2);
			    					}
			    				},
			    				"newCustom":{
			    					"label":"新建自定义类型",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						nodeAll = node;
			    						addCodeNode(node,3);
			    					}
			    				},
			    				"refresh":{
			    					"label":"刷新",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/refresh.png", 
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						$('#container').jstree(true).refresh_node(node);
			    					}
			    				},
			    				"remove":{  
			    					"label":"删除",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/delete.png", 
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
										var parentNode =$('#container').jstree(true).get_parent(node);
			    						nodeAll = parentNode;
			    						deleteCodeNode(node);
			    					}
			    				},
			    				"moveup":{  
			    					"label":"上移",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_up.png",
			    					"action":function(data){
			    						var parentId = $('#container').jstree('get_parent',data.reference[0]);
			    						var prevdom = $('#container').jstree('get_prev_dom',data.reference[0],true).context.id;
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						$.post(
			    								"<%=path%>/code/code_moveUpBasicItem.action",
			    								{ 
			    									data:"{'entityId':"+prevdom+",'preEntityId':"+node.id+"}"
			    								},
			    								function(){
			    									$('#container').jstree(true).refresh_node(parentId);
			    								}
			    							);
			    					}
			    				},
			    				"movedown":{  
			    					"label":"下移",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_down.png",
			    					"action":function(data){
			    						var parentId = $('#container').jstree('get_parent',data.reference[0]);
			    						var nextdom = $('#container').jstree('get_next_dom',data.reference[0],true).context.id;
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						$.post(
			    								"<%=path%>/code/code_moveDownBasicItem.action",
			    								{ 
			    									data:"{'entityId':"+node.id+",'afterEntityId':"+nextdom+"}"
			    								},
			    								function(){
			    									$('#container').jstree(true).refresh_node(parentId);
			    								}
			    							);
			    					}
			    				}
			    			};
		    			
		    			var typeBasic = {
			    				"create":null,  
			    				"rename":null,  
			    				"ccp":null,
			    				"refresh":{
			    					"label":"刷新",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/refresh.png", 
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						$('#container').jstree(true).refresh_node(node);
			    					}
			    				},
			    				"remove":{  
			    					"label":"删除",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/delete.png", 
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						var parentNode =$('#container').jstree(true).get_parent(node);
			    						nodeAll = parentNode;
			    						deleteCodeNode(node);
			    					}
			    				},
			    				"moveup":{  
			    					"label":"上移",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_up.png",
			    					"action":function(data){
			    						var parentId = $('#container').jstree('get_parent',data.reference[0]);
			    						var prevdom = $('#container').jstree('get_prev_dom',data.reference[0],true).context.id;
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						$.post(
			    								"<%=path%>/code/code_moveUpBasicItem.action",
			    								{ 
			    									data:"{'entityId':"+prevdom+",'preEntityId':"+node.id+"}"
			    								},
			    								function(){
			    									$('#container').jstree(true).refresh_node(parentId);
			    								}
			    							);
			    					}
			    				},
			    				"movedown":{  
			    					"label":"下移",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_down.png",
			    					"action":function(data){
			    						var parentId = $('#container').jstree('get_parent',data.reference[0]);
			    						var nextdom = $('#container').jstree('get_next_dom',data.reference[0],true).context.id;
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						$.post(
			    								"<%=path%>/code/code_moveDownBasicItem.action",
			    								{ 
			    									data:"{'entityId':"+node.id+",'afterEntityId':"+nextdom+"}"
			    								},
			    								function(){
			    									$('#container').jstree(true).refresh_node(parentId);
			    								}
			    							);
			    					}
			    				},
			    				"transfer":{
			    					"label":"迁移",
			    					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/undo.png",
			    					"action":function(data){
			    						var node = $('#container').jstree('get_node',data.reference[0]);
			    						var parentId = $('#container').jstree('get_parent',data.reference[0]);
			    						transferBasic(node,parentId);
			    					}
			    				}
			    			};
		    			
		    			var type = data.original.type;
		    			var result;
		    			if(type==0){
		    				result = typeRoot;
		    			}else if(type==1){
		    				result = typeChild;
		    			}else if(type==2||type==3){
		    				result = typeBasic;
		    			}
		    			return result;
		    		}
		    		
		    		
		    		
		    	</script>
			</div>
		    <div id="HorizontalContainer001Panel2" class="page-main" style="width:calc(100% - 18%);overflow: hidden;margin-left: 18%;position: relative;">
		    	<!-- <div style="height: 100%;width: 20px;background: red;vertical-align: middle;display: inline;">
	    			<button id="button0001" type="button" onclick="openAndClose()" style="width: 100%;height:50px;">展开</button>
    			</div> -->
   				<iframe id="InfoIframe" style="width:100%;height:100%; " frameborder="0" src="<%=path%>/form/admin/logon/matrix/welcome.jsp" >
   				</iframe>
		    </div>
		</div>
	</form>
</body>
</html>