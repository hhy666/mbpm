<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>表单预览窗口</title>
<style type="text/css">
	div, ul{
		box-sizing: border-box;
	}
</style>
<jsp:include page="/form/admin/common/resource.jsp" />
</head>
<body style="background: rgba(245,245,247,.9)">
	<div style="position: relative;height: calc(100% - 20px);;width: 85%;margin: auto;margin-top: 10px;border: 1px solid rgb(231, 234, 236); box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16), 0 2px 8px 0 rgba(0,0,0,0.12);overflow: hidden;">
		<div style="padding-left:20px;width: 100%;height: 40px;line-height:40px;border-bottom: 1px solid #cccccc;background-color: white;">
			<label style="font-weight: bold;font-size: 16px;color: rgb(22, 105, 171);">
				表单预览
			</label>
		</div>
		<div style="width: 100%;height: 20px;background-color: white">
		</div>
		 <div id="container" style="height: calc(100% - 60px);width:100%;margin: auto;padding:0px 10px;overflow: auto;background: #fff;font-size: 12px;">
		 	 <iframe id="iframeContent" src="<%=request.getContextPath()%>/matrix.rform?mode=debug&mHtml5Flag=true" style="width:100%;height:100%;" frameborder="0"/>
	    </div>
	</div>
	<div style="width: 100%;height: 20px;background-color: white">
	</div>
</body>
</html>