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
	//打印
	function load(){
		var str = "<%=path%>/performance/pri_comprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&templetId=${param.templetId}";
		Matrix.setFormItemValue('url',str);  
		window.open('<%=path%>/office/performance/print.jsp');
	}  
	
	//导出
	function exportExcel(){
		var searchForm = document.getElementById("Form0");
		searchForm.action = "<%=path%>/performance/pri_exportexcel.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&templetId=${param.templetId}";
		searchForm.target = "penTarget";
		searchForm.submit();
	}
	
	//表格标签
	function tabPanel001Click(){
		document.getElementById('InfoIframe').src = "<%=path%>/performance/per_comprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&templetId=${param.templetId}";
	}
	
	//图标标签
	function tabPanel002Click(){
		document.getElementById('InfoIframe').src = "<%=path%>/performance/per_chartComprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&templetId=${param.templetId}";
	}
</script>
<title>综合分析标签页</title>
</head>
	<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; width:100%;height: 100%;overflow:auto;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="url" id="url">
		<table class="query_form_content" style="height: 100%">
			<tr>
				<td style="height: 30px">
					<label style="padding-left: 10px">统计结果:</label>
					<a onclick="load()" style="padding-left: 10px;padding-right: 10px">打印</a>
					<a onclick="exportExcel()" style="padding-left: 10px;padding-right: 10px">导出</a>
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
						<iframe id="InfoIframe" style="width:100%;height:calc(100% - 35px);top:30px " frameborder="0" src="<%=path%>/performance/per_comprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&templetId=${param.templetId}">
							
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