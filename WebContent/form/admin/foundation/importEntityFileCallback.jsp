<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            导入实体文件
        </title>
        
		<jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
		   function closeDialog(){
			var props = "${requestScope.properties}";
			
			Matrix.closeWindow(props);
		   
		   }
		
		</script>

    </head>
    
    <body onload="closeDialog()">
       <jsp:include page="/form/admin/common/loading.jsp"/>
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
            <script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "<%=request.getContextPath() %>/UploadEntityFileServlet",
                    enctype:"multipart/form-data",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
            <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
            style="margin:0px;height:100%;" enctype="multipart/form-data">
               <input id="iframewindowid" name="iframewindowid" type="hidden" value="${requestScope.iframewindowid}" />
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;">
                </div>

             
                    <div id="j_id2_div2" style="width:100%;height:100%;overflow:auto;" class="matrixInline">
                        
                    </div>
                    <script>
                        Matrix.appendChild('j_id2_div', 'j_id2_div2');
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


