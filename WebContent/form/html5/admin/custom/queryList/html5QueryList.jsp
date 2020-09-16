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
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
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
				
				<td style="width: 100%; height: 80%;">
					
					<div id="container" style="background: #fff; font-size: 13px; height: 100%;"></div>

					<!-- include the minified jstree source -->
					<script type="text/javascript">
						
						$(document).ready(function() {
							var tree=	$('#container').jstree({
								'core' : {
									'multiple' : false,
									//'dblclick_toggle': false,
				    				'data' : {
										"url" : '<%=request.getContextPath()%>/templet/tem_h5LoadData4QueryAndUti.action',
										"data" : function(node) {
													return {
														"root" : node.id ==="#"?"0":node.id,
														"templateType" : node.original==null?'':node.original.templateClass,
														"configUUID" : node.entityId==null?'':node.entityId,
														"mIsQueryMode" : true,
													};
												},
										"dataType" : "json",
										"type":"post"
									},
									'themes' : {
										'icons' : true
									}
								},
			            		"plugins" : [ "themes", "json_data","crrm","wholerow"]  ,
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
			    			
			    			//单击打开节点
			    			$("#container").on("select_node.jstree",function(e, data){
			    				var node = data.node;
			    				var uuid = node.id;
								var thetype = node.original.type;
								var formId = node.original.formId;
								if(thetype == 2){
									document.getElementById('InfoIframe').src="<%=request.getContextPath()%>/matrix.rform?configUUID="+uuid+"&formId="+formId+"&mIsQueryMode=true&mHtml5Flag=true";
								}
			    			}).jstree();
						});
					</script>
				</td>
			</tr>
			<!-- <tr >
				<td class="cmdLayout">
					<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
					<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
					<script type="text/javascript">
						$('#button001').click(function(){
							var data = {};
							var nodes = $('#container').jstree(true).get_selected(true);
							if(nodes.length == 0 || nodes.length > 1){
								layer.alert("请选择数据！",{icon: 2});
								return;
							}
							if(nodes[0].original.type == 1){
								layer.alert("请勿选择目录！",{icon: 2});
								return;
							}
							var node = nodes[0];
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
			</tr> -->
		</table>
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
			"remove":{  
				"label":"删除",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/delete.png", 
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var node = $('#container').jstree('get_node',data.reference[0]);
					if(confirm('确定要删除'+node.text+'吗?')){
						$.post(
							"<%=request.getContextPath()%>/query/code_deleteH5.action",
							{ entityId: node.id, 
							  parentNodeId: parentId,
							  type: node.original.type,
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
				"label":"上移",
				"icon":"<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/move_up.png",
				"action":function(data){
					var parentId = $('#container').jstree('get_parent',data.reference[0]);
					var prevdom = $('#container').jstree('get_prev_dom',data.reference[0],true).context.id;
					var node = $('#container').jstree('get_node',data.reference[0]);
					$.post(
						"<%=path%>/query/code_loadDataGridDataH5.action",
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
						"<%=path%>/query/code_loadDataGridDataH5.action",
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
						var nodeid = node.id;
						var parentId = $('#container').jstree('get_parent',data.reference[0]);
						layer.open({
					    	id:'layerNewDir',
							type : 2,//iframe 层
							
							title : ['添加目录'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '90%', '50%' ],
							content : '<%=request.getContextPath()%>/query/code_h5LoadAddCodePage.action?parentUUID='+nodeid+'&parentNodeId='+nodeid+'&type=1&oType=add',
							//end	: function(){
							//	$('#container').jstree(true).refresh_node(node);
							//}
						});
					}
				},
				"newmodule":{  
					"label":"添加查询设置",
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
							
							title : ['添加目录'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '90%', '50%' ],
							content : '<%=request.getContextPath()%>/query/code_h5LoadAddCodePage.action?parentUUID='+nodeid+'&parentNodeId='+nodeid+'&type=2&oType=add&formValue='+theForm+'&formId='+formId,
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
						if(confirm('确定要删除'+node.text+'吗?')){
							$.post(
								"<%=path%>/query/code_deleteH5.action",
								{ entityId: node.id, 
								  parentNodeId: parentId,
								  type: node.original.type,
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
							"<%=path%>/query/code_loadDataGridDataH5.action",
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
							var nodeid = node.id;
							var parentId = $('#container').jstree('get_parent',data.reference[0]);
							layer.open({
						    	id:'layerNewDir',
								type : 2,//iframe 层
								
								title : ['添加目录'],
								closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
								shadeClose: false, //开启遮罩关闭
								area : [ '90%', '50%' ],
								content : '<%=request.getContextPath()%>/query/code_h5LoadAddCodePage.action?parentUUID='+nodeid+'&parentNodeId='+nodeid+'&type=1&oType=add',
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
	
	<script>
	var authUser={};

	isc.Window.create({
			ID:"MmainDialog",
			id:"mainDialog",
			name:"mainDialog",
			autoCenter: true,
			position:"absolute",
			height: "90%",
			width: "85%",
			title: "test",
			canDragReposition: true,
			showMinimizeButton:false,
			showMaximizeButton:true,
			showCloseButton:false,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel","maximizeButton",
				"closeButton"
			]
			
			//initSrc:
			//src:
	});
	MmainDialog.hide();
	</script>
	
	 </div>
	</div>
		<div id="col2" class="col-xs-10" style="height:100%; padding:0px;">
			<iframe id="InfoIframe" style="width:100%;height:100%; " frameborder="0" src="<%=request.getContextPath()%>/form/admin/logon/matrix/welcome.jsp" ></iframe>
		</div>
</body>
</html>
