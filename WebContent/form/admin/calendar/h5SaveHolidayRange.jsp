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
				elem: '#fromDate', 
				format: 'yyyy-MM-dd'			
			})
			laydate.render({
				elem: '#toDate', 
				format: 'yyyy-MM-dd'		
			})
		})
		
		function save(){
			var operationType = document.getElementById('operationType').value;
			var calendarId = document.getElementById('calendarId').value;
			var fromDate = document.getElementById('fromDate').value;
			var toDate = $("#toDate").val();
			if(valiadateTimeDuration(fromDate,toDate)){
				var data = {'fromDate':fromDate,'toDate':toDate,'operationType':operationType,'calendarId':calendarId};
				if("update"==operationType){
					data['holidayRangeId']  = document.getElementById('holidayRangeId').value;
	    		}
				Matrix.closeWindow(data);
			}
		}
		
		//验证时间
		function valiadateTimeDuration(fromDate,toDate){
			var result = Matrix.validateForm("Form0");
			if(result){
				var date1 = new Date(fromDate);
				var date2 = new Date(toDate);
				if(date1.getTime() < date2.getTime()){
					return true;
				}else{
					Matrix.warn('开始时间不能大于结束时间！');
					return false;
				}
			}
		}
	</script>
<title>编辑公共假日</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin:0px;overflow:hidden;height:100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="validateType" name="validateType" value="jquery">
		<input type="hidden" id="calendarId" name="calendarId" value="${calendarId }">
		<input type="hidden" id="operationType" name="operationType" value="${operationType }">
		<input id="holidayRangeId" type="hidden" name="holidayRangeId" value="${holidayRangeObj.id}"/>
		<div style="display: block;">
			<table class="maintain_form_content" style="width:100%;height:100%">
				<tr>
					<td class="maintain_form_label2" style="width: 30%;height: 25%">
						<label id="j_id3" name="j_id3">
							开始时间
						</label>
					</td>
					<td class="maintain_form_input2" style="width: 70%;height: 25%">
						<div id="inputDate001_div" class="date-default-width col-md-12  input-prepend input-group " style="display: inline-table; vertical-align: middle; width: 100%; ">
							<input required value="${holidayRangeObj.fromDate }" id='fromDate' name='fromDate' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
							<span class="input-group-addon addon-udSelect udSelect">
								<i class="fa fa-calendar"></i>
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
						<div id="inputDate002_div" class="date-default-width col-md-12  input-prepend input-group " style="display: inline-table; vertical-align: middle; width: 100%; ">
							<input required value="${holidayRangeObj.toDate }" id='toDate' name='toDate' class='form-control layer-date  ' style='width:100%;height:100%;padding-left: 5px;'/>
							<span class="input-group-addon addon-udSelect udSelect">
								<i class="fa fa-calendar"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="cmdLayout" colspan="2">
						<div id="button003_div" class="matrixInline" ">
							<input type="button" class="x-btn ok-btn " value="保存"  onclick="save()">
						</div>
						<div id="button004_div" class="matrixInline" ">
							<input type="button" class="x-btn cancel-btn " value="取消"  onclick="Matrix.closeWindow()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>