<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>任务提醒事件属性页面</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script type="text/javascript">
		//提醒目标下拉框改变事件
		function checkIsSelectedUser(){
			debugger;
			var remindTarget = Matrix.getFormItemValue("comboBox001");
			if(remindTarget=='5'){
				document.getElementById('td006').colspan="1";
				document.getElementById('td006').style.width="40%";
				document.getElementById('td111').style.display='';
			}else{
				document.getElementById('td006').colspan="2";
				document.getElementById('td006').style.width="80%";
				document.getElementById('td111').style.display='none';
			}
		}
		//得到焦点事件
		window.onfocus=function(){
			Matrix.setFormItemValue('editFlag','edit');
		}
		//窗口失去焦点时保存窗口的数据
		window.onblur=function(){
			saveRemindEvent();
		}
		function saveRemindEvent(){
			var editFlag = Matrix.getFormItemValue('editFlag');
			if(editFlag==null || editFlag!='edit'){
				return ;
			}
			var synJson = Matrix.formToObject('form0');
			if(synJson!=null){
				var url = "<%=request.getContextPath()%>/editor/editor_saveRemindEventDetailProperty.action";
				Matrix.sendRequest(url,synJson,function(){
					return true;
				});
				
			}
		}
		window.onload=function(){
			debugger;
			var remindTarget = Matrix.getFormItemValue("comboBox001");
			if(remindTarget == '5'){
			
				document.getElementById('td006').colspan="1";
				document.getElementById('td006').style.width="40%";
				document.getElementById('td006').style.borderRight="0px";
				document.getElementById('td111').style.borderLeft='0px';
				document.getElementById('td111').style.display='';
			}else{
				document.getElementById('td006').colspan="2";
				document.getElementById('td006').style.width="80%";
				document.getElementById('td006').style.borderRight="1px";
				document.getElementById('td111').style.display='none';
			}
			//邮件复选框选中
			$("input:checkbox[name='checkBoxGroup001_0']").on('ifChecked', function(event){		
				$('#checkBoxGroup001_0').val(1);
				window.focus();
			});
			//邮件复选框取消选中
			$("input:checkbox[name='checkBoxGroup001_0']").on('ifUnchecked', function(event){
				$('#checkBoxGroup001_0').val('');
				window.focus();
			});
			//短信复选框选中
			$("input:checkbox[name='checkBoxGroup001_1']").on('ifChecked', function(event){		
				$('#checkBoxGroup001_1').val(2);
				window.focus();
			});
			//短信复选框取消选中
			$("input:checkbox[name='checkBoxGroup001_1']").on('ifUnchecked', function(event){
				$('#checkBoxGroup001_1').val('');
				window.focus();
			});
			//即时消息复选框选中
			$("input:checkbox[name='checkBoxGroup001_2']").on('ifChecked', function(event){		
				$('#checkBoxGroup001_2').val(3);
				window.focus();
			});
			//即时消息复选框取消选中
			$("input:checkbox[name='checkBoxGroup001_2']").on('ifUnchecked', function(event){
				$('#checkBoxGroup001_2').val('');
				window.focus();
			});
			//系统内消息复选框选中
			$("input:checkbox[name='checkBoxGroup001_3']").on('ifChecked', function(event){		
				$('#checkBoxGroup001_3').val(4);
				window.focus();
			});
			//系统内消息复选框取消选中
			$("input:checkbox[name='checkBoxGroup001_3']").on('ifUnchecked', function(event){
				$('#checkBoxGroup001_3').val('');
				window.focus();
			});
		}
		
		//弹出选择活动执行人窗口
		function openpopupSelectDialog2(){
			parent.parent.parent.openChooseActivities(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//弹出条件编辑窗口
		function openpopupSelectDialog001(){
			<%
			int phaseStatus = (Integer)session.getAttribute("phase");										
			if(phaseStatus == 4){ //实施阶段	
			%>	
			var conditionValue = Matrix.getFormItemValue('popupSelectDialog001');
			parent.parent.parent.openConditionEditByAdmin(this,conditionValue);     //loadBasicActivityTreeNodePage.jsp弹出
			<%
			}else{  //设计开发
			%>
			parent.parent.parent.openConditionEditByDesigner(this);    //loadBasicActivityTreeNodePage.jsp弹出
			<%
			}
			%>
			
		}
		
		//标题弹出选择流程变量窗口
		function openpopupSelectDialog1(){
			parent.parent.parent.openVariables3(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//内容弹出选择流程变量窗口
		function openpopupSelectDialog4(){
			parent.parent.parent.openVariables4(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_getCurActivityEditProperty.action"
	style="margin: 0px; height: 100%;overflow:auto;overflow-x:hidden;" enctype="application/x-www-form-urlencoded">
	<input name="data" id="data" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input name="index" id="index" type="hidden" value="${param.index }"/>
	<input name="entityId" id="entityId" type="hidden" value="${param.entityId }"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<!-- 选定的执行人员比编码 -->
	<input name="selectedUserId" id="selectedUserId" type="hidden" value="${notifyInfo.actId }"/>
	<input name="iframewindowid" id="iframewindowid" type="hidden" value="Dialog001"/>
	<input name="express" id="express" type="hidden" value=""/>
	
	<table id="table001" class="tableLayout" style="width:100%;" >
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:20%;text-align:right;">
				<label id="label001" name="label001" id="label001">
					名&nbsp;&nbsp;&nbsp;&nbsp;称：
				</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:80%;" colspan="2">
				<div id="input001_div" style="vertical-align: middle;">
					<input id="input001" name="input001" type="text" value="${notifyInfo.name}" class="form-control" style="height:100%;width:100%;" onkeyup="changeContent();"/>
				</div>
			</td>
		</tr>
		<script>
			 //改变任务提醒名称文本框内容事件
			function changeContent(){
			     var name = Matrix.getFormItemValue('input001');//名称
			     var index = Matrix.getFormItemValue('index');
				 parent.parent.updateName(name,index);
			}
		</script>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:20%;text-align:right;" colspan="1">
				<label id="label003" name="label003" id="label003">
					提醒目标：
				</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:50%;" colspan="1">
				<div id="comboBox001_div" style="vertical-align: middle;">
					<select id="comboBox001" name="comboBox001" value="${notifyInfo.receipientType=='ProcessAdmins'?'2':notifyInfo.receipientType=='ProcessParticipants'?'3':notifyInfo.receipientType=='ParticipantsExceptCurOwner'?'4':notifyInfo.receipientType=='TaskExecutor'?'5':notifyInfo.receipientType=='TasksTakeholder'?'7':notifyInfo.receipientType=='AllTaskExecutorsExceptCurOwner'?'8':'1'}" 
					class="form-control" style="height:100%;" onchange="checkIsSelectedUser();">
                       <option value="1" ${notifyInfo.receipientType=='ProcessStarter' ? "selected" : ""}>流程启动人员</option>
                       <option value="2" ${notifyInfo.receipientType=='ProcessAdmins' ? "selected" : ""}>流程实例管理人员</option>
                       <option value="3" ${notifyInfo.receipientType=='ProcessParticipants' ? "selected" : ""}>所有流程参与者</option>
                       <option value="4" ${notifyInfo.receipientType=='ParticipantsExceptCurOwner' ? "selected" : ""}>除实际执行人员以外的参与者</option>
                       <option value="5" ${notifyInfo.receipientType=='TaskExecutor' ? "selected" : ""}>选定活动执行人员</option>
                       <option value="7" ${notifyInfo.receipientType=='TasksTakeholder' ? "selected" : ""}>当前活动所有任务分派人员</option>
                       <option value="8" ${notifyInfo.receipientType=='AllTaskExecutorsExceptCurOwner' ? "selected" : ""}>除当前活动的所有流程活动执行人员</option>
                    </select>
				</div>
			</td>
			<td id="td111" class="tdValueCls" style="width:40%" colspan="1">
				<div id="popupSelectDialog2_div" class="input-group">
					 <input type="text" id="popupSelectDialog2" name="popupSelectDialog2" value="${selectedAct=='null'?'':selectedAct}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog2();"><i class="fa fa-search"></i></span>
				</div>
			</td>	
		</tr>	
		<tr id="tr004">
			<td id="td007" class="tdLabelCls" style="width:20%;text-align:right;">
				<label id="label004" name="label004" id="label004">
					条件：
				</label>
			</td>
			<td id="td008" class="tdValueCls" style="width:80%;" colspan="2">
				<div id="popupSelectDialog001_div" class="input-group"  style="width:100%;">
					 <input type="text" id="popupSelectDialog001" name="popupSelectDialog001" value="${condition}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog001();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr101">
			<td id="td101" class="tdLabelCls" style="width:20%;text-align:right;border-right:0px;" colspan="1">
				<label id="label105" name="label105" id="label105">
					发送方式：
				</label>
			</td>
			<td id="td103" class="tdLabelCls" style="width:80%;border-left:0px;" colspan="2">
			</td>
		</tr>
		<tr id="tr102" >
			<td id="td121" class="tdValueCls" style="width:20%;border-right:0px" colspan="1"></td>
			<td id="td102" class="tdValueCls" style="width:80%;text-align:right;border-left:0px" colspan="2">
				<table id="table001" class="tableLayout" style="width:100%;border:0px">
					<tr id="tr001">
						<td id="td001" class="tdValueCls" style="width:100%;text-align:left;border:0px;">
							<span id="checkBoxGroup001_div" style="height:100px;">
								<table border="0" style="margin:0px;padding: 0px;display: inline;width:70%;height:50px;" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
												<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_0_div" id="checkBoxGroup001_0_div" >
													<input type="checkbox" class="box" name="checkBoxGroup001_0" id="checkBoxGroup001_0" value="${notifyInfo.isEmailNotification=='true'?'1':''}"  ${notifyInfo.isEmailNotification=='true'?'checked':''}/>
												</div>
												<label name="label0032" id="label0032" class="control-label ">
													邮件
												</label>
											</td>
											
											<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
												<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_1_div" id="checkBoxGroup001_1_div" >
													<input type="checkbox" class="box" name="checkBoxGroup001_1" id="checkBoxGroup001_1" value="${notifyInfo.isSMSNotification=='true'?'2':''}"  ${notifyInfo.isSMSNotification=='true'?'checked':''}/>
												</div>
												<label name="label0032" id="label0032" class="control-label ">
													短信
												</label>
											</td>
										</tr>
										<tr>
											<td style="padding-left: 2px;padding-top: 2px;border-style:none;;height:27px;">
												<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_2_div" id="checkBoxGroup001_2_div" >
													<input type="checkbox" class="box" name="checkBoxGroup001_2" id="checkBoxGroup001_2" value="${notifyInfo.isRTXNotification=='true'?'3':''}"  ${notifyInfo.isRTXNotification=='true'?'checked':''}/>
												</div>
												<label name="label0032" id="label0032" class="control-label ">
													即时消息
												</label>
											</td>
											
											<td style="padding-left: 2px;padding-top: 2px;border-style:none;;height:27px;">
												<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_3_div" id="checkBoxGroup001_3_div" >
													<input type="checkbox" class="box" name="checkBoxGroup001_3" id="checkBoxGroup001_3" value="${notifyInfo.isMessageNotification=='true'?'4':''}"  ${notifyInfo.isMessageNotification=='true'?'checked':''}/>
												</div>
												<label name="label0032" id="label0032" class="control-label ">
													系统内消息
												</label>										
											</td>
										</tr>
									</tbody>
								</table>
							</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="tr201">
			<td id="td201" class="tdLabelCls" style="width:20%;text-align:right;border-right:0px;">
				<label id="label001" name="label001" id="label001">
					发送消息：
				</label>
			</td>
			<td id="td002" class="tdLabelCls" style="width:80%;border-left:0px;" colspan="2">	
			</td>
		</tr>
		<tr id="tr006">
			<td id="td011" class="tdLabelCls" style="width:20%;text-align:right;">
				<label id="label006" name="label006" id="label006">
					标题：
				</label>
			</td>
			<td id="td012" class="tdValueCls" style="width:80%;" colspan="2">
				<div id="popupSelectDialog1_div" class="input-group" style="width:100%;">
					 <input type="text" id="popupSelectDialog1" name="popupSelectDialog1" value="${notifyInfo.subject}"  class="form-control">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog1();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr012">
			<td id="td019" class="tdLabelCls" style="width: 20%; text-align: right; border-right: 0px;">
			   <label id="label016" name="label016" id="label016"> 内容：</label>
			 </td>
			<td id="td020" class="tdValueCls" colspan="2" style="width: 80%; border-left: 0px;">&nbsp;</td>
		</tr>
		<tr id="tr013">
			<td id="td021" class="tdValueCls" style="width: 20%; text-align: center; border-right: 0px;"></td>
				<td id="td022" class="tdValueCls" style="width: 80%; border-left: 0px;" colspan="2">
					<div id="popupSelectDialog4_div" class="input-group" style="width:100%;">
						<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;">${notifyInfo.content}</textarea>
            			<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog4();"><i class="fa fa-search"></i></span>
					</div>
				</td>
			</tr>
		</table>
	</form>
 </div>
</body>
</html>