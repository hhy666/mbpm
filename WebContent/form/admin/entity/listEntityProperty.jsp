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
<title>实体属性维护</title>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/html5/js/jquery.min.js"></script>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></SCRIPT>

<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<style>
touch-action: none;
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
	                warnMg('研发阶段数据不可删除!');
	                return false;
	            }
	
	        }
	
	    }
	    return true;
	}



/******** upmove data  begin*********/
  //上移操作	
	function onMoveUpRecord(gridName){
			if(gridName==null||gridName.length==0){
			gridName = "DataGrid0";
		}
		var dataGrid = Matrix.getMatrixComponentById(gridName);
		
		if(dataGrid){
			if(!dataGrid.canEdit){
				warnMg("表格不可编辑。");
				return;
			}
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				warnMg("没有数据被选中，不能执行此操作。");
				return null;
			}
			
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			
			var recordIndex = recordData.indexOf(selectedRecord);
			//curEditedPart
			var editedObj = dataGrid.$300(recordIndex);//行编辑过的部分
			//var newObj = isc.addProperties(selectedRecord, editedObj);
			var editedObjCopy ={};
			if(editedObj!=null){
				for(var pro in editedObj){
					editedObjCopy[pro] = editedObj[pro];
				}
			
			}
		
			if(recordIndex>0){
			    recordIndex--;
			    //获取上条数据记录
			    var preRecord = recordData.get(recordIndex);
			 
			    var editedPreObj = dataGrid.$300(recordIndex);//上条记录编辑过的部分
			    
			    var editedPreObjCopy ={};
			    if(editedPreObj!=null){
					for(var pro in editedPreObj){
						editedPreObjCopy[pro] = editedPreObj[pro];
					}
			    
			    }
			    
			    //交换数据中未编辑部分
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex+1,preRecord);
			    //交换行记录中编辑的部分
			    dataGrid.setEditValues (recordIndex, editedObjCopy);
			    dataGrid.setEditValues (recordIndex+1, editedPreObjCopy);
			    dataGrid.isMove = true;
			   
			}
		}
	}
  
  
  /******** upmove grid list data  end*********/


		//添加属性记录
		function addpropertyRecord(){
			
			var data ={"mid":"","name":"","entityUuid":"","isCol":true,"isKey":false,"isRequired":false,"isSystemCol":false,"phase":0,"type":-1,"uiType":1};
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0"); 
			dataGrid.getData().add(data);
			dataGrid.startEditing(dataGrid.getData().length-1);
			//解决插入数据mid 和name初始值不验证的问题
			dataGrid.setEditValue (dataGrid.getEditRow(), dataGrid.getFieldNum('mid'), null);
			dataGrid.setEditValue (dataGrid.getEditRow(), dataGrid.getFieldNum('name'), null);
			dataGrid.setEditValue (dataGrid.getEditRow(), dataGrid.getFieldNum('type'), 1);
			if("<%=curPhase%>"!="4"){//业务定制阶段
				dataGrid.setEditValue (dataGrid.getEditRow(), dataGrid.getFieldNum('colName'), null);
					 	 
			}
		
		}




		//var uiTypeValue= null;//记录uiTypeValue

		//导出属性到文件 entityUuid entityType  mid
		function exportPropertyToFile(){
		    var entityMid = parent.document.getElementById("mid").value;
		    var entityType = "entityObject";
			var entityUuid = document.getElementById("entityUuid").value;
			var url = "<%=request.getContextPath()%>/file/exportfile?exportType=entity&entityUuid="+entityUuid+"&mid="+entityMid+"&entityType=entityObject";
			window.location.href = url;
		}
		
		

		//选中主键时：同时选中实体和必填字段
		function checkedKey(form){
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			var record = dataGrid.getSelectedRecord();
			var selectRowNum = dataGrid.getRecordIndex (record);
			
			dataGrid.setEditValue (selectRowNum, dataGrid.getFieldNum('isCol'), true);
			dataGrid.setEditValue (selectRowNum, dataGrid.getFieldNum('isRequired'), true);
			dataGrid.refreshFields();
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
				    warnMg('数据未保存，不能执行此操作！');
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
		 
		
		//主键验证：
		//至少有一字段为主键,主键必须为实体字段和必填
		function keyValidator() {
		  	
		  	var curPhase = "<%=curPhase%>";
		  	if(curPhase=="4"){//业务定制阶段在js端不验证主键
		  		return true;
		  	}
		  
		    var isEntityCol = true;
		    var  isRequiredMsg = true; 
		    
		    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		    var count = 0;
		    var data = dataGrid.getData();
		    var dataLength = data.length;
		    if (data != null && dataLength > 0){
		        var record = null;
		        var isKey = null;
		        var isCol = null;
		        var isRequired = null;
		        for (var i = 0; i < dataLength; i++) {
		
		            isKey = dataGrid.getEditValue(i, "isKey"); //获取编辑值如果编辑过
		            if (isKey == null) {
		                isKey = data[i].isKey;
		            }
		            
		            if (isKey == true) {
		                count++;
		                //判断主键是否为实体字段
		                isCol = dataGrid.getEditValue(i, "isCol"); //获取编辑值如果编辑过
		                if (isCol == null) {
		                    isCol = data[i].isCol;
		                }
		                
		                if (!isCol){
		                    isEntityCol = false;
		                    break;
		                }
		                
		                //判断主键是否为必填 isRequired 
		                isRequired = dataGrid.getEditValue(i, "isRequired"); //获取编辑值如果编辑过
		                if (isRequired == null) {
		                    isRequired = data[i].isRequired;
		                   
		                }
		                
		                 if (!isRequired){
		                   isRequiredMsg = false;
		                    break;
		                }
		            }
		        }
		
		        if (count > 0) {
		            if (!isEntityCol) {
		                warnMg("主键必须为实体字段!");
		                return false;
		            }
		            
		            if(!isRequiredMsg){
		           	    warnMg("主键必须为必填字段!");
		                return false;
		            }
		            count = 0;
		            return true;
		        } else {
		            warnMg("至少有一个字段为主键!");
		            return false;
		        }
		    } else { //属性为空不验证
		        return true;
		    }
		
		}
		  //var copyData;//保存复制和剪切的数据
		 
          //复制数据
          function  copyPropertyList(){
             var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
             if(dataGrid){
               	// var data = "[]";
		 	    if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
			    	warnMg("没有数据被选中，不能执行此操作。");
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
			    	warnMg("没有数据被选中，不能执行此操作。");
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
			}
			return true;		 	
		}
		
		  //初始化数据表格数据
		  function initGridList(){
		     document.getElementById("gridListId").value = "MDataGrid0";
		   	 document.getElementById("entityUuid").value = "${param.entityUuid}"; //需要根据链接动态赋值
		     Matrix.send("Form0");
		     return false;
		  }


	//获取组件图标
	function getComponentIconByType(type){
	      var strType = null;
	     if(type=='1'){
	        strType = 'input';//文本框
	     }else if(type=='2'){
	       strType = 'inputDate';
	     }else if(type=='3'){
	       strType = 'inputTime';
	     }	else if(type=='4'){
	       strType = 'numberSpinner';
	     }	else if(type=='5'){
	       strType = 'comboBox';//下拉框
	     }	else if(type=='6'){
	       strType = 'radio';//单选按钮
	     }	else if(type=='7'){
	       strType = 'checkBox';//复选框
	     }	else if(type=='8'){
	       strType = 'radioGroup';//单选按钮组
	     }	else if(type=='9'){
	       strType = 'checkBoxGroup';//复选按钮组
	     }	else if(type=='10'){
	       strType = 'inputTextArea';//文本域
	     }	else if(type=='11'){
	       strType = 'listBox';//列表框
	     }	else if(type=='12'){
	       strType = 'fileUpload';//附件上传
	     }	else if(type=='13'){
	       strType = 'password';//密码框
	     }	else if(type=='14'){
	       strType = 'richText';//富文本框
	     }	else if(type=='15'){
	       strType = 'image';//图片
	     }	else if(type=='18'){
	       strType = 'label';//标签
	     }	else if(type=='19'){
	       strType = 'link';//链接
	     }	else if(type=='20'){
	       strType = 'inputHidden';//隐藏域    
	     }	else if(type=='21'){
	       strType = 'popupSelectDialog';//弹出选择
	     }else if(type=='22'){
	       strType = 'multiFilteringSelect';//多选下拉框
	     }else if(type=='23'){
	     	strType = 'userSelect';//单选人员
	     }else if(type=='24'){
	     	strType = 'usersSelect';//多选人员
	     }else if(type=='25'){
	     	strType = 'depSelect';//单选部门
	     }else if(type=='26'){
	     	strType = 'depsSelect';//多选部门
	     }else if(type=='27'){
	     	strType = 'singleFile';//单文件上传
	     }else if(type=='28'){
	     	strType = 'mutiFile';//多文件上传
	     }else if(type=='29'){
	     	strType = 'flowComment';//流程意见
	     }else if(type=='30'){
	     	strType = 'bigTextArea';//大文本域
	     }
	 	 return  Matrix.getComponentIcon(strType);
      }
      
      
     function getComponentTextByType(type){
       var curPhase = "<%=curPhase%>";
       
       var strType = null;
	     if(type=='1'){
	        strType = '文本框';//
	     }else if(type=='2'){
	       strType = '日期框';
	     }else if(type=='3'){
	       strType = '时间框';
	     }	else if(type=='4'){
	       strType = '数字框';
	     }	else if(type=='5'){
	       strType = '下拉框';//下拉框
	     }	else if(type=='6'){
	       strType = '单选按钮';//单选按钮
	     }	else if(type=='7'){
	       strType = '复选框';//复选框
	     }	else if(type=='8'){
	       strType = '单选按钮组';//
	     }	else if(type=='9'){
	       strType = '复选按钮组';//
	     }	else if(type=='10'){
	       strType = '文本域';//文本域
	     }	else if(type=='11'){
	       strType = '列表框';//列表框
	     }	else if(type=='12'){
	       strType = '单文件上传';//附件上传
	       if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }	else if(type=='13'){
	       strType = '密码框';//密码框
	     }	else if(type=='14'){
	       strType = '富文本框';//富文本框
	     }	else if(type=='15'){
	       strType = '图片';//图片
	     }	else if(type=='18'){
	       strType = '标签';//标签
	     }	else if(type=='19'){
	       strType = '链接';//链接
	     }	else if(type=='20'){
	       strType = '隐藏域';//隐藏域  先用input  
	     }	else if(type=='21'){
	       strType = '弹出选择';//弹出选择
	     }else if(type=='22'){
	       strType = '多选下拉框';//多选下拉框
	     }else if(type=='23'){
	     	strType = '单选人员';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }else if(type=='24'){
	     	strType = '多选人员';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }else if(type=='25'){
	     	strType = '单选部门';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }else if(type=='26'){
	     	strType = '多选部门';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }else if(type=='27'){
	     	strType = '单文件上传';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }else if(type=='28'){
	     	strType = '多文件上传';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }else if(type=='29'){
	     	strType = '流程意见';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }else if(type=='30'){
	     	strType = '大文本域';
	     	if(curPhase != '4'){
	       		strType+="定制";
	       }
	     }
	 	 return strType;
      
      }
		//UI组件显示对应的图片
		function convertUIValue(value, record, rowNum, colNum,grid){

			var titleStr = "";
			titleStr+="<TABLE cellSpacing=0 cellPadding=0><TBODY><TR>";
			titleStr+="<TD vAlign=middle noWrap align=center style='BORDER: 0px;BORDER-LEFT: 0px;PADDING: 0px;MARGIN: 0px;box-shadow: none; -webkit-box-shadow: none'>";
			titleStr += "<img style='VERTICAL-ALIGN: middle' align=absMiddle width=16 height=16 src='";
			titleStr += getComponentIconByType(value);
			titleStr += "'/>&nbsp;";
			titleStr += "</TD>";
			titleStr+="<TD vAlign=middle noWrap align=center style='BORDER: 0px;BORDER-LEFT: 0px;PADDING: 0px;MARGIN: 0px;box-shadow: none; -webkit-box-shadow: none'>";
			titleStr +=  getComponentTextByType(value);
		
			titleStr += "</TD>";
			titleStr+="</TR></TBODY></TABLE>";
		   
		return "<div align='left'>"+titleStr+"</div>"; 
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
		   
		   dataGrid.setEditValue(dialog.rowNum, dataGrid.getFieldNum('proEntityUuid'), data.proEntityType);
		   
	   }
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
                src: Matrix.getActionIcon("edit"),
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
        
        //载入
        function loadTableColumns(){
        	var tableName = parent.document.getElementById("tableName").value;
        	var dsName = parent.document.getElementById("dsName").value;
        	var url = "<%=request.getContextPath()%>/entity/importEntity_loadTableColumns.action?dsName="+dsName+"&tableName="+tableName;
        	MLoadColumnDialog.initSrc = url;
        	Matrix.showWindow("LoadColumnDialog");
        	
        }
        
        //载入关闭时触发
        function onLoadColumnDialogClose(data, oType){
        	if(data!=null){
        		MDataGrid0.getData().addAll(data);
        	}
        	return true;
        }
	</script>
</head>
<body onload="initGridList()" >
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
				enctype="application/-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<!-- 实体类型 entity[1] or query Obj [2]  -->
<input type="hidden" id="entityType" name="entityType" value="${entityPro.entityType}">
<input type="hidden" id="entityUuid" name="entityUuid" value="${entityPro.entityUuid}">
<input type="hidden" id="entity" name="entity" value="${param.entity}">

<!-- commom cols -->
<input type="hidden" id="phase" name="phase" value="${entityPro.phase}">
<input type="hidden" id="createdUser" name="createdUser" value="${entityPro.createdUser}">
<input type="hidden" id="publishedUser" name="publishedUser" value="${entityPro.publishedUser}">
<input type="hidden" id="mid0" name="mid0" value="${param.mid}">
<input type="hidden" id="gridListId" name="gridListId" />
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
					 	
					 	addpropertyRecord();
					 	
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
			         	
				     	//验证是否含有设计开发阶段数据
				     	if(!validatePhase()){
				         	 Matrix.hideMask();
					   		 return false;
				     	}
				     	
			         	deleteDataGridData('MDataGrid0',false);
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
			     	if(!keyValidator()){
			         	 Matrix.hideMask();
				   		 return false;
			     	}
			      
			     	
					document.getElementById('Form0').action='<%=request.getContextPath()%>/entity/entityProperty_saveProperties.action';
			     	
			     	
			     	
			     	
			     	convertEditDataGridData('MDataGrid0',true);
			     	Matrix.hideMask();
			     	return;
			     }
			    </script>
			    <script>
			   
			    isc.ToolStripButton.create({
			    	ID:"MToolBarItem13",
			    	icon:Matrix.getActionIcon("copy"),
			    	prompt: "复制",
			    	showDisabledIcon:false,
			    	showDownIcon:false
			     });
			     MToolBarItem13.click=function(){
			     	Matrix.showMask();
			     	if(!MForm0.validate()){
			     		Matrix.hideMask();
			     		return false;
			     	}
			  
			     	copyPropertyList();
			     
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
				 			onMoveUpRecord();
				 			
				 			
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
				 		    	onMoveDownRecord('DataGrid0');
				 		    	if(!MForm0.validate()){
				 		    		Matrix.hideMask();
				 		    		return false;
				 		    	}
				 		   
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
					 		    	MDialog1.initSrc="<%=request.getContextPath()%>/entity/entityProperty_loadUploadEntityXmlPage.action"
					 		    	//传入entityUuid将当前实体属性删除  
					 		    	Matrix.showWindow('Dialog1');
					 		    	Matrix.hideMask();
			 		    	}
			 		    	</script>
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
				 		    		ID:"MToolBarItem12",
				 		    		icon:Matrix.getActionIcon("import_db"),
				 		    		prompt: "载入",
				 		    		showDisabledIcon:false,
				 		    		showDownIcon:false
			 		    		 });
			 		    		 MToolBarItem12.click=function(){
				 		    		 Matrix.showMask();
				 		    	
				 		    		 if(!MForm0.validate()){
				 		    			 Matrix.hideMask();
				 		    		 	 return false;
			 		    		     }
			 		    		     loadTableColumns();
			 		    		
			 		    		     Matrix.hideMask();
			 		    		 }</script>
			 		    		 <script>
			 		    		 isc.ToolStripButton.create({
				 		    		 ID:"MToolBarItem11",
				 		    		 icon:Matrix.getActionIcon("sync_db"),
				 		    		 prompt: "同步表",
				 		    		 showDisabledIcon:false,
				 		    		 showDownIcon:false 
			 		    		 });
			 		    		 MToolBarItem11.click=function(){
				 		    		 Matrix.showMask();
				 		    		
				 		    		if(!MForm0.validate()){
					 		    		 Matrix.hideMask();
					 		    		 return false;
				 		    		 }
				 		    		 //同步表 HB模型
				 		    		 synPropsContent(true);
				 		    		 
			 		    		 	Matrix.hideMask();
			 		    		 }</script>
			 		    		 <script>
			 		    		 isc.ToolStripButton.create({
				 		    		 ID:"MToolBarItem15",
				 		    		 icon:Matrix.getActionIcon("sync_model"),
				 		    		 prompt: "同步HB模型",
				 		    		 showDisabledIcon:false,
				 		    		 showDownIcon:false
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
			 		    			}
			 		    	</script>
			 		    		  
			 		    		 
			 		    		   	<div id="j_id5_div"  style="width:100%;overflow:hidden;"  >
			 		    		   	<script>
			 		    		   	isc.ToolStrip.create({
			 		    		   		ID:"Mj_id5",
			 		    		   		displayId:"j_id5_div",
			 		    		   		width: "100%",
			 		    		   		//height: "*",
			 		    		   		position: "relative",
			 		    		   		members: [ 
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
			 		    		   				MToolBarItem10,
			 		    		   				"separator",
			 		    		   				MToolBarItem12,
			 		    		   				MToolBarItem11,
			 		    		   				MToolBarItem15
			 		    		   				
			 		    		   		 ] });
			 		    		   		 //如果为实体对象,添加对应的按钮
			 		    		   		 //9 10 12 15
			 		    		   		 if("<%=curPhase%>"==4){//业务定制阶段
			 		    		   		  //var deleteMemberArray = [MToolBarItem9,MToolBarItem10,MToolBarItem12,MToolBarItem15];
			 		    		   		  var deleteMemberArray = [MToolBarItem12,MToolBarItem15];
			 		    		   		  var seMember = Mj_id5.getMember(9);
			 		    		   		  deleteMemberArray.push(seMember)
			 		    		   		  Mj_id5.removeMembers (deleteMemberArray);
			 		    		   		  
			 		    		   		 }
			 		    		   		 /*
			 		    		   		 if(parseInt('${entityPro.entityType}')==1){//实体对象需要添加对应的操作按钮
                								var showItems = new Array();
                                                showItems.push("separator","MToolBarItem12","MToolBarItem11","MToolBarItem15");	
                								Mj_id5.addMembers(showItems);
										  }
										  */
			 		    		   		 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
			 		    		   		</script>
			 		    		   		</div>
			 		  </td>
					
		</tr>
		<tr id="j_id7" jsId="j_id7">
			
				<td id="j_id9" jsId="j_id9"  rowspan="1" style="border-style:none;width:100%;height:100%">
					<div id="DataGrid0_div" class="matrixComponentDiv" style="width:100%;height:100%;">
					<script>
	 		var map = {'1':'文本框','2':'日期框','3':'时间框',
					  			'4':'数字框','5':'下拉框','22':'多选下拉框','6':'单选按钮','7':'复选按钮','8':'单选按钮组','9':'复选按钮组','10':'文本域','30':'大文本域',
					  			'11':'列表框','12':'单文件上传','28':'多文件上传','14':'富文本框',
					  			'20':'隐藏域','21':'弹出选择','23':'单选用户','24':'多选用户','25':'单选部门','26':'多选部门',
					  			'29':'流程意见'
					  			};
			if("<%=curPhase%>" != '4'){
				 map = {'1':'文本框','2':'日期框','3':'时间框',
					  			'4':'数字框','5':'下拉框','22':'多选下拉框','6':'单选按钮','7':'复选按钮','8':'单选按钮组','9':'复选按钮组','10':'文本域','30':'大文本域定制',
					  			'11':'列表框','12':'单文件上传定制','28':'多文件上传定制','14':'富文本框',
					  			'20':'隐藏域','21':'弹出选择','23':'单选用户定制','24':'多选用户定制','25':'单选部门定制','26':'多选部门定制',
					  			'29':'流程意见定制'
					  			};
			}
			var displayValueMap = {'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'业务对象'};			 	
			var displayFormatValueMap = {'':'','#.##%':'百分号','#,###.##':'千分位','yyyy-MM-dd':'yyyy-MM-dd','yyyy年MM月dd日':'yyyy年MM月dd日','yyyy-MM-dd hh:mm':'yyyy-MM-dd hh:mm','yyyy年MM月dd日 hh:mm':'yyyy年MM月dd日 hh:mm'} ;
			var displayFormatVM = ['','#.##%','#,###.##','yyyy-MM-dd','yyyy年MM月dd日','yyyy-MM-dd hh:mm','yyyy年MM月dd日 hh:mm'] ;
			
			var valueMapNum=['','#.##%','#,###.##'];
			var displayValueMapNum={'':'','#.##%':'百分号','#,###.##':'千分位'}

			var valueMapDate=['','yyyy-MM-dd','yyyy年MM月dd日','yyyy-MM-dd hh:mm','yyyy年MM月dd日 hh:mm'];
			var displayValueMapDate={'':'','yyyy-MM-dd':'yyyy-MM-dd','yyyy年MM月dd日':'yyyy年MM月dd日','yyyy-MM-dd hh:mm':'yyyy-MM-dd hh:mm','yyyy年MM月dd日 hh:mm':'yyyy年MM月dd日 hh:mm'};
			
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
				      		    	if("<%=curPhase%>"=="4"){//业务定制阶段不验证
				      		    		return true;
				      		    	}
				      		    	
				      		        //非实体字段时不验证
				      		         var editValue= MDataGrid0.getEditValue(MDataGrid0.getRecordIndex (record), "isCol");//获取编辑值如果编辑过
			        				 if(editValue==null){
			         					editValue = record.isCol;
			        				 }
			        				 
			        				 if(!editValue){
			        				 		return true;
			        				 }
			        				
			        				 var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			        				 if(value==null||value.length==0){
			        				 	validator.errorMessage="字段名不能为空!";
			        				 	return false;
			        				 }
			        				 var isExist= columnNameValidate(item, validator, value, record, dataGrid);
				      		        return isExist;
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
					  		valueMap:['1','2','3','4','5','6','7','8','9','14','13'],
					  		autoFetchDisplayMap:true,
					  		showHover:false,
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
								//var rowNum =grid.getEditRow() ;
								
						  		var _formLength = form.grid.getEditFormItem("length");
						  		var _formPrecision = form.grid.getEditFormItem("precision");
						  		var _defaultVal = grid.getEditFormItem("defaultValue");
						  		var _displayFormat = grid.getEditFormItem("displayFormat");
						  		var _uiType = grid.getEditFormItem("uiType");
						  		
						  		_defaultVal.setDisabled(false);//可用
						  		_uiType.setDisabled(false);
						  		 
						  		//获取编辑时isCol列
						  		
						  		 var _formIsCol = form.grid.getField("isCol");
						  		 var lengField = grid.getField('length');
								 var precisionField = grid.getField('precision');
								 var displayFormatField = grid.getField('displayFormat');
								 
						  		 _formIsCol.canEdit = true;
					  		 	 //123长度可用 45 9精度 长度可用 其余都不可用
					  		 	 //关联对象时 默认值 ui组件不可用
					  		 	 var lengthList =[1,2,3];
								
					  		 	var displayFormatValue = _displayFormat.getValue();
					  		 	 if(value == 2 || value == 3 || value == 4 || value == 5){
					  		 		 if(typeof(displayValueMapNum[displayFormatValue]) == "undefined"){
						  		 		grid.setEditValue (grid.getEditRow(), grid.getFieldNum('displayFormat'), "");
					  		 		 }
					  		//		_displayFormat.setValueMap(displayValueMapNum);
					  		// 		_displayFormat.setEditorValueMap(displayValueMapNum);
					  		// 		_displayFormat.displayValueMap=displayValueMapNum;
					  		// 		displayFormatValueMap = displayValueMapNum;
					  		// 		displayFormatValueMap = displayValueMapNum;
					  		// 		displayFormatVM = valueMapNum;
					  		// 		displayFormatValueMap = displayValueMapNum;
					  		// 		displayFormatVM = valueMapNum;
					  		 	 }else if(value == 7){
					  		 		if(typeof(displayValueMapDate[displayFormatValue]) == "undefined"){
						  		 		grid.setEditValue (grid.getEditRow(), grid.getFieldNum('displayFormat'), "");
					  		 		 }
					  		// 		_displayFormat.setValueMap(displayValueMapDate);
					  		// 		_displayFormat.displayValueMap=displayValueMapDate;
					  		// 		displayFormatValueMap = displayValueMapDate;
					  		// 		displayFormatVM = valueMapDate;
					  		// 		displayFormatValueMap  = displayValueMapDate;
					  		// 		displayFormatVM = valueMapDate;
					  		 	 }else {
					  		 		grid.setEditValue (grid.getEditRow(), grid.getFieldNum('displayFormat'), "");
					  		 	 }
					  		 	 
					  		 	 if(value!=null && lengthList.contains(value)){//整数时 精度不可用
					  		 	 	 _formLength.setDisabled(false);
					  		 	 	 _formPrecision.setDisabled(true);
					  		 	 	 if(precisionField!=null){
								    	 grid.setEditValue (grid.getEditRow(), grid.getFieldNum('precision'), "");	
								    	}
					  		 	 
					  		 	 }else if(value!=null &&(value==4||value==5||value==9)){//小数时长度精度都可用
					  		 	 		_formLength.setDisabled(false);
					  		 	    	_formPrecision.setDisabled(false);
					  		 	    	//grid.refreshRecordComponent(grid.getRecordIndex(record));
					  		 	    	 //grid.refreshFields();
					  		 	         //grid.deselectRecord(record);
					  		 	    	//_formLength.updateState();
					  		 	    	//_formPrecision.updateState();
					  		 	    	
					  		 	 }else{
					  		 	 	  if(lengField!=null){//不可用时长度置空
								    	 grid.setEditValue (grid.getEditRow(), grid.getFieldNum('length'), "");	
								    	}
								    	
								     if(precisionField!=null){//不可用时精度置空
								    	 grid.setEditValue (grid.getEditRow(), grid.getFieldNum('precision'), "");	
								    	}	
					  		 	     _formLength.setDisabled(true);
					  		 	 	 _formPrecision.setDisabled(true);
					  		 	 	 //_formLength.updateState();
					  		 	    //_formPrecision.updateState();
					  		 	 
					  		 	 }
					  		 	
					  		 	 //设置关联对象
					  		 	 if(value!=null&&(value==13||value==14)){
					  		 	        //将当前编辑行的isCol设置为false
					  		 	        grid.setEditValue (grid.getEditRow(), grid.getFieldNum('isCol'), false);
					  		 	        _formIsCol.canEdit = false;//关联对象时 设置为不可用
					  		 	     
						  		 	 	// 判断选择结果是否为关联实体类型
						  		 	 	if(value==13){
					  		 	          
						  		 	 	  grid.setEditValue (grid.getEditRow(), grid.getFieldNum('defaultValue'), "");
						  		 	 	  //uiType为 弹出选择	
						  		 	 	  grid.setEditValue (grid.getEditRow(), grid.getFieldNum('uiType'), 21);
						  		 	 	  	
						  		 	 	   _defaultVal.setDisabled(true);
						  		 	 	   _uiType.setDisabled(true);
								    	   record.showSelectEntityComponent = true;
								    
								    	}
								    	
								    	if(lengField!=null&&precisionField!=null){
									    	 grid.setEditValue (grid.getEditRow(), grid.getFieldNum('length'), "");
									    	 grid.setEditValue (grid.getEditRow(), grid.getFieldNum('precision'), "");
								    	
								    	}
					  		 	 }else{
					  		    	 grid.setEditValue (grid.getEditRow(), grid.getFieldNum('proEntityUuid'), null);
							    	 record.showSelectEntityComponent = false;
					  		 	 
					  		 	 }
					  		 	//grid.refreshRow(rowNum);
					  		 	 grid.refreshFields();
					  		 	 grid.updateRecordComponents();
					  		 	 
					  			// return;
					  		}
					  		
					  },
					  
					  
					  {
					  		title:"长度",
					  		matrixCellId:"j_id23",
					  		name:"length",
					  		canEdit:true,
					  		width:'10%',
					  		editorType:'Text',
					  		type:'integer',
					  		showHover:false,
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					  		},
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
												var lengthList =[6,7,8,13,14];
												if((_7 &&lengthList.contains(_7))){
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
								,
								validators:[{
				      		    type:"custom",
				      		    condition:function(item, validator, value, record){
				      		    	var lenType = record.type;
				      		    	
				      		        var lenTypeList = [1,2,3,4,5];
				      		        if(lenTypeList.contains(lenType)){
					      		        return  numberValidate(item, validator, record.length+"", record);
				      		        
				      		        }else{//不可用时 不校验
				      		        	return true;
				      		        }
				      		     },
				      		     errorMessage:"长度不能为空!"
				      		 }]
					  },{
					  		title:"精度",
					  		matrixCellId:"j_id24",
					  		name:"precision",
					  		canEdit:true,
					  		width:'10%',
					  		editorType:'Text',
					  		type:'integer',
					  		showHover:false,
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					  		},
					  		editorProperties:{
					  				//是否可用
									isDisabled:function isc_FormItem_isDisabled(){
										var _2=this.form;_3=_2.grid;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _5 = "type";
												var _6 = _3.fields.findIndex(_3.fieldIdProperty,_5);
												var _formItem = _3.getEditFormItem(_5);
												var _7 =_formItem.getValue();
												if(((_7 && _7!=4)&&(_7 && _7!=5)&&(_7 && _7!=9))){//不等是为true
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
								,
								validators:[{
					      		    type:"custom",
					      		    condition:function(item, validator, value, record){
					      		    	var preType = record.type;
					      		        
					      		        //根据数据类型决定
					      		        if(preType==4||preType==5||preType==9){
					      		       		if(record.precision==null){
					      		       				errorMessage:"精度不能为空!";
					      		       				return false;
					      		       		}
						      		        return  numberValidate(item, validator, record.precision+"", record);
					      		        
					      		        }else{//不可用时 不校验
					      		        	return true;
					      		        }
					      		     },
					      		     errorMessage:"精度不能为空!"
				      		 }]
				      		 
				      		 
				      		 
					  },{
					  		title:"主键",
					  		matrixCellId:"j_id25",
					  		name:"isKey",
					  		canEdit:true,
					  		width:40,
					  		editorType:'Checkbox',
					  		type:'boolean',
					  		showHover:false,
					  		changed:function(form, item, value){
					  			if(value){//选中时触发
					  				checkedKey(form);
					  			}
					  		}
					  		
					  },{
					  		title:"必填",
					  		matrixCellId:"j_id28",
					  		name:"isRequired",
					  		canEdit:true,
					  		width:40,
					  		editorType:'Checkbox',
					  		type:'boolean',
					  		showHover:false
					  		
					  },{
					  		title:"默认值",
					  		matrixCellId:"j_id31",
					  		name:"defaultValue",
					  		canEdit:true,
					  		editorType:'Text',
					  		type:'text',
					  		showHover:false,
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					  		},
					  		editorProperties:{//为13关联对象时不可用
									isDisabled:function isc_FormItem_isDisabled(){
										var _2=this.form;_3=_2.grid;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _5 = "type";
												var _6 = _3.fields.findIndex(_3.fieldIdProperty,_5);
												var _formItem = _3.getEditFormItem(_5);
												var _7 =_formItem.getValue();
												if(_7 && _7==13){//为13时不可用
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
					  },{
					  		title:"实体字段",
					  		matrixCellId:"j_id32",
					  		name:"isCol",
					  		canEdit:true,
					  		width:"6%",
					  		editorType:'Checkbox',
					  		type:'boolean',
					  		showHover:false,
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
												if(((_7 && _7==13)&&(_7 && _7==14))){//为13,14时不可用
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
					  		
					  },
					  {
					  		title:"系统字段",
					  		matrixCellId:"j_id92",
					  		name:"isSystemCol",
					  		canEdit:true,
					  		width:"6%",
					  		editorType:'Checkbox',
					  		type:'boolean',
					  		showHover:false,
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
												if(((_7 && _7==13)&&(_7 && _7==14))){//为13,14时不可用
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
					  		
					  },
					  
					  {
							title : "显示格式",
							matrixCellId : "displayFormat",
							name : "displayFormat",
							canEdit:true,
					  		editorType:'comboBox',
					  	//	visibility:true,
					  		type:'text',
					  		valueMap:displayFormatVM,
					  		autoFetchDisplayMap:false,
					  		showHover:false,
					  		editorProperties:{
					  			displayValueMap: displayFormatValueMap
					  		},
					  	//	formatCellValue:function(value, record, rowNum, colNum,grid){
					  	//		if(value==null || value == ""){
					  	//			return "";
					  	//		}
					  	//		if(typeof(displayValueMapNum[value]) != "undefined"){
					  	//			this.valueMap = displayValueMapNum;
					  	//			return displayValueMapNum[value];
					  	//		}else if(displayValueMapDate[value] != "undefined"){
					  	//			this.valueMap = displayValueMapDate;
					  	//			return displayValueMapDate[value];
					  	//		}
					  	//		return "";
					  	//	}
						  	formatCellValue:function(value, record, rowNum, colNum,grid){
					  			if(value==null){
					  				return "";
					  			}
//					  			var uiTypeValue = grid.getEditValue(rowNum,"uiType");
					  			var uiTypeValue = record.uiType;
					  			if(uiTypeValue == '2'){
					  				return displayValueMapDate[value];
					  			}else if(uiTypeValue == '4'){
					  				return displayValueMapNum[value];
					  			}
					  			return "";
					  		},
					  		getEditorValueMap : function (values, field, grid) {
					             var division = values.uiType;
					             if(division == '2'){
					            	 return displayValueMapDate;
					             }else if(division == '4'){
					            	 return displayValueMapNum;
					             }
						         return {'':''};
					         }
						},
					  
					  {
						title : "选择项",
						matrixCellId : "options",
						name : "options",
						canEdit:true,
						editorType:'PopupSelect',
						type:'text',
						showHover:false,
						formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
				  		}
				       
					},
					  {
					  		title:"UI组件",
					  		matrixCellId:"j_id35",
					  		name:"uiType",
					  		canEdit:true,
					  		required:false,
					  		editorType:'select',
					  		type:'text',
					  		showHover:false,
					  		valueMap:['1','2','3','4','5','22','6','7','8','9','10','30','11','12','28','14','20','21','23','24','25','26','29'],
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  				return convertUIValue(value,record, rowNum, colNum,grid);
					  		},
					  		editorProperties:{//为13关联对象时不可用
									isDisabled:function isc_FormItem_isDisabled(){
										var _2=this.form;_3=_2.grid;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _5 = "type";
												var _6 = _3.fields.findIndex(_3.fieldIdProperty,_5);
												var _formItem = _3.getEditFormItem(_5);
												var _7 =_formItem.getValue();
												
												if(_7 && _7==13){//为13时不可用
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
								},
								
					  		    autoFetchDisplayMap:true,
						  		editorProperties:{
							  		
							  		displayValueMap: map,
	      							valueIcons: {'1':'input','2':'inputDate','3':'inputTime','4':'numberSpinner',
						  			'5':'comboBox','6':'radio','7':'checkBox','8':'radioGroup',
						  			'9':'checkBoxGroup',
						  			'10':'inputTextArea','11':'listBox','12':'fileUpload','14':'richText',
						  			'20':'inputHidden','21':'popupSelectDialog','22':'multiFilteringSelect','23':'userSelect','24':'usersSelect','25':'depSelect',
						  			'26':'depsSelect','28':'fileUpload','29':'flowComment','30':'bigTextArea'
						  		   },
						  		   imageURLPrefix:isc.Page.getImgURL("[SKIN]/matrix/component/"),
	       						    imageURLSuffix:".png"
	    					 
						  		},
						  		changed:"item.grid.setValueMap('displayFormat')"
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
			       //需要考虑禁用的都设置为可用 然后根据类型设置这些字段的可编辑性
			       //初始化时设置Cell是否可编辑
			  		var record = this.getRecord(rowNum);
	                fieldName = this.getFieldName(colNum);
			  		if(record!=null){
			  		    var type = record.type;
			  		    
			  		    var phase = record.phase;
			  		    if("2" == phase){//设计开发
			  		    	return false;
			  		    }
			  		    
			  		    
			  		    if(fieldName == 'options'){
			  		    	var uiTypeValue = MDataGrid0.getEditedRecord (rowNum).uiType;//获取编辑值如果编辑过
			  		    //	var uiTypeValue = record.uiType ;
			  		    	//根据ui组件控制选择项的是否编辑
			  		    	if(uiTypeValue != 5 && uiTypeValue != 6 && uiTypeValue != 7 && uiTypeValue != 8 && uiTypeValue != 9 && uiTypeValue != 22 && uiTypeValue != 11){
			  		    		var record=Matrix.getDataGridSelection('DataGrid0');	
				  		  		var dataGrid = Matrix.getMatrixComponentById('DataGrid0');
			  		    		record.options='';
			  					dataGrid.setEditValue(rowNum,"options",'');
			  		    		
				  		    	return false;
			  		    	}
			  		    }
			  		 
			  		    
			  		   /* 
	                    if(fieldName=="isCol" && (type==13||type==14)){//如果为扩展组件
	                       record.isCol = false;
	                        return false;
	                    }
	                    */
	                    
	                    
	                   //  if(fieldName=="uiType" && (type!=13||type==14)){//如果为扩展组件
	                   //    record.isCol = false;
	                  //      return false;
	                 //   }
			  		}
                   return this.Super("canEditCell", arguments);//默认处理
			  },
			  
			  rowClick:function(record, recordNum, fieldNum){//rocordNum 从0开始
			  	
			      //先取编辑值
			      var type= MDataGrid0.getEditedRecord (recordNum).type;//获取编辑值如果编辑过
			  
			         if(type==null){
			         	type = record.type;
			         }
			     
				      var isColField = MDataGrid0.getField("isCol");
				      if(type==13||type==14){
						    isColField.canEdit= false;
				    
				      }else{
				            isColField.canEdit = true;
				      }
				      
			      //获取当前的type值 根据type值刷新Field
			     	overwritetypeChange(type);
			   
			      return this.Super("rowClick", arguments);
			  }
			});
			
			if("<%=curPhase%>"=="4"){//业务定制阶段
				MDataGrid0.hideField ('colName');
				MDataGrid0.hideField ('isKey');
				
			}
			
			isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
			isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);

			var ratio = detectZoom();if(ratio != 100){setTimeout(reInitGridScroll,200);}
			
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
function getParamsForDataGrid0_optionsDialog(grid,record,rowNum,columnNum){
var params='&';
var value;
return params;
}
isc.Window.create({
ID:"MDataGrid0_optionsDialog",
id:"DataGrid0_optionsDialog",
name:"DataGrid0_optionsDialog",
position:"absolute",
height: "80%",
width: "40%",
title: "选择项",
autoCenter: true,
animateMinimize: false,
canDragReposition: true,
//targetDialog: "CodeMain",
showHeaderIcon:false,
showTitle:true,
showMinimizeButton:false,
showMaximizeButton:true,
showCloseButton:true,
showModalMask: false,
isModal:true,
autoDraw: false,
getParamsFun:getParamsForDataGrid0_optionsDialog,
initSrc:"<%=request.getContextPath()%>/form/admin/custom/queryList/options.jsp",
src:"<%=request.getContextPath()%>/form/admin/custom/queryList/options.jsp" });
function onDataGrid0_optionsDialogClose(data) {
		var record=Matrix.getDataGridSelection('DataGrid0');	
		var dataGrid = Matrix.getMatrixComponentById('DataGrid0');
		var editRowNum = dataGrid.getEditRow();	
		if (data == null)
			return true;
		if (isc.isA.String(data))
			data = isc.JSON.decode(data);
		if (data['info'] != null) {
			if(data['info'] == '_cleanSelectItem_'){
				record.options='';
				dataGrid.setEditValue(editRowNum,"options",'');
			}else{
				record.options=data['info'];
				dataGrid.setEditValue(editRowNum,"options",data['info']);
			}
			MDataGrid0.redraw();
		}
		
	}
</script>

	<script>
   
     //获取选中行数据的id值
     function getEditAttributeId(){
     	 var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		  if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				warnMg("没有数据被选中，不能执行此操作。",{ width:150,height:70});
				return null;
			}
			return dataGrid.getSelection()[0].id;
		}
		return null;
     }
     
	
	//保存数据
	function saveData(dataGridId,actionId,msg){
		debugger;
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		warnMg("非法数据表格。");
		return false;
	}
	
	if(_curGrid.canEdit && _curGrid.hasChanges()){
		// 保存表格编辑数据
		if(!Matrix.saveDataGridData(dataGridId)){
			warnMg("表格包含非法数据。");
			return false;
		};
	}
	
	// 修改数据,
	var items = _curGrid.getData();
	
	if(items.length==0){
		warnMg("没有数据被修改，不能执行此操作。");
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
		
		//warnMg(msg);
	 }
	 return false;
  };
	function callback(){
		infoMsg("添加成功",{title:'提示消息'});
	
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


	isc.Window.create({
		ID:"MDialog1",
		id:"Dialog1",
		name:"Dialog1",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "400",
		title: "导入实体属性",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialog1.hide();
	
	//载入
	
	isc.Window.create({
		ID:"MLoadColumnDialog",
		id:"LoadColumnDialog",
		name:"LoadColumnDialog",
		autoCenter: true,
		position:"absolute",
		height: "400",
		width: "600",
		title: "选择表字段",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MLoadColumnDialog.hide();
	
	</script>

	</div>
<script type="text/javascript">
 /******** property  id validate begin*********/
 function propertyIdValidate(item, validator, value, record,dataGrid){
	//空的话返回false
	if(value==null||value.length==0){
	  validator.errorMessage="编码不能为空!";
	  return false;
	}
	
	 var hasInput = Matrix.validateLength(1,100, value);
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
		   var exceptMsg = value.match(/^[a-zA-Z\d_]*$/);//
		 	if(exceptMsg==null){//含有非法字符
			 	validator.errorMessage="只能使用字母数字下划线命名";
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
 
 /******** component id validate end *********/
 
  /******** property  name validate begin*********/
 function propertyNameValidate(item, validator, value, record,dataGrid){
	//空的话返回false
	if(value==null||value.length==0){
	  validator.errorMessage="名称不能为空!";
	  return false;
	}
	 var hasInput = Matrix.validateLength(1,100, value);
	
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
 /******** property  name validate end*********/

 
  /******** overwrite  type change begin*********/
     			 //只改变行记录的组件的可用性 不改变各个组件的值
      			function overwritetypeChange(value){
      							var form = MForm0;
						  		var grid = MDataGrid0;
								var rowNum =grid.getEditRow() ;
								if(rowNum==null)return;
								var record = grid.getRecord(grid.getEditRow());
								
						  		var _formLength = grid.getEditFormItem("length");
						  		var _formPrecision = grid.getEditFormItem("precision");
						  		var _defaultVal = grid.getEditFormItem("defaultValue");
						  		var _uiType = grid.getEditFormItem("uiType");
						  		
						  		if(_defaultVal)
						  			_defaultVal.setDisabled(false);//可用
						  		if(_uiType)	
						  			_uiType.setDisabled(false);
						  		 
						  		//获取编辑时isCol列
						  		
						  		 var _formIsCol = grid.getField("isCol");
						  		 var lengField = grid.getField('length');
								 var precisionField = grid.getField('precision');
								 
						  		 _formIsCol.canEdit = true;
					  		 	 //1238长度可用 45精度 长度可用 其余都不可用
					  		 	 //关联对象时 默认值 ui组件不可用
					  		 	 var lengthList =[1,2,3,8];
					  	        
					  		 	 if(value!=null && lengthList.contains(value)){//整数时 精度不可用
					  		 	 	 _formLength.setDisabled(false);//长度可用
					  		 	 	 _formPrecision.setDisabled(true);
					  		 	 	// if(precisionField!=null){
								    	// grid.setEditValue (grid.getEditRow(), grid.getFieldNum('precision'), "");	
								    //	}
					  		 	 
					  		 	 }else if(value!=null &&(value==4||value==5||value==9)){//小数时长度精度都可用
					  		 	 		_formLength.setDisabled(false);
					  		 	    	_formPrecision.setDisabled(false);
					  		 	    	
					  		 	    	//_formLength.updateState();
					  		 	    	//_formPrecision.updateState();
					  		 	    	
					  		 	 }else{
					  		 	     
					  		 	     _formLength.setDisabled(true);
					  		 	 	 _formPrecision.setDisabled(true);
					  		 	 	 
					  		 	 	// _formLength.updateState();
					  		 	    //_formPrecision.updateState();
					  		 	 
					  		 	 }
					  		 	
					  		 	 //设置关联对象
					  		 	 if(value!=null&&(value==13||value==14)){
					  		 	        _formIsCol.canEdit = false;//关联对象时 设置为不可用
					  		 	     
						  		 	 	// 判断选择结果是否为关联实体类型
						  		 	 	if(value==13){
						  		 	 	   _defaultVal.setDisabled(true);
						  		 	 	   _uiType.setDisabled(true);
						  		 	 	 //点击时不维护选择关联对象按钮
								    	 // record.showSelectEntityComponent = true;
								    
								    	}
								    	
					  		 	 }
					  		 	 
					  		 	 //grid.refreshFields();
					  		 	 grid.updateRecordComponents();
					  		 	 
					  			// return;
					  		}
   /********  overwrite  type change end*********/
 
	</script>

</body>
</html>