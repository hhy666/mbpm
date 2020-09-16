<%@page import="com.matrix.office.chinese.util.ChineseUtill"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />

		<style type="text/css">
#main {
	width: 90%;
	height: 40%;
	text-align: center;
	position: absolute;
	margin-top : 2px;
}

#footer {
	width: 99%;
	height: 40px;
	position: fixed;
	bottom: 0; table-cell;
	background-color: #F2F2F2;
	text-align: center;
	line-height: 40px;
}

.btn{
	text-align: center;
	height: 30px;
	width: 50px;
	background-color: #1B80D8;
	border-radius: 5px;
	color: #FFFFFF;
}
</style>
	<script>
	
		function closeWin(){
			Matrix.closeWindow();
		}
		function changed(){
			var data = {};
			var divider
			var radios = document.getElementsByName("dayType");
			if(radios[1].checked==true){
				document.getElementById("value").value="";
			}else{
				document.getElementById("value").value="";
			}
			
		}
		function complete(){
			var data = {};
			var divider
			var radios = document.getElementsByName("dayType");
			var str 
			var dividend = document.getElementById("dividend").value;
			if(radios[1].checked==true){
				divider=document.getElementById("value").value;
				str = "getMod("+dividend+"},"+divider+")";
			}else{
				var selects = document.getElementsByTagName("select");
				 divider = selects[0].value;
				 str = "getMod({"+dividend+"},{"+divider+"})";
			}
			
			data.value = str ;
			Matrix.closeWindow(data);
		}
	</script>
	</head>

	<body>
		<div id="main">
		<%
			String dividend = ChineseUtill.toChinese(request.getParameter("value"));
		 %>
			&nbsp;&nbsp;被除数：&nbsp;&nbsp;&nbsp;
			<input name="dividend" id="dividend" value="<%=dividend %>" readonly="readonly" width="150px" />
			</br>
			
			<label>
			<input name="dayType" type="radio" value="0"  onchange="changed()"  checked/>
			选择除数：
			<select name="divider" id="divider" style="width: 175px;">
				<c:forEach var="dividerVar" items="${dividerVars}">
					<option value="${dividerVar}">${dividerVar}</option>
				</c:forEach>
			</select>
			</label>
			</br>
			<label>
			<input name="dayType" type="radio" value="1" onchange="changed()" />
			手工输入:
			<input name="value" id="value" type="text" value=""  />
			</label>
		</div>
		<div id="footer">
			<table style="margin: auto;">
				<tr>
					<td>
						<input  class="btn" name="submitBtm" type="button" id="submitBtm"
							onclick="complete();" value="确认" />
					</td>
					<td>
						<input class="btn" name="cancelBtn" type="button" id="cancelBtn" onclick="closeWin();" value="取消" />
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>