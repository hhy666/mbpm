<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title >选服务方法</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
  
    //双击实现选择添加数据
    function recordDoubleClickCustomFun(viewer, record, recordNum, field, fieldNum, value, rawValue){
    	Matrix.closeWindow(record);
    }
    
    //获取确定按钮组件
    function submitSelectedMethod(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");//获取数据列表
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
		    Matrix.closeWindow(record);
		}else{
			isc.say("请选择方法！");
		}
		
	}


</script>

</head>
<body>
<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}">
		
<%

	com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>