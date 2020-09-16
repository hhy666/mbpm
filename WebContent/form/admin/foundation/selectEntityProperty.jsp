<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
    //重写双击事件 实现选属性
    function recordDoubleClickCustomFun(viewer, record, recordNum, field, fieldNum, value, rawValue){
		Matrix.closeWindow(record);
	}
    
    //获取确定按钮组件
    function submitSelectedMethod(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");//获取数据列表
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			//var recordStr = isc.JSON.encode(record);
			
		    Matrix.closeWindow(record);
		}else{
			isc.say("请选择属性！");
		}
		
	}


</script>

</head>
<body >
		
<%

com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>