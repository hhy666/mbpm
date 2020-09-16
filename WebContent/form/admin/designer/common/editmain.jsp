<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<%@page import="com.matrix.form.designer.action.ActionConstants"%>
<%@page import="javax.matrix.faces.component.MUIComponent"%>
<%@page import="com.matrix.form.model.component.layout.ToolBar"%>
<%@page import="com.matrix.form.model.component.composite.IncludeForm"%>
<%@page import="com.matrix.form.model.component.composite.DataList"%>
<%@page import="com.matrix.form.model.component.basic.InnerHtml"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@taglib uri="http://platform/resource" prefix="mr"%>
<html>
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            editMain
        </title>

<mr:resource isHTML5="true"/>
        <jsp:include page="/form/admin/common/taglib.jsp" />
        <link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
   

	<script type="text/javascript">
	function onMainDialogClose(data,oType){
		return true;
	
	}
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
</head>
<body>
<div id='matrixMask' name='matrixMask' class='matrixMask' style='display:none;'> </div>
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
<table id="table0css" jsId="table0css" 
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%;table-layout:fixed;">
	<tr id="j_id2" jsId="j_id2">
		<td id="j_id3" jsId="j_id3" colspan="1"
			rowspan="1" style="height: 60px;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);">
			<br>
			&nbsp;&nbsp;&nbsp;描述:&nbsp;&nbsp;&nbsp;请在下面标签页中设置组件属性,完成后点击保存确认.
			</td>
	</tr>
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" colspan="1" rowspan="1">
<div id="tabContainer0_div" class="matrixComponentDiv" style="width:100%;position:relative;overflow:hidden" >

<% 
//取出组件,先取sub中,如果没有,取component
Object comp = null;
Object obj = session.getAttribute(ActionConstants.SUBCOMPONENT_MODEL);
if(obj!=null){
	Map subComMap = (Map)obj;
	String subItemKey = request.getParameter(ActionConstants.COMPONENT_TYPE)+ActionConstants.SUBCOMPONETN_SUFFIX;
	Object subItemObj = subComMap.get(subItemKey);
	if(subItemObj!=null){
		comp = (MUIComponent)subItemObj;
	}
}
if(comp == null){
	comp = session.getAttribute(ActionConstants.COMPONENT_MODEL);
}	

String componentType = request.getParameter("componentType");
if(comp != null){
	componentType = ((MUIComponent)comp).getTagName();
}	
%>
	<script> var MtabContainer0 = isc.TabSet.create({
		ID:"MtabContainer0",
		displayId:"tabContainer0_div",
		layoutTopMargin:0,
	   height: "100%",
	   width: "100%",
	   position: "relative",
	   align: "center",
	   tabBarPosition: "top",
	   tabBarAlign: "left",
	   showPaneContainerEdges: false,
	   showTabPicker: true,
	   showTabScroller: true,
		tabBarControls : [isc.MatrixHTMLFlow.create({ID:"MtabContainer0Bar0",width:"300px",contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"}) ],
		tabs: [ 
			{title: "基本信息",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel0",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=<%=componentType%>&componentId=${param.componentId}&command=editPart&page=basic&mode=propertyedit"})}
		<%
			
			
		//输入类包含数据教研	
		if(comp instanceof javax.matrix.faces.component.MUIInput){%>
			,{title: "数据校验",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel1",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form/admin/designer/h5DataValidatorList.jsp?componentType=<%=componentType%>"})}
			
		<%}
		if(comp instanceof com.matrix.form.model.component.basic.PopupSelectDialog){
		%>	
			,{title: "交互数据",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel22",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form/admin/designer/common/datamapping.jsp"})}
			
			<%
			}
		
		if(MFormContext.getPhaseId() == 2 || MFormContext.getPhaseId() == 3){  //设计开发阶段再显示
			
		if( !(comp instanceof ToolBar) && !(comp instanceof IncludeForm)  && !(comp instanceof InnerHtml) && !(comp instanceof DataList)){%>
			
			,{title: "事件",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel2",height: "100%",overflow: "hidden",margin:0,autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form/admin/designer/common/event.jsp?eventType=event&componentType=<%=componentType%>"})}
		<%
		}
		//命令类包含操作和流转
		if(comp instanceof javax.matrix.faces.component.MUICommand){%>
			,{title: "操作",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel4",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/designer/formDesign_loadOperationListPage.action?eventType=command"})},
			{title: "流转",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel5",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=transition&command=list&mode=propertyedit&level=subItem&componentType=<%=componentType%>"})}
			<%
			}
		}
			%>

		<%
		//输入类包含数据教研	
		if(comp instanceof javax.matrix.faces.component.MUIInput){
		     if( ((javax.matrix.faces.component.MUIInput)comp).getQueryItem() != null){
		%>
			,{title: "查询设置",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel4",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=<%=componentType%>&command=editPart&mode=propertyedit&level=subItem&page=QueryItem-edit"})}
			<%
		    }
		}

		if(MFormContext.getPhaseId() == 2 || MFormContext.getPhaseId() == 3){  //设计开发阶段再显示
		%>

			,{title: "高级属性",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel3",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentId=${param.componentId}&command=editPart&page=advance&mode=propertyedit&componentType=<%=componentType%>"})}
