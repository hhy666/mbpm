<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>表单操作列表</title>

<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">
	//调整显示类型的值
    function  typeFormatter(value, record, rowNum, colNum,grid){
            var convertValue = value;
			var type = record.type;
			 if(type=='List'){//列表
			     convertValue = "列表("+record.entity+")";
			 }else if(type=='DataObject'){
			     convertValue = record.entity;
			 }  
			     return convertValue;
     
     }
     //添加自定义逻辑
     function addCustomFormOperation(){
     	var url ="<%=request.getContextPath()%>/designer/formDesign_addFormCustomLogic.action?eventType=${param.eventType}&ajaxEventType=${param.ajaxEventType}";
        opType= "add";
        MDialog0.opType = "add"; 
		MDialog0.initSrc = url;
		MDialog0.setTitle ("添加自定义逻辑");
		Matrix.showWindow('Dialog0');
     }
     
     
    //添加内置操作 load add page
    function addFormInnerOperation(){
       var url ="<%=request.getContextPath()%>/designer/formDesign_addFormInnerLogic.action?eventType=${param.eventType}&ajaxEventType=${param.ajaxEventType}";
    	//添加时将记录属性置空
	 	//MDialog0.rowNum = null;
		//MDialog0.colNum = null;
		//MDialog0.record = null;
		opType= "add";
		MDialog0.opType = "add"; 
		MDialog0.initSrc = url;
		MDialog0.setTitle ("添加内置服务");
		//MDialog0.setSrc(url);
		Matrix.showWindow('Dialog0');
    }
    //双击实现修改操作
	function updateFormOperation(record, recordNum){
	    //根据type 来指定修改页面 将修改前记录存入隐藏域
	     var url = "<%=request.getContextPath()%>/designer/formDesign_getUpdateFormOper.action?rowNum="+recordNum+"&eventType=${param.eventType}&ajaxEventType=${param.ajaxEventType}"; 
	    //将数据传递到弹出框中记录
	     MDialog0.rowNum = recordNum;
		 //MDialog0.colNum = fieldNum;
		MDialog0.record = record;
		opType = "update";//修改时将所有数据传递到弹出框
		MDialog0.opType = "update"; 
		MDialog0.setTitle ("编辑逻辑服务");
		MDialog0.initSrc = url; 
		Matrix.showWindow("Dialog0");
	}
	//通过按钮实现修改操作
    function  updateByButton(){
    	 var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
    	 var record =  dataGrid.getSelectedRecord();
    	 if(record!=null){
	    	 var recordNum = dataGrid.getRecordIndex(record);
	    	 updateFormOperation(record, recordNum);
    	 
    	 }else{
    	 	 isc.warn("没有数据被选中，不能执行此操作。");
    	 }
    	 
    }
	//鼠标移至记录上时显示默认值和描述信息
	function showDefaultValueAndDesc(record, rowNum, colNum){
	   var fullName = record.fullName;
	   var msg = "<b>服务:</b>"+record.service+"<br>"+"<b>方法：</b>"+fullName==null?"":fullName;
		return msg;
	}


	//添加内置服务弹出窗口关闭触发oType update | add
	function onDialog0Close(data,oType){
	 if(data!=null){
	   
		 var jsonObj = isc.JSON.decode(isc.JSON.encode(data)); 
	     var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	     
		 var url = '<%=request.getContextPath()%>/designer/formDesign_saveFormOperations.action';
		 var opType = MDialog0.opType;
		 if(opType=="add"){//添加
	         var synJson = {'data':data,'actionType':'add'};
	         synJson["eventType"]="${param.eventType}";
	         synJson["ajaxEventType"]="${param.ajaxEventType}";
	         dataSend(synJson,url,"POST",function(data){
	         	var dataStr = data.data;
	         	if(dataStr!=null){
	         		var dataJson = isc.JSON.decode(dataStr);
	         		if(dataJson.message==true){
	        			dataGrid.addData(jsonObj);
	         			
	         		}else{
	         			isc.warn('添加失败');
	         		}
	         	}
	         
	         },null);
		 
		 }else if(opType=="update"){//更新
			 var recordNum = MDialog0.rowNum;
			 var  record = MDialog0.record;
			 var type = jsonObj.type;//添加操作的类型
			 
			 //update record field
			 record.service = jsonObj.service;
			 record.name = jsonObj.name;
			 record.type = jsonObj.type;
			 if(type=='custom'){//自定义逻辑
				 record.content = jsonObj.content;
			 
			 }else{
				 record.serviceName = jsonObj.serviceName;
				 record.condition = jsonObj.condition;
				 record.inputs =jsonObj.inputs;
				 record.location =jsonObj.location;
				 record.methodName =jsonObj.methodName;
				 record.methodTitle =jsonObj.methodTitle;
				 record.returnPO =jsonObj.returnPO;
			 
			 }
	        var synJson = {'data':jsonObj,'actionType':'update','rowNum':recordNum};
	        synJson["eventType"]="${param.eventType}";
	        synJson["ajaxEventType"]="${param.ajaxEventType}";
	        dataSend(synJson,url,"POST",function(data){
		        var dataStr = data.data;
		         	if(dataStr!=null){
		         		var dataJson = isc.JSON.decode(dataStr);
		         		if(dataJson.message==true){
						     dataGrid.updateData(record);
					         dataGrid.refreshFields();
		         		
		         		}else{
		         			isc.warn('更新失败');
		         		}
		         	}
	        
	        },null);
		 }
	    }
      return true;
	}
  //初始化数据表格数据
		  function initGridList(){
		     //document.getElementById("listGridID").value = "MDataGrid0";
		     Matrix.send("Form0");
		     return false;
		  }
		  
		  //删除 上移 下移
		  function operateOperation(dataGridName,operationType){
				
                 var dataGrid =  Matrix.getMatrixComponentById(dataGridName);
                 var record = dataGrid.getSelectedRecord();
                 var rowNum = dataGrid.getRecordIndex(record);
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
                 var url = '<%=request.getContextPath()%>/designer/formDesign_saveFormOperations.action?eventType=${param.eventType}&ajaxEventType=${param.ajaxEventType}';
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
</script>
</head>
<body onload="initGridList()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 

var MForm0=isc.MatrixForm.create({
			ID:"MForm0",
			name:"MForm0",
			position:"absolute",
			action:"<%=request.getContextPath()%>/designer/formDesign_getFormOperations.action",
			fields:[{
				name:'Form0_hidden_text',
				width:0,
				height:0,
				displayId:'Form0_hidden_text_div'
			}]
});
</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/designer/formDesign_getFormOperations.action" style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="eventType" value="${param.eventType}" />
	<input type="hidden" name="ajaxEventType" value="${param.ajaxEventType}" />
	<input type="hidden" name="preEidtId" id="preEidtId" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
<table id="j_id2" jsId="j_id2" cellpadding="0px" cellspacing="0px"
	style="width: 100%; height: 100%;">
	<tr id="j_id3" jsId="j_id3">
		<td id="j_id4" jsId="j_id4" class="Toolbar" colspan="2" rowspan="1" style="border-style: none;">
		<script>
			isc.ToolStripButton.create({
					ID:"MToolBarItem3",
					icon:Matrix.getActionIcon("add"),
					title: "内置逻辑",
					showDisabledIcon:false,
					showDownIcon:false 
				});
				MToolBarItem3.click=function(){
						 Matrix.showMask();
						 addFormInnerOperation();
		                 Matrix.hideMask();
                }
               </script>
               <script>
			isc.ToolStripButton.create({
					ID:"MToolBarItem4",
					icon:Matrix.getActionIcon("add"),
					title: "自定义逻辑",
					showDisabledIcon:false,
					showDownIcon:false 
				});
				MToolBarItem4.click=function(){
						 Matrix.showMask();
						 addCustomFormOperation();
						 
		                 Matrix.hideMask();
                }
               </script>
                <script>
                isc.ToolStripButton.create({
	                ID:"MToolBarItem6",
	                icon:Matrix.getActionIcon("edit"),
	                title: "编辑",
	                showDisabledIcon:false,
	                showDownIcon:false 
                });
                MToolBarItem6.click=function(){
	                Matrix.showMask();
	                //获取当前选中的记录，执行双击时触发的事件
	                updateByButton();
					Matrix.hideMask();
				}
				</script>
                <script>
                isc.ToolStripButton.create({
	                ID:"MToolBarItem5",
	                icon:Matrix.getActionIcon("delete"),
	                title: "删除",
	                showDisabledIcon:false,
	                showDownIcon:false 
                });
                MToolBarItem5.click=function(){
	                Matrix.showMask();
	                operateOperation("DataGrid0","delete");
	            
					Matrix.hideMask();
				}
				</script>
				
				
			
		<script>
			 			isc.ToolStripButton.create({
			 			ID:"MToolBarItem7",
			 			icon:Matrix.getActionIcon("move_up"),
			 			title: "上移",
			 			showDisabledIcon:false,
			 			showDownIcon:false 
			 			});
			 			MToolBarItem7.click=function(){
				 			Matrix.showMask();
				 			operateOperation("DataGrid0","up");
				 			
				 			Matrix.hideMask();
			 			}
			 		</script>
			 		<script>
			 			isc.ToolStripButton.create({
			 				ID:"MToolBarItem8",
			 				icon:Matrix.getActionIcon("move_down"),
			 				title: "下移",
			 				showDisabledIcon:false,
			 				showDownIcon:false
			 		    });
			 		    MToolBarItem8.click=function(){
				 		    	Matrix.showMask();
				 		       operateOperation("DataGrid0","down");
				 		    	
				 		    	if(!MForm0.validate()){
				 		    		Matrix.hideMask();
				 		    		return false;
				 		    	}
				 		    Matrix.hideMask();
			 		    }</script>
		
		<div id="j_id5_div" style="width: 100%;height:38px; overflow: hidden;">
		<script>
	isc.ToolStrip.create({
			ID:"Mj_id5",
			displayId:"j_id5_div",
			width: "100%",
			height: "100%",
			position: "relative",
			members: [ 
					MToolBarItem3,
					
					MToolBarItem6,
					MToolBarItem5,
					"separator",
			 		MToolBarItem7,
			 		MToolBarItem8
			 ]
	 });
	 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
	 </script>
	 </div>
		</td>
	</tr>
	<tr id="j_id8" jsId="j_id8">
		<td id="j_id9" jsId="j_id9" colspan="2" rowspan="1" style="border-style: none; width: 100%; height: 100%">
		<div id="DataGrid0_div" class="matrixComponentDiv"
			style="width: 100%; height: 100%;">
			<script>
			
			isc.MatrixListGrid.create({
				ID:"MDataGrid0",
				name:"DataGrid0",
				displayId:"DataGrid0_div",
				position:"relative",
				width:"100%",
				height:"100%",
				showAllRecords:true,
				canHover:true,
				showHover:true,
				cellHoverHTML:function(record, rowNum, colNum){
				  return showDefaultValueAndDesc(record, rowNum, colNum);
				},
				fields:[
				
				
				{//行号
				title:"&nbsp;",
				name:"MRowNum",
				canSort:false,
				canExport:false,
				canDragResize:false,
				showDefaultContextMenu:false,
				autoFreeze:true,
				autoFitEvent:'none',
				width:45,
				canEdit:false,
				canFilter:false,
				autoFitWidth:false,
				formatCellValue:function(value, record, rowNum, colNum,grid){
					if(grid.startLineNumber==null)return '&nbsp;';
					return grid.startLineNumber+rowNum;
					}
				},{
					title:"名称",
					matrixCellId:"j_id11",
					name:"name",
					canEdit:false,
					editorType:'Text',
					type:'text',
					formatCellValue:function(value, record, rowNum, colNum,grid){
						return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					}
			    },
				
				{
				title:"服务",
				matrixCellId:"j_id11",
				name:"service",
				canEdit:false,
				editorType:'Text',
				type:'text',
				formatCellValue:function(value, record, rowNum, colNum,grid){
					return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
				}
			},{
			title:"方法",
			matrixCellId:"j_id12",
			name:"methodTitle",
			canEdit:false,
			editorType:'Text',
			type:'text',
			formatCellValue:function(value, record, rowNum, colNum,grid){
				return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
			}
		}
	 ],
	 autoSaveEdits:false,
	 autoFetchData:true,
	 selectionType:"single",
	 selectionAppearance:"rowStyle",
	 alternateRecordStyles:true,
	 canSort:true,
	 canAutoFitFields:false,
	 startLineNumber:1,
	 canEdit:true,
	 //editEvent:"doubleClick",
	 showRecordComponents:true,
	 showRecordComponentsByCell:true,
	 recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue){
	 			updateFormOperation(record, recordNum);
	 
	 } 
	 });
	// MDataGrid0.setData(MDataGrid0_DS);
	 isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
	 isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
	 </script>
	 
	 </div>
	    <input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
		<input id="DataGrid0_insert_rows" name="DataGrid0_insert_rows" type="hidden" />
		<input id="DataGrid0_update_rows" name="DataGrid0_update_rows" type="hidden" />
		<input id="DataGrid0_delete_rows" name="DataGrid0_delete_rows" type="hidden" />
		<input id="dataGridID" name="dataGridID" type="hidden" value="MDataGrid0"/>
		</td>
	</tr>
	<tr id="j_id17" jsId="j_id17"></tr>
</table>

</form>
<script>MForm0.initComplete=true;MForm0.redraw();
isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
<script>
    var opType = null;
	function getParamsForDialog0(){
	    
		var params='&opType='+opType;
		var value;
		return params;
	}
	
	isc.Window.create({
			ID:"MDialog0",
			id:"Dialog0",
			name:"Dialog0",
			targetDialog:"FormOperationTarget",
			autoCenter: true,
			position:"absolute",
			height: "100%",
			width: "95%",
			title: "添加内置逻辑",
			canDragReposition: false,
			showMinimizeButton:false,
			showMaximizeButton:false,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel",
				"minimizeButton","maximizeButton","closeButton"
			],
			getParamsFun:getParamsForDialog0,
			initSrc:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp",
			src:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp" 
	});
	//MDialog0.hide();
	</script>
	

	
	</div>

</body>
</html>