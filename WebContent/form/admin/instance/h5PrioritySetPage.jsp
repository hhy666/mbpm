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

	window.onload = function(){
		var priority = document.getElementById('priority').options;
		for(var i=0;i<priority.length;i++){
			if(<%=request.getAttribute("priority")%>==priority[i].value){
				priority[i].selected =true;
			}
		}
	}

	function confirmSubmit(){
		var priority = document.getElementById('priority').value;
		var piid = document.getElementById('piid').value;
		var aiid = document.getElementById('aiid').value;
		var data = {'priority':priority,'piid':piid,'aiid':aiid};
		Matrix.closeWindow(data,1);
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"	action="" style="padding-left:5px;margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded"><input type="hidden" name="Form0" value="Form0" />
		<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
		<input id="aiid" type="hidden" name="aiid" value="${param.aiid}" />
		<input id="piid" type="hidden" name="piid" value="${param.piid}" />
		<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
		<table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
			<tr style="height: 20%">
				<td class="maintain_form_content" colspan="2" rowspan="1" style="height: 30px;">
					<label id="label001" name="label001">
						该页面用于设定切换优先级的各种等级。
					</label>
				</td>
			</tr>
			<tr style="height: 60%">
				<td class="maintain_form_content" colspan="2" rowspan="1" style="height: 30px;display: inline">
					<select class="form-control select2-accessible" id="priority" name="priority" style="width:100px">
						<option value="0">普通</option>
						<option value="1">中级</option>
						<option value="2">高级</option>
						<option value="3">特级</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="8" style="text-align: center;">
					<div id="button1" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="确认" style="top:0;left:0;width:100%;height: 100%" onclick="confirmSubmit()">
					</div>
					<div id="button2" class="matrixInline">
						<input type="button" class="x-btn cancel-btn " value="取消" style="top:0;left:0;width:100%;height: 100%" onclick="Matrix.closeWindow(null,0)">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>