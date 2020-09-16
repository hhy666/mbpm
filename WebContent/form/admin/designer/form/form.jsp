<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.matrix.form.api.MFormContext"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            表单属性
        </title>
        <script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
		<script src="<%=path %>/resource/html5/js/layer.min.js"></script>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
        <jsp:include page="/form/admin/common/resource.jsp" />
        <link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
        <style type="text/css">
        	html,body{height:100%}
        
        </style>
    </head>
<script>
/***********************zsd  用于触发器数据复制*********************************************/
var dataCopy;//用于回掉数据复制页面的方法
var firstCondition;//用于回掉数据复制中的条件
var tarForm;//用于回掉数据复制中的条件
var iframeJs;

	function ontargetFormClose(data){
	//回掉数据复制页面的setTargetValuye()方法·
		dataCopy.setTargetValue(data);	
	}
	function ontarConditionClose(data){
	//回掉数据复制页面的setTargetValuye()方法·
		dataCopy.setConditionValue(data);	
		
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
	
	//打开条件设置窗口
	function openCondiation(conditionValue,associatedFormId,iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer01',
			type : 2,
			
			title : ['设置条件'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '96%', '96%' ],
			content : "<%=path%>/trigger/condition_conditionAssociated.action?iframewindowid=layer01&firstCondition="+encodeURI(conditionValue)+"&associatedFormId="+associatedFormId+""
		});			
	}
	
	//选择条件回调
	 function onlayer01Close(data){
		 /*
		 if(document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow.Matrix){
			  var iframe = document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
		 }else{
			  var iframe = document.getElementsByTagName("iframe")[2].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
		 }
		 */
		
		 if(data!=null){
			 data = eval('(' + data + ')');
			 iframeJs.MpopupCondition.setValue(data.conditionText);  
			 
		}else if(typeof(data) == "undefined"){

		}else{
			iframeJs.MpopupCondition.setValue("");
		}
		
	 }
	
	//表单联合校验弹出条件窗口
	function openValidation(validation){
		layer.open({
	    	id:'layer02',
			type : 2,
			
			title : ['设置条件'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '80%', '95%' ],
			content : "<%=path%>/trigger/condition_condition.action?iframewindowid=layer02&firstCondition="+encodeURI(validation)+""
		});			
	}
	
	//表单联合校验弹出条件窗口回调
	 function onlayer02Close(data){
		 var value;
		 var iframe = document.getElementsByTagName("iframe")[0].contentWindow;
		 if(data!=null && data!=''){
				var result = eval("("+data+")");
		        value = result.conditionText;
		        
		        iframe.Matrix.setFormItemValue('adValidationStr',value);
				var data2 = {};
				data2['attrName'] = 'adValidationStr';
				data2['attrValue'] = value;
				data2['componentType'] = 'form';
				data2['command'] = 'updateAttribute';
				Matrix.sendRequest("<%=path%>/designer.daction",data2);
		 }else if(typeof(data) == "undefined"){
				
	     }else{
	    	   iframe.Matrix.setFormItemValue('adValidationStr',"");
				var data2 = {};
				data2['attrName'] = 'adValidationStr';
				data2['attrValue'] = "";
				data2['componentType'] = 'form';
				data2['command'] = 'updateAttribute';
				Matrix.sendRequest("<%=path%>/designer.daction",data2);
		}    
			
		
	 }
	
	//触发事件数据拷贝设置条件弹出窗口
	function openDataCopyCondiation(targetFormId,arr,firstCondition,optString){
		document.getElementById('firstCondition').value = "";
		if(firstCondition){
			document.getElementById('firstCondition').value = firstCondition;
		}
		var params = '&';
		var value;
		value = null;
		try {
			value = eval(optString);
		} catch (error) {
			value = optString;
		}
		if (value != null) {
			value = "optString=" + value;
			params += value;
		}
		params += "&";
		try {
			value = eval(targetFormId);
		} catch (error) {
			value = targetFormId;
		}
		if (value != null) {
			value = "targetFormId=" + value;
			params += value;
		}
		
		layer.open({
	    	id:'layer03',
			type : 2,
			
			title : ['设置条件'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '96%', '96%' ],
			content : "<%=path%>/form/admin/custom/trigger/transit.jsp?iframewindowid=layer03&"+params+""
		});			
	}
	
	//触发事件数据拷贝设置复制数据点击文本框弹出条件设置窗口
	function openTargetCondition(targetFormId,operateType,tarForm){
		document.getElementById('tarForm').value = "";
		document.getElementById('tarForm').value = tarForm;
	
		layer.open({
	    	id:'layer04',
			type : 2,
			
			title : ['设置条件'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '96%', '96%' ],
			content : "<%=path%>/form/admin/custom/trigger/tarTransit.jsp?iframewindowid=layer04&targetFormId="+targetFormId+"&operateType="+operateType+""
		});		
	}
	
	
	//触发事件数据拷贝设置弹出
	function openDataCopy(params,dataCopyStr,iframe){
		iframeJs = iframe;
		document.getElementById('dataCopyStr').value  = "";
		document.getElementById('dataCopyStr').value = dataCopyStr;
		layer.open({
	    	id:'layer05',
			type : 2,
			
			title : ['设置条件'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '96%', '96%' ],
			content : "<%=path%>/form/admin/custom/trigger/betweenLayer.jsp?iframewindowid=layer05"+params+""
		});			
	}
	
	//触发事件触发点首次满足条件弹出窗口
	function openFirstCondition(condition){
		//打开条件设置窗口
		layer.open({
	    	id:'layer06',
			type : 2,
			
			title : ['设置条件'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '85%', '90%' ],
			content : "<%=path%>/trigger/trigger/condition_condition.action?iframewindowid=layer06&firstCondition="+encodeURI(condition)+""
		});			
	}
	
	//选择条件回调
	 function onlayer06Close(data){
		 if(document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow.Matrix){
			var iframe = document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
		 }else{
			var iframe = document.getElementsByTagName("iframe")[2].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
		 }
		 if(data!=null){
			 var result = eval("("+data+")");
			 iframe.Matrix.setFormItemValue('inputTextArea002',result.conditionText);
			 iframe.Matrix.setFormItemValue('conditionVal',result.conditionVal);
			 
		}else if(typeof(data) == "undefined"){

		}else{
			 iframe.Matrix.setFormItemValue('inputTextArea002',"");
			 iframe.Matrix.setFormItemValue('conditionVal',"");
		}
	 }
	
	//触发事件消息模板弹出窗口	
	function openMsgContent(msgContent){
		layer.open({
	    	id:'layer07',
			type : 2,
			
			title : ['设置条件'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '85%', '90%' ],
			content : "<%=path%>/trigger/condition_loadMsgContent.action?iframewindowid=layer07&msgContent="+encodeURI(msgContent)+""
		});			
	}
	
	//触发事件消息模板弹出窗口选择回调
	 function onlayer07Close(data){
		 if(document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow.Matrix){
			var iframe = document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
		 }else{
			var iframe = document.getElementsByTagName("iframe")[2].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
		 }
		 if(data!=null){
			 var result = eval("("+data+")");
			 iframe.Matrix.setFormItemValue('inputTextArea004',result.msgContentText);
			 iframe.Matrix.setFormItemValue('msgContentVal',result.msgContentVal);
			 
		}else if(typeof(data) == "undefined"){

		}else{
			 iframe.Matrix.setFormItemValue('inputTextArea004',"");
			 iframe.Matrix.setFormItemValue('msgContentVal',"");
		}
	 }
