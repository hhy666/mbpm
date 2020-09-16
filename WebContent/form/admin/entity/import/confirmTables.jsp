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
            	}
            
            
            	.str td{
            		border:1px solid #cccccc;
            	}
            	
            	
            
            </style>
            <script type="text/javascript">
                //初始页面
             
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
                action="<%=request.getContextPath()%>/entity/importEntity_loadTableList.action"
                style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="Form0" value="Form0" />
                   
                    <input id="parentUuid" type="hidden" name="parentUuid" value="${param.parentUuid}" />
                    <input id="dsName" type="hidden" name="dsName" value="${requestScope.dsName}" />
                    <input id="schemaName" type="hidden" name="schemaName" value="${requestScope.schemaName}" />
                    <input id="parentNodeId" type="hidden" name="parentNodeId" value="${requestScope.parentNodeId}" />
                   
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
                    </div>
                    <table id="table0css" jsId="table0css" cellpadding="0px" cellspacing="0px"
                    style="width: 100%; height: 100%" class="str">
                        <tr id="j_id2" jsId="j_id2">
                            <td id="j_id3" jsId="j_id3" colspan="2" rowspan="1" style="height: 30px;">
                                工具栏：
                            </td>
                        </tr>
                        <tr id="j_id5" jsId="j_id5" height="100%">
                         
                            <td colspan="2" style="vertical-align:top">
							<!-- 引入外部网页 -->
							<div id="horizontalContainer0_div" class="matrixInline" style="width:100%;height:100%;;overflow:hidden;">
    <script>
        isc.HLayout.create({
            ID: "MhorizontalContainer0",
            displayId: "horizontalContainer0_div",
            position: "relative",
            height: "100%",
            width: "100%",
            align: "center",
            overflow: "auto",
            defaultLayoutAlign: "center",
            members: [isc.MatrixHTMLFlow.create({
                ID: "MhorizontalContainer0Panel0",
                width: '20%',
                height: "100%",
                overflow: "hidden",
                showResizeBar: "true",
                contents: "<div id='horizontalContainer0Panel0_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
            }), isc.MatrixHTMLFlow.create({
                ID: "MhorizontalContainer0Panel1",
                height: "100%",
                overflow: "hidden",
                contents: "<div id='horizontalContainer0Panel1_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
            })]
        });
    </script>
</div>
<div id="horizontalContainer0Panel0_div2" style="width:100%;height:100%;overflow:hidden;"
class="matrixInline">
   
    <div id="DataGrid0_div" class="matrixComponentDiv"
				style="width: 100%; height:100%;">
				<script>
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
						  {title:"表名",	name:"tableName"}
						  
						],
						data:gridData,
						autoFetchData:true,
						alternateRecordStyles:true,
						canAutoFitFields:false,
						canEdit:false,
						selectionType: "single",
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
		                    
		                }
					});
					if (MhorizontalContainer0Panel0) if (!MhorizontalContainer0Panel0.customMembers) MhorizontalContainer0Panel0.customMembers = [];
           		    MhorizontalContainer0Panel0.customMembers.add(MDataGrid0);
					isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			 		
			 		
				</script>
			</div>
    
    
</div>
<script>
    document.getElementById('horizontalContainer0Panel0_div').appendChild(document.getElementById('horizontalContainer0Panel0_div2'));
</script>
<div id="horizontalContainer0Panel1_div2" style="width:100%;height:100%;overflow:hidden;"
class="matrixInline">
</div>
<script>
    document.getElementById('horizontalContainer0Panel1_div').appendChild(document.getElementById('horizontalContainer0Panel1_div2'));
</script>
							

                            </td>
                        </tr>
                        <tr id="j_id9" jsId="j_id9" height="20px">
                            <td id="j_id10" jsId="j_id10" colspan="2" rowspan="1">
                                <script>
                                    isc.ToolStripButton.create({
                                        ID: "MToolBarItem3",
                                        icon: Matrix.getActionIcon("left"),
                                        title: "上一步",
                                        disabled: true,
                                        showDisabledIcon: false,
                                        showDownIcon: false
                                    });
                                    MToolBarItem3.click = function() {
                                        Matrix.showMask();

                                        Matrix.hideMask();
                                    }
                                </script>
                                <script>
                                    isc.ToolStripButton.create({
                                        ID: "MToolBarItem4",
                                        icon: Matrix.getActionIcon("right"),
                                        title: "下一步",
                                        showDisabledIcon: false,
                                        showDownIcon: false
                                    });
                                    MToolBarItem4.click = function() { //同时保存
                                        Matrix.showMask();


                                        if (!MForm0.validate()) {
                                            Matrix.hideMask();
                                            return false;
                                        }

                                        Matrix.convertFormItemValue('Form0');
                                        document.getElementById('Form0').submit();
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
                                    var x = eval("parent.hideComponentPropertiesWindow(1);");
                                    if (x != null && x == false) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                    if (!false) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                    if (!MForm0.validate()) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                   
                                    Matrix.convertFormItemValue('Form0');
                                    document.getElementById('Form0').submit();
                                    Matrix.hideMask();
                                }
                            </script>
                            <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem2",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "关闭",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem2.click = function() {
                                    Matrix.showMask();
                                    var x = eval("parent.hideComponentPropertiesWindow(2);");
                                    if (x != null && x == false) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                    if (!false) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                    if (!MForm0.validate()) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                        
                                    Matrix.convertFormItemValue('Form0');
                                    document.getElementById('Form0').submit();
                                    Matrix.hideMask();
                                }
                            </script>
                            
                                <div id="ToolBar0_div" style="width: 100%; overflow: hidden;">
                                    <script>
                                        isc.ToolStrip.create({
                                            ID: "MToolBar0",
                                            displayId: "ToolBar0_div",
                                            width: "100%",
                                            height: "*",
                                            position: "relative",
                                            align: "right",
                                            members: [MToolBarItem3, "separator", MToolBarItem4, "separator", MToolBarItem1, "separator", MToolBarItem2]
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