<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>	
<script>
///////更新门户--接收数据--setModel()中用
	var titleRecive = '<%=request.getAttribute("title")%>';
   	var modRecive = <%=request.getAttribute("model")%>;
   	var layRecive = <%=request.getAttribute("layout")%>;
   	var staRecive= <%=request.getAttribute("status")%>;
   	var partSizeRecive = '<%=request.getAttribute("partSize")%>';
   	//设置布局样式
    function setLayout(){
        var group = document.getElementsByName('layout');
        var model=document.getElementsByName('model');
        if(model[1].checked){
        	
        }else{
        	for(var i=0;i<group.length;i++){
             	if(group[i].checked){
                 	if(group[i].value=='3'){
                   	 	 Matrix.setFormItemValue('partSize','30,40,30');
                 	}
                	if(group[i].value=='2'){
                    	 Matrix.setFormItemValue('partSize','50,50');
                	}
                	if(group[i].value=='1'){
                     	Matrix.setFormItemValue('partSize','100');
                	}    
             	}
        	}
        }
    }
    //设置布局模式
    function setModel(){
    	var model=document.getElementsByName('model');
    	for(var i=0;i<model.length;i++){
    		if(model[i].checked){
    			if(model[i].value=='1'){
    				document.getElementById("layout").style.display='none';
    				if(partSizeRecive!=null&&modRecive==1){
    					Matrix.setFormItemValue('partSize',partSizeRecive);
    				}else{
    					Matrix.setFormItemValue('partSize','3,3,3');
    				}
    				if(staRecive!=null){
    					Matrix.setFormItemValue('status','staRecive');
    				}else{
    					Matrix.setFormItemValue('status','0');
    				}
    			}else{
    				document.getElementById("layout").style.display='';
    				var layout = document.getElementsByName('layout'); 
					for(var i=0;i<layout.length-1;i++){ 
						if(layout[i].checked) { 
							layout[i].checked=false; //不选中 
						} 
					} 
					if(layRecive!=null&&modRecive==0){
						layout[layRecive-1].checked=true;
					}else{
						layout[layout.length-1].checked=true;
					}
					if(partSizeRecive!='null' && modRecive==0){
    					Matrix.setFormItemValue('partSize',partSizeRecive);
    				}else{
    					Matrix.setFormItemValue('partSize','30,40,30');
    				}
    				if(staRecive!=null){
    					Matrix.setFormItemValue('status','staRecive');
    				}else{
    					Matrix.setFormItemValue('status','0');
    				}
    			}
    		}
    	}
    }	
    //门户标题长度验证
    function lengthValidate(item, validator, value, record){
    	var titleLength = value.length;
    	if(titleLength>40){
    		return false;
    	}
    	return true;
    }
    //验证partSize
    function check(item, validator, value, record){
    //加if判断
    	//partSize = value.value;
    	var regex1 = /^[1-9][0-9]$/;
    	var regex2 = /^100|[1-9][0-9]$/;
    	if(record.model=='0'){
    		if(record.layout!="1"){
    			if(value==null) {
    				return true;
    			}else{
    				var partArr = value.split(",");
    				if(record.layout=="3" && partArr.length==3){
    					if(regex1.test(partArr.get(0))&&regex1.test(partArr.get(2))&&(parseInt(partArr[0])+parseInt(partArr[1])+parseInt(partArr[2]))<=100){
    						return true;
    					}
    				}else if(record.layout=="2"&&partArr.length==2){
    					if(regex1.test(partArr.get(0))&&regex1.test(partArr.get(1))&&(parseInt(partArr[0])+parseInt(partArr[1]))<=100){
    						return true;
    					}
    				}
    			}
    		}else{
    			if(regex2.test(value)&&parseInt(value)<=100){
    				return true;
    			}
    		}
    	}else{
    		Matrix.setFormItemValue('layout','');
    		var regex3=new RegExp("^[1-9]$");
    		var partSize = value;
    		var partArr = partSize.split(',');
    		var flag=true;
    		if(partArr.length==1&&regex3.test(partSize)){
    			return true;
    		}else if(partArr.length!=1&&regex3.test(partArr.get(0))&&regex3.test(partArr.get(partArr.length-1))){
    			for(var i=0;i<partArr.length;i++){
    				if(!regex3.test(partArr.get(i))){
    					flag=false;
    				}
    			}
    			if(flag==true){
    				return true;
    			}
    		}
    	}
    	return false;
    }
   //面加载检查如果是更新行布局，则设置layout
    function checkLayout(){
    	
    	if(titleRecive!=null&&modRecive==1){
    		document.getElementById("layout").style.display='none';
    	}
    	var type = Matrix.getFormItemValue("type");
    	if(type!=null && type!="2"){
	    	var depName = Mdep.getValue();
	    	if(depName!=null && depName.length>0){
	    		document.getElementById('selectDepTr').style.display="";
	    		Mdep.setRequired(true);
	    	}else{
	    		document.getElementById('selectDepTr').style.display="none";
	    		Mdep.setRequired(false);
	    	}
    	}else{
    		document.getElementById('selectDepTr').style.display="none";
    		document.getElementById('typeTr').style.display="none";
    		Mdep.setRequired(false);
    	}
    }
    
    function setType(){
    	var isShow = document.getElementById('selectDepTr').style.display;
    	if(isShow==''){
    		document.getElementById('selectDepTr').style.display="none";
    		Matrix.setFormItemValue("type",'1');
    		Mdep.setRequired(false);
    	}else if(isShow=='none'){
    		document.getElementById('selectDepTr').style.display="";
    		Matrix.setFormItemValue("type",'3');
    		Mdep.setRequired(true);
    	}
    }
    
    function onDialog_0Close(data){
    	if(data!=null){
    		Mdep.setValue(data.depName);
    		Matrix.setFormItemValue('depId',data.sequenceId);
    	}
    }
