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
<title>流程超期统计</title>
<script type="text/javascript">
		$(function(){
			laydate.render({
				elem: '#startTime', 
				format: 'yyyy-MM-dd',
			})
			laydate.render({
				elem: '#endTime', 
				format: 'yyyy-MM-dd',
			})
		})
		//重置
		function refreshQuery(){
			$('#startTime').val('');
			$('#endTime').val('');
			$('#comboBox001')[0].selectedIndex  = 0;
			$('#comboBox002')[0].selectedIndex  = 0;
		}
		
		//统计
		function forwardPage(){
			var flowType = document.getElementById("comboBox001").value;
			var status = document.getElementById("comboBox002").value;
			var startTime = document.getElementById("startTime").value;
			var endTime = document.getElementById("endTime").value;
			var src = "<%=path%>/office/performance/h5Taboverdue.jsp?flowType="+flowType+"&status="+status+"&startTime="+startTime+"&endTime="+endTime;
			document.getElementById('InfoIframe').src = src;
		}
	</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="templetId" id="templetId">
		<input type="hidden" name="url" id="url">
		<input type="hidden" name="type" id="type">
		<div style="display:block;height:21%">
		    <table class="query_form_content" style="width: 100%; height: 100%;">
				<tr>
					<td style="float: left;" colspan="2">
						<table class="query_form_content" style="width: 100%">
							<tr>
								<td class="maintain_form_label2">
									<label>流程类型</label>
								</td>
								<td class="tdLayout" style="width: 20%">
									<div style="padding-right: 5px;display: inline-block;width: 100%">
										<select disabled="disabled" class="form-control select2-accessible" id="comboBox001" name="comboBox001">
											<option value="0" selected>协同</option>
											<option value="1">公文</option>
										</select>
									</div>
								</td>
								<td class="maintain_form_label2" style="width: 20%">
									<label>时间</label>
								</td>
								<td class="tdLayout">
									<div class='date-default-width col-md-12  input-prepend input-group ' style='display: inline-table; vertical-align: middle; '>
										<input id='startTime' name='startTime' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
											<span class="input-group-addon addon-udSelect udSelect">
											<i class="fa fa-calendar"></i>
										</span>
									</div>
									<div style="display: inline;">
										<label>至</label>
									</div>
									<div class='date-default-width col-md-12  input-prepend input-group ' style='display: inline-table; vertical-align: middle; '>
										<input id='endTime' name='endTime' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
											<span class="input-group-addon addon-udSelect udSelect">
											<i class="fa fa-calendar"></i>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="maintain_form_label2">
									<label>状态</label>
								</td>
								<td class="tdLayout" colspan="1">
									<div style="padding-right: 5px;display: inline-block;width: 100%">
										<select class="form-control select2-accessible" id="comboBox002" name="comboBox002">
											<option value="0" selected>已办和当前待办</option>
											<option value="1">已办</option>
											<option value="2">当前待办</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLayout" style="text-align:center;padding:10px;" colspan="4" >
									<div id="button1" class="matrixInline" >
										<input type="button" class="x-btn ok-btn " value="统计"  onclick="forwardPage()">
									</div>
									<div id="button2" class="matrixInline" >
										<input type="button" class="x-btn ok-btn " value="重置"  onclick="refreshQuery()">
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>			
			</table>
		</div>
		<div style="display:block;height:79%">
			<iframe id="InfoIframe" style="width:100%;top:30px;height: 100%" frameborder="0" src="<%=path%>/office/performance/h5Taboverdue.jsp">
			</iframe>
		</div>
	</form>
</body>
</html>