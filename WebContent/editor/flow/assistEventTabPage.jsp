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
<title>辅助事件标签页</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>
<body>

<div style="width:100%;height:100%;position:relative;margin:0 auto;zoom:1" id="context">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
  	<input type="hidden" id="entityId" name="entityId" value="${param.entityId }"/>
	<input type="hidden" id="parentNodeId" name="parentNodeId" value="${param.parentNodeId }"/>
	<input type="hidden" id="index" name="index" value="${param.index }"/>
	<input type="hidden" id="processdid" name="processdid" value="${param.processdid }"/>
	
	<ul id="TabContainer001" class="nav nav-tabs disable" style="height:32px;"/>
	    <li><a href="#TabPanel001" data-toggle="tab" >属性</a></li>
	    <li><a href="#TabPanel002" data-toggle="tab" >时间</a></li>
	</ul>
	<div id="content-main" class="tab-content" style="height:calc(100% - 32px);width:100%;border-color: #e7eaec;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;">
		<script>
		$(document).ready(function () {
			debugger;
			$('#TabContainer001 a[href="#TabPanel001"]').tab('show');   //启用标签页
			var eventType = Matrix.getFormItemValue('parentNodeId');;
			if(eventType!='yhdys') {//非用户自定义  时间标签不显示
				$("#TabContainer001").children("li:last-child").hide();
			}
		})
		</script>
		<div class="tab-pane fade in active" id="TabPanel001" style='height:100%;padding: 3px 3px 0px 3px;'>
			<iframe class="J_iframe" src="<%=request.getContextPath()%>/editor/process_getAssistEventDetailInfoById.action?entityId=${param.entityId}&flag=1&parentNodeId=${param.parentNodeId}&index=${param.index}&processdid=${param.processdid}" width="100%"  style='height:100%;border-width: 0px;'></iframe>
		</div>
		<div class="tab-pane fade" id="TabPanel002" style='height:100%;padding: 3px 3px 0px 3px;'>
			<iframe class="J_iframe"  src="<%=request.getContextPath()%>/editor/process_getAssistUserDefinedPage.action?entityId=${param.entityId}&flag=2&parentNodeId=${param.parentNodeId}&index=${param.index}&processdid=${param.processdid}" width="100%" style='height:100%;border-width: 0px; display:block;'></iframe>
		</div>
	</div>
  </form>
</div>
</body>
</html>
