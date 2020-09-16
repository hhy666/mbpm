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
	function modifyCodeNode(node){
		var url = node.original.url;
		var uuid = node.original.id;
		var type = node.original.type;
		if(type==0){//基本类型
	    	return;
	    }else if(type==1){
	    	return;
	    }else{
	    	var src = '<%=path%>/'+url+'?uuid='+uuid;
			document.getElementById('InfoIframe').src =	src;
	    }
	} 
</script>
<title>应用管理树</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<div id="HorizontalContainer001" class="page page-full animation-fade page-data-tables" style="height:100%;">
			<div id="HorizontalContainer001Panel1" class="page-aside" style="width:18%;height: 100%;overflow:hidden;">
				<div style="background-color:rgb(248, 248, 248);width:100%;height:30px;">
					<div style="height: 30px;padding: 7px;font-weight:bold;padding-left:30px;">目录树</div>
				</div>				
			    <div style="width:100%;height:calc(100% - 30px);overflow:auto">
		    		<table style="width:100%;height:100%;margin:0px;">
		    			<tr>
		    				<td>
		    					<div id="container" style="background: #fff; font-size: 12px; height: 100%;">
									<script type="text/javascript">
										$(document).ready(function(){
											var tree = $('#container').jstree({
												'core':{
													'multiple':false,
													'data':{
														'url': '<%=path %>/performance/code_h5performanceTree.action',
														'data':function(node){
															return {
																"root" : node.id ==="#"?"root":node.id,
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
							    				var uuid = node.original.id;
												if(uuid=="root"){
													return false;
												}else{
													modifyCodeNode(node);
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
				<iframe id="InfoIframe" style="width:100%;height:100%; " frameborder="0" src="<%=path%>/form/admin/logon/matrix/welcome.jsp" >
				</iframe>
		    </div>
		</div>
	</form>
</body>
</html>