<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            创建列表样式框架
        </title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
        <jsp:include page="/form/admin/common/resource.jsp" />
        <script type="text/javascript">
             var step = 1;
        	 function linkToNextPage(){
        	    //跳转之前需要对当页面数据进行提交
        	    MToolBarItem3.setDisabled(false);//上一步可用
        	 	var iframeMain = document.getElementById("iframeMain");
        	 
        	 	iframeMain.src="<%=request.getContextPath() %>/form/admin/designer/step2.jsp";
        	 	step++;
        	 	
        	 }
        	 
        	  function linkToPrePage(){
        	    //跳转之前需要对当页面数据进行提交
        	  
        	 	var iframeMain = document.getElementById("iframeMain");
        	 	
        	 	iframeMain.src="<%=request.getContextPath() %>/form/admin/designer/step1.jsp";
        	 	step--;
        	 	if(step==1){//第一步 将上一步禁用
        	 	MToolBarItem3.setDisabled(true);
        	 	}
        	 	
        	 }
        
        
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
                
                <table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px"
                cellspacing="0px" style="width:100%;height:100%">
                    <tr id="j_id2" jsId="j_id2">
                        <td id="j_id3" jsId="j_id3" class="maintain_form_input" colspan="1" rowspan="1"
                        style="height:60px;">
                            &nbsp;导航信息栏:
                            
                            
                            
                            
                        </td>
                    </tr>
                    <tr id="j_id4" jsId="j_id4" height="100%">
                        <td id="j_id5" jsId="j_id5" colspan="1" rowspan="1">
                        <tr id="j_id5" jsId="j_id5" height="100%">
                        <td id="j_id6" jsId="j_id6" class="maintain_form_input" colspan="1" rowspan="1"
                        width="200px">
                            第一步左侧
                        </td>
                        <td id="td13874300245170" jsId="td13874300245170" colspan="1" rowspan="1"
                        class="maintain_form_input">
                            <iframe id="iframe1" height="100%" width="100%" frameborder="0" src="<%=request.getContextPath() %>/form/admin/designer/frameTest.jsp">
                            </iframe>
                        </td>
                    </tr>
                    <tr id="j_id7" jsId="j_id7">
                        <td id="j_id8" jsId="j_id8" class="maintain_form_input" colspan="1" rowspan="1">
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
                                   
                                    if (!MForm0.validate()) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                    if(step>1){
                                     linkToPrePage();
                                    
                                    }
                                    //Matrix.convertFormItemValue('Form0');
                                    //document.getElementById('Form0').submit();
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
                                 
                                    linkToNextPage();
                                    //Matrix.convertFormItemValue('Form0');
                                   // document.getElementById('Form0').submit();
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
                <input id="iframewindowid" type="hidden" name="iframewindowid" value=""
                />
            </form>
            <script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script>
        </div>
    </body>

</html>