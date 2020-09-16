<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            queryListDataField!
        </title>
        <jsp:include page="/form/admin/common/resource.jsp" />
    </head>


<script>
                
		/*******************************asynchronous common method begin***************************************/
	 function dataSend(data,url,method,callbackFun,errorFun) {
	    method=method?method:"POST";
      	RPCManager.sendRequest({params:data,callback:callbackFun,handleError:errorFun,httpMethod:method,actionURL:url});      
     }
	
	 function update(command){
		         var componentType = document.getElementById("componentType").value;
                 var data ="{'componentType':'"+componentType+"','command':'update'}";
                 var url = '<%=request.getContextPath()%>/formdesigner.daction';
	    	     var synJson = isc.JSON.decode(data);
	     		 dataSend(synJson,url,"POST",function(data){
	     		 },null);
		  
		  }
	
</script>

<body>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: hidden;">

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
			canDragReposition: true,
			showMinimizeButton:true,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw:false
	});
	</script>
<script> 

     
var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/form/admin/designer/composite/actionbuttons.jsp"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState"
	id="javax.faces.ViewState" value="j_id7:j_id8" /> <input type="hidden"
	id="matrix_current_page_id" name="matrix_current_page_id"
	value="/console/formmanager/formdesign/BasicInputText" />
<table id="table0css" jsId="table0css" 
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
	<tr id="j_id4" jsId="j_id4" height="100%">
		<td id="j_id5" jsId="j_id5" colspan="1" rowspan="1">
            <div id="horizontalContainer0_div" class="matrixInline" style="width:100%;height:435px;;overflow:hidden;">
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
                            width: '28%',
                            height: "100%",
                            overflow: "hidden",
                            showResizeBar: "true",
                            showEdges: false,
                            contentsType: "page",
                            contentsURL: "<%=request.getContextPath()%>/form/admin/designer/composite/queryViewDataLeft.jsp"
                        }), isc.MatrixHTMLFlow.create({
                            ID: "MhorizontalContainer0Panel1",
                            height: "100%",
                            contentsType: "page",
                            overflow: "hidden"
                        })]
                    });
                </script>
            </div>
		</td>		
	</tr>
	
</table>
<input id="iframewindowid" type="hidden" name="iframewindowid" value="" />
</form>
<script>//MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);

</script></div>


</body>
</html>