</script>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto;">
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
				"minimizeButton","maximizeButton","closeButton"
			]
			
			
	});
	MMainDialog.hide();
	
	isc.Window.create({
			ID:"MFormActionTarget",
			id:"FormActionTarget",
			name:"FormActionTarget",
			autoCenter: true,
			position:"absolute",
			height: "500px",
			width: "900px",
			title: "test",
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
				"minimizeButton","maximizeButton","closeButton"
			]
			
	});
	MFormActionTarget.hide();
	
	
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
								"headerIcon",
								"headerLabel",
								"closeButton"
							]
							
					});
					
					
	
	
	</script>
<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"/workbench/jsp/console/formmanager/formdesign/BasicInputText.form",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form"
	style="margin: 0px; height: 100%;overflow:hidden;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState"
	id="javax.faces.ViewState" value="j_id7:j_id8" /> <input type="hidden"
	id="matrix_current_page_id" name="matrix_current_page_id"
	value="/console/formmanager/formdesign/BasicInputText" />
	<input type="hidden" id="formulaSetId" name="formulaSetId"
					value="" />
<table id="table0css" jsId="table0css" 
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
	<tr id="j_id2" jsId="j_id2">
		<td id="j_id3" jsId="j_id3" colspan="1" height="60px"
			rowspan="1" style="height: 60px;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);">
						<br>
			&nbsp;&nbsp;&nbsp;描述:&nbsp;&nbsp;&nbsp;请在下面标签页中设置表单属性及相关信息,完成后点击保存确认.
			
			</td>
	</tr>
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" colspan="1" rowspan="1" >
<div id="tabContainer0_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;" >
	<script> var MtabContainer0 = isc.TabSet.create({ID:"MtabContainer0",displayId:"tabContainer0_div",height: "100%",width: "100%",position: "relative",align: "center",tabBarPosition: "top",tabBarAlign: "left",showPaneContainerEdges: false,showTabPicker: true,showTabScroller: true,
		tabBarControls : [isc.MatrixHTMLFlow.create({ID:"MtabContainer0Bar0",width:"300px",contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"}) ],
		tabs: [ 
			{title: "基本信息",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel0",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=form&command=editPart&mode=propertyedit&page=basic"})},
<%		if(MFormContext.getPhaseId() == 2 || MFormContext.getPhaseId() == 3){  //设计开发阶段再显示
%>
			{title: "表单变量",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel1",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/designer/formDesign_loadFormVarListPage.action"})},
			{title: "表单事件",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel5",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form/admin/designer/form/formEvent.jsp"})},
			{title: "隐藏项",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel2",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form/admin/designer/form/formHiddens.jsp"})},
