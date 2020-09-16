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
            <script type="text/javascript">
                //初始页面
                function initPage() {
                    var actionType = "${requestScope.actionType}";
                    if (actionType == "update") {
                        var definedId = Matrix.getMatrixComponentById("definedId");
                        definedId.setDisabled(true);
                        document.getElementById("Form0").action = "<%=request.getContextPath()%>/catalog_updateCatalogNode.action";

                    }
                }
                //dsName变化时触发
                function dsNameChanged(value){
                	var url = "<%=request.getContextPath()%>/entity/importEntity_loadSchemasByDs.action?dsName="+value;
                	if(value!=null){
                		//异步请求 获取对应的schema
                		dataSend(null,url,"POST",dsNameChangedCallBack);
                	}
                }
                
                function dsNameChangedCallBack(data){
                    var schemaItemsStr = data.data;
                	if(schemaItemsStr!=null&&schemaItemsStr.length>0){
                	  var schemaItems = isc.JSON.decode(schemaItemsStr);
                		 MschemaName.setValueMap(schemaItems);
                	}
                
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
                action="<%=request.getContextPath()%>/entity/importEntity_loadTableList.action"
                style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="Form0" value="Form0" />
                    
                    <input id="nodeUrl" type="hidden" name="nodeUrl" value="${nodeUrl }" /> 
                    <input id="parentUuid" type="hidden" name="parentUuid" value="${requestScope.parentUuid}" />
                    <input id="parentNodeId" type="hidden" name="parentNodeId" value="${requestScope.parentNodeId}" />
                    <input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
                    </div>
                    <table id="table0css" jsId="table0css" cellpadding="0px" cellspacing="0px"
                    style="width: 100%; height: 100%">
                        <tr id="j_id2" jsId="j_id2">
                            <td id="j_id3" jsId="j_id3" colspan="2" rowspan="1" style="height: 30px;">
                                导航信息栏：
                            </td>
                        </tr>
                        <tr id="j_id5" jsId="j_id5" height="100%">
                            <td id="j_id6" jsId="j_id6" class="maintain_form_input" colspan="1" style="width:100px;"
                            valign="top">
                                左侧导航图占位
                            </td>
                            <td colspan="1" style="vertical-align:top">
                                <table id="basicContent" jsId="basicContent" class="maintain_form_content">
                                    <tr id="j_id4" jsId="j_id4">
                                        <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1"
                                        style="width: '20%'">
                                            <label id="j_id6" name="j_id6" style="margin-left: 10px">
                                                	数据源名称：
                                            </label>
                                        </td>
                                        <td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
                                            <div id="dsName_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MdsName_VM=[];
		    var dsName=isc.SelectItem.create({
		    		ID:"MdsName",
		    		name:"dsName",
		    		editorType:"SelectItem",
		    		displayId:"dsName_div",
		    		valueMap:[],
		    		position:"relative",
		    		required:true,
		    		width:290,
		    		changed:function(form, item, value) {
		    				dsNameChanged(value);
		    		}
		    });
		    MForm0.addField(dsName);
		    MdsName_VM = ${requestScope.dsNameArray};
		    MdsName.setValueMap(MdsName_VM);
		    
		   
		</script>
                                     <span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">
                                                *
                                            </span>
                                          
                                        </td>
                                    </tr>
                 <tr id="j_id9" jsId="j_id9">
                                        <td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
                                        rowspan="1" style="width: '20%'">
                                            <label id="j_id11" name="j_id11" style="margin-left: 10px">
                                                schema：
                                            </label>
                                        </td>
                                        <td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
                                        rowspan="1">
                                          <div id="schemaName_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	
		    var schemaName=isc.SelectItem.create({
		    		ID:"MschemaName",
		    		name:"schemaName",
		    		editorType:"SelectItem",
		    		displayId:"schemaName_div",
		    		valueMap:[],
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(schemaName);
		    
		    MschemaName.setValueMap([]);
		    
		    //初始时设置DS为系统默认数据源
		    var defaultDs = MdsName_VM[0];
		    if(defaultDs!=null){
		    MdsName.setValue(defaultDs);
		     dsNameChanged(defaultDs);
		    }
		   
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">
                                                *
                                            </span>
                                        </td>
                                    </tr>
 
	
                                    
                                    
                                    <tr id="j_id20" jsId="j_id20">
                                        <td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1"
                                        rowspan="1" style="width: '20%'">
                                            <label id="j_id22" name="j_id22" style="margin-left: 10px">
                                                说明：
                                            </label>
                                        </td>
                                        <td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
                                        rowspan="1">
                                            <div id="desc_div" eventProxy="MForm0" class="matrixInline" style="">
                                            </div>
                                            <script>
                                                var desc = isc.TextAreaItem.create({
                                                    ID: "Mdesc",
                                                    name: "desc",
                                                    editorType: "TextAreaItem",
                                                    displayId: "desc_div",
                                                    position: "relative",
                                                    value: "选择数据源和相关的schema，然后点击[下一步]选择要导入的数据表。",
                                                    width: 290,
                                                    canEdit:false
                                                });
                                                MForm0.addField(desc);
                                            </script>
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
                                    disabled:true,
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem1.click = function() {
                                    Matrix.showMask();
                                   
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
//											members: [MToolBarItem3, "separator", MToolBarItem4, "separator", MToolBarItem1, "separator", MToolBarItem2]
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