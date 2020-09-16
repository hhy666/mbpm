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
		$(function(){
			laydate.render({
				elem: '#dayOfDate', 
				format: 'yyyy-MM-dd'				
			})
		})
		
		function save(){
			var operationType = document.getElementById('operationType').value;
			var calendarId = document.getElementById('calendarId').value;
			var dayOfDate = document.getElementById('dayOfDate').value;
			var fromTime = document.getElementById('fromTime').value;
			var toTime = $("#toTime").val();
			if(valiadateTimeDuration(fromTime,toTime)){
				var data = {'fromTime':fromTime,'toTime':toTime,'dayOfDate':dayOfDate,'operationType':operationType,'calendarId':calendarId};
				if("update"==operationType){
					data['busyDayOfDateId']  = document.getElementById('busyDayOfDateId').value;
	    		}
				Matrix.closeWindow(data);
			}
		}
		
		//验证时间
		function valiadateTimeDuration(fromTime,toTime){
			var result = Matrix.validateForm("Form0");
			if(result){
				var date = new Date();
				var from = fromTime.split(":");
				var to = toTime.split(":");
				if(date.setHours(from[0],from[1]) < date.setHours(to[0],to[1])){
					return true;
				}else{
					Matrix.warn('开始时间不能大于结束时间！');
					return false;
				}
			}
		}
	</script>
<title>编辑特殊工作日</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin:0px;overflow:hidden;height:100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="validateType" name="validateType" value="jquery">
		<input type="hidden" id="calendarId" name="calendarId" value="${calendarId }">
		<input type="hidden" id="operationType" name="operationType" value="${operationType }">
		<input id="busyDayOfDateId" type="hidden" name="busyDayOfDateId" value="${busyCalendarDate.id}"/>
		<div style="display: block;">
			<table class="maintain_form_content" style="width:100%;height:100%">
				<tr>
					<td class="maintain_form_label2" style="width: 30%;height: 25%">
						<label id="j_id0" name="j_id0">
						 	日期
						</label>
					</td>
					<td class="maintain_form_input2" style="width: 70%;height: 25%">
						<div id="inputDate001_div" class="date-default-width col-md-12  input-prepend input-group " style="display: inline-table; vertical-align: middle; width: 100%;">
							<input required value="${busyCalendarDate.date }" id='dayOfDate' name='dayOfDate' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
							<span class="input-group-addon addon-udSelect udSelect">
								<i class="fa fa-calendar"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="maintain_form_label2" style="width: 30%;height: 25%">
						<label id="j_id3" name="j_id3">
							开始时间
						</label>
					</td>
					<td class="maintain_form_input2" style="width: 70%;height: 25%">
						<div id="inputTime001_div" class="input-group  default-width clockpicker " style="  display: inline-table;vertical-align: middle;width: 100%;"  data-autoclose="true"  >
							<input required id="fromTime" name="fromTime" type="text" class="form-control " style="width:100%;" value="${busyCalendarDate.fromTime }" > 
							<span class="input-group-addon addon-udSelect udSelect">
								<i class="fa fa-clock-o"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="maintain_form_label2" style="width: 30%;height: 25%">
						<label id="j_id6" name="j_id6">
							结束时间
						</label>
					</td>
					<td class="maintain_form_input2" style="width: 70%;height: 25%">
						<div id="inputTime002_div" class="input-group  default-width clockpicker " style="  display: inline-table;vertical-align: middle;width: 100%;"  data-autoclose="true"  >
							<input required id="toTime" name="toTime" type="text" class="form-control " style="width:100%;" value="${busyCalendarDate.toTime }" > 
							<span class="input-group-addon addon-udSelect udSelect">
								<i class="fa fa-clock-o"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="cmdLayout" colspan="2">
						<div id="button003_div" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="保存" onclick="save()">
						</div>
						<div id="button004_div" class="matrixInline">
							<input type="button" class="x-btn cancel-btn " value="取消" onclick="Matrix.closeWindow()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>