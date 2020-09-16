<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	//跳转到指定页面
	function forwardPage(src){
		src = "<%=request.getContextPath()%>"+"/"+src;
		parent.Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
	}
	function getParentUUID(){
		return  document.getElementById("parentUUID").value;
	}

	//添加基本项
	function addBasicItem(){
		//添加走配置文件的默认信息 parentUUID不用传递到添加页
	    //var parentUUID = "${param.parentUUID}";
		Matrix.showWindow('AddBasicItemDialog');
	
	}
	
	
	//获取将要更新的uuid
	function getItemUuid(){
		return  document.getElementById("uuid").value;
	}
	
	//更新操作
	function updateBasicItem(){
	   var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	   var seRecord = dataGrid.getSelectedRecord ();
	   if(seRecord!=null){
		   var uuid = seRecord.uuid;
		   document.getElementById("uuid").value=uuid;
		   
	   	   MUpdateBasicItemDialog.record = seRecord;
		   Matrix.showWindow("UpdateBasicItemDialog");
	   
	   }else{
	   	   parent.isc.say("未选中数据！");
	   }
	   
	}
	
	//双击更新操作
	function updateBasicItemDoubleClick(seRecord){
	    
	   if(seRecord!=null){
		   var uuid = seRecord.uuid;
		   document.getElementById("uuid").value=uuid;
	   	   MUpdateBasicItemDialog.record = seRecord;
		   Matrix.showWindow("UpdateBasicItemDialog");
	   
	   }else{
	   	   parent.isc.say("未选中数据！");
	   }
	   
	}
	
	//添加窗口关闭时触发
	function onAddBasicItemDialogClose(data, oType){
		// parentUUID type
		if(data!=null){
		//维护parentUUID
		var parentUUID = document.getElementById("parentUUID").value;
		data.parentUUID = parentUUID;
		//异步 添加  后台响应成功后 更新数据表格 提示添加成功
		synData ={'data':data};
		var cbDataStr = isc.JSON.encode(data);
		
			var flag = data.flag;
		url = "<%=request.getContextPath()%>/code/code_addBasicItem.action";
		dataSend(synData,url,"POST",function(data){
		    var cdata = data.data;
		    var callbackObj =isc.JSON.decode(cdata);
		     var message = callbackObj.message;
		    if(message==true){
		       var recordData = isc.JSON.decode(cbDataStr);
		         recordData.uuid = callbackObj.uuid;
		         var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		          
				 dataGrid.getData().add(recordData);
		   		 if(!flag){
			   		 parent.isc.say("添加成功");
		   		 }else{
					 Matrix.showWindow("AddBasicItemDialog");
		   		 }
		    }else if(message=='repeat'){
		    	 parent.isc.say("编码重复,请重新添加");
		    
		    }
			
		},null);
		//
			
		}
		
		return true;
	}
	//更新时 回调方法触发  
	function onUpdateBasicItemDialogClose(data, oType){
		if(data!=null){//id name uuid
			var id = data.id;
			var name = data.name;
			var isEnable = data.isEnable;
			synData ={'data':data};
		    url = "<%=request.getContextPath()%>/code/code_updateBasicItem.action";
			dataSend(synData,url,"POST",function(data){
		    var cdata = data.data;
		    var callbackObj =isc.JSON.decode(cdata);
		    var message = callbackObj.message;
		    if(message==true){
		       	var  record = MUpdateBasicItemDialog.record;
		       	MUpdateBasicItemDialog.record = null;
		         record.id = id;
		         record.name = name;
		         record.isEnable = isEnable;
		       	 MDataGrid0.updateData(record);
		       	 MDataGrid0.refreshFields();
		   		 parent.isc.say("更新成功");
		    }else if(message=='repeat'){
		    	 parent.isc.say("编码重复,请重新修改!");
		    	
		    }else{
		       parent.isc.say("更新失败!");
		    }
			
		},null);
		}
	
	}
	
	//------------------------------------------

	
	
	//异步删除记录
	function deleteCodeItem(){
		//获取选择行  获取选中record uuid
		 var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
         var record = dataGrid.getSelectedRecord();
 
         if(record!=null){
        	 var uuid = record.uuid;
        	 var url ="<%=request.getContextPath()%>/code/code_deleteCodeItem.action?uuid="+uuid;
        	 dataSend(null, url, "POST",function(data){
        	 var backStr = data.data;
	    	 var backData = isc.JSON.decode(backStr);
	    	 if(backData.message==true){
	    	 	dataGrid.removeSelectedData();
	    	 	parent.isc.say("删除成功!");
	    	 }else{
	    	 	parent.isc.say("删除失败!");
	    	 }
        	 
        	 
        	 },null);
         
         }else{
         	parent.isc.say("未选中数据!");
         }
        
	}
	
	//获取更新选中的权限范围
	function updateCodeItem(){
	   var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	   var seRecord = dataGrid.getSelectedRecord ();
	   if(seRecord!=null){
		   var uuid = seRecord.uuid;
	   	   var url ="<%=request.getContextPath()%>/security/formSecScope_loadUpdateCodeBasicItem.action?uuid="+uuid+"&oType=update";
	   	   MAddSecScopeDialog.record = seRecord;
	   	   var recordNum = dataGrid.getRecordIndex(seRecord);
	   	   MAddSecScopeDialog.recordNum = recordNum;
	   	   MAddSecScopeDialog.initSrc = url;
	   	   MAddSecScopeDialog.title = "编辑权限范围";
		   Matrix.showWindow("AddSecScopeDialog");
	   
	   }else{
	   	parent.isc.say("未选中数据！");
	   }
	
	}
	

	//双击实现修改
	function linkToSecurity(viewer, record, recordNum, field, fieldNum, value, rawValue){
	  updateBasicItemDoubleClick(record);
		
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

<script type="text/javascript">
	  //上移操作	
	function onMoveUpRecord1(isAjax){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			if(recordIndex>0){
			    recordIndex--;
			    //获取上条数据记录
			    var preRecord = recordData.get(recordIndex);
			     
			    if(isAjax){  //发送异步请求
			    var data = {'data':{'entityId':selectedRecord.uuid,'preEntityId':preRecord.uuid}};	
			    var url = "<%=request.getContextPath()%>/code/code_moveUpBasicItem.action";
			    dataSend(data,url,"POST",function(data){
			    	if(data!=null){
			    		var callbackJson = isc.JSON.decode(data.data);
			    		if(callbackJson.message==true){
				    		  recordData.set(recordIndex,selectedRecord);
				    		  recordData.set(recordIndex+1,preRecord);
			    		      return;
			    		}else{
			    			parent.isc.say("服务器端异常!");
			    		}
			    	
			    	}else{
			    		parent.isc.say("服务器端未能同步!");
			    	}
			    
			    },null);
			    
			    }else{
			    
				    recordData.set(recordIndex,selectedRecord);
				    recordData.set(recordIndex+1,preRecord);
			    
			    }
			    //交换数据记录，更新数据表格
			    
			    
			    
			}
		}
	}
  
  
  /******** upmove grid list data  end*********/
  
  
    /******** down move data  begin*********/
   //下移操作	
	function onMoveDownRecord1(isAjax){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			var listSize = recordData.getLength();
			if(recordIndex<listSize-1){
			    recordIndex++;
			    //获取上条数据记录
			    var afterRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    
			    
			 if(isAjax){  //发送异步请求
			    var data = {'data':{'entityId':selectedRecord.uuid,'afterEntityId':afterRecord.uuid}};	
			    var url = "<%=request.getContextPath()%>/code/code_moveDownBasicItem.action";
			    dataSend(data,url,"POST",function(data){
			    	if(data!=null){
			    		var callbackJson = isc.JSON.decode(data.data);
			    		if(callbackJson.message==true){
				    		 recordData.set(recordIndex,selectedRecord);
			   				 recordData.set(recordIndex-1,afterRecord);
			    		      return;
			    		}else{
			    			parent.isc.say("服务器端异常!");
			    		}
			    	
			    	}else{
			    		parent.isc.say("服务器端未能同步!");
			    	}
			    
			    },null);
			    
			    }else{
				    recordData.set(recordIndex,selectedRecord);
				    recordData.set(recordIndex-1,afterRecord);
					   
			    
			    }
			}
		}
	}
  
  
  /******** downmove record  data  end*********/


</script>
</body>
</html>