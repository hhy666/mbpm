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
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<script>
	//去除字符串中间的空格
	 function splitString(str){
	 	var strArr = str.split('');
	 	var string = '';
	 	for(var i=0;i<str.length;i++){
	 		if(strArr[i]!=' '){
	 			string+=strArr[i];
	 		}
	 	}
	 	return string;
	 }
	 
  function checkPassword(){
      var oldPwd = Matrix.getFormItemValue("oldPassword");
      var newPwd = Matrix.getFormItemValue("newPassword");
      var reNewPwd=Matrix.getFormItemValue("input003");
      var oldStr = splitString(oldPwd);
      var newStr = splitString(newPwd);
      var reNewStr = splitString(reNewPwd);
      if(oldStr.length<oldPwd.length){
     	 isc.warn("原密码中不能包含空格!");
     	 return;
      }
      if(newStr.length<newPwd.length){
     	 isc.warn("新密码中不能包含空格!");
     	 return;
      }
      if(reNewStr.length<reNewPwd.length){
     	 isc.warn("重复密码中不能包含空格!");
     	 return;
      }
      if(oldPwd==newPwd){
         isc.warn("原密码与新密码相同!");
         return;
      }else{
         if(newStr!=reNewStr){
             isc.warn("重复密码与新密码不一致!");
             return;
         }else{
             var newData = "{'oldPassword':'"+oldStr;
             newData+="','newPassword':'"+newStr; 
             newData+="'}";
             var url = '<%=request.getContextPath()%>/password/passwordAction_savePassword.action';
	         var synJson = isc.JSON.decode(newData); 
	         Matrix.sendRequest(url,synJson, function(data){
	          		var json = data.data;
	          		if(json){
	          			var result = isc.JSON.decode(json);
	          			if(result.result==true){
	          				isc.say(result.message);
	          			}else{
	          				isc.warn(result.message);
	          			}
	          		}
        		});
      		} 
      	}
  }
  //**********长度验证*************************
  function lengthValidate0(item, validator, value, record){
  	  if(value.length>100){
  	      return false;
  	  }
  	  return true;
  }
  function lengthValidate1(item, validator, value, record){
  	  if(value.length>100){
  	      return false;
  	  }
  	  return true;
  }
  function lengthValidate2(item, validator, value, record){
  	  if(value.length>100){
  	      return false;
  	  }
  	  return true;
  }
