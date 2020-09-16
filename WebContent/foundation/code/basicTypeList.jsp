<%@page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<head>

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
	    //var parentUUID = "402881e64aeb712f014aeb7b62750001";
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
		
		url = "<%=request.getContextPath()%>/code/code_addBasicItem.action";
		Matrix.sendRequest(url,synData,function(data){
		    var cdata = data.data;
		    var callbackObj =isc.JSON.decode(cdata);
		     var message = callbackObj.message;
		    if(message==true){
		       var recordData = isc.JSON.decode(cbDataStr);
		         recordData.uuid = callbackObj.uuid;
		         var dataGrid = Matrix.getMatrixComponentById("DataGrid0"); 
				 dataGrid.getData().add(recordData);
				 
		   		 parent.isc.say("添加成功");
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
			Matrix.sendRequest(url,synData,function(data){
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
        	 Matrix.sendRequest(url, null, function(data){
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
<input type="hidden" name="iframewindowid" id="iframewindowid" value="">
		

<script> var M_mform_01=isc.MatrixForm.create({ID:"M_mform_01",name:"M_mform_01",position:"absolute",action:"<%=request.getContextPath()%>/Logon.jsp",fields:[{name:'_mform_01_hidden_text',width:0,height:0,displayId:'_mform_01_hidden_text_div'}]});</script><div style="width:100%;height:100%;overflow:auto;position:relative;"><form id="_mform_01" name="_mform_01" eventProxy="M_mform_01" method="post" action="<%=request.getContextPath()%>/Logon.jsp" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="_mform_01" value="_mform_01" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid__mform_01" name="matrix_form_datagrid__mform_01" value="" />
<div type="hidden" id="_mform_01_hidden_text_div" name="_mform_01_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>

<input id="parentUUID" type="hidden" name="parentUUID" value="${param.parentUUID }" /><input id="uuid" type="hidden" name="uuid" />
<script>
	function getParamsForAddBasicItemDialog(){
		var params='&';
		var value;
		value=null;
		try{
			getParentUUID();
		}catch(error){
			value="getParentUUID()"
		}
		if(value!=null){
			value="parentUUID="+value;
			params+=value;
		}
		value=null;
		params+='&';
		return params;
	}
	isc.Window.create({
		ID:"MAddBasicItemDialog",
		id:"AddBasicItemDialog",
		name:"AddBasicItemDialog",
		autoCenter: true,
		position:"absolute",
		height: "60%",
		width: "450px",
		title: "添加基本代码项",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"],
		getParamsFun:getParamsForAddBasicItemDialog,
		initSrc:"<%=request.getContextPath()%>/code/code_loadSaveBasicItemPage.action?oType=add",
		src:"<%=request.getContextPath()%>/code/code_loadSaveBasicItemPage.action?oType=add",showFooter: false });</script><script>MAddBasicItemDialog.hide();</script><script>function getParamsForUpdateBasicItemDialog(){var params='&';var value;value=null;try{value=eval("getItemUuid()");}catch(error){value="getItemUuid()"}if(value!=null){value="uuid="+value;params+=value;}return params;}isc.Window.create({ID:"MUpdateBasicItemDialog",id:"UpdateBasicItemDialog",name:"UpdateBasicItemDialog",autoCenter: true,position:"absolute",height: "60%",width: "450px",title: "更新基本代码项",canDragReposition: false,showMinimizeButton:true,showMaximizeButton:true,showCloseButton:true,showModalMask: false,modalMaskOpacity:0,isModal:true,autoDraw: false,headerControls:["headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"],getParamsFun:getParamsForUpdateBasicItemDialog,initSrc:"<%=request.getContextPath()%>/code/code_loadUpdateCodeBasicItem.action?oType=update",src:"<%=request.getContextPath()%>/code/code_loadUpdateCodeBasicItem.action?oType=update",showFooter: false });</script><script>MUpdateBasicItemDialog.hide();</script><table style="width:100%;height:100%;overflow:hidden;cellpadding:collapse;cellspacing:0px;border-collapse: collapse;border-spacing:0px;table-layout:fixed;"><tr><td colspan="2" style="border-style:none;width:100%;height:30px;overflow:hidden;"><script>isc.ToolStripButton.create({ID:"MToolBarItem0",icon:"[skin]/images/matrix/actions/add.png",prompt: "添加",showDisabledIcon:false,showDownIcon:false });MToolBarItem0.click=function(){Matrix.showMask();var x = eval("addBasicItem();");if(x!=null && x==false){Matrix.hideMask();return false;}Matrix.hideMask();}</script><script>isc.ToolStripButton.create({ID:"MToolBarItem1",icon:"[skin]/images/matrix/actions/edit.png",prompt: "修改",showDisabledIcon:false,showDownIcon:false });MToolBarItem1.click=function(){Matrix.showMask();var x = eval("updateBasicItem();");if(x!=null && x==false){Matrix.hideMask();return false;}Matrix.hideMask();}</script><script>isc.ToolStripButton.create({ID:"MToolBarItem2",icon:"[skin]/images/matrix/actions/delete.png",prompt: "删除",showDisabledIcon:false,showDownIcon:false });MToolBarItem2.click=function(){Matrix.showMask();var x = eval("deleteCodeItem();");if(x!=null && x==false){Matrix.hideMask();return false;}Matrix.hideMask();}</script><script>isc.ToolStripButton.create({ID:"MToolBarItem3",icon:"[skin]/images/matrix/actions/move_up.png",prompt: "上移",showDisabledIcon:false,showDownIcon:false });MToolBarItem3.click=function(){Matrix.showMask();var x = eval("onMoveUpRecord1(true);");if(x!=null && x==false){Matrix.hideMask();return false;}Matrix.hideMask();}</script><script>isc.ToolStripButton.create({ID:"MToolBarItem4",icon:"[skin]/images/matrix/actions/move_down.png",prompt: "下移",showDisabledIcon:false,showDownIcon:false });MToolBarItem4.click=function(){Matrix.showMask();var x = eval("onMoveDownRecord1(true);");if(x!=null && x==false){Matrix.hideMask();return false;}Matrix.hideMask();}</script><div id="DataGrid0_QF_tb_div"  style="width:100%;height:30px;;overflow:hidden;"  ><script>isc.ToolStrip.create({ID:"MDataGrid0_QF_tb",displayId:"DataGrid0_QF_tb_div",width: "100%",height: "100%",position: "relative",members: [ MToolBarItem0,MToolBarItem1,MToolBarItem2,MToolBarItem3,MToolBarItem4 ] });isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0_QF_tb.resizeTo(0,0);MDataGrid0_QF_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div></td>
</tr>
<tr><td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;"><div id="DataGrid0_div" class="matrixComponentDiv" style="width:100%;height:100%;">

<% 
System.out.println("-------------------");
%>

	<script> var MDataGrid0_DS=<%=request.getAttribute("data")%>;
		isc.MatrixListGrid.create({
			ID:"MDataGrid0",
			name:"DataGrid0",
			displayId:"DataGrid0_div",
			position:"relative",
			width:"100%",
			height:"100%",
			fields:[
			{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
			{title:"选项值",matrixCellId:"id",name:"id",canSort:false,canEdit:false,editorType:'Text',type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);}},
			{title:"选项显示值",matrixCellId:"name",name:"name",canSort:false,canEdit:false,editorType:'Text',type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);}},
			{title:"状态",matrixCellId:"isEnable",name:"isEnable",canSort:false,canEdit:false,editorType:'Text',type:'text',valueMap:{'1':'启用','2':'禁用'},displayValueMap:{'1':'启用','2':'禁用'}}],autoSaveEdits:false,isMLoaded:false,autoDraw:false,autoFetchData:true,selectionType:"single",selectionAppearance:"rowStyle",alternateRecordStyles:true,canSort:false,autoFitFieldWidths:false,recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue){linkToSecurity(viewer, record, recordNum, field, fieldNum, value, rawValue);},startLineNumber:1,showHeaderContextMenu:false,canEdit:true,editEvent:"doubleClick",exportCells:[{id:'j_id0',title:'选项值'},{id:'j_id1',title:'选项显示值'},{id:'j_id2',title:'状态'}],showRecordComponents:true,showRecordComponentsByCell:true});isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid0.isMLoaded=true;MDataGrid0.draw();MDataGrid0.setData(MDataGrid0_DS);MDataGrid0.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('_mform_01')){Matrix.getDataGridIdsHiddenOfForm('_mform_01').value=Matrix.getDataGridIdsHiddenOfForm('_mform_01').value+',DataGrid0'}</script></div><input id="matrix_Logon_dataGrid_DataGrid0" name="matrix_Logon_dataGrid_DataGrid0" type="hidden" value="DataGrid0" /><input id="DataGrid0_data_entity" name="DataGrid0_data_entity" type="hidden" /></td>
</tr>
</table>


</form></div><script>M_mform_01.initComplete=true;M_mform_01.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"M_mform_01.redraw()",null);},isc.Page.FIRE_ONCE);</script><input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />

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
			    Matrix.sendRequest(url,data,function(data){
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
			    Matrix.sendRequest(url,data,function(data){
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