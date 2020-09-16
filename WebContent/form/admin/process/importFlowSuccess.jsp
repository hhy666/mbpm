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
	var message = '<%=request.getAttribute("statusMessage")%>';
	function showMsgInfo(){
		if(message=='sucess'){
			var data = {'message':message};
			//Matrix.closeWindow(data);
			window.opener.setInitFlag(false);
			window.opener.loadDiagramFromServer();
			window.close();
		}else{
			alert("读取本地流程文件失败");
			window.close();
		}	
	}
	
</script>
</head>
<body onload="showMsgInfo()">
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

<input type="hidden" id="iframewindowid" name="iframewindowid" value="Dialog0"/>
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>

</form></div></body>
</html>