</script>
</head>
<body onload="checkLayout();">
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
				ID:"Mform0",
				name:"Mform0",
				position:"absolute",
				action:"/bpmconsole/matrix.rform",
				fields:[
				{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}
				]});
</script>
<div style="width:100%;height:100%;overflow:auto;position:relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" 
	action="<%=request.getContextPath()%>/portal/portalAction_findAllPortal.action" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="application/x-www-form-urlencoded">
<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<input name="type" id="type" type="hidden" value="${type }"/>
<input type="hidden" id="depId" name="depId" value="${depId }"/>
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
<table class="maintain_form_content" style="width:100%;">
<tr>
<td class="maintain_form_label2">
<label id="j_id0" name="j_id0">
门户标题</label></td>
<td class="maintain_form_input2">
<div id="title_div" eventProxy="Mform0" class="matrixInline" style=""></div>
<script> var title=isc.TextItem.create({
						ID:"Mtitle",
						name:"title",
						value:"${title}",
						editorType:"TextItem",
						displayId:"title_div",
						position:"relative",
						required:true,
						width:250,
						length:100,
						validators:[{
						type:"custom",
						condition:function(item, validator, value, record){
							return lengthValidate(item, validator, value, record);
						},
						errorMessage:"标题必须在40个字符之内!"}]
					});
					Mform0.addField(title);</script>
				<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                    *
                </span>
                
		</td>
</tr>
<!--  
<tr><td class="maintain_form_label2"><label id="j_id4" name="j_id4">
布局模式</label></td>
<td class="maintain_form_input2"><span id="model_div" style="width:200px;"><table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;display: inline;" cellspacing="0" cellpadding="0">

