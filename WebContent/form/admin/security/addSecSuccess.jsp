<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<title>在此处插入标题</title>
<script type="text/javascript">
	function closeWindow(){
		Matrix.closeWindow();
	}
</script>
</head>
<body onload="closeWindow();">
 <jsp:include page="/form/admin/common/loading.jsp"/>
  <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
            <script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    
                    enctype:"multipart/form-data",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
  <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
            style="margin:0px;height:100%;" enctype="multipart/form-data">
              <input id="iframewindowid" name="iframewindowid" type="hidden" value="Dialog1" />
            </form>
</body>
</html>