<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            sectionStack!
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
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
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%;">
<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form"
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
<table
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%;table-layout:fixed">
	<tr>
		<td style="height: 60px;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);"
			><br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请配置属性
			</td>
	</tr>

	<tr>
		<td>
<div id="tabContainer0_div" class="matrixComponentDiv" style="width:100%;height:100%;;position:relative;" >
	<script> var MtabContainer0 = isc.TabSet.create({ID:"MtabContainer0",displayId:"tabContainer0_div",height: "100%",width: "100%",position: "relative",align: "center",tabBarPosition: "top",tabBarAlign: "left",showPaneContainerEdges: false,showTabPicker: true,showTabScroller: true,
		tabs: [ 
			{title: "基本信息",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel0",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=SectionStack&command=editPart&page=edit&mode=propertyedit"})},
			{title: "抽屉信息",pane:isc.HTMLPane.create({ID:"MtabContainer0Panel1",height: "100%",overflow: "hidden",autoDraw: false,showEdges:false,contentsType:"page",
			contentsURL:"<%=request.getContextPath()%>/form.daction?componentType=Section&command=list&level=subItem&mode=propertyedit"})}
			  ] });
			document.getElementById('tabContainer0_div').style.display='none';
			</script>
			</div>
		<script>
			document.getElementById('tabContainer0_div').style.display='';
			isc.Page.setEvent(isc.EH.LOAD,
                 	function(){
                 		MtabContainer0.resizeTo(0,0);MtabContainer0.resizeTo('100%','100%');
                 		isc.Page.setEvent(isc.EH.RESIZE,"MtabContainer0.resizeTo(0,0);MtabContainer0.resizeTo('100%','100%');",null);
                  },
                  null
               );
		</script>
		</td>		
	</tr>
	
	<tr id="j_id490" jsId="j_id49">
		<td class="cmdLayout" colspan="2" style="border: 0px;">
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
				Matrix.showMask();
				
				parent.isc.MH.updateComponent();
				
				Matrix.hideMask();
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
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

				parent.isc.MH.cancelUpdateComponent();

				Matrix.hideMask();
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
		};
	</script></div>
		</td>
	</tr>
	
	
</table>
<input id="iframewindowid" type="hidden" name="iframewindowid" value="" />
</form>
<script>//MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>


</body>
</html>