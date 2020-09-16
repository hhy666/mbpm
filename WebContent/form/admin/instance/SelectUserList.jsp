

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户列表</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">

 

	//提交查询
	function submitQueryButton(){
	    Matrix.queryDataGridData('DataGrid0');
		Matrix.send("Form0");
	}

	//重置查询输入框
	function  resetQueryInput(){
		MqueryID.clearValue();
		MqueryName.clearValue();
	 	
	}	
   function submitByButton(){
     	//1.首先判断是否选中节点
     	 
	    var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var record = dataGrid.getSelectedRecord();
		if(record!=null){
	    	Matrix.closeWindow(record);
	    }else{
	      isc.say("请选择用户!",{width:150,height:70});
	    }
     
     }
     
</script>
</head>

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto;">
<script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
	  action="<%=request.getContextPath()%>/instance/activityInsAction_queryUsers.action" 
	  style="margin:0px;overflow:auto;width:100%;height:100%;"
	   enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="aiid" id="aiid" value="${param.aiid}" />
	<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
	<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
    
<table id="table0css" jsId="table0css" class="maintain_form_content"
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
	
	<tr>
		<td style="height:60px;" colspan="2" >
			<table id="j_id5" jsId="j_id5" class="query_form_content" >
			
			   
			    <tr id="j_id6" jsId="j_id6" style="">
			        <td id="j_id7" jsId="j_id7" class="query_form_label"  style="width:20%;" colspan="1" rowspan="1">
			            <label id="j_id8" name="j_id8">
			                编码：
			            </label>
			        </td>
			        <td id="j_id9" jsId="j_id9" class="query_form_input" colspan="1" rowspan="1">
			            <div id="queryActPIID_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var queryID = isc.TextItem.create({
			                    ID: "MqueryID",
			                    name: "queryID",
			                    editorType: "TextItem",
			                    displayId: "queryActPIID_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: 120
			                });
			                MForm0.addField(queryID);
			            </script>
			        </td>
			        <td id="j_id11" jsId="j_id11" class="query_form_label" style="width:20%;" colspan="1" rowspan="1">
			            <label id="j_id12" name="j_id12">
			               	名称：
			            </label>
			        </td>
			        <td id="j_id13" jsId="j_id13" class="query_form_input" colspan="1" rowspan="1">
			            <div id="queryActAIID_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var queryName = isc.TextItem.create({
			                    ID: "MqueryName",
			                    name: "queryName",
			                    editorType: "TextItem",
			                    displayId: "queryActAIID_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: 120
			                });
			                MForm0.addField(queryName);
			            </script>
			        </td>
			    </tr>
			 <tr id="j_id15" jsId="j_id15">
			        <td id="j_id16" jsId="j_id16" class="query_form_command" colspan="4" rowspan="1">
			            <div id="j_id17_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
			                <script>
			                    isc.Button.create({
			                        ID: "Mj_id17",
			                        name: "j_id17",
			                        title: "查询",
			                        panelID: "Mj_id2",
			                        displayId: "j_id17_div",
			                        position: "absolute",
			                        top: 0,
			                        left: 0,
			                        width: "100%",
			                        height: "100%",
			                        icon: Matrix.getActionIcon("query"),
			                        showDisabledIcon: false,
			                        showDownIcon: false,
			                        showRollOverIcon: false
			                    });
			                    Mj_id17.click = function() {
			                        Matrix.showMask();
			                       
			                        if(!MForm0.validate()) {
			                            Matrix.hideMask();
			                            return false;
			                        }
			                        submitQueryButton();
			                        
			                        Matrix.hideMask();
			                    };
			                </script>
			            </div>
			            <div id="j_id18_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
			                <script>
			                    isc.Button.create({
			                        ID: "Mj_id18",
			                        name: "j_id18",
			                        title: "重置",
			                        panelID: "Mj_id2",
			                        displayId: "j_id18_div",
			                        position: "absolute",
			                        top: 0,
			                        left: 0,
			                        width: "100%",
			                        height: "100%",
			                        icon: Matrix.getActionIcon("exit"),
			                        showDisabledIcon: false,
			                        showDownIcon: false,
			                        showRollOverIcon: false
			                    });
			                    Mj_id18.click = function() {
			                        Matrix.showMask();
			                        resetQueryInput();
			                        Matrix.hideMask();
			                    };
			                </script>
			            </div>
			        </td>
			    </tr>
			</table>
		
		
		</td>
	</tr>
			    	
			    	
	<tr id="j_id5" jsId="j_id5">
		
		<td id="td13874300245170" jsId="td13874300245170" style="height:100%"
			class="maintain_form_input" rowspan="1" style="vertical-align:top" colspan="2">
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
	                        viewDetail(record.PROCESS_INS_ID);
	                     },
						fields:[
												   
						   {title:'编码',name:'id',width:'50%'}
						   ,
						   {title:'名称',name:'name',width:'50%'}
						   
					 
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
	              canDragSelect: false,
	              editEvent: "click",
				  showRecordComponents:true,
				  showRecordComponentsByCell:true,
				  canEditCell2:function(rowNum, colNum){
	                   return this.Super("canEditCell", arguments);//默认处理
				  } 
				});
				if("${requestScope.tasksJson}".length>0){
					MDataGrid0.setData(${requestScope.tasksJson});
				}
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
	     
	
			</script>
		</div>
	
		</td>
	</tr>
	
	<tr id="j_id9" jsId="j_id9" height="20px">
		<td id="j_id10" jsId="j_id10" class="maintain_form_input" 
			rowspan="1"  colspan="2"> <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem0",
                                    icon:Matrix.getActionIcon("copy"),
                                    title: "确认",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem0.click = function() {
                                    Matrix.showMask();
                                   submitByButton();
                                    Matrix.hideMask();
                                }
                                
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem4",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "关闭",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem4.click = function() {
                                    Matrix.showMask();
                                    Matrix.closeWindow(null,0);
                                    Matrix.hideMask();
                                }
                            </script>
                            
		<div id="ToolBar0_div" style="width: 100%; overflow: hidden;"><script>
                                    isc.ToolStrip.create({
                                        ID: "MToolBar0",
                                        displayId: "ToolBar0_div",
                                        width: "100%",
                                        height: "*",
                                        position: "relative",
                                        align: "center",
                                         members: [MToolBarItem0,MToolBarItem4]
                                    });
                                    isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                </script></div>
		</td>
	</tr>
</table>
	
	</form>
<script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script></div>
 
</body>

</html>
</span>


