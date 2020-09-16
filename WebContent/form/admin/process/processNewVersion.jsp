<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.matrix.engine.foundation.config.MFSystemProperties"%>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="
		java.text.SimpleDateFormat,
		com.matrix.api.MFExecutionService,
   		com.matrix.api.identity.*,
		com.matrix.client.ClientConstants,
		java.util.*"%>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>置为最新版</title>
<script>
	var webContextPath = "/mofficeV3";
</script>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${iframewindowid}">
	<div style="width: 100%;height: 100%;">
		<table style="width: 100%;height: 100%;">
			<tr style="height: 80%;">
				<td>
					<textarea name="textArea" style="resize:none;width: 100%;height: 100%;"></textarea>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<button type="button" class="button" style="position:relative; bottom:0px;width: 100px;" onclick="button1Click()">
						确认
					</button>
					<button type="button" class="button" style="position:relative; bottom:0px;width: 100px;" onclick="button2Click()	">
						取消
					</button>
					<script>
						function button1Click(){
							var src = webContextPath+"/process/processTmplAction_processNewVersionResult.action";
							document.getElementById('Form0').action = src;
							document.getElementById('Form0').submit();
							var iframewindowid = document.getElementById('iframewindowid').value;
							parent.Matrix.getMatrixComponentById(iframewindowid).hide();
						}
						
						function button2Click(){
							var iframewindowid = document.getElementById('iframewindowid').value;
							parent.Matrix.getMatrixComponentById(iframewindowid).hide();
						}
					</script>
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>