<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加委托项</title>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
		//委托范围类型变化重写
		function scopeTypeChanged(value){
			var processNameTr = document.getElementById("processNameTr");
			var activityNameTr = document.getElementById("activityNameTr");
			   MprocessName.setDisabled(false);
			   MactivityName.setDisabled(false);
			if(value==1){//所有
			    processNameTr.style.display="none";
			    activityNameTr.style.display="none";
			    MprocessName.clearValue();
			    MprocessName.setDisabled(true);
			    MactivityName.clearValue();
			    MactivityName.setDisabled(true);
			    document.getElementById("pdid").value=null;
			    document.getElementById("adid").value=null;
			    
			}else if(value==2){//流程
			    processNameTr.style.display="table-row";
			    activityNameTr.style.display="none";
			     
			    MactivityName.clearValue();
			    MactivityName.setDisabled(true);
			    document.getElementById("adid").value=null;
			}else if(value==3){//环节
			    processNameTr.style.display="table-row";
			    activityNameTr.style.display="table-row";
			}
		}
		
		//选流程
		function selectProcess(){
			//Matrix.hideMask();
			MSelectProcessDialog.initSrc ="<%=request.getContextPath()%>/common/processTmpl_loadProcessTreePage.action";
			Matrix.showWindow('SelectProcessDialog');
		}
		
		//选环节
		function selectActivity(){
			var pdName = Matrix.getMatrixComponentById("processName").getValue();
            var pdid = document.getElementById("pdid").value;
        	if(pdid==null||pdid.length==0||pdName==null||pdName.length==0){
        		isc.say("请先选择流程!");
        		return;
        	}
        	MSelectActivityDialog.initSrc="<%=request.getContextPath()%>/common/processTmpl_loadProcessActivitys.action?processDid="+pdid;
			Matrix.showWindow('SelectActivityDialog');
		}
		
		//选人员(委托人)
		function selectUser(){
			MSelectUserDialog.initSrc="<%=request.getContextPath()%>/common/userSelected_loadUserTreePage.action";
			Matrix.showWindow('SelectUserDialog');
		}
		
		
		//选流程Callback
		function onSelectProcessDialogClose(data, oType){
			if(data!=null){
        		var pdJson = isc.JSON.decode(data);//{text,id}
        		var pdName = Matrix.getMatrixComponentById("processName");
        		var pdid = document.getElementById("pdid");
        		pdName.setValue(pdJson.text);
        		pdid.value = pdJson.pdid;
        		return true;
        	}
        	return true;
		}
		
		//选环节Callback
		function onSelectActivityDialogClose(data, oType){
			if(data!=null){
        		var adJson =data;//{text,id}
        		var activityName = Matrix.getMatrixComponentById("activityName");
        		var adid = document.getElementById("adid");
        			
        		activityName.setValue(adJson.name);
        		adid.value = adJson.adid;
        		return true;
        	}
        	return true;
		}
		
		//选人员Callback
		function onSelectUserDialogClose(data, oType){
			//userName  userId
        	if(data!=null){
        		var userJson = isc.JSON.decode(data);//{text,id}
        		var substitutorName = Matrix.getMatrixComponentById("substitutorName");
        		var substitutorId = document.getElementById("substitutorId");
        			
        		substitutorName.setValue(userJson.text);
        		substitutorId.value = userJson.id;
        		return true;
        		}
        	return true;
		}
		
		
		
		//初始页面
		function initPage(){
			var scopeType = MscopeType.getValue();
			if(scopeType==null){
				scopeType = 1;
			}
			scopeTypeChanged(scopeType);
			if("${requestScope.message}"!=""){
				isc.warn("${requestScope.message}");
			}
		}
	
	
	</script>
</head>
<body onload="initPage()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/catalog_addComponent.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="<%=request.getContextPath()%>/substitute/substituteAction_createSubstituteItem.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	
    <input id="id" type="hidden" name="id" value="${substituteItem.id}"/>
	<input id="pdid" type="hidden" name="pdid" value="${substituteItem.pdid}"/>
	<input id="adid" type="hidden" name="adid" value="${substituteItem.adid}" />
	<input id="substitutorId" type="hidden" name="substitutorId" value="${substituteItem.substitutorId}" />
	<input id="userId" type="hidden" name="userId" value="${substituteItem.userId}"/>
	<input id="userName" type="hidden" name="userName" value="${substituteItem.userName}" />
	
	<input id="type" type="hidden" name="type" value="${requestScope.type}"/>
	<input id="oType" type="hidden" name="oType" value="${requestScope.oType}"/>
	
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>

