<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
   /*
	
	//添加验证器
	function addValidator(){
		var url ="<%=request.getContextPath()%>/designer/formValidatorDesign_loadAddInputValidatorPage.action?iframewindowid=Dialog0";
        MDialog0.opType= "add";
		MDialog0.initSrc = url;
		MDialog0.setTitle ("添加验证器");
		Matrix.showWindow('Dialog0');
	
	}
	//添加或更新关闭时触发
	function onDialog0Close(data, oType) {
	       if(data==null)return true;//取消操作直接返回
	        var opType = MDialog0.opType;
		    var jsonObj = isc.JSON.decode(data);
		    var validatorType = jsonObj.validatorType;//validator type
		    var validData = jsonObj.data;
		    var errorMessage = validData.errorMessage;
		    //根据类别来拼接字符串{'name':'','desc':''}
		    //['email', 'postCode', 'mobileTelephone', 'identityCard', 'precision', 'regexp', 
		    //'length', 'longRange', 'doubleRange', 'jsFunction', 'jsExpression']
		   
		    var recordData = null;//验证器信息
		    
		    if (validatorType == "precision") { //精度验证器
		  		  recordData = "{'precision':'"+validData.precision+"','errorMessage':'"+errorMessage+"'}";
		  		  
		    } else if ((validatorType == 'regexp') || (validatorType == 'jsExpression')) { //正则表达式，js表达式
		    		recordData = "{'expression':'"+validData.expression+"','errorMessage':'"+errorMessage+"'}";
		    		
		    } else if (validatorType == 'jsFunction') { //js方法
		    		recordData = "{'functionName':'"+validData.functionName+"','errorMessage':'"+errorMessage+"'}";
		    		
		    } else if ((validatorType == 'length') || (validatorType == 'longRange') || (validatorType == 'doubleRange')) {
				  	recordData = "{'minValue':'"+validData.minValue+"','maxValue':'"+validData.maxValue+"','errorMessage':'"+errorMessage+"'}";
				  	
		    } else { //only errorMessage input
		    	   recordData = "{'errorMessage':'"+errorMessage+"'}";
		    }
		     //发送异步请求,{'actionType':'','validatorType':'','data':''}
		     var url ="<%=request.getContextPath()%>/designer/formValidatorDesign_saveInputValidators.action";
		     
		    if (opType == "add") { //添加操作
			     var asynData ="{'actionType':'"+opType+"','validatorType':'"+validatorType+"','data':"+recordData+"}";
			     var adynJsonObj = isc.JSON.decode(asynData);
		          dataSend(adynJsonObj,url,"POST",addValidatorCallBack,null);
		    	
		    } else if (opType == "update") { //更新操作
					var rowNum = MDialog0.rowNum;
					var asynData ="{'actionType':'"+opType+"','rowNum':"+rowNum+",'validatorType':'"+validatorType+"','data':"+recordData+"}";
			        var adynJsonObj = isc.JSON.decode(asynData);
			       dataSend(adynJsonObj,url,"POST",updateValidatorCallBack,null);	
		    }
		    return true;
		}
		
		//添加验证器时回调函数
		function addValidatorCallBack(data){
		    
			if(data!=null){
			  //获取数据表格
			   var jsonObj = isc.JSON.decode(data.data);
			   var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			   dataGrid.getData().add(jsonObj);//将异步返回的数据 显示到列表
			
			}
		
		}
		//更新验证时回调函数
		function updateValidatorCallBack(data){
		   if(data!=null){//根据行记录Id，更新数据集合行记录
		    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		   	var record = MDialog0.record;
		   	var jsonObj = isc.JSON.decode(data.data);
		   	
		   	record.name = jsonObj.name;
		   	record.desc = jsonObj.desc;
		    
		    dataGrid.updateData(record);
		    dataGrid.deselectRecord(record);//切换选择状态
		   }
			
		}
		//双击弹出编辑记录
		function  updateRecordByDoubleClick(viewer, record, recordNum, field, fieldNum, value, rawValue){
			   //1.从action中获取该数据 并弹出弹出框
		        var url ="<%=request.getContextPath()%>/designer/formValidatorDesign_getUpdateValidator.action?componentType=${requestScope.subComponentType}&rowNum="+recordNum;
		        //将数据传递到弹出框中
			     MDialog0.rowNum = recordNum;
				 MDialog0.record = record;
				 MDialog0.opType = "update";//修改时将所有数据传递到弹出框
				 MDialog0.setTitle ("编辑验证器");
				 MDialog0.initSrc = url; 
				 Matrix.showWindow("Dialog0");
		
		}
		  
		
		  //删除 上移 下移 通用部分
		  function validatorOperation(dataGridName,operationType){
                 var dataGrid =  Matrix.getMatrixComponentById(dataGridName);
                 var record = dataGrid.getSelectedRecord();
                 if(record!=null){
	                 var rowNum = dataGrid.getRecordIndex(record);
	                 if(rowNum==0&&operationType=='up'){//已经上移到顶端
	                 	return false;
	                 }
	                 var  dataRows = dataGrid.getTotalRows();
	                 if(rowNum==(dataRows-1)&&operationType=='down'){//已经下移到最底端
	                    return false;
	                 }
	                 var data ="{'rowNum':"+rowNum+",'actionType':'"+operationType+"'}";
	                 var url = '<%=request.getContextPath()%>/designer/formValidatorDesign_saveInputValidators.action';
		    	     var synJson = isc.JSON.decode(data);
		     		 dataSend(synJson,url,"POST",function(data){
		     		 var data = data.data;//根据回调函数操作数据列表
			     		 if(data=="deleteSuccess"){
			     		     Matrix.deleteDataGridData(dataGridName);
			     		 }else if(data=="upSuccess"){
			     	     	 onMoveUpRecord();
			     		 }else if(data=="downSuccess"){
			     			 onMoveDownRecord();
			     		 
			     		 }
		     		 },null);
                 
                 
                 }else{
                   isc.warn("没有数据被选中，不能执行此操作。");
		        	return false;
                 }
		  
		  }
		  
		 */
		 
</script>

</head>
<body>
	<input name="componentType1" id="componentType1" type="hidden" value="${param.componentType}" />
	<%
	com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
		String content = render2.render(request, response);
		out.print(content);	
	%>


</body>
</html>