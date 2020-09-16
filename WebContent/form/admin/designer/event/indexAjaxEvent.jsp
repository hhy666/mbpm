<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            AjaxIndex!
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp" />
        <jsp:include page="/form/admin/common/resource.jsp" />
    </head>
    
    <body>
        <jsp:include page="/form/admin/common/loading.jsp"/>
        </div>
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
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
                        members: [isc.HTMLPane.create({
                            ID: "MhorizontalContainer0Panel0",
                            width: '26%',
                            height: "100%",
                            overflow: "hidden",
                            showResizeBar: "true",
                            showEdges: false,
                            contentsType: "page",
                            contentsURL: "<%=request.getContextPath()%>/form.daction?componentType=ActionSupport&command=list&mode=propertyedit&level=subItem&eventType=${eventType}&ajaxEventType=${ajaxEventType}"
                        }), isc.MatrixHTMLFlow.create({
                            ID: "MhorizontalContainer0Panel1",
                            height: "100%",
                            overflow: "hidden",
                            contentsType: "page",
                            contentsURL: ""
                        })]
                    });
                </script>
            </div>
            <div id="horizontalContainer0Panel1_div2" style="width:100%;height:100%;overflow:hidden;"
            class="matrixInline">
                <div id="tabContainer0_div" class="matrixComponentDiv" style="width:100%;height:100%;;position:relative;">
                   
            </div>
        </div>
    </body>

</html>