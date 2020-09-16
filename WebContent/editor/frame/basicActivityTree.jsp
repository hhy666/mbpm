<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>活动树</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
		<style type="text/css">
			#td105{/** 属性结构标题td*/
				width:100%;
				height:30px;
				background:#F8F8F8;
			}
			#td106{/** 属性结构内容td*/
				width:100%;
				height:94%;
				border:1px #dedede solid;
			}
			#font1{
				font-size:14px;
				margin-left:10px;
				font-weight:bold;
			}
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
		<script type="text/javascript">
			function refreshTreeNodeById(name){
				var parentNodeId = Matrix.getFormItemValue('parentNodeId');       //父节点
				var selectedNode = $('#container').jstree(true).get_selected();   //当前选中的节点
				$('#container').jstree(true).rename_node(selectedNode, name);
			}
		</script>		
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="<%=request.getContextPath()%>/editor/editor_manageTree.action" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input type="hidden" id="flag" name ="flag" value="initLoad"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="processdid" name="processdid" value="${param.processdid }"/>
	<input type="hidden" id="processType" name="processType" value="${param.processType }"/>
	<input type="hidden" id="activityId" name="activityId" value="${param.activityId }"/>
	<input type="hidden" id="type" name="type" value="${param.type }"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType }"/>
	<input type="hidden" name="parentNodeId" id="parentNodeId" />
	
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
		<tr id="tr105" name="tr105">
			<td id="td105" name="td105"><font id="font1">属性结构</font></td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdLayout" style="width:100%;height:100%;text-align:left;">
				<!-- 属性结构树-->
			    <div id="container" style="background: #fff; font-size: 12px; height: 100%;overflow: auto"></div>
			    <script type="text/javascript">
				    $(document).ready(function() {
				    	var type = $('#type').val();
				    	var activityId = $('#activityId').val();
				    	var processdid = $('#processdid').val();
				    	var containerId = $('#containerId').val();
						var tree=$('#container').jstree({
							'core' : {
								"check_callback" : true,//默认为flase，会导致无法使用修改树结构。
								'multiple' : false,    //设置为单选
								"animation" : false,   //打开/关闭动画持续时间（以毫秒为单位） - 将此设置false为禁用动画（默认为200）
								'dblclick_toggle': false,  //禁止双击（ 默认为true）
			    				'data' : {
									"url" : "<%=path %>/editor/editor_manageTree.action",
									"data" : function(node) {
										return {
											"root" : node.id ==="#"?"0":node.id,
											"type" : type,	
											"activityId" : activityId,
											"processdid" : processdid,
											"containerId" : containerId
										};
									},
									"dataType" : "json",
									"type" : "post"
								},
								'themes' : {
									'icons' : true
								}
							},	     
							"plugins" : [ "wholerow" ]
						});
			
						
		    			//单击打开节点
		    			$("#container").on("select_node.jstree",function(e, data){
		    				
		    				var processType = Matrix.getFormItemValue('processType');
		    				var type = Matrix.getFormItemValue('type');
		    				var processdid = Matrix.getFormItemValue('processdid');
		    				var containerId = Matrix.getFormItemValue('containerId');
		    				var containerType = Matrix.getFormItemValue('containerType');
		    				var activityId = Matrix.getFormItemValue('activityId');
		    				var optType = Matrix.getFormItemValue('optType');
		    				
		    				var node = data.node.original;
		    				var entityId = node.entityId;  //树节点id
		    				var parentNodeId = $('#container').jstree('get_parent',node.id); //父节点刷新用
		    				Matrix.setFormItemValue('parentNodeId',parentNodeId);
		    				
		    				if(entityId=='jbxx'){//基本信息
		    					var custom = Matrix.getFormItemValue('custom');
		    					var url = "<%=request.getContextPath()%>/editor/editor_getCurActivityBasicInfo.action?entityId="+entityId+"&activityId="+activityId+"&custom="+custom+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType+"&processType="+processType;
		    					parent.document.getElementById('main_iframe1').src = url;
		    				}else if(entityId=='rwfp'){//任务分派
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/editor_getCurActivityTaskAssignInfo.action?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(entityId=='hdsx'){//活动时限
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/editor_getCurActivityDuration.action?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(entityId=='baohan'){//包含
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/activity/executorListPage.jsp?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(entityId=='paichu'){//排除
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/activity/notExecutorListPage.jsp?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(entityId=='kzsx'){//扩展属性
		    					parent.document.getElementById('main_iframe1').src  = "<%=request.getContextPath()%>/editor/activity/expandInsPropertyPage.jsp?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(entityId=='gjsx'){//高级属性
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/editor_getAdvancePropertyInfo.action?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(parentNodeId=='fzsj'){//辅助事件
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/activity/assistEventListPage.jsp?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(parentNodeId=='rwtx'){//活动提醒 根据点击的节点不同查询不同的提醒方式
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/activity/taskRemindListPage.jsp?entityId="+entityId+"&activityId="+activityId+"&parentNodeId="+parentNodeId+"&optType="+optType+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(entityId == 'dhdsl'){//多活动实例
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/activity/mulitActivityInsPage.jsp?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}else if(entityId == 'jhsj'){//交互数据
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/flow/interactiveDataTabPage.jsp?processdid="+processdid+"&activityId="+activityId+"&flowType=0&containerId="+containerId+"&containerType="+containerType;
		    				}
		    				
		    			}).jstree();
		    			
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
			    </script>
			</td>
		</tr>
	</table>
</form>
</div>

</body>
</html>