<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            list!
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
        <jsp:include page="/form/admin/common/resource.jsp" />
    </head>
<script>
	/******** upmove data  begin*********/
  //上移操作	
	function onMoveUpRecord(){
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
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex+1,preRecord);
			    
			}
		}
	}
  
  
  /******** upmove grid list data  end*********/
  
  
    /******** down move data  begin*********/
   //下移操作	
	function onMoveDownRecord(){
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
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex-1,afterRecord);
			}
		}
	}
  
  
  /******** downmove record  data  end*********/

/******** grid list delete data  begin*********/
  function deleteDataGridData(){
  		var _curGrid = Matrix.getMatrixComponentById("DataGrid0");
		if(!_curGrid.getSelection() || _curGrid.getSelection().length==0){
			isc.warn("没有数据被选中，不能执行此操作。");
			return false;
		}
		_curGrid.removeSelectedData();
		
		return false;
	}
	
	function showItems(){
  		var _curGrid = Matrix.getMatrixComponentById("DataGrid0");
		if(!_curGrid.getSelection() || _curGrid.getSelection().length==0){
			isc.warn("没有数据被选中，不能执行此操作。");
			return false;
		}
		Matrix.showWindow('EditItems');
	}
  
	function showParams(){
  		var _curGrid = Matrix.getMatrixComponentById("DataGrid0");
		if(!_curGrid.getSelection() || _curGrid.getSelection().length==0){
			isc.warn("没有数据被选中，不能执行此操作。");
			return false;
		}
		Matrix.showWindow('ParamItems');
	}
  
	function showBackValues(){
  		var _curGrid = Matrix.getMatrixComponentById("DataGrid0");
		if(!_curGrid.getSelection() || _curGrid.getSelection().length==0){
			isc.warn("没有数据被选中，不能执行此操作。");
			return false;
		}
		Matrix.showWindow('BackItems');
	}
  
  /******** grid list delete data  end*********/
	
	/*******************************asynchronous common method begin***************************************/
	 function dataSend(data,url,method,callbackFun,errorFun) {
	    method=method?method:"POST";
      	RPCManager.sendRequest({params:data,callback:callbackFun,handleError:errorFun,httpMethod:method,actionURL:url});      
     }
	
	/********************************asynchronous common method begin**************************************/
 //删除 上移 下移
		  function exeOperation(command){
		         var componentType = document.getElementById("componentType").value;
		    	 var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
                 var record = dataGrid.getSelectedRecord();
                 var rowNum = dataGrid.getRecordIndex(record);
                 var data ="{'componentType':'"+componentType+"','rowNum':"+rowNum+",'command':'"+command+"'}";
                 var url = '<%=request.getContextPath()%>/formdesigner.daction';
	    	     var synJson = isc.JSON.decode(data);
	     		 dataSend(synJson,url,"POST",function(data){
	     		 var command2 = command;//根据回调函数操作数据列表
	     		 var data = data.data;
		     		 if(command2=="delete"){
		     		     deleteDataGridData();
		     		 }else if(command2=="up"){
		     	     	 onMoveUpRecord();
		     		 }else if(command2=="down"){
		     			 onMoveDownRecord();
		     		 
		     		 }
	     		 },null);
		  
		  }
		  
		  function onNewDialogClose(newRow){
	
		         var componentType = document.getElementById("componentType").value;
		         var level = document.getElementById("level").value;
                 var data ="{'componentType':'"+componentType+"','level':'"+level+"','command':'postCreate'}";
                 var url = '<%=request.getContextPath()%>/formdesigner.daction';
	    	     var synJson = isc.JSON.decode(data);
	     		 dataSend(synJson,url,"POST",function(data){
				  	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
				  	//encode转为字符串, decode转为对象
				  	var row = isc.JSON.decode(isc.JSON.encode(newRow));
				  	dataGrid.addData(row);
	     		  },null);
		  }
	
		  function onUpdateDialogClose(rowData){
	
		         var componentType = document.getElementById("componentType").value;
		         var level = document.getElementById("level").value;
		         var rowNum = getCurRowNum();
                 var data ="{'componentType':'"+componentType+"','level':'"+level+"','rowNum':'"+rowNum+"','command':'update'}";
                 var url = '<%=request.getContextPath()%>/formdesigner.daction';
	    	     var synJson = isc.JSON.decode(data);
	     		 dataSend(synJson,url,"POST",function(data){
				  	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
					var recordData = dataGrid.getData();
					var selectedRecord = dataGrid.getSelection()[0];
					var recordIndex = recordData.indexOf(selectedRecord);

				  	var row = isc.JSON.decode(isc.JSON.encode(rowData));
				  	dataGrid.addData(row);
				    recordData.set(recordIndex,row);
	     		  },null);
		  }
		  
		  function getCurRowNum(){
				  	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
					var recordData = dataGrid.getData();
					var selectedRecord = dataGrid.getSelection()[0];
					var recordIndex = recordData.indexOf(selectedRecord);
					return recordIndex;
		  }

		  function getComponentType(){
		         var componentType = document.getElementById("componentType").value;
					return componentType;
		  }

		  function getLevel(){
		         var level = document.getElementById("level").value;
					return level;
		  }
		  
	function resetJSProperty(mitem){
		// 重置组件属性
		if(mitem!=null){
			if(!isc.MH.validateComponentFieldProperty(mitem)){
				return false;
			}

			var attrName = mitem.record.jsName;
			var attrValue = mitem.getValue();
			var componentType = document.getElementById(isc.MC.SERVER_PARAMS.componentType);
			if(componentType!=null){
				componentType = componentType.value;
			}
			var data = {};
			data[isc.MC.SERVER_PARAMS.attrName] = attrName;
			data[isc.MC.SERVER_PARAMS.attrValue] = attrValue;
			data[isc.MC.SERVER_PARAMS.componentType] = componentType;
			data[isc.MC.SERVER_PARAMS.command] = isc.MC.COMMAND.updateAttribute;
			isc.MH.sendRequest(data);
		}
	}
		  
	</script>
<body>

	
<jsp:include page="/form/admin/common/loading.jsp"/>
	<form>
	<input type="hidden" id="componentType" value="<%=request.getParameter("componentType") %>">
	<input type="hidden" id="level" value="<%=request.getParameter("level") %>">
<%

com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>
	</form>


</body>
</html>