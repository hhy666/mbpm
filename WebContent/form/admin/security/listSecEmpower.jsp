<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
<%
	//String formUser = CommonUtil.getFormUser();//zr or matrix
	String formUser = "matrix";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
<script type="text/javascript">
	//点击设置弹出条件设置窗口窗口
	function showSet(id,formUuid,rowNum){//授权项主键  表单编码  行号
		id = id.replace(/\s+/g,"");
        if(id!=null&&id.length>0){//如果授权项没有主键  不能添加操做设置 
	        MoperationSet.initSrc = "<%=request.getContextPath()%>/form/admin/security/betweenLayer.jsp?formUuid="+formUuid;
			MoperationSet.Src = "<%=request.getContextPath()%>/form/admin/security/betweenLayer.jsp?formUuid="+formUuid;
			var dataGrid = Matrix.getMatrixComponentById('DataGrid0');
			var record=dataGrid.getCellRecord(parseInt(rowNum));
			Matrix.setFormItemValue("rowNum",rowNum);
			
			debugger;
			if(parent.document.getElementById("controlSet")){     //表单设计数据权限
				parent.document.getElementById("controlSet").value=record.controlSet;
				//Matrix.showWindow("operationSet");
	        	var formulaSetId = parent.document.getElementById("controlSet").value;
	            parent.iframeJs = this;        //securityIndex.jsp弹出
			    parent.layer.open({
			    	id:'operationSet',
					type : 2,
					
					title : ['操作设置'],
					shadeClose: false, //开启遮罩关闭
					area : [ '80%', '90%' ],
					content : "<%=request.getContextPath() %>/security/formSecurity_loadControlSet.action?iframewindowid=operationSet&formulaSetId="+encodeURIComponent(formulaSetId)
				});	
			}else{           //流程设计数据权限
	        	var formulaSetId = record.controlSet;
	        	parent.iframeJs = this;        //floedesigner.jsp弹出
	        	parent.layer.open({
			    	id:'operationSet',
					type : 2,
					
					title : ['操作设置'],
					shadeClose: false, //开启遮罩关闭
					area : [ '70%', '99%' ],
					content : "<%=request.getContextPath() %>/security/formSecurity_loadControlSet.action?iframewindowid=operationSet&formUuid="+formUuid+"&formulaSetId="+encodeURIComponent(formulaSetId)
				});	
			}
     
        }else{
        	warn("请先保存数据!");
        }
		  
	}
	//窗口关闭  
	function onoperationSetClose(data){	
		debugger;
		var dataGrid = Matrix.getMatrixComponentById('DataGrid0');
		var editRowNum = Matrix.getFormItemValue("rowNum");
		var record=dataGrid.getCellRecord(parseInt(editRowNum));	
		if(data!=null){
			if(data==true){
				record.controlSet="";
			}else{
				var formulaSetId = JSON.stringify(data.conditionVal);
				record.controlSet=formulaSetId;
			}
		}
		MDataGrid0.redraw();
			
	}	  

	//保存授权信息
    function saveSecuritys(){
          var url = "<%=request.getContextPath()%>/security/security/formSecurity_saveSecurityList.action";
          var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
           dataGrid.saveAllEdits();//保存编辑值
          var addData = dataGrid.getData();
          
          if(addData!=null&&addData.length>0){
          	 //组织保存的数据
         	 var result = "["+Matrix.itemsToJson(addData)+"]";
         	 //var dataJson = isc.JSON.decode(result);
         	 var scopeUuid = document.getElementById("scopeUuid").value;
         	 var formUuid = document.getElementById("formUuid").value;
         	 var modulePath = document.getElementById("modulePath").value;
         	 var asynJson= {'data':result,'scopeUuid':scopeUuid,'formUuid':formUuid,'modulePath':modulePath};
         	 
         	 dataSend(asynJson, url, "POST",function(data){
		    	 var backStr = data.data;
		    	 var backData = isc.JSON.decode(backStr);
		    	 if(backData.message=="true"){
		    	 	location.reload();
		    	 	parent.layer.alert("授权成功!");
		    	 
		    	 }else{
		    	 	parent.layer.alert("授权失败!");
		    	 }
		    	 
		    	 }, null);
          	
          }
    }

	//加载范围子项时 提供scopeUuid
	function getscopeUuid(){
		//获取当前选择数据行  获取record uuid属性
		 var scopeUuid = MSecScopeItemDialog.scopeUuid;
		 MSecScopeItemDialog.scopeUuid = null;
        
		return scopeUuid;
	}
	//重写字段变化方法  是否显示
	function displayChanged(form, item, value){
		//value 为更改后的新值
		var grid = Matrix.getMatrixComponentById("DataGrid0");
	
		var rowNum = grid.getFocusRow(); 
		if(value==false){//选中->未选中
			grid.setEditValue(rowNum, "isEdit", false);//不显示不可编辑约束
			grid.setEditValue(rowNum, "isRequired", false);
		}
		grid.refreshFields();
	}
	//重写字段变化方法  是否可编辑
	function editChanged(form, item, value){
		var grid = Matrix.getMatrixComponentById("DataGrid0");
		var rowNum = grid.getFocusRow();
		
		if(value==true){//可编辑 肯定显示约束
			grid.setEditValue(rowNum, "isDisplay", true);
		}else{//不可编辑  肯定不能必填约束
			grid.setEditValue(rowNum, "isRequired", value);
		}
		
		grid.refreshFields();
	}
	//设置必填（单个）---------lpz---------
	function requiredToWrite(form, item, value){
		var grid = Matrix.getMatrixComponentById("DataGrid0");
		var rowNum = grid.getFocusRow();
		//选中
		if(value==true){
			//必填项选中，必须 是可显示，可编辑
			grid.setEditValue(rowNum,"isDisplay",true);
			grid.setEditValue(rowNum,"isEdit",true);
		}
		grid.refreshFields();
	}
	
	
	
	
	 //是否可显示变化rowNum从0开始
      function globalCanShowChanged(form,item,value){
      		var grid = Matrix.getMatrixComponentById("DataGrid0");
      		var tempRecord = null;
      		var canShowValue = false;
      		//获取所有的数据
      		var gridData = grid.getData();
      		if(gridData==null||gridData.length==0){
      			return;
      		}
      		
      		if("1"==value){
      			canShowValue = true;
      		}
      		
      		for(var i=0;i<gridData.length;i++){
      			tempRecord = gridData[i];
      			//tempRecord.isDisplay = canShowValue;
      			grid.setEditValue(i, "isDisplay", canShowValue);//不显示不可编辑约束
      			
      			if(!canShowValue){
      				grid.setEditValue(i, "isEdit", canShowValue);
      				grid.setEditValue(i, "isRequired", canShowValue);//---------lpz-----------
      			}
      		
      		}
      		
      		grid.refreshFields();
      		
        
      }
      
       //是否可编辑变化
      function globalCanEditChanged(form,item,value){
        	var grid = Matrix.getMatrixComponentById("DataGrid0");
      		var tempRecord = null;
      		var canShowValue = false;
      		//获取所有的数据
      		var gridData = grid.getData();
      		if(gridData==null||gridData.length==0){
      			return;
      		}
      		
      		if("1"==value){
      			canShowValue = true;
      		}
      		
      		
      		//不显示时,不可编辑
      		var displayEditValue = null;
      		for(var i=0;i<gridData.length;i++){
      			tempRecord = gridData[i];
      			 displayEditValue = grid.getEditValue(i, 'isDisplay');//获取编辑值如果编辑过
			     if(displayEditValue==null){
			         displayEditValue = gridData[i].isDisplay;
			     }
      			 if((!displayEditValue)&&canShowValue){//不显示且可编辑时 
      			 	grid.setEditValue(i, "isEdit", false);
      			 }else{
      			 	grid.setEditValue(i, "isEdit", canShowValue);
      			 }
      			 if(!canShowValue){//只要不可编辑，必填就不能选中
      			 	grid.setEditValue(i, "isRequired", false);
      			 }
      			
      		}
      		
      		grid.refreshFields();
        
      }
       //必填项变化    ---------lpz---------
      function globalRequiredValueChanged(form,item,value){
    	   debugger;
        		var grid = Matrix.getMatrixComponentById("DataGrid0");
      		var tempRecord = null;
      		var canShowValue = false;
      		//获取所有的数据
      		var gridData = grid.getData();
      		if(gridData==null||gridData.length==0){
      			return;
      		}
      		
      		if("1"==value){
      			canShowValue = true;
      		}
      		//显示+可编辑   才有必填项
      		var displayRequiredValue;
      		for(var i=0;i<gridData.length;i++){
      			tempRecord = gridData[i];
      			grid.setEditValue(i, "isRequired", canShowValue);
      			displayRequiredValue = grid.getEditValue(i, 'isEdit');//获取编辑值如果编辑过
			    if(displayRequiredValue==null){
			       displayRequiredValue = gridData[i].isEdit;
			    }
      			if(!displayRequiredValue){//不可编辑，就不能必填，
      				grid.setEditValue(i, "isRequired", false);
      			}else{
      				grid.setEditValue(i, "isRequired", canShowValue);
      			}
      		}
      		
      		grid.refreshFields();
        
      }
       //默认值变化
      function globalInitValueChanged(form,item,value){
        		var grid = Matrix.getMatrixComponentById("DataGrid0");
      		var tempRecord = null;
      		var canShowValue = false;
      		//获取所有的数据
      		var gridData = grid.getData();
      		if(gridData==null||gridData.length==0){
      			return;
      		}
      		
      		if("1"==value){
      			canShowValue = true;
      		}
      		
      		for(var i=0;i<gridData.length;i++){
      			tempRecord = gridData[i];
      			grid.setEditValue(i, "isBusOper", canShowValue);
      			
      		
      		}
      		
      		grid.refreshFields();
        
      }
      function formatStatus(record){
    	  var info="";
    	  if(record.controlSet!=''){
    	      info = "<span><font style='color:red;'>√</font></span>";
    	  }
    	  return info;
    	}
	
	function initPage(){
		
	    //var dataGrids = Matrix.getMatrixComponentById("DataGrid0");
	    //var result = dataGrids.data;
	    //for(var i in result){
	    	//var key = result[i];
	    	//var condition =key.controlSet;
	    	//if(condition!=""){
	    		//var setUp = Matrix.getMatrixComponentById("DataCellDisplayType001");
	    	//}
	    //}
		
		var formUser = "<%=formUser%>";
		
    	var tabContent = "<div  style='width:100%;' >";
    	
           		tabContent= tabContent+	"<div  id='label001_div'  style='margin-top:8px;width:55%;float:left;'  >&nbsp;当前授权范围: ${scopeName}</div>";
            	
            	//显示用的div          /leaveType_4_div-----lpz-----/
            	tabContent= tabContent+	"<div  id='leaveType_1_div'  eventProxy='M_mform_01' style='margin-top:8px;width:60px;float:left;' ></div>"+
            		"<div  id='leaveType_2_div'  eventProxy='M_mform_01' style='margin-top:8px;width:60px;float:left;' ></div>"+
            		"<div  id='leaveType_4_div'  eventProxy='M_mform_01' style='margin-top:8px;width:60px;float:left;' ></div>";
            		
            		
           tabContent = tabContent+"<div  id='leaveType_3_div'  eventProxy='M_mform_01' style='margin-top:8px;width:60px;float:left;' ></div>";
        tabContent = tabContent+"</div>";
	
		
		MDataGrid0_QF_tb.align="right";//按钮居右
		 
		var membersArray = MDataGrid0_QF_tb.getMembers();//工具栏操作
		
		MDataGrid0_QF_tb.addMember( 
			isc.MatrixHTMLFlow.create({
            		contents: tabContent
  			 }),0
	  	    );
	  	    
	  	
		
		M_mform_01.addField(
			 isc.CheckboxItem.create({
		        ID: "MleaveType_1",
		        name: "leaveType_1",
		        editorType: "CheckboxItem",
		        displayId: "leaveType_1_div",
		        value: "M_NULL",
		        valueMap:{
		            "M_NULL":false,
		            "1":true
		        },
		        title: "可显示",
		        position: "relative",
		        groupId: "leaveType",
		        required: false,
		        width:35
		        ,
		       changed: "globalCanShowChanged(form,item,value)"
	    	})
        
        );
        
        
        	M_mform_01.addField(
			 isc.CheckboxItem.create({
		        ID: "MleaveType_2",
		        name: "leaveType_2",
		        editorType: "CheckboxItem",
		        displayId: "leaveType_2_div",
		        value: "M_NULL",
		        valueMap:{
		            "M_NULL":false,
		            "1":true
		        },
		        title: "可编辑",
		        position: "relative",
		        groupId: "leaveType",
		        required: false,
		        width:35
		        ,
		        changed: "globalCanEditChanged(form,item,value)"
	    	})
        
        );
        //必填项  -----lpz------
        M_mform_01.addField(
			 isc.CheckboxItem.create({
		        ID: "MleaveType_4",
		        name: "leaveType_4",
		        editorType: "CheckboxItem",
		        displayId: "leaveType_4_div",
		        value: "M_NULL",
		        valueMap:{
		            "M_NULL":false,
		            "1":true
		        },
		        title: "必填项",
		        position: "relative",
		        groupId: "leaveType",
		        required: false,
		        width:35,
		       changed: "globalRequiredValueChanged(form,item,value)"
	    	})
        ); 
           
        
        	
        	M_mform_01.addField(
				 isc.CheckboxItem.create({
			        ID: "MleaveType_3",
			        name: "leaveType_3",
			        editorType: "CheckboxItem",
			        displayId: "leaveType_3_div",
			        value: "M_NULL",
			        valueMap:{
			            "M_NULL":false,
			            "1":true
			        },
			        title: "默认值",
			        position: "relative",
			        groupId: "leaveType",
			        required: false,
			        width:35 ,
			        changed: "globalInitValueChanged(form,item,value)"
		    	})
        
           );
        
       	
        
       
      
		//授权发布状态下 除了关闭外 按钮禁用
		var state = "${param.state}";
		var authView = "${param.authView}";
		if(state=="1"){//已经发布状态
			if(authView!="scene"){
			 	var currentArr = membersArray[membersArray.length-1];
				currentArr.setDisabled (true);
					
			    //MDataGrid0.setCanEdit(false);
			}
		}
	
	}
	
	

</script>

</head>
<body onload="initPage()">
	 <jsp:include page="/form/admin/common/loading.jsp"/>	
<%
	boolean hasNewItem = false;
   if( request.getAttribute("data") != null){
	    java.util.List list = (java.util.List)request.getAttribute("data");
	    for(int i=0; i<list.size(); ++i){
	    	com.matrix.form.admin.security.model.FormSecurityMessage item = (com.matrix.form.admin.security.model.FormSecurityMessage)list.get(i);
	    	if(item.isNewItem()){
	    		hasNewItem = true;
	    	}
	    }
   }
	

	if(hasNewItem){
%>
	<script> layer.msg('当前数据权限项有新增项，保存后才能生效', {icon: 0});</script>

<%		
		
	}
com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>