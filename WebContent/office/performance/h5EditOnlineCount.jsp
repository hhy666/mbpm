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
<title>在线时间分析列表</title>
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
			$('#comboBox002')[0].selectedIndex  = 0;
			$('#userName').val('');
			$('#selectTime').style.display = 'none';
		}
		
		//人员列表
		function userSelect(){
			layer.open({
				type:2,
				title:['人员选择'],
				area:['85%','85%'],
				content:'<%=path%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=UserSelect'
			});
		}
		
		function onUserSelectClose(data){
			if(data!=null){
				var userNames = data.names;
				var adminId = data.ids;
			 	document.getElementById("userName").value = userNames;
			 	document.getElementById("userId").value = adminId;
			}
		}
		
		//统计
		function forwardPage(){
			var startTime = document.getElementById("startTime").value;
			var endTime = document.getElementById("endTime").value;
			var userName = document.getElementById("userName").value;
			var userId = document.getElementById("userId").value;
			var type = document.getElementById("comboBox002").value;
			var src = "<%=path%>/office/performance/h5Tabonline.jsp?userId="+userId+"&userName="+userName+"&type="+type+"&startTime="+startTime+"&endTime="+endTime;
			document.getElementById('InfoIframe').src = src;
		}
	</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="userId" id="userId">
		<input type="hidden" name="url" id="url">
		<input type="hidden" name="type" id="type">
		<div style="display:block;height:15%">
		    <table class="query_form_content" style="width: 100%; height: 100%;">
				<tr>
					<td style="float: left;" colspan="1">
						<table class="query_form_content" style="width: 100%">
							<tr>
								<td class="maintain_form_label2" style="width:15%">
									<label>选择人员</label>
								</td>
								<td class="tdLayout" style="width:15%">
									<div style='display: inline-table; vertical-align: middle; '>
										<input class="form-control" type="text" id="userName" name="userName"  onfocus="userSelect()" placeholder="请选择人员">
									</div>
								</td>
								<td class="maintain_form_label2" style="width:15%">
									<label>时间</label>
								</td>
								<td class="tdLayout" style="width:55%">
									<div style="padding-right: 5px;vertical-align: middle;display: inline-table;width: 25%">
										<select class="form-control select2-accessible" id="comboBox002" name="comboBox002">
											<option value="0" selected>本日</option>
											<option value="1">本周</option>
											<option value="2">本月</option>
											<option value="3">任意</option>
										</select>
									</div>
									<script>
										$('#comboBox002').change(function(){
											if($(this)[0].value == "3"){
												$('#selectTime')[0].style.display = "inline-table";
											}else{
												$('#selectTime')[0].style.display = "none";
											}
										});
									</script>
									<div id="selectTime" style="padding-left:5px;width: 65%;display: none;vertical-align: middle;display: none;">
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
		<div style="display:block;height:85%">
			<iframe id="InfoIframe" style="width:100%;top:30px;height: 100%" frameborder="0" src="<%=path%>/office/performance/h5Tabonline.jsp">
			</iframe>
		</div>
	</form>
</body>
</html>