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
	//保存
	function save(){
		var result = Matrix.validateForm('Form0');
		if(result){
				var operationType = document.getElementById('operationType').value;
				var	calendarId = document.getElementById('calendarId').value;
				var	calendarName = document.getElementById('calendarName').value;
				var	description = document.getElementById('description').value;
				validateBeforeSubmit(calendarId,calendarName);
				var data = {'calendarId':calendarId,'calendarName':calendarName,'description':description,'operationType':operationType};
				Matrix.closeWindow(data);
		}else{
			return false;
		}
	}
	
	//提交前验证
	function validateBeforeSubmit(calendarId,calendarName){
		var idUrl = "<%=path%>/calendar/calendarAction_isExistCalendarId.action?calendarId="+calendarId;
		var nameUrl = "<%=path%>/calendar/calendarAction_isExistCalendarName.action?calendarId="+calendarId+"&calendarName="+calendarName;
		validateId(idUrl);
		validateName(nameUrl);
	}
	
	//验证编码重复
	function validateId(idUrl){
		Matrix.sendRequest(idUrl,null,function(data){
			var result = data.data;
			if(result){
				Matrix.warn("编码重复!");
				return false;
			}
		});
	}
	
	//验证名称重复
	function validateName(nameUrl){
		Matrix.sendRequest(nameUrl,null,function(data){
			var result = data.data;
			if(result){
				Matrix.warn("名称重复!");
				return false;
			}
		});
	}
</script>
<title>添加业务日历</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin:0px;overflow:hidden;height:100%;" enctype="application/x-www-form-urlencoded">
		<input id="operationType" type="hidden" name="operationType" value="${param.operationType}"/>
		<input id="validateType" type="hidden" name="validateType" value="jquery"/>
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	编码
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="title_div" eventProxy="Mform0" class="matrixInline" style="width: 100%">
						<input class="form-control" required type="text" name="calendarId" id="calendarId" style="WIDTH:90%;HEIGHT:30px;" value="${calendar.calendarId}" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id3" name="j_id3">
						名称
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="width_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" required type="text" name="calendarName" id="calendarName" style="WIDTH:90%;HEIGHT:30px;" value="${calendar.calendarName}">
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;height: 72px">
					<label id="j_id6" name="j_id6">
						描述
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;height: 72px">
					<div class="matrixInline" style="width:100%;height: 100%">
						<textarea class="form-control" name="description" id="description" style="WIDTH:90%;HEIGHT:100%;resize:none;outline: none">${calendar.description}</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="2">
					<div id="button003_div" class="matrixInline" >
						<input type="button" class="x-btn ok-btn " value="保存"  onclick="save()">
					</div>
					<div id="button004_div" class="matrixInline" >
						<input type="button" class="x-btn cancel-btn " value="取消"  onclick="Matrix.closeWindow()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>