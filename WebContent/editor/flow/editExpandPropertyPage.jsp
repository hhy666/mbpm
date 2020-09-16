<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>编辑扩展属性</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style>
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
			//页面加载初始
			window.onload=function(){
				var propertyName = Matrix.getFormItemValue('propertyName');
				var expandProperty = Matrix.getFormItemValue('expandProperty');
				var propertyType = Matrix.getFormItemValue('propertyType');
				var propertyValue = Matrix.getFormItemValue('propertyValue');
				if(propertyName!=null && propertyName.length>0 && propertyName!='undefined'){
					Matrix.setFormItemValue('input001',propertyName);
				}
				if(propertyType!=null && propertyType.length>0 && propertyType!='undefined'){
					var items = document.getElementsByName('radio');
					if(propertyValue!=null && propertyValue.length>0){
						if(propertyType=='2'){//static
							Minput301.setValue(propertyValue);
						}else if(propertyType=='1'){
							McomboBox302.setValue(propertyValue);
						}
					}
				}
				isSynamic();
			}
			//改变单选按钮的选择状态
			function isSynamic(){
				var items = document.getElementsByName('radio');
				if(items[0].checked){
					Minput301.setCanEdit(true);
					McomboBox302.setDisabled(true);
				}else if(items[1].checked){
					Minput301.setCanEdit(false);
					McomboBox302.setDisabled(false);
				}
			}
			function onpopupSelectDialog302DialogClose(data){
				if(data!=null){
					Matrix.setFormItemValue("popupSelectDialog302",data.id);
				}
			}
			function onpopupSelectDialog303DialogClose(data){
				if(data!=null){
					Matrix.setFormItemValue("popupSelectDialog303",data.id);
				}
			}
			function onpopupSelectDialog301DialogClose(data){
				if(data!=null){
					Matrix.setFormItemValue("popupSelectDialog301",data.calendarId);
				}
			}
			//确认
			function confirmSelect(){
				var jsonObj = Matrix.formToObject('form0');
				if(jsonObj!=null){
					debugger;
					var newData = {};
					newData.expandProperty = jsonObj.expandProperty;
					newData.propertyName = jsonObj.input001;
					newData.propertyType = jsonObj.radio;
					if(jsonObj.radio=='2'){
						newData.propertyValue = jsonObj.input301;
					}else if(jsonObj.radio =='1'){
						newData.propertyValue = jsonObj.comboBox302;
					}
					
					Matrix.closeWindow(newData);
					//var url = "<%=request.getContextPath()%>/editor/editor_updateExpandProperty.action";
					//Matrix.sendRequest(url,jsonObj,function(data){//更新完成后回调关闭窗口，回写数据
					//	if(data!=null && data.data!=''){
					//		var result = isc.JSON.decode(data.data);
					//		if(result.flag = true){
					//			Matrix.closeWindow(jsonObj);
					//		}
					//	}
					//});
				}
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
 				action:"",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input type="hidden" id="propertyValue" name="propertyValue" value="${param.propertyValue }"/>
	<input type="hidden" id="propertyType" name="propertyType" value="${param.propertyType }"/>
	<input name="propertyName" id="propertyName" type="hidden" value="${param.propertyName }"/>
	<input name="expandProperty" id="expandProperty" type="hidden" value="${param.expandProperty }"/>
<table id="table301" class="tableLayout" style="width:100%;">
										<tr>
											<td id="td001" class="tdLayout" style="width:20%;text-align:center;">
												<label id="label001" name="label001" id="label001">
													名称：
												</label>
											</td>
											<td id="td002" class="tdLayout" style="width:80%">
												<div id="input001_div" eventProxy="Mform0" class="matrixInline" style="width:100%"></div>
															<script> var input001=isc.TextItem.create({
																		ID:"Minput001",
																		name:"input001",
																		editorType:"TextItem",
																		displayId:"input001_div",
																		width:'100%',
																		value:"",
																		position:"relative",
																		groupId:"radio",
																		autoDraw:false
																		});
																		Mform0.addField(input001);
															</script>
											</td>
										</tr>
										<tr id="tr311">
												<td id="td006" class="tdLayout" style="width:20%;text-align:center;"><label id="label002" name="label002" >
													设定值：
												</label></td>
												<td id="td009" class="tdLayout" style="width:80%;"></td>
										</tr>
												<tr id="tr308">
												<td id="td003" class="tdLayout" style="width:20%;"></td>
													<td id="td373" class="tdLayout" style="width:80%;">
														<div id="radio302_div" eventProxy="Mform0" class="matrixInline" style="float:left;margin-right:5px;"></div>
															<script> var radio302=isc.RadioItem.create({
																		ID:"Mradio302",
																		name:"radio",
																		title:'静态值',
																		editorType:"RadioItem",
																		displayId:"radio302_div",
																		value:"2",
																		groupId:"radio",
																		change:'isSynamic()',
																		position:"relative",
																		autoDraw:false
																		});
																		Mform0.addField(radio302);

															</script>
															<div id="input301_div" eventProxy="Mform0" class="matrixInline" style="width:70%;"></div>
															<script> var input301=isc.TextItem.create({
																		ID:"Minput301",
																		name:"input301",
																		editorType:"TextItem",
																		displayId:"input301_div",
																		width:'100%',
																		value:"",
																		position:"relative",
																		autoDraw:false
																		});
																		Mform0.addField(input301);
															</script>
														</td>
													</tr>
													<!-- 流程变量选择-->
													<tr id="tr309">
														<td id="td005" class="tdLayout" style="width:20%;"></td>
														<td id="td383" class="tdLayout" style="width:80%;">
														<div id="radio303_div" eventProxy="Mform0" class="matrixInline" style="float:left;margin-right:5px;"></div>
														<script> var radio303=isc.RadioItem.create({
																	ID:"Mradio303",
																	name:"radio",
																	title:'流程变量',
																	editorType:"RadioItem",
																	displayId:"radio303_div",
																	value:"1",
																	change:'isSynamic()',
																	groupId:"radio",
																	position:"relative",
																	autoDraw:false
																	});
																	Mform0.addField(radio303);
														</script>
															
																		<div id="comboBox302_div" eventProxy="Mform0" class="matrixInline" style="width:70%;"></div>
																	<script> var McomboBox302_VM=[]; 
																			 var comboBox302=isc.SelectItem.create({
																			 			ID:"McomboBox302",
																			 			name:"comboBox302",
																			 			editorType:"SelectItem",
																			 			displayId:"comboBox302_div",
																			 			width:'100%',
																			 			autoDraw:false,
																			 			value:'',
																			 			valueMap:[],
																			 			position:"relative"});
																			 			Mform0.addField(comboBox302);
																			 			var selectList=<%=request.getAttribute("list")%>;
																			 			
			                                                                           	var processDisplayMap = "{";
			                                                                           	var first = true;
																			 			for(var i=0;i<selectList.length;i++){
																			 			var itemValue = selectList[i];
																			 			if(itemValue){
																			 			if(first){
																			 			first=false;
																			 			}else{
																			 			processDisplayMap+=",";
																			 			}
																			 			processDisplayMap +="'"+itemValue.id+"':'"+itemValue.name+"'";
																			 			}
																			 			McomboBox302_VM.push(itemValue.id);
																			 			}
																			 			processDisplayMap+="}";
																			 			var displayVM;
																			 			var displayVar = eval("displayVM="+processDisplayMap+";");
																			 			
																			 			McomboBox302.displayValueMap=displayVM;
																			 			McomboBox302.setValueMap(McomboBox302_VM);
																	</script>
																</td>
																</tr>
																<!-- 确认按钮 -->
																<tr>
																	<td id="td008" class="cmdLayout" colspan="2">
																		<div id="button103_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
					<script>
						isc.Button.create({
							ID:"Mbutton103",
							name:"button103",
							title:"确认",
							displayId:"button103_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton103.click=function(){
							Matrix.showMask();
							confirmSelect();
							Matrix.hideMask();
							};
						</script>
					</div>
					<div id="button102_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;margin:left:10px;">
						<script>
							isc.Button.create({
								ID:"Mbutton102",
								name:"button102",
								title:"取消",
								displayId:"button102_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								icon:"[skin]/images/matrix/actions/delete.png",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton102.click=function(){
								Matrix.showMask();
								Matrix.closeWindow();
								Matrix.hideMask();
							};
						</script>
					</div>	
																	
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