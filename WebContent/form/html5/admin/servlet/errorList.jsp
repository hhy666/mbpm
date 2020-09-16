<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.matrix.mobile.ErrorBean" %>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/skin_styles.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css" rel="stylesheet"></link>
<style type="text/css">
h5,h3{
	text-align: center;
}
div{
	overflow: auto;
}
td{
	border-bottom: 1px solid #cccccc;
}
body{
	padding: 0px;
	margin: 0px;
}
</style>
</head>
<body>
	<div>
		<h3>导入出错</h3>
		<label>${errorMessage }</label>
		<h5>请检查以下信息</h5>
	</div>
	<div>
		<table width="100%" cellspacing="0" cellpadding="0">
			<thead>
				<tr style="background-color: #fafafa; height:36px;">
					<td class="headerButton" style="width: 10%; text-align: center; vertical-align: middle; font-size: 14px; background-color: #b5dbeb">
						  行号
					</td>
					<td class="headerButton" style="width: 10%; text-align: center; vertical-align: middle; font-size: 14px; background-color: #b5dbeb">
						 列号
					</td>
					<td class="headerButton" style="width: 80%; text-align: left; vertical-align: middle; font-size: 14px; background-color: #b5dbeb">
						信息
					</td>
				</tr>
			</thead>
			<tbody>
					<%
						if(request.getAttribute("errorList")!= null){
							List list = (List)request.getAttribute("errorList");
							for(int i=0; i<list.size(); i++){
								ErrorBean eb = (ErrorBean)(list.get(i));
								if(eb.getRowNum() == null){
									%>
									<tr>
										<td colspan="3" style="height:35px;"><%=eb.getMessage() %></td>
									</tr>
							<% 
								}else{
									%>
									<tr>
										<td style="height:35px; text-align: center;"><%=eb.getRowNum()!=null?eb.getRowNum():"" %></td>
										<td style="height:35px; text-align: center;"><%=eb.getColNum()!=null?eb.getColLetter():"" %></td>
										<td style="height:35px;"><%=eb.getMessage() %></td>
									</tr>
							<% 
								}
							}
						}
					%>
			</tbody>
		</table>
	</div>
</body>
</html>