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
	<font size=4;>非定制:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog();" style="font-size:20px;text-decoration:none;">弹出编辑非定制人工活动窗口</a>
	<br/><br/><br/>
	<font size=4;>定  制:</font>&nbsp;&nbsp;&nbsp;<a href="javascript:showDialog('custom');" style="font-size:20px;text-decoration:none;">弹出编辑定制人工活动窗口</a>
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
								//initSrc:"<%=request.getContextPath()%>/editor/editor_getCurActivityEditProperty.action"
								initSrc:'<%=request.getContextPath()%>/editor/activity/editActProMainPage.jsp?activityId=1065253125525',
								src:'<%=request.getContextPath()%>/editor/activity/editActProMainPage.jsp?activityId=1065253125525' 
							});
				</script>

</div>

</body>
</html>