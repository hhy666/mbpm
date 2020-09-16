<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                实体表导入
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <style type="text/css">
            	.str{
            		border-collapse: collapse;
            		border-spacing: 0px;
            		border:1px solid #cccccc;
            	}
            
            
            </style>
            <script type="text/javascript">
              //查询表
	          function queryTables(){
	          	var tableNameFilter = MtableNameFilter.getValue();
	          	if(tableNameFilter==null){
	          		tableNameFilter ="";
	          	}
	          
	            var dsName = document.getElementById("dsName").value;
	            var schemaName = document.getElementById("schemaName").value;
	          	var url="<%=request.getContextPath()%>/entity/importEntity_queryTableList.action?dsName="+dsName+"&schemaName="+schemaName;
	          	var data={'tableNameFilter':tableNameFilter};
	          	dataSend(data,url,"POST");
	          }
	          
	          //去前缀选中时处理
	          function selectRemoveprefixNames(){
	          	MprefixNames.setDisabled(false);   
	          
	          }
	          
	           //去前缀未选中时处理
	          function unSelectRemoveprefixNames(){
	          	MprefixNames.clearValue();
	          	MprefixNames.setDisabled(true);  
	          
	          }
	          
	          //去分隔符 选中时处理
	          function selectRemoveDelimiter(){
	          	Mdelimiter.setDisabled(false);
	          
	          }
                
              //去分隔符 未选中时处理
	          function unSelectRemoveDelimiter(){
	              Mdelimiter.clearValue();
	              Mdelimiter.setDisabled(true);
	          
	          }
	          
	          //添加选中的记录到目标列表
	          function addSelected2Target(){
	          	var records = MDataGrid0.getSelection();
	          	if(records!=null&&records.length>0){
	          		//追加到目标列表
	          		MDataGrid1.getData().addAll(records);
	          		//从源列表移除选中数据
	          		MDataGrid0.removeSelectedData(); 
	          	
	          	}else{
	          		isc.warn("请选择要导入的表!");
	          	}
	          
	          }
	          
	          //添加所有记录到目标列表
	          function addAll2Target(){
	            // 源数据
	          	var srcData = MDataGrid0.getData();
	          	if(srcData!=null){
	          	   
	          	   MDataGrid1.getData().addAll(srcData);
	          	   MDataGrid1.deselectAllRecords ();
	          	   MDataGrid0.getData().splice(0,srcData.length);
	          	   MDataGrid0.deselectAllRecords ();
	          	   MDataGrid0.refreshFields();
	          	   
	          	}
	          }
	          
	          
	          //去除选中的到源列表
	          function removeSelected2Src(){
	          var records = MDataGrid1.getSelection();
	          	if(records!=null&&records.length>0){
	          		//追加到目标列表
	          		MDataGrid0.getData().addAll(records);
	          		//从源列表移除选中数据
	          		MDataGrid1.removeSelectedData(); 
	          	
	          	}else{
	          		isc.warn("请选择要除去的表!");
	          	}
	          }
	          
	           //去除选中的到源列表
	          function removeAll2Src(){
	           // 目标数据
	          	var srcData = MDataGrid1.getData();
	          	if(srcData!=null){
	          	   MDataGrid0.getData().addAll(srcData);
	               MDataGrid0.deselectAllRecords ();
	          		
	          	   MDataGrid1.getData().splice(0,srcData.length);
	          	   MDataGrid1.deselectAllRecords ();
	          	   MDataGrid1.refreshFields();
	          	}
	          }
	          
	          //完成操作 
	          function submitSelectTables(){
	          		var selectedData = MDataGrid1.getData();
	          		
	          		if(selectedData!=null){
	          			
	          			var selectedDataStr = "["+Matrix.itemsToJson(selectedData,MDataGrid1)+"]";
		          		document.getElementById("selectedTableData").value = selectedDataStr;
	          		
	          		}
	           		
               		document.getElementById('Form0').action="<%=request.getContextPath()%>/entity/importEntity_saveSelectedtables.action";
               		document.getElementById('Form0').submit();
	          }
	          
	          //提交选择的数据
	          function submitSelectTables1(){
	          	var selectTableStr = "["+Matrix.itemsToJson(MDataGrid1.getData(),MDataGrid1)+"]";
	          	var seTableArray = isc.JSON.decode(selectTableStr);
	          	var parentUuid = document.getElementById("parentUuid").value;
	          	var parentNodeId = document.getElementById("parentNodeId").value;
	          	var subData ={'tableNames':seTableArray,'parentUuid':parentUuid,'parentNodeId':parentNodeId};
	          	Matrix.closeWindow();
	          	
	          }
                
            </script>
        </head>
        
        <body>
            <jsp:include page="/form/admin/common/loading.jsp" />
            <div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto;">
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
                action="<%=request.getContextPath()%>/entity/importEntity_loadDsList.action" 
                style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="Form0" value="Form0" />
                   
                    <input id="parentUuid" type="hidden" name="parentUuid" value="${requestScope.parentUuid}" />
                    <input id="parentNodeId" type="hidden" name="parentNodeId" value="${requestScope.parentNodeId}" />
                    <input id="dsName" type="hidden" name="dsName" value="${requestScope.dsName}" />
                    <input id="schemaName" type="hidden" name="schemaName" value="${requestScope.schemaName}" />
                    <input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
                    <input id="nodeUrl" type="hidden" name="nodeUrl" value="${nodeUrl }" />
                    
                   	<input id="selectedTableData" type="hidden" name="selectedTableData" value="${requestScope.selectedTableData}" />
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
                    </div>
                    <table id="table0css" jsId="table0css" cellpadding="0px" cellspacing="0px"
                    style="width: 100%; height: 100%">
                        <tr id="j_id2" jsId="j_id2">
                            <td id="j_id3" jsId="j_id3" colspan="2" rowspan="1" style="height: 30px;">
                                工具栏：
                            </td>
                        </tr>
                        <tr id="j_id5" jsId="j_id5">
                         
                            <td colspan="2" style="vertical-align:top">
