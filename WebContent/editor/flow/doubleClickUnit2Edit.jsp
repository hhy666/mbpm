<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>表单</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			function showDialog(){
				Matrix.setFormItemValue('arg','');
				Matrix.showWindow("Dialog");
				MDialog.setWidth("1100px");
				MDialog.setHeight("700px");
			}
			
			function showDialog(arg){
				Matrix.setFormItemValue('arg',arg);
				Matrix.showWindow("Dialog");
				MDialog.setWidth("1100px");
				MDialog.setHeight("700px");
			}
			
			//基本活动
			var basicAct = ['HumanTask','AutomaticAct','SubflowAct','BlockAct'];
			//逻辑活动
			var logicAct = ['StopAct','ConditionAct','SplitAct','JoinAct'];
			//流程泳道
			var swimLine = ['HSwimline','VSwimline'];
			function showDialog2(arg){
				Matrix.showWindow("Dialog2");
				if(basicAct.contains(arg)){//基本活动
					var activityId = "115555496898";
					var processdid = "UseCarFlow";
					MDialog2.initSrc = "<%=request.getContextPath()%>/editor/activity/editActProMainPage1.jsp?type="+arg+"&activityId="+activityId+"&processdid="+processdid;
				}else if(logicAct.contains(arg)){//逻辑活动
					var activityId = "";
					if(arg=='StopAct'){
						activityId = "1612207988";
					}else if(arg=='ConditionAct'){
						activityId = "2381594099";
					}else if(arg=='SplitAct'){
						activityId = "2382047510";
					}else if(arg=='JoinAct'){
						activityId = "2382177511";
					}
					var processdid="tttt";
					MDialog2.initSrc="<%=request.getContextPath()%>/editor/logicactivity/editLogicActivityPro.jsp?type="+arg+"&activityId="+activityId+"&processdid="+processdid;
				}else if(swimLine.contains(arg)){//泳道
					MDialog2.initSrc = "<%=request.getContextPath()%>/editor/flow/doubleClickUnitGetTreeNodePage.jsp?type="+arg+"&activityId="+activityId+"&processdid="+processdid;;
				}else if(arg=='ActivityLine'){//活动连线
					var activityId = "2383773913";
					var processdid = "tttt";
					MDialog2.initSrc = "<%=request.getContextPath()%>/editor/flow/doubleClickUnitGetTreeNodePage.jsp?type="+arg+"&activityId="+activityId+"&processdid="+processdid;;
				}
				MDialog2.setWidth("1100px");
				MDialog2.setHeight("700px");
			}
			
			function showProcessDialog(){
				Matrix.showWindow("Dialog1");
				MDialog1.setWidth("1100px");
				MDialog1.setHeight("700px");
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
	<div style="width:100%;height:100;margin:0 auto;text-align:center;">
	
	
	<font size=4;>活动连线:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('ActivityLine');" style="font-size:20px;text-decoration:none;">活动连线</a>
	<br>
	基本活动：<br>
	<font size=4;>人工活动:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('HumanTask');" style="font-size:20px;text-decoration:none;">人工活动</a>
	<br/>
	<font size=4;>自由活动:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('AutomaticAct');" style="font-size:20px;text-decoration:none;">自由活动</a>
	<br/>
	<font size=4;>内部子流程:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('BlockAct');" style="font-size:20px;text-decoration:none;">内部子流程</a>
	<br/>
	<font size=4;>外部子流程:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('SubflowAct');" style="font-size:20px;text-decoration:none;">外部子流程</a>
	<br/>
	逻辑活动：<br>
	<font size=4;>完成:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('StopAct');" style="font-size:20px;text-decoration:none;">完成</a>
	<br/>
	<font size=4;>条件活动:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('ConditionAct');" style="font-size:20px;text-decoration:none;">条件活动</a>
	<br/>
	<font size=4;>并发活动:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('SplitAct');" style="font-size:20px;text-decoration:none;">并发活动</a>
	<br/>
	<font size=4;>合并活动:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('JoinAct');" style="font-size:20px;text-decoration:none;">合并活动</a>
	<br/>
	流程泳道：<br>
	<font size=4;>横向泳道:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('HSwimline');" style="font-size:20px;text-decoration:none;">横向泳道</a>
	<br/>
	<font size=4;>纵向泳道:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog2('VSwimline');" style="font-size:20px;text-decoration:none;">纵向泳道</a>
	<br/><br><br>
	流程:<br>
	<font size=4;>编辑流程:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showProcessDialog();" style="font-size:20px;text-decoration:none;">弹出流程属性编辑窗口</a>
	
	
	
	</div>
	
	</div>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
<script>function getParamsForDialog(){
							var arg = Matrix.getFormItemValue('arg');
							var value = "";
							if(arg!=null && arg!='undefined'&&arg.length>0){
								value="custom="+arg;
							}
							
							return value;
						}
						isc.Window.create({
								ID:"MDialog",
								id:"Dialog",
								name:"Dialog",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "编辑活动属性",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								getParamsFun:getParamsForDialog,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								//initSrc:'<%=request.getContextPath()%>/editor/activity/editActProMainPage.jsp?activityId=82932263458',
								//src:'<%=request.getContextPath()%>/editor/activity/editActProMainPage.jsp?activityId=82932263458' 
								initSrc:'<%=request.getContextPath()%>/editor/activity/editActProMainPage.jsp?optType=1&activityId=82932263458',
								src:'<%=request.getContextPath()%>/editor/activity/editActProMainPage.jsp?optType=1&activityId=82932263458' 
							});
				</script>
				
				<script>function getParamsForDialog1(){
							var arg = Matrix.getFormItemValue('arg');
							var value = "";
							if(arg!=null && arg!='undefined'&&arg.length>0){
								value="custom="+arg;
							}
							
							return value;
						}
						isc.Window.create({
								ID:"MDialog1",
								id:"Dialog1",
								name:"Dialog1",
								position:"absolute",
								height: "400px",
								width: "400px",
								title: "编辑流程属性",
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
//								initSrc:'<%=request.getContextPath()%>/editor/flow/editFlowProMainPage.jsp?processdid=docFlow',
//								src:'<%=request.getContextPath()%>/editor/flow/editFlowProMainPage.jsp?processdid=docFlow' 
								initSrc:'<%=request.getContextPath()%>/editor/flow/editFlowProMainPage.jsp?optType=2&processId=5a0b5010-03b5-45a8-8b30-33e71290b135',
								src:'<%=request.getContextPath()%>/editor/flow/editFlowProMainPage.jsp?optType=2&processId=5a0b5010-03b5-45a8-8b30-33e71290b135' 
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
								title: "",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								getParamsFun:getParamsForDialog,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
							});
				</script>
				

</div>

</body>
</html>