<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
<script>
	 var MtabContainer0 = isc.TabSet.create({
	 	ID:"MtabContainer0",
	 	displayId:"tabContainer0_div",
	 	height: "100%",width: "100%",
	 	position: "relative",
	 	align: "center",
	 	tabBarPosition: "top",
	 	tabBarAlign: "left",
	 	showPaneContainerEdges: false,
	 	showTabPicker: true,
	 	showTabScroller: true,
	 	selectedTab: 1,
	 	tabBarControls : [
	 		isc.MatrixHTMLFlow.create({
	 			ID:"MtabContainer0Bar0",
	 			width:"300px",
	 			contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
	 		})
	    ],
	    tabs: [ {
	    	title: "${requestScope.oType}"=="add"?"新增流程委托":"更新流程委托",
	    	pane:isc.MatrixHTMLFlow.create({
	    	     ID:"MtabContainer0Panel0",
	    	     width: "100%",
	    	     height: "100%",
	    	     overflow: "hidden",
	    	     contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"})
	    	     } ] 
	 });
	 document.getElementById('tabContainer0_div').style.display='none';
	 MtabContainer0.selectTab(0);
	 isc.Page.setEvent("load","MtabContainer0.selectTab(0);");
  </script>
 </div>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
</script>
<div id="tabContainer0Panel0_div2" style="width: 100%; height: 100%; overflow: hidden;" class="matrixInline">
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content" style="width:100%;">

	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 委托范围：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="scopeType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MscopeType_VM=[];
		    var scopeType=isc.SelectItem.create({
		    		ID:"MscopeType",
		    		name:"scopeType",
		    		editorType:"SelectItem",
		    		displayId:"scopeType_div",
		    		valueMap:[],
		    		value:"1",
		    		position:"relative",
		    		width:290,
			    	changed:function(form, item, value){
			    			scopeTypeChanged(value);
			        }
		    });
		    MForm0.addField(scopeType);
		    MscopeType_VM=['1','2','3'];
		    MscopeType.displayValueMap={'1':'所有工作','2':'流程','3':'环节'};
		    MscopeType.setValueMap(MscopeType_VM);
		    var scopeTypeValue = "${substituteItem.scopeType.value}";
		    //编码名称重复时处理
		    if(scopeTypeValue!=null && scopeTypeValue.length>0){
		        MscopeType.setValue(scopeTypeValue);
		    }else{
		       MscopeType.setValue('1'); 
		    }
		</script>
		
		</td>
	</tr>
	<tr id="processNameTr" name="processNameTr">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 流程名称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="processName_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script> 
			var processName=isc.TextItem.create({
				ID:"MprocessName",
				name:"processName",
				editorType:"TextItem",
				displayId:"processName_div",
				position:"relative",
				width:290,
				canEdit:false,
				value:"${substituteItem.processName}",
				validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
			      		    	if(MscopeType){
			      		    		if(MscopeType.getValue()==2 ||　MscopeType.getValue()=='2'
			      		    		   || MscopeType.getValue()==3 ||　MscopeType.getValue()=='3'){
			      		         		if(value!=null&&value.length>0){
				      		    			return true;
			      		    			}else{
			      		    			 	validator.errorMessage="请选择流程!";
			      		    			 	return false;
			      		    			}
			      		    		}
			      		    	}
		      		    		return true;
		      		         },
		      		         errorMessage:"流程名称必选项!"
		      		 	}]
			});
			MForm0.addField(processName);
		</script>
		
		 <script>
			  isc.ImgButton.create({
					  ID:"MImageButton0",
					  name:"ImageButton0",
					  showDisabled:false,
					  showDisabledIcon:false,
					  showDown:false,
					  showDownIcon:false,
					  showRollOver:false,
					  showRollOverIcon:false,
					  position:"relative",
					 
					  width:18,
					  height:18,
					  
					  src:Matrix.getActionIcon("query"),
					  prompt:"选择流程"
			  });
			  MImageButton0.click=function(){
				  Matrix.showMask();
				 selectProcess();
				  Matrix.hideMask();
			  }
			  </script>
			 <span id="MultiLabelImg1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		</td>
	</tr>
	<tr id="activityNameTr" name="activityNameTr">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style=" width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 环节名称：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="activityName_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script>
			 var activityName=isc.TextItem.create({
			  	ID:"MactivityName",
			  	name:"activityName",
			  	editorType:"TextItem",
			  	displayId:"activityName_div",
			  	position:"relative",
			  	value:"${substituteItem.activityName}",
			  	width:290,
			  	canEdit:false,
			  	validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		    		
		      		    		if(MscopeType){
			      		    		if(MscopeType.getValue()==3 ||　MscopeType.getValue()=='３'){
				      		    		if(value!=null&&value.length>0){
					      		    			return true;
				      		    		}else{
				      		    			 validator.errorMessage="请选择环节!";
				      		    			 return false;
				      		    		}
			      		    		}
		      		    		}
		      		    		return true;
		      		     },
		      		     errorMessage:"请选择环节!"
		      		 }]
			 });
		 MForm0.addField(activityName);
		</script>
		
		 <script>
			  isc.ImgButton.create({
					  ID:"MImageButton1",
					  name:"ImageButton1",
					  showDisabled:false,
					  showDisabledIcon:false,
					  showDown:false,
					  showDownIcon:false,
					  showRollOver:false,
					  showRollOverIcon:false,
					  position:"relative",
					 
					  width:18,
					  height:18,
					  
					  src:Matrix.getActionIcon("query"),
					  prompt:"选择环节"
			  });
			  MImageButton1.click=function(){
				  Matrix.showMask();
				  selectActivity();
				  Matrix.hideMask();
			  }
			  </script>
			 <span id="MultiLabelImg1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		
		
		</td>
	</tr>
	<!-- 服务标识和实现类 -->
	
	<tr id="serviceNameTr" jsId="serviceNameTr">
		<td id="j_id10eN" jsId="j_id10eN" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11eN" name="j_id11eN" style="margin-left: 10px"> 委托类型：</label></td>
		<td id="j_id12eN" jsId="j_id12eN" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="substituteType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MsubstituteType_VM=[];
		    var substituteType=isc.SelectItem.create({
		    		ID:"MsubstituteType",
		    		name:"substituteType",
		    		editorType:"SelectItem",
		    		displayId:"substituteType_div",
		    		valueMap:[],
		    		value:"",
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(substituteType);
		    MsubstituteType_VM=['1','2'];
		    MsubstituteType.displayValueMap={'1':'创建时','2':'超时时'};
		    MsubstituteType.setValueMap(MsubstituteType_VM);
		    var substituteTypeValue = "${substituteItem.substituteType.value}";
		    //编码名称重复时处理
		    if(substituteTypeValue!=null && substituteTypeValue.length>0){
		       	   MsubstituteType.setValue(substituteTypeValue);
		    }else{
		       MsubstituteType.setValue(''); 
		    }
		</script>
		
		</td>
	</tr>
	
	<tr id="serviceLocationTr" jsId="serviceLocationTr">
		<td class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11eL" name="j_id11eL" style="margin-left: 10px"> 被委托人：</label></td>
		<td  class="maintain_form_input" colspan="1" rowspan="1">
		<div id="substitutorName_div" eventProxy="MForm0" style="float:left;"></div>
		
		<script> 
			var substitutorName=isc.TextItem.create({
				ID:"MsubstitutorName",
				name:"substitutorName",
				editorType:"TextItem",
				displayId:"substitutorName_div",
				position:"relative",
				width:290,
				canEdit:false,
				value:"${substituteItem.substitutorName}",
				validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		    			if(value!=null&&value.length>0){
			      		    			return true;
		      		    			}else{
		      		    			 	validator.errorMessage="请选择被委托人!";
		      		    			 	return false;
		      		    			}
		      		         },
		      		         errorMessage:"请选择被委托人!"
		      		 	}]
		      		 	
		    
		      		 	
			});
			MForm0.addField(substitutorName);
		</script>
		
		 <script>
			  isc.ImgButton.create({
					  ID:"MImageButton2",
					  name:"ImageButton2",
					  showDisabled:false,
					  showDisabledIcon:false,
					  showDown:false,
					  showDownIcon:false,
					  showRollOver:false,
					  showRollOverIcon:false,
					  position:"relative",
					 
					  width:18,
					  height:18,
					  
					  src:Matrix.getActionIcon("query"),
					  prompt:"选择被委托人"
			  });
			  MImageButton2.click=function(){
				  Matrix.showMask();
				  selectUser();
				  Matrix.hideMask();
			  }
			  </script>
			 <span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		</td>
	</tr>
	
	
	
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 开始时间：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="validFromDate_div" eventProxy="MForm0" class="matrixInline" style="">
							</div>
							<script>
							    var validFromDate = isc.DateItem.create({
							        ID: "MvalidFromDate",
							        name: "validFromDate",
							        type: "date",
							        width:290,
							        value:"${requestScope.validFromDateStr}",
							        displayId: "validFromDate_div",
							        paseDateFun: function(value, formatPattern) {
							            return Matrix.parseDate(value, formatPattern);
							        },
							        dateFormatter: function(_1) {
							            return Matrix.formatDate(this, MvalidFromDate.formatPattern);
							        },
							        formatPattern: "yyyy-MM-dd",
							        useTextField: true,
							        enforceDate: true,
							        position: "relative",
							        validators: [{
							            type: "custom",
							            condition: function(item, validator, value, record) {
							            	
							               	if(value==null||value.length==0){
							            	 	//validator.errorMessage = "请选择开始时间!";
							            		//return false;
							            		return true;
							            	}
							            	
							            	var endTime = MvalidToDate.getValue();
							            	
							            	if(endTime!=null){
							            		endTime = endTime.getTime();
							            		var valueTime = value.getTime();
							            		if(valueTime>=endTime){
							            			validator.errorMessage = "开始时间应早于结束时间!";
							            			return false;
							            		}
							            	}
							            	
							                return item.validateDateValue(value);
							            },
							            errorMessage: isc.DateItem.getPrototype().invalidDateStringMessage
							        }]
							    });
							    MForm0.addField(validFromDate);
							</script>
	</td>
	</tr>
	
		<tr >
		<td  class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
		<label style="margin-left: 10px"> 结束时间：</label></td>
		<td class="maintain_form_input" colspan="1" rowspan="1">
		<div id="validToDate_div" eventProxy="MForm0" class="matrixInline" style="">
							</div>
							<script>
							    var MvalidToDate_value = null;
							    var validToDate = isc.DateItem.create({
							        ID: "MvalidToDate",
							        name: "validToDate",
							        value: MvalidToDate_value,
							        type: "date",
							        width:290,
							        value:"${requestScope.validToDateStr}",
							        displayId: "validToDate_div",
							        paseDateFun: function(value, formatPattern) {
							            return Matrix.parseDate(value, formatPattern);
							        },
							        dateFormatter: function(_1) {
							            return Matrix.formatDate(this, MvalidToDate.formatPattern);
							        },
							        formatPattern: "yyyy-MM-dd",
							        useTextField: true,
							        enforceDate: true,
							        position: "relative",
							        validators: [{
							            type: "custom",
							            condition: function(item, validator, value, record) {
							            	if(value==null||value.length==0){
							            	 	//validator.errorMessage = "请选择结束时间!";
							            		//return false;
							            		return true;
							            	}
							            	
							            	var startTime = MvalidFromDate.getValue();
							            	
							            	if(startTime!=null){
							            		startTime = startTime.getTime();
							            		var valueTime = value.getTime();
							            		if(valueTime<=startTime){
							            			validator.errorMessage = "结束时间应晚于开始时间!";
							            			return false;
							            		}
							            	}
							            	
							                return item.validateDateValue(value);
							            },
							            errorMessage: isc.DateItem.getPrototype().invalidDateStringMessage
							        }]
							    });
							    MForm0.addField(validToDate);
							</script>
	</td>
	</tr>
	<tr id="j_id27" jsId="j_id27">
		<td id="j_id28" jsId="j_id28" class="maintain_form_command"
			colspan="2" rowspan="1">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative; width: 100px; height: 22px;">
			<script>
			isc.Button.create({
				ID:"MdataFormSubmitButton",
				name:"dataFormSubmitButton",
				title:"保存",
				displayId:"dataFormSubmitButton_div",
				position:"absolute",
				top:0,left:0,
				width:"100%",
				height:"100%",
				icon:Matrix.getActionIcon("save"),
				showDisabledIcon:false,
				showDownIcon:false,
				showRollOverIcon:false
				});
				MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					var scopeType = MscopeType.getValue();
					
					if(scopeType==2){//process
						MprocessName.canEdit = true;
						
					}else if(scopeType==3){//proc and activity
						MprocessName.canEdit = true;
						MactivityName.canEdit = true;
					}
					
				  	MsubstitutorName.canEdit = true;
					
					if(!MForm0.validate()){
						MprocessName.canEdit = false;
						MactivityName.canEdit = false;
						MsubstitutorName.canEdit = false;
						Matrix.hideMask();
				   	    return false;
					}
				
					Matrix.convertFormItemValue('Form0');
					if("update"=="${requestScope.oType}"){
						document.getElementById('Form0').action ="<%=request.getContextPath()%>/substitute/substituteAction_updateSubstituteItem.action";
					}
						
					document.getElementById('Form0').submit();
					Matrix.hideMask();
					
				   
			};
			</script>
		</div>
		
		<div id="dataFormResetButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
				ID:"MdataFormResetButton",
				name:"dataFormResetButton",
				title:"取消",
				displayId:"dataFormResetButton_div",
				position:"absolute",
				top:0,left:0,
				width:"100%",height:"100%",
				icon:Matrix.getActionIcon("exit"),
				showDisabledIcon:false,
				showDownIcon:false,
				showRollOverIcon:false
				});
				MdataFormResetButton.click=function(){
					Matrix.showMask();
					//返回列表
					window.location.href ="<%=request.getContextPath()%>/substitute/substituteAction_querySubstituteItems.action";
					Matrix.hideMask();
				};
			</script>
		</div>
		</td>
	</tr>
