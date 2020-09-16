<%@page pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.api.MFormContext" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String urlPath = MFormContext.getFormProperties().getRootSrc();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<title>Insert title here</title>
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
						<script type="text/javascript">
							
							function proUrl(node){
								var url;
								var parentId = $('#container').jstree('get_parent',node);
								var parentNode = $('#container').jstree('get_node',parentId);
								if(node.id == '#'){
								//	url = "C:/";
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
											"url" : '<%=request.getContextPath()%>/templet/tem_h5LoadStatisticTree.action',
											"data" : function(node) {
												return {
													"root" : node.id ==="#"?"0":node.id,
													"templateType" : node.original==null?'':node.original.templateClass,
														"configUUID" : node.entityId==null?'':node.entityId,
													"mIsQueryMode" : false,
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
				    				var diagramId = node.id;
									var thetype = node.original.type;
									var formId = node.original.formId;
									if(thetype == 2){
										document.getElementById('InfoIframe').src="<%=path %>/matrix.rform?statisticsDiagramId="+diagramId+"&mIsStatisticsDiagram=true&mHtml5Flag=true";
									}
				    			}).jstree();
							});
						</script>
					</td>
				</tr>
			</table>
			<script>
				//菜单
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
				};
			</script>
			<script>
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