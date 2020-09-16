<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		int curPhase = CommonUtil.getCurPhase();

	%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询对象属性维护</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></SCRIPT>

<style>
html{
   touch-action:none;
}
</style>
<script type="text/javascript">

	function infoMsg(message){
		
		 layer.msg(message, {icon: 1});
	}
	
	function warnMsg(message){
		
		 layer.msg(message, {icon: 0});
	}

	function validatePhase() {
	    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
	    var seArray = dataGrid.getSelection();
	    var seRecord = null;
	    if (seArray != null) {
	        for (var i = 0; i < seArray.length; i++) {
	            seRecord = seArray[i];
	            if ("2" == seRecord.phase) {
	                warnMsg('研发阶段数据不可删除!');
	                return false;
	            }
	
	        }
	
	    }
	    return true;
	}




		//导出属性到文件 entityUuid entityType  mid
		function exportPropertyToFile(){
		    var entityMid = parent.document.getElementById("mid").value;
		    //var entityType = "queryObject";
			var entityUuid = document.getElementById("entityUuid").value;
			var url = "<%=request.getContextPath()%>/file/exportfile?exportType=entity&entityUuid="+entityUuid+"&mid="+entityMid+"&entityType=queryObject";
			window.location.href = url;
		}
		 
		 //同步ds数据(同步表)或 同步hb模型(false) 
		 function synPropsContent(isSynTable){
		    var _curGrid = Matrix.getMatrixComponentById("DataGrid0");
			var allData = _curGrid.getData();
		    var len = allData.length;
		    if(len==0){
		   		 infoMsg("属性数据为空,操作无效!");
		   		 return false;
		    }
		     //数据需要保存后再同步
			if( MDataGrid0.hasChanges()){
				    warnMsg('数据未保存，不能执行此操作！');
				    return false;
			}
			var dataResult = Matrix.itemsToJson(allData);
	    	document.getElementById("MDataGrid0_data_rows").value=dataResult;
	    	//清空所有编辑数据
	    	_curGrid.dataResult = []; 
			_curGrid.insertItems = [];
			_curGrid.updateItems = [];
			_curGrid.deleteItems = [];
			_curGrid.isMove = null;
	    	
			
			var url = "<%=request.getContextPath()%>/entity/entityProperty_synPropsContent.action?isSynTable="+isSynTable;
			document.getElementById('Form0').action= url;
			Matrix.send("Form0");  
		 
		 }
		 
		 
		 //异步同步操作回调函数
		 function synDSCallBack(data){
		    var message = data.data;
		 	if(message=="true"){
		 		infoMsg("同步成功!");
		 	}else{
		 		infoMsg("同步失败!");
		 	}
		 
		 }
		
		 
		 
           //复制数据
          function  copyPropertyList(){
             var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
             if(dataGrid){
               	// var data = "[]";
		 	    if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
			    	warnMsg("没有数据被选中，不能执行此操作。");
			    	return null;
				}
				dataGrid.copyData = null;
				var recordData = dataGrid.getData();
				
				var selectedArray = dataGrid.getSelection();
				var copyArray =[];
				var curRecord;
				
				var curRowNum;
				var editedPartObj;
				for(var i=0;i<selectedArray.length;i++){
					//获取编辑值
					curRecord = selectedArray[i];
					curRowNum = recordData.indexOf(curRecord);
					editedPartObj = dataGrid.$300(curRowNum);
					
					
					var tempStr = Matrix.itemsToJson(curRecord,dataGrid);
					var newRecord = isc.JSON.decode(tempStr);
			
					isc.addProperties(newRecord, editedPartObj);
					newRecord.uuid=undefined;
					newRecord.index=undefined;
					copyArray.push(newRecord);
				}
				
				dataGrid.copyData = copyArray;
				
           }
        }
        
        
        //剪切数据
        function cutPropertyList(){
        
        	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
             if(dataGrid){
               	// var data = "[]";
		 	    if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
			    	warnMsg("没有数据被选中，不能执行此操作。");
			    	return null;
				}
				 dataGrid.copyData = null;
				//var selectedRecord = dataGrid.getSelection();
				//将选中的数据追加到数据中
			    // dataGrid.copyData = eval("["+Matrix.itemsToJson(selectedRecord,dataGrid)+"]");
			    var recordData = dataGrid.getData();
			    var selectedArray = dataGrid.getSelection();
				var copyArray =[];
				var curRecord;
				
				var curRowNum;
				var editedPartObj;
				for(var i=0;i<selectedArray.length;i++){
					//获取编辑值
					curRecord = selectedArray[i];
					curRowNum = recordData.indexOf(curRecord);
					editedPartObj = dataGrid.$300(curRowNum);
					
					
					var tempStr = Matrix.itemsToJson(curRecord,dataGrid);
					var newRecord = isc.JSON.decode(tempStr);
			
					isc.addProperties(newRecord, editedPartObj);
					copyArray.push(newRecord);
				}
				
				dataGrid.copyData = copyArray;
			    
			     //删除选中记录
				dataGrid.removeSelectedData();
           }
        }
        
        
        //粘贴数据
		function pastePropertyList(){
		    
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			
			//将操作域的数据追加到数据表格
			
			if(dataGrid.copyData!=null &&dataGrid.copyData.length>0){
			    dataGrid.insertItems = dataGrid.copyData;//仅用于标示
			   var copyArray = dataGrid.copyData ;
			  
			    for(var i=0;i<copyArray.length;i++){
			    	var curRecord = copyArray[i];
			    	var curInitObj = {'proEntityName':curRecord.proEntityName};
			    	dataGrid.getData().add(curInitObj);

				    dataGrid.setEditValues (dataGrid.getData().length-1, curRecord);
			  		
			   
			    }
			// dataGrid.getData().addAll(dataGrid.copyData);
			}
			return true;		 	
		}
        

		  //初始化数据表格数据
		  function initGridList(){
		     document.getElementById("gridListName").value = "MDataGrid0";
		   	 document.getElementById("entityUuid").value = "${param.entityUuid}"; //需要根据链接动态赋值
		     Matrix.send("Form0");
		     return false;
		  }

		//UI组件显示对应的图片  查询对象不使用
		function convertUIValue(value, record, rowNum, colNum,grid){
	     return;
		}
		
    
     //当窗口执行关闭时执行此操作
	 function onDialog0Close(data,oType){
	  if(data!=null){
		   var data = isc.JSON.decode(data);
		   //将数据写入到当前行
		   var dialog = Matrix.getMatrixComponentById("Dialog0");
		   var dataGrid =  Matrix.getMatrixComponentById("DataGrid0");
		   //将值追加到编辑的record中
		   var fullName = data.proEntityType;
			   
		   var index1 = fullName.lastIndexOf('.');
		   var  proShortName = fullName.substring(index1+1,fullName.length);
		   var record = dataGrid.getRecord(dialog.rowNum);
		   record.proEntityName = proShortName;
		   
		   
		   
		   dataGrid.setEditValue (dialog.rowNum, dataGrid.getFieldNum('proEntityUuid'), data.proEntityType);
	   
	   }
		return true;
	}
	
	function  onDialog2Close(data,oType){
		return true;
	}
	
	// 定义选择关联实体组件
	function getSelectEntityComponent(listGrid,record,colNum){
	 	 var rowNum = listGrid.getRecordIndex(record);
	 	  var phase =record.phase;
		 var recordCanvas = isc.HLayout.create({
                height: '100%',
                ID:"MSelectEntityCom_"+rowNum,
	    		isModal: true,
	   			showModalMask: true,
                width:"100%",
                verticalAlign:"center",
                align: "right"
            });
            var editImg = isc.ImgButton.create({
                showDown: false,
                showRollOver: false,
                layoutAlign: "right",
                src:Matrix.getActionIcon("edit"),
                prompt: "选择关联实体",
                height: 16,
                width: 16,
                grid: this,
                click:function (){
                	if(2==phase){//ZR设计开发阶段不可修改
                		return false;
                	}
					MDialog0.rowNum = rowNum;
					MDialog0.colNum = colNum;
					MDialog0.listGrid = listGrid;
					MDialog0.record = record;
                   // MDialog0.show();
                   Matrix.showWindow("Dialog0");
                }
            });
            recordCanvas.addMember(editImg);  
            return recordCanvas;  
        }
        
        
       function onDialog1Close(data, oType){
        	if(data!=null){
        		var dataArray = isc.JSON.decode(data);
        		//发送异步请求 删除属性信息
        		var entityUuid = document.getElementById('entityUuid').value;
        		var url = "<%=request.getContextPath()%>/entity/entityProperty_deleteAllProperties.action?entityUuid="+entityUuid;
        		dataSend(null,url,"POST",function(data){
        		    if(data.data =="true"){
        		        MDataGrid0.removeData(MDataGrid0.getData());
        		        MDataGrid0.insertItems = dataArray;
	        			MDataGrid0.setData(dataArray);
        		    }
        		
        		},null);
        		//在回调函数中更新表单数据
        	}
        	return true;
        
        }
	</script>
