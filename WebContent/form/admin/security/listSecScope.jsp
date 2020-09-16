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

<html>
<head>
<SCRIPT SRC='<%=path%>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=path%>/resource/html5/js/layer.min.js'></SCRIPT>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript"  charset="utf-8">
	function closeEmpowerWindow(){
	     parent.Matrix.closeWindow();
	
	}
	//加载范围子项时 提供scopeUuid
	function getscopeUuid(){
		
		 var scopeUuid = MSecScopeItemDialog.scopeUuid;
		 MSecScopeItemDialog.scopeUuid = null;
        
		return scopeUuid;
	}
	
	//获取表单版本发布状态
	function getPublishState(){
		return "${param.state}";
	}
	
	
	//显示范围子项列表
	function showSecScopeItemList(){
		var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
		var formUuid = document.getElementById("formUuid").value;
		var modulePath = document.getElementById("modulePath").value;

        var record = dataGrid.getSelectedRecord();
        var curPhase = "<%=curPhase%>";
        var scopeUuid = null;
        if(record!=null){
        	if(curPhase=="2"){//设计开发
        		scopeUuid = record.name;
        	}else{
        		scopeUuid = record.uuid;
        	}
        
        	MSecScopeItemDialog.scopeUuid = scopeUuid;
        	//Matrix.showWindow('SecScopeItemDialog');
        	parent.layer.open({
        		type:2,
        		title:['权限范围子项'],
        		area:['80%','80%'],
        		content:'<%=path%>/security/formSecScopeItem_getSecScopeItems.action?&scopeUuid='+scopeUuid+'&formUuid='+formUuid+'&state=${param.state}&modulePath='+modulePath+'&iframewindowid=SecScopeItemDialog'
        	});
        }else{
     	  parent.isc.warn("未选择有效数据!");
     	  return false;
        } 
	}
	
	/*返回权限范围对应的formUuid*/
	function getFormUuid(){
		 return document.getElementById("formUuid").value;
	}
	
	/*返回权限范围对应的modulePath*/
	function getModulePath(){
		 return document.getElementById("modulePath").value;
	}
	
	//异步删除记录
	function deleteSecScope(){
		//获取选择行  获取选中record uuid
		 var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
         var record = dataGrid.getSelectedRecord();
         //var rowNum = dataGrid.getRecordIndex(record);
         if(record!=null){
         	 var curPhase = "<%=curPhase%>";
        	// var uuid = record.uuid;
        	 var url ="<%=request.getContextPath()%>/security/formSecScope_deleteSecScopeBasic.action";
         	 var formUuid = document.getElementById("formUuid").value;
         	if(curPhase=="2"){//设计开发
         		  var modulePath = document.getElementById("modulePath").value;
         		 url = url+"?uuid="+record.name+"&formUuid="+formUuid+"&modulePath="+modulePath;
         	}else{
         		 url = url+"?uuid="+record.uuid+"&formUuid="+formUuid;
         	}
        	 dataSend(null, url, "POST",function(data){
	        	 var backStr = data.data;
		    	 var backData = isc.JSON.decode(backStr);
		    	 if(backData.message=="true"){
		    	 	dataGrid.removeSelectedData();
		    	 	//将右侧范围列表页 设置为占位页面
		    	 	parent.MhorizontalContainer0Panel1.setContentsURL('<%=request.getContextPath()%>/form/admin/security/listSecEmpower_Blank.jsp');
		    	 
		    	 }else{
		    	 	parent.isc.say("删除失败!");
		    	 }
        	 
        	 },null);
         
         }else{
         	parent.isc.say("未选中数据!");
         }
        
	}
	//添加权限范围
	function addSecScope(){
		
		 var curPhase = "<%=curPhase%>";
		 var formUuid = document.getElementById("formUuid").value;
		var url = "<%=request.getContextPath()%>/security/formSecScope_loadSecScopeBasicPage.action?oType=add&formUuid="+formUuid;
		if("2" == curPhase){
			var modulePath = document.getElementById("modulePath").value;
			url = url+"&modulePath="+modulePath;
		}
		
		if(curPhase=='4'){
			debugger;
			MAddSecScopeDialog.setHeight("600px");
		}
		
		 MAddSecScopeDialog.initSrc = url;
		 MAddSecScopeDialog.title = "添加权限范围";
		 parent.layer.open({
			 type:2,
			 title:['添加权限范围'],
			 area:['65%','65%'],
			 content:'<%=path%>/security/formSecScope_loadSecScopeBasicPage.action?oType=add&formUuid='+formUuid+'&iframewindowid=AddSecScopeDialog'
			 
		 });
		// Matrix.showWindow("AddSecScopeDialog");
	
	}
	
	
	//复制权限范围
	function copySecScope(){
		 var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	  	 var seRecord = dataGrid.getSelectedRecord ();
	  	 if(seRecord!=null){
	  	 var uuid = seRecord.uuid;
	  	 var scopeName = seRecord.name;
	  	 var formUuid = document.getElementById("formUuid").value;
	  	 var modulePath = document.getElementById("modulePath").value;
	  	 
	  	 var url ="<%=request.getContextPath()%>/security/formSecScope_copySecurityScope.action";
	  	 
	  	 var synJson = {'uuid':uuid,'scopeName':scopeName,'formUuid':formUuid,'modulePath':modulePath};	
	  	 	dataSend(synJson, url, "POST",function(data){
					
					var backData = data.data;
					if(backData!=null){
						var jsonData = isc.JSON.decode(backData);
						//服务端添加成功
						if(jsonData.message==true){
							//追加一条记录
				           var copyJson = {'formUuid':formUuid,'name':jsonData.scopeName,'uuid':jsonData.scopeUuid,'desc':jsonData.desc,'modulePath':modulePath};
						   var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
						   dataGrid.addData(copyJson);
						   var preSeRecord = dataGrid.getSelectedRecord ();
						   if(preSeRecord){
							   dataGrid.deselectRecord(preSeRecord);
						   }
						   dataGrid.selectRecord(dataGrid.getData().length-1); 
						   //加载此范围授权信息
						   linkToSecurity(null, copyJson);
						   
						}else if(jsonData.message==false){
							parent.isc.warn("复制权限范围失败!");
		    	 			
						}
						
					}
				
				} ,null);
	  	 
	  	 }else{
	  	 	isc.say('请选择要复制的授权范围!');
	  	 }
	  	 
	
	}
	
	//获取更新选中的权限范围
	function updateSecScope(){
	   var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	   var seRecord = dataGrid.getSelectedRecord ();
	   if(seRecord!=null){
		   var uuid = seRecord.uuid;
		   var curPhase = "<%=curPhase%>";
		   
	   	   var url ="<%=request.getContextPath()%>/security/formSecScope_loadUpdateSecScopeBasic.action?uuid="+uuid+"&oType=update";
	   	   if(curPhase=="2"){
		   	   	var formUuid = document.getElementById("formUuid").value;
		   	   	var modulePath = document.getElementById("modulePath").value;
		   	   	url = url+ "&formUuid="+formUuid+"&scopeName="+seRecord.name+"&modulePath="+modulePath;
	   	   }else{
	   	  	 var formUuid = document.getElementById("formUuid").value;
		   	 url = url+ "&formUuid="+formUuid
	   	   }
	   	   
	   	   MAddSecScopeDialog.record = seRecord;
	   	   var recordNum = dataGrid.getRecordIndex(seRecord);
	   	   MAddSecScopeDialog.recordNum = recordNum;
	   	   MAddSecScopeDialog.initSrc = url;
	   	   MAddSecScopeDialog.title = "编辑权限范围";
	   	   parent.layer.open({
	   		   type:2,
	   		   title:['编辑权限范围'],
	   		   area:['65%','65%'],
	   		   content:'<%=path%>/security/formSecScope_loadUpdateSecScopeBasic.action?uuid='+uuid+'&oType=update&formUuid='+formUuid+'&iframewindowid=AddSecScopeDialog'
	   				   
	   	   });
		   //Matrix.showWindow("AddSecScopeDialog");
	   
	   }else{
	   	parent.isc.say("未选中数据！");
	   }
	
	}
	

	//添加弹出框关闭时触发
	function onAddSecScopeDialogClose(data, oType){
		var modulePath = document.getElementById("modulePath").value;
		var formUuid = document.getElementById("formUuid").value;
	 	
	    if(oType!=null&&oType=="add"){
		    if(data!=null){
			    //data.formUuid = formUuid;
			    
			    var synJson = {'formUuid':formUuid,'name':data.name,'desc':data.desc,'modulePath':modulePath};
			  
				var url = "<%=request.getContextPath()%>/security/formSecScope_addSecScopeBasic.action";
				dataSend(synJson, url, "POST",function(data){
					//回调函数{message,scopeUuid}
					var backData = data.data;
					if(backData!=null){
						var jsonData = isc.JSON.decode(backData);
						//服务端添加成功
						if(jsonData.message=='true'){
						   synJson.uuid =jsonData.scopeUuid;//给添加记录添加uuid 属性

						   var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
							//追加一条记录
							dataGrid.addData(synJson);
							
							return true;
						}else if(jsonData.message=='repeat'){
							parent.isc.warn("授权范围名称重复!");
		    	 			return false;
						}
					}
				
				} ,null);
				
				return true;
			}
	    
	    }else if(oType!=null&&oType=="update"){
	    	if(data!=null){
	    	 var record =  MAddSecScopeDialog.record;
	     	 MAddSecScopeDialog.record = null;
	    	 var name = data.name;
	    	 var desc = data.desc;
	    	 record.name = name;
	    	 record.desc = desc;
	    	 var curPhase = "<%=curPhase%>";
	    	
	    	 record.uuid = data.uuid;
	    	 
	    	 var synJson = {'data':record,'modulePath':modulePath,'formUuid':formUuid};
	    	 
	    	 //更新
	    	 var url = "<%=request.getContextPath()%>/security/formSecScope_updateSceScopeBasic.action";
	    	 dataSend(synJson, url, "POST",function(data){
		    	 var backStr = data.data;
		    	 var backData = isc.JSON.decode(backStr);
		    	 if(backData.message=="true"){
		    	    var recordNum = MAddSecScopeDialog.recordNum;
		    	    MAddSecScopeDialog.recordNum = null;
		    	    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		    	    var record = dataGrid.getRecord(recordNum);
		    	    record.name = name;
		    	    record.desc = desc;
		    	    MDataGrid0.updateData(record);
		    	    MDataGrid0.refreshFields();
		    	 	
		    	 }else if(backData.message=="repeat"){
		    	 	parent.isc.warn("授权范围名称重复!");
		    	 	return false;
		    	 }else{
		    	 	 parent.isc.warn("更新失败!");
		    	 }
	    	 
	    	 },null);
	    	 
	    	}
	    }
		return true;
	}
	
  	//跳转到指定页面
	function forwardPage(src){
		src = "<%=request.getContextPath()%>"+"/"+src;
		//获取父页面的iframe
		parent.Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
	}
	
	//授权
	function linkToSecurity(viewer, record, recordNum, field, fieldNum, value, rawValue){
		var catalogId = '${param.catalogId}';
	   //文件模式下 表单路径
		//获取 formUuid scopeUuid
		var url = "security/formSecurity_getSecurityList.action?formUuid="+record.formUuid+"&scopeUuid="+record.uuid+"&scopeName="+record.name+"&catalogId="+catalogId;
		var curPhase = "<%=curPhase%>";
//		if(curPhase =="2"){//设计开发阶段
			//var formUuid = document.getElementById("formUuid").value;
	   		var modulePath = document.getElementById("modulePath").value;
			url = url+"&modulePath="+modulePath;
//		}
		//非场景下校验 发布状态
		if("${param.authView}"!="scene"){
			if("${param.state}"=="1"){
				url = url+"&state=${param.state}";
			}
		
		}
		url = encodeURI(url);
		forwardPage(url);
	}

	
	function initPage(){
		
		var state = "${param.state}";
		var authView = "${param.authView}";
		//非场景下校验发布状态
		if(authView!="scene"){
			if(state=="1"){//已经发布状态
			var membersArray = MDataGrid0_QF_tb.getMembers();//工具栏操作
			 	var currentArr;
				for(var i=0;i<membersArray.length;i++){
				    if(i==2)continue;
					currentArr = membersArray[i];
					currentArr.setDisabled (true);
				}
				
			}
		
		}
	
	}
</script>

</head>
<body onload="initPage()">
		
<%
com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>