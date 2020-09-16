<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
        </title>
        
		<jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
			function closeWindow(){
				var importResult = "${requestScope.importResult}";
				if(importResult!=null){
					importResult = isc.JSON.decode(importResult);
					if(importResult.result==true){
						Matrix.closeWindow(importResult.pkgTid);
					}else{
						Matrix.closeWindow();
					}
			    }
			}
		</script>
    </head>
    
    <body onload="closeWindow()">
       <form>
       	<input id="iframewindowid" name="iframewindowid" type="hidden" value="${requestScope.iframewindowid}">
       </form>
    </body>

</html>