</head>
<body onload="initGridList()">
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"<%=request.getContextPath()%>/entity/entityProperty_getProperties.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="<%=request.getContextPath()%>/entity/entityProperty_getProperties.action" style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<!-- 实体类型 entity[1] or query Obj [2]  basic[3]-->
<input type="hidden" id="entityType" name="entityType" value="${entityPro.entityType}">
<input type="hidden" id="entityUuid" name="entityUuid" value="${entityPro.entityUuid}">
<input type="hidden" id="entity" name="entity" value="${param.entity}">

<!-- commom cols -->
<input type="hidden" id="phase" name="phase" value="${entityPro.phase}">
<input type="hidden" id="createdUser" name="createdUser" value="${entityPro.createdUser}">
<input type="hidden" id="publishedUser" name="publishedUser" value="${entityPro.publishedUser}">
<input type="hidden" id="mid0" name="mid0" value="${entityPro.mid }">
<input type="hidden" id="gridListName" name="gridListName" />
<input type="hidden" id="actionType" name="actionType"/>
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="dataTable" jsId="dataTable" cellpadding="0px" cellspacing="0px" style="width:100%;height:100%;">
		<tr id="j_id2" jsId="j_id2">
				
				<td id="j_id4" jsId="j_id4" class="query_form_toolbar"  rowspan="1" style="border-style:none;">
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
					 	
					 	var data ={"entityUuid":"","isCol":true,"isKey":false,"isRequired":false,"isSystemCol":false,"phase":0,"type":-1};
					 	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
					 	dataGrid.getData().add(data);
					 	dataGrid.startEditing(dataGrid.getData().length-1);
					 	 //解决插入数据mid 和name初始值不验证的问题
					 	dataGrid.setEditValue (dataGrid.getEditRow(), dataGrid.getFieldNum('mid'), null);
					 	dataGrid.setEditValue (dataGrid.getEditRow(), dataGrid.getFieldNum('name'), null);
					 	dataGrid.setEditValue (dataGrid.getEditRow(), dataGrid.getFieldNum('type'), 1);
					 	
					 	Matrix.hideMask();
					 	return false;
					 	
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
			         	
			         	//验证是否含有设计开发阶段数据
				     	if(!validatePhase()){
				         	 Matrix.hideMask();
					   		 return false;
				     	}
			         	
			         	deleteDataGridData('MDataGrid0',true);
			         	Matrix.hideMask();
			         	return false;
			         	
			         }
			     </script>
			     <script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem6",
						icon:Matrix.getActionIcon("save"),
			     		prompt: "保存",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     	});
			     	MToolBarItem6.click=function(){
			     		Matrix.showMask();
			     		
					if(!MForm0.validate()){
						Matrix.hideMask();
				   		 return false;
					}
					
			     	//验证主键
			     	//if(!keyValidator()){
			         	// Matrix.hideMask();
				   		// return false;
			     //	}
					document.getElementById('Form0').action='<%=request.getContextPath()%>/entity/entityProperty_saveProperties.action';
			     	convertEditDataGridData('MDataGrid0',true);
			     	Matrix.hideMask();
			     	return;
			     }
			    </script>
			    <script>
			    var copyData;
			    isc.ToolStripButton.create({
			    	ID:"MToolBarItem13",
			    	icon:Matrix.getActionIcon("copy"),
			    	prompt: "复制",
			    	showDisabledIcon:false,
			    	showDownIcon:false
			     });
			     MToolBarItem13.click=function(){
			     	Matrix.showMask();
			     	
			     	copyData = copyPropertyList();
			     	
			     	Matrix.hideMask();
			     }
			  </script>
			   <script>
			   
			    isc.ToolStripButton.create({
			    	ID:"MToolBarItem131",
			    	icon:Matrix.getActionIcon("cut"),
			    	prompt: "剪切",
			    	showDisabledIcon:false,
			    	showDownIcon:false
			     });
			     MToolBarItem131.click=function(){
			     	Matrix.showMask();
			     	if(!MForm0.validate()){
			     		Matrix.hideMask();
			     		return false;
			     	}
			     	
			     	//验证是否含有设计开发阶段数据
				     	if(!validatePhase()){
				         	 Matrix.hideMask();
					   		 return false;
				     	}
				     	
			     	cutPropertyList();
			    
			     	Matrix.hideMask();
			     }
			  </script>
			  
			  
			  
			  <script>
			 		 isc.ToolStripButton.create({
					 		 ID:"MToolBarItem14",
					 		 icon:Matrix.getActionIcon("paste"),
					 		 prompt: "粘贴",
					 		 showDisabledIcon:false,
					 		 showDownIcon:false 
			 		});
			 		MToolBarItem14.click=function(){
					 			Matrix.showMask();
					 			if(!MForm0.validate()){
					 				Matrix.hideMask();
					 				return false;
					 			}
					 			pastePropertyList();
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
				 			var x = eval("onMoveUpRecord();");
				 			if(x!=null && x==false){
					 			Matrix.hideMask();
					 			return false;
				 			}if(!MForm0.validate()){
					 			Matrix.hideMask();
					 			return false;
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
				 		    	var x = eval("onMoveDownRecord();");
				 		    	if(x!=null && x==false){
				 		    		Matrix.hideMask();
				 		    		return false;
				 		    	}if(!false){
				 		    		Matrix.hideMask();
				 		    		return false;
				 		    	}if(!MForm0.validate()){
				 		    		Matrix.hideMask();
				 		    		return false;
				 		    	}
				 		    	
				 		    	Matrix.convertFormItemValue('Form0');
				 		    	//document.getElementById('Form0').submit();
				 		    	Matrix.hideMask();
			 		    }</script>
			 		    <script>
			 		    	isc.ToolStripButton.create({
				 		    	ID:"MToolBarItem9",
				 		    	icon:Matrix.getActionIcon("import_hd"),
				 		    	prompt: "导入",
				 		    	showDisabledIcon:false,
				 		    	showDownIcon:false 
			 		    	});
			 		    	MToolBarItem9.click=function(){
					 		    	Matrix.showMask();
					 		    	if(!MForm0.validate()){
						 		    	Matrix.hideMask();
						 		    	return false;
					 		    	}
//					 		    	MDialog1.initSrc="<%=request.getContextPath()%>/entity/entityProperty_loadUploadEntityXmlPage.action"
									var entity = document.getElementById('entity').value;
					 		    	MDialog1.initSrc="<%=request.getContextPath()%>/entity/entityProperty_loadUploadEntityXmlPage.action?entity="+entity;
					 		    	//传入entityUuid将当前实体属性删除  
					 		    	Matrix.showWindow('Dialog1');
					 		    	
					 		    	Matrix.hideMask();
			 		    	}</script>
			 		    	<script>
			 		    		isc.ToolStripButton.create({
			 		    		ID:"MToolBarItem10",
			 		    		icon:Matrix.getActionIcon("save_hd"),
			 		    		prompt: "导出",
			 		    		showDisabledIcon:false,
			 		    		showDownIcon:false 
			 		    		});
			 		    		MToolBarItem10.click=function(){
			 		    		Matrix.showMask();
			 		    		if(!MForm0.validate()){
				 		    		Matrix.hideMask();
				 		    		return false;
			 		    		}
			 		    		
			 		    		exportPropertyToFile();
			 		    		Matrix.hideMask();
			 		    		}</script>
			 		    		
			 		    		
			 		    		<script>
			 		    		 isc.ToolStripButton.create({
				 		    		 ID:"MToolBarItem15",
				 		    		 icon:Matrix.getActionIcon("sync_model"),
				 		    		 prompt: "同步HB模型",
				 		    		 showDisabledIcon:false,
				 		    		 showDownIcon:false,
				 		    		 autoDraw:false
			 		    		  });
			 		    		  MToolBarItem15.click=function(){
			 		    		  	Matrix.showMask();
			 		    		 
				 		    		  if(!MForm0.validate()){
					 		    		  Matrix.hideMask();
					 		    		  return false;
				 		    		  }
			 		    		  	//仅同步hibernate模型
			 		    		 	synPropsContent(false);
			 		    		 	Matrix.hideMask();
			 		    		   }</script>
			 		    		
			 		    		 
			 		    		   	<div id="j_id5_div"  style="width:100%;overflow:hidden;"  >
			 		    		   	<script>
			 		    		   	isc.ToolStrip.create({
			 		    		   		ID:"Mj_id5",
			 		    		   		displayId:"j_id5_div",
			 		    		   		width: "100%",
			 		    		   		//height: "*",
			 		    		   		position: "relative",members: [ 
			 		    		   				MToolBarItem3,
			 		    		   				MToolBarItem5,
			 		    		   				MToolBarItem6,
			 		    		   				"separator",
			 		    		   				MToolBarItem13,
			 		    		   				MToolBarItem131,
			 		    		   				MToolBarItem14,
			 		    		   				MToolBarItem7,
			 		    		   				MToolBarItem8,
			 		    		   				"separator",
			 		    		   				MToolBarItem9,
			 		    		   				MToolBarItem10
			 		    		   				
			 		    		   				
			 		    		   		 ] 
			 		    		   });
			 		    		   
								    
								    if("<%=curPhase%>"==4){//业务定制阶段
			 		    		   		  var deleteMemberArray = [MToolBarItem9,MToolBarItem10];
			 		    		   		  var seMember = Mj_id5.getMember(9);
			 		    		   		  deleteMemberArray.push(seMember)
			 		    		   		  Mj_id5.removeMembers (deleteMemberArray);
			 		    		   		  
			 		    		   	 }
			 		    		   
			 		    		   isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
			 		    		   		</script>
			 		    		   		</div>
			 		  </td>
					
		</tr>
		<tr id="j_id7" jsId="j_id7">
			
				<td id="j_id9" jsId="j_id9"  rowspan="1" style="border-style:none;width:100%;height:100%">
					<div id="DataGrid0_div" class="matrixComponentDiv" style="width:100%;height:100%;">
					<script>
	 	
			var displayValueMap = {'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'业务对象'};			 	
			isc.MatrixListGrid.create({
					ID:"MDataGrid0",
					name:"DataGrid0",
					canSort:false,
					width:"100%",
					height:"100%",
					displayId:"DataGrid0_div",
					position:"relative",
					canHover:true,
					
					fields:[{//行号
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
					   },
					  {
						  	title:"编码",
						  	matrixCellId:"j_id11",
						  	name:"mid",
						  	canEdit:true,
						  	editorType:'Text',
						  	canHide:true,
						  	required:true,
						  	type:'text',
						  	showHover:false,
						  	validators:[{
				      		    type:"custom",
				      		    condition:function(item, validator, value, record){
				      		        var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
				      		        return  propertyIdValidate(item, validator, value, record,dataGrid);
				      		     },
				      		     errorMessage:"编码不能为空!"
				      		 }]
					  },{
						  	title:"名称",
						  	matrixCellId:"j_id12",
						  	name:"name",
						  	canEdit:true,
						  	editorType:'Text',
						  	canHide:true,
						  	type:'text',
						  	required:true,
						  	showHover:false,
						  	validators:[{
				      		    type:"custom",
				      		    condition:function(item, validator, value, record){
				      		        var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
				      		        return  propertyNameValidate(item, validator, value, record,dataGrid);
				      		     },
				      		     errorMessage:"名称不能为空!"
				      		 }]
						  	
					  },
					  
					  {
						  title:"字段",
						  matrixCellId:"j_id13",
						  name:"colName",
						  canEdit:true,
						  editorType:'Text',
						  type:'text',
						  canHide:true,
						  showHover:false,
						  validators:[{
				      		    type:"custom",
				      		    condition:function(item, validator, value, record){
				      		       
				      		        return  columnNameValidate(item, validator, value, record, MDataGrid0);
				      		     },
				      		     errorMessage:"字段名称不能为空!"
				      		 }]
					  },{
					  		title:"类型",
					  		matrixCellId:"j_id14",
					  		name:"type",
					  		canEdit:true,
					  		editorType:'select',
					  		type:'integer',
					  		showHover:false,
					  		valueMap:['1','2','3','4','5','6','7','8','9','14','13'],
					  		autoFetchDisplayMap:true,
					  		editorProperties:{
					  			displayValueMap: displayValueMap
					  		},
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			if(value==null){
					  				return "";
					  			}
					  			return displayValueMap[value];
					  		},
					  		changed: function(form, item, value){
						  		var grid = form.grid;
								var record = grid.getRecord(grid.getEditRow());
								record.isCol=true;//查询对象 非关联类型isCol默认为true
						  	
					  		 	 //设置关联对象
					  		 	 if(value!=null&&(value==13||value==14)){
					  		 	     
						  		 	 	// 判断选择结果是否为关联实体类型
						  		 	 	if(value==13){
						  		 	 		record.isCol=false;
								    		record.showSelectEntityComponent = true;
								    	}
								    	
					  		 	 }else{
					  		    	 grid.setEditValue (grid.getEditRow(), grid.getFieldNum('proEntityUuid'), null);
							    	 record.showSelectEntityComponent = false;
					  		 	 
					  		 	 }
					  		 	 grid.refreshFields();
					  		 	 grid.updateRecordComponents();
					  			// return;
					  		}
					  		
					  },{
					  		title:"关联对象",
					  		matrixCellId:"j_id558",
					  		name:"proEntityUuid",
					  		canEdit:false,
					  		width:'15%',
					  		editorType:'Text',
					  		type:'text',
					  		showHover:true,
					  		hoverHTML:function(record, value, rowNum, colNum, grid){
					  			var showValue = grid.getEditValue(rowNum, colNum);
					  			
					  			if(showValue==null||showValue.length==0){
					  				showValue = record.proEntityUuid;
					  			}
					  			return showValue;
					  		
					  		},
					  		
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  		
					  		    return record.proEntityName;
					  			//return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					  		},
					  		customComponentFunction:"getSelectEntityComponent",
					  		editorProperties:{
									isDisabled:function isc_FormItem_isDisabled(){
										var _2=this.form;_3=_2.grid;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _5 = "type";
												var _6 = _3.fields.findIndex(_3.fieldIdProperty,_5);
												var _formItem = _3.getEditFormItem(_5);
												var _7 =_formItem.getValue();
												
											
												if(_7 &&_7!=13){//不为关联对象时不可用
												     
													return true;
				  			 						
										  		}
										  	}
										}
										var _1=this.disabled;
										if(!_1){
											if(this.parentItem!=null)
												_1=this.parentItem.isDisabled();
											else{
												_1=this.form.isDisabled();
												if(!_1&&this.containerWidget!=this.form)
												_1=this.containerWidget.isDisabled()
											}
										}
										return _1
									}
								}
					  }
					
			  ],
			  //设置UI组件和扩展组件关联关系
			  
			  autoSaveEdits:false,
			  autoFetchData:true,
			  alternateRecordStyles:true,
			  showDefaultContextMenu:false,
			  canAutoFitFields:false,
			  startLineNumber:1,
			  canEdit:true,
			  selectionType: "multiple",
              canDragSelect: true,
              editEvent: "click",
			  showRecordComponents:true,
			  showRecordComponentsByCell:true,
			  canEditCell:function(rowNum, colNum){
			       var record = this.getRecord(rowNum);
	                fieldName = this.getFieldName(colNum);
			  		if(record!=null){
			  		    
			  		    var phase = record.phase;
			  		    if("2" == phase){//设计开发
			  		    	return false;
			  		    }
			  	
			  		}
			  		
                   return this.Super("canEditCell", arguments);//默认处理
			  },
			  rowClick:function(record, recordNum, fieldNum){
			  
			      //先取编辑值
			      var type= MDataGrid0.getEditedRecord (recordNum).type;//获取编辑值如果编辑过
			         if(type==null){
			         	type = record.type;
			         }
			         
			      return this.Super("rowClick", arguments);
			  } 
			});
			
			if(${param.entityType eq 3}){//基本对象
				MDataGrid0.hideField ('colName');
			}
			
			isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
			isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			
			  // 重写表格方法
		MDataGrid0.addProperties({
		showRecordComponent:function(record,colNum){
			var fieldName = this.getFieldName(colNum);
			if(fieldName=="proEntityUuid"){
			 // 判断列是否为关联实体显示列			
				if(record.showSelectEntityComponent!=null){
					return record.showSelectEntityComponent;
				}
     	        var rowNum = this.getRecordIndex(record);
     	        var cellValue = record["type"];//取到类型列值
				var editValue = this.getEditValue(rowNum, this.getFieldNum('type'));
				if(editValue!=null){
					cellValue = editValue;
				}
				if(cellValue!=13){
					// 判断类型结果是否为关联实体类型
					return false;
				}
			}
			return true;
		}

});

	//设置数据
		MDataGrid0.setData(${requestScope.propertyListJson});
     
		</script>
	</div>
	<input id="matrix_AttributeManager_dataGrid_DataGrid0" 
			name="matrix_AttributeManager_dataGrid_DataGrid0" type="hidden" value="DataGrid0" />
	<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
	
	
	<input id="m_has_edit_datagrid" name="m_has_edit_datagrid" type="hidden" value="true" />
	<input id="DataGrid0_selections" name="DataGrid0_selections" type="hidden" />
	<input id="MDataGrid0_data_entity_namespace" name="MDataGrid0_data_entity_namespace" value="http://console/catalog/catalogdata" type="hidden" />
	<input id="MDataGrid0_data_entity_localpart" name="MDataGrid0_data_entity_localpart" value="EntityAttribute" type="hidden" />
	</td>
