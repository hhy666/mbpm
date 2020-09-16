<%@ page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="commonj.sdo.DataObject"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>	
<script type="text/javascript">
	var statusMessage = '<%=request.getAttribute("statusMessage")%>';
	function closeWindow(){
		var dialog = Matrix.getFormItemValue('iframewindowid');
		var importType = Matrix.getFormItemValue('importType');
		//var statusMessage = Matrix.getFormItemValue('statusMessage');
		var json = "{'importType':'"+importType+"'";
		
		if(statusMessage!=null && statusMessage.length>0 &&statusMessage!='null' && statusMessage!='undefined'){
			json+=",'statusMessage':'"+statusMessage+"'";
		}
		json+="}";
		var data =isc.JSON.decode(json);
		Matrix.closeWindow(data);
	}
	
</script>
</head>
<body onload="closeWindow()">
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>


<div style="width:100%;height:100%;overflow:auto;position:relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" 
	action="" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="multipart/form-data">

<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>
<input type="hidden" id="mid" name="mid" value="${param.mid }"/>
<input type="hidden" id="exportType" name="exportType" value="${param.exportType }"/>
<input type="hidden" id="importType" name="importType" value="${param.importType }"/>
<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid}"/>
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>

</form></div></body>
</html>
