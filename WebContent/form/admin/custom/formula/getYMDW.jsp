<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="commonj.sdo.DataObject"%>
<%@ page import="com.matrix.commonservice.data.DataService"%>
<%@ page
	import="com.matrix.client.foundation.common.helper.CommonServiceHelper"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.matrix.form.api.MFormContext"%>
<%@ page import="com.matrix.form.engine.foundation.FormStore"%>
<%@ page import="com.matrix.form.model.PropertyBasicInfo"%>
<%@ page import="com.matrix.form.model.form.FormVariable"%>
<%@ page import="com.matrix.form.model.config.FormContentHelper"%>
<%@ page import="com.matrix.form.model.FormContainer"%>
<%@ page import="com.matrix.form.model.form.FormModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<script type="text/javascript">
			function complete(){  //点击确认
				var selects = document.getElementById("formit1");
				var index = selects.selectedIndex;
				if(selects.options[index].text.indexOf("[日期变量]") == 0){
					var str = "([" +　selects.options[index].value + "])";
				}else{
					var str = "({" +　selects.options[index].value + "})";
				}	
				var data = {};
				data.value = str;
				Matrix.closeWindow(data);		
			}
		
		  	function closeWin(){ //点击取消
		  		Matrix.closeWindow();
		  	}
		</script>
		
		
		<style type="text/css">
#main {
	width: 90%;
	height: 45%;
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

.btn {
	text-align: center;
	height: 30px;
	width: 50px;
	background-color: #1B80D8;
	border-radius: 5px;
	color: #FFFFFF;
}
</style>
	</head>
	<body>
		
		<div id="main">
			表单域：
			<select id="formit1">
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
		</div>
		<div id="footer">
			<table style="margin: auto;">
				<tr>
					<td>
						<input class="btn" name="submitBtn" type="button" id="submitBut"
							onclick="complete();" value="确认" />
					</td>
					<td>
						<input  class="btn" name="cancelBtn" type="button" id="cancelBtn"
							onclick="closeWin();" value="取消" />
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
</script>