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
<title>改进分析标签页</title>
<script type="text/javascript">
	//表格标签
	function tabPanel001Click(){
		document.getElementById('InfoIframe').src = "<%=path%>/performance/per_countImprove.action?templetId=${param.templetId}&startTime=${param.startTime}&endTime=${param.endTime}&startTime_2=${param.startTime_2}&endTime_2=${param.endTime_2}";
	}
	
	//图标标签
	function tabPanel002Click(){
		document.getElementById('InfoIframe').src = "<%=path%>/performance/per_chartImprove.action?templetId=${param.templetId}&startTime=${param.startTime}&endTime=${param.endTime}&startTime_2=${param.startTime_2}&endTime_2=${param.endTime_2}";
	}
	
	//打印
	function load(){
		var str = "<%=path%>/performance/pri_countImprove.action?templetId=${param.templetId}&startTime=${param.startTime}&endTime=${param.endTime}&startTime_2=${param.startTime_2}&endTime_2=${param.endTime_2}";
		Matrix.setFormItemValue('url',str);  
		window.open('<%=path%>/office/performance/print.jsp');
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; width:100%;height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="url" id="url">
		<table class="query_form_content" style="height: 100%">
			<tr>
				<td style="height: 30px">
					<label style="padding-left: 10px">统计结果:</label>
					<a onclick="load()" style="padding-left: 10px;padding-right: 10px">打印</a>
				</td>
			</tr>
			<tr>
				<td>
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
								<a href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()">表格</a>
							</li>
							<li>
								<a href="#TabPanel002" data-toggle="tab" onclick="tabPanel002Click()">图表</a>
							</li>
						</ul>
						<iframe id="InfoIframe" style="width:100%;height:calc(100% - 35px);top:30px " frameborder="0" src="<%=path%>/performance/per_countImprove.action?templetId=${param.templetId}&startTime=${param.startTime}&endTime=${param.endTime}&startTime_2=${param.startTime_2}&endTime_2=${param.endTime_2}">
							
						</iframe>
					</div>
					<div id="content-main" class="tab-content" style="display:none; border-color: #e7eaec;   -webkit-border-image: none;    -o-border-image: none;    border-image: none;    border-style: solid;    border-width: 1px;    border-top: 0px;width:100%;height:100%">
						<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'></div>
						<div class="tab-pane fade" id="TabPanel002" padding: 3px 3px 0px 3px; style='-webkit-border-image: none;    -o-border-image: none;  '></div>
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>