</table>
</div>
	<script type="text/javascript">
		//表单迁移
					isc.Window.create({
							ID:"MSelectProcessDialog",
							id:"SelectProcessDialog",
							name:"SelectProcessDialog",
							autoCenter: true,
							position:"absolute",
							height: "400px",
							width: "300px",
							title: "选流程",
							canDragReposition: true,
							showMinimizeButton:false,
							showMaximizeButton:false,
							showCloseButton:true,
							showModalMask: false,
							modalMaskOpacity:0,
							isModal:true,
							autoDraw: false,
							headerControls:[
								"headerIcon","headerLabel",
								"closeButton"
							]
					
					});
					MSelectProcessDialog.hide();
					
					
					//表单迁移
					isc.Window.create({
							ID:"MSelectActivityDialog",
							id:"SelectActivityDialog",
							name:"SelectActivityDialog",
							autoCenter: true,
							position:"absolute",
							height: "400px",
							width: "300px",
							title: "选环节",
							canDragReposition: true,
							showMinimizeButton:false,
							showMaximizeButton:false,
							showCloseButton:true,
							showModalMask: false,
							modalMaskOpacity:0,
							isModal:true,
							autoDraw: false,
							headerControls:[
								"headerIcon","headerLabel",
								"closeButton"
							]
					
					});
					MSelectActivityDialog.hide();
					
					//选用户
					isc.Window.create({
							ID:"MSelectUserDialog",
							id:"SelectUserDialog",
							name:"SelectUserDialog",
							autoCenter: true,
							position:"absolute",
							height: "400px",
							width: "300px",
							title: "选人员",
							canDragReposition: true,
							showMinimizeButton:false,
							showMaximizeButton:false,
							showCloseButton:true,
							showModalMask: false,
							modalMaskOpacity:0,
							isModal:true,
							autoDraw: false,
							headerControls:[
								"headerIcon","headerLabel",
								"closeButton"
							]
					
					});
					MSelectUserDialog.hide();
					
					
	
	
	
	</script>
	
</div>
<script>
document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));
</script>
<script>document.getElementById('tabContainer0_div').style.display='';</script>
</form>
<script>
MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>