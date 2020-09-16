<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>业务日历列表</title>
	<jsp:include page="/form/admin/common/taglib.jsp"/>
	<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
	
	//预览业务日历
	function previewCalendar(){
		
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
			var recordList = dataGrid.getSelection();
			var record =null;
			var calendarId = null;
			
			if(recordList==null||recordList.length==0){
				isc.warn('请选择要浏览的业务日历！');
				return false;
			}else if(recordList.length>1){
				isc.warn('每次只能浏览一个的业务日历！');
				return false;
			
			}else if(recordList.length==1){
				record = recordList[0];
				calendarId = record.calendarId;
			    if(calendarId==null||calendarId.trim().length==0){
			    	isc.warn('业务日历编码获取异常！');
					return false;
			    }
			    
				var url= "<%=request.getContextPath()%>/calendar/calendarAction_previewContentOfCalendar.action?fromPlace=list&calendarId="+calendarId;
				document.forms[0].action=url;
				document.forms[0].submit();
				
			}
		
	}
	
	//删除业务日历
	function  deleteCalendars(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordList = dataGrid.getSelection();
		var record =null;
		var calendarId = null;
		
		if(recordList==null||recordList.length==0){
			isc.warn('请选择要删除的业务日历！');
			return false;
		}else{
		    var calendarIds ="";
		   
			var recordListStr = Matrix.itemsToJson(recordList,dataGrid);
			var recordListJson = isc.JSON.decode("["+recordListStr+"]");//获取选中数据
			
			for(var i=0;i<recordListJson.length;i++){
					record = recordListJson[i];
					calendarId = record.calendarId;
	    		    
	    		    if(calendarIds!=""){
	    		       calendarIds = calendarIds + ",";
	    		    }
					calendarIds = calendarIds +calendarId;
			}
			
			//calendarIds
			if(calendarIds==""){
				isc.warn("请选择要删除的业务日历！");
	    		return false;
			}
			
			isc.confirm('确定要删除选择的业务日历吗？',function(data){//true or null
		      if(data){
		        
		      	 var url = "<%=request.getContextPath()%>/calendar/calendarAction_deleteBusinessCalendar.action?calendarIds="+calendarIds;
				 document.getElementById("Form0").action = url;
				 Matrix.send("Form0");
		      }
                                    		 
        });
		
		}
	}
	
	
	
	//创建业务日历
	function createBusinessCalen(){
		var src = "<%=request.getContextPath()%>/calendar/calendarAction_loadCalendarSavePage.action?operationType=add";
		MDialog0.initSrc = src;
		MDialog0.operationType = "add";
		Matrix.showWindow('Dialog0');
	}
	
	//双击 实现更新业务日历
	function updateBusinessValen(calendarId){
		if(calendarId==null){
			return false;
		}
		
		var src = "<%=request.getContextPath()%>/calendar/calendarAction_loadCalendarSavePage.action?operationType=update&calendarId="+calendarId;
		MDialog0.initSrc = src;
		MDialog0.operationType = "update";
		Matrix.showWindow('Dialog0');
	
	}
	
	
	//add or update dialog callback
	function onDialog0Close(data, oType){
		if(data!=null){
			var operationType = data.operationType;
			var calendarId = data.calendarId;
			var url;
			if(operationType=="add"){//添加
			    url = "<%=request.getContextPath()%>/calendar/calendarAction_createBusinessCalendar.action";
			}else if(operationType=="update"){//更新
				if(calendarId==null||calendarId.trim().length==0){
					return false;
				}
				url = "<%=request.getContextPath()%>/calendar/calendarAction_updateBusinessCalendar.action";
				
			}
			url = url+"?dataGridId=DataGrid0";
		
			dataSend(data, url,"POST");
			//url=url+"?calendarId="+data.calendarId+"&calendarName="+data.calendarName+"&description="+data.description;
			//document.getElementById("Form0").action= url;
			//Matrix.send("Form0");
		
		}
	
	
		return true;
	}
	
	//查看内容
	function calendarContent(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordList = dataGrid.getSelection();
		var record =null;
		var calendarId = null;
		
		if(recordList==null||recordList.length==0){
			isc.warn('请选择要查看的业务日历！');
			return false;
		}else if(recordList.length>1){
			isc.warn('每次只能查看一个的业务日历！');
			return false;
		
		}else if(recordList.length==1){
			record = recordList[0];
			calendarId = record.calendarId;
		    if(calendarId==null||calendarId.trim().length==0){
		    	isc.warn('业务日历编码获取异常！');
				return false;
		    }
			var url= "<%=request.getContextPath()%>/calendar/calendarAction_loadDetailMain.action?calendarId="+calendarId;
			MDialogContent.initSrc = url;
			Matrix.showWindow('DialogContent');
		}
	
	}
	
	</script>
	
	<style type="text/css">
	body {
   		margin: 0px;
	}
	
	</style>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"Form0",
	 		position:"absolute",
	 				
	 		action:"<%=request.getContextPath()%>/calendar/calendarAction_getBusinessCalendars.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
	  action="<%=request.getContextPath()%>/calendar/calendarAction_getBusinessCalendars.action" 
	  style="margin:0px;overflow:auto;height:100%;" 
	  enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
