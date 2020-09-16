<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
   		  通用选择索引页
        </title>
       <jsp:include page="/form/admin/common/taglib.jsp" />
         <jsp:include page="/form/admin/common/resource.jsp" />
         
         <script type="text/javascript">
         //表单选择
         function onDialog0Close(data,oType){
         	return true;
         }
         
         //对象选择
           function onDialog1Close(data,oType){
         	return true;
         }
         
         //页面变量选择
           function onDialog2Close(data,oType){
         	return true;
         }
         //属性选择
         
         function onDialog3Close(data,oType){
            return true;
         
         }
         
         
           //数据词典选择
           function onDialog4Close(data,oType){
         	return true;
         }
         
           //按钮属性弹出
           function onDialog5Close(data,oType){
         		return true;
           }
         </script>
    </head>
    
    <body>
        <jsp:include page="/form/admin/common/loading.jsp"/>
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
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
         <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
            style="margin:0px;height:100%;" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="Form0" value="Form0" />
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;">
               </div>
      
                <script>
                    isc.ToolStripButton.create({
                        ID: "MToolBarItem0",
                       icon:Matrix.getActionIcon("add"),
                        title: "表单选择",
                        showDisabledIcon: false,
                        showDownIcon: false
                    });
                    MToolBarItem0.click = function() {
                        Matrix.showMask();
                        var x = eval("Matrix.showWindow('Dialog0');");
                        if (x != null && x == false) {
                            Matrix.hideMask();
                            return false;
                        }
                        if (!false) {
                            Matrix.hideMask();
                            return false;
                        }
                   
                       
                        Matrix.hideMask();
                    }
                </script>
                <script>
                    isc.ToolStripButton.create({
                        ID: "MToolBarItem1",
                        icon:Matrix.getActionIcon("add"),
                        title: "对象选择",
                        showDisabledIcon: false,
                        showDownIcon: false
                    });
                    MToolBarItem1.click = function() {
                        Matrix.showMask();
                        var x = eval("Matrix.showWindow('Dialog1');");
                        if (x != null && x == false) {
                            Matrix.hideMask();
                            return false;
                        }
                        if (!false) {
                            Matrix.hideMask();
                            return false;
                        }
                     
                     
                        Matrix.hideMask();
                    }
                </script>
                <script>
                    isc.ToolStripButton.create({
                        ID: "MToolBarItem2",
                        icon:Matrix.getActionIcon("add"),
                        title: "页面变量选择",
                        showDisabledIcon: false,
                        showDownIcon: false
                    });
                    MToolBarItem2.click = function() {
                        Matrix.showMask();
                        var x = eval("Matrix.showWindow('Dialog2');");
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
                    
                        Matrix.hideMask();
                    }
                </script>
                <script>
                    isc.ToolStripButton.create({
                        ID: "MToolBarItem3",
                        icon:Matrix.getActionIcon("add"),
                        title: "属性选择",
                        showDisabledIcon: false,
                        showDownIcon: false
                    });
                    MToolBarItem3.click = function() {
                        Matrix.showMask();
                        var x = eval("Matrix.showWindow('Dialog3');");
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
                       
                        Matrix.hideMask();
                    }
                </script>
                
                <script>
                    isc.ToolStripButton.create({
                        ID: "MToolBarItem4",
                        icon:Matrix.getActionIcon("add"),
                        title: "代码选择树",
                        showDisabledIcon: false,
                        showDownIcon: false
                    });
                    MToolBarItem4.click = function() {
                        Matrix.showMask();
                        var x = eval("Matrix.showWindow('Dialog4');");
                        if (x != null && x == false) {
                            Matrix.hideMask();
                            return false;
                        }
                     
                        if (!MForm0.validate()) {
                            Matrix.hideMask();
                            return false;
                        }
                       
                        Matrix.hideMask();
                    }
                </script>
                
                
                 <script>
                    isc.ToolStripButton.create({
                        ID: "MToolBarItem5",
                        icon:Matrix.getActionIcon("add"),
                        title: "按钮",
                        showDisabledIcon: false,
                        showDownIcon: false
                    });
                    MToolBarItem5.click = function() {
                        Matrix.showMask();
                        var x = eval("Matrix.showWindow('Dialog5');");
                        if (x != null && x == false) {
                            Matrix.hideMask();
                            return false;
                        }
                     
                        if (!MForm0.validate()) {
                            Matrix.hideMask();
                            return false;
                        }
                       
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
                            members: [MToolBarItem0, "separator", MToolBarItem1, "separator", MToolBarItem2, "separator", MToolBarItem3, "separator", MToolBarItem4
                            , "separator", MToolBarItem5]
                        });
                        isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                    </script>
                </div>
                        <span style="font-size:15px">注: 初次点击[页面变量选择]之前，请先点击初始化页面变量链接URL:<a target="_blank" href="<%=request.getContextPath()%>/designer/formDesign_getFormVariables.action">[初始化页面变量]</a>
                 <a target="_blank" href="<%=request.getContextPath()%>/test.test">[初始按钮属性]</a></span>                
                <script>
                    function getParamsForDialog0() {
                        var params = 'iframewindowid=Dialog0&';
                        var value;
                        return params;
                    }
                    isc.Window.create({
                        ID: "MDialog0",
                        autoCenter: true,
                        position: "absolute",
                        height: 400,
                        width: 300,
                        title: "表单选择",
                        canDragReposition: false,
                        showMinimizeButton: true,
                        showMaximizeButton: true,
                        showCloseButton: true,
                        showModalMask: false,
                        modalMaskOpacity: 0,
                        isModal: true,
                        autoDraw: false,
                        headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                        getParamsFun:getParamsForDialog0,
						initSrc:"<%= request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=14",
						src:"<%= request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=14" 
                    });
                </script>
                <script>
                    MDialog0.hide();
                </script>
                <script>
                    function getParamsForDialog1() {
                        var params = 'iframewindowid=Dialog1&';
                        var value;
                        return params;
                    }
                    isc.Window.create({
                        ID: "MDialog1",
                        autoCenter: true,
                        position: "absolute",
                        height: 400,
                        width: 300,
                        title: "对象选择",
                        canDragReposition: false,
                        showMinimizeButton: true,
                        showMaximizeButton: true,
                        showCloseButton: true,
                        showModalMask: false,
                        modalMaskOpacity: 0,
                        isModal: true,
                        autoDraw: false,
                        headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                        getParamsFun:getParamsForDialog1,
						initSrc:"<%= request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=16",
						src:"<%= request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=16" 
                    });
                </script>
                <script>
                    MDialog1.hide();
                </script>
                <script>
                    function getParamsForDialog2() {
                        var params = 'iframewindowid=Dialog2&';
                        var value;
                        return params;
                    }
                    isc.Window.create({
                        ID: "MDialog2",
                        autoCenter: true,
                        position: "absolute",
                        height: 400,
                        width: 300,
                        title: "页面变量选择",
                        canDragReposition: false,
                        showMinimizeButton: true,
                        showMaximizeButton: true,
                        showCloseButton: true,
                        showModalMask: false,
                        modalMaskOpacity: 0,
                        isModal: true,
                        autoDraw: false,
                        headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                        getParamsFun:getParamsForDialog2,
						initSrc:"<%= request.getContextPath()%>/common/formVarTree_loadFormVarPage.action",
						src:"<%= request.getContextPath()%>/common/formVarTree_loadFormVarPage.action" 
                    });
                </script>
                <script>
                    MDialog2.hide();
                </script>
                <script>
                    function getParamsForDialog3() {
                        var params = 'iframewindowid=Dialog3&';
                        var value;
                        return params;
                    }
                    isc.Window.create({
                        ID: "MDialog3",
                        autoCenter: true,
                        position: "absolute",
                        height: 400,
                        width: 800,
                        title: "属性选择",
                        canDragReposition: false,
                        showMinimizeButton: true,
                        showMaximizeButton: true,
                        showCloseButton: true,
                        showModalMask: false,
                        modalMaskOpacity: 0,
                        isModal: true,
                        autoDraw: false,
                        headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                        getParamsFun:getParamsForDialog3,
						initSrc:"<%= request.getContextPath()%>/common/commonProperties_getEntityProperties.action",
						src:"<%= request.getContextPath()%>/common/commonProperties_getEntityProperties.action" 
                    });
                </script>
                <script>
                    MDialog3.hide();
                </script>
                
                
                  <script>
                    function getParamsForDialog4() {
                        var params = 'iframewindowid=Dialog4&';
                        var value;
                        return params;
                    }
                    isc.Window.create({
                        ID: "MDialog4",
                        autoCenter: true,
                        position: "absolute",
                        height: 400,
                        width: 300,
                        title: "代码选择",
                        canDragReposition: false,
                        showMinimizeButton: true,
                        showMaximizeButton: true,
                        showCloseButton: true,
                        showModalMask: false,
                        modalMaskOpacity: 0,
                        isModal: true,
                        autoDraw: false,
                        headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                        getParamsFun:getParamsForDialog4,
						initSrc:"<%= request.getContextPath()%>/common/commonCode_loadSelectCodeTreePage.action",
						src:"<%= request.getContextPath()%>/common/commonCode_loadSelectCodeTreePage.action" 
                    });
                </script>
                <script>
                    MDialog4.hide();
                </script>
                
                
                   <script>
                    function getParamsForDialog5() {
                        var params = '&';
                        var value;
                        return params;
                    }
                    isc.Window.create({
                        ID: "MDialog5",
                        autoCenter: true,
                        position: "absolute",
                        height: 500,
                        width: 900,
                        title: "按钮属性",
                        canDragReposition: false,
                        showMinimizeButton: true,
                        showMaximizeButton: true,
                        showCloseButton: true,
                        showModalMask: false,
                        modalMaskOpacity: 0,
                        isModal: true,
                        autoDraw: false,
                       
                        headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                        getParamsFun:getParamsForDialog5,
						initSrc:"<%= request.getContextPath()%>/form/admin/designer/common/editmain.jsp?componentType=button",
						src:"<%= request.getContextPath()%>/form/admin/designer/common/editmain.jsp?componentType=button"

                    });
                </script>
                <script>
                    MDialog5.hide();
                </script>
            </form>
            <script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script>
        </div>
    </body>

</html>