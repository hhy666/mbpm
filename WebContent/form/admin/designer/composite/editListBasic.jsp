<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>editListBasic</title>
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
<div id='matrixMask' name='matrixMask' class='matrixMask' style='display:none;'> </div>
<jsp:include page="/form/admin/common/loading.jsp" />
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
	</script> <script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"<%=request.getContextPath()%>/jsp/console/formmanager/formdesign/BasicInputText.form",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
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
		<td
			style="height: 60px; background-image: url(<%= request . getContextPath() %>/matrix/resource/images/probanner.jpg);">
		<br>
		&nbsp;&nbsp;&nbsp;导航:&nbsp;&nbsp;&nbsp; <b>基本信息</b>--> <a
			href="<%=request.getContextPath()%>/form/admin/designer/composite/editListDataFields.jsp">数据项</a>-->
		<a
			href="<%=request.getContextPath()%>/form/admin/designer/composite/editListActions.jsp">操作列表</a>
		</td>
	</tr>
	<tr>
		<td>
		<table style="border-collapse:collapse;border-spacing:0px; height: 100%; width: 100%;">
			<tr>
				<td style="width: 160px;overflow:hidden;height:100%;">
					<table style="border-collapse:collapse;border-spacing:0px;border:0;height: 100%; width: 100%;">
						<tr><td style="height:50px;background-image: url(<%= request . getContextPath() %>/matrix/resource/images/editlist/title.jpg);"></td></tr>
						<tr><td style="background-image: url(<%= request . getContextPath() %>/matrix/resource/images/editlist/bg.jpg);"></td></tr>
						<tr><td style="height:200px;background-image: url(<%= request . getContextPath() %>/matrix/resource/images/editlist/logo.jpg);"></td></tr>
					</table>
				</td>
				<td>
					 <iframe id="iframe1" height="100%" width="100%" frameborder="0" src="<%=request.getContextPath() %>/form.daction?componentType=EditList&command=editPart&page=first&mode=propertyedit">
					</iframe>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		
		<td style="height:28px;overflow:hidden;">
		<script>isc.ToolStripButton.create({ID:"MToolBarItem3",icon:Matrix.getActionIcon("left"),title: "上一步",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem3.click=function(){
			Matrix.showMask();
			document.getElementById('Form0').action="<%=request.getContextPath()%>/form/admin/designer/composite/editListInfo.jsp";
			document.getElementById('Form0').submit();
			Matrix.hideMask();
			}
			</script> 
			
			
			<script>isc.ToolStripButton.create({ID:"MToolBarItem4",icon:Matrix.getActionIcon("right"),title: "下一步",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem4.click=function(){
			Matrix.showMask();
			document.getElementById('Form0').action="<%=request.getContextPath()%>/form/admin/designer/composite/editListDataFields.jsp";
			document.getElementById('Form0').submit();
			Matrix.hideMask();
			}
			</script> 
			
			<script>isc.ToolStripButton.create({ID:"MToolBarItem1",icon:Matrix.getActionIcon("save"),title: "完成",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem1.click=function(){
			Matrix.showMask();
			parent.isc.MH.updateComponent();	
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
			Matrix.hideMask();
			}
			</script> <script>isc.ToolStripButton.create({ID:"MToolBarItem2",icon:Matrix.getActionIcon("exit"),title: "关闭",showDisabledIcon:false,showDownIcon:false });
			MToolBarItem3.setDisabled(true);
			//MToolBarItem1.setDisabled(true);
			MToolBarItem2.click=function(){
			Matrix.showMask();

			parent.isc.MH.cancelUpdateComponent();	
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
			Matrix.hideMask();}</script>
		<div id="ToolBar0_div"
			style="width: 100%; height: 28px; overflow: hidden;"><script>
		
		isc.ToolStrip.create({ID:"MToolBar0",displayId:"ToolBar0_div",width: "100%",height: "28px",position: "relative",align: "right",members: [ MToolBarItem3,"separator",MToolBarItem4,"separator",MToolBarItem1,"separator",MToolBarItem2 ] });
		
//		isc.Page.setEvent(isc.EH.RESIZE,"MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');",null);
		
		</script></div>
		</td>
	</tr>
</table>
<input id="iframewindowid" type="hidden" name="iframewindowid" value="" />
</form>

</div>


</body>
</html>