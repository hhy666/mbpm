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
<title>流程统计列表</title>
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
			$("input[name='radioGroup001']").get(0).checked = true; 
			$("input[name='radioGroup002']").get(0).checked = true; 
			$('#templet')[0].style.display = 'none';
			$('#dep')[0].style.display = '';
			$('#user')[0].style.display = 'none';
		}
		
		function userSelect(){
			layer.open({
				type:2,
				title:['人员选择'],
				area:['85%','85%'],
				content:'<%=path%>/office/html5/select/SingleSelectPerson.jsp?uuid=${param.uuid}&iframewindowid=UserSelect'
			});
		}
		
		function onUserSelectClose(data){
			if(data!=null){
				var id = data.ids;
				var name = data.names;
			 	document.getElementById("user").value = name;
			 	document.getElementById("userId").value = id;
			}
		}
		
		function depSelect(){
			layer.open({
				type:2,
				title:['部门选择'],
				area:['85%','85%'],
				content:'<%=path%>/office/html5/select/SingleSelectDep.jsp?uuid=${param.uuid}&iframewindowid=DepSelect'
			});
		}
		
		function onDepSelectClose(data){
			if(data!=null){
				var id = data.ids;
				var name = data.names;
			 	document.getElementById("dep").value = name;
			 	document.getElementById("depId").value = id;
			}
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
			 	document.getElementById("templet").value = userNames;
			 	document.getElementById("templetId").value = adminId;
			}
		}
		
		//统计
		function forwardPage(){
			var type;
			var statisType;
			var flowType = document.getElementById("comboBox001").value;
			var startTime = document.getElementById("startTime").value;
			var endTime = document.getElementById("endTime").value;
			var templetId = document.getElementById("templetId").value;
			var userId = document.getElementById("userId").value;
			var depId = document.getElementById("depId").value;
			var flag1 = document.getElementsByName("radioGroup001");
			var flag2 = document.getElementsByName("radioGroup002");
			if(flag1[0].checked == true){
				type='0';
			}else{
				type='1';
			}
			if(flag2[0].checked == true){
				statisType='0';
			}else{
				statisType='1';
			}
			document.getElementById("type").value = type;
			var src = "<%=path%>/office/performance/h5Tabflow.jsp?flowType="+flowType+"&type="+type+"&statisType="+statisType+"&startTime="+startTime+"&endTime="+endTime+"&templetId="+templetId+"&userId="+userId+"&depId="+depId;
			document.getElementById('InfoIframe').src = src;
		}
	</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="templetId" id="templetId">
		<input type="hidden" name="userId" id="userId" value="" />
		<input type="hidden" name="depId" id="depId" value="root" />
		<input type="hidden" name="url" id="url">
		<input type="hidden" name="type" id="type">
		<div style="display:block;height:22%">
		    <table class="query_form_content" style="width: 100%; height: 100%;">
				<tr>
					<td style="float: left;" colspan="2">
						<table class="query_form_content" style="width: 100%">
							<tr>
								<td class="maintain_form_label2" colspan='1'>
									<label>流程类型</label>
								</td>
								<td class="tdLayout" colspan='2'>
									<div style="padding-right: 5px;display: inline-block;width: 100%">
										<select disabled="disabled" class="form-control select2-accessible" id="comboBox001" name="comboBox001">
											<option value="0" selected>协同</option>
											<option value="1">公文</option>
										</select>
									</div>
								</td>
								<td class="maintain_form_label2"  colspan='1'>
									<label>流程模板</label>
								</td>
								<td class="tdLayout" colspan="2">
									<div style='display: inline-table; vertical-align: middle; '>
										<input type="radio" name="radioGroup001" value="0" checked="checked">全部模板
										<input type="radio" name="radioGroup001" value="1">指定模板
									</div>
									<div style='display: inline-table; vertical-align: middle; '>
										<input class="form-control" type="text" id="templet" name="templet" style="display: none;" onfocus="templateSelect()" placeholder="请选择模板">
									</div>
								</td>
								<script type="text/javascript">
									$(document).ready(function() {
									    $('input[type=radio][name=radioGroup001]').change(function() {
									        if (this.value == '0') {
									           $('#templet')[0].style.display = 'none';
									        }
									        else if (this.value == '1') {
									        	$('#templet')[0].style.display = '';
									        }
									    });
									});
								</script>
							</tr>
							<tr>
								<td class="maintain_form_label2" colspan='1'>
									<label>时间</label>
								</td>
								<td class="tdLayout" colspan="2">
									<div class='date-default-width col-md-12  input-prepend input-group ' style='width:150px;display: inline-table; vertical-align: middle; '>
										<input id='startTime' name='startTime' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
											<span class="input-group-addon addon-udSelect udSelect">
											<i class="fa fa-calendar"></i>
										</span>
									</div>
									<div style="display: inline;">
										<label>至</label>
									</div>
									<div class='date-default-width col-md-12  input-prepend input-group ' style='width:150px;display: inline-table; vertical-align: middle; '>
										<input id='endTime' name='endTime' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
											<span class="input-group-addon addon-udSelect udSelect">
											<i class="fa fa-calendar"></i>
										</span>
									</div>
								</td>
								<td class="maintain_form_label2"  colspan='1'>
									<label>统计到</label>
								</td>
								<td class="tdLayout" colspan="2">
									<div style='display: inline-table; vertical-align: middle; '>
										<input type="radio" name="radioGroup002" value="0" checked="checked">部门
										<input type="radio" name="radioGroup002" value="1">人员
									</div>
									<div style='display: inline-table; vertical-align: middle; '>
										<input value="全公司" class="form-control" type="text" id="dep" name="dep" onfocus="depSelect()">
										<input style="display: none" class="form-control" type="text" id="user" name="user" onfocus="userSelect()" placeholder="请选择人员">
									</div>
								</td>
								<script type="text/javascript">
									$(document).ready(function() {
									    $('input[type=radio][name=radioGroup002]').change(function() {
									        if (this.value == '0') {
									           $('#dep')[0].style.display = '';
									           $('#user')[0].style.display = 'none';
									        }
									        else if (this.value == '1') {
									           $('#dep')[0].style.display = 'none';
									        	$('#user')[0].style.display = '';
									        }
									    });
									});
								</script>
							</tr>
							<tr>
								<td class="tdLayout" style="text-align:center;padding:10px;" colspan="6" >
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
			<iframe id="InfoIframe" style="width:100%;top:30px;height: 100%" frameborder="0" src="<%=path%>/office/performance/h5Tabflow.jsp">
			</iframe>
		</div>
	</form>
</body>
</html>