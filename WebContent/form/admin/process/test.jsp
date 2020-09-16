<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在此处插入标题</title>
</head>
<body>

<% 
  String value = request.getParameter("mndpxjhspdfield0");
String value2 = request.getParameter("test");
  System.out.println("=========="+value2+"========== value is:" + value);
%>

</body>
</html>