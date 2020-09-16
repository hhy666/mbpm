<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>流程实例列表</title>
	<jsp:include page="/form/admin/common/taglib.jsp"/>
	<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
	var formDefaultAction = "<%=request.getContextPath()%>/process/ruleAction_queryRules.action";
	//提交查询
	function submitQueryByPage(){
	    Matrix.queryDataGridData('DataGrid0');
		Matrix.send("Form0");
	}	
	//重置查询框
	function resetQueryInput(){
		Mquery_rule_desc.clearValue();
		Mquery_rule_name.clearValue();
	}
	
	//添加规则
	function addRule(){
		var src = "<%=request.getContextPath()%>/process/ruleAction_loadcreateRulePage.action?processId=${param.processId}&operationType=add";
		MDialog0.initSrc = src;
		MDialog0.setTitle("添加规则");
		MDialog0.operationType = "add";
		Matrix.showWindow('Dialog0');
	
	}
	
	//更新规则
	function getUpdateRule(ruleId){
		if(ruleId==null){
			return false;
		}
		
		var src = "<%=request.getContextPath()%>/process/ruleAction_getRule.action?processId=${param.processId}&operationType=update&ruleId="+ruleId;
		MDialog0.initSrc = src;
		MDialog0.setTitle("更新规则");
		MDialog0.operationType = "update";
		Matrix.showWindow('Dialog0');
		
	}
	
	//弹出框 
	function onDialog0Close(data, oType){
		if(data!=null){
		    //设置当前数据表格id
		    data.dataGridId = document.getElementById("dataGridId").value;
			var operationType = MDialog0.operationType;
			var url;
			var processId = data.processId;
			if(operationType=="add"){//添加
				
				if(processId=null||processId.trim().length==0){
					isc.warn('数据获取异常,添加失败！');
					return true;
				}
				
			    url = "<%=request.getContextPath()%>/process/ruleAction_createRule.action";
			}else if(operationType=="update"){//更新
				var ruleId = data.ruleId;
				
				if(ruleId==null||ruleId.trim().length==0){
					isc.warn('数据获取异常,更新失败！');
					return true;
				}
				if(processId==null||processId.trim().length==0){
					isc.warn('数据获取异常,更新失败！');
					return true;
				}
				
				url = "<%=request.getContextPath()%>/process/ruleAction_updateRule.action";
				
			}
			
			dataSend(data,url,"POST");
		}
	
		MDialog0.operationType = null;
		return true;
	}
	
	
	//删除规则
	function  deleteRules(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		var recordList = dataGrid.getSelection();
		var record =null;
		var ruleId = null;
		
		if(recordList==null||recordList.length==0){
			isc.warn('请选择要删除的规则！');
			return false;
		}else{
		    var deleteIds ="";
		   
			var recordListStr = Matrix.itemsToJson(recordList,dataGrid);
			var recordListJson = isc.JSON.decode("["+recordListStr+"]");//获取选中数据
			
			for(var i=0;i<recordListJson.length;i++){
					record = recordListJson[i];
					ruleId = record.ruleId;
	    		    
	    		    if(deleteIds!=""){
	    		       deleteIds = deleteIds + ",";
	    		    }
					deleteIds = deleteIds +ruleId;
			}
			
			//deleteIds
			if(deleteIds==""){
				isc.warn("请选择要删除的规则！");
	    		return false;
			}
			
		    var url = "<%=request.getContextPath()%>/process/ruleAction_deleteRule.action";
			var dataGridId = document.getElementById('dataGridId').value;
			var sendData = {'deleteIds':deleteIds,'dataGridId':dataGridId};
			//异步请求
			dataSend(sendData,url,"POST");
		
		}
	}
	
	
	
	
	//自定义显示 操作栏 生成超链接
	function operationCustomFunc(value, record, rowNum, colNum,grid){
	    
	    return "<A href=\"javascript:editRuleContent('"+record.ruleId+"',"+record.M_TYPE+",'"+record.processId+"');\">"+record.operation+"</A>";
		
    }
    
    function editRuleContent(ruleId,ruleType,pdid){
    	if(false){
			var width1 =  window.screen.availWidth;
		var height = window.screen.availHeight;
  		window.open('denglu.html','newwindow','top=0,left=0, width='+width1+', height='+height+', toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
  		window.opener=null;
  		window.close(true);
			return;
		}
		
		var title = "编辑规则项";
		var serverIp = parent.serverIp;
		var contextPath = parent.contextPath;
		var serverPort = parent.serverPort;
		var sessionId = parent.sessionId;
		var matrixUserId = parent.userId;
		var params = "sessionId="+sessionId+"&serverIp="+serverIp+"&serverPort="+serverPort+"&contextPath="+contextPath+"&ruleId=" + ruleId +"&ruleType=" + ruleType + "&pdid=" + pdid+"&userId="+matrixUserId;
		var url = "<%=request.getContextPath()%>/form/admin/process/flex/MatrixRule.jsp?"+params;
		var iHeight = 420;
		var iWidth = 620;
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  		var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
  		var property = "toolbar=no, menubar=no, scrollbars=yes, resizable=false,location=no, status=no, width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop;
		
		window.open(url, title, property);
    
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
	 				
	 		action:"<%=request.getContextPath()%>/process/ruleAction_queryRules.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
			 
	  action="<%=request.getContextPath()%>/process/ruleAction_queryRules.action" style="margin:0px;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
<input type="hidden" name="processId" id="processId" value="${requestScope.processId}" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
			style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>

<table class="query_form_content" style="width:100%;height:100%;">
	<tr>
		<td style="height:100px;" colspan="2">
			<table id="j_id5" jsId="j_id5" class="query_form_content">
			    <tr id="j_id6" jsId="j_id6" style="">
			        <td id="j_id7" jsId="j_id7" class="query_form_label" colspan="1" rowspan="1" style="width:120px">
			            <label id="j_id8" name="j_id8" >
			                名称：
			            </label>
			        </td>
			        <td id="j_id9" jsId="j_id9" class="query_form_input" colspan="1" rowspan="1">
			            <div id="query_rule_name_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var query_rule_name = isc.TextItem.create({
			                    ID: "Mquery_rule_name",
			                    name: "query_rule_name",
			                    editorType: "TextItem",
			                    displayId: "query_rule_name_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: 290
			                });
			                MForm0.addField(query_rule_name);
			            </script>
			        </td>
			        <td id="j_id11" jsId="j_id11" class="query_form_label" colspan="1" rowspan="1" style="width:120px">
			            <label id="j_id12" name="j_id12">
			               描述：
			            </label>
			        </td>
			        <td id="j_id13" jsId="j_id13" class="query_form_input" colspan="1" rowspan="1">
			            <div id="query_rule_desc_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var query_rule_desc = isc.TextItem.create({
			                    ID: "Mquery_rule_desc",
			                    name: "query_rule_desc",
			                    editorType: "TextItem",
			                    displayId: "query_rule_desc_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: 290
			                });
			                MForm0.addField(query_rule_desc);
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
			                        submitQueryByPage();
			                        
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
   <!-- 数据表格 -->
   <tr id="j_id7" jsId="j_id7">
				
		<td id="j_id9" jsId="j_id9"  rowspan="1" colspan="2" style="border-style:none;">
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
	                        getUpdateRule(record.ruleId);//双击实现修改
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
						   {title:'名称',name:'M_NAME'}
						   ,
						   {title:'规则类型',width:'25%',name:'M_TYPE',
						    valueMap:{'1':'表达式','2':'自定义求值'}}
						   ,
						   {title:'描述',width:'30%',name:'M_DESC'}
						   ,
						   {title:'操作',width:'20%',name:'operation',canSort:false,
						   
							formatCellValue:function(value, record, rowNum, colNum,grid){
									return operationCustomFunc(value, record, rowNum, colNum,grid);
							}
							
							}
						   ,
						  
						   {title:'模板ID',name:'processId',hidden:true},
						   {title:'规则编码',name:'ruleId',hidden:true}
						     
						     
						  
					 
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
				
				MDataGrid0.setData(${requestScope.insListData});
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
	     
	
	
			</script>
		</div>
		<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows" type="hidden" />
		
		
		</td>
	</tr>
	
	<tr id="j_id40" jsId="j_id40">
                                        <td class="toolStrip"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;"><span
			id="DataPaginator0" class="paginator"><span
			id="DataPaginator0:status" class="paginator_status"></span></span> <script>
                                                isc.Page.setEvent("load", "Matrix.fillDataPaginator('DataPaginator0',${requestScope.curPageNum},${requestScope.totalPageNum},${requestScope.pageSize},'DataGrid0',${requestScope.totalSize})", isc.Page.FIRE_ONCE);
                                            </script>
                                        </td>
                                         <td class="toolStrip" align="right"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align: right; margin: 0px; padding: 0px;"><span
			id="DataPaginator1" class="paginator"><span
			id="DataPaginator1:first" class="paginator_first"><img
			id="DataPaginator1_fI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/first.gif"
			border="0" /></span><span id="DataPaginator1:previous"
			class="paginator_previous"><img id="DataPaginator1_pI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/pre.gif"
			border="0" /></span><span class='paginator_separator'><img
			src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
			border="0" /></span><span id="DataPaginator1:go" class="paginator_go"><span
			class="go_prefix">第</span><span id="DataPaginator1:goText"
			class="paginator_go_text"></span><span class="go_suffix">页</span></span><span
			class='paginator_separator'><img
			src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
			border="0" /></span><span id="DataPaginator1:next" class="paginator_next"><img
			id="DataPaginator1_nI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/next.gif"
			border="0" /></span><span id="DataPaginator1:last" class="paginator_last"><img
			id="DataPaginator1_lI"
			src="<%=request.getContextPath()%>/matrix/resource/images/paginator/last.gif"
			border="0" /></span><span class="paginator_clean"></span><span
			class='paginator_separator'><img
			src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png"
			border="0" /></span><span id="DataPaginator1:refresh"
			class="paginator_refresh"></span><span>&nbsp;&nbsp;</span> </span> <script>
                                             isc.Page.setEvent("load", "Matrix.fillDataPaginator('DataPaginator1',${requestScope.curPageNum},${requestScope.totalPageNum},${requestScope.pageSize},'DataGrid0',${requestScope.totalSize})", isc.Page.FIRE_ONCE);
                                            </script>
                                        </td>
                 </tr>
	
                                    
					<tr id="j_id35" jsId="j_id35">
                            	<td id="j_id36" jsId="j_id36" class="Toolbar" colspan="2" rowspan="1" align="center"
                           	 	style="border-style:none;height:25px;" height="25px">
                           			 <div id="CommandButton0_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton0",
                                            name: "CommandButton0",
                                            title: "添加",
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
                                     
                                            if (!MForm0.validate()) {
                                                Matrix.hideMask();
                                                return false;
                                            }
                                            addRule();//添加规则
                                            Matrix.hideMask();
                                        };
                                    </script>
                                </div>
                                <div id="CommandButton1_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                    <script>
                                        isc.Button.create({
                                            ID: "MCommandButton1",
                                            name: "CommandButton1",
                                            title: "删除",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton1_div",
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
                                        MCommandButton1.click = function() {
                                            Matrix.showMask();
                                     
                                            if (!MForm0.validate()) {
                                                Matrix.hideMask();
                                                return false;
                                            }
                                            deleteRules();
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
	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		autoCenter: true,
		position:"absolute",
		height: "300",
		width: "450",
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
	MDialog0.hide();
	

</script>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
</body>
</html>