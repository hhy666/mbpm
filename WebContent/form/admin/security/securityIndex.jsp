<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            securityIndex
        </title>
        <SCRIPT SRC='<%=path%>/resource/html5/js/jquery.min.js'></SCRIPT>
		<SCRIPT SRC='<%=path%>/resource/html5/js/layer.min.js'></SCRIPT>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
			var iframeJs;   //记录一级弹出窗口
			
			function getWindow(window){
				windowId = window;
			}
			
			//选择用户 data 为 str
        	function onDialog0Close(data, oType){
        		//userName  userId
        		if(data!=null){
        			//var userJson = isc.JSON.decode(data);//{text,id}
        			var userName = windowId.Matrix.getMatrixComponentById("userName");
        			var userId = windowId.document.getElementById("userId");
        			
        			userName.setValue(data.names);
        			userId.value = data.ids;
        			return true;
        		}
        		
        	
        		return true;
        	}
			//从子类调用
			function closeEmpowerWindow(){
				Matrix.closeWindow();
			}
			
			//子类添加弹出框关闭时触发
			function onAddSecScopeDialogClose(data, oType){
				document.getElementById('isc_4').contentWindow.onAddSecScopeDialogClose(data,oType);
			}
		
			//右侧操作设置弹出窗口回调
			function onoperationSetClose(data){
				iframeJs.onoperationSetClose(data);       //listSecEmpower.jsp
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
            <form id="Form0" name="Form0" eventProxy="MForm0" method="post"
             action=""
            style="margin:0px;height:100%;" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="Form0" value="Form0" />
                <!-- 表单发布状态 -->
                <input type="hidden" name="state"  id="state"value="${param.state}" />
                <input type="hidden" name="formUuid" id="formUuid" value="${requestScope.formUuid}" />
                <input type="hidden" name="catalogId" id="catalogId" value="${param.catalogId}" />
                <input type="hidden" name="modulePath" id="modulePath" value="${param.modulePath }" /> 
                <input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}" />
                <input type="hidden" name="controlSet" id="controlSet" value="" />
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;">
                </div>
                
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
                             resizeBarSize:1,
                            defaultLayoutAlign: "center",
                            members: [
	                            isc.HTMLPane.create({
	                                ID: "MhorizontalContainer0Panel0",
	                                width: '290px',
	                                height: "100%",
	                                overflow: "hidden",
	                                showResizeBar: "true",
	                                showEdges: false,
	                                contentsType: "page",
	                                contentsURL: ""
	                            }),
	                             isc.HTMLPane.create({
	                                ID: "MhorizontalContainer0Panel1",
	                                height: "100%",
	                                overflow: "hidden",
	                                showEdges: false,
	                                contentsType: "page",
	                                contentsURL: ""
	                            })
                            ]
                        });
                    </script>
                </div>
              
                <script>
                	//左侧栏 范围列表 param formUuid authView  授权的视图(common|scene)
                    MhorizontalContainer0Panel0.setContentsURL('<%=request.getContextPath()%>/security/formSecScope_getSecScopeList.action?formUuid=${formUuid}&authView=${param.authView}&state=${param.state}&modulePath=${param.modulePath}&iframewindowid=${param.iframewindowid}&catalogId=${param.catalogId}');
                    MhorizontalContainer0Panel1.setContentsURL('<%=request.getContextPath()%>/form/admin/security/listSecEmpower_Blank.jsp');
                   
                    //MhorizontalContainer0Panel0.setContentsURL('');
                   
                	//右侧栏 范围详细列表
                    
                </script>
            </form>
            <script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script>
            
      <script>
	
	isc.Window.create({
			ID:"MMainDialog",
			id:"MainDialog",
			name:"MainDialog",
			autoCenter: true,
			position:"absolute",
			height: "500px",
			width: "900px",
			title: "test",
			canDragReposition: false,
			showMinimizeButton:true,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel",
				"closeButton"
			]
			
			//initSrc:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp",
			//src:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp" 
	});
	MMainDialog.hide();
	
	
	
	isc.Window.create({
			ID:"MSelectTreeDialog",
			id:"SelectTreeDialog",
			name:"SelectTreeDialog",
			autoCenter: true,
			position:"absolute",
			height: "500px",
			width: "900px",
			title: "test",
			canDragReposition: false,
			showMinimizeButton:true,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel",
				"closeButton"
			]
			
			//initSrc:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp",
			//src:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp" 
	});
	
	MSelectTreeDialog.hide();
	
	
	
	isc.Window.create({
			ID:"MAddItemTarget",
			id:"AddItemTarget",
			name:"AddItemTarget",
			autoCenter: true,
			position:"absolute",
			height: "500px",
			width: "900px",
			title: "test",
			canDragReposition: false,
			showMinimizeButton:true,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel",
				"closeButton"
			]
			
			
	});
	MAddItemTarget.hide();
	
	</script>
        </div>
    </body>

</html>