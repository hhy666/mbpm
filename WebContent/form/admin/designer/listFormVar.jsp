<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>页面变量列表</title>

<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">
	//通过按钮更新
	function updateByEditButton(){
	   var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	   var record = dataGrid.getSelectedRecord();
		if(record!=null){
			 var recordIndex = dataGrid.getRecordIndex(record);
			 updateFormVar(record, recordIndex);
		
		}else{
			parent.isc.say("未选中表单变量!");
		}
	
	}



	//删除表单变量
    function deleteFormVar(){
    	//删除的同时也要发送一个异步请求，删除对应的数据
    	if(!MDataGrid0.getSelection() || MDataGrid0.getSelection().length==0){
			isc.warn("没有数据被选中，不能执行此操作。");
			return false;
		}
    	
        var deleteRecord = Matrix.itemsToJson(MDataGrid0.getSelection());
        var  deleteStr =  isc.JSON.encode(deleteRecord);
        var url = '<%=request.getContextPath()%>/designer/formDesign_saveFormVariables.action';
        var synData = "{'data':"+deleteStr+",'actionType':'delete'}";
	    var synJson = isc.JSON.decode(synData);
        Matrix.deleteDataGridData('DataGrid0');
	    dataSend(synJson,url,"POST",null,null);
    
    }
    
    

	//异步保存表单变量
	function saveFormVars(){
		//保存前将数据存入隐藏域中
	    var allData = Matrix.itemsToJson(MDataGrid0.getData());
		document.getElementById("MDataGrid0_data_rows").value=allData;
		//异步保存
		Matrix.convertFormItemValue('Form0');
		document.getElementById('Form0').action='<%=request.getContextPath()%>/designer/formDesign_saveFormVariables.action';
		//var x = convertEditDataGridData('MDataGrid0',true);
		 Matrix.send('Form0');
	}
	//调整显示类型的值
    function  typeFormatter(value, record, rowNum, colNum,grid){
            var convertValue = value;
			var type = record.type;
			 if(type=='List'){//列表
			     convertValue = "列表("+record.entity+")";
			 }else if(type=='DataObject'){
			     convertValue = 'DataObject('+record.entity+')';
			 }  
			     return convertValue;
     
     }
    //添加表单变量 
    function addFormVar(){
       	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
    	 //添加时将记录属性置空
	 	MDialog0.rowNum = null;
		MDialog0.colNum = null;
		MDialog0.record = null;
		MDialog0.allData =  dataGrid.getData();//添加时将所有数据传递到弹出框
		MDialog0.setTitle("添加表单变量");
		MDialog0.initSrc = "<%=request.getContextPath()%>/designer/formDesign_loadFormVarPage.action?oType=add";
		
		Matrix.showWindow('Dialog0');
		
    }
    //双击实现修改表单变量值
	function updateFormVar(record, recordNum){
	    //将修改前记录存入隐藏域
	   	 var preEditId =  document.getElementById("preEidtId");
	   	 preEditId.value=record.id;
	     var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	    //将数据传递到弹出框中
	     MDialog0.rowNum = recordNum;
		 //MDialog0.colNum = fieldNum;
		 MDialog0.record = record;
		 MDialog0.allData = dataGrid.getData();//修改时将所有数据传递到弹出框
		 MDialog0.setTitle("更新表单变量");
		 MDialog0.initSrc = "<%=request.getContextPath()%>/designer/formDesign_loadFormVarPage.action?oType=update";
		// MDialog0.show();
		Matrix.showWindow("Dialog0");
	}


	//鼠标移至记录上时显示默认值和描述信息
	function showDefaultValueAndDesc(record, rowNum, colNum){
	   var initValue = record.initValue;
	   var desc =  record.desc;
	  
	   initValue = (initValue!='undefined'&&initValue!=null)?initValue:"";
	   desc = (desc!='undefined'&&desc!=null)?desc:"";
	   var msg = "<b>默认值:</b>"+initValue+"<br>"+"<b>描述：</b>"+desc;
		return msg;
	}

	//添加窗口关闭时触发该方法
	function onDialog0Close(data,oType){
	 var recordNum = MDialog0.rowNum;//如果不为空时为修改
	 var url = '<%=request.getContextPath()%>/designer/formDesign_saveFormVariables.action';
	  if(data!=null){//确认按钮
	      var jsonObj = isc.JSON.decode(isc.JSON.encode(data)); 
	      var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	  
	      if(recordNum!=null){//recordNum更新 操作标识
	        
	        var preEditId =  document.getElementById("preEidtId").value;
	        var synData = "{'data':"+isc.JSON.encode(data)+",'actionType':'edit','preEditId':'"+preEditId+"'}";
	        var synJson = isc.JSON.decode(synData);
	        dataSend(synJson,url,"POST",function(data){
	       		var callbackStr = data.data;
	       		if(callbackStr!=null){
	       			var callbackJson = isc.JSON.decode(callbackStr);
	       			if(callbackJson.message==true){//更新成功
				        dataGrid.updateData(data);
	       		 		dataGrid.refreshFields();
	       				
	       			}else{
	       				isc.warn('更新失败!');
	       			}
	        	}
	        },null);
	       //同步更新数据
	       
	      }else{//添加
	       var synJson = {'data':data,'actionType':'add'};
	       dataSend(synJson,url,"POST",function(data){
	       		var callbackStr = data.data;
	       		if(callbackStr!=null){
	       			var callbackJson = isc.JSON.decode(callbackStr);
	       			if(callbackJson.message==true){
					        dataGrid.addData(jsonObj);
	       				  
	       			}else{
	       				isc.warn('添加失败!');
	       			}
	       		}
	       	
	       },null);
	      }
	      //添加和修改完后异步提交保存更新操作
	      //dataGrid.addData(jsonObj);
	  }
      return true;
	}
  		//初始化数据表格数据
		  function initGridList(){
		     //document.getElementById("listGridID").value = "MDataGrid0";
		     Matrix.send("Form0");
		     return false;
		  }
