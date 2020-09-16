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
<title>添加更新触发事件标签页</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	body, ul{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	}
	div, ul{
		box-sizing: border-box;
	}
</style>
<script type="text/javascript">
	//记录iframe中的一级弹出窗口
	var iframeJs;
	
	//选择指定人员或消息接收人窗口回调
	function onpersonsClose(data){
		iframeJs.onpersonsClose(data);
	}
	
	//选择流程窗口回调
	function onflowClose(data){
		iframeJs.onflowClose(data);
	}
	
	//选择流程模板窗口回调
	function onflowTemplateClose(data){
		iframeJs.onflowTemplateClose(data);
	}
	
	//选择节点窗口回调
	function oncheckPointClose(data){
		iframeJs.oncheckPointClose(data);
	}
	
	//选择目标表单窗口回调
	function onformTreeClose(data){
		iframeJs.onformTreeClose(data);
	}
	
	//记录的消息接收人的组织机构编码
	var authUser = {};
</script>
</head>
<body>

<div style="width:100%;height:100%;position:relative;margin:0 auto;zoom:1" id="context">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" id="optString" name="optString" value="${param.optString }"/>   <!-- 操作类型  0添加  1修改 -->
	<input type="hidden" id="index" name="index" value="${param.index }"/>

	<ul id="TabContainer001" class="nav nav-tabs disable" style="height:32px;"/>
	    <li><a href="#TabPanel001" data-toggle="tab" id="tabVal">添加触发事件</a></li>
	</ul>
	<div id="content-main" class="tab-content" style="height:calc(100% - 32px);width:100%;border-color: #e7eaec;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;">
		<script>
		$(document).ready(function () {
			debugger;
			$('#TabContainer001 a[href="#TabPanel001"]').tab('show');   //启用标签页
			var optString = $("#optString").val();
			var index = $("#index").val();
			if(optString == '0'){   //添加
				$("#tabVal").text("添加触发事件");
				document.getElementById('J_iframe').src = "<%=request.getContextPath()%>/trigger/formProcessor_loadTriggerSet.action?optString=0";
			}else if(optString == '1'){   //修改
				$("#tabVal").text("更新触发事件");
				document.getElementById('J_iframe').src = "<%=request.getContextPath()%>/trigger/formProcessor_loadTriggerSet.action?index="+index+"&optString=1";
			}	
		})
		</script>
		<div class="tab-pane fade in active" id="TabPanel001" style='height:100%;padding: 3px 0px 0px 0px;'>
			<iframe class="J_iframe" id="J_iframe" src="" style='height:100%;width:100%;border-width: 0px;'></iframe>
		</div>
	</div>
  </form>
</div>
</body>
</html>
