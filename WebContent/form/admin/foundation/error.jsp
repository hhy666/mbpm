<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<head></head>
	<body>
	<h1>页面出错了！</h1><br>
	错误信息：
	<hr><br>
	<div id="errorMessage" style="color: red">
	${requestScope.exception}
	<div>
	
	</body>
</html>