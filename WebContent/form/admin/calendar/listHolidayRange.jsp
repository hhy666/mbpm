<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>公共假日列表</title>
	<jsp:include page="/form/admin/common/taglib.jsp"/>
	<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
	
	
	
	//删除公共假日
	function  deleteHolidayRanges(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordList = dataGrid.getSelection();
		var record =null;
		var holidayRangeId = null;
		
		if(recordList==null||recordList.length==0){
			isc.warn('请选择要删除的公共假日！');
			return false;
		}else{
		    var deleteIds ="";
		   
			var recordListStr = Matrix.itemsToJson(recordList,dataGrid);
			var recordListJson = isc.JSON.decode("["+recordListStr+"]");//获取选中数据
			
			for(var i=0;i<recordListJson.length;i++){
					record = recordListJson[i];
					holidayRangeId = record.holidayRangeId;
	    		    
	    		    if(deleteIds!=""){
	    		       deleteIds = deleteIds + ",";
	    		    }
					deleteIds = deleteIds +holidayRangeId;
			}
			
			//deleteIds
			if(deleteIds==""){
				isc.warn("请选择要删除的公共假日！");
	    		return false;
			}
			
		    var url = "<%=request.getContextPath()%>/calendar/calendarAction_deleteHolidayRange.action";
			var dataGridId = document.getElementById('dataGridId').value;
			var calendarId = document.getElementById('calendarId').value;
			var sendData = {'deleteIds':deleteIds,'dataGridId':dataGridId,'calendarId':calendarId};
			//异步请求
			dataSend(sendData,url,"POST");
		
		}
	}
	
	
	
	
	//创建公共假日
	function createBusydayOfDate(){
		var src = "<%=request.getContextPath()%>/calendar/calendarAction_loadSaveHolidayRange.action?operationType=add";
		MDialog0.initSrc = src;
		MDialog0.setTitle("添加公共假日");
		MDialog0.operationType = "add";
		Matrix.showWindow('Dialog0');
		
	}
	
	//双击 实现更新业务日历
	function updateHolidayRange(holidayRangeId){
		if(holidayRangeId==null){
			return false;
		}
		
		var src = "<%=request.getContextPath()%>/calendar/calendarAction_getHolidayRange.action?holidayRangeId="+holidayRangeId+"&operationType=update";
		MDialog0.initSrc = src;
		MDialog0.setTitle("更新公共假日");
		MDialog0.operationType = "update";
		Matrix.showWindow('Dialog0');
		
	
	}
	//通过按钮实现更新
	function updateHolidayRangeByButton(){
		 var dataGrid = Matrix.getMatrixComponentById('DataGrid0');
		 var recordList = dataGrid.getSelection();
		 
		 if(recordList==null||recordList.length==0){
			parent.isc.warn('请选择要更新的公共假日！');
			return false;
		 }else if(recordList.length==1){
		 	updateHolidayRange(recordList[0].holidayRangeId);
		 
		 }else{
			 parent.isc.warn("每次只能更新一个公共假日！");
		 }
	
	} 
	
   
	
	//add or update dialog callback
	function onDialog0Close(data, oType){
	    
		if(data!=null){
		    //设置当前数据表格id
		    data.dataGridId = document.getElementById("dataGridId").value;
			var operationType = MDialog0.operationType;
			var url;
			if(operationType=="add"){//添加
				var newCalendarId = "${param.calendarId}";
				
				if(newCalendarId=null||newCalendarId.trim().length==0){
					isc.warn('数据获取异常,添加失败！');
					return true;
				}
				data.calendarId = "${param.calendarId}";
			    url = "<%=request.getContextPath()%>/calendar/calendarAction_createHolidayRange.action";
			}else if(operationType=="update"){//更新
				var calendarId = data.calendarId;
				var holidayRangeId = data.holidayRangeId;
				
				if(holidayRangeId==null||holidayRangeId.trim().length==0){
					isc.warn('数据获取异常,更新失败！');
					return true;
				}
				if(calendarId==null||calendarId.trim().length==0){
					isc.warn('数据获取异常,更新失败！');
					return true;
				}
				
				url = "<%=request.getContextPath()%>/calendar/calendarAction_updateHolidayRange.action";
				
			}
			
			dataSend(data,url,"POST");
		}
	
		MDialog0.operationType = null;
		return true;
	}
	
	</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"Form0",
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
	  action="" 
	  style="margin:0px;overflow:auto;width:100%;height:100%;" 
	  enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