<table id="table0" jsId="table0" class="str" cellpadding="0px"
cellspacing="0px" style="width:100%;height:100%;">
    <tr id="j_id2" jsId="j_id2" >
        <td id="j_id3" jsId="j_id3" colspan="1" rowspan="1" style="width:49%;">
            <div id="MultiLabel0" style="width: 100px;height:20px;float:left;">
                待选表/视图：
            </div>
            <div id="tableNameFilter_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
            </div>
            <script>
            	
                var tableNameFilter = isc.TextItem.create({
                    ID: "MtableNameFilter",
                    name: "tableNameFilter",
                    editorType: "TextItem",
                    displayId: "tableNameFilter_div",
                    position: "relative",
                    width: 154
                });
                MForm0.addField(tableNameFilter);
            </script>
            <script>
                isc.ImgButton.create({
                    ID: "MImageButton0",
                    name: "ImageButton0",
                    showDisabled: false,
                    showDisabledIcon: false,
                    showDown: false,
                    showDownIcon: false,
                    showRollOver: false,
                    showRollOverIcon: false,
                    position: "relative",
                    width: 18,
                    height: 18,
                    src:Matrix.getActionIcon("query")
                });
                MImageButton0.click = function() {
                    Matrix.showMask();
                    queryTables();
                   
                    Matrix.hideMask();
                }
            </script>
        </td>
        <td id="j_id5" jsId="j_id5" colspan="1" rowspan="1" style="width:2%;">
            &nbsp;
        </td>
        <td id="j_id6" jsId="j_id6" colspan="1" rowspan="1" style="width:49%;">
            <span id="MultiLabel1" style="width: 124px;height:20px;">
                已选表/视图：
            </span>
        </td>
    </tr>
    
    
    <tr id="j_id8" jsId="j_id8" style="height:270px;">
        <td id="j_id9" jsId="j_id9" colspan="1" rowspan="1" style="border:0px;">
            <div id="DataGrid0_div" class="matrixComponentDiv"
				style="width: 100%; height:270px;">
				<script>
				    //待选 数据列表
					var gridData = []; 
					isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:false,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
						fields:[
						  {title:"名称",	name:"tableName",canEdit:false}
						  
						],
						data:gridData,
						autoFetchData:true,
						alternateRecordStyles:true,
						canAutoFitFields:false,
						canEdit:true,
						selectionType: "multiple",
						canDragSelect: true,
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
		                    
		                }
		                //,selectionChanged: "MDataGrid1.setData(this.getSelection())"
					});
					
			 		MDataGrid0.setData(${requestScope.tableNames});
					//isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			 		
			 		
				</script>
			</div>
        </td>
        <td id="j_id11" jsId="j_id11" colspan="1" rowspan="1" style="height: 200px; width: 30px" align="center">
               <script>
            	//添加选中
                isc.ImgButton.create({
                    ID: "MImageButton1",
                    name: "ImageButton1",
                    showDisabled: false,
                    showDisabledIcon: false,
                    showDown: false,
                    showDownIcon: false,
                    showRollOver: false,
                    showRollOverIcon: false,
                    position: "relative",
                    width: 18,
                    height: 18,
                    src:Matrix.getActionIcon("right")
                });
                MImageButton1.click = function() {
                    Matrix.showMask();
                 	addSelected2Target();
                    Matrix.hideMask();
                }
            </script>
            <br/>
            <script>
            	//添加所有选中
                isc.ImgButton.create({
                    ID: "MImageButton2",
                    name: "ImageButton2",
                    showDisabled: false,
                    showDisabledIcon: false,
                    showDown: false,
                    showDownIcon: false,
                    showRollOver: false,
                    showRollOverIcon: false,
                    position: "relative",
                    width: 18,
                    height: 18,
                   src:Matrix.getActionIcon("right2")
                });
                MImageButton2.click = function() {
                    Matrix.showMask();
                   	addAll2Target();
                    Matrix.hideMask();
                }
            </script>
           
         
            <br/>
            <script>
            	//移除选中
                isc.ImgButton.create({
                    ID: "MImageButton3",
                    name: "ImageButton3",
                    showDisabled: false,
                    showDisabledIcon: false,
                    showDown: false,
                    showDownIcon: false,
                    showRollOver: false,
                    showRollOverIcon: false,
                    position: "relative",
                    width: 18,
                    height: 18,
                    src:Matrix.getActionIcon("left")
                });
                MImageButton3.click = function() {
                    Matrix.showMask();
                   
                    removeSelected2Src();
                    Matrix.hideMask();
                }
            </script>
            <br/>
            <script>
                isc.ImgButton.create({
                    ID: "MImageButton4",
                    name: "ImageButton4",
                    showDisabled: false,
                    showDisabledIcon: false,
                    showDown: false,
                    showDownIcon: false,
                    showRollOver: false,
                    showRollOverIcon: false,
                    position: "relative",
                    width: 18,
                    height: 18,
                    src:Matrix.getActionIcon("left2")
                });
                MImageButton4.click = function() {
                    Matrix.showMask();
                   	removeAll2Src();
                    Matrix.hideMask();
                }
            </script>
        </td>
        <td id="j_id15" jsId="j_id15" colspan="1" rowspan="1" style="border:0px;">
            <div id="DataGrid1_div" 
				style="width: 100%; height: 100%;">
				<script>
					var gridData = []; 
					isc.MatrixListGrid.create({
						ID:"MDataGrid1",
						name:"DataGrid1",
						canSort:false,
						displayId:"DataGrid1_div",
						position:"relative",
						width:"100%",
						height:"100%",
						fields:[
						  {title:"名称",	name:"tableName",canEdit:false}
						  
						],
						data:gridData,
						autoFetchData:true,
						alternateRecordStyles:true,
						canAutoFitFields:false,
						canEdit:true,
						selectionType: "multiple",
						canDragSelect: true,
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
		                     //设计流程
		                    // designProcess(record.pkgTid);
		                }
					});
					//isc.Page.setEvent(isc.EH.LOAD,"MDataGrid1.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid1.resizeTo(0,0);MDataGrid1.resizeTo('100%','100%');",null);
			 		
			 		
				</script>
			</div>
        </td>
    </tr>
    
    <tr id="j_id17" jsId="j_id17" class="str">
        <td id="j_id18" jsId="j_id18" colspan="3" rowspan="1">
            <span id="MultiLabel4" style="width: 292px;height:20px;">
                表到对象转换(默认转换后首字母小写)
            </span>
        </td>
    </tr>
    <tr id="j_id20" jsId="j_id20" class="str">
        <td id="j_id21" jsId="j_id21" colspan="3" rowspan="1">
            <div id="needRemovePrefix_div" eventProxy="MForm0" class="matrixInline" style="">
            </div>
            <script>
                var needRemovePrefix = isc.CheckboxItem.create({
                    ID: "MneedRemovePrefix",
                    name: "needRemovePrefix",
                    editorType: "CheckboxItem",
                    displayId: "needRemovePrefix_div",
                    valueMap: {
                        "false": false,
                        "true": true
                    },
                    position: "relative",
                    title: "去前缀(可写多个,按“;”分隔)",
                    changed:function(form, item, value){
                       
					  	if(value=="true"){
					  		selectRemoveprefixNames();
					  	}else if(value =="false"){
					  		unSelectRemoveprefixNames();
					  	}
					}
                });
                MForm0.addField(needRemovePrefix);
                MForm0.setValue("needRemovePrefix", "false");
            </script>
        </td>
    </tr>
    <tr id="j_id22" jsId="j_id22" class="str">
        <td id="j_id23" jsId="j_id23" colspan="3" rowspan="1">
            <span id="MultiLabel5" style="width:90px;height:20px;">
                &nbsp;&nbsp;&nbsp;前缀名：
            </span>
            <div id="prefixNames_div" eventProxy="MForm0" class="matrixInline" style="">
            </div>
            <script>
                var prefixNames = isc.TextItem.create({
                    ID: "MprefixNames",
                    name: "prefixNames",
                    editorType: "TextItem",
                    displayId: "prefixNames_div",
                    position: "relative",
                    width: 160,
                    disabled:true
                });
                MForm0.addField(prefixNames);
            </script>
            <span id="MultiLabel6" style="width: 393px;height:20px;">
                &nbsp;&nbsp;去掉表名字段名中当前输入的前缀&nbsp;如：OA_User到user
            </span>
        </td>
    </tr>
    <tr id="j_id26" jsId="j_id26" class="str">
        <td id="j_id27" jsId="j_id27" colspan="3" rowspan="1">
            <div id="needRemoveDelimiter_div" eventProxy="MForm0" class="matrixInline" style="">
            </div>
            <script>
                var needRemoveDelimiter = isc.CheckboxItem.create({
                    ID: "MneedRemoveDelimiter",
                    name: "needRemoveDelimiter",
                    editorType: "CheckboxItem",
                    displayId: "needRemoveDelimiter_div",
                    valueMap: {
                        "false": false,
                        "true": true
                    },
                    position: "relative",
                    title: "去分隔符",
                    changed:function(form, item, value){
                       
					  	if(value=="true"){
					  		selectRemoveDelimiter();
					  	}else if(value == "false"){
					  		unSelectRemoveDelimiter();
					  	}
					}
                });
                MForm0.addField(needRemoveDelimiter);
                MForm0.setValue("needRemoveDelimiter", "false");
            </script>
        </td>
    </tr>
    <tr id="j_id28" jsId="j_id28" class="str">
        <td id="j_id29" jsId="j_id29" colspan="3" rowspan="1">
            <span id="MultiLabel7" style="width:90px;height:20px;">
                &nbsp;&nbsp;&nbsp;分隔符：
            </span>
            <div id="delimiter_div" eventProxy="MForm0" class="matrixInline" style="">
            </div>
            <script>
                var delimiter = isc.TextItem.create({
                    ID: "Mdelimiter",
                    name: "delimiter",
                    editorType: "TextItem",
                    displayId: "delimiter_div",
                    position: "relative",
                    width: 160,
                    disabled:true
                });
                MForm0.addField(delimiter);
            </script>
            <span id="MultiLabel8" style="width: 467px;height:20px;">
                去掉表名字段中当前输入的分隔符&nbsp;如：ORDER_ITEM到orderItem
            </span>
        </td>
    </tr>
    <tr id="j_id32" jsId="j_id32">
        <td id="j_id33" jsId="j_id33" colspan="3" rowspan="1">
            &nbsp;
        </td>
    </tr>
