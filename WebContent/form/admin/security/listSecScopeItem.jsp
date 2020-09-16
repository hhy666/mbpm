<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%  
		int curPhase = CommonUtil.getCurPhase();

	%>
	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>权限范围子项列表</title>
<SCRIPT SRC='<%=path%>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=path%>/resource/html5/js/layer.min.js'></SCRIPT>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	//获取记录的Uuid
  	function getSecScopeItemUuid(){
  		var uuid = MUpdateScopeItemDialog.uuid;
  		MUpdateScopeItemDialog.uuid = null;
  		return uuid;
  	}
  	
  	//获取记录的Uuid
  	function getScopeUuid(){
  		return document.getElementById("scopeUuid").value;
  	}
  	
  	function  getFormUuid(){
  		return document.getElementById("formUuid").value;
  	}
  	
  	function  getModulePath(){
  		return document.getElementById("modulePath").value;
  	}
  	
  	//获取记录的Uuid
  	function getSecScopeItemUuid(){
  		var uuid = MUpdateScopeItemDialog.uuid;
  		MUpdateScopeItemDialog.uuid = null;
  		return uuid;
  	}
  
  	//弹出框加载 添加页面
  	function loadAddPage(){
  		//Matrix.showWindow('AddScopeItemDialog');
  		layer.open({
  			type:2,
  			title:['添加权限范围子项'],
  			area:['85%','100%'],
  			content:'<%=path%>/security/formSecScopeItem_loadAddScopeItemPage.action?oType=add&iframewindowid=AddScopeItemDialog'
  		});
  	
  	}
  	//更新权限范围子项
  	function updateSecScopeItem(){
  		 var formUuid = document.getElementById('formUuid').value; 
	     var modulePath = document.getElementById("modulePath").value;
  		 var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
         var record = dataGrid.getSelectedRecord();
         
         if(record!=null){
         	var scopeUuid = record.scopeUuid;
            var uuid = null;
         	if("<%=curPhase%>"=="2"){
         		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
         		var rowNum = dataGrid.getRecordIndex(record);
  		    	uuid = rowNum;//保存行号
  		    }else{
  		     	uuid = record.uuid;
  		    }
         
         	 MUpdateScopeItemDialog.uuid = uuid;
         	 MUpdateScopeItemDialog.record = record;
         	 layer.open({
         		 type:2,
         		 title:['更新权限范围子项'],
         		 area:['85%','100%'],
         		 content:'<%=path%>/security/formSecScopeItem_loadUpdateScopeItemPage.action?oType=update1&uuid='+ uuid +'&formUuid='+formUuid+'&modulePath='+modulePath+'&iframewindowid=UpdateScopeItemDialog&scopeUuid='+scopeUuid
         	 });
         	 //Matrix.showWindow("UpdateScopeItemDialog");
         
         }else{
         	isc.say("未选中数据");
         }
  	}
 
  	
  	//添加权限范围子项关闭时触发
  	function onAddScopeItemDialogClose(data, oType){
  		if(oType!=null&&oType=="add"){//添加
  			var scopeUuid = document.getElementById("scopeUuid").value;
  			var type = data.type;
  			//准备数据
  		    data.scopeUuid = scopeUuid;
  		    var formUuid = null;
  		    var modulePath = null;
  		    var synData = {'data':data};
  		    if("<%=curPhase%>"=="2"){
  		    	formUuid = document.getElementById("formUuid").value;
  		    	modulePath = document.getElementById("modulePath").value;
  		    	synData.formUuid = formUuid;
  		    	synData.modulePath = modulePath;
  		    }
  			//异步保存
  			var url = "<%=request.getContextPath()%>/security/formSecScopeItem_addSecScopeItem.action?formUuid=${param.formUuid}";
  			dataSend(synData, url, "POST",function(data){
  				var backStr = data.data;
  				
  				if(backStr!=null){
  					var backData = isc.JSON.decode(backStr);
  				    var message = backData.message;
  					if(message=='true'){
  					    var uuid = backData.uuid;
  					    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");//获取数据列表
  						var record = synData.data;
  						record.uuid = uuid;
  						record.value = getShowValueByType(record);
  						dataGrid.addData(record);
  						
  						//parent.isc.say('添加成功!');
  					}else if(message=="repeat"){
  						isc.warn('您添加的子项在该范围下已存在!');
  					}	
  				}
  			
  			},null);
  		}
  		return true;
  	
  	}
  	//更新信息保存触发该方法
  	function onUpdateScopeItemDialogClose(data, oType){
  		if(data!=null){
	  		var type = data.type;
	  		//准备后更新后的数据
	  	    var  updateRecord = MUpdateScopeItemDialog.record;
	  	
	  	    MUpdateScopeItemDialog.record = null;
	  	    updateRecord.type = type;
	  	    switch(parseInt(type)){
	  	    	case 1://用户
	  	    	    updateRecord.userId = data.userId;
	  	    		updateRecord.userName =data.userName;
	  	    		
	  	    	  break;
	  	    	case 2://部门
	  	    		updateRecord.depId = data.depId;
	  	    		updateRecord.depName =data.depName;
	  	    	  break;
	  	        case 3://角色
	  	        	updateRecord.roleId = data.roleId;
	  	    		updateRecord.roleName =data.roleName;
	  	        
	  	    	  break;
	  	        case 4://岗位 [部门+角色]
	  	        	updateRecord.depId = data.depId;
	  	    		updateRecord.depName =data.depName;
	  	    		
	  	    		updateRecord.roleId = data.roleId;
	  	    		updateRecord.roleName =data.roleName;
	  	    	  break;
	  	        case 5://流程
	  	        	updateRecord.pdId = data.pdId;
	  	    		updateRecord.pdName =data.pdName;
	  	    		
	  	    		updateRecord.adId = data.adId;
	  	    		updateRecord.adName =data.adName;
	  	        
	  	    	  break;
	  	    }
	  	    //更新显示值value field
	  	    updateRecord.value = getShowValueByType(updateRecord);
	  	    
	  	   //异步更新
	  	   var asynData = {'data':updateRecord};
	  	    if("<%=curPhase%>"=="2"){
	  	    	asynData.scopeUuid = document.getElementById("scopeUuid").value;
	  	    	asynData.formUuid = document.getElementById("formUuid").value;
	  	    	asynData.modulePath = document.getElementById("modulePath").value;
	  	    	
	  	    }
	  	   var url = "<%=request.getContextPath()%>/security/formSecScopeItem_updateSecScopeItem.action?formUuid=${param.formUuid}"; 
		   dataSend(asynData, url, "POST",function(data){
		    	 var backStr = data.data;
		    	 var backData = isc.JSON.decode(backStr);
		    	 if(backData.message=="true"){
				  	   var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
				  	   dataGrid.updateData(updateRecord);
				  	   dataGrid.refreshFields();
				  	   isc.say("更新成功!");
				  	   return true;
		    	 }else if(backData.message=="repeat"){
		    	 	isc.warn("该范围下已经存在此子项!");
		    	 }else{
		    	 	isc.say("更新失败!");
		    	 }	
			},null);
  		
  		}
  		return true;
  	}
  	
  	
  	//删除选中的数据记录
  	function deleteSecScopeItem(){
  		//获取选择行  获取选中record uuid
		 var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
         var record = dataGrid.getSelectedRecord();
        // var rowNum = dataGrid.getRecordIndex(record);
         if(record!=null){
        	 var uuid = record.uuid;
        	 var url ="<%=request.getContextPath()%>/security/formSecScopeItem_deleteSecScopeItem.action?uuid="+uuid+"&formUuid=${param.formUuid}";
         	 if("<%=curPhase%>"=="2"){
         	 	var formUuid = document.getElementById("formUuid").value;
         	 	var scopeUuid = document.getElementById("scopeUuid").value;
         	 	var modulePath = document.getElementById("modulePath").value;
         	 	url = url+"&scopeUuid="+scopeUuid+"&modulePath="+modulePath;
	  	     }
	  	     
        	 dataSend(null, url, "POST",function(data){
        	 var backStr = data.data;
	    	 var backData = isc.JSON.decode(backStr);
		    	 if(backData.message=="true"){
		    	 	dataGrid.removeSelectedData();
		    	 	isc.say("删除成功!");
		    	 }else{
		    	 	isc.say("删除失败!");
		    	 }
        	 
        	 },null);
         
         }else{
         	isc.say("未选中数据!");
         }
  	
  	}
  
  
  	//根据类型返回列表内的显示值
     function getShowValueByType(record){
   		  var type = record.type;
   		  var showValue = null;
     	  switch(parseInt(type)){
     	  	case 1://用户
     	  	    showValue =record.userName;
     	  		break;
     	  	case 2://部门
     	  	     showValue =record.depName;
     	  		break;
     	  	case 3://角色
     	  	     showValue =record.roleName;
     	  		break;
     	    case 4://岗位
     	        showValue =record.depName+";"+record.roleName;
     	    	break;
     	    case 5://流程节点
     	       showValue =record.pdName+"("+record.pdId+");"+record.adName+"("+record.adId+")";
     	    	break;
     	  }	
     	return showValue;
     }
  
  
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

	function initPage(){
		//授权发布状态下 除了关闭外 按钮禁用
		var state = "${param.state}";
		if(state=="1"){//已经发布状态
		var membersArray = MDataGrid0_QF_tb.getMembers();//工具栏操作
		 	var currentArr;
			for(var i=0;i<membersArray.length-1;i++){
				currentArr = membersArray[i];
				currentArr.setDisabled (true);
			}
			
		}
	
	
	}


</script>

</head>
<body onload="initPage()">
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}">
	<input type="hidden" name="formUuid" id="formUuid" value="${param.formUuid}">	
<%

com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>