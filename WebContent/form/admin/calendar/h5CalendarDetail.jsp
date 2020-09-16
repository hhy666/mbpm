<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
		document.getElementById('InfoIframe').src = '<%=path%>/calendar/calendarAction_getBusyDayOfWeekList.action?calendarId=${param.calendarId}';
	}
	
	function tabPanel002Click(){
		document.getElementById('InfoIframe').src = '<%=path%>/calendar/calendarAction_getBusyDayOfDateList.action?calendarId=${param.calendarId}';
	}
	
	function tabPanel003Click(){
		document.getElementById('InfoIframe').src = '<%=path%>/calendar/calendarAction_getHolidayRangeList.action?calendarId=${param.calendarId}';
	}
</script>
<title>业务日历内容</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post"	action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%; position: relative;">
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
					<a href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()">每周工作日</a>
				</li>
				<li>
					<a href="#TabPanel002" data-toggle="tab" onclick="tabPanel002Click()">特殊工作日</a>
				</li>
				<li>
					<a href="#TabPanel003" data-toggle="tab" onclick="tabPanel003Click()">公共假日</a>
				</li>
			</ul>
			<iframe id="InfoIframe" style="width:100%;height:calc(100% - 35px);top:30px " frameborder="0" src='<%=path%>/calendar/calendarAction_getBusyDayOfWeekList.action?calendarId=${param.calendarId}' >
			</iframe>
		</div>
		<div id="content-main" class="tab-content" style="display:none; border-color: #e7eaec;   -webkit-border-image: none;    -o-border-image: none;    border-image: none;    border-style: solid;    border-width: 1px;    border-top: 0px;width:100%;height:100%">
			<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'></div>
			<div class="tab-pane fade" id="TabPanel002" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
			<div class="tab-pane fade" id="TabPanel003" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
		</div>
	</form>
</body>
</html>