<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="model_0_div" eventProxy="Mform0"></div>
<script> var model_0=isc.RadioItem.create({
					ID:"Mmodel_0",
					name:"model",
					editorType:"RadioItem",
					displayId:"model_0_div",
					value:"0",
					title:"列布局",
					position:"relative",
					groupId:"model",
					changed:"setModel();"
				});
				Mform0.addField(model_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="model_1_div" eventProxy="Mform0"></div>
<script> var model_1=isc.RadioItem.create({
					ID:"Mmodel_1",
					name:"model",
					editorType:"RadioItem",
					displayId:"model_1_div",
					value:"1",
					title:"行布局",
					position:"relative",
					groupId:"model",
					changed:"setModel();"
				});
				Mform0.addField(model_1);Mform0.setValue("model","${model}");</script></td>
</tr>

</table></span>
</td>
</tr>
-->
<tr id="layout"><td class="maintain_form_label2"><label id="j_id1" name="j_id1">
门户列数</label></td>
<td class="maintain_form_input2"><span id="layout_div" style="width:200px;"><table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;display: inline;" cellspacing="0" cellpadding="0">

<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:66px;"><div id="layout_0_div" eventProxy="Mform0"></div>
<script> var layout_0=isc.RadioItem.create({
						ID:"Mlayout_0",
						name:"layout",
						value:"1",
						editorType:"RadioItem",
						displayId:"layout_0_div",
						title:"1列",
						position:"relative",
						groupId:"layout",						
						changed:"setLayout();"
					});
					Mform0.addField(layout_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:66px;"><div id="layout_1_div" eventProxy="Mform0"></div>
<script> var layout_1=isc.RadioItem.create({
						ID:"Mlayout_1",
						name:"layout",
						editorType:"RadioItem",
						displayId:"layout_1_div",
						value:"2",
						title:"2列",
						position:"relative",
						groupId:"layout",					
						changed:"setLayout();"
					});
					Mform0.addField(layout_1);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:66px;"><div id="layout_2_div" eventProxy="Mform0"></div>
<script> var layout_2=isc.RadioItem.create({
						ID:"Mlayout_2",
						name:"layout",
						editorType:"RadioItem",
						displayId:"layout_2_div",
						value:"3",
						title:"3列",
						position:"relative",
						groupId:"layout",
						changed:"setLayout();"
					});
					Mform0.addField(layout_2);
					Mform0.setValue("layout","${layout}");
				</script></td>
</tr>

</table></span>
</td>
</tr>
<!-- 
<tr><td class="maintain_form_label2"><label id="j_id2" name="j_id2">
布局样式</label></td>
<td class="maintain_form_input2"><div id="partSize_div" eventProxy="Mform0" class="matrixInline" style=""></div>
<script> var partSize=isc.TextItem.create({
					ID:"MpartSize",
					name:"partSize",
					editorType:"TextItem",
					displayId:"partSize_div",
					position:"relative",
					value:"${partSize==null?'30,40,30':partSize}",
					width:250,
					length:10,
					required:true,
					validators:[{
					type:"custom",
					condition:function(item, validator, value, record){return check(item, validator, value, record);},
					errorMessage:"样式错误，请重新布局!"}]
				});
				Mform0.addField(partSize);</script>
				<label style="color:red;" value="*"/>
				</td>
</tr>
 -->
<tr><td class="maintain_form_label2"><label id="j_id3" name="j_id3">
门户状态</label></td>
<td class="maintain_form_input2"><span id="status_div" style="width:200px;">
<table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;display: inline;" cellspacing="0" cellpadding="0">

<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="status_0_div" eventProxy="Mform0"></div>
<script> var status_0=isc.RadioItem.create({
					ID:"Mstatus_0",
					name:"status",
					editorType:"RadioItem",
					displayId:"status_0_div",
					value:"0",
					title:"启用",
					
					position:"relative",
					groupId:"status"
				});
				Mform0.addField(status_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;"><div id="status_1_div" eventProxy="Mform0"></div>
<script> var status_1=isc.RadioItem.create({
					ID:"Mstatus_1",
					name:"status",
					editorType:"RadioItem",
					displayId:"status_1_div",
					value:"1",
					title:"禁用",
					
					position:"relative",
					groupId:"status"
				});
				Mform0.addField(status_1);Mform0.setValue("status","${status}");</script></td>
</tr>
</table></span>
</td>
</tr>



<tr id="typeTr"><td class="maintain_form_label2"><label id="j_id4" name="j_id4">
门户类型</label></td>
<td class="maintain_form_input2">
<span id="type_div" style="width:200px;">
<table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;display: inline;" cellspacing="0" cellpadding="0">

<tr>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
<div id="type_0_div" eventProxy="Mform0"></div>
<script> var type_0=isc.RadioItem.create({
					ID:"Mtype_0",
					name:"type",
					editorType:"RadioItem",
					displayId:"type_0_div",
					value:"1",
					title:"公司门户",
					changed:"setType();",
					position:"relative",
					groupId:"type"
				});
				Mform0.addField(type_0);</script></td>
<td></td>
<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
<div id="type_1_div" eventProxy="Mform0"></div>
<script> var type_1=isc.RadioItem.create({
					ID:"Mtype_1",
					name:"type",
					editorType:"RadioItem",
					displayId:"type_1_div",
					value:"3",
					title:"部门门户",
					changed:"setType();",
					position:"relative",
					groupId:"type"
				});
				Mform0.addField(type_1);
				Mform0.setValue("type","${type=='3'?'3':'1'}");</script></td>
</tr>
</table></span>
</td>
</tr>

<tr id="selectDepTr">
<td class="maintain_form_label2">
<label id="j_id6" name="j_id6">
选择部门</label></td>
<td class="maintain_form_input2">

					<table id='popupSelectDialog_001_table',style='width:100%;height:22px;table-layout:fixed;border-collapse:collapse;border-spacing:0;padding:0;margin:0;'>
					<tr>
						<td style='padding:0;width:80%;height:100%;'>
							<div id="dep_div" style='width:100%;height:100%' eventProxy="Mform0" ></div>
						</td>
						<td style='width:20%;height:100%;text-align:left;padding:0;'>
							<div id='Dialog_0_button_div' style='position:relative;width:100%;height:100%;vertical-align:middle;padding-left:10px;' class='matrixInline'>
								<script>isc.ImgButton.create({
										ID:"MDialog_0_button",
										name:"Dialog_0_button",
										displayId:"Dialog_0_button_div",
										showDisabled:false,
										showDisabledIcon:false,
										showDown:false,
										showDownIcon:false,
										showRollOver:false,
										showRollOverIcon:false,
										position:"relative",
										width:16,height:16,
										src:"[skin]/images/matrix/actions/query.png"});
										MDialog_0_button.click=function(){
											Matrix.showMask();
											parent.MMainDialog.setWidth("400px");
											parent.MMainDialog.setHeight("600px");
											var x = eval("Matrix.showWindow('Dialog_0');");
											
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
				<script> var dep=isc.TextItem.create({
						ID:"Mdep",
						name:"dep",
						value:"${depName}",
						editorType:"TextItem",
						displayId:"dep_div",
						position:"relative",
						required:true,
						width:250,
						length:100
					});
					Mform0.addField(dep);</script>
				<script>function getParamsForDialog_0(){
							var params='&';
							var value;
							return params;
						}
						isc.Window.create({
								ID:"MDialog_0",
								id:"Dialog_0",
								name:"Dialog_0",
								position:"absolute",
								height: "350",
								width: "500",
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
								getParamsFun:getParamsForDialog_0,
								autoDraw: false,
								initSrc:'<%=request.getContextPath()%>/common/deptSelect.jsp',
								src:'<%=request.getContextPath()%>/common/deptSelect.jsp',
								targetDialog:'MainDialog'
							});
				</script>
		</td>
</tr>
<tr>
	<input type="hidden" id="uuid" name="uuid" value="${param.uuid }">
<td class="cmdLayout" colspan="2"><div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
	<script>
		isc.Button.create({
			ID:"Mbutton001",
			name:"button001",
			title:"保存",
			displayId:"button001_div",
			position:"absolute",
			top:0,left:0,
			width:"100%",
			height:"100%",
			icon:"<%=request.getContextPath()%>/resource/images/submit.png",
			showDisabledIcon:false,
			showDownIcon:false,
			showRollOverIcon:false
		});
		Mbutton001.click=function(){
		debugger;
			Matrix.showMask();
			if(!true){
				Matrix.hideMask();
				return false;
			}
			if(!Mform0.validate()){
				Matrix.hideMask(); 
				return false;
			}
			var vituralbuttonHidden = document.getElementById('matrix_command_id');
			if(vituralbuttonHidden)
				vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
				var currentForm = document.getElementById('form0');
				var buttonHidden = document.createElement('input');
				buttonHidden.type='hidden';
				buttonHidden.name='matrix_command_id';
				buttonHidden.id='matrix_command_id';
				buttonHidden.value='button001';
				currentForm.appendChild(buttonHidden);
				var _mgr=Matrix.convertDataGridDataOfForm('form0');
				if(_mgr!=null&&_mgr==false){
					Matrix.hideMask();
					return false;
				}
				document.getElementById('form0').action="<%=request.getContextPath()%>/portal/portalAction_savePortal.action";
				
				
				var data=Matrix.getFormItemValue('uuid');
				var newData=null;
				var synJson=null;
				if(data!=null){
					newData="{'uuid':'"+data+"'}";
					synJson = isc.JSON.decode(newData);
				}
				Matrix.send('form0',synJson,function(){
						 Matrix.closeWindow();
					});
					Matrix.hideMask();
				};
			</script></div><div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;"><script>isc.Button.create({ID:"Mbutton002",name:"button002",title:"取消",displayId:"button002_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",icon:"<%=request.getContextPath()%>/resource/images/return.png",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton002.click=function(){Matrix.showMask();Matrix.closeWindow();Matrix.hideMask();};</script></div></td>
</tr>

</table>


</form></div><script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
