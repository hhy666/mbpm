<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>表单版本列表</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></SCRIPT>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<script type="text/javascript">

    function onDialog0Close(data, oType){
    	return true;
    }
   function onDialog1Close(){
    	Matrix.say('授权成功！');
    }
    //通过编辑按钮更新 
    function updateFormVersion(){
    	//获取选中的记录
    	 
		 if(isc.Browser.isIE&&isc.Browser.isIE10){
		 	//isc.warn("由于浏览器兼容问题，目前设计表单建议使用IE9及以下版本IE浏览器，或使用谷歌浏览器！");
		 	//return false;
		 }
		 
    	var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
    		doubleClickUpdateFormVersion(record);
		}else{
			warnMsg("请先选择表单版本!");
		}
    
    }

	//表单版本授权
	function empowerFormVersion(){
	    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			var state = record.state;
			//将 formUuid 
		    var formUuid = record.uuid;
		    var modulePath = "";    
	        var url ="<%=request.getContextPath()%>/security/formSecurity_loadSecurityIndex.action?formUuid="+formUuid+"&modulePath="+modulePath;
	      	
			if(state==1){//发布
					url=url+"&state="+state;
			}
	      	
	      	 MDialog0.initSrc = url;
	      	 Matrix.showWindow("Dialog0");
		
		}else{
			warnMsg("请先选择表单版本!");
		}
	
	}
	//导出权限
	function saveFormAuth2File(){
	    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			var state = record.state;
			//将 formUuid 
		    var formUuid = record.uuid; 
		    var formName = record.mid;
		    var flag = "exportMod";
	        var url ="<%=request.getContextPath()%>/ModelConvertDocumentHelper?formUuid="+formUuid+"&formName="+formName+"&flag="+flag;
	      	window.location.href = url;
		}else{
			warnMsg("请先选择表单版本!");
		}
	
	}
	//导入权限
	function importFile(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			var state = record.state;
			//将 formUuid 
		    var formUuid = record.uuid; 
		    var formName = record.mid;
		    var flag = "importDoc";
	        var url ="<%=request.getContextPath()%>/ModelConvertDocumentHelper?formUuid="+formUuid+"&formName="+formName+"&flag="+flag;
	      	Matrix.sendRequest(url,null,function(data){
	      		var result = isc.JSON.decode(data.data);
	      		if(result.result=='success'){
	     			Matrix.say("导入权限成功!");
	      		}else if(result.result=='file is null'){
	      			Matrix.warn('权限文件为空!');
	      		}else{
	      			Matrix.warn('未找到权限文件!');
	      		}
	      	});
		
		}else{
			warnMsg("请先选择表单版本!");
		}
	}
	
	
	//双击实现修改模型 
	function doubleClickUpdateFormVersion(record){
		 
		 if(isc.Browser.isIE&&isc.Browser.isIE10){
		 	//isc.warn("由于浏览器兼容问题，目前设计表单建议使用IE9及以下版本IE浏览器，或使用谷歌浏览器！");
		 	//return false;
		 }
		 
		 parent.document.getElementById("formUuid").value = record.uuid;
		 parent.document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_updateFormVersion.action?state='+record.state;
	     parent.document.getElementById('Form0').submit();
	}

	//添加表单版本[同步提交]
	function addFormVersion(){
	   
	    //将本页面的字段值赋值到父页面中
	    // parent.document.getElementById("version").value = addVersion;
	     
	     parent.document.getElementById("mid").value = "${formInfo.mid}";
	     parent.document.getElementById("name").value = "${formInfo.name}";
	     parent.document.getElementById("desc").value = "${formInfo.desc}";
	     
		 parent.document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_addFormVersion.action';
	     parent.document.getElementById('Form0').submit();
	     
	}
	
	//复制一个新的表单版本
	function copyFormVersion(){
		//获取选中记录的uuid
		
		 if(isc.Browser.isIE&&isc.Browser.isIE10){
		 	//isc.warn("由于浏览器兼容问题，目前设计表单建议使用IE9及以下版本IE浏览器，或使用谷歌浏览器！");
		 	//return false;
		 }
		 debugger;
	    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
			  parent.document.getElementById("formUuid").value = record.uuid;
		
		}else{
			warnMsg("请先选择表单版本!");
			return;
		}
	 	
	     
	     //将本页面的字段值赋值到父页面中
	     //parent.document.getElementById("version").value = addVersion;
	     parent.document.getElementById("mid").value = "${formInfo.mid}";
	     parent.document.getElementById("name").value = "${formInfo.name}";
	     parent.document.getElementById("desc").value = "${formInfo.desc}";
	     
	     parent.document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_copyFormVersion.action';
	     parent.document.getElementById('Form0').submit();
	     
	}
	
    //发布表单
