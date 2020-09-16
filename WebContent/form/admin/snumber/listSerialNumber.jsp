<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<title>流水号定义列表</title>
<script type="text/javascript">
	//添加关闭时触发
	function onAddSerialNumClose(data, oType){
		//data为obj
		if(data!=null){
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			dataGrid.getData().add(data);
			isc.say('添加成功!');
		
		}
		
		return true;
	}
	//获取选中记录的uuid
	function getSerialNumUuid(){
		var record = MUpdateSerialNum.record;
		return record.uuid;
	}
	
	//显示更新输入框
	function showUpdateDialog(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordData = dataGrid.getData();
		var selection = dataGrid.getSelection() ;
		if(!selection || selection.length==0){
				isc.warn("请选择要编辑的流水号定义!");
				return null;
		}
		var selectRecord = selection[0];
		
		var rowNum = recordData.indexOf(selectRecord);
		MUpdateSerialNum.record = selectRecord;
		MUpdateSerialNum.rowNum = rowNum;
		
		Matrix.showWindow("UpdateSerialNum");
		
	
	}
	
	
	
	//更新关闭时触发
	function onUpdateSerialNumClose(data, oType){
		//data为obj
		if(data!=null){
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			var preRecord = MUpdateSerialNum.record;
			preRecord.id = data.id;
			preRecord.name = data.name;
			preRecord.prefix = data.prefix;
			preRecord.postfix = data.postfix;
			preRecord.rule = data.rule;
			preRecord.seperator = data.seperator;
			preRecord.startNum = data.startNum;
			preRecord.step = data.step;
			preRecord.length = data.length;
			preRecord.state = data.state;
			preRecord.desc = data.desc;
			preRecord.isStaticLength = data.isStaticLength;
			 
			MDataGrid0.updateData(preRecord);
			MDataGrid0.refreshFields();
		   	isc.say("更新成功");
			MUpdateSerialNum.record = null;
			MUpdateSerialNum.rowNum = null;
		}
		
		return true;
	
	}
	
	function deleteSerialNum(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordData = dataGrid.getData();
		var selection = dataGrid.getSelection() ;
		if(!selection || selection.length==0){
				isc.warn("请选择要删除的流水号定义!");
				return null;
		}
		var selectRecord = selection[0];
		var uuid = selectRecord.uuid;
		
		var url = "<%=request.getContextPath()%>/number/serialNumber_deleteSerialNum.action?uuid="+uuid;
		
		dataSend(null,url,"POST",function(data){
        	if(data.data =="true"){
        		isc.confirm('确定要删除吗?',function(data){//true or null
					if(data){
		        	    dataGrid.removeSelectedData();
		        		isc.say('删除成功!');
	        		}else{
	        			return;
	        		}
        		});
            }else{
            	isc.warn('删除失败!');
            } 
        		
        },null);
		
		
	}
	
	
	//双击修改
	function doubleClickRecord(viewer, record, recordNum, field, fieldNum, value, rawValue){
		MUpdateSerialNum.record = record;
		MUpdateSerialNum.rowNum = recordNum;
		
		Matrix.showWindow("UpdateSerialNum");
	
	}
	
</script>

</head>
<body>
		
<%

com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>