</script>
</head>
<body>
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>
	<script> 
		var Mform0=isc.MatrixForm.create({
			ID:"Mform0",
			name:"Mform0",
			position:"absolute",
			action:"<%=request.getContextPath()%>/matrix.rform",
			fields:[
				{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}
			]
		});
	</script>
	<div style="width:100%;height:100%;overflow:auto;position:relative;">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/matrix.rform" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<input type="hidden" id="mode" name="mode" value="debug" />
			<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
			<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
			<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
			<div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;" >
			<script> 
				var MTabContainer001 = isc.TabSet.create({
					ID:"MTabContainer001",
					displayId:"TabContainer001_div",
					height: "100%",width: "100%",
					position: "relative",
					align: "center",
					tabBarPosition: "top",
					tabBarAlign: "left",
					showPaneContainerEdges: false,
					showTabPicker: false,
					showTabScroller: false,
					selectedTab: 1,
					tabBarControls : [isc.MatrixHTMLFlow.create({
								ID:"MTabBar001",width:"300px",
								contents:"<div id='TabBar001_div' style='text-align:right;' ></div>"}) ],
								tabs: [ {title: "修改密码",autoDraw: false,pane:isc.MatrixHTMLFlow.create({ID:"MTabPanel001",autoDraw: false,width: "100%",height: "100%",overflow: "hidden",contents:"<div id='TabPanel001_div' style='width:100%;height:100%'></div>"})} ] });document.getElementById('TabContainer001_div').style.display='none';MTabPanel001.draw();isc.Page.setEvent("load","MTabContainer001.selectTab(0);");
			</script>
		</div>
		
		<div id="TabPanel001_div2" style="width:100%;height:100%;overflow:hidden;" class="matrixInline">
		<table id="table001" class="tableLayout" style="width:100%;">
			<tr id="tr001">
				<td id="td001" class="maintain_form_label2" style="width:30%;text-align:center;">
					<label id="label001" name="label001" id="label001">
						原密码：
					</label>
				</td>
				<td id="td002" class="tdLayout" style="width:70%;">
					<div id="oldPassword_div"  eventProxy="Mform0" class="matrixInline" style="height:100%;"></div>
					<script> 
						var oldPassword=isc.PasswordItem.create({
							ID:"MoldPassword",
							name:"oldPassword",
							value:"${oldPassword}",
							editorType:"PasswordItem",
							displayId:"oldPassword_div",
							position:"relative",
							width:300,
							height:"100%",
							required:true,
							validators:[{
								type:"custom",
								condition:function(item, validator, value, record){
									return lengthValidate0(item, validator, value, record);
								},
								errorMessage:"原密码必须在100个字符之内!"}]
							
						});
						Mform0.addField(oldPassword);
						</script>
						<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                    		*
               			 </span>
				</td>
			</tr>
			<tr id="tr002">
				<td id="td003" class="maintain_form_label2" style="width:30%;text-align:center;">
					<label id="label002" name="label002" id="label002">
						新密码：
					</label>
				</td>
				<td id="td004" class="tdLayout" style="width:70%;">
				<div id="newPassword_div" eventProxy="Mform0" class="matrixInline" style="height:100%;"></div>
					<script> var newPassword=isc.PasswordItem.create({
									ID:"MnewPassword",
									name:"newPassword",
									value:"${newPassword}",
									editorType:"PasswordItem",
									displayId:"newPassword_div",
									position:"relative",
									width:300,height:"100%",
									required:true,
									validators:[{
										type:"custom",
										condition:function(item, validator, value, record){
											return lengthValidate1(item, validator, value, record);
										},
										errorMessage:"新密码必须在100个字符之内!"}]
							});Mform0.addField(newPassword);
					</script>
					<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                    		*
               			 </span>
				</td>
			</tr>
			<tr id="tr003">
				<td id="td005" class="maintain_form_label2" style="width:30%;text-align:center;">
					<label id="label003" name="label003" id="label003">
						重复新密码：
					</label>
				</td>
				<td id="td006" class="tdLayout" style="width:70%;">
					<div id="input003_div" eventProxy="Mform0" class="matrixInline" style="height:100%;"></div>
						<script> 
							var input003=isc.PasswordItem.create({
								ID:"Minput003",
								name:"input003",
								value:"",
								editorType:"PasswordItem",
								displayId:"input003_div",
								position:"relative",
								width:300,
								height:"100%",
								required:true,
								validators:[{
								type:"custom",
								condition:function(item, validator, value, record){
									return lengthValidate2(item, validator, value, record);
								},
								errorMessage:"重复密码必须在100个字符之内!"}]
							});
							Mform0.addField(input003);
						</script>
						<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                    		*
               			 </span>
					</td>
			</tr>
			<tr id="tr004">
				<td id="td007" class="tdLayout" colspan="2" rowspan="1" style="width:892px;text-align:center;border:0px;"><div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
					<script>
						isc.Button.create({
						ID:"Mbutton001",
						name:"button001",
						title:"提交",
						displayId:"button001_div",
						position:"absolute",
						top:0,left:0,
						width:"100%",
						height:"100%",
						//icon:"[skin]/images/matrix/actions/save.png",
						showDisabledIcon:false,
						showDownIcon:false,
						showRollOverIcon:false
					});
					Mbutton001.click=function(){
						Matrix.showMask();
						//校验
						if(!Mform0.validate()){
							Matrix.hideMask(); 
							return false;
						}
						checkPassword();
						Matrix.hideMask();
					};</script>
				</div>
		</td>
</tr>
</table>

</div>
<script>
	document.getElementById('TabPanel001_div').appendChild(document.getElementById('TabPanel001_div2'));
</script>
<div id="TabBar001_div2" style="text-align:right" class="matrixInline"></div>
<script>
	document.getElementById('TabBar001_div').appendChild(document.getElementById('TabBar001_div2'));
</script>
<script>
	document.getElementById('TabContainer001_div').style.display='';
</script>
</form>
</div>
<script>
	Mform0.initComplete=true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,function(){
		isc.Page.setEvent(
			isc.EH.RESIZE,"Mform0.redraw()",null);
		},isc.Page.FIRE_ONCE);
</script>
</body>
</html>
