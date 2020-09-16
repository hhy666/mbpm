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
<title>交互数据标签页</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	#font2{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
	#td107{
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
</style>

</head>
<body>

<div style="width:100%;height:100%;position:relative;margin:0 auto;zoom:1" id="context">
    <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	    <input type="hidden" name="flowType" id="flowType" value="${param.flowType}" />
		<input type="hidden" name="activityId" id="activityId" value="${param.activityId}" />
		<input type="hidden" name="containerId" id="containerId" value="${param.containerId}" />
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
			<td id="td107" name="td107" colspan="1" style="width:100%;"><font id="font2">交互数据</font></td>
		</tr>
		<tr id="tr108" name="tr108">
			<td id="td108" name="td108" colspan="1" style="width:100%;">
				<ul id="TabContainer001" class="nav nav-tabs disable" />
				    <li><a href="#TabPanel001" data-toggle="tab" >基本信息</a></li>
				    <li><a href="#TabPanel002" data-toggle="tab" >输入数据映射</a></li>
				    <li><a href="#TabPanel003" data-toggle="tab" >输出数据映射</a></li>
				</ul>
				<div id="content-main" class="tab-content" style="border-color: #e7eaec;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;width:100%;">
					<script>
					$(document).ready(function () {
						debugger;
						$('#TabContainer001 a[href="#TabPanel001"]').tab('show');   //启用标签页
						var flowType = Matrix.getFormItemValue("flowType");
						var activityId = Matrix.getFormItemValue("activityId");
						var containerId = Matrix.getFormItemValue("containerId");
						if(flowType==0){      //编辑外部子流程活动时的交互数据
							document.getElementById('tab_iframe1').src = '<%=request.getContextPath()%>/editor/editor_getSubflowTypeDecla.action?activityId='+activityId+'&containerId='+containerId+'';
							document.getElementById('tab_iframe2').src = '<%=request.getContextPath()%>/editor/flow/inputParamListPage.jsp?activityId='+activityId+'&containerId='+containerId+'&flowType=0';
							document.getElementById('tab_iframe3').src = '<%=request.getContextPath()%>/editor/flow/outputParamListPage.jsp?activityId='+activityId+'&containerId='+containerId+'&flowType=0';
						}else{     //编辑流程时的交互数据
							document.getElementById('tab_iframe1').src = '<%=request.getContextPath()%>/editor/process_getCurDeclarations.action';
							document.getElementById('tab_iframe2').src = '<%=request.getContextPath()%>/editor/flow/inputParamListPage.jsp?flowType=1';
							document.getElementById('tab_iframe3').src = '<%=request.getContextPath()%>/editor/flow/outputParamListPage.jsp?flowType=1';	
						}
					})
					</script>
					<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'>
						<iframe class="J_iframe" id="tab_iframe1" src="" width="100%"  style='border-width: 0px;'></iframe>
					</div>
					<div class="tab-pane fade" id="TabPanel002" style='padding: 3px 3px 0px 3px;'>
						<iframe class="J_iframe" id="tab_iframe2" src="" width="100%" style='border-width: 0px; display:block;'></iframe>
					</div>
					<div class="tab-pane fade" id="TabPanel003" style='padding: 3px 3px 0px 3px;'>
						<iframe class="J_iframe" id="tab_iframe3" src="" width="100%" style='border-width: 0px; display:block;'></iframe>
					</div>
				</div>
			</td>
		</tr>
	</table>
  </form>
</div>
</body>
</html>
