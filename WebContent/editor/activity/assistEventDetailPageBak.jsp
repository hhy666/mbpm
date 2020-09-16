<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>辅助事件详细信息页面</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style type="">
		#font2{
		font-size:14px;
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
		window.onblur=function(){
			saveData();
		}
		
		window.onfocus=function(){
				Matrix.setFormItemValue('editFlag','edit');
		}
		
			function saveData(){
				var editFlag = Matrix.getFormItemValue('editFlag');
				if(editFlag==null || editFlag!='edit'){
					return;
				}else{
					var entityId = Matrix.getFormItemValue("entityId");
					var component = Matrix.getFormItemValue('popupSelectDialog001');//组件名称
					var authId = Matrix.getFormItemValue('authId');//组件编码
					var name = Matrix.getFormItemValue('input002');//名称
					var condition = Matrix.getFormItemValue('popupSelectDialog2').replaceAll("\"","----#&#----");//条件
					var activityId = Matrix.getFormItemValue('activityId');
					var containerId = Matrix.getFormItemValue('containerId');
					
					var txType = McomboBox001.getValue();//事务类型
				
					var json = "{'componentId':'"+authId+"','component':'"+component+"','name':'"+name+"','condition':\""+condition+"\",'containerId':'"+containerId+"','txType':'"+txType+"','entityId':'"+entityId+"','activityId':'"+activityId+"'}";
					var synJson = isc.JSON.decode(json);
					//保存辅助事件的属性
					var url = "<%=request.getContextPath()%>/editor/editor_saveAssistEventDetailProperty.action";
					Matrix.sendRequest(url,synJson,function(){
						return true;
					});
				}
			}
			/**
			window.onfocus=function(){
				Matrix.setFormItemValue('editFlag','edit');
			}
		
			window.onload=function(){
				window.focus();
			}
			**/
			//选择授权信息回调
			function onpopupSelectDialog001DialogClose(data){
				Matrix.setFormItemValue('editFlag','edit');
				if(data!=null){
					var authId = data.id;
					var groupName = data.name;
					Matrix.setFormItemValue('authId',authId);
					Matrix.setFormItemValue('popupSelectDialog001',groupName);
				}
				window.focus();
			}
			function onpopupSelectDialog2DialogClose(data){
				Matrix.setFormItemValue('editFlag','edit');
				if(data!=null){
					Matrix.setFormItemValue('popupSelectDialog2',data.expressName);
					Matrix.setFormItemValue('express',data.express);
					parent.parent.parent.Matrix.setFormItemValue("conditionValue","");
				}
				window.focus();
			}
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
 				action:"<%=request.getContextPath()%>/editor/editor_.action",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/editor/editor_.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input name="authId" id="authId" type="hidden" value="${assistEvent.actionId}"/>
	<input name="data" id="data" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input name="entityId" id="entityId" type="hidden" value="${param.entityId }"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="express" id="express" type="hidden" value="${assistEvent.preCondition.value }"/>
	<table id="table001" class="tableLayout" style="width:100%;" >
		<tr id="tr004">
			<td id="td007" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label004" name="label004" id="label004">
					组件
				</label>
			</td>
			<td id="td008" class="tdLayout" style="width:80%;">
				<table id='popupSelectDialog001_table',style='width:90%;height:22px;table-layout:fixed;border-collapse:collapse;border-spacing:0;padding:0;margin:0;'>
					<tr>
						<td style='padding:0;width:88%;height:100%;'>
							<div id="popupSelectDialog001_div" style='width:300px;height:100%' eventProxy="Mform0" ></div>
						</td>
						<td style='width:20px;height:100%;text-align:center;padding:0;'>
							<div id='popupSelectDialog001_button_div' style='position:relative;width:100%;height:100%;vertical-align:middle;' class='matrixInline'>
								<script>isc.ImgButton.create({
										ID:"MpopupSelectDialog001_button",
										name:"popupSelectDialog001_button",
										displayId:"popupSelectDialog001_button_div",
										showDisabled:false,
										showDisabledIcon:false,
										showDown:false,
										showDownIcon:false,
										showRollOver:false,
										showRollOverIcon:false,
										position:"relative",
										width:16,height:16,
										src:"[skin]/images/matrix/actions/query.png"});
										MpopupSelectDialog001_button.click=function(){
											Matrix.showMask();
											Matrix.setFormItemValue('editFlag','');
											var x = eval("Matrix.showWindow('popupSelectDialog001Dialog');");
												parent.parent.parent.MMainDialog.setTitle('集成组件选择窗口');
												parent.parent.parent.MMainDialog.setHeight("400px");
												parent.parent.parent.MMainDialog.setWidth("500px");
											if(x!=null && x==false){
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
				<script> var popupSelectDialog001=isc.TextItem.create({
								ID:"MpopupSelectDialog001",
								name:"popupSelectDialog001",
								editorType:"TextItem",
								displayId:"popupSelectDialog001_div",
								value:"${componentName}",
								width:"100%",
								position:"relative",
								canEdit:false,
								autoDraw:false
							});
							Mform0.addField(popupSelectDialog001);
							
				</script>
				<script>function getParamsForpopupSelectDialog001Dialog(){
							var params='&';
							var value;
							return params;
						}
						isc.Window.create({
								ID:"MpopupSelectDialog001Dialog",
								id:"popupSelectDialog001Dialog",
								name:"popupSelectDialog001Dialog",
								position:"absolute",
								height: "50%",
								width: "50%",
								title: "",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								autoDraw: false,
								initSrc:'<%=request.getContextPath()%>/editor/editor_getBizComponent.action',
								src:'<%=request.getContextPath()%>/editor/editor_getBizComponent.action',
								targetDialog:'MainDialog'
								
							});
				</script>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label002" name="label002" id="label002">
					名称
				</label>
			</td>
			<td id="td004" class="tdLayout" style="width:80%;">
				<div id="input002_div" eventProxy="Mform0" class="matrixInline" style="width:300px;"></div>
				<script> var input002=isc.TextItem.create({
								ID:"Minput002",
								name:"input002",
								editorType:"TextItem",
								displayId:"input002_div",
								value:"${assistEvent.name}",
								position:"relative",
								autoDraw:false,
								width:"100%"
								});
								Mform0.addField(input002);
				</script>
			</td>
		</tr>
		<tr id="tr005">
			<td id="td009" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label005" name="label005" id="label005">
					条件
				</label>
			</td>
			<td id="td010" class="tdLayout" style="width:80%;">
				<table id='popupSelectDialog001_table',style='width:90%;height:22px;table-layout:fixed;border-collapse:collapse;border-spacing:0;padding:0;margin:0;'>
					<tr>
						<td style='padding:0;width:88%;height:100%;'>
							<div id="popupSelectDialog2_div" style='width:300px;height:100%' eventProxy="Mform0" ></div>
						</td>
						<td style='width:20px;height:100%;text-align:center;padding:0;'>
							<div id='popupSelectDialog2_button_div' style='position:relative;width:100%;height:100%;vertical-align:middle;' class='matrixInline'>
								<div id="popupSelectDialog2_div" style='width:100%;height:100%' eventProxy="Mform0" ></div></td><td style='width:20px;height:100%;text-align:center;padding:0;'><div id='popupSelectDialog2_button_div' style='position:relative;width:100%;height:100%;vertical-align:middle;' class='matrixInline'>
								<script>isc.ImgButton.create({
											ID:"MpopupSelectDialog2_button",
											name:"popupSelectDialog2_button",
											displayId:"popupSelectDialog2_button_div",
											showDisabled:false,
											showDisabledIcon:false,
											showDown:false,
											showDownIcon:false,
											showRollOver:false,
											showRollOverIcon:false,
											position:"relative",
											width:16,height:16,
											src:"[skin]/images/matrix/actions/query.png"
										});
										MpopupSelectDialog2_button.click=function(){
											Matrix.showMask();
											var conditionValue = Matrix.getFormItemValue('popupSelectDialog2');
											if(conditionValue==null ||conditionValue=='undefined' ||conditionValue=='null'){
												conditionValue = "";
											}
											parent.parent.parent.Matrix.setFormItemValue('conditionValue',conditionValue);
											Matrix.setFormItemValue('editFlag','');
											var x = eval("Matrix.showWindow('popupSelectDialog2Dialog');");
												parent.parent.parent.MMainDialog.setTitle('条件编辑窗口');
												parent.parent.parent.MMainDialog.setHeight("600px");
												parent.parent.parent.MMainDialog.setWidth("580px");
											
											if(x!=null && x==false){Matrix.hideMask();return false;}Matrix.hideMask();};</script>
								</div>
								</td></tr></table>
	<script> var popupSelectDialog2=isc.TextItem.create({
							ID:"MpopupSelectDialog2",
							name:"popupSelectDialog2",
							canEdit:false,
							editorType:"TextItem",
							displayId:"popupSelectDialog2_div",
							width:"100%",
							value:"${condition}",
							position:"relative",
							autoDraw:false
						});
						Mform0.addField(popupSelectDialog2);
					</script>
					<script>function getParamsForpopupSelectDialog2Dialog(){
										var params='&';
										var value;
										return params;
									}
								isc.Window.create({
										ID:"MpopupSelectDialog2Dialog",
										id:"popupSelectDialog2Dialog",
										name:"popupSelectDialog2Dialog",
										position:"absolute",
										height: "50%",width: "50%",
										title: "",
										autoCenter: true,
										animateMinimize: false,
										canDragReposition: false,
										showHeaderIcon:false,
										showTitle:true,
										showMinimizeButton:false,
										showMaximizeButton:false,
										showCloseButton:true,
										showModalMask: false,
										isModal:true,
										autoDraw: false,
										initSrc:'<%=request.getContextPath()%>/editor/editor_loadConditionEditDataGridData.action',
										src:'<%=request.getContextPath()%>/editor/editor_loadConditionEditDataGridData.action',
										targetDialog:'MainDialog' 
									});</script>
			</td>
		</tr>
	<tr id="tr003">
			<td id="td005" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label003" name="label003" id="label003">
					事务类型
				</label>
			</td>
			
			<td id="td006" class="tdLayout" style="width:80%;">
				<div id="comboBox001_div" eventProxy="Mform0" class="matrixInline" style="width:300px;"></div>
				<script> var McomboBox001_VM=[]; 
						 var comboBox001=isc.SelectItem.create({
						 		ID:"McomboBox001",
						 		name:"comboBox001",
						 		editorType:"SelectItem",
						 		displayId:"comboBox001_div",
						 		autoDraw:false,
						 		value:'${assistEvent.transactionType=="Emben"?"1":"2"}',
						 		position:"relative",
						 		width:"100%"
						 		});
						 		Mform0.addField(comboBox001);
						 		McomboBox001_VM=['1','2'];
						 		McomboBox001.displayValueMap={'1':'嵌入上级事务中','2':'不支持事务'};
						 		McomboBox001.setValueMap(McomboBox001_VM);
						 		//McomboBox001.setValue('2');
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