</table>
                            </td>
                        </tr>
                        <tr id="j_id9" jsId="j_id9" height="20px">
                            <td id="j_id10" jsId="j_id10" colspan="2" rowspan="1">
                                <script>
                                    isc.ToolStripButton.create({
                                        ID: "MToolBarItem3",
                                        icon: Matrix.getActionIcon("left"),
                                        title: "上一步",
                                        showDisabledIcon: false,
                                        showDownIcon: false
                                    });
                                    MToolBarItem3.click = function() {
                                        Matrix.showMask();
										Matrix.convertFormItemValue('Form0');
                                        document.getElementById('Form0').submit();
                                        Matrix.hideMask();
                                    }
                                </script>
                                <script>
                                    isc.ToolStripButton.create({
                                        ID: "MToolBarItem4",
                                        icon: Matrix.getActionIcon("right"),
                                        title: "下一步",
                                        showDisabledIcon: false,
                                        showDownIcon: false,
                                        disabled:true
                                    });
                                    MToolBarItem4.click = function() { //同时保存
                                        Matrix.showMask();

                                       
                                        Matrix.hideMask();
                                    }
                                </script>
                                
                                 <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem1",
									icon:Matrix.getActionIcon("save"),
                                    title: "完成",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem1.click = function() {
                                    Matrix.showMask();
                                    
                                    if (!MForm0.validate()) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                    submitSelectTables();
                                    
                                    Matrix.hideMask();
                                }
                            </script>
                           <!--  <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem2",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "关闭",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem2.click = function() {
                                    Matrix.showMask();
                                    Matrix.closeWindow();
                                    
                                    Matrix.hideMask();
                                }
                            </script> -->
                            
                                <div id="ToolBar0_div" style="width: 100%; overflow: hidden;">
                                    <script>
                                        isc.ToolStrip.create({
                                            ID: "MToolBar0",
                                            displayId: "ToolBar0_div",
                                            width: "100%",
                                            height: "*",
                                            position: "relative",
                                            align: "right",
//                                          members: [MToolBarItem3, "separator", MToolBarItem4, "separator", MToolBarItem1, "separator", MToolBarItem2]
                                        	members: [MToolBarItem3, "separator", MToolBarItem4, "separator", MToolBarItem1]
                                        });
                                        isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                    </script>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
                <script>
                    MForm0.initComplete = true;
                    MForm0.redraw();
                    isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
                </script>
            </div>
        </body>
    
    </html>