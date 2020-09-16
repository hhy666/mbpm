<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.api.MFExecutionService"%>
<%@ page import="com.matrix.form.api.MFormContext"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String urlPath = MFormContext.getFormProperties().getRootSrc();
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8' />
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
	<div id="col1"
		style="height: 100%; padding: 0px; border-right: inset; border-right-width: 1px;">
		<div id="tablediv" style="width: 100%; height: 80%; overflow: auto;">

			<table style="width: 100%;">
				<tr>
					<td style="width: 100%; height: 85%;">
						<div id="container"
							style="background: #fff; font-size: 12px; height: 100%;"></div> <!-- include the minified jstree source -->
						<script type="text/javascript">
						
						$(document).ready(function() {
							var tree=	$('#container').jstree({
								'core' : {
									'multiple' : false,
									//'dblclick_toggle': false,
				    				'data' : {
										"url" : '<%=path%>/templet/tem_h5LoadData.action',
										"data" : function(node) {
														var templateType = '${param.templateType }';
														var isCopyTime = '${param.isCopyTime }';
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
			            		"plugins" : [ "themes", "json_data","crrm"]
							});
			
			    			//加载二级菜单
			    			$("#container").on("load_node.jstree", function(e, data){
			    				//取jstree根节点角
			    				var inst = data.instance;  
			    			    var obj = inst.get_node(e.target.firstChild.firstChild.lastChild); 
			    			    
					    		$('#container').jstree(true).open_node(obj);
			    			}).jstree();
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
								var pathStr = node.text;
								var parentId = $('#container').jstree('get_parent',node);
								data['parentId'] = parentId;
								
								while(true){
									//父节点
									if(parentId == 'root' || parentId == 'flowRoot' || parentId == 'yewudibiao'){
										break;
									}
									var parentNode = $('#container').jstree('get_node',parentId);
									pathStr = parentNode.text + "/"+ pathStr;
									parentId = $('#container').jstree('get_parent',parentNode);
								}
								
								data['id'] = node.id;
								data['name'] = node.text;
								data['pathStr'] = pathStr;
								Matrix.closeLayerWindow(data);
							});
							
							$('#button002').click(function(){
								var data = {};
								data['id'] = "";
								data['name'] = "";
								data['pathStr'] = "";
								Matrix.closeLayerWindow(data);
							});
						</script>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
