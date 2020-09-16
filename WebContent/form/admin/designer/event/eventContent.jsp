<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>eventContent</title>
		<jsp:include page="/form/admin/common/taglib.jsp"/>
        <jsp:include page="/form/admin/common/resource.jsp" />
    
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="tabContainer0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;">
 				<script>
                        var MtabContainer0 = isc.TabSet.create({
                            ID: "MtabContainer0",
                            displayId: "tabContainer0_div",
                            height: "100%",
                            width: "100%",
                            position: "relative",
                            align: "center",
                            tabBarPosition: "top",
                            tabBarAlign: "left",
                            showPaneContainerEdges: false,
                            showTabPicker: true,
                            showTabScroller: true,
                            selectedTab: 2,
                            tabBarControls: [isc.MatrixHTMLFlow.create({
                                ID: "MtabContainer0Bar0",
                                width: "300px",
                                contents: "<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
                            })],
                            tabs: [{
                             title: "执行逻辑",
                                pane: isc.HTMLPane.create({
                                    ID: "MtabContainer0Panel1",
                                    height: "100%",
                                    overflow: "hidden",
                                    autoDraw: false,
                                    showEdges: false,
                                    contentsType: "page",
                                    contentsURL: "<%=request.getContextPath()%>/designer/formDesign_loadOperationListPage.action?eventType=${param.eventType}&ajaxEventType=${param.ajaxEventType}"
                                })
                            },
                            {
                                title: "JS方法",
                                pane: isc.HTMLPane.create({
                                    ID: "MtabContainer0Panel0",
                                    height: "100%",
                                    overflow: "hidden",
                                    autoDraw: false,
                                    showEdges: false,
                                    contentsType: "page",
                                    contentsURL: "<%=request.getContextPath()%>/designer/formDesign_loadAjaxRelateJSPage.action?eventType=${param.eventType}&ajaxEventType=${param.ajaxEventType}"
                                })
                            }]
                        });
                        //if (MhorizontalContainer0Panel1) if (!MhorizontalContainer0Panel1.customMembers) MhorizontalContainer0Panel1.customMembers = [];
                        //MhorizontalContainer0Panel1.customMembers.add(MtabContainer0);
                        //document.getElementById('tabContainer0_div').style.display = 'none';
                        //MtabContainer0.selectTab(0);
                    </script>
                </div>
                
                <div id="tabContainer0Bar0_div2" style="text-align:right" class="matrixInline">
                </div>
                <script>
                    document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
                
                </script>
</body>
</html>