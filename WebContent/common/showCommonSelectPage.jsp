<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>打开用户/部门选择页面</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			function createNewDialog(){
				isc.Window.create({
							ID:"MDialog",
							id:"Dialog",
							name:"Dialog",
							position:"absolute",
							height: "80%",
							width: "70%",
							title:"",
							autoCenter: true,
							animateMinimize: false,
							canDragReposition: true,
							showHeaderIcon:false,
							showTitle:true,
							showMinimizeButton:false,
							showMaximizeButton:false,
							howCloseButton:true,
							showModalMask: false,
							isModal:true,
							autoDraw: false							
				});
			}
			
			function onDialogClose(data){
				Matrix.setFormItemValue('id',data.userId);
			}
		</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 				ID:"MForm0",
 				name:"MForm0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden"/>
	<input name="arg" id="arg" type="hidden" />
	<input name="type" id="type" type="hidden" />
	<input name="activityId" id="activityId" type="hidden" />
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<div style="width:100%;height:100;margin:0 auto;text-align:center;">
	
		<div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
				<script>isc.Button.create({
								ID:"Mbutton001",
								name:"button001",
								title:"单选用户",
								displayId:"button001_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton001.click=function(){
									Matrix.showMask();
									var dialog = Matrix.getMatrixComponentById("MDialog");
									if(dialog==null){
										createNewDialog();
									}
									MDialog.initSrc = "<%=request.getContextPath()%>/common/userSelect.jsp";
									MDialog.title = "单选用户";
									Matrix.showWindow('Dialog');
									Matrix.hideMask();
								};
				</script>
		</div>
		<br>
		<hr>
		<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
				<script>isc.Button.create({
								ID:"Mbutton002",
								name:"button002",
								title:"多选用户",
								displayId:"button002_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton002.click=function(){
									Matrix.showMask();
									var dialog = Matrix.getMatrixComponentById("MDialog");
									if(dialog==null){
										createNewDialog();
									}
									MDialog.initSrc = "<%=request.getContextPath()%>/common/usersSelect.jsp";
									MDialog.title = "多选用户";
									Matrix.showWindow('Dialog');
									Matrix.hideMask();
								};
				</script>
		</div>
	<br><hr>
	<div id="button003_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
				<script>isc.Button.create({
								ID:"Mbutton003",
								name:"button003",
								title:"单选部门",
								displayId:"button003_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton003.click=function(){
									Matrix.showMask();
									var dialog = Matrix.getMatrixComponentById("MDialog");
									if(dialog==null){
										createNewDialog();
									}
									MDialog.initSrc = "<%=request.getContextPath()%>/select/dept_queryDeptInfoList.action";
									MDialog.title = "单选部门";
									Matrix.showWindow('Dialog');
									Matrix.hideMask();
								};
				</script>
		</div>
		
		<br><hr>
		<div id="button004_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
				<script>isc.Button.create({
								ID:"Mbutton004",
								name:"button004",
								title:"多选部门",
								displayId:"button004_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton004.click=function(){
									Matrix.showMask();
									var dialog = Matrix.getMatrixComponentById("MDialog");
									if(dialog==null){
										createNewDialog();
									}
									MDialog.initSrc = "<%=request.getContextPath()%>/common/deptsSelect.jsp";
									MDialog.title = "多选部门";
									Matrix.showWindow('Dialog');
									Matrix.hideMask();
								};
				</script>
		</div>
	</div>
	
		<input name="id" id="id" type="text" />
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
					<script>
						isc.Window.create({
								ID:"MDialog1",
								id:"Dialog1",
								name:"Dialog1",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "单选用户",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								//getParamsFun:getParamsForDialog,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								initSrc:'<%=request.getContextPath()%>/select/user_queryUserInfoList.action',
								src:'<%=request.getContextPath()%>/select/user_queryUserInfoList.action' 
							});
				</script>
				
				<script>
						isc.Window.create({
								ID:"MDialog2",
								id:"Dialog2",
								name:"Dialog2",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "多选用户",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								//getParamsFun:getParamsForDialog1,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								initSrc:'<%=request.getContextPath()%>/common/usersSelect.jsp',
								src:'<%=request.getContextPath()%>/editor/flow/editFlowProMainPage.jsp?optType=2&processId=5a0b5010-03b5-45a8-8b30-33e71290b135&processdid=docFlow' 
							 
							});
				</script>
				
				
				
				<script>
					function getParamsForDialog2(){
							var type = Matrix.getFormItemValue('type');
							var value = "";
							if(type!=null && type!='undefined'&&type.length>0){
								value+="&type="+type;
							}
							var activityId = Matrix.getFormItemValue('activityId');
							if(activityId!=null && activityId!='undefined'&&activityId.length>0){
								value+="&activityId="+activityId;
							}
							var containerId = Matrix.getFormItemValue('containerId');
							if(containerId!=null && containerId.length>0){
								value+="&containerId="+containerId;
							}
							return value;
						}
						isc.Window.create({
								ID:"MDialog2",
								id:"Dialog2",
								name:"Dialog2",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								getParamsFun:getParamsForDialog2,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								initSrc:"<%=request.getContextPath()%>/editor/frame/loadLogicActivityTreeNodePage.jsp?processdid=testHumanTaskAct",
								src:"<%=request.getContextPath()%>/editor/frame/loadLogicActivityTreeNodePage.jsp?processdid=testHumanTaskAct"
							});
				</script>
				
				<script>
				function getParamsForDialog3(){
							var value = "";
							var containerId = Matrix.getFormItemValue('containerId');
							if(containerId!=null && containerId.length>0){
								value+="&containerId="+containerId;
							}
							return value;
						}
						//活动连线弹出框
						isc.Window.create({
								ID:"MDialog3",
								id:"Dialog3",
								name:"Dialog3",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								getParamsFun:getParamsForDialog3,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								initSrc:"<%=request.getContextPath()%>/editor/frame/loadActivityLineTreeNodePage.jsp?type=ActivityLine&processdid=testHumanTaskAct&activityId=331341085011",
								src:"<%=request.getContextPath()%>/editor/frame/loadActivityLineTreeNodePage.jsp?type=ActivityLine&processdid=testHumanTaskAct&activityId=331341085011"
							});
				</script>
				
				<script>
					function getParamsForDialog4(){
							var type = Matrix.getFormItemValue('type');
							var value = "";
							if(type!=null && type!='undefined'&&type.length>0){
								value+="&type="+type;
							}
							var activityId = Matrix.getFormItemValue('activityId');
							if(activityId!=null && activityId!='undefined'&&activityId.length>0){
								value+="&activityId="+activityId;
							}
							var containerId = Matrix.getFormItemValue('containerId');
							if(containerId!=null && containerId.length>0){
								value+="&containerId="+containerId;
							}
							return value;
						}
						//泳道弹出框
						isc.Window.create({
								ID:"MDialog4",
								id:"Dialog4",
								name:"Dialog4",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								getParamsFun:getParamsForDialog4,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								initSrc:"<%=request.getContextPath()%>/editor/frame/loadSwimLineTreeNodePage.jsp?processdid=swimline",
								src:"<%=request.getContextPath()%>/editor/frame/loadSwimLineTreeNodePage.jsp?processdid=swimline"
							});
				</script>
				
				<script>
					function getParamsForDialog5(){
							var type = Matrix.getFormItemValue('type');
							var value = "";
							if(type!=null && type!='undefined'&&type.length>0){
								value+="&type="+type;
							}
							var activityId = Matrix.getFormItemValue('activityId');
							if(activityId!=null && activityId!='undefined'&&activityId.length>0){
								value+="&activityId="+activityId;
							}
							var containerId = Matrix.getFormItemValue('containerId');
							if(containerId!=null && containerId.length>0){
								value+="&containerId="+containerId;
							}
							return value;
						}
						//基本活动  人工活动  自由活动  外部子流程  内部子流程
						isc.Window.create({
								ID:"MDialog5",
								id:"Dialog5",
								name:"Dialog5",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								getParamsFun:getParamsForDialog5,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								//type :"HumanTask","AutomaticAct","SubflowAct","BlockAct"
								initSrc:"<%=request.getContextPath()%>/editor/frame/loadBasicActivityTreeNodePage.jsp?processdid=testHumanTaskAct",
								src:"<%=request.getContextPath()%>/editor/frame/loadBasicActivityTreeNodePage.jsp?processdid=testHumanTaskAct"
							});
				</script>
				

</div>

</body>
</html>