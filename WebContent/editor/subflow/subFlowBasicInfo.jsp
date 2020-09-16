<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.matrix.template.object.activity.SubFlow" %>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>流程基本信息</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style type="">
		#font2{
		font-size:16px;
		margin-left:10px;
		font-weight:bold;
	}
	#td107{
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
		</style>
		<script type="text/javascript">
			
		</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var Mform0=isc.MatrixForm.create({
 				ID:"Mform0",
 				name:"Mform0",
 				position:"absolute",
 				action:"<%=request.getContextPath()%>/editor/process_getCurProcessVarible.action",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  //<%=request.getContextPath()%>/editor/editor_.action
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/editor/process_getCurProcessVarible.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input type="hidden" name="pdid" id="pdid" value="${pdid}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType }"/>
	<table id="table001" class="tableLayout" style="width:100%;" >
			<tr id="tr107" name="tr107">
				<td id="td107" name="td107" colspan="4" style="width:100%;"><font id="font2">基本信息</font></td>
			</tr>
		<tr id="tr001">
			
			<td id="td001" class="tdLayout" colspan="1" style="width:20%;text-align:right;">
				<label id="label001" name="label001" id="label001">
					编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
				</label>
			</td>
			<td id="td002" class="tdLayout" colspan="3" style="width:80%;">
				<div id="input001_div" eventProxy="Mform0" class="matrixInline" style="width:100%;"></div>
				<script> var input001=isc.TextItem.create({
								ID:"Minput001",
								name:"input001",
								editorType:"TextItem",
								displayId:"input001_div",
								value:"${activity.id}",
								position:"relative",
								canEdit:false,
								autoDraw:false,
								width:"100%"
								});
								Mform0.addField(input001);
				</script>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLayout" colspan="1" style="width:20%;text-align:right;">
				<label id="label002" name="label002" id="label002">
					名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：
				</label>
			</td>
			<td id="td004" class="tdLayout" colspan="3" style="width:80%;">
				<div id="input002_div" eventProxy="Mform0" class="matrixInline" style="width:100%;"></div>
				<script> var input002=isc.TextItem.create({
								ID:"Minput002",
								name:"input002",
								editorType:"TextItem",
								displayId:"input002_div",
								value:"${activity.name}",
								position:"relative",
								autoDraw:false,
								width:"100%"
								});
								Mform0.addField(input002);
				</script>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="tdLayout" colspan="1" style="width:20%;text-align:right;">
				<label id="label004" name="label004" id="label004">
					关联子流程：
				</label>
			</td>
			<td id="td008" class="tdLayout" colspan="1" style="width:30%;border-right:0px;">
				<table id='popupSelectDialog001_table'
								style='width: 150px; height: 22px; table-layout: fixed; border-collapse: collapse; border-spacing: 0; padding: 0; margin: 0;'>
								<tr>
									<td style='padding: 0;'>
										<div id="popupSelectDialog001_div"
											style='width: 100%; height: 100%' eventProxy="Mform0"></div>
									</td>
									<td
										style='width: 20px; height: 100%; text-align: center; padding: 0;'>
										<div id='popupSelectDialog001_button_div'
											style='position: relative; width: 100%; height: 100%; vertical-align: middle;'
											class='matrixInline'>
											<script>
	isc.ImgButton.create( {
		ID : "MpopupSelectDialog001_button",
		name : "popupSelectDialog001_button",
		displayId : "popupSelectDialog001_button_div",
		showDisabled : false,
		showDisabledIcon : false,
		showDown : false,
		showDownIcon : false,
		showRollOver : false,
		showRollOverIcon : false,
		position : "relative",
		width : 16,
		height : 16,
	
		src : "[skin]/images/matrix/actions/query_advance.png"
	});
	MpopupSelectDialog001_button.click = function() {

		Matrix.showMask();

		var x = eval("Matrix.showWindow('popupSelectDialog001Dialog');");
		if (x != null && x == false) {
			Matrix.hideMask();
			return false;
		}
		Matrix.hideMask();
	};
</script>
										</div>
									</td>
								</tr>
							</table>
							<script>
	var popupSelectDialog001 = isc.TextItem.create( {
		ID : "MpopupSelectDialog001",
		name : "popupSelectDialog001",
		editorType : "TextItem",
		displayId : "popupSelectDialog001_div",
		width : "100%",
		position : "relative",
		value:"${activity.implementation.name}",
		autoDraw : false
	});
	Mform0.addField(popupSelectDialog001);
</script>
							<script>
	function getParamsForpopupSelectDialog001Dialog() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MpopupSelectDialog001Dialog",
		id : "popupSelectDialog001Dialog",
		name : "popupSelectDialog001Dialog",
		position : "absolute",
		height : "60%",
		width : "25%",
		title : "选择流程",
		autoCenter : true,
		animateMinimize : false,
		canDragReposition : false,
		showHeaderIcon : false,
		showTitle : true,
		showMinimizeButton : false,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		isModal : true,
		autoDraw : false,
		getParamsFun : getParamsForpopupSelectDialog001Dialog,
		initSrc : "/moffice/editor/common/selectProcessTree.jsp",
		src : "/moffice/editor/common/selectProcessTree.jsp"
	});
	function onpopupSelectDialog001DialogClose(data) {

		if (data == null)
			return true;
		if (isc.isA.String(data))
			data = isc.JSON.decode(data);
		if (data['text'] != null) {
			var mform = Matrix.getMatrixComponentById('form0');
			var field = mform.getField('popupSelectDialog001');
			if (field != null) {
				mform.setValue('popupSelectDialog001', data['text']);
				if (field.editorExit != null
						&& isc.isA.Function(field.editorExit))
					field.editorExit(mform, field);
			} else {
				field = document.getElementById('popupSelectDialog001');
				if (field != null) {
					field.value = data['text']
				}
			}
		}
		if (data['pdid'] != null) {
			var mform = Matrix.getMatrixComponentById('form0');
			var field = mform.getField('pdid');
			if (field != null) {
				mform.setValue('pdid', data['pdid']);
				if (field.editorExit != null
						&& isc.isA.Function(field.editorExit))
					field.editorExit(mform, field);
			} else {
				field = document.getElementById('pdid');
				if (field != null) {
					field.value = data['pdid']
				}
			}
		}

	}
