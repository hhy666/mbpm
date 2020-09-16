<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
	<script type="text/javascript">
	
		
		function forwardPageByNodeType(node){
			var src = "<%=path%>/instance/processInstance_loadTabsPage.action?processDID="+node.original.processDID;
			document.getElementById('InfoIframe').src =	src;
		}
		
		/* window.onload = function(){
			flag = "1";
		};
		
		function openAndClose(){
			if(flag=="1"){
				document.getElementById('HorizontalContainer001Panel1').style.display = 'none';
				document.getElementById('HorizontalContainer001Panel2').style.width = '100%';
				document.getElementById('HorizontalContainer001Panel2').style.marginLeft = '0px';
				flag = "0";
			}else if(flag = "0"){
				document.getElementById('HorizontalContainer001Panel1').style.display = 'unset';
				document.getElementById('HorizontalContainer001Panel2').style.width = 'calc(100% - 18%)';
				document.getElementById('HorizontalContainer001Panel2').style.marginLeft = '200px';
				flag = "1";
			}
			
		} */
		//树收起
		function retractDiv(){
			var tool = document.getElementById('tool');
			var tree = document.getElementById('HorizontalContainer001Panel1');
			var main = document.getElementById('HorizontalContainer001Panel2');
			tree.style.display = "none";
			main.style.width = "100%"
			main.style.marginLeft = '0px';
			main.style.left = "15px";
			tool.style.display = "";
		}
		
		//树展开
		function spreadDiv(){
			var tool = document.getElementById('tool');
			var tree = document.getElementById('HorizontalContainer001Panel1');
			var main = document.getElementById('HorizontalContainer001Panel2');
			tree.style.display = "";
			main.style.width = "calc(100% - 18%)";
			main.style.marginLeft = '18%';
			main.style.left = "0px";
			tool.style.display = "none";
			
		}
	</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="Form0" value="Form0" />
		<input type="hidden" name="componentType" id="componentType" value="17" />
		<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
		<div id="HorizontalContainer001" class="page page-full animation-fade page-data-tables" style="height:100%;">
			<div id="tool" class="col-xs-2" style="height:100%;width:15px;display:none;position: absolute;">
				<table style="width: 100%;height:100%;">
					<tr>
						<td><div id="spread" class="glyphicon glyphicon-forward" style="right:5px;" onclick="spreadDiv()"></div></td>
					</tr>
				</table>
			</div>
		    <div id="HorizontalContainer001Panel1" class="page-aside" style="width:18%;height: 100%;overflow:hidden;">
		    	<div style="background-color:rgb(248, 248, 248);width:100%;height:30px;">
		    		<table style="width:100%;height:100%;margin:0px;">
		    			<tr>
							<td style="height: 30px;padding-top: 7px;font-weight:bold;padding-left:35px;padding-bottom:5px;">目录树</td>
							<td style="right: 0px;position: relative;text-align: right;">
								<div id="retract" class="glyphicon glyphicon-backward" style="right:5px;" onclick="retractDiv()">
							</td>
				    	</tr>
		    		</table>
		    	</div>
		    	<div style="width:100%;height:calc(100% - 30px);overflow:auto">
			    	<table style="width:100%;height:100%;margin:0px;">				 	
						<tr>
							<td>
								<div id="container" style="background: #fff; font-size: 13px; height: 100%;">
									<script type="text/javascript">
										var componentType = document.getElementById('componentType').value;
										$(document).ready(function(){
											var tree = $('#container').jstree({
												'core':{
													'multiple':false,
													'data':{
														'url': '<%=path %>/instance/processInstance_treeShow.action',
														'data':function(node){
															return {
																"root" : node.id ==="#"?"flowRoot":node.id,
																"componentType" : componentType
															};
														},
														'dataType' : 'json',
														'type':'post'
													},
												},
												"plugins" : ["themes", "json_data","crrm","wholerow"]
											});
									
										
											//单击流程	
							    			$("#container").on("select_node.jstree",function(e, data){
							    				var node = data.node;
							    				var componentType = node.original.componentType;
												var parentNodeId = $('#container').jstree('get_parent',node.id);//刷新用
												if(componentType){
													forwardPageByNodeType(node);
												}
							    			}).jstree();
										});
									</script>
								</div>
							</td>
						</tr>
					</table>
		    	</div>
		    </div>
		    <div id="HorizontalContainer001Panel2" class="page-main" style="width:calc(100% - 18%);overflow: hidden;margin-left: 18%;position: relative;">
		    	<!-- <div style="height: 100%;width: 20px;background: red;vertical-align: middle;display: inline;">
	    			<button id="button0001" type="button" onclick="openAndClose()" style="width: 100%;height:50px;">展开</button>
    			</div> -->
   				<iframe id="InfoIframe" style="width:100%;height:100%; " frameborder="0" src="<%=path%>/form/admin/logon/matrix/welcome.jsp" >
   				</iframe>
		    </div>
		</div>
	</form>
</body>
</html>