</script>
</head>
<body onload="initGridList()">
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
	
<script> 

var MForm0=isc.MatrixForm.create({
			ID:"MForm0",
			name:"MForm0",
			position:"absolute",
			action:"<%=request.getContextPath()%>/designer/formDesign_getFormVariables.action",
			fields:[{
				name:'Form0_hidden_text',
				width:0,height:0,
				displayId:'Form0_hidden_text_div'
			}]
});
</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/designer/formDesign_getFormVariables.action" style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
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
					prompt: "添加",
					showDisabledIcon:false,
					showDownIcon:false 
				});
				MToolBarItem3.click=function(){
						 Matrix.showMask();
						   addFormVar();
						 
		                 Matrix.hideMask();
                }
               </script>
                <script>
                isc.ToolStripButton.create({
                ID:"MToolBarItem5",
                icon:Matrix.getActionIcon("delete"),
                prompt: "删除",
                showDisabledIcon:false,
                showDownIcon:false 
                });
                MToolBarItem5.click=function(){
                Matrix.showMask();
                
                deleteFormVar();
				Matrix.hideMask();
				}
				</script>
				
				 <script>
                isc.ToolStripButton.create({
                ID:"MToolBarItem4",
                icon:Matrix.getActionIcon("edit"),
                prompt: "编辑",
                showDisabledIcon:false,
                showDownIcon:false 
                });
                MToolBarItem4.click=function(){
                Matrix.showMask();
                updateByEditButton();
               
				Matrix.hideMask();
				}
				</script>
			
			
				<script>
			 			isc.ToolStripButton.create({
			 			ID:"MToolBarItem7",
			 			icon:Matrix.getActionIcon("move_up"),
			 			prompt: "上移",
			 			showDisabledIcon:false,
			 			showDownIcon:false 
			 			});
			 			MToolBarItem7.click=function(){
				 			Matrix.showMask();
				 			var isUp = onMoveUpRecord("DataGrid0");
				 			
				 			if(isUp){
					 			//同时发送异步请求修改模型中变量值
					 			 var upRecord = Matrix.itemsToJson(MDataGrid0.getSelection());
	                             var  upStr =  isc.JSON.encode(upRecord);
	                             var url = '<%=request.getContextPath()%>/designer/formDesign_saveFormVariables.action';
	               				 var synData = "{'data':"+upStr+",'actionType':'up'}";
		    					 var synJson = isc.JSON.decode(synData);
		     					 dataSend(synJson,url,"POST",null,null);
				 			
				 			}
				 			
				 			Matrix.hideMask();
			 			}
			 		</script>
			 		<script>
			 			isc.ToolStripButton.create({
			 				ID:"MToolBarItem8",
			 				icon:Matrix.getActionIcon("move_down"),
			 				prompt: "下移",
			 				showDisabledIcon:false,
			 				showDownIcon:false
			 		    });
			 		    MToolBarItem8.click=function(){
				 		    	Matrix.showMask();
				 		    	var isDown = onMoveDownRecord("DataGrid0");
				 		    if(isDown){
					 		     var downRecord = Matrix.itemsToJson(MDataGrid0.getSelection());
	                             var  downStr =  isc.JSON.encode(downRecord);
	                             var url = '<%=request.getContextPath()%>/designer/formDesign_saveFormVariables.action';
	               				 var synData = "{'data':"+downStr+",'actionType':'down'}";
		    					 var synJson = isc.JSON.decode(synData);
		     					 dataSend(synJson,url,"POST",null,null);
				 		    
				 		     }	
				 		     Matrix.hideMask();
			 		    }</script>
		
		<div id="j_id5_div" style="width: 100%; overflow: hidden;">
		<script>
	isc.ToolStrip.create({
			ID:"Mj_id5",
			displayId:"j_id5_div",
			width: "100%",
			height: "*",
			position: "relative",
			members: [ 
					MToolBarItem3,
					MToolBarItem5,
					MToolBarItem4,
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
			<script> var MDataGrid0_DS=[{
			mid:'MATRIX',
			name:'MATRIX',
			type:'2',
			initValue:'1',
			id:'MATRIX',
			desc:'页面变量',initType:'defaultValue'
			},{mid:'FORM',name:'FORM',type:'1',value:'MATRIX',initValue:'MATRIX1',pageId:'MATRIX',desc:'页面变量',initType:'defaultValue'}];
			
			
			isc.MatrixListGrid.create({
				ID:"MDataGrid0",
				name:"DataGrid0",
				displayId:"DataGrid0_div",
				position:"relative",
				canHover:true,
				width:"100%",
				height:"100%",
				showAllRecords:true,
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
				title:"编码",
				matrixCellId:"j_id11",
				name:"id",
				canEdit:false,
				editorType:'Text',
				type:'text',
				formatCellValue:function(value, record, rowNum, colNum,grid){
					return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
				}
			},{
			title:"名称",
			matrixCellId:"j_id12",
			name:"name",
			canEdit:false,
			editorType:'Text',
			type:'text',
			formatCellValue:function(value, record, rowNum, colNum,grid){
				return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
			}
		},{
			title:"类型",
			matrixCellId:"j_id13",
			name:"type",
			canEdit:false,
			editorType:'select',
			type:'text',
			valueMap:{'String':'字符型','Integer':'整型','Long':'长整型','Float':'单精度小数','Double':'双精度小数','Boolean':'布尔型','Date':'日期时间','BigDecimal':'数值','Timestamp':'时间戳','Byte':'二进制','List':'列表','Object':'任意对象','DataObject':'实体类型'},
			formatCellValue:function(value, record, rowNum, colNum,grid){
			    return  typeFormatter(value, record, rowNum, colNum,grid);
					//return Matrix.formatter(convertValue,'normal','null', record, rowNum, colNum,grid);
			}
		},{
			title:"初始方式",
			matrixCellId:"j_id14",
			name:"initType",
			canEdit:false,
			editorType:'select',
			type:'text',
			valueMap:{'defaultValue':'默认值','autoLoad':'自动加载'},
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
	 			updateFormVar(record, recordNum);
	 
	 } 
	 });
	// MDataGrid0.setData(MDataGrid0_DS);
	 isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
	 isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
	 </script></div>
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
	function getParamsForDialog0(){
		var params='iframewindowid=Dialog0&';
		var value;
		return params;
	}
	
	isc.Window.create({
			ID:"MDialog0",
			id:"Dialog0",
			name:"Dialog0",
			//targetDialog:"MainDialog",
			autoCenter: true,
			position:"absolute",
			height: "100%",
			width: "90%",
			title: "添加表单变量",
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
			getParamsFun:getParamsForDialog0
	});
	MDialog0.hide();
	</script>
</div>

</body>
</html>