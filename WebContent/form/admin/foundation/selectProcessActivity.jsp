<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<SCRIPT SRC='<%=path%>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=path%>/resource/html5/js/layer.min.js'></SCRIPT>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>

<script type="text/javascript">
    //重写双击事件 实现选属性
    function recordDoubleClickCustomFun(viewer, record, recordNum, field, fieldNum, value, rawValue){
		//Matrix.closeWindow(record);
		var iframewindowid = document.getElementById('iframewindowid').value;
		var closeFunction = eval("parent.on"+iframewindowid+"Close");
		closeFunction(record);
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
    
    //获取确定按钮组件
    function submitSelectedMethod(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");//获取数据列表
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			//var recordStr = isc.JSON.encode(record);
		    //Matrix.closeWindow(record);
			var iframewindowid = document.getElementById('iframewindowid').value;
			var closeFunction = eval("parent.on"+iframewindowid+"Close");
			closeFunction(record);
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		}else{
			isc.say("请选择活动！");
		}
		
	}
    
    //取消
    function cancel(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}


</script>

</head>
<body >
		<input type="hidden" id='iframewindowid' name='iframewindowid' value="${iframewindowid }">
<%
com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>

<%
   java.util.List list = (java.util.List)request.getAttribute("data");
   if(list == null || list.size()==0){
	   %>
	<script type="text/javascript">
	
	isc.say("该流程尚无已发布版本!");


</script>
	   
	   <%
   }
%>
</body>
</html>