<%}%>
<%		if(!(MFormContext.getPhaseId() == 2 || MFormContext.getPhaseId() == 3)){  //设计开发阶段再显示
%>
			{title: "数据带入",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel1",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/mapping/dataMapping_loadDataGrid.action"})},
			{title: "数据计算",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel21",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/formula/formula_queryAll.action"})},
			{title: "触发事件",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel22",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form/admin/custom/trigger/triggerSet.jsp"})},
<%
}
%>
<%		if(MFormContext.getPhaseId() == 2 || MFormContext.getPhaseId() == 3){  //设计开发阶段再显示
%>
			{title: "授权控件",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel4",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=authItem&command=list&mode=propertyedit&level=subItem"})}
<%	
}
			%>
			  ] });
			document.getElementById('tabContainer0_div').style.display='none';
			</script>
			</div><div id="tabContainer0Bar0_div2" style="text-align:right"  class="matrixInline"></div>
<script>document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));</script>
<%		if(MFormContext.getPhaseId() == 2 || MFormContext.getPhaseId() == 3){  //设计开发阶段再显示
%>
<%	
}
			%>
<script>
isc.Page.setEvent(isc.EH.LOAD,
			function(){
				MtabContainer0.resizeTo(0,0);
				MtabContainer0.resizeTo('100%','100%');
			}
			,isc.Page.FIRE_ONCE
		);

document.getElementById('tabContainer0_div').style.display='';</script></div>
		</td>		
	</tr>
		<tr >
	<td style="height:40px;"/>
	</tr>
	
		<tr id="j_id190" jsId="j_id190">
		<td id="j_id191" jsId="j_id191" height="42px" style="border-bottom: 1px solid white; border-right: 1px solid white;text-align: center; bottom: 0px; left: 0px;padding-right: 4px;background: #f2f2f2;width: 100%; height: 42px;"
			colspan="1" rowspan="1">
			<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="width: 80px; position: relative; height: 30px;">
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
				Matrix.showMask();
				parent.isc.MH.updateComponent();
				
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);

			Matrix.hideMask();
		};
		
		function callbackFun(response) {
		    var data2 = isc.JSON.decode(response.data);
			Matrix.closeWindow(data2);
 		}
		
		</script></div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="width: 80px; position: relative;; height: 30px;">
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
				//Matrix.showMask();
				parent.isc.MH.cancelUpdateComponent();
				
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);

			//this.hide();			
			Matrix.hideMask();
		};
	</script></div>
		<div id="ToolBar0_div" style="width: 100%; overflow: hidden;"><script>isc.ToolStrip.create({ID:"MToolBar0",displayId:"ToolBar0_div",width: "100%",height: "*",position: "relative",align: "right",members: ["separator"] });isc.Page.setEvent(isc.EH.RESIZE,"MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');",null);</script></div>
		</td>
	</tr>
	
</table>
<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
<input id="dataCopyStr" type="hidden" name="dataCopyStr" value="" />
<input id="tarForm" type="hidden" name="tarForm" value="" />
<input id="firstCondition" type="hidden" name="firstCondition" value="" />
</form>
<script>//MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>

<script>
			isc.Window.create( {
				ID : "Mparent",
				id : "parent",
				name : "parent",
				autoCenter : true,
				position : "absolute",
				height : "100%",
				width : "100%",
				title : "首次满足条件",
				canDragReposition : true,
				showMinimizeButton : false,
				showMaximizeButton : false,
				showCloseButton : true,
				showModalMask : false,
				modalMaskOpacity : 0,
				isModal : true,
				autoDraw : false,
				headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
						"maximizeButton", "closeButton" ],
				showFooter : false
			});
		</script>
		<script>
			Mparent.hide();
		</script>
	<script>
			isc.Window.create( {
				ID : "Mpdailog",
				id : "pdailog",
				name : "pdailog",
				autoCenter : true,
				position : "absolute",
				height : "100%",
				width : "100%",
				title : "目标数据",
				canDragReposition : true,
				showMinimizeButton : false,
				showMaximizeButton : false,
				showCloseButton : true,
				showModalMask : false,
				modalMaskOpacity : 0,
				isModal : true,
				autoDraw : false,
				headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
						"maximizeButton", "closeButton" ],
				showFooter : false
			});
		</script>
		<script>
			Mpdailog.hide();
		</script>
	
</body>
</html>