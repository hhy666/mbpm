<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.matrix.template.object.activity.Activity" %>
<%@ page language="java" import="com.matrix.form.admin.entreflow.action.ConvertDisplayStr" %>
<%@ page language="java" import="com.matrix.template.object.Condition" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>高级属性</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style>
		font{
			font-size:14px;
			margin-left:10px;
			font-weight:bold;
		}
		#td101{
			width:100%;
			height:30px;
			background:#F8F8F8;
		}
		
	</style>
	
	<script type="text/javascript">
		//保存高级属性
		function saveAdvanceProperty(){
			var editFlag = Matrix.getFormItemValue('editFlag');
			var formObj = Matrix.formToObject('form0');
			if(formObj!=null){
				//双引号处理----asd
				if(formObj.inputTextArea001.indexOf("\"") >= 0 || formObj.inputTextArea001.indexOf("“") >= 0 || formObj.inputTextArea001.indexOf("”") >= 0 ){
					formObj.inputTextArea001 = formObj.inputTextArea001.replaceAll("\"","----#&#----");
				}
				if(formObj.inputTextArea002.indexOf("\"") >= 0 || formObj.inputTextArea002.indexOf("“") >= 0 || formObj.inputTextArea002.indexOf("”") >= 0 ){
					formObj.inputTextArea002 = formObj.inputTextArea002.replaceAll("\"","----#&#----");
				}
				if(formObj.startExpress.indexOf("\"") >= 0 || formObj.startExpress.indexOf("“") >= 0 || formObj.startExpress.indexOf("”") >= 0 ){
					formObj.startExpress = formObj.startExpress.replaceAll("\"","----#&#----");
				}
				if(formObj.endExpress.indexOf("\"") >= 0 || formObj.endExpress.indexOf("“") >= 0 || formObj.endExpress.indexOf("”") >= 0 ){
					formObj.endExpress = formObj.endExpress.replaceAll("\"","----#&#----");
				}
				var url = "<%=request.getContextPath()%>/editor/editor_updateAdvancePropertyInfo.action";
				Matrix.sendRequest(url,formObj,function(data){
					if(data!=null && data.data!=''){
						var result = isc.JSON.decode(data.data);
						if(!result.flag){
							return;
						}
					}
					
				});
			}	
		}
		//设置焦点
		function setFocus(){
			var input = document.getElementsByName('inputTextArea001')[0];
			input.focus();
		}
		window.onblur = function(){
			saveAdvanceProperty();	
		}
		
		//开始条件弹出条件编辑窗口
		function openpopupSelectDialog001(){
			var conditionValue = Matrix.getFormItemValue('inputTextArea001');
			parent.Matrix.setFormItemValue('conditionValue',conditionValue);
			parent.openSatrtCondition(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//完成条件弹出条件编辑窗口
		function openpopupSelectDialog002(){
			var conditionValue = Matrix.getFormItemValue('inputTextArea002');
			parent.Matrix.setFormItemValue('conditionValue',conditionValue);
			parent.openFinishCondition(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}

		window.onload=function(){
			var phase="<%=session.getAttribute("phase")%>"; 
			if(phase == 4){
				document.getElementById("tr001").style.display="none";
				document.getElementById("tr002").style.display="none";
			}
			if(phase != 4){
				document.getElementById("tr010").style.display="none";
			}
			var type = Matrix.getFormItemValue("type");
			if(type!=null && type.length>0){
				Matrix.setFormItemValue('editFlag','edit');
				if(type=='HumanTask'){//人工活动
					//执行方式
					document.getElementById('tr200').style.display="none";
					document.getElementById('td201').style.display="none";
					document.getElementById('td202').style.display="none";
					
					if(phase == 4){   //实施阶段控制只显示归档复选框
						document.getElementById('tr007').style.display="none";
						document.getElementById('tr008').style.display="none";
						document.getElementById('tr009').style.display="none";
					}

				}else if(type=='AutomaticAct'){//自动活动的高级属性
					document.getElementById('tr107').style.display="none";
					document.getElementById('td107').style.display="none";
					//执行方式
					document.getElementById('tr200').style.display="none";
					document.getElementById('td201').style.display="none";
					document.getElementById('td202').style.display="none";
					
				}else if(type=='BlockAct'){//内部子流程
					document.getElementById('tr107').style.display="none";
					document.getElementById('td107').style.display="none";
					//执行方式
					document.getElementById('tr200').style.display="none";
					document.getElementById('td201').style.display="none";
					document.getElementById('td202').style.display="none";
					
				}else if(type=='SubflowAct'){  //外部子流程
					document.getElementById('tr107').style.display="none";
					document.getElementById('td107').style.display="none";
					
				}
				//复选框选中
				$("input:checkbox[name^='checkBoxGroup001_']").on('ifChecked', function(event){		
					$(this).val(1);
					window.focus();
				});
				
				//复选框取消选中
				$("input:checkbox[name^='checkBoxGroup001_']").on('ifUnchecked', function(event){
					$(this).val('');
					window.focus();
				});
				
				setTimeout('setFocus()',500);
			}
		}
	</script>
</head>
<body>
 <div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
   <form id="form0" name="form0" eventProxy="Mform0" method="post" action=""
	 style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded" >
	<input name="editFlag" id="editFlag" type="hidden"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input type="hidden" id="startExpress" name="startExpress" value="${activity.preCondition.value }"/>
	<input type="hidden" id="endExpress" name="endExpress" value="${activity.postCondition.value }"/>
	<%
		Activity activity = (Activity)request.getAttribute("activity");
		String postCondition = "";
		String preCondition = "";
		if(activity!=null){
			Condition cond = activity.getPostCondition();
			if(cond!=null){
				postCondition = cond.getValue();
			}
			Condition cond1 = activity.getPreCondition();
			if(cond!=null){
				preCondition = cond1.getValue();
			}
		}
	%>
	<table id="table001" class="tableLayout" style="width:100%;">
		<tr id="tr101">
			<td id="td101" class="tdLabelCls" style="width:100%;height:30px;text-align:left;" colspan="2"><font>高级属性</font></td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdValueCls" style="width:20%;text-align:center;">
				<label id="label001" name="label001" id="label001">
					开始条件：
				</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:80%;">
				<div id="popupSelectDialog001_div" class="input-group" style="width:70%;">
					<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;">${startCondition}</textarea>
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog001();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdValueCls" style="width:20%;text-align:center;">
				<label id="label002" name="label002" id="label002">
					完成条件：
				</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:80%;">
				<div id="popupSelectDialog002_div" class="input-group" style="width:70%;">
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;">${endCondition}</textarea>
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog002();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr107">
			<td id="td106" class="tdValueCls" style="width:20%;text-align:center;">
				<label id="label002" name="label002" id="label002">
					授权：
				</label>
			</td>
			<td id="td107" class="tdValueCls" style="width:80%;">
				<table id="table301" class="tableLayout" style="width:100%;border:0px">
						<tr id="tr301">
							<td id="td301" class="tdValueCls" style="width:100%;text-align:left;border:0px;padding-bottom: 3px;">
								<span id="checkBoxGroup001_div" style="height:100px;">
									<table border="0" style="margin:0px;padding: 0px;display: inline;width:70%;height:50px;" cellspacing="0" cellpadding="0">
										<tbody>
											<tr id="tr007">
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_0_div" id="checkBoxGroup001_0_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_0" id="checkBoxGroup001_0" value="${activity.transferEnable=='true'?'1':''}"  ${activity.transferEnable=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许转交
													</label>
												</td>
												
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_1_div" id="checkBoxGroup001_1_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_1" id="checkBoxGroup001_1" value="${activity.substituteEnable=='true'?'1':''}"  ${activity.substituteEnable=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许委托
													</label>													
												</td>
												
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_4_div" id="checkBoxGroup001_4_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_4" id="checkBoxGroup001_4" value="${activity.keepTasks=='true'?'1':''}"  ${activity.keepTasks=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许反复提交
													</label>													
												</td>
											</tr>
											<tr id="tr008">
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_2_div" id="checkBoxGroup001_2_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_2" id="checkBoxGroup001_2" value="${activity.withdrawEnable=='true'?'1':''}"  ${activity.withdrawEnable=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许撤回
													</label>											
												</td>
												
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_3_div" id="checkBoxGroup001_3_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_3" id="checkBoxGroup001_3" value="${activity.gobackEnable=='true'?'1':''}"  ${activity.gobackEnable=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许回退
													</label>						
												</td>
												
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_5_div" id="checkBoxGroup001_5_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_5" id="checkBoxGroup001_5" value="${activity.jumpEnable=='true'?'1':''}"  ${activity.jumpEnable=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许任意跳转
													</label>														
												</td>
											</tr>
											<tr id="tr009">												
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_6_div" id="checkBoxGroup001_6_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_6" id="checkBoxGroup001_6" value="${activity.viewEnable=='true'?'1':''}"  ${activity.viewEnable=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许传阅
													</label>	
												</td>
												
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_7_div" id="checkBoxGroup001_7_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_7" id="checkBoxGroup001_7" value="${activity.assistEnable=='true'?'1':''}"  ${activity.assistEnable=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														允许协作
													</label>												
												</td>
												
												<td style="padding-left: 2px;padding-top: 2px;border-style:none;;height:27px;">
													<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_8_div" id="checkBoxGroup001_8_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_8" id="checkBoxGroup001_8" value="${activity.singleAvailableActInsFlag=='true'?'1':''}"  ${activity.singleAvailableActInsFlag=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														限定唯一活动实例
													</label>													
												</td>
											</tr>
											
											<!-- 自动归档复选框 -->
											<tr id="tr010">
											    <td style="padding-left: 2px;padding-top: 2px;border-style:none;;height:27px;">
											    	<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_9_div" id="checkBoxGroup001_9_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_9" id="checkBoxGroup001_9" value="${activity.archiveFlag=='true'?'1':''}"  ${activity.archiveFlag=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														自动归档
													</label>							
												</td>
												
												 <td style="padding-left: 2px;padding-top: 2px;border-style:none;;height:27px;">
												 	<div style="display: inline-table;margin-left: 40px;" name="checkBoxGroup001_10_div" id="checkBoxGroup001_10_div" >
														<input type="checkbox" class="box" name="checkBoxGroup001_10" id="checkBoxGroup001_10" value="${activity.processPass=='true'?'1':''}"  ${activity.processPass=='true'?'checked':''}/>
													</div>
													<label name="label0032" id="label0032" class="control-label ">
														核定通过
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
		
		<tr id="tr200">
			<td id="td201" class="tdValueCls" style="width:20%;text-align:center;">
				<label id="label203" name="label203" id="label203">
					执行方式：
				</label>
			</td>
			<td id="td202" class="tdValueCls" style="width:80%;height:80px;text-align:left;">
				<div id="radioGroup001_0_div"  style="display: inline-table;margin-left:40px;" >
					<input type="radio" class="box" name="radioGroup001" id="value_0" value="1" ${executionType=='1'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label">
					同步
				</label>
				<div id="radioGroup001_1_div"  style="display: inline-table;margin-left:40px;" >
					<input type="radio" class="box" name="radioGroup001" id="value_1" value="2" ${executionType=='2'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label">
					异步
				</label>	
			</td>
		</tr>
			
	</table>
 </form>
</div>

</body>
</html>