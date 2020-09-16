<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            场景下实体
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
            parent.Matrix.forceFreshTreeNode("Tree0", "<%=request.getParameter("parentNodeId")%>");
             //parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
            //工具栏加载完后加载iframe        
            function initPage(){
            	document.getElementById("iframe1").src="<%=request.getContextPath()%>/entity/entityProperty_loadEntityProPage.action?entityUuid=${entityInfo.uuid}&entityType=${entityInfo.type}&mid=${entityInfo.mid}";
            	var soType = "${param.soType}";
				var sceneId = "${requestScope.sceneId}";
			
				var basicLinkUrl = "<%=request.getContextPath() %>/scene/scene_preLoadSceneBasicMsg.action?sceneId="+sceneId+"&soType="+soType;
				if(soType=="update"){
				
					
					var objLinkUrl = "#";
					var formLinkUrl= "<%=request.getContextPath() %>/scene/scene_loadSceneFormDesigner.action?sceneId="+sceneId+"&soType="+soType;
					var processLinkUrl = "<%=request.getContextPath() %>/scene/scene_loadSceneFlow.action?sceneId="+sceneId+"&soType="+soType;
					var authLinkUrl = "<%=request.getContextPath() %>/scene/scene_loadSceneAuthorize.action?sceneId="+sceneId+"&soType="+soType;
					
					document.getElementById("sceneBasicLink").href = basicLinkUrl;
					document.getElementById("sceneObjLink").href = objLinkUrl;
					document.getElementById("sceneFormLink").href = formLinkUrl;
					document.getElementById("sceneProcessLink").href = processLinkUrl;
					document.getElementById("sceneAuthLink").href = authLinkUrl;
					
					
				}else if(soType=="add"){
					document.getElementById("sceneBasicLink").href = basicLinkUrl;
				}
            	
            	
            }         
       </script>
       
<style type="text/css">
.scene_undo{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/undo-middle.png);
	background-repeat: repeat-x;
	width:150px;
	height:25px;
	text-align:center;
	vertical-align:middle;
	text-decoration: none;
	cursor:hand;
	
}

.scene_undo_right{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/undo-right.png);
	background-repeat: no-repeat;
	width:30px;
	height:25px;
	text-align:center;
	vertical-align:middle;
	text-decoration: none;
	cursor:hand;
	
}
.scene_doing{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/doing.png);
	background-repeat: no-repeat;
	width:148px;
	height:25px;
	text-align:center;
	vertical-align:middle;
	cursor:hand;
}

.scene_doed{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/doed-middle.png);
	background-repeat: repeat-x;
	width:150px;
	height:25px;
	text-align:center;
	vertical-align:middle;
	text-decoration: none;
	cursor:hand;
}

.scene_doed_left{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/doed-left.png);
	background-repeat: no-repeat;
	background-position:top right;
	width:10px;
	height:25px;
	text-align:right;
	vertical-align:middle;
	text-decoration: none;
	cursor:hand;
	
}
.scene_doing span,.scene_undo span,.scene_doed span{
	height:100%;
	padding-top:5px;
}

.scene_doing a{
	text-decoration: none;
	color:#FFFFFF;
}

</style>
    </head>
    
    <body onload="initPage()">
      
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%;overflow:auto;">
            <script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "<%=request.getContextPath() %>/scene/scene_loadSceneFormDesigner.action",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
            <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="<%=request.getContextPath() %>/scene/scene_loadSceneFormDesigner.action?soType=${param.soType}"
            style="margin:0px;height:100%;" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="Form0" value="Form0"/>
                <input type="hidden" name="sceneId" id="sceneId" value="${requestScope.sceneId}"/>
                <input type="hidden" name="parentId" id="parentId" value="${requestScope.parentId}"/> 
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;">
                </div>
               
                <table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px"
                cellspacing="0px" style="width:100%;height:100%">
                    <tr id="j_id2" jsId="j_id2">
                        <td style="height: 30px;padding-left:5px;">
							<table style="border-collapse:collapse;">
								<tr>
								<td class="scene_doed_left"></td>
								<td class="scene_doed"><a id="sceneBasicLink">基本信息</a></td>
								<td class="scene_doing"><a id="sceneObjLink">对象设计</a></td>
								<td class="scene_undo"><a id="sceneFormLink" >表单设计</a></td>
								<td class="scene_undo"><a id="sceneProcessLink" >流程设计</a></td>
								<td class="scene_undo"><a id="sceneAuthLink" >表单授权</a></td>
								<td class="scene_undo_right"></td>
								</tr>
							</table>
					 </td>
                    </tr>
                    <tr id="j_id5" jsId="j_id5">
                     
                        <td valign="top">
							 <iframe id="iframe1" height="100%" width="100%" frameborder="0"
							  src="">
                            </iframe>	
                        </td>
                    </tr>
                    <tr >
                        <td  style="width:100%;height:25px">
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
                                    //上一步 返回基础页面
                                  	 isc.confirm('请确认已经保存当前编辑的数据!',function(data){//true or null
                                    
                                    if(data){
                                    	Matrix.convertFormItemValue('Form0');
                                    	var form0 = document.getElementById('Form0');
                                    	form0.action = "<%=request.getContextPath() %>/scene/scene_preLoadSceneBasicMsg.action?soType=${param.soType}";
                                        form0.submit();
                                    		
                                    }
                                      
                                    		 
                                    });
                                   
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
                                    
                                
                                    isc.confirm('请确认已经保存当前编辑的数据!',function(data){//true or null
                                    
	                                    if(data){
	                                    	Matrix.convertFormItemValue('Form0');
	                                        document.getElementById('Form0').submit();
	                                    		
	                                    }
                                      
                                    		 
                                    });
                                    
                                    //下一步之前先确认
                                    
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
                                         members: [MToolBarItem3, "separator", MToolBarItem4]
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