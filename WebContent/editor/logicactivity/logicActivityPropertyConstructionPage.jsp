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
<title>属性结构树</title>
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
			
			.jstree-default .jstree-node-children {
				background: url("<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/tree/node.png") no-repeat
					#fff;
				background-position: 50% 50%;
				background-size: auto;
			}
			
		</style>
		<script type="text/javascript">
			function refreshTreeNodeById(){
				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
				$('#container').jstree(true).refresh_node(parentNodeId);
			}
		</script>		
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="<%=request.getContextPath()%>/editor/unit_getEditInfoByUnit.action" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input type="hidden" id="flag" name ="flag" value="initLoad"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="activityId" name="activityId" value="${param.activityId }"/>
	<input type="hidden" id="optType" name="optType" value="${param.optType }"/>
	<input type="hidden" id="type" name="type" value="${param.type }"/>
	<input type="hidden" id="processdid" name="processdid" value="${param.processdid }"/>
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
				    	var activityId = $('#activityId').val();
				    	var containerId = $('#containerId').val();
				    	var processdid = $('#processdid').val();
				    	var type = $('#type').val();
						var tree=$('#container').jstree({
							'core' : {
								'multiple' : false,    //设置为单选
								"animation" : false,   //打开/关闭动画持续时间（以毫秒为单位） - 将此设置false为禁用动画（默认为200）
								'dblclick_toggle': false,  //禁止双击（ 默认为true）
			    				'data' : {
									"url" : "<%=path %>/editor/unit_getEditInfoByUnit.action",
									"data" : function(node) {
										return {
											"root" : node.id ==="#"?"0":node.id,
											"activityId" : activityId,
											"containerId" : containerId,
											"processdid" : processdid,
											"type" : type
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
		    				var type = Matrix.getFormItemValue('type');//逻辑活动的各个类型 开始、结束、并发、合并、条件
		    				var containerType = Matrix.getFormItemValue('containerType');
		    				var activityId = Matrix.getFormItemValue('activityId');
		    				var processdid = Matrix.getFormItemValue('processdid');
		    				var optType = Matrix.getFormItemValue('optType');
		    				var containerId = Matrix.getFormItemValue('containerId');
		    				
		    				var node = data.node.original;
		    				var entityId = node.entityId;  //树节点id
		    				var parentNodeId = $('#container').jstree('get_parent',node.id); //父节点刷新用
		    				Matrix.setFormItemValue('parentNodeId',parentNodeId);
		    				
		    				if(entityId=='jbxx'){//基本信息
		    					var custom = Matrix.getFormItemValue('custom');
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/editor_getLogicActivityByType.action?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId;
		    				}else if(entityId=='gjsx'){//高级属性
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/editor_getLogicActivityAdvPro.action?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId;
		    				}else if(parentNodeId=='fzsj'){  //辅助事件
		    					parent.document.getElementById('main_iframe1').src = "<%=request.getContextPath()%>/editor/activity/assistEventListPage.jsp?entityId="+entityId+"&activityId="+activityId+"&type="+type+"&processdid="+processdid+"&containerId="+containerId+"&containerType="+containerType;
		    				}

		    			}).jstree();
					});		
			    </script>
			</td>
		</tr>
	</table>
</form>
</div>

</body>
</html>