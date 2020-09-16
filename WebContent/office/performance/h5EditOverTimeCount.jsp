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
<title>超时分析列表</title>
<script type="text/javascript">
	//重置
	function refreshQuery(){
		$('#startTime').val('');
		$('#endTime').val('');
		$('#selectTemplet').val('');
		document.getElementById("complete").checked = true;
		document.getElementById("notFinish").checked = true;
		document.getElementById("cutout").checked = true;;
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
	
	//统计
	function forwardPage(){
		var complete = "";
		var notFinish = "";
		var cutout = "";
		var startTime = document.getElementById("startTime").value;
		var endTime = document.getElementById("endTime").value;
		var templetId = document.getElementById("templetId").value;
		var completeTemp = document.getElementById("complete");
		var notFinishTemp = document.getElementById("notFinish");
		var cutoutTemp = document.getElementById("cutout");
		if(completeTemp.checked == true){
			complete = "1";
		}
		if(notFinishTemp.checked == true){
			notFinish = "1";
		}
		if(cutoutTemp.checked == true){
			cutout = "1";
		}
		var src = "<%=path%>/office/performance/h5Tabovertime.jsp?templetId="+templetId+"&startTime="+startTime+"&endTime="+endTime+"&complete="+complete+"&notFinish="+notFinish+"&cutout="+cutout;
		document.getElementById('InfoIframe').src = src;
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="templetId" id="templetId">
		<input type="hidden" name="url" id="url">
		<input type="hidden" name="type" id="type">
		<div style="display:block;height:22%">
		    <table class="query_form_content" style="width: 100%; height: 100%;">
				<tr>
					<td style="float: left;" colspan="2">
						<table class="query_form_content" style="width: 100%">
							<tr>
								<td class="maintain_form_label2">
									<label>模版流程</label>
								</td>
								<td class="tdLayout" style="width: 20%">
									<input class="form-control" type="text" id="selectTemplet" name="selectTemplet" onfocus="templateSelect()" placeholder="请选择模板">
								</td>
								<td class="maintain_form_label2" style="width: 20%">
									<label>流程状态</label>
								</td>
								<td  class="tdLayout" style="width: 40%">
									<input class="box" type="checkbox" id="complete" name="complete" checked="checked">已结束
									<input class="box" type="checkbox" id="notFinish" name="notFinish" checked="checked">未结束
									<input class="box" type="checkbox" id="cutout" name="cutout" checked="checked">终止
								</td>
							</tr>
							<tr>
								<td class="maintain_form_label2" >
									<label>时间</label>
								</td>
								<td class="tdLayout" colspan="4">
									<div class='date-default-width col-md-12  input-prepend input-group ' style='display: inline-table; vertical-align: middle; '>
										<input id='startTime' name='startTime' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;' onClick="if(document.getElementById('startTime').readOnly == false){laydate({istime:false, format: 'YYYY-MM-DD'})}"/>
											<span class="input-group-addon addon-udSelect udSelect" onClick="laydate({elem:'#startTime',istime:false, format: 'YYYY-MM-DD'})">
											<i class="fa fa-calendar"></i>
										</span>
									</div>
									<div style="display: inline;">
										<label>至</label>
									</div>
									<div class='date-default-width col-md-12  input-prepend input-group ' style='display: inline-table; vertical-align: middle; '>
										<input id='endTime' name='endTime' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;' onClick="if(document.getElementById('endTime').readOnly == false){laydate({istime:false, format: 'YYYY-MM-DD'})}"/>
											<span class="input-group-addon addon-udSelect udSelect" onClick="laydate({elem:'#endTime',istime:false, format: 'YYYY-MM-DD'})">
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
			<iframe id="InfoIframe" style="width:100%;top:30px;height: 100%" frameborder="0" src="<%=path%>/office/performance/h5Tabovertime.jsp">
			</iframe>
		</div>
	</form>
</body>
</html>