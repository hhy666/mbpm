<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            场景样式框架
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
                    parent.Matrix.forceFreshTreeNode("Tree0", "<%=request.getParameter("parentNodeId")%>");
                    //parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
       </script>
    </head>
    
    <body>
        <jsp:include page="/form/admin/common/loading.jsp"/>
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%;overflow:auto;">
            <script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "/formconfole",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
            <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
            style="margin:0px;height:100%;" enctype="application/x-www-form-urlencoded">
                 <input type="hidden" name="Form0" value="Form0"/>
                 
                 <input type="hidden" name="currentStep" id="currentStep" value="${requestScope.currentStep}"/> 
                 <input type="hidden" name="mid" id="mid" value="${requestScope.mid}"/> <!-- 场景mid -->
                 <input type="hidden" name="parentUuid" id="parentUuid" value="${requestScope.parentId}"/>
                 <!-- 实体部分隐藏字段 -->
                 <input type="hidden" id="entityUuid" name="entityUuid" value="${requestScope.entityUuid}" />
                 <input type="hidden" id="entityMid" name="entityMid" value="${requestScope.entityMid}" />
	             
	            
                
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;">
                </div>
               
                <table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px"
                cellspacing="0px" style="width:100%;height:100%">
                    <tr id="j_id2" jsId="j_id2">
                        <td id="j_id3" jsId="j_id3" class="maintain_form_content" colspan="2"
                        rowspan="1" style="height:60px;">
                            导航信息栏：
                        </td>
                    </tr>
                    <tr id="j_id5" jsId="j_id5">
                     
                        <td id="td13874300245170" jsId="td13874300245170" class="maintain_form_input" colspan="1" rowspan="1" 
                        style="height:100%" valign="top">
	<iframe id="sceneContent" height="100%" width="100%" frameborder="0"
   src="<%=request.getContextPath() %>/scene/scene_loadSceneFrameContent.action?currentStep=${requestScope.currentStep}&mid=${requestScope.mid}&parentUuid=${requestScope.parentId}">
     </iframe>
                        </td>
                    </tr>
                    <tr id="j_id9" jsId="j_id9">
                        <td id="j_id10" jsId="j_id10" class="maintain_form_input" colspan="2"
                        rowspan="1">
                            <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem3",
                                     icon:Matrix.getActionIcon("left"),
                                    title: "上一步",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem3.click = function() {
                                    Matrix.showMask();
                                    if (!true) {
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
                                    ID: "MToolBarItem4",
                                    icon:Matrix.getActionIcon("right"),
                                    title: "下一步",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem4.click = function() {
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
                                    title: "取消",
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
                            <div id="ToolBar0_div" style="width:100%;overflow:hidden;">
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