<input type="hidden" name="calendarId" id="calendarId" value="${param.calendarId}"/>

<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
			style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>

<table class="query_form_content" style="width:100%;height:100%;margin:0px;padding:0px;">
	
	<tr id="j_id2" jsId="j_id2">
					
		<td id="j_id4" jsId="j_id4"  class="query_form_label"  style="text-align:left;">
					公共假日列表:
		</td>
						
   </tr>
   
   <!-- 数据表格 -->
   <tr id="j_id7" jsId="j_id7">
				
		<td id="j_id9" jsId="j_id9"  style="border-style:none;width:100%;">
		
			  <div id="DataGrid0_div" class="matrixComponentDiv" style="width:100%;height:90%;">
			<script>
		 	
							 	
				isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:false,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
						showAllRecords:true,
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
	                       updateHolidayRange(record.holidayRangeId);
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
						  
						   {title:'开始日期',name:'fromDate'}
						   ,
						   {title:'结束日期',name:'toDate'},
						   {title:'工作日编码',name:'holidayRangeId',hidden:true},
						   
						   {title:'业务日历编码',name:'calendarId',hidden:true}
						  
						
					 ],
				  //设置UI组件和扩展组件关联关系
				  
				  autoSaveEdits:false,
				  autoFetchData:true,
				  alternateRecordStyles:true,
				  showDefaultContextMenu:false,
				  canAutoFitFields:false,
				  startLineNumber:1,
				  canEdit:false,
				  selectionType: "multiple",
	              canDragSelect: true,
	              editEvent: "click",
				  showRecordComponents:true,
				  showRecordComponentsByCell:true,
				  canEditCell2:function(rowNum, colNum){
	                   return this.Super("canEditCell", arguments);//默认处理
				  } 
				});
				
				MDataGrid0.setData(${requestScope.holidayRangeList});
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
			</script>
		</div>
		<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
		
		
		</td>
	</tr>
	
                                    
	<tr id="j_id35" jsId="j_id35">
         <td id="j_id36" jsId="j_id36" class="Toolbar" align="center"
                          style="border-style:none;height:25px;">
            <div id="CommandButton0_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton0",
                                            name: "CommandButton0",
                                            title: "创建",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton0_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("add"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton0.click = function() {
                                            Matrix.showMask();
                                     		createBusydayOfDate();
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton1_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton1",
                                            name: "CommandButton1",
                                            title: "修改",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton1_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("copy"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton1.click = function() {
                                            Matrix.showMask();
                                     
                                            if (!MForm0.validate()) {
                                                Matrix.hideMask();
                                                return false;
                                            }
                                           
                                            
                                            updateHolidayRangeByButton();
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton2_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton2",
                                            name: "CommandButton2",
                                            title: "删除",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton2_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("copy"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton2.click = function() {
                                            Matrix.showMask();
                                            deleteHolidayRanges();//删除特殊工作日
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton3_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton3",
                                            name: "CommandButton3",
                                            title: "关闭",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton3_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("delete"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton3.click = function() {
                                            Matrix.showMask();
                                     		parent.Matrix.closeWindow();
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                            </td>
                        </tr>
						<tr><td style="height:5px"></td></tr>

</table>

</form>
<script type="text/javascript">
	//添加业务日历
	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "450",
		title: "添加节假日",
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
	MDialog0.hide();
	
	//内容
	isc.Window.create({
		ID:"MDialogContent",
		id:"DialogContent",
		name:"DialogContent",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "400",
		title: "",
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
	MDialogContent.hide();
	

</script>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
</body>
</html>


