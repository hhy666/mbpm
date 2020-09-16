<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.matrix.form.designer.action.ActionConstants"%>
<%@page import="javax.matrix.faces.component.MUIComponent"%>
<html>
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            treeInfo!
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
        <jsp:include page="/form/admin/common/resource.jsp" />

	<script type="text/javascript">
	
	function onMainDialogClose(data,oType){
		return true;
	
	}
	
	
	</script>
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
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: hidden;">
<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/form.daction?componentType=ActionButton&command=update&mode=propertyedit"
	style="margin: 0px; width:100%;height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState"
	id="javax.faces.ViewState" value="j_id7:j_id8" /> <input type="hidden"
	id="matrix_current_page_id" name="matrix_current_page_id"
	value="/console/formmanager/formdesign/BasicInputText" />
<table id="table0css" jsId="table0css" class="maintain_form_content"
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">

	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" colspan="1" rowspan="1">
<div id="tabContainer0_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;" >
	<script> var MtabContainer0 = isc.TabSet.create({ID:"MtabContainer0",displayId:"tabContainer0_div",layoutTopMargin:0,
	   height: "98%",width: "100%",position: "relative",align: "center",tabBarPosition: "top",tabBarAlign: "left",showPaneContainerEdges: false,showTabPicker: true,showTabScroller: true,
		tabBarControls : [isc.MatrixHTMLFlow.create({ID:"MtabContainer0Bar0",width:"300px",contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"}) ],
		tabs: [ 
			{title: "基本信息",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel0",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/designer.daction?componentType=Paginator&componentId=${param.componentId}&command=edit"})}
			  ] });
			document.getElementById('tabContainer0_div').style.display='none';
			</script>
			</div><div id="tabContainer0Bar0_div2" style="text-align:right"  class="matrixInline"></div>
<script>document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));</script>
<script>document.getElementById('tabContainer0_div').style.display='';</script></div>
		</td>		
	</tr>
		<tr id="j_id190" jsId="j_id190">
		<td id="j_id191" jsId="j_id191"  style="height:25px;" 
			colspan="1" rowspan="1">
			<script>isc.ToolStripButton.create({ID:"MToolBarItem1",icon:Matrix.getActionIcon("save"),title: "完成",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem1.click=function(){
			Matrix.showMask();
			parent.isc.MH.updateComponent();	
			Matrix.hideMask();
			}
			</script>
			<script>isc.ToolStripButton.create({ID:"MToolBarItem2",icon:Matrix.getActionIcon("exit"),title: "关闭",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem2.click=function(){
			Matrix.showMask();

			parent.isc.MH.cancelUpdateComponent();		
			Matrix.hideMask();}</script>
		<div id="ToolBar0_div" style="width: 100%; overflow: hidden;">
		<script>isc.ToolStrip.create({ID:"MToolBar0",displayId:"ToolBar0_div",width: "100%",height: "*",position: "relative",align: "right",members: [ MToolBarItem1,"separator",MToolBarItem2 ] });isc.Page.setEvent(isc.EH.RESIZE,"MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');",null);</script></div>
		</td>
	</tr>
<input id="iframewindowid" type="hidden" name="iframewindowid" value="" />
</table>
<input id="rowNum" type="hidden" name="rowNum" value="<%=request.getParameter("rowNum")%>" />
</form>
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
			autoDraw: false,
			headerControls:[
				"headerIcon","headerLabel",
				"minimizeButton","maximizeButton","closeButton"
			]
			
			//initSrc:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp",
			//src:"<%=request.getContextPath()%>/designer/addFormInnerLogic.jsp" 
	});
	MMainDialog.hide();
	</script>



<script>//MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>


</body>
</html>