function publishedForm() {
    var _curGrid;
    _curGrid = eval("MDataGrid0");
    if (_curGrid == null) {
        warnMsg("非法数据表格编码#" + dataGridId);
        return false;
    }
    if (!_curGrid.getSelection() || _curGrid.getSelection().length == 0) {
    	warnMsg("没有数据被选中，不能执行此操作。");
        return false;
    }
    
    
    
    //获取选中的数据
    var record = _curGrid.getSelectedRecord();
 //   var rowNum = _curGrid.getRecordIndex(record);
 //   var colNum = _curGrid.getFieldNum("state"); //1.为发布
    var state = record.state;
    if(record.version==0){
	 			warnMsg("该版本不支持此操作!");
	 			return false;
	}
    
    if (state == 1) {
        warnMsg("您已经发布,请勿重复操作!");
    } else if (state == 0) {
        document.getElementById("state").value = 1;
        document.getElementById("uuid").value = record.uuid;
        //切换选择状态
        document.getElementById('Form0').action ='<%=request.getContextPath()%>/form/formInfo_updateFormState.action';
        Matrix.send("Form0",null,function(data){
				var dataStr = data.data;
			    if(dataStr!=null){
					var dataJson = isc.JSON.decode(dataStr);
					if(dataJson.message==true){//发布成功
						record.state =1;
						record.publishedUser = dataJson.publishedUser;
						record.publishedDate = dataJson.publishedDate;
						record.operator = dataJson.operator;
       					_curGrid.updateData(record);//更新记录
       					_curGrid.refreshFields();
						infoMsg('发布成功! ');
					}else{
						warnMsg('操作失败,请确认表单模型是否校验通过！');
					}
			    }
			});
      	return false;
     }
 }
    
     //撤销发布
     function cancelPublishedForm(){
     	var _curGrid;
			_curGrid=eval("MDataGrid0");
			if(_curGrid==null){
				warnMsg("非法数据表格编码#"+dataGridId);
				return false;
			}
			if(!_curGrid.getSelection() || _curGrid.getSelection().length==0){
				warnMsg("没有数据被选中，不能执行此操作。");
				return false;
			}
			
			
	 		//获取选中的数据
	 		var record = _curGrid.getSelectedRecord();
	 		if(record.version==0){
	 			warnMsg("该版本不支持此操作!");
	 			return false;
	 		}
	 		
	 		var rowNum = _curGrid.getRecordIndex(record);
	 		var colNum = _curGrid.getFieldNum("state");//1.为发布 0 未发布
	        var state = record.state;
	        if(state==0){
	        	warnMsg("您还未发布,请勿执行此操作!");
	        }else if(state==1){
	        	document.getElementById("state").value=0;
	        	document.getElementById("uuid").value=record.uuid;

			   	document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_updateFormState.action';
				Matrix.send("Form0",null,function(data){
					var dataStr = data.data;
				    if(dataStr!=null){
						var dataJson = isc.JSON.decode(dataStr);
						if(dataJson.message==true){//撤销发布成功
							record.state =0;
							record.publishedUser = null;
							record.publishedDate = null;
							record.operator = null;
	       					_curGrid.updateData(record);//更新记录
	       					_curGrid.refreshFields();
							infoMsg('撤销发布成功!');
						}else{
							warnMsg('操作失败!');
						}
				    }
				});
				
			    return false;
	        }
     }
     
     
     function infoMsg(message){
    	
    	 layer.msg(message, {icon: 1});
     }
     
     function warnMsg(message){
     	
    	 layer.msg(message, {icon: 0});
     }
     
     function confirmMsg(message,callback,properties){
    		// callback param is result
    		// properties eg: { buttons : [Dialog.OK, Dialog.CANCEL] }
    		//isc.confirm(message,callback,properties);
    		if(properties!=null&&properties!=""){
    			//layer.confirm( message,{  time: 0,properties,yes:function (index) {layer.close(index);callback()},no:function (index){Matrix.hideMask();return false;}});
    		}else{
    			layer.confirm( message,{  time: 0,btn: ['确定', '取消'],yes:function (index) {layer.close(index);callback()},no:function (index){Matrix.hideMask2();return false;}});
    		}
    	}

     
      //删除数据
      function deleteDataGridData(dataGridId,isAjax){
			var _curGrid;
			_curGrid=eval(dataGridId);
			if(_curGrid==null){
				warnMsg("非法数据表格编码#"+dataGridId);
				return false;
			}
			var selectedRecords = _curGrid.getSelection();
			if(! selectedRecords|| selectedRecords.length==0){
				warnMsg("没有数据被选中，不能执行此操作。");
				//isc.warn("没有数据被选中，不能执行此操作。");
				return false;
			}
			var seRecord = selectedRecords[0];
			if(seRecord.version==0){
				warnMsg("该版本不支持此操作!");
	 			return false;
	 		}
			var state = seRecord.state;
			//是否发布
			if(state==1){
				warnMsg("表单已发布，不能执行删除操作。");
				return false;
			}
			
			//操作人是否为空
			var operator = seRecord.operator;
			
			if(operator!=null&&operator.length>0){
				var currentUser = parent.document.getElementById('currentUser').value;
				if(currentUser!=null){
					if(currentUser!=operator){
						warnMsg('您当前未获得对该表单的操作权限!');
						return false;
					}
					
				}else{
					warnMsg('获取当前登录用户信息异常!');
				}
			
			}
			//var confirmMsg = false;
			
			isc.confirm('您确定要删除该表单版本？',function(data){
			  if(data){
					_curGrid.removeSelectedData();//前端删除数据
					//获取删除的数据
					var deleteData = _curGrid.deleteItems;
					if(deleteData!=null&&deleteData.length>0){
					    var deleteResult = Matrix.itemsToJson(deleteData);
						document.getElementById("delete_data_rows").value=deleteResult;	
						_curGrid.deleteItems=[];
					}
					
					if(isAjax){
					   	document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_deleteFormVersion.action';
					   	debugger;
						Matrix.send("Form0");
					    return false;
					}
			  }
			   return false;
			});
		
			
		return true;	
	}
	
	//删除信息回调函数
	function callbackMag(result){
		 infoMsg(result.data);
	}

	//初始化数据表格数据
 	function initGridList(){
			
		     Matrix.send("Form0");
	 }
	 
	 //*******************************************************
	 
	 //放到body标签的onload方法中
	 function format(){
	 	var createdUser = Matrix.getFormItemValue('createdUser');
	 	if(createdUser=='null'){
	 		Matrix.setFormItemValue('createdUser'," ");
	 		//MDataGrid0.resizeTo('100%','100%');
	 	}
	 }
	 //*******************************************************
	</script>
