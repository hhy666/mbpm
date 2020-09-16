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
	$(function(){
		laydate.render({
			elem: '#startTime', 
			format: 'yyyy-MM-dd',
		})
		laydate.render({
			elem: '#endTime', 
			format: 'yyyy-MM-dd',
		})
		laydate.render({
			elem: '#startTime_2', 
			format: 'yyyy-MM-dd',
		})
		laydate.render({
			elem: '#endTime_2', 
			format: 'yyyy-MM-dd',
		})	
	})
	//重置
	function refreshQuery(){
		$('#startTime').val('');
		$('#endTime').val('');
		$('#startTime_2').val('');
		$('#endTime_2').val('');
		$('#selectTemplet').val('');
	}
	
	//模板列表
	function templateSelect(){
		layer.open({
			type:2,
			title:['模板选择'],
			area:['85%','85%'],
			content:'<%=path%>/performance/tem_loadData.action?uuid=${param.uuid}&iframewindowid=TemplateSelect'
		});
	}
	
	function onTemplateSelectClose(data){
		if(data!=null){
			var userNames = data.templateNames;
			var adminId = data.mBizIds;
		 	document.getElementById("selectTemplet").value = userNames;
		 	document.getElementById("templetId").value = adminId;
		}
	}
	
	function forwardPage(){
		var startTime = document.getElementById("startTime").value;
		var endTime = document.getElementById("endTime").value;
		var startTime_2 = document.getElementById("startTime_2").value;
		var endTime_2 = document.getElementById("endTime_2").value;
		var templetId = document.getElementById("templetId").value;
		var src = "<%=path%>/office/performance/h5Tabimprove.jsp?templetId="+templetId+"&startTime="+startTime+"&endTime="+endTime+"&startTime_2="+startTime_2+"&endTime_2="+endTime_2;
		document.getElementById('InfoIframe').src = src;
	}
</script>
<title>改进分析列表</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="templetId" id="templetId">
		<div style="display:block;height:22%">
			<table class="query_form_content" style="width: 100%; height: 100%;">
				<tr>
					<td style="float: left;" colspan="2">
						<table class="query_form_content" style="width: 100%">
							<tr>
								<td class="maintain_form_label2" style="width: 20%">
									<label>模板流程</label>
								</td>
								<td class="tdLayout" style="width: 20%">
									<input class="form-control" type="text" id="selectTemplet" name="selectTemplet" onfocus="templateSelect()" placeholder="请选择模板">
								</td>
								<td class="maintain_form_label2" style="width: 20%">
									<label>对比区间一</label>
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
							<td class="tdLayout" colspan="2">
								</td>
								<td class="maintain_form_label2" style="width: 20%">
									<label>对比区间二</label>
								</td>
								<td class="tdLayout">
									<div class='date-default-width col-md-12  input-prepend input-group ' style='display: inline-table; vertical-align: middle; '>
										<input id='startTime_2' name='startTime_2' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
											<span class="input-group-addon addon-udSelect udSelect">
											<i class="fa fa-calendar"></i>
										</span>
									</div>
									<div style="display: inline;">
										<label>至</label>
									</div>
									<div class='date-default-width col-md-12  input-prepend input-group ' style='display: inline-table; vertical-align: middle; '>
										<input id='endTime_2' name='endTime_2' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
											<span class="input-group-addon addon-udSelect udSelect">
											<i class="fa fa-calendar"></i>
										</span>
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
		<div style="display:block;height:78%">
			<iframe id="InfoIframe" style="width:100%;top:30px;height: 100%" frameborder="0" src="<%=path%>/office/performance/h5Tabimprove.jsp">
			</iframe>
		</div>
	</form>
</body>
</html>