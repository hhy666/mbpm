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
<title>交互式组件标签页</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	#font2{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
	#td107{
		width:100%;
		height:32px;
		background:#F8F8F8;
	}
</style>

</head>
<body>

<div style="width:100%;height:100%;position:relative;margin:0 auto;zoom:1" id="context">
    <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	    <input type="hidden" id="appdid" name="appdid" value="${param.appdid}" />
		<input type="hidden" id="entityId" name="entityId" value="${param.entityId }"/>
		<input type="hidden" id="parentNodeId" name="parentNodeId" value="${param.parentNodeId }"/>
		<input type="hidden" id="index" name="index" value="${param.index }"/>
	<script>
	$(document).ready(function () {
		var ifm=$(".J_iframe");
		ifm.height(document.documentElement.clientHeight);
	});
	window.onresize=function(){ 
		var ifm=$(".J_iframe");
		ifm.height(document.documentElement.clientHeight);
	}
	</script>
	
	<table id="table001" class="tableLayout" style="width:100%;	height:30px;margin-bottom:5px;" >
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107" colspan="1" style="width:100%;">
				<font id="font2">
				 <% 
					String entityId=request.getParameter("entityId");
					if("jhszj".equals(entityId)){
				 %>
					 交互式组件
		 		 <%
		 			}else{
		  		 %>
		  			非交互式组件
		  		 <%
		  			} 
		  		 %>
		  		</font>
		  	</td>
		</tr>
		<tr id="tr108" name="tr108">
			<td id="td108" name="td108" colspan="1" style="width:100%;">
				<ul id="TabContainer001" class="nav nav-tabs disable" />
				    <li><a href="#TabPanel001" data-toggle="tab" >属性</a></li>
				</ul>
				<div id="content-main" class="tab-content" style="border-color: #e7eaec;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;width:100%;">
					<script>
					$(document).ready(function () {
						debugger;
						$('#TabContainer001 a[href="#TabPanel001"]').tab('show');   //启用标签页
					})
					</script>
					<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'>
						<iframe class="J_iframe" id="tab_iframe1" src="<%=request.getContextPath()%>/editor/process_editApplication.action?index=${param.index}&entityId=${param.entityId}&appdid=${param.appdid}" width="100%"  style='border-width: 0px;'></iframe>
					</div>
				</div>
			</td>
		</tr>
	</table>
  </form>
</div>
</body>
</html>