</script>
						
			</td>
			<td id="td109" class="tdLayout" colspan="1" style="width:20%;text-align:right;border:0px;">
				
			</td>
			<td id="td010" class="tdLayout" colspan="1" style="width:30%;border:0px;">
				
			</td>
		</tr>
		<tr id="tr010">
		<td id="td015" class="tdLayout" colspan="1"
			style="width: 20%; text-align: right; border-right: 0px;"><label
			id="label015" name="label015" id="label015"> 定义描述：</label></td>
		<td id="td016" class="tdLayout" colspan="3" style="width: 80%; border-left: 0px;">&nbsp;</td>
	</tr>
	<tr id="tr011">
		<td id="td017" class="tdLayout" colspan="1"
			style="width: 20%; text-align: center; border-right: 0px;"></td>
		<td id="td018" class="tdLayout" colspan="3" style="width:80%; border-left: 0px;">
		<div id="inputTextArea001_div" eventProxy="Mform0"
			class="matrixInline" style="width: 99%;float:left;"></div>
		<script> var inputTextArea001=isc.TextAreaItem.create({
							ID:"MinputTextArea001",
							name:"inputTextArea001",
							editorType:"TextAreaItem",
							displayId:"inputTextArea001_div",
							position:"relative",
							autoDraw:false,
							value:'${activity.description}',
							width:'99%',
							height:70
						});
						Mform0.addField(inputTextArea001);
		</script></td>
	</tr>
	
	<tr id="tr012">
		<td id="td019" class="tdLayout" colspan="1"
			style="width: 20%; text-align: right; border-right: 0px;"><label
			id="label016" name="label016" id="label016"> 实例描述：</label></td>
		<td id="td020" class="tdLayout" colspan="3" style="width: 80%; border-left: 0px;">&nbsp;</td>
	</tr>
	<!--  -->
	
	<tr id="tr013">
		<td id="td021" class="tdLayout" colspan="1"
			style="width: 20%; text-align: center; border-right: 0px;"></td>
		<td id="td022" class="tdLayout" colspan="3" style="width: 80%; border-left: 0px;">
		<div id="inputTextArea002_div" eventProxy="Mform0"
			class="matrixInline" style="width: 85%;height:100%"></div>
		<script> var inputTextArea002=isc.TextAreaItem.create({
							ID:"MinputTextArea002",
							name:"inputTextArea002",
							editorType:"TextAreaItem",
							displayId:"inputTextArea002_div",
							position:"relative",
							autoDraw:false,
							value:'${activity.descXpression}',
							width:'100%',
							height:70
					});
					Mform0.addField(inputTextArea002);</script>
		
		<div id='popupSelectDialog4_button_div' style='position:relative;width:20px;height:100%;vertical-align:middle;' class='matrixInline'></div>
								<script>isc.ImgButton.create({
										ID:"MpopupSelectDialog4_button",
										name:"popupSelectDialog4_button",
										displayId:"popupSelectDialog4_button_div",
										showDisabled:false,
										showDisabledIcon:false,
										showDown:false,
										showDownIcon:false,
										showRollOver:false,
										showRollOverIcon:false,
										position:"relative",
										width:16,height:16,
										src:"[skin]/images/matrix/actions/query.png"});
										MpopupSelectDialog4_button.click=function(){
											Matrix.showMask();
											var x = eval("Matrix.showWindow('popupSelectDialog4Dialog');");
											if(parent.parent.MMainDialog!=null&&parent.parent.MMainDialog!='undefined'){
												parent.parent.MMainDialog.setTitle('流程变量选择窗口');
												parent.parent.MMainDialog.setHeight("400px");
												parent.parent.MMainDialog.setWidth("500px");
											}else{
												parent.MMainDialog.setTitle('流程变量选择窗口');
												parent.MMainDialog.setHeight("400px");
												parent.MMainDialog.setWidth("500px");
											}
											if(x!=null && x==false){
												Matrix.hideMask();
												return false;
											}
											Matrix.hideMask();
										};
								</script>			
			
		</td>
	</tr>
</table>

</form>
<script>
	Mform0.initComplete=true;Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);
</script>


</div>

</body>
</html>