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
			
			/* 遮盖层 */
			#maskDiv{
				position: absolute;
				top: 0;
				left: 0;
				z-index: 99891017;
				opacity: 0.3;
				filter: alpha(opacity=30);
				height:100%;
				width:100%;
			}
			#rollIcon{
				position:absolute;
				top:50%;
				left:50%;
			}
		</style>
</head>
<body>
		<div id="maskDiv" >
			<i id="rollIcon" class="fa fa-spinner fa-pulse fa-5x"></i>
		</div>
		<div id="div1" class="col-xs-2" style="height:100%;width:15px;display:none;">
			<table style="width: 100%;height:100%;">
				<tr>
					<td><div id="spread" class="glyphicon glyphicon-forward" style="right:5px;"></div></td>
				</tr>
				<script type="text/javascript">
						$('#spread').click(function(){
							$('#col1').css('display','');
							$('#div1').css('display','none');
							$('#col2').css('width','')
						});
			  </script>
			</table>
		</div>
		<div id="col1" class="col-xs-2" style="height:100%; padding: 0px;border-right: inset;border-right-width: 1px;">
		<div style="background-color:rgb(248, 248, 248);">
					 <div style="height: 30px;padding: 7px;font-weight:bold;padding-left:30px;">目录树</div>
					 <div id="controlBtn" style="position: absolute;right:5px;top: 5px;cursor: pointer;">
						 <div class="glyphicon glyphicon-backward"></div> 
					 </div>

					  <script type="text/javascript">
						$('#controlBtn').click(function(){
							$('#col1').animate({width: 'toggle'},'fast',function(){
								$('#div1').css('display','');
								//$('#col2').toggleClass('col-xs-10');
								$('#col2').css('width','calc(100% - 20px)')
							});
						});
					  </script>
		     </div>
		<div id="tablediv" style="width: 100%;height:calc(100% - 30px); overflow: auto;" >
		
			<table style="width: 100%; ">
			<tr>
				<td style="width: 100%; height: 85%;">
					<div id="container" style="background: #fff; font-size: 12px; height: 100%;"></div>

					<!-- include the minified jstree source -->
					<script type="text/javascript">
					var showListName=[];
					var templateType = '${param.templateType }';
					var isCopyTime = '${param.isCopyTime }';
						$(document).ready(function() {
							/* document.getElementById('controlBtn').style.display='none'; 隐藏控制按钮*/
							document.getElementById('maskDiv').style.display='none';
							var tree=	$('#container').jstree({
								'core' : {
									'multiple' : false,
									//'dblclick_toggle': false,
				    				'data' : {
										"url" : '<%=path %>/templet/tem_h5LoadData.action',
										"data" : function(node) {
														return {
															"root" : node.id ==="#"?"0":node.id,
															"templateType" : templateType,
															"isCopyTime" :isCopyTime
														};
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
			              //  	"themes": { "theme": "default", "dots": false, "icons": false },  
			            		"plugins" : [ "themes", "json_data","crrm","contextmenu"]  ,
								'contextmenu' :{
									"items" : onType
								}
							});
			
			    			//加载二级菜单
			    			$("#container").on("load_node.jstree", function(e, data){
			    				//取jstree根节点角
			    				var inst = data.instance;  
			    			    var obj = inst.get_node(e.target.firstChild.firstChild.lastChild); 
			    			    
					    		$('#container').jstree(true).open_node(obj);
			    			}).jstree();
			    			
			    			//单击打开节点
			    			$("#container").on("select_node.jstree",function(e, data){
			    				var node = data.node;
								var isTem = node.original.isTem;
								var formMid = node.original.formMid;
								var isFormTemplate = node.original.isFormTemplate;
								var templateType = '${param.templateType }';
								var parentNodeId = $('#container').jstree('get_parent',node.id);//刷新用
								if(isTem){
									var type =node.original.type;
									var docType = '';
									var flowOrDoc = '';
									if(templateType == '2'){
										flowOrDoc = '1';
									}else if(templateType == '1'){
										docType = '1';
									}else if(templateType == '3'){//底表
									}
									document.getElementById('InfoIframe').src='<%=path %>/templet/tem_toCompositePage.action?parentNodeId='+parentNodeId+'&isFormTemplate='+isFormTemplate+'&mBizId='+node.id+'&mid='+formMid+'&tempCls=${param.templateType}&docType='+docType+'&type='+type+'&flowOrDoc='+flowOrDoc;
								}
			    			}).jstree();
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
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['新建子目录'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/flow/addTemplateList.jsp?addType=dir&parentId='+nodeid+'&type='+templateType,
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
		var typeRoot2 = {
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
		   <%--
			"create":null,  
			"rename":null,  
			"ccp":null,
			"newsubdirectory":{  
				"label":"新建子目录",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['新建子目录'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/flow/addTemplateList.jsp?addType=dir&type='+templateType+'&parentId='+nodeid,
					});
				}
			},
			--%>
			"newmodule":{  
				"label":"新建模版",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var type = node.original.type;
					layer.open({
						    	id:'layerNewmodule',
								type : 2,//iframe 层
								
								title : ['新建模版'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/form/html5/admin/flow/addTemplateList.jsp?addType=template&parentId='+nodeid+'&type='+type+'&tempCls=${param.templateType }',
								//end	: function(){
								//	$('#container').jstree(true).refresh_node(node);
								//}
					});
				}
			},
			"change":{  
				"label":"编辑目录",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/edit.png", 
				"action":function(data){
					var node = $('#container').jstree('get_node',data.reference[0]);
					var nodeid = node.original.id;
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					layer.open({
						    	id:'layerNewsubdirectory',
								type : 2,//iframe 层
								
								title : ['编辑目录'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '50%', '50%' ],
								content : '<%=request.getContextPath()%>/templet/tem_loadToEditPage.action?uuid='+nodeid,
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
			"remove":{  
				"label":"删除",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/delete.png", 
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',data.reference[0]);
					/*
					if(confirm('确定要删除'+node.text+'吗?')){
						$.post(
							"<%=path%>/templet/tem_deleteNode.action",
							{ 
								nodeType: node.original.isTem?'template':'directory', 
								nodeId: node.id
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
					*/
					Matrix.confirm('确定要删除'+node.text+'吗?',function(value){
						value=true;
						if(value){
							$.post(
									"<%=path%>/templet/tem_deleteNode.action",
									{ 
										nodeType: node.original.isTem?'template':'directory', 
										nodeId: node.id
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
					});
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
						"<%=path%>/templet/tem_moveNode.action",
						{ 
							nodeId: node.id,
							otherNodeId: prevdom,
							nodeType: node.original.isTem?'template':'directory' 
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
						"<%=path%>/templet/tem_moveNode.action",
						{ 
							nodeId: node.id,
							otherNodeId: nextdom,
							nodeType: node.original.isTem?'template':'directory' 
						},
						function(){
							$('#container').jstree(true).refresh_node(parentId);
						}
					);
				}
			}
		};
		//模版右键
		var typeform = {
				"create":null,  
				"rename":null,  
				"ccp":null,
				"copy":{  
					"label":"复制",
					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/copy.png", 
					"action":function(data){
						var node = $('#container').jstree('get_node',data.reference[0]);
						var nodeid = node.original.id;
						var parentId = $('#container').jstree('get_parent',data.reference[0]);
						var templateType = '${param.templateType }';//公文还是协同
						layer.open({
					    	id:'copy',
							type : 2,//iframe 层
							
							title : ['模版复制'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '60%', '70%' ],
							content : '<%=request.getContextPath()%>/templet/tem_toCopyPage.action?templateType='+templateType+'&nodeid='+nodeid,
							end:function(){
								document.getElementById('maskDiv').style.display='none';
								$('#container').jstree(true).refresh_node(parentId);
								//layer.alert('复制完成！');
							}
						});
					}
				},
				<%-- "move":{  
					"label":"迁移",
					"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/transfer.png", 
					"action":function(data){
						var node = $('#container').jstree('get_node',data.reference[0]);
						var nodeid = node.original.id;
						var templateType = '${param.templateType }';//公文还是协同
						layer.open({
					    	id:'move',
							type : 2,//iframe 层
							
							title : ['模版迁移'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '50%', '50%' ],
							content : '<%=request.getContextPath()%>/form/html5/admin/logon/matrix/html5TemplateMove.jsp?templateType='+templateType+'&nodeid='+nodeid,
							end:function(){
								document.getElementById('maskDiv').style.display='none';
							}
						});
					}
				},--%>
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
						/*
						if(confirm('确定要删除'+node.text+'吗?')){
							$.post(
								"<%=path%>/templet/tem_deleteNode.action",
								{ 
									nodeType: node.original.isTem?'template':'directory', 
									nodeId: node.id
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
						*/
						Matrix.confirm('确定要删除'+node.text+'吗?',function(value){
							value=true;
							if(value){
								$.post(
										"<%=path%>/templet/tem_deleteNode.action",
										{ 
											nodeType: node.original.isTem?'template':'directory', 
											nodeId: node.id
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
						});
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
							"<%=path%>/templet/tem_moveNode.action",
							{ 
								nodeId: node.id,
								otherNodeId: prevdom,
								nodeType: node.original.isTem?'template':'directory' 
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
							"<%=path%>/templet/tem_moveNode.action",
							{ 
								nodeId: node.id,
								otherNodeId: nextdom,
								nodeType: node.original.isTem?'template':'directory' 
							},
							function(){
								$('#container').jstree(true).refresh_node(parentId);
							}
						);
					}
				}
			};
		
		var id = data.id;
		var flag;
		if(id == 'root' || id == "flowRoot" || id == 'yewudibiao'){   //公文协同底表定制为根时只能新建子目录和刷新 
			if(id == 'root'){
				flag = typeRoot2;
			}else{
				flag = typeRoot;
			}
		}else{
			var isTem = data.original.isTem;
			if(isTem){
				flag = typeform;
			}else{
				flag = type1;
			}
		}
		return flag;
	}
	
	</script>
	</div>
		</div>
		<div id="col2" class="col-xs-10" style="height:100%; padding:0px;position: relative;">
			<iframe id="InfoIframe" style="width:100%;height:100%; " frameborder="0" src="<%=request.getContextPath()%>/form/admin/logon/matrix/welcome.jsp" ></iframe>
		</div>
</body>
</html>
