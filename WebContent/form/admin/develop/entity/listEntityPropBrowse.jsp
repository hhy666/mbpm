<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>实体属性维护2</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
		
		
        
        
	</script>
</head>
<body style="padding:5px;">
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


<!-- commom cols -->

<input type="hidden" id="mid" name="mid" value="${param.mid}">
<input type="hidden" id="gridListId" name="gridListId" />
<input type="hidden" id="actionType" name="actionType"/>
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
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
			 		    		ID:"MToolBarItem12",
			 		    		icon:Matrix.getActionIcon("import_db"),
			 		    		prompt: "载入",
			 		    		showDisabledIcon:false,
			 		    		showDownIcon:false
			 		    		 });
			 		    		 MToolBarItem12.click=function(){
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
			 		    	}</script>
			 		    		  
			 		    		 
			 		    		   	<div id="j_id5_div"  style="width:100%;overflow:hidden;"  >
			 		    		   	<script>
			 		    		   	isc.ToolStrip.create({
			 		    		   		ID:"Mj_id5",
			 		    		   		displayId:"j_id5_div",
			 		    		   		width: "100%",
			 		    		   		disabled:true,
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
			 		    		   				MToolBarItem10,
			 		    		   				"separator",
			 		    		   				"MToolBarItem12",
			 		    		   				"MToolBarItem11",
			 		    		   				"MToolBarItem15"
			 		    		   				
			 		    		   		 ] });
			 		    		   		
			 		    		   		 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
			 		    		   		</script>
			 		    		   		</div>
			 		  </td>
					
		</tr>
		<tr id="j_id7" jsId="j_id7">
			
				<td id="j_id9" jsId="j_id9"  rowspan="1" style="border-style:none;width:100%;height:100%">
					<div id="DataGrid0_div" class="matrixComponentDiv" style="position:relative;width:100%;height:100%;">
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
					showAllRecords:true,
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
						  	
						  	editorType:'Text',
						  	canHide:true,
						  	required:true,
						  	type:'text'
					  },{
						  	title:"名称",
						  	matrixCellId:"j_id12",
						  	name:"name",
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
					  		width:'18%',
					  		editorType:'Text',
					  		type:'text',
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
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
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					  		}
								
					  },{
					  		title:"精度",
					  		matrixCellId:"j_id24",
					  		name:"precision",
					  		canEdit:true,
					  		width:'10%',
					  		editorType:'Text',
					  		type:'integer',
					  		formatCellValue:function(value, record, rowNum, colNum,grid){
					  			return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
					  		}
							
				      		 
					  },{
					  		title:"主键",
					  		matrixCellId:"j_id25",
					  		name:"isKey",
					  		canEdit:true,
					  		width:40,
					  		editorType:'Checkbox',
					  		type:'boolean',
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
					  		type:'boolean'
					  		
					  },{
					  		title:"实体字段",
					  		matrixCellId:"j_id32",
					  		name:"isCol",
					  		canEdit:true,
					  		width:"6%",
					  		editorType:'Checkbox',
					  		type:'boolean'
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
			  showRecordComponentsByCell:true
			});
			
			
			isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
			isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			
	
		//设置数据
		MDataGrid0.setData(${requestScope.propertyListJson});
		
     
		</script>
	</div>
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

	

	</div>


</body>
</html>