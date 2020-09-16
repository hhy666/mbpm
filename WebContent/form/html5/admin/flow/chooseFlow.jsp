<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.api.MFExecutionService"%>
<%@ page import="com.matrix.form.api.MFormContext" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String urlPath = MFormContext.getFormProperties().getRootSrc();
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
	<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%;overflow:auto;">
		<div style=" position: absolute;height: 100%;width: 100%;overflow: hidden;">
			<div id="container" style="height:calc(100% - 54px); width:100%;overflow: auto;background: #fff; font-size: 13px;">
			</div>
			<script type="text/javascript">
				function proUrl(node){
					var url;
					var parentId = $('#container').jstree('get_parent',node);
					var parentNode = $('#container').jstree('get_node',parentId);
					if(node.id == '#'){
						url = "<%=urlPath %>/";
					}else {
						if( node.original.type > 3 && node.original.type < 8){
							var nodeUrl = midToName(node);
						}else{
							var nodeUrl = node.original.mid+"/";
						}
						url = proUrl(parentNode)+nodeUrl;
					}
					return url;
				}
				function midToName(node){
					var nodeUrlName;
					if(node.original.type == 4){
						nodeUrlName = "form/";
					}
					if(node.original.type == 5){
						nodeUrlName = "logic/";
					}
					if(node.original.type == 6){
						nodeUrlName = "bo/";
					}
					if(node.original.type == 7){
						nodeUrlName = "flow/";
					}
					return nodeUrlName;
				}
				$(document).ready(function() {
					var tree=	$('#container').jstree({
						'core' : {
							'multiple' : false,
							//'dblclick_toggle': false,
		    				'data' : {
								"url" : '<%=request.getContextPath()%>/templet/tem_h5LoadDataWithoutFormTem.action',
								"data" : function(node) {
											var templateType = '${param.templateType }';
											return {
												"root" : node.id ==="#"?"0":node.id,
												"templateType" : templateType,
											};
										},
								"dataType" : "json",
								"type":"post"
							},
							'themes' : {
								'icons' : true
							}
						},
	            		/* "plugins" : [ "themes", "json_data","crrm","contextmenu"]  , */
	            		"plugins" : [ "themes", "json_data","crrm"]  ,
						'contextmenu' :{
							"items" : onType
						}
					});
	
	    			//加载二级菜单
	    			$("#container").on("load_node.jstree", function(e, data){
	    				//取jstree根节点
	    				var inst = data.instance;  
	    			    var obj = inst.get_node(e.target.firstChild.firstChild.lastChild); 
	    			    
			    		$('#container').jstree(true).open_node(obj);
	    			}).jstree();
				});
			</script>
			
			<div id="buttom" class="cmdLayout">
			 	<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
				<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
				<script type="text/javascript">
					$('#button001').click(function(){
						var data = {};
						var nodes = $('#container').jstree(true).get_selected(true);
						if(nodes.length == 0 || nodes.length>1){
							layer.alert("请选择一条数据！",{icon: 2});
							return;
						}
						if(nodes[0].original.type == 1){
							layer.alert("请勿选择目录！",{icon: 2});
							return;
						}
						var node = nodes[0];
						data['uuid'] = node.id;
						data['formId'] = node.original.formMid;
						data['name'] = node.text;
						data['pdid'] = node.original.flowMid; 
						
						var index = parent.layer.getFrameIndex(window.name);
						parent.onlayerSelectTemplateClose(data);
						parent.layer.close(index);
					});
					
					$('#button002').click(function(){
						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
					});
				</script>
			</div>	
	</div>					
	<script>
	/*
		菜单
	*/
	var onType = function(data){
		//模块各项内部右键菜单
		var type4_8 = {
			"create":null,  
			"rename":null,  
			"ccp":null,
			/* "open":{
				"label":"打开",
				"_disabled":false,
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/edit.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var parentNode = $('#container').jstree('get_node',parentId);
					var thetype = node.original.type;
					var formId = node.original.formId;
					$('iframe').attr("src","<%=request.getContextPath()%>/form/admin/custom/utilization/tabUtilization.jsp?entityId="+node.id+"&parentNodeId=parentNode.id&catalogId="+node.id+"&formId="+formId);
				}
			}, */
			"remove":{  
				"label":"删除",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/delete.png", 
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeUrl = proUrl(node);
					if(confirm('确定要删除'+node.text+'吗?')){
						$.post(
							"<%=request.getContextPath()%>/utilization/code_deleteCodeH5.action",
							{ entityId: node.id, 
							  parentNodeId: parentId,
							  type: node.original.type,
							},
							function(data){
								if(data){
									$('#container').jstree(true).refresh_node(parentId);
									$("#InfoIframe").attr("src",'<%=path %>/form/admin/logon/matrix/welcome.jsp');
									//$('#container').jstree(true).delete_node([node.id]);
								}
							}
						);
					}
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
						"<%=path%>/utilization/code_loadDataGridDataH5.action",
						{ root: node.id, 
						  otherNodeId: prevdom,
						  forMove: "previousNodeData" 
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
					var nextdomNode = $('#continer').jstree('get_node',nextdom);
					$.post(
						"<%=path%>/utilization/code_loadDataGridDataH5.action",
						{ root: node.id, 
						  otherNodeId: nextdom,
						  forMove: "nextNodeData" 
						},
						function(){
							$('#container').jstree(true).refresh_node(parentId);
						}
					);
				}
			}
		};
			//目录右键菜单
			var type1 = {
				"create":null,  
				"rename":null,  
				"ccp":null,
				"newsubdirectory":{  
					"label":"添加目录",
					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
					"action":function(data){
						var node = $('#container').jstree('get_node',data.reference[0]);
						var nodeid = node.original.id;
						var parentId = $('#container').jstree('get_parent',data.reference[0]);
					//	$('iframe').attr("src","<%=request.getContextPath()%>/utilization/code_loadAddCodePage.action?parentUUID="+node.id+"&parentNodeId="+parentId+"&oType=add&type=1");
						layer.open({
					    	id:'layerNewDir',
							type : 2,//iframe 层
							
							title : ['添加目录'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '90%', '50%' ],
							content : '<%=request.getContextPath()%>/utilization/code_H5LoadAddCodePage.action?parentUUID='+nodeid+'&parentNodeId='+nodeid+'&type=1&oType=add',
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
						});
					}
				},
				"newmodule":{  
					"label":"添加应用设置",
					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
					"action":function(data){
						var node = $('#container').jstree('get_node',data.reference[0]);
						var nodeid = node.original.id;
						var parentId = $('#container').jstree('get_parent',data.reference[0]);
						var theForm = '${param.formValue }';
						var formId = '${param.formId }';
						layer.open({
					    	id:'layerNewDir',
							type : 2,//iframe 层
							
							title : ['添加应用设置'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '90%', '50%' ],
							content : '<%=request.getContextPath()%>/utilization/code_H5LoadAddCodePage.action?parentUUID='+nodeid+'&parentNodeId='+nodeid+'&type=2&oType=add&formValue='+theForm+'&formId='+formId,
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
						});
					}
				},
				/*  
				"change":{  
					"label":"编辑节点",
					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/edit.png", 
					"action":function(data){
						var node = $('#container').jstree('get_node',data.reference[0]);
						var nodeid = node.original.id;
						var parentId = $('#container').jstree('get_parent',data.reference[0]);
						layer.open({
							    	id:'layerNewsubdirectory',
									type : 2,//iframe 层
									
									title : ['编辑目录节点'],
									closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
									shadeClose: false, //开启遮罩关闭
									area : [ '50%', '50%' ],
									content : '<%=request.getContextPath()%>/html5Catalog_getCatalogById.action?entityId='+nodeid+'&parentNodeId='+parentId,
									//end	: function(){
									//	$('#container').jstree(true).refresh_node(parentId);
									//}
						});
					}
				},
				*/
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
						var parentId = $('#container').jstree('get_parent',data.reference[0]);
						var node = $('#container').jstree('get_node',data.reference[0]);
						var nodeUrl = proUrl(node);
						if(confirm('确定要删除'+node.text+'吗?')){
							$.post(
								"<%=path%>/utilization/code_deleteCodeH5.action",
								{ entityId: node.id, 
								  parentNodeId: parentId,
								  type: node.original.type,
								},
								function(data){
									if(data){
										$('#container').jstree(true).refresh_node(parentId);
										$("#InfoIframe").attr("src",'<%=path %>/form/admin/logon/matrix/welcome.jsp');
										//$('#container').jstree(true).delete_node([node.id]);
									}
								}
							);
						}
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
							"<%=path%>/utilization/code_loadDataGridDataH5.action",
							{ root: node.id, 
							  otherNodeId: prevdom,
							  forMove: "previousNodeData" 
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
						var nextdomNode = $('#container').jstree('get_node',nextdom);
						$.post(
							"<%=path%>/utilization/code_loadDataGridDataH5.action",
							{ root: node.id, 
							  otherNodeId: nextdom,
							  smid:nextdomNode.original.mid,
							  forMove: "nextNodeData" 
							},
							function(){
								$('#container').jstree(true).refresh_node(parentId);
							}
						);
					}
				}
		};
			//跟
			var typeRoot = {
					"create":null,  
					"rename":null,  
					"ccp":null,
					"newsubdirectory":{
						"label":"添加目录",
						"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
						"action":function(data){
							var node = $('#container').jstree('get_node',data.reference[0]);
							var nodeid = node.original.id;
							var parentId = $('#container').jstree('get_parent',data.reference[0]);
						//	$('iframe').attr("src","<%=request.getContextPath()%>/utilization/code_loadAddCodePage.action?parentUUID="+node.id+"&parentNodeId="+parentId+"&oType=add&type=1");
							layer.open({
						    	id:'layerNewDir',
								type : 2,//iframe 层
								
								title : ['添加目录'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '90%', '50%' ],
								content : '<%=request.getContextPath()%>/utilization/code_H5LoadAddCodePage.action?parentUUID='+nodeid+'&parentNodeId='+nodeid+'&type=1&oType=add',
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(node);
								//}
							});
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
		
		var thetype = data.original.type;
		if(data.original.mid == 'commonservice' ){
			
		}
		
		if(thetype == 2){
			return type4_8;
		}else if(thetype == 0){
			return typeRoot;
		}else if(thetype == 1){
			return type1;
		}
	}
	</script>
</body>
</html>
