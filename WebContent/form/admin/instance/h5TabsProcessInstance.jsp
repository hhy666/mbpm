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
			document.getElementById('InfoIframe').src = "<%=path%>/instance/processInstance_queryProcessInses.action?processDID=${processDID}";
		}
		function tabPanel002Click(){
			document.getElementById('InfoIframe').src = "<%=path%>/instance/activityInsAction_queryActivityInses.action?processDID=${processDID}";
		}
		function tabPanel003Click(){
			document.getElementById('InfoIframe').src = "<%=path%>/instance/processInstance_queryHistoryProcessInses.action?processDID=${processDID}";
		}
		function tabPanel004Click(){
			document.getElementById('InfoIframe').src = "<%=path%>/instance/activityInsAction_queryHistoryActivityInses.action?processDID=${processDID}";
		}
	</script>
</head>
<body>
	<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1" id="context">
		<form id="Form0" name="Form0" method="post"	action="/entity" style="margin: 0px; height: 100%;"	enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="Form0" value="Form0"/>
			<input name="type" id="type" type="hidden" value="${catalogInfo.comType}">
			<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
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
				<ul id="TabContainer001" class="nav nav-tabs disable" style="padding-top:5px;border-bottom:1px solid #cccccc"/>
					<li>
						<a href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()">流程实例列表</a>
					</li>
					<li>
						<a href="#TabPanel002" data-toggle="tab" onclick="tabPanel002Click()">活动实例列表</a>
					</li>
					<li>
						<a href="#TabPanel003" data-toggle="tab" onclick="tabPanel003Click()">流程实例历史列表</a>
					</li>
					<li>
						<a href="#TabPanel004" data-toggle="tab" onclick="tabPanel004Click()">活动实例历史列表</a>
					</li>
				</ul>
				<iframe id="InfoIframe" style="width:100%;height:calc(100% - 42px); " frameborder="0" src="<%=path%>/instance/processInstance_queryProcessInses.action?processDID=${processDID}" >
				</iframe>
			</div>
			<div id="content-main" class="tab-content" style="display:none; border-color: #e7eaec;   -webkit-border-image: none;    -o-border-image: none;    border-image: none;    border-style: solid;    border-width: 1px;    border-top: 0px;width:100%;height:100%">
				<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'></div>
				<div class="tab-pane fade" id="TabPanel002" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
				<div class="tab-pane fade" id="TabPanel003" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
				<div class="tab-pane fade" id="TabPanel004" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
			</div>
		</form>
	</div>
</body>
</html>