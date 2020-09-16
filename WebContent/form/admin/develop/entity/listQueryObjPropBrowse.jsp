<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询对象属性维护</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT SRC='<%=request.getContextPath()%>/resource/html5/js/jquery.min.js'></SCRIPT>

<script type="text/javascript">
	
	</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="" style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<input type="hidden" id="gridListName" name="gridListName" />
<input type="hidden" id="actionType" name="actionType"/>
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>
<table id="dataTable" jsId="dataTable" cellpadding="0px" cellspacing="0px" style="width:100%;height:100%;">
		<tr id="j_id2" jsId="j_id2">
				
				<td id="j_id4" jsId="j_id4" class="Toolbar"  rowspan="1" style="border-style:none;">
					<script>
					isc.ToolStripButton.create({
							ID:"MToolBarItem3",
							icon:Matrix.getActionIcon("add"),
							prompt: "添加",
							showDisabledIcon:false,
							showDownIcon:false
					 });
					 MToolBarItem3.click=function(){
					 	
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
			 		    		   }</script>
			 		    		
			 		    		 
			 		    		   	<div id="j_id5_div"  style="width:100%;overflow:hidden;"  >
			 		    		   	<script>
			 		    		   	isc.ToolStrip.create({
			 		    		   		ID:"Mj_id5",
			 		    		   		displayId:"j_id5_div",
			 		    		   		width: "100%",
			 		    		   		disabled:true,
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
			 		    		   				MToolBarItem10,
			 		    		   				
			 		    		   				MToolBarItem15
			 		    		   				
			 		    		   		 ] 
			 		    		   });
			 		    		   if(${param.entityType eq 2}){//查询对象
										Mj_id5.removeMember(MToolBarItem15);
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
	 	
			var displayValueMap = {'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'关联对象'};			 	
			isc.MatrixListGrid.create({
					ID:"MDataGrid0",
					name:"DataGrid0",
					canSort:false,
					width:"100%",
					height:"100%",
					displayId:"DataGrid0_div",
					position:"relative",
					canHover:true,
					cellHover:function(record, rowNum, colNum){
						var fieldName = this.getFieldName(colNum);
						if("proEntityUuid"==fieldName){
							return true;
						}else{
							return false;
						}
						
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
						  	title:"编码",
						  	matrixCellId:"j_id11",
						  	name:"mid",
						  	canEdit:true,
						  	width:"10%",
						  	editorType:'Text',
						  	canHide:true,
						  	required:true,
						  	type:'text'
					  },{
						  	title:"名称",
						  	matrixCellId:"j_id12",
						  	name:"name",
						  	width:"10%",
						  	canEdit:true,
						  	editorType:'Text',
						  	canHide:true,
						  	type:'text',
						  	required:true
						  	
					  },
					  
					  {
						  title:"字段",
						  matrixCellId:"j_id13",
						  name:"colName",
						  width:"10%",
						  canEdit:true,
						  editorType:'Text',
						  type:'text',
						  canHide:true
					  },{
					  		title:"类型",
					  		matrixCellId:"j_id14",
					  		name:"type",
					  		canEdit:true,
					  		width:"10%",
					  		editorType:'select',
					  		type:'integer',
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
					  		}
					  		
					  },{
					  		title:"关联对象",
					  		matrixCellId:"j_id558",
					  		name:"proEntityUuid",
					  		canEdit:false,
					  		width:'20%',
					  		editorType:'Text',
					  		type:'text',
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					  		}
					  		//customComponentFunction:"getSelectEntityComponent",
					  		
					  }
					
			  ],
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
			       //初始化时设置Cell是否可编辑
			  		
                   return this.Super("canEditCell", arguments);//默认处理
			  }
			});
			
			if(${param.entityType eq 3}){//基本对象
				MDataGrid0.hideField ('colName');
			}
			
			isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
			isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			
			 
	

 		//设置数据
		MDataGrid0.setData(${requestScope.propertyListJson});
     
		</script>
	</div>
	
	<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
	
	
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

	
	</script>

	</div>
	<script type="text/javascript">
 /******** property  id validate begin*********/
 function propertyIdValidate(item, validator, value, record, dataGrid){
	//空的话返回false
		if(value==null||value.length==0){
			  validator.errorMessage="非空字段!";
			  return false;
			}
	 var hasInput = Matrix.validateLength(1,40, value);
	
	 if(hasInput){
		 var isMatch = value.match(/^[a-z][\w]+$/);
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
			  validator.errorMessage="非空字段!";
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