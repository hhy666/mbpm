<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>


		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>编辑活动属性</title>
		
		<% 
		 String contextPath = request.getContextPath();
		%>
		<jsp:include page="../form/admin/common/taglib.jsp" />
		<jsp:include page="../form/admin/common/resource.jsp" />
		
		<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
		<style>
			
		</style>
		<script type="text/javascript">
   
</script>	
		
		<script type="text/javascript">
			function changeSelectStatus(){
				var val = McheckBox301.getValue();
				if(val=='1'){
					MpopupSelectDialog002_button.setDisabled(true);
					MpopupSelectDialog002.setDisabled(true);
					MpopupSelectDialog002.setRequired(false);
				}else{
					MpopupSelectDialog002_button.setDisabled(false);
					MpopupSelectDialog002.setDisabled(false);
					MpopupSelectDialog002.setRequired(true);
				}
			}
			window.onload=function(){
				var isSetCalendar = McheckBox301.getValue();
				if(isSetCalendar=="0" || isSetCalendar==""){
					MpopupSelectDialog002_button.setDisabled(true);
					MpopupSelectDialog002.setDisabled(true);
					MpopupSelectDialog002.setRequired(false);
				}else{
					MpopupSelectDialog002_button.setDisabled(false);
					MpopupSelectDialog002.setDisabled(false);
					MpopupSelectDialog002.setRequired(true);
				}
				Minput001.setCanEdit(false);
				Minput002.setCanEdit(false);
			
				
			}
			//双击左边行
		function doubleClick2Select(){
		  var select = MDataGrid004.getSelection();
		  var items = parent.parent.MDataGrid005.getData();
		  if(!items.contains(select[0])){
		  	  items.add(select[0]);
		  }else{
		  	  parent.parent.Matrix.warn("您已经选择了该人员！");
		  }
		  parent.parent.MDataGrid005.setData(items);
		}
		//选择授权信息回调
		function onpopupSelectDialog001DialogClose(data){
			if(data!=null){
				var authId = data.uuid;
				var groupName = data.groupName;
				Matrix.setFormItemValue('authId',authId);
				Matrix.setFormItemValue('popupSelectDialog001',groupName);
			}
		}
		function onpopupSelectDialog002DialogClose(data){
			if(data!=null){
				var calendarId = data.calendarId;
				var name = data.name;
				Matrix.setFormItemValue('popupSelectDialog002',calendarId);
			}
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
 				action:"<%=request.getContextPath()%>/mobile/flowEdit_dealHumanActivity.action",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/mobile/flowEdit_dealHumanActivity.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden"/>
	<input name="authId" id="authId" type="hidden" value="${activity.authItemId }"/>
	<input name="piid" id="piid" type="hidden" value="${param.piid }">
	<input name="processType" id="processType" type="hidden" value="${param.processType}"/>
	<input name="data" id="data" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="iframewindowid" id="iframewindowid" type="hidden" value="Dialog001"/>
	<table id="table001" class="tableLayout" style="width:100%;">
		<tr id="j_id2" jsId="j_id2">
			<td id="j_id3" jsId="j_id3" colspan="2" class="tdLayout" height="60px"
				 style="height: 50px;width:100%;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);background-size:100% 100%">
						<br>
				&nbsp;&nbsp;&nbsp;编辑流程活动节点属性，完成后点击保存确认.
			
			</td>
		</tr>
		<tr id="tr111" name="tr111" >
			<td id="td111" class="tdLayout" style="width:20%;text-align:right;border-right:0px;background-color:#dedede">
		 		<label id="label111" name="label111" style="padding-right:20px;">
					<font size="2" style="font-weight:bold">基本信息：</font>
				</label>
			</td>
			<td id="td112" class="tdLayout" style="width:80%;border-left:0px;background-color:#dedede">
		 		
			</td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label001" name="label001" id="label001">
					编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
				</label>
			</td>
			<td id="td002" class="tdLayout" style="width:80%;">
				<div id="input001_div" eventProxy="MForm0" class="matrixInline" style="width:300px;"></div>
				<script> var input001=isc.TextItem.create({
								ID:"Minput001",
								name:"input001",
								editorType:"TextItem",
								displayId:"input001_div",
								value:"${activity.id}",
								position:"relative",
								autoDraw:false,
								width:"100%"
								});
								MForm0.addField(input001);
				</script>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label002" name="label002" id="label002">
					名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：
				</label>
			</td>
			<td id="td004" class="tdLayout" style="width:80%;">
				<div id="input002_div" eventProxy="MForm0" class="matrixInline" style="width:300px;"></div>
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
								MForm0.addField(input002);
				</script>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label003" name="label003" id="label003">
					优&nbsp;&nbsp;先&nbsp;&nbsp;级：
				</label>
			</td>
			<td id="td006" class="tdLayout" style="width:80%;">
				<div id="comboBox001_div" eventProxy="MForm0" class="matrixInline" style="width:200px;"></div>
				<script> var McomboBox001_VM=[]; 
						 var comboBox001=isc.SelectItem.create({
						 		ID:"McomboBox001",
						 		name:"comboBox001",
						 		editorType:"SelectItem",
						 		displayId:"comboBox001_div",
						 		autoDraw:false,
						 		value:"${activity.priority}",
						 		position:"relative",
						 		width:"100%"
						 		});
						 		MForm0.addField(comboBox001);
						 		McomboBox001_VM=['0','1','2','3'];
						 		McomboBox001.displayValueMap={'0':'普通','1':'中级','2':'高级','3':'特级'};
						 		McomboBox001.setValueMap(McomboBox001_VM);
						 		//McomboBox001.setValue('0');
				</script>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="tdLayout" style="width:20%;text-align:right;">
				<label id="label004" name="label004" id="label004">
					授权信息：
				</label>
			</td>
			<td id="td008" class="tdLayout" style="width:80%;">
				<table id='popupSelectDialog001_table',style='width:90%;height:22px;table-layout:fixed;border-collapse:collapse;border-spacing:0;padding:0;margin:0;'>
					<tr>
						<td style='padding:0;width:88%;height:100%;'>
							<div id="popupSelectDialog001_div" style='width:300px;height:100%' eventProxy="MForm0" ></div>
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
											var processType = Matrix.getFormItemValue("processType");
											layer.open({
										    	id:'popupSelectDialog001Dialog',
												type : 2,
												
												title : ['请选择授权信息'],
												shadeClose: false, //开启遮罩关闭
												area : [ '50%', '65%' ],
												content : '<%=request.getContextPath()%>/mobile/securityInfoPage.jsp?iframewindowid=popupSelectDialog001Dialog&processType='+processType
											});  
											/*	
											Matrix.showMask();
											var x = eval("Matrix.showWindow('popupSelectDialog001Dialog');");
											MpopupSelectDialog001Dialog.setTitle('请选择授权信息');
											MpopupSelectDialog001Dialog.setHeight("60%");
											MpopupSelectDialog001Dialog.setWidth("500px");
											if(x!=null && x==false){
												Matrix.hideMask();
												return false;
											}
											Matrix.hideMask();
											*/
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
								value:"${activity.authItemName}",
								width:"100%",
								position:"relative",
								canEdit:false,
								autoDraw:false
							});
							MForm0.addField(popupSelectDialog001);
							
				</script>
				<script>
						function getParamsForpopupSelectDialog001Dialog(){
							var params='&';
							var processType = Matrix.getFormItemValue("processType");
							var value;
							params ="&processType="+processType;
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
								initSrc:'<%=request.getContextPath()%>/mobile/flowEdit_loadNodeAuthList.action?processType=${param.processType}',
								src:'<%=request.getContextPath()%>/mobile/flowEdit_loadNodeAuthList.action?processType=${param.processType}' 
							});
				</script>
			</td>
		</tr>
		<tr id="tr112" name="tr112" >
			<td id="td113" class="tdLayout" style="width:20%;text-align:right;border-right:0px;background-color:#dedede">
		 		<label id="label112" name="label112" style="padding-right:20px;">
					<font size="2" style="font-weight:bold">活动时限：</font>
				</label>
			</td>
			<td id="td113" class="tdLayout" style="width:80%;border-left:0px;background-color:#dedede">
		 		
			</td>
		</tr>
		<tr>
			<td id="td009" name="td009" style="width:20%;text-align:right;" class="tdLayout">
				<label id="label005" name="label005">期&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;限：</label>
			</td>
			<td id="td010" name="td010" style="width:80%;" class="tdLayout">
				<div id="input003_div" eventProxy="MForm0" class="matrixInline" style="width:200px;"></div>
				<script> var input003=isc.TextItem.create({
								ID:"Minput003",
								name:"input003",
								editorType:"TextItem",
								displayId:"input003_div",
								value:"${activity.deadLineInfo.durationValue=='null'?'':activity.deadLineInfo.durationValue}",
								position:"relative",
								autoDraw:false,
								width:"100%",
								validators:[{type:"custom",
											condition:function(item, validator, value, record){
												return Matrix.validateLongRange(1,9223372036854775807,value);},
												expression:"^\\d+$",errorMessage:"请填写大于0的整数值"}]
								});
								MForm0.addField(input003);
				</script>
				<label style="margin-left:10px" id="label006" name="label006">单位:</label>
				<div id="comboBox301_div" eventProxy="MForm0" class="matrixInline" style=""></div>
														<script> var McomboBox301_VM=[]; 
																 var comboBox301=isc.SelectItem.create({
																 		ID:"McomboBox301",
																 		name:"comboBox301",
																 		editorType:"SelectItem",
																 		displayId:"comboBox301_div",
																 		autoDraw:false,
																 		value:'${activity.deadLineInfo.unitType=="DAY"?"1":activity.deadLineInfo.unitType=="HOUR"?"2":"3"}',
																 		valueMap:[],
																 		position:"relative"
																 		});
																 		MForm0.addField(comboBox301);
																 		McomboBox301_VM=['1','2','3'];
																 		McomboBox301.displayValueMap={'1':'天','2':'小时','3':'分'};
																 		McomboBox301.setValueMap(McomboBox301_VM);
																 		//McomboBox301.setValue('1');
														</script>
			</td>
		</tr>
		<tr style=" display:none;">
			<td id="td011" name="td011" style="width:20%;text-align:right;" class="tdLayout">
				<div id="checkBox301_div" eventProxy="MForm0" class="matrixInline" style="width:80px"></div>
				
				
													<script> var checkBox301=isc.CheckboxItem.create({
															ID:"McheckBox301",
															name:"date_checkBox301",
															title:'业务日历',
															editorType:"CheckboxItem",
															displayId:"checkBox301_div",
															groupId:"date",
															value:'1',
															canEdit:false,
															valueMap:{"":false,"1":true},
															position:"relative",
															autoDraw:false,
															change:"changeSelectStatus()",
															//value:"${activity.deadLineInfo.isSetCalendar}",
															height:25
															});
															MForm0.addField(checkBox301);
															//MForm0.setValue("date_checkBox301","${activity.deadLineInfo.isSetCalendar=='true'?'1':''}");
													</script>
			</td>
				
			<td id="td012" name="td012" style="width:80%;" class="tdLayout">
				<table id='popupSelectDialog002_table',style='width:90%;height:22px;table-layout:fixed;border-collapse:collapse;border-spacing:0;padding:0;margin:0;'>
					<tr>
						<td style='padding:0;width:88%;height:100%;'>
							<div id="popupSelectDialog002_div" style='width:300px;height:100%' eventProxy="MForm0" ></div>
						</td>
						<td style='width:20px;height:100%;text-align:center;padding:0;'>
							<div id='popupSelectDialog002_button_div' style='position:relative;width:100%;height:100%;vertical-align:middle;' class='matrixInline'>
								<script>isc.ImgButton.create({
										ID:"MpopupSelectDialog002_button",
										name:"popupSelectDialog002_button",
										displayId:"popupSelectDialog002_button_div",
										showDisabled:false,
										showDisabledIcon:false,
										showDown:false,
										showDownIcon:false,
										showRollOver:false,
										showRollOverIcon:false,
										position:"relative",
										width:16,height:16,
										src:"[skin]/images/matrix/actions/query.png"});
										MpopupSelectDialog002_button.click=function(){
											return;
											/**
											Matrix.showMask();
											var x = eval("Matrix.showWindow('popupSelectDialog002Dialog');");
											MpopupSelectDialog002Dialog.setTitle('请选择业务日历');
											MpopupSelectDialog002Dialog.setHeight("400px");
											MpopupSelectDialog002Dialog.setWidth("500px");
											if(x!=null && x==false){
												Matrix.hideMask();
												return false;
											}
											Matrix.hideMask();
											**/
										};
								</script>
							</div>
						</td>
					</tr>
				</table>
				<script> var popupSelectDialog002=isc.TextItem.create({
								ID:"MpopupSelectDialog002",
								name:"popupSelectDialog002",
								editorType:"TextItem",
								displayId:"popupSelectDialog002_div",
								width:"100%",
								position:"relative",
								value:'calendar',
								//value:'${activity.deadLineInfo.calendarId}',
								canEdit:false,
								autoDraw:false
								
							});
							MForm0.addField(popupSelectDialog002);
							
				</script>
				<script>function getParamsForpopupSelectDialog002Dialog(){
							var params='&';
							var value;
							return params;
						}
						isc.Window.create({
								ID:"MpopupSelectDialog002Dialog",
								id:"popupSelectDialog002Dialog",
								name:"popupSelectDialog002Dialog",
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
								initSrc:"<%=request.getContextPath()%>/mobile/flowEdit_loadCalendarData.action",
								src:"<%=request.getContextPath()%>/mobile/flowEdit_loadCalendarData.action"
							});
				</script>
			</td>
		</tr>
		<tr><td id="td332" class="tdLayout" style="width:20%;text-align:right;"><label id="label306" name="label306" id="label306">
																			超时策略：
																		</label>
																</td>
																<td id="td333" class="tdLayout" colspan="8" rowspan="1" style="width:80%;">
																	<div id="comboBox302_div" eventProxy="MForm0" class="matrixInline" style=""></div>
																	<script> var McomboBox302_VM=[]; 
																			 var comboBox302=isc.SelectItem.create({
																			 			ID:"McomboBox302",
																			 			name:"comboBox302",
																			 			editorType:"SelectItem",
																			 			displayId:"comboBox302_div",
																			 			autoDraw:false,
																						value:'${activity.deadLineInfo.timeoutPolicy=="UPGRADEPRIORITY"?"1":activity.deadLineInfo.timeoutPolicy=="SUBSTITUTE"?"2":activity.deadLineInfo.timeoutPolicy=="COMPLETE"?"3":activity.deadLineInfo.timeoutPolicy== "TERMINATE"?"4":"0"}',
																			 			valueMap:[],
																			 			position:"relative"});
																			 			MForm0.addField(comboBox302);
																			 			McomboBox302_VM=['0','1','2','3','4'];
																			 			McomboBox302.displayValueMap={'0':'无','1':'提高优先级','2':'自动委托','3':'自动完成','4':'自动终止'};
																			 			McomboBox302.setValueMap(McomboBox302_VM);
																			 			</script></td></tr>
																			 			
		<tr id="tr102" name="tr102">
			<td id="td102" name="td102" class="cmdLayout" style="width:100%;height:30px;text-align:center;line-height:25px;" colspan="2">
				<div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
					<script>
						isc.Button.create({
							ID:"Mbutton001",
							name:"button001",
							title:"确认",
							displayId:"button001_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton001.click=function(){
							debugger;
							Matrix.showMask();
							if(!MForm0.validate()){
								Matrix.hideMask();
								Mbutton001.enable();
								return false;
							}
							var id = Matrix.getFormItemValue("input001");
							var name = Matrix.getFormItemValue('input002');
							var priority = McomboBox001.getValue();
							var authId = Matrix.getFormItemValue('authId');
							var authName = Matrix.getFormItemValue('popupSelectDialog001');
							var dateLine = Matrix.getFormItemValue('input003');
							var unit = McomboBox301.getValue();
							var calendar = McheckBox301.getValue();
							var calendarId = Matrix.getFormItemValue('popupSelectDialog002');
							var timeoutStr = McomboBox302.getValue();
							Matrix.setFormItemValue('flag','save');
							var piid = Matrix.getFormItemValue("piid");
							var json = "{'priority':'"+priority+"','adid':'"+id+"','authId':'"+authId+"','authName':'"+authName+"','dateLine':'"+dateLine+"','unit':'"+unit+"','calendar':'"+calendar+"','calendarId':'"+calendarId+"','timeout':'"+timeoutStr+"','piid':'"+piid+"'}";
							var synJson = isc.JSON.decode(json);
							Matrix.setFormItemValue('data',json);
							var url = "<%=request.getContextPath()%>/mobile/flowEdit_dealHumanActivity.action?flag=save";
							Matrix.sendRequest(url,synJson,function(data){
								if(data.data!=null){
									var result = isc.JSON.decode(data.data);
									if(result.result!=null && result.result!=''){
										parent.setPtid(result.result);
										//window.opener.setPtid(result.result);
										//parent.Matrix.setFormItemValue("ptid",result.result);
										Matrix.hideMask();
										var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
										parent.layer.close(index);
//										window.close();
									}else{
										Matrix.warn("流程模型不存在!");
									}
								}
							});
							//document.getElementById("Form0").action = url;
							//document.getElementById("Form0").submit();
							
							
							};
						</script>
					</div>
					<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
						<script>
							isc.Button.create({
								ID:"Mbutton002",
								name:"button002",
								title:"关闭",
								displayId:"button002_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								icon:"[skin]/images/matrix/actions/delete.png",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton002.click=function(){
								Matrix.showMask();
								//window.close();
								var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
								parent.layer.close(index);
								
								Matrix.hideMask();
							};
						</script>
					</div>	
			</td>	
		</tr>
	
	</table>

</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>


</div>

</body>
</html>