</head>
<body onload="format()">
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"<%=request.getContextPath()%>/form/formInfo_getFormVersions.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="<%=request.getContextPath()%>/form/formInfo_getFormVersions.action" style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<!-- commom cols -->
<input type="hidden" id="nodeUuid" name="nodeUuid" value="${formInfo.nodeUuid}">

<!-- 实体类型 entity[1] or query Obj [2]  -->
<input type="hidden" id="type" name="type" value="${formInfo.type}">
<input type="hidden" id="version" name="version"/><!-- 添加时动态写入值 -->

<input type="hidden" id="mid" name="mid" value="${formInfo.mid}">
<input type="hidden" id="name" name="name" value="${formInfo.name}">
<input type="hidden" id="desc" name="desc" value="${formInfo.desc}">
<input type="hidden" id="createdUser" name="createdUser" value="${formInfo.createdUser }"/>  
<!-- <input type="hidden" id="createdDate" name="createdDate" value="${formInfo.createdDate }"/>-->
<input type="hidden" id="operatorName" name="operatorName" value="${formInfo.operatorName }"/>



<input type="hidden" id="gridListName" name="gridListName" value="MDataGrid0"/>
<input type="hidden" id="actionType" name="actionType"/>
<input type="hidden" id="delete_data_rows" name="delete_data_rows">
<input type="hidden" id="update_data_rows" name="update_data_rows">
<input type="hidden" id="state" name="state">
<input type="hidden" id="uuid" name="uuid">
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="dataTable" jsId="dataTable" cellpadding="0px" cellspacing="0px" style="width:100%;height:100%;">
		<tr id="j_id2" jsId="j_id2">
				
				<td id="j_id4" jsId="j_id4" class="query_form_toolbar"  rowspan="1" style="border-style:none;">
					<script>
					isc.ToolStripButton.create({
							ID:"MToolBarItem3",
							icon:Matrix.getActionIcon("add"),
							title: "添加",
							showDisabledIcon:false,
							showDownIcon:false
					 });
					 MToolBarItem3.click=function(){
					 	Matrix.showMask();
					 	addFormVersion();
					 		
					    Matrix.hideMask();
					 	//return false;
					 	
					}
					</script>
					<script>
					isc.ToolStripButton.create({
							ID:"MToolBarItem31",
							icon:Matrix.getActionIcon("edit"),
							title: "编辑",
							showDisabledIcon:false,
							showDownIcon:false
					 });
					 MToolBarItem31.click=function(){
					 	Matrix.showMask();
					 	updateFormVersion();
					 		
					    Matrix.hideMask();
					 	
					}
					</script>
					<script>
					isc.ToolStripButton.create({
							ID:"MToolBarItem4",
							icon:Matrix.getActionIcon("copy"),
							title: "复制",
							showDisabledIcon:false,
							showDownIcon:false
					 });
					 MToolBarItem4.click=function(){
					 	Matrix.showMask();
					 	copyFormVersion();
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
			         	deleteDataGridData('MDataGrid0',true);
			         	Matrix.hideMask();
			         		return false;
			         	
			         }
			     </script>
			     <script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem6",
			     		icon:Matrix.getActionIcon("auth"),
			     		title: "授权",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     	});
			     	MToolBarItem6.click=function(){
			     		Matrix.showMask();
			            empowerFormVersion();
			  
			     	Matrix.hideMask();
			     	return;
			     }
			    </script>
			    <script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem17",
			     		icon:Matrix.getActionIcon("publish"),
			     		title: "发布",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     		
			     	});
			     	MToolBarItem17.click=function(){
			     		Matrix.showMask();
			          
			     		//调用发布函数
						publishedForm();
				     	Matrix.hideMask();
				     	return false;
			     	}
			    </script>
			    <script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem8",
			     		icon:Matrix.getActionIcon("save_hd"),
			     		title: "导出权限",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     	});
			     	MToolBarItem8.click=function(){
			     		Matrix.showMask();
			            saveFormAuth2File();
			  
			     	Matrix.hideMask();
			     	
			     }
			      </script>
			     <script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem9",
			     		icon:Matrix.getActionIcon("import_hd"),
			     		title: "导入权限",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     	});
			     	MToolBarItem9.click=function(){
			     		Matrix.showMask();
			     		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
						var record = dataGrid.getSelectedRecord();
						if(record!=null){
							var state = record.state;
		    				var formUuid = record.uuid; 
		    				var formName = record.mid;
		    				var flag = "importDoc";
			     			MDialog1.initSrc = "<%=request.getContextPath()%>/form/formInfo_addSecurityFilePage.action?recordId="+formUuid+"&formName="+formName;
			           	 	Matrix.showWindow("Dialog1");
			  			}else{
			  				warnMsg("请先选择表单版本!");
						}
			     		Matrix.hideMask();
			     	
			     	}
			    </script>
			    <script>
			    var copyData;
			    isc.ToolStripButton.create({
			    	ID:"MToolBarItem7",
			    	icon:Matrix.getActionIcon("exit"),
			    	title: "撤销发布",
			    	showDisabledIcon:false,
			    	showDownIcon:false
			    	
			     });
			     MToolBarItem7.click=function(){
			     	Matrix.showMask();
			     	if(!MForm0.validate()){
			     		Matrix.hideMask();
			     		return false;
			     	}
			     	
			     	Matrix.convertFormItemValue('Form0');
			        cancelPublishedForm();
			     	Matrix.hideMask();
			     }
			  </script>
			 		 	<div id="j_id5_div"  style="width:100%;height:30px;overflow:hidden;"  >
			 		    		   	<script>
			 		    		   	isc.ToolStrip.create({
			 		    		   		ID:"Mj_id5",
			 		    		   		displayId:"j_id5_div",
			 		    		   		width: "100%",
			 		    		   		height: "*",
			 		    		   		position: "relative",
			 		    		   		members: [ 
			 		    		   				MToolBarItem3,
			 		    		   				MToolBarItem31,
			 		    		   				MToolBarItem4,
			 		    		   				MToolBarItem5,
			 		    		   				"separator",
			 		    		   				MToolBarItem6,
			 		    		   				MToolBarItem9,
			 		    		   				MToolBarItem8,
			 		    		   				MToolBarItem17,
			 		    		   				MToolBarItem7
			 		    		   				
			 		    		   				
			 		    		   		 ] 
			 		    		   	 });
			 		    		   	    
			 		    		   		var curPhase = "${requestScope.phase}";
			 		    		   		//需求分析阶段 不显示发布 撤销发布 操作
			 		    		   		if(curPhase=="1"){
			 		    		   		
			 		    		   			Mj_id5.removeMembers ([MToolBarItem17,MToolBarItem7]);
			 		    		   		}
			 		    
			 		    		   		 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
			 		    		   		</script>
			 		    	 </div>
			 		  </td>
					
		</tr>
		
		<tr id="j_id7" jsId="j_id7">
			
				<td id="j_id9" jsId="j_id9"  rowspan="1" style="border-style:none;width:100%;">
					<div id="DataGrid0_div" class="matrixComponentDiv" style="width:100%;height:100%;">
		<script>
	 	
						 	
			isc.MatrixListGrid.create({
					ID:"MDataGrid0",
					name:"DataGrid0",
					canSort:true,
					displayId:"DataGrid0_div",
					position:"relative",
					width:"100%",
					height:"100%",
					recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                        doubleClickUpdateFormVersion(record);
                     },
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
						  	title:"版本号",
						  	matrixCellId:"j_id11",
						  	name:"version",
						  	canEdit:false,
						  	editorType:'Text',
						  	canHide:true,
						  	align:"left",
						  	type:'integer',
						  	required:true
						  	
					  },{
						  	title:"创建人",
						  	matrixCellId:"j_id12",
						  	name:"createdUser",
						  	editorType:'Text',
						  	canEdit:false,
						  	type:'text',
						  	required:true,
						  	formatCellValue:function(value, record, rowNum, colNum,grid){//对该属性方法进行重写
						  		return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
						  	}
					  },
					  {
						  title:"创建时间",
						  matrixCellId:"j_id13",
						  name:"createdDate",
						  canEdit:false,
						  editorType:'Text',
						  canEdit:false,
						  type:'text',
						  canHide:true
						  
					  },{
					  		
						  	title:"发布人",
						  	matrixCellId:"j_id14",
						  	name:"publishedUser",
						  	editorType:'Text',
						  	canEdit:false,
						  	type:'text',
						  	required:true,
						  	formatCellValue:function(value, record, rowNum, colNum,grid){//对该属性方法进行重写
						  		return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
						  	}
						  	
					  },
					  
					  {
						  title:"发布时间",
						  matrixCellId:"j_id15",
						  name:"publishedDate",
						  canEdit:false,
						  editorType:'Text',
						  type:'text',
						  canHide:true
						  
					  },
					  {
						  title:"当前操作人",
						  matrixCellId:"j_id16",
						  name:"operatorName",
						  canEdit:false,
						  editorType:'Text',
						  type:'text',
						  canHide:true
						  
					  },
					  {
					  		title:"状态",
					  		matrixCellId:"j_id25",
					  		name:"state",
					  		canEdit:false,
					  		width:100,
					  		editorType:'select',
					  		type:'integer',
					  		valueMap:{'1':'发布','0':'未发布'}
				 }],
			  //设置UI组件和扩展组件关联关系
			  
			  autoSaveEdits:false,
			  autoFetchData:true,
			  alternateRecordStyles:true,
			  showDefaultContextMenu:false,
			  canAutoFitFields:false,
			  startLineNumber:1,
			  canEdit:false,
			  selectionType: "single",
              canDragSelect: false,
              editEvent: "click",
			  showRecordComponents:true,
			  showRecordComponentsByCell:true,
			  canEditCell2:function(rowNum, colNum){
                   return this.Super("canEditCell", arguments);//默认处理
			  } 
			});
			
			
			isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
			isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			
     


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

    
	
	//保存数据
	function saveData(dataGridId,actionId,msg){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	if(_curGrid.canEdit && _curGrid.hasChanges()){
		// 保存表格编辑数据
		if(!Matrix.saveDataGridData(dataGridId)){
			isc.warn("表格包含非法数据。");
			return false;
		};
	}
	
	// 修改数据,
	var items = _curGrid.getData();
	
	if(items.length==0){
		isc.warn("没有数据被修改，不能执行此操作。");
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
		
		//isc.warn(msg);
	 }
	 return false;
  };
	function callback(){
		isc.warn("添加成功！");
	
	}
	
	

	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		targetDialog:"CatalogTarget",
		autoCenter: true,
		position:"absolute",
		height: "500",
		width: "900",
		title: "表单授权",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","closeButton"
		]
		
		
	 });
	MDialog0.hide();
	
	isc.Page.setEvent(isc.EH.LOAD,"initGridList();");
	
	</script>
	

	</div>
	<script>
                                function getParamsForDialog1() {
                                    var params = '&';
                                    var value;
                                    return params;
                                } 
                                isc.Window.create({
                                    ID: "MDialog1",
                                    id:"Dialog1",
                                    name:"Dialog1",
                                    autoCenter: true,
                                    position: "absolute",
                                    height:"300px",
                                    width:"400px",
                                    title: "",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel","closeButton"]
                                });
                            </script>
                            <script>
                                MDialog1.hide();
                            </script>

</body>
</html>