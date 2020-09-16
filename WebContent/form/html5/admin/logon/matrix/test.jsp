<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath = path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>var webContextPath="<%=path%>";</script>
		<base href="<%=basePath%>">
		<title>test树</title>
		<script src="<%=path%>/resource/html5/js/jquery.min.js"></script>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
	    <script src='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></script>
		<script src="<%=path%>/resource/html5/js/jstree.min.js"></script>
		<script src="<%=path%>/resource/html5/js/demo.js"></script>
		<link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet"
			href="<%=path%>/css/themes/default/style.min.css" />
	</head>
	<body>
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
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="width: 100%; height: 85%;">
					<div id="container"
						style="background: #fff; font-size: 12px; height: 100%;"></div>

					<!-- include the minified jstree source -->
					<script type="text/javascript">
						function proUrl(node){
							var url;
							var parentId = $('#container').jstree('get_parent',node);
							var parentNode = $('#container').jstree('get_node',parentId);
							if(node.id == '#'){
								url = "C:\\Users\\aaa\\Desktop\\nodeData/";
							}else {
								var nodeUrl = node.original.mid+"/";
								url = proUrl(parentNode)+nodeUrl;
							}
							return url;
						}
						$(document).ready(function() {
							var tree=	$('#container').jstree({
								'core' : {
									'multiple' : false,
									//'dblclick_toggle': false,
				    				'data' : {
										"url" : '<%=path %>/html5Catalog_manageTree2.action',
										//	function(node){
										//		var type = node.id == '#' ? 'root' : node.original.type;
										//		if(node.id != '#' && type == 2){
										//			return "nodeData/node_Component.mconf";
										//		}
										//		if(node.id == 'form' || node.id == 'logic' || node.id == 'synflow' || node.id == 'serviceObj'){
										//			var parentId = $('#container').jstree('get_parent',node);
										//			return "nodeData/node_"+parentId+"_"+node.id+"_"+type+".mconf";
										//		}
										//		return "nodeData/node_"+(node.id === "#"?"0":node.id)+"_"+type+".mconf";
										//	},
										//	function(node){
										//		
										//		var url = proUrl(node)+".mconf";
										//		
										//		return url;
										//	},
										"data" : 
													function(node) {
														return {
															"nodeType" : node.original == null? "" :(node.original.type === ""?"-1":node.original.type),
															"root" : node.id ==="#"?"0":node.id,
															"nodeUrl": proUrl(node)
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
			            		"plugins" : [ "themes", "json_data","crrm","contextmenu"]  ,
								'contextmenu' :{
									"items" : onType
								}
							});
			
			        		//展开时候图标设置
			    			$('#container').on('open_node.jstree', function(e, datas) {  
				     			var nodeId = datas.node.id; 
				     			//$('#container').jstree(true).set_icon(nodeId, "jstree-node-online");
			    				// tree.set_icon(node,"jstree-node-offline");
			    			});
						    //收拢时候图标设置
						    $('#container').on('close_node.jstree', function(e, datas) {  
						     	var nodeId = datas.node.id; 
						     	//$('#container').jstree(true).set_icon(nodeId, "jstree-node-offline");
						    	// tree.set_icon(node,"jstree-node-offline");
			    			});
			    			
			    			//加载二级菜单
			    			$('#container').on('load_node.jstree', function(e, data){
					    		$('#container').jstree(true).open_node("root");
			    			});
			    			
			    			//单击打开节点
			    			$('#container').on('select_node.jstree',function(e, data){
			    				var node = data.node;
								var parentId = $('#container').jstree('get_parent',node);
								var parentNode = $('#container').jstree('get_node',parentId);
								var thetype = node.original.type;
								if(thetype == 14){
									$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/form/formInfo_loadFormMainPage.action?nodeUuid='+node.id+'&type=1&parentNodeId='+parentId+'&processType=')
								}
								if(thetype == 15){
									$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/logic/logicInfo_loadLogicMainPage.action?mid='+node.original.mid+'&comType='+node.original.comType+'&parentNodeId='+parentId+'&isCommon='+parentNode.original.mid+'_logic')
								}
								if(thetype == 16){
									$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/entity/entityInfo_loadMainPage.action?entityPath='+node.original.subItems+'&parentNodeId='+parentId);
								}
								if(thetype == 17){
									$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/form/admin/process/mainProcess.jsp?processId='+node.original.mid+'&processTmplId='+node.id+'&entityId='+node.id+'&parentNodeId='+parentId+'&type=17&processType=');
								}
			    			});
						});
					</script>
				</td>
			</tr>
		</table>
	</body>
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
			"open":{
				"label":"打开",
				"_disabled":false,
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/edit.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var parentNode = $('#container').jstree('get_node',parentId);
					var thetype = node.original.type;
					if(thetype == 14){
						$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/form/formInfo_loadFormMainPage.action?nodeUuid='+node.id+'&type=1&parentNodeId='+parentId+'&processType=')
					}
					if(thetype == 15){
						$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/logic/logicInfo_loadLogicMainPage.action?mid='+node.original.mid+'&comType='+node.original.comType+'&parentNodeId='+parentId+'&isCommon='+parentNode.original.mid+'_logic')
					}
					if(thetype == 16){
						$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/entity/entityInfo_loadMainPage.action?entityPath='+node.original.subItems+'&parentNodeId='+parentId);
					}
					if(thetype == 17){
						$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/form/admin/process/mainProcess.jsp?processId='+node.original.mid+'&processTmplId='+node.id+'&entityId='+node.id+'&parentNodeId='+parentId+'&type=17&processType=');
					}
					//alert("打开"+node.original);
					//alert(node.original.id);
					//catalog.jsp 调用   forwardPageByNodeType()方法 ,参数为node.original  
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
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeUrl = proUrl(node);
					if(confirm('确定要删除'+node.text+'吗?')){
						$.post(
							"<%=path%>/html5Catalog_deleteCatalog.action",
							{ entityId: node.id, 
							  parentNodeId: parentId,
							  type: node.original.type,
							  mid: node.original.mid,
							  nodeUrl:nodeUrl
							},
							function(data){
								if(data){
									$('#container').jstree(true).refresh_node(parentId);
									//$('#container').jstree(true).delete_node([node.id]);
								}
							}
						);
					}
				}
			},  
			"moveup":{  
				"label":"上移菜单",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_up.png",
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var prevdom = $('#container').jstree('get_prev_dom',data.reference[0],true).context.id;
					var node = $('#container').jstree('get_node',data.reference[0]);
					$.post(
						"<%=path%>/html5Catalog_manageTree2.action",
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
				"label":"下移菜单",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_down.png",
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nextdom = $('#container').jstree('get_next_dom',data.reference[0],true).context.id;
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nextdomNode = $('#continer').jstree('get_node',nextdom);
					$.post(
						"<%=path%>/html5Catalog_manageTree2.action",
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
			},
			"newform":{  
				"label":"新建表单",
				"separator_before"	: true,
				"_disabled":true,
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.original.id;
					
						layer.open({
						    	id:'layerNewform',
								type : 2,//iframe 层
								
								title : ['新建表单'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=14',
								end	: function(){
									$('#container').jstree(true).refresh_node(node);
								}
						});
					//catalog.jsp 调用   forwardPageByNodeType()方法 ,参数为node.original  
				}
			},
			"copypath":{  
				"label":"复制路径",
				"_disabled":function(data){
					var flag = false;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',parentId);
					if(node.original.type == 7){
						flag = true;
					}
					return flag;
				},
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/copy.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
				    var formId = node.original.mid+".rform";
				    var userAgent = navigator.userAgent;
				    var isOpera = userAgent.indexOf("Opera") > -1
				    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera;
				    if(isIE){
					    window.clipboardData.setData("Text",formId);
				    
				    }else{
				    	alert('该功能仅支持IE浏览器,其他浏览器请选择复制以下内容：'+formId);
				    }
				}
			},
			"reconstruction":{  
				"label":"重构",
				"_disabled":function(data){
					var flag = false;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',parentId);
					if(node.original.type == 7 || node.original.type == 5){
						flag = true;
					}
					return flag;
				},
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/refactor.png", 
				"action":false,
				"submenu":{
					"movecode":{  
						"label":"迁移",
						"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/migrate.png", 
						"action":function(data){
							var node = $('#container').jstree('get_node',data.reference[0]);
							var nodeid = node.original.id;
							var parentId = $('#container').jstree('get_parent',data.reference[0]);
							layer.open({
								    	id:'layerMovecode',
										type : 2,//iframe 层
										
										title : ['实体表单迁移'],
										closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
										shadeClose: false, //开启遮罩关闭
										area : [ '30%', '65%' ],
										content : '<%=request.getContextPath()%>/common/html5Common_loadCommonTreePage.action?componentType='+node.original.type+'&refactor=true&&iframewindowid=MigrateDialog',
										end	: function(){
											$('#container').jstree(true).refresh_node(parentId);
										}
							});
							//catalog.jsp 调用  migrateComponent()方法 ,参数为node.original  
						}
					},
					"changecode":{  
						"label":"编码修改",
						"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/refactor_id.png", 
						"action":function(data){
							var node = $('#container').jstree('get_node',data.reference[0]);
							var nodeid = node.original.id;
							var parentId = $('#container').jstree('get_parent',data.reference[0]);
							layer.open({
								    	id:'layerChangecode',
										type : 2,//iframe 层
										
										title : ['实体编码修改'],
										closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
										shadeClose: false, //开启遮罩关闭
										area : [ '50%', '50%' ],
										content :'<%=request.getContextPath()%>/refactor/html5RefactorAction_loadRenamePage.action?srcCompId='+node.original.mid+'&uuid='+nodeid+'&cType='+node.original.type+'&srcEntityPath='+node.original.subItems+'&iframewindowid=RenameIdDialog',
										end	: function(){
											$('#container').jstree(true).refresh_node(parentId);
										}
							});
							//catalog.jsp 调用  compRenameId()方法 ,参数为node.original  
						}
					}
				}
			},
			"authorization":{  
				"label":"授权",
				"_disabled":function(data){
					var flag = true;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',parentId);
					if( node.original.type == 4){
						flag = false;
					}
					return flag;
				},
				"separator_after"	: true,
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/auth.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/security/formSecurity_loadSecurityIndex.action?catalogId='+node.id);
					//alert("授权"+node.original);
					//alert(node.original.id);
					//catalog.jsp 调用   setSecurity()方法 ,参数为node.original  
				}
			},
		};
		//模块右键菜单
		var type2 = {
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
								end	: function(){
									$('#container').jstree(true).refresh_node(parentId);
								}
					});
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
							"<%=path%>/html5Catalog_deleteCatalog.action",
							{ entityId: node.id, 
							  parentNodeId: parentId,
							  type: node.original.type,
							  mid: node.original.mid,
							  nodeUrl:nodeUrl
							},
							function(data){
								if(data){
									$('#container').jstree(true).refresh_node(parentId);
									//$('#container').jstree(true).delete_node([node.id]);
								}
							}
						);
					}
				}
			},  
			"moveup":{  
				"label":"上移菜单",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_up.png",
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var prevdom = $('#container').jstree('get_prev_dom',data.reference[0],true).context.id;
					var node = $('#container').jstree('get_node',data.reference[0]);
					$.post(
						"<%=path%>/html5Catalog_manageTree2.action",
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
				"label":"下移菜单",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_down.png",
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nextdom = $('#container').jstree('get_next_dom',data.reference[0],true).context.id;
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nextdomNode = $('#container').jstree('get_node',nextdom);
					$.post(
						"<%=path%>/html5Catalog_manageTree2.action",
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
			},
			"export":{  
				"label":"导出模块",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/save_hd.png",
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['选择导出模式'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '30%', '30%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectType.jsp?uuid='+nodeid+'&mid='+node.original.mid+'&flag=export&type=2&parentNodeId='+parentId,
								end	: function(){
									$('#container').jstree(true).refresh_node(parentId);
								}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			}
		};
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
					var nodeid = node.original.id;
					var nodeUrl = proUrl(node);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['新建子目录'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/html5Catalog_addCatalogEntranceH5.action?parentId='+nodeid+'&parentNodeId='+nodeid+'&type=1&nodeUrl='+nodeUrl,
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(node);
								//}
					});
				}
			},
			"newmodule":{  
				"label":"新建模块",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var nodeUrl = proUrl(node);
					layer.open({
						    	id:'layerNewmodule',
								type : 2,//iframe 层
								
								title : ['新建模块'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/html5Catalog_addCatalogEntranceH5.action?parentId='+nodeid+'&parentNodeId='+nodeid+'&type=2&nodeUrl='+nodeUrl,
								end	: function(){
									$('#container').jstree(true).refresh_node(node);
								}
					});
				}
			},
			"import":{  
				"label":"导入目录",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/import_hd.png",
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['选择导出模式'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectFile.jsp?uuid='+nodeid+'&mid='+node.original.mid+'&contentFlag=contents&type=1&flag=import&parentNodeId='+parentId
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
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
		//目录右键菜单
		var type1 = {
			"create":null,  
			"rename":null,  
			"ccp":null,
			"newsubdirectory":{  
				"label":"新建子目录",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var nodeUrl = proUrl(node);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['新建子目录'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/html5Catalog_addCatalogEntranceH5.action?parentId='+nodeid+'&parentNodeId='+nodeid+'&type=1&nodeUrl='+nodeUrl,
								end	: function(){
									$('#container').jstree(true).refresh_node(node);
								}
					});
				}
			},
			"newmodule":{  
				"label":"新建模块",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var nodeUrl = proUrl(node);
					layer.open({
						    	id:'layerNewmodule',
								type : 2,//iframe 层
								
								title : ['新建模块'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/html5Catalog_addCatalogEntranceH5.action?parentId='+nodeid+'&parentNodeId='+nodeid+'&type=2&nodeUrl='+nodeUrl,
								end	: function(){
									$('#container').jstree(true).refresh_node(node);
								}
					});
				}
			},
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
								end	: function(){
									$('#container').jstree(true).refresh_node(parentId);
								}
					});
				}
			},
			"importmodule":{  
				"label":"导入模块",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/import_hd.png",
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['选择导出模式'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectFile.jsp?uuid='+nodeid+'&mid='+node.original.mid+'&contentFlag=contents&type=2&flag=import&parentNodeId='+parentId,
								end	: function(){
									$('#container').jstree(true).refresh_node(parentId);
								}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"exportcatalog":{  
				"label":"导出目录",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/save_hd.png",
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['选择导出模式'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '30%', '30%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectType.jsp?uuid='+nodeid+'&mid='+node.original.mid+'&flag=export&type=1&parentNodeId='+parentId,
								end	: function(){
									$('#container').jstree(true).refresh_node(parentId);
								}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"importcatalog":{  
				"label":"导入目录",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/import_hd.png",
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['选择导出模式'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectFile.jsp?uuid='+nodeid+'&mid='+node.original.mid+'&contentFlag=contents&type=1&flag=import&parentNodeId='+parentId,
								end	: function(){
									$('#container').jstree(true).refresh_node(parentId);
								}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
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
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeUrl = proUrl(node);
					if(confirm('确定要删除'+node.text+'吗?')){
						$.post(
							"<%=path%>/html5Catalog_deleteCatalog.action",
							{ entityId: node.id, 
							  parentNodeId: parentId,
							  type: node.original.type,
							  mid: node.original.mid,
							  nodeUrl:nodeUrl
							},
							function(data){
								if(data){
									$('#container').jstree(true).refresh_node(parentId);
									//$('#container').jstree(true).delete_node([node.id]);
								}
							}
						);
					}
				}
			},  
			"moveup":{  
				"label":"上移菜单",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_up.png",
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var prevdom = $('#container').jstree('get_prev_dom',data.reference[0],true).context.id;
					var node = $('#container').jstree('get_node',data.reference[0]);
					$.post(
						"<%=path%>/html5Catalog_manageTree2.action",
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
				"label":"下移菜单",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_down.png",
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nextdom = $('#container').jstree('get_next_dom',data.reference[0],true).context.id;
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nextdomNode = $('#container').jstree('get_node',nextdom);
					$.post(
						"<%=path%>/html5Catalog_manageTree2.action",
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
		//表单右键菜单
		var typeform = {
			"create":null,  
			"rename":null,  
			"ccp":null,
			"newform":{  
				"label":"新建表单",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.original.id;
					
						layer.open({
						    	id:'layerNewform',
								type : 2,//iframe 层
								
								title : ['新建表单'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=14',
								end	: function(){
									$('#container').jstree(true).refresh_node(node);
								}
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
		//逻辑服务右键菜单
		var typelogicalservice = {
			"create":null,  
			"rename":null,  
			"ccp":null,
			"newlogic":{  
				"label":"新建逻辑服务",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.id;
					layer.open({
					    	id:'layerNewlogic',
							type : 2,//iframe 层
							
							title : ['新建逻辑服务'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '50%', '50%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=15',
							end	: function(){
								$('#container').jstree(true).refresh_node(node);
							}
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
		//业务对象右键菜单
		var typebusiness = {
			"create":null,  
			"rename":null,  
			"ccp":null,
			"newbasic":{  
				"label":"新建基本对象",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.id;
					layer.open({
					    	id:'layerNewbasic',
							type : 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							
							title : ['新建基本对象'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							scrollbar: false,//关闭滚动条
							area : [ '50%', '50%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=16&comType=3',
							end	: function(){
								$('#container').jstree(true).refresh_node(node);
							}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"newsave":{  
				"label":"新建存储对象",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.id;
					layer.open({
					    	id:'layerNewSave',
							type : 2,//iframe 层
							
							title : ['新建存储对象'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							scrollbar: false,//关闭滚动条
							area : [ '61%', '61%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=16&comType=1',
							end	: function(){
								$('#container').jstree(true).refresh_node(node);
							}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"newquery":{  
				"label":"新建查询对象",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.id;
					layer.open({
					    	id:'layerNewquery',
							type : 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							
							title : ['新建查询对象'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							scrollbar: false,//关闭滚动条
							area : [ '50%', '50%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=16&comType=2',
							end	: function(){
								$('#container').jstree(true).refresh_node(node);
							}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"importsave":{  
				"label":"导入存储对象",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/import_hd.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.id;
					layer.open({
					    	id:'layerImportsave',
							type : 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							
							title : ['导入业务对象'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							scrollbar: false,//关闭滚动条
							area : [ '60%', '60%' ],
							content : '<%=request.getContextPath()%>/entity/importEntity_loadDsList.action?parentUuid='+parentId+'&parentNodeId='+nodeid+'&&iframewindowid=ImportBODialog',
							end	: function(){
								$('#container').jstree(true).refresh_node(node);
							}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
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
		//协同流程右键菜单
		var typeprocess = {
			"create":null,  
			"rename":null,  
			"ccp":null,
			"newprocess":{  
				"label":"新建协同流程",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var nodeid = node.id;
					layer.open({
					    	id:'layerNewprocess',
							type : 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							
							title : ['新建协同流程'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							scrollbar: false,//关闭滚动条
							area : [ '50%', '50%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=17',
							end	: function(){
								$('#container').jstree(true).refresh_node(node);
							}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
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
		if(thetype > 7 ){
			return type4_8;
		}else if(thetype == 2){
			return type2;
		}else if(thetype == 0){
			return typeRoot;
		}else if(thetype == 1){
			return type1;
		}else if(thetype == 4){
			return typeform;
		}else if(thetype == 5){
			return typelogicalservice;
		}else if(thetype == 6){
			return typebusiness;
		}else if(thetype == 7){
			return typeprocess;
		}
	}
	
	</script>
</html>
