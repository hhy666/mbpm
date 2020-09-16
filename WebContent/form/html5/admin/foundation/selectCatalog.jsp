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
		<title>选择</title>
		<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
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
		<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/refactor/html5RefactorAction_migrateComponent.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="width: 100%; height: 90%;">
					<div id="container"
						style="background: #fff; font-size: 12px; height: 100%;; overflow: auto;"></div>

					<!-- include the minified jstree source -->
					<script type="text/javascript">
						function proUrl(node){
							var url;
							var parentId = $('#container').jstree('get_parent',node);
							var parentNode = $('#container').jstree('get_node',parentId);
							if(node.id == '#'){
								url = "nodeData/";
							}else {
								var nodeUrl = node.original.mid+"/";
								url = proUrl(parentNode)+nodeUrl;
							}
							return url;
						}
						$(document).ready(function() {
							var isMigrateMesg = "${isMigrate }";
							if(isMigrateMesg == "save"){ 
								layer.alert("不可以迁移到当前模块！");
							}
							if( isMigrateMesg == "exception"){
								layer.alert("迁移时异常！");
							}
							var tree=	$('#container').jstree({
								'core' : {
									'multiple' : false,
									'dblclick_toggle': false,
				    				'data' : {
										"url" : '<%=path %>/common/html5Common_getCommonTree.action',
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
															"root" : node.id ==="#"?"0":node.id
															//"nodeUrl": proUrl(node)
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
			            		"plugins" : [ "themes", "json_data","crrm","contextmenu"]
							});
			
			        		//展开时候图标设置
			    			$('#container').on('open_node.jstree', function(e, datas) {  
				     			var nodeId = datas.node.id; 
				     			//$('#container').jstree(true).set_icon(nodeId, "jstree-node-online");
			    				// tree.set_icon(node,"jstree-node-offline");
			    			});
						    //收拢时候图标设置
						    $('#container').on('dblclick', function(e, datas) {  
						     	var nodeId = datas.node.id; 
						     	//$('#container').jstree(true).set_icon(nodeId, "jstree-node-offline");
						    	// tree.set_icon(node,"jstree-node-offline");
			    			});
			    			
			    			$('#container').on('load_node.jstree', function(e, data){
					    		$('#container').jstree(true).open_node("root");
			    			});
						});
					</script>
				</td>
			</tr>
			<tr>
				<td id="td2" class="cmdLayout" >
				<button type="button"  id="button001" class="x-btn ok-btn "  >确定</button>
				<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
				
				<input id="srcCompId" type="hidden" name="srcCompId" />
				<input id="cType" type="hidden" name="cType" value=${componentType } />
				<input id="targetModuleUuid" type="hidden" name="targetModuleUuid"  />
				<input id="srcEntityPath" type="hidden" name="srcEntityPath" />
				<script>
					$('#button001').click(function(data){
						var selected = $('#container').jstree(true).get_selected();
						if(selected.length == 1){
								var node = $('#container').jstree(true).get_node(selected[0]);
								var ctype = node.original.type;
								if(ctype != '2'){
									layer.alert("请选择模块！");
									return;
								}
								var parentnodeid = window.parent.$('#container').jstree(true).get_selected()[0];
								var parentnode = window.parent.$('#container').jstree(true).get_node(parentnodeid);
								$('#srcCompId').val(parentnode.original.mid);
								$('#srcEntityPath').val(parentnode.original.subItems);
								$('#targetModuleUuid').val(node.id);
								$('#form0').submit();
						}else{
							layer.alert("请选择一个模块！");
							return;
						}
					});
					
					$('#button002').click(function(){
						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
					});
				</script></td>
			</tr>
		</table>
		</form>
		</div>
	</body>
</html>
