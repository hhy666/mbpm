<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.form.model.component.composite.QueryList"%>
<%@page import="com.matrix.form.designer.action.ActionConstants"%>
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            queryListActions!
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
<jsp:include page="/form/admin/common/loading.jsp"/>
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
	
	//表单操作目标弹出框
     isc.Window.create({
       ID:"MFormOperationTarget",
       id:"FormOperationTarget",
       name:"FormOperationTarget",
       autoCenter: true,
       position:"absolute",
       height: "100%",
       width: "100%",
       title: "表单操作目标弹出框",
       canDragReposition: false,
       showMinimizeButton:false,
       showMaximizeButton:false,
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
	</script>

<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<table style="border-collapse:collapse;border-spacing:0px;width: 100%; height: 100%">
	<tr>
		<td style="height: 60px;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);" 
		>			<br>
			&nbsp;&nbsp;&nbsp;导航:&nbsp;&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>/form/admin/designer/composite/queryListBasic.jsp">基本信息</a>-->
			<a href="<%=request.getContextPath()%>/form/admin/designer/composite/queryListDataFields.jsp">数据项</a>-->
			<a href="<%=request.getContextPath()%>/form/admin/designer/composite/queryListQueryForm.jsp">查询分页</a>
<% 
if(MFormContext.getPhaseId() == 2 || MFormContext.getPhaseId() == 3){  //设计开发阶段再显示
%>
			--><b>操作列表</b>-->
			<a href="<%=request.getContextPath()%>/form/admin/designer/composite/queryListAdvance.jsp">高级属性</a>
<% 
  }
%>
			</td>
	</tr>
	<tr>
		<td>
<div id="tabContainer0_div" class="matrixComponentDiv" style="width:100%;height:100%;;position:relative;" >
<% 
//获取并传容器类型
QueryList queryList = (QueryList)session.getAttribute(ActionConstants.COMPOSITE_MODEL);
String containerType = queryList.getQueryContainerType();
%>
	<script> var MtabContainer0 = isc.TabSet.create({ID:"MtabContainer0",overflow:'auto',displayId:"tabContainer0_div",height: "100%",width: "100%",position: "relative",align: "center",tabBarPosition: "top",tabBarAlign: "left",showPaneContainerEdges: false,showTabPicker: true,showTabScroller: true,selectedTab: 4,
		tabBarControls : [isc.MatrixHTMLFlow.create({ID:"MtabContainer0Bar0",width:"300px",contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"}) ],
		tabs: [ 
			{title: "操作列表",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel0",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:""})}
			  ] });
			document.getElementById('tabContainer0_div').style.display='none';
			</script>
			</div>
	<script>
		document.getElementById('tabContainer0_div').style.display='';
		isc.Page.setEvent(isc.EH.LOAD,
           	function(){
           		MtabContainer0Panel0.setContentsURL("<%=request.getContextPath()%>/form.daction?componentType=ActionButton&command=list&mode=propertyedit&level=subItem&containerType=<%=containerType%>");
           		MtabContainer0.resizeTo(0,0);MtabContainer0.resizeTo('100%','100%');
           		isc.Page.setEvent(isc.EH.RESIZE,"MtabContainer0.resizeTo(0,0);MtabContainer0.resizeTo('100%','100%');",null);
            },
            null
         );
			

	</script>
		</td>		
	</tr>
	<tr>
		<td style="height:28px">
			<script>isc.ToolStripButton.create({ID:"MToolBarItem3",icon:Matrix.getActionIcon("left"),title: "上一步",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem3.click=function(){
			Matrix.showMask();
			document.getElementById('Form0').action="<%=request.getContextPath()%>/form/admin/designer/composite/queryListQueryForm.jsp";
			document.getElementById('Form0').submit();
			Matrix.hideMask();
			}
			</script>
			<script>isc.ToolStripButton.create({ID:"MToolBarItem4",icon:Matrix.getActionIcon("right"),title: "下一步",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem4.click=function(){
			Matrix.showMask();
			document.getElementById('Form0').action="<%=request.getContextPath()%>/form/admin/designer/composite/queryListAdvance.jsp";
			document.getElementById('Form0').submit();
			Matrix.hideMask();
			}
			</script>
			<script>isc.ToolStripButton.create({ID:"MToolBarItem1",icon:Matrix.getActionIcon("save"),title: "完成",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem1.click=function(){
			Matrix.showMask();
			
			parent.isc.MH.updateComponent();	
			
			Matrix.hideMask();
			
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
			
			}
			</script><script>isc.ToolStripButton.create({ID:"MToolBarItem2",icon:Matrix.getActionIcon("exit"),title: "关闭",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem2.click=function(){
			Matrix.showMask();

			parent.isc.MH.cancelUpdateComponent();		
			Matrix.hideMask();
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
			}</script>
		<div id="ToolBar0_div" style="width: 100%;height:28px;overflow: hidden;"><script>isc.ToolStrip.create({ID:"MToolBar0",displayId:"ToolBar0_div",width: "100%",height: "28px",position: "relative",align: "right",members: [MToolBarItem3,"separator",MToolBarItem4,"separator", MToolBarItem1,"separator",MToolBarItem2 ] });isc.Page.setEvent(isc.EH.RESIZE,"MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');",null);</script></div>
		</td>
	</tr>
</table>
<input id="iframewindowid" type="hidden" name="iframewindowid" value="" />
</form>
<script>//MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>


</body>
</html>