<input type="hidden" name="calendarIds" id="calendarIds"/>

<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
			style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>

<table class="query_form_content" style="overflow:auto;width:100%;height:100%;">
	<tr id="tr111" name="tr111">
            <td id="td111" style="width:100%;height:30px;padding-top:5px;vertical-align:bottom;border:0 " name="td111" styleClass="tdLayout">
              <image id="image001" style="width:40px;height:30px;display:inline-block;vertical-align:top;margin-right:8px;padding-left:5px" name="image001" src="<%=request.getContextPath()%>/resource/images/collaborationthemespace.png" imageType="stretch"/>
              <span id="label011" style="font-size:13px;vertical-align:bottom; " name="label011"/>基础配置&gt;业务日历管理</span>
            </td>
          </tr>
	<tr id="j_id2" jsId="j_id2">
					
					<td id="j_id4" jsId="j_id4" height="25px"   class="query_form_label"  style="text-align:left;height:25px;">
					业务日历列表：	
				    </td>
						
   </tr>
   <!-- 数据表格 -->
   <tr id="j_id7" jsId="j_id7">
				
		<td id="j_id9" jsId="j_id9"  style="border-style:none;vertical-align:top;">
			  <div id="DataGrid0_div" class="matrixComponentDiv" style="width:100%;">
			<script>
		 	
							 	
				isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:true,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
						showAllRecords:true,
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
	                       updateBusinessValen(record.calendarId);
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
						   {title:'编码',name:'calendarId'}
						   ,
						   {title:'名称',width:'20%',name:'calendarName'}
						   ,
						   {title:'描述',width:'15%',name:'description'}
						  
						
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
				
				MDataGrid0.setData(${requestScope.calendarsJson});
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
	     
	
	
			</script>
		</div>
		<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
		
		
		</td>
	</tr>
	
                                    
	<tr id="j_id35" jsId="j_id35">
         <td id="j_id36" jsId="j_id36" class="Toolbar" align="center" height="25px" 
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
                                     		createBusinessCalen();
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton1_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton1",
                                            name: "CommandButton1",
                                            title: "内容",
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
                                            calendarContent();//查看
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton2_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton2",
                                            name: "CommandButton2",
                                            title: "浏览",
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
                                            previewCalendar();//终止操作 支持多选
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton3_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton3",
                                            name: "CommandButton3",
                                            title: "删除",
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
                                     		deleteCalendars();//删除流程实例
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
		height: "60%",
		width: "60%",
		title: "添加业务日历",
		canDragReposition: true,
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
		height: "80%",
		width: "80%",
		title: "业务日历详细",
		canDragReposition: true,
		showMinimizeButton:false,
		showMaximizeButton:true,
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
</body>
</html>