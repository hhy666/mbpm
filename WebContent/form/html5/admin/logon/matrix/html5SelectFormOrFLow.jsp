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
		<div id="col1" class="col-xs-12" style="height:100%; padding: 0px;border-right: inset;border-right-width: 1px;">
		<div id="tablediv" style="width: 100%;height:90%; overflow: auto;" >
		
			<table style="width: 100%; ">
			<tr>
				<td style="width: 100%; height: 80%;">
					<div id="container" style="background: #fff; font-size: 12px; height: 100%;"></div>

					<!-- include the minified jstree source -->
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
										"url" : '<%=path %>/html5Catalog_manageTreeInSingle.action',
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
														var rootCode = "${param.rootCode }";
														var queryType = "${param.queryType }";
														var returnData ;
														if(rootCode != ""){
															if(queryType != ""){
																returnData = {
																		"nodeType" : node.original == null? "" :(node.original.type === ""?"0":node.original.type),
																		"root" : node.id ==="#"?"0":node.id,
																		"rootCode": rootCode,
																		"queryType" : queryType
																};
															}else{
																returnData = {
																		"nodeType" : node.original == null? "" :(node.original.type === ""?"0":node.original.type),
																		"root" : node.id ==="#"?"0":node.id,
																		"rootCode": rootCode
																};
															}
														}else{
															returnData = {
																	"nodeType" : node.original == null? "" :(node.original.type === ""?"0":node.original.type),
																	"root" : node.id ==="#"?"0":node.id
															};
														}
														return returnData;
													},
										"dataType" : "json",
										"type":"post"
									},
									'themes' : {
										'icons' : true
									}
								},
								
								//'expand_selected_onload' : true, //选中项蓝色底显示  
			              // 	"checkbox": {
			              //     	"keep_selected_style": true,//是否默认选中
			              //     	"three_state": false,//父子级别级联选择
			              //     	"tie_selection": true
			              // 	},
			                	"themes": { "theme": "default", "dots": false, "icons": false },  
			            		"plugins" : [ "themes", "json_data","crrm","contextmenu"], 
			            	//	"plugins" : [ "themes", "json_data","crrm"]
								'contextmenu' :{
									"items" : onType
								}
							});
			
			        		//展开时候图标设置
			    			$('#container').on('open_node.jstree', function(e, datas) {  
				     			var nodeId = datas.node.id; 
				     			//$('#container').jstree(true).set_icon(nodeId, "jstree-node-online");
			    				// tree.set_icon(node,"jstree-node-offline");
			    			}).jstree();
						    //收拢时候图标设置
						    $('#container').on('close_node.jstree', function(e, datas) {  
						     	var nodeId = datas.node.id; 
						     	//$('#container').jstree(true).set_icon(nodeId, "jstree-node-offline");
						    	// tree.set_icon(node,"jstree-node-offline");
			    			}).jstree();
			    			
			    			//加载二级菜单
			    			$("#container").on("load_node.jstree", function(e, data){
			    				//取jstree根节点角
			    				var inst = data.instance;  
			    			    var obj = inst.get_node(e.target.firstChild.firstChild.lastChild); 
			    			    
					    		$('#container').jstree(true).open_node(obj);
			    			}).jstree();
			    			
			    			//单击打开节点
			    		//	$("#container").on("select_node.jstree",function(e, data){
			    		//		var node = data.node;
						//		var parentId = $('#container').jstree('get_parent',node);
						//		var parentNode = $('#container').jstree('get_node',parentId);
						//		var thetype = node.original.type;
						//		if(thetype == 14){
						//			document.getElementById('InfoIframe').src='<%=path %>/form/formInfo_loadFormMainPage.action?nodeUuid='+node.id+'&type=1&parentNodeId='+parentId+'&processType=${param.processType }';
						//		}
						//		if(thetype == 15){
						//			document.getElementById('InfoIframe').src='<%=path %>/logic/logicInfo_loadLogicMainPage.action?mid='+node.original.mid+'&comType='+node.original.comType+'&parentNodeId='+parentId+'&isCommon='+parentNode.original.mid+'_logic';
						//		}
						//		if(thetype == 16){
						//			document.getElementById('InfoIframe').src='<%=path %>/entity/entityInfo_loadMainPage.action?entityPath='+node.original.subItems+'&parentNodeId='+parentId;
						//		}
						//		if(thetype == 17){
						//			document.getElementById('InfoIframe').src='<%=path %>/form/admin/process/mainProcess.jsp?processId='+node.original.mid+'&processTmplId='+node.id+'&entityId='+node.id+'&parentNodeId='+parentId+'&type=17&processType=${param.processType }';
						//		}
			    		//	}).jstree();
						});
					</script>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout">
					<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
					<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
					<script type="text/javascript">
						$('#button001').click(function(){
							var data = {};
							var nodes = $('#container').jstree(true).get_selected(true);
							if(nodes.length == 0){
								layer.alert("请选择数据！",{icon: 2});
								return;
							}
							var node = nodes[0];
							if(node.original.type == 0|| node.original.type == 1 || node.original.type == 2){//不能选择目录
								layer.alert("请勿选择目录！",{icon: 2});
								return;
							}
							var parentId = $('#container').jstree('get_parent',node);
							data['id'] = node.id;
							data['name'] = node.text;
							data['parentId'] = parentId;
							data['formId'] = node.original.mid;
							Matrix.closeLayerWindow(data);
						});
						
						$('#button002').click(function(){
							 Matrix.closeLayerWindow();
						});
					</script>
				</td>
			</tr>
		</table>
	<script>
	/*
		菜单
	*/
	var onType = function(data){
		var phase = '<%=com.matrix.form.admin.common.utils.CommonUtil.getCurPhase()%>';
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
						$('iframe').attr("src",'<%=path %>/form/formInfo_loadFormMainPage.action?nodeUuid='+node.id+'&type=1&parentNodeId='+parentId+'&processType=${param.processType }');
					}
					if(thetype == 15){
						$('iframe').attr("src",'<%=path %>/logic/logicInfo_loadLogicMainPage.action?mid='+node.original.mid+'&comType='+node.original.comType+'&parentNodeId='+parentId+'&isCommon='+parentNode.original.mid+'_logic');
					}
					if(thetype == 16){
						$('iframe').attr("src",'<%=path %>/entity/entityInfo_loadMainPage.action?entityPath='+node.original.subItems+'&parentNodeId='+parentId);
					}
					if(thetype == 17){
						$('iframe').attr("src",'<%=path %>/form/admin/process/mainProcess.jsp?processId='+node.original.mid+'&processTmplId='+node.id+'&entityId='+node.id+'&parentNodeId='+parentId+'&type=17&processType=${param.processType }');
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
									$("#InfoIframe",parent.document.body).attr("src",'<%=path %>/form/admin/logon/matrix/welcome.jsp');
									//$('#container').jstree(true).delete_node([node.id]);
								}
							}
						);
					}
				}
			},  
			/*
			"authorization":{  
				"label":"授权",
				"_disabled":function(data){
					var flag = true;
					var node = $('#container').jstree('get_node',data.reference[0]);
					if((node.original.storeType == 2 || phase == '4') && node.original.type == 14){
						flag = false;
					}
	//				var parentId = $('#container').jstree('get_parent',data.reference[0]);
	//				var node = $('#container').jstree('get_node',parentId);
	//				if( node.original.type == 4){
	//					flag = false;
	//				}
					return flag;
				},
				"separator_after"	: true,
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/auth.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeUrl = proUrl(node);
					$("#InfoIframe").attr("src",'<%=path %>/security/formSecurity_loadSecurityIndex.action?catalogId='+node.id+'&modulePath='+nodeUrl);
				}
			},
			*/
			"moveup":{  
				"label":"上移",
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
				"label":"下移",
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
			}
			/*
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
						"_disabled":function(data){
							var flag = false;
							if(phase == '4'){
								flag =true;
							}
							return flag;
						},
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
										//end	: function(){
										//	$('#container').jstree(true).refresh_node(parentId);
										//}
							});
							//catalog.jsp 调用  compRenameId()方法 ,参数为node.original  
						}
					}
				}
			}
			*/
			
		};
		//模块右键菜单
		var type2 = {
			"create":null,  
			"rename":null,  
			"ccp":null,
			"newprocess":{  
				"label":"新建协同流程",
				"_disabled":function(data){
					var queryType = "${param.queryType }";
					var flag = true;
					if(queryType == '7'){
						flag = false;
					}
					return flag;
				},
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
							area : [ '80%', '70%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+nodeid+'&parentNodeId='+nodeid+'&type=17',
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"newform":{  
				"label":"新建表单",
				"_disabled":function(data){
					var queryType = "${param.queryType }";
					var flag = true;
					if(queryType == '4'){
						flag = false;
					}
					return flag;
				},
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
								content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+nodeid+'&parentNodeId='+nodeid+'&type=14',
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
				"label":"下移",
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
			/*
			"export":{  
				"label":"导出模块",
				"_disabled":true,
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
								area : [ '45%', '45%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectType.jsp?uuid='+nodeid+'&mid='+node.original.mid+'&flag=export&type=2&parentNodeId='+parentId,
								//end	: function(){
									//$('#container').jstree(true).refresh_node(parentId);
								//}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			}
			*/
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
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(node);
								//}
					});
				}
			},
			/*
			"import":{  
				"label":"导入目录",
				"_disabled":true,
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
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(parentId);
								//}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
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
			"importmodule":{  
				"label":"导入模块",
				"_disabled":true,
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
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(parentId);
								//}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"exportcatalog":{  
				"label":"导出目录",
				"_disabled":true,
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
								area : [ '45%', '45%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectType.jsp?uuid='+nodeid+'&mid='+node.original.mid+'&flag=export&type=1&parentNodeId='+parentId,
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(parentId);
								//}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
				}
			},
			"importcatalog":{  
				"label":"导入目录",
				"_disabled":true,
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
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(parentId);
								//}
					});
					//catalog.jsp 调用  showExportDialog(target)方法 ,参数为node.original
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
				"label":"下移",
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
							area : [ '50%', '55%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=15',
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
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
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
							area : [ '61%', '80%' ],
							content : '<%=request.getContextPath()%>/html5Catalog_addComponentEntranceH5.action?entityId='+nodeid+'&parentId='+parentId+'&parentNodeId='+nodeid+'&type=16&comType=1',
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
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
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
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
							content : '<%=request.getContextPath()%>/entity/importEntity_loadDsList.action?parentUuid='+parentId+'&parentNodeId='+nodeid+'&nodeUrl='+proUrl(node)+'&iframewindowid=ImportBODialog',
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
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
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
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
	</div>
		</div>
</body>
</html>
