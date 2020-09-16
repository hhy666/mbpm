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
	function tabPanel001Click(){
		document.getElementById('InfoIframe').src = '<%=path%>/instance/processInstance_getProcessInsMsg.action?piid=${param.piid}&detailType=${param.detailType}';
	}
	
	function tabPanel002Click(){
		document.getElementById('InfoIframe').src = '<%=path%>/instance/processInstance_getProcessInsVar.action?piid=${param.piid}&detailType=${param.detailType}';
	}
	
	function tabPanel003Click(){
		document.getElementById('InfoIframe').src = '<%=path%>/instance/processInstance_getActivtityInsesByPiid.action?piid=${param.piid}';
	}
</script>
</head>
<body>
	<div style="width:100%;height:100%;overflow:hidden;position:relative;margin:0 auto;zoom:1" id="context">
		<form id="Form0" name="Form0" method="post"	action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="Form0" value="Form0" />
			<input type="hidden" name="detailType" id="detailType" value="${param.detailType}" />
			<input type="hidden" name="piid" id="piid" value="${param.piid}" />
			<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
			<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
			<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
				<script>
				    $(document).ready(function () {
				        var ifm = $(".J_iframe");
				        ifm.height(document.documentElement.clientHeight);
					    $('#TabContainer001 a[href="#TabPanel001"]').tab('show');
				    });
				    window.onresize = function () {
				        var ifm = $(".J_iframe");
				        ifm.height(document.documentElement.clientHeight);
				    }
				</script>
				<ul id="TabContainer001" class="nav nav-tabs disable" style="position: relative;height: 30px"/>
					<li>
						<a href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()">流程实例信息</a>
					</li>
					<li>
						<a href="#TabPanel002" data-toggle="tab" onclick="tabPanel002Click()">流程实例变量</a>
					</li>
					<li>
						<a href="#TabPanel003" data-toggle="tab" onclick="tabPanel003Click()">活动实例列表</a>
					</li>
				</ul>
				<iframe id="InfoIframe" style="width:100%;height:calc(100% - 84px);top:30px " frameborder="0" src='<%=path%>/instance/processInstance_getProcessInsMsg.action?piid=${param.piid}&detailType=${param.detailType}' >
				</iframe>
			</div>
			<div id="content-main" class="tab-content" style="display:none; border-color: #e7eaec;   -webkit-border-image: none;    -o-border-image: none;    border-image: none;    border-style: solid;    border-width: 1px;    border-top: 0px;width:100%;height:100%">
				<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'></div>
				<div class="tab-pane fade" id="TabPanel002" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
				<div class="tab-pane fade" id="TabPanel003" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
			</div>
			<div id="button001" class="cmdLayout" style="text-align: center;">
				<input type="button" class="x-btn cancel-btn " value="关闭" onclick="Matrix.closeWindow()">
			</div>
		</form>
	</div>
</body>
</html>