</tr>
</table>
<input id="entityId" type="hidden" name="entityId" value="sean" />
<!-- 需要动态赋值 -->
</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>

	<script>
     //获取选中行数据的id值
     function getEditAttributeId(){
     	 var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		  if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				warnMsg("没有数据被选中，不能执行此操作。",{ width:150,height:70});
				return null;
			}
			return dataGrid.getSelection()[0].id;
		}
		return null;
     }
     
	
	//保存数据
	function saveData(dataGridId,actionId,msg){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		warnMsg("非法数据表格。");
		return false;
	}
	
	if(_curGrid.canEdit && _curGrid.hasChanges()){
		// 保存表格编辑数据
		if(!Matrix.saveDataGridData(dataGridId)){
			warnMsg("表格包含非法数据。");
			return false;
		};
	}
	
	// 修改数据,
	var items = _curGrid.getData();
	
	if(items.length==0){
		warnMsg("没有数据被修改，不能执行此操作。");
		return false;
	}	
	
	if(msg){
		if(!window.confirm(msg)){
			return false;
		}
	}
	
	//选中对象的JSON字符串表示
	var result = Matrix.itemsToJson(items);
	
	//要找的表单元素
	var n2=Matrix.getParentForm(_curGrid.displayId);
	
	if(n2!=null &&n2.nodeType==1&&n2.tagName.toUpperCase()=="FORM"){
		var data = {};
		//data["Matrix_entityId"] = document.gentElementById("entityId").value;
		data["Matrix_entityId"] = document.gentElementById("entityId").value;
		data[Matrix.escapeId(dataGridId)+"_"+Matrix.escapeId(actionId)+Matrix.GRID_EVENT_TYPE_SUFFIX]=Matrix.GRID_EVENT_TYPE_SELECT;	
			data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_SELECT_OBJECT]=result;
		Matrix.send(n2,data,callback);
		// 清空表格记录修改数据
		_curGrid.insertItems = []; 
		_curGrid.updateItems = []; 
		_curGrid.deleteItems = []; 
		
		//warnMsg(msg);
	 }
	 return false;
  };
	function callback(){
		warnMsg("添加成功！");
	
	}
	
	// 选择关联实体弹出窗口

	function getParamsForDialog0(){
	var params='iframewindowid=Dialog0';
	var value;
	return params;
	}
	isc.Window.create({
		ID:"MDialog0",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "400",
		title: "设置关联对象",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		],
		getParamsFun:getParamsForDialog0,
		initSrc:webContextPath+"/common/common_loadCommonTreePage.action?componentType=16",
		src:webContextPath+"/common/common_loadCommonTreePage.action?componentType=16"
	 });
	MDialog0.hide();
	
	
	// 导入属性配置文件

	function getParamsForDialog1(){
	var params='iframewindowid=Dialog1';
	var value;
	return params;
	}
	isc.Window.create({
		ID:"MDialog1",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "400",
		title: "导入实体属性",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		],
		getParamsFun:getParamsForDialog1
	 });
	MDialog1.hide();
	
	</script>
	</script>

	</div>
	<script type="text/javascript">
 /******** property  id validate begin*********/
 function propertyIdValidate(item, validator, value, record, dataGrid){
	//空的话返回false
	if(value==null||value.length==0){
	  validator.errorMessage="编码不能为空!";
	  return false;
	}
	 var hasInput = Matrix.validateLength(1,40,value);
	
	 if(hasInput){
		 var isMatch = value.match(/^[a-z][\w]*$/);
		
		 if(isMatch!=null){
		      var recordData = dataGrid.getData();
		      var j = 0;
			
		    if(recordData!=null&&recordData.length>0){
			     for(var i=0,len=recordData.length;i<len;i++){
			          var editValue= dataGrid.getEditValue(i, item.name);//获取编辑值如果编辑过
			         if(editValue==null){
			         	editValue = recordData[i].mid;
			         }
			         
			         if(value==editValue){
			            j++;
			         	
			         }
				   }
				   
				    if(j>1){
				      validator.errorMessage="编码重复，请重新输入";
				      j = 0;
				      return false;
				   }
			  	 
		     } 
			 return true;
		  }
		  
	    //分类返回错误消息
		   var exceptMsg = value.match(/^[a-zA-Z\d_]+$/);//
		 	if(exceptMsg==null){//含有非法字符
			 	validator.errorMessage="只能使用字母字母数字下划线命名";
		   		return false;
		 	}
		  //2.以下划线 数字开头[第一位]
		  var validateMsg1 = value.match(/^[^a-zA-Z][a-zA-Z\d_]+$/);
		  if(validateMsg1!=null){
		  	validator.errorMessage="必须以字母开头";
	   		return false;
		  }   
		   
	   validator.errorMessage="只能使用字母、数字和下划线命名，且以字母开头";
	   return false;
	 }
    validator.errorMessage="编码不能为空!";
	return hasInput;
 }
 /******** component id validate end*********/
 
 /******** property  name validate begin*********/
 function propertyNameValidate(item, validator, value, record,dataGrid){
	//空的话返回false
	if(value==null||value.length==0){
	  validator.errorMessage="名称不能为空!";
	  return false;
	}
	 var hasInput = Matrix.validateLength(1,40, value);
	
	 if(hasInput){
		 var isMatch = value.match(/^[\w\u4e00-\u9fa5]+$/);
		 if(isMatch!=null){
		     var recordData = dataGrid.getData();
		     var j = 0;
		     
		    if(recordData!=null&&recordData.length>0){
			     for(var i=0,len=recordData.length;i<len;i++){
			        
			         var editValue= dataGrid.getEditValue(i, item.name);//获取编辑值如果编辑过
			         if(editValue==null){
			         	editValue = recordData[i].name;
			         }
			         
			         if(value==editValue){
			            j++;
			         }
				   }
				   if(j>1){
				      validator.errorMessage="名称重复，请重新输入";
				      j = 0;
				      return false;
				   }
		     } 
			 return true;
		  }
		validator.errorMessage="不能使用字母汉字下划线以外的非法字符!";
	   return false;
	 }
    validator.errorMessage="名称不能为空!";
	return hasInput;
 }
 /******** component  name validate end*********/

 var ratio = detectZoom(); 
 debugger;
 if(ratio != 100){setTimeout(reInitGridScroll,100);}
	</script>

</body>
</html>