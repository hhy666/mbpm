<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<script language="javascript" type="text/javascript">
		function complete(){
			var data = {};
			var content=document.getElementById('content').value;
			var operators=document.getElementById('operators').value;
			var val=document.getElementById('value').value;
			if(val==null||val==''||val=='undefined'||val==""){
			Matrix.warn("请输入值!");
			}else{
			data.value=operators;
			data.value+="("+content;
			data.value+=",'";
			data.value+=val;
			data.value+="')";
		  	Matrix.closeWindow(data);
		    }
		}
		function closeWin(){
			Matrix.closeWindow();
		}
	
</script>
		<style type="text/css">
#main {
	width: 90%;
	height: 90%;
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

#butt {
	text-align: center;
	height: 30px;
	width: 50px;
	background-color: #1B80D8;
	border-radius: 5px;
	color: #FFFFFF;
}

#butt1 {
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
		<%String text=com.matrix.office.chinese.util.ChineseUtill.toChinese(request.getParameter("text"));
		  String type = request.getParameter("type");  //是包含还是不包含
		  String content = "{"+text+"}";	
		 %>
		<div id="main">
			<table style="margin: auto;">
				<tr>
					<td>
						表单域：
					</td>
					<td>
						<input type="text" name="content" id="content" value="<%=content %>" />
					</td>
				</tr>
				<tr>
					<td>
						操作符：
					</td>
					<td>
						<input type="text" name="operators" id="operators" value="<%=type %>" />
					</td>
				</tr>
				<tr>
					<td>
						值：
					</td>
					<td>
						<input type="text" name="value" id="value" />
					</td>
				</tr>
			</table>
		</div>
		<div id="footer">
			<table style="margin: auto;">
				<tr>
					<td>
						<input name="submit2" type="button" id="butt"
							onclick="complete();" value="确认" />
					</td>
					<td>
						<input name="button" type="button" id="butt1" value="取消" onclick="closeWin();"/>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