<%
		} 
%>			
			  ] });
			  
			  
			document.getElementById('tabContainer0_div').style.display='none';
			
			isc.Page.setEvent(isc.EH.LOAD,
			function(){
				MtabContainer0.resizeTo(0,0);
				MtabContainer0.resizeTo('100%','100%');
			}
			,isc.Page.FIRE_ONCE
		);
			
			</script>
			</div>
			
	

		
<script>document.getElementById('tabContainer0_div').style.display='';</script></div>
		</td>		
	</tr>
	
		<tr id="j_id490" jsId="j_id49">
		<td id="j_id191" jsId="j_id191" height="32px" style="border-bottom: 1px solid white; border-right: 1px solid white;text-align: center; bottom: 0px; left: 0px;padding-right: 4px;background: #f2f2f2;width: 100%; height: 32px;"
			colspan="1" rowspan="1">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="width: 80px; position: relative; height: 22px;">
			<script>
			isc.Button.create({
			ID:"MdataFormSubmitButton",
			name:"dataFormSubmitButton",
			title:"保存",
			displayId:"dataFormSubmitButton_div",
			position:"absolute",
			top:0,
			left:0,
			width:"100%",
			height:"100%",
			//icon:Matrix.getActionIcon("save"),
			showDisabledIcon:false,
			showDownIcon:false,
			showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
				if(parent.isc.MH){
					parent.isc.MH.updateComponent();
					
					//parent.isc.MFH.initProperties();
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					parent.layer.close(index);
			}else{
			<% if(comp instanceof javax.matrix.faces.component.MUICommand){%>
				Matrix.sendRequest("<%=request.getContextPath()%>/form.daction?componentType=ActionButton&subItem=<%=componentType%>&command=complete&rowNum=<%=request.getParameter("rowNum")%>",null,callbackFun);
			<%}else if(comp instanceof javax.matrix.faces.component.MUIInput){%>		
				Matrix.sendRequest("<%=request.getContextPath()%>/form.daction?componentType=EditField&subItem=<%=componentType%>&command=complete&rowNum=<%=request.getParameter("rowNum")%>",null,callbackFun);
			<%}%>
			}
			
			Matrix.hideMask();
		};
		
		function callbackFun(response) {
		    var data2 = isc.JSON.decode(response.data);
			Matrix.closeWindow(data2);
 		}
		
		</script></div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="width: 80px; position: relative;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,
					left:0,
					width:"100%",
					height:"100%",
					//icon:Matrix.getActionIcon("exit"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormCancelButton.click=function(){
				Matrix.showMask();
				debugger;
				if(parent.isc.MH){
					parent.isc.MH.cancelUpdateComponent();
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					parent.layer.close(index);
				}else{
	           		 Matrix.closeWindow();
				}
			//this.hide();			
			Matrix.hideMask();
		};
	</script></div>
		</td>
	</tr>
	
	
<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
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


	isc.Window.create({
			ID:"MSubDialog",
			id:"SubDialog",
			name:"SubDialog",
			autoCenter: true,
			position:"absolute",
			height: "450px",
			width: "800px",
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
			
	});
	MSubDialog.hide();
	
	
	
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
							canDragReposition: true,
							showMinimizeButton:false,
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
	</script>
	
	



<script>//MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>


</body>
</html>