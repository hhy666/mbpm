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
		
		function complete(){
			var data = {};
			var selects_start = document.getElementById("formit1");
			var selects_end = document.getElementById("formit2");
			var radios = document.getElementsByName("dayType");
			var str = "differDate(";
			if(radios[1].checked==true){
				str = "differDateBiz(";
			}
			var index_start = selects_start.selectedIndex;
			if(selects_start.options[index_start].text.indexOf("[日期变量]") == 0){
				str += "["+selects_start.options[index_start].value+"]";
			}else{
				str += "{"+selects_start.options[index_start].value+"}";
			}
			str += ",";
			var selects_end = selects_end.selectedIndex;
			if(selects_start.options[selects_end].text.indexOf("[日期变量]") == 0){
				str += "["+selects_start.options[selects_end].value+"]";
			}else{
				str += "{"+selects_start.options[selects_end].value+"}";
			}
			str += ")";
			data.value = str ;
			Matrix.closeWindow(data);
		}
	</script>
	</head>

	<body>
		<div id="main">
			表单域：
			<select name="formit1" id="formit1" style="width: 150px;">
				<c:forEach var="field" items="${entVal}">
					<option value="${field}">${field}</option>
				</c:forEach>
				<c:forEach var="dateVar" items="${dateVars}">
					<option value="${dateVar}">[日期变量]${dateVar}</option>
				</c:forEach>
				<c:forEach var="sysData" items="${sysDataVars}">
					<option value="${sysData}">[系统数据域]${sysData}</option>
				</c:forEach>
			</select>
			</br>
			操作符：
			<input type="text" name="operators" id="operators" value="-"
				style="width: 150px;" readonly="readonly"/>
			</br>
			表单域：
			<select name="formit2" id="formit2" style="width: 150px;">
				<c:forEach var="field" items="${entVal}">
					<option value="${field}">${field}</option>
				</c:forEach>
				<c:forEach var="dateVar" items="${dateVars}">
					<option value="${dateVar}">[日期变量]${dateVar}</option>
				</c:forEach>
				<c:forEach var="sysData" items="${sysDataVars}">
					<option value="${sysData}">[系统数据域]${sysData}</option>
				</c:forEach>
			</select>
			</br>
			<label>
			<input name="dayType" type="radio" value="0"  checked/>
			默认日期差
			</label>
			<label>
			<input name="dayType" type="radio" value="1"  />
			工作日日期差
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