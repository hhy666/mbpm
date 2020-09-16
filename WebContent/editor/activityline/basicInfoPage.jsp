<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.matrix.template.object.transition.Transition" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>活动连线基本信息页面</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="text/css">
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
	<%
	  int phase = (Integer)session.getAttribute("matrix_phaseId");
	%>
	<script type="text/javascript">
		
		//弹出条件窗口
		function openpopupSelectDialog2(){
			Matrix.setFormItemValue('editFlag','');
			var conditionValue = Matrix.getFormItemValue('inputTextArea002');
			var express = Matrix.getFormItemValue("express");
			parent.Matrix.setFormItemValue('conditionValue',conditionValue);
			parent.Matrix.setFormItemValue('express',express);
			<%
			if(phase == 4){ //实施阶段	
			%>
			var params="";
			var firstCondition = Matrix.getFormItemValue('inputTextArea002');
			var value;
			params="entrance=ProcessConnection";      //编辑流程连线入口  
			params+="&firstCondition="+encodeURI(firstCondition);
			parent.popupSelectDialog3Dialog(this,params);   //loadActivityLineTreeNodePage.jsp弹出
			<%
			 }else{
			%>
			parent.popupSelectDialog2Dialog(this);   //loadActivityLineTreeNodePage.jsp弹出
			<%
			 }
			%>
		}

		//onblur保存数据
		function save(flag){
			var data = Matrix.formToObject('form0');
			var url = "<%=request.getContextPath()%>/editor/editor_updateActivityLineInfo.action";
			var transitionId = Matrix.getFormItemValue('input001');
			var name = Matrix.getFormItemValue('input002');
			if(name==null||name=='null'||name=='undefined'){
				name="";
			}
			debugger;
			Matrix.sendRequest(url,data,function(){
				//都是保存成功  点击的按钮不一样，造成不同的结果
				if(flag){//flag ：true  允许关闭  ；false：不允许关闭
					parent.closeDialog();
				}else if(!flag){
					Matrix.say("保存成功！");
				}
			});
			parent.window.parent.updateTransitionName(transitionId,name);  //修改连线名称
			debugger;
			var type = Matrix.getFormItemValue('type');
			parent.window.parent.initProperties('Connector',transitionId);   //初始右侧连线属性
		}
		
		function saveCondition(){
			var data = Matrix.formToObject('form0');
			var url = "<%=request.getContextPath()%>/editor/editor_updateActivityLineInfo.action";
			var transitionId = Matrix.getFormItemValue('input001');
			var name = Matrix.getFormItemValue('input002');
			if(name==null||name=='null'||name=='undefined'){
				name="";
			}
			Matrix.sendRequest(url,data,function(){});
		}
		
		//是否选择返回转移  是  显示是否返回给原执行人组件
		function IsReturn(){
			var status = Matrix.getFormItemValue('comboBox001');
			if(status=='1'){
				document.getElementById('isReturn').style.display='';
			}else{
				document.getElementById('isReturn').style.display='none';
			}
		}
		
		//设置焦点
		function setFocus(){
			var input = document.getElementsByName('input002')[0];
			input.focus();
		}
		
		//初始加载
		window.onload=function(){
			setFocus();
			var isGoBack = '${isGoBack}';
			if(isGoBack=='1'){//是返回转移  显示是否返回给原执行人
				document.getElementById('isReturn').style.display='';
			}
			var phase="<%=phase%>"; 
			if(phase != 4){
				document.getElementById("tr006").style.display="none";
				document.getElementById("tr007").style.display="none";
			}else{
				//document.getElementById("tr003").style.display="none";
			}
			
			if($("#comboBox003").val() == 0){     //条件分支
				$("#comboBox004").attr("disabled",false);
			}else if($("#comboBox003").val() == 1){  //手动分支
				$("#comboBox004").val(0);
				$("#comboBox004").attr("disabled",true);
			}
			$("#comboBox003").change(function(){
				var value = $(this).val();
				if(value == 0){    //条件分支
					$("#comboBox004").attr("disabled",false);
				}else if(value == 1){    //手动分支 直接默认非强制并且不可编辑
					$("#comboBox004").val(0);
					$("#comboBox004").attr("disabled",true);
				}
			});
		}
	</script>
</head>
<body>

<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow-x: hidden;overflow-y: auto;">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_getCurActivityEditProperty.action" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input name="authId" id="authId" type="hidden" value="${activity.authItemId}"/>
	<input name="custom" id="custom" type="hidden" value="${param.custom}"/>
	<input name="data" id="data" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="transitionId" id="transitionId" type="hidden" value="${param.transitionId }"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input type="hidden" name="express" id="express" value="${transitionLine.condition.value}"/>
	<input name="iframewindowid" id="iframewindowid" type="hidden" value="Dialog001"/>
	<%
		Transition transitionLine  = (Transition)request.getAttribute("transitionLine");
	%>
	<table id="table001" class="tableLayout" style="width:100%;" >
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107" colspan="2" style="width:100%;"><font id="font2">基本信息</font></td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:25%;">
				<label id="label001" name="label001" id="label001">
					编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
				</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:75%;">
				<div id="input001_div" style="vertical-align: middle;">
					<input id="input001" name="input001" type="text" value="${transitionLine.id}" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
				</div>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:25%;">
				<label id="label002" name="label002" id="label002">
					名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：
				</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:75%;">
				<div id="input002_div" style="vertical-align: middle;">
					<input id="input002" name="input002" type="text" value="${transitionLine.name}" class="form-control" style="height:100%;width:100%;"/>
				</div>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="tdLabelCls" style="width:25%;">
				<label id="label003" name="label003" id="label003">
					优&nbsp;&nbsp;先&nbsp;&nbsp;级：
				</label>
			</td>
			<td id="td008" class="tdValueCls" style="width:75%;">
				<div id="numberSpinner001_div" style="vertical-align:middle; ">
					<input type="number" id="numberSpinner001" class="form-control" name="numberSpinner001" value="${transitionLine.priority}" style="width:100%;">
				</div>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:25%;">
				<label id="label003" name="label003" id="label003">
					返回转移：
				</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:75%;">
				<table style="width:100%">
					<tr>
						<td>
							<div id="comboBox001_div" style="vertical-align: middle;">
								<select id="comboBox001" name="comboBox001" value="${isGoBack}" class="form-control" onchange="IsReturn();"  style="height:100%;width:100%;">
			                       <option value="0" ${isGoBack == 0 ? "selected" : ""}>否</option>
			                       <option value="1" ${isGoBack == 1 ? "selected" : ""}>是</option>
			                    </select>
							</div>
						</td>
						<td id="isReturn" style="display:none;text-align: left;">
							<label id="label010" name="label010" id="label010">
								 是否返回给原执行人员：
							</label>
							<div id="comboBox002_div" style="vertical-align: middle;display: inline-block;width:40%;">
								<select id="comboBox002" name="comboBox002" value="${isOriginalPF}" class="form-control" style="height:100%;width:50%;">
			                       <option value="0" ${isOriginalPF == 0 ? "selected" : ""}>否</option>
			                       <option value="1" ${isOriginalPF == 1 ? "selected" : ""}>是</option>
			                    </select>
							</div>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
		<tr id="tr006">
			<td id="td011" class="tdLabelCls" style="width:25%;">
				<label id="label003" name="label003">
					分支类型：
				</label>
			</td>
			<td id="td012" class="tdValueCls" style="width:75%;">
				<table style="width:100%;">
					<tr>
						<td>
							<div id="comboBox003_div" style="width：100%;vertical-align: middle;">
								<select id="comboBox003" name="comboBox003" value="${transitionLine.routeType}" class="form-control" style="height:100%;">
			                       <option value="0" ${transitionLine.routeType == 0 ? "selected" : ""}>条件分支</option>
			                       <option value="1" ${transitionLine.routeType == 1 ? "selected" : ""}>手动分支</option>
			                    </select>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="tr007">
			<td id="td013" class="tdLabelCls" style="width:25%;">
				<label id="label003" name="label003">
					强制类型：
				</label>
			</td>
			<td id="td014" class="tdValueCls" style="width:75%;">
				<table style="width:100%;">
					<tr>
						<td>
							<div id="comboBox004_div" style="vertical-align: middle;">
								<select id="comboBox004" name="comboBox004" value="${transitionLine.forceType}" class="form-control" style="height:100%;">
			                       <option value="0" ${transitionLine.forceType == 0 ? "selected" : ""}>非强制</option>
			                       <option value="1" ${transitionLine.forceType == 1 ? "selected" : ""}>强制</option>
			                    </select>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="tr005">
			<td id="td009" class="tdLabelCls" style="width:20%;">
				<label id="label005" name="label005" id="label005">
					条&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：
				</label>
			</td>
			<td id="td010" class="tdValueCls" style="width:80%;">
				<div id="popupSelectDialog2_div" class="input-group">
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;">${condition}</textarea>
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog2();"><i class="fa fa-search"></i></span>
				</div>			
			</td>
		</tr>
		<tr id="tr010">
			<td id="td015" class="tdLabelCls" style="width: 25%;">
				<label id="label015" name="label015" id="label015">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：</label>
			</td>
			<td id="td018" class="tdValueCls" style="width: 75%;">
				<div id="inputTextArea001_div">
					<%
					if(transitionLine.getDescription()!=null && transitionLine.getDescription().trim().length()>0){
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;"><%=transitionLine.getDescription()%></textarea>
					<% 
					}else{
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;"></textarea>
					<%
					}
					%>
				</div>
			</td>
		</tr>
	</table>
 </form>
</div>
</body>
</html>