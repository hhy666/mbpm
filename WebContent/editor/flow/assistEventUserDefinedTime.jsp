<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import = "com.matrix.template.object.resource.EscalationAction" %>
<%@ page import = "com.matrix.template.object.resource.DeadLineInfo" %>
<%@ page import ="com.matrix.template.object.resource.NotifyInfo" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>用户自定义辅助事件时间</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script type="text/javascript">
			//页面失去焦点事件
			window.onblur = function(){
				debugger;
				//onblur时判断是否处于编辑状态，处于编辑状态 就保存，没有处于编辑状态就不保存
				var editFlag = Matrix.getFormItemValue('editFlag');
				if(editFlag==null || editFlag!='edit'){
					return false;
				}
				//获得页面组件的数据
				var deadLineType='1';//时间段 or 源自变量的时间值
				var isSetCalendar = Matrix.getFormItemValue('date_checkBox301');//是否绑定业务日历
				var calendarId = Matrix.getFormItemValue('popupSelectDialog301');//业务日历值
				var isSetDeadLine = Matrix.getFormItemValue('date_checkBox302');//是否设置时间值
				var durationValue='1';//固定值 or 变量值
				var deadLineValue;//时间值
				var variableId = Matrix.getFormItemValue('popupSelectDialog302');//源自变量的值
				var dv = document.getElementsByName('value');//固定值，变量值的单选按钮组
				if(dv[0].checked){
					durationValue = '1';
					deadLineValue = Matrix.getFormItemValue('input301');
				}else if(dv[1].checked){
					durationValue = '2';
					deadLineValue = Matrix.getFormItemValue('popupSelectDialog303');
				}
				var dlType = document.getElementsByName('time');
				if(dlType!=null&&dlType.length>0){
					if(dlType[0].checked){
						deadLineType='1';
					}else if(dlType[1].checked){
						deadLineType='2';
					}
				}
				var isAssist = Matrix.getFormItemValue('isAssist');
				if(isAssist!=null && isAssist=='tx'){
					isAssist = "";
				}else{
					isAssist = "isAssist";
				}
				var Id = Matrix.getFormItemValue('Id');
				var entityId = Matrix.getFormItemValue('entityId');
				var activityId = Matrix.getFormItemValue('activityId');
				var containerId = Matrix.getFormItemValue('containerId');
				var timeUnit = Matrix.getFormItemValue('comboBox301');
				//构造json
				var json = "{'deadLineType':'"+deadLineType
						 +"','isSetCalendar':'"+isSetCalendar
						 +"','calendarId':'"+calendarId
						 +"','timeUnit':'"+timeUnit
						 +"','isSetDeadLine':'"+isSetDeadLine
						 +"','durationValue':'"+durationValue
						 +"','deadLineValue':'"+deadLineValue
						 +"','variableId':'"+variableId
						 +"','Id':'"+Id
						 +"','entityId':'"+entityId
						 +"','isAssist':'"+isAssist
						 +"','containerId':'"+containerId
						 +"','activityId':'"+activityId+"'}";
				var synJson = isc.JSON.decode(json);
				//发送请求保存自定义属性
				var url = "<%=request.getContextPath()%>/editor/process_saveAssistEventUserDefinedProperty.action";
				Matrix.sendRequest(url,synJson,function(){
					return true;
				});
			}
			
			//页面得到焦点事件
			window.onfocus=function(){
				//onfocus时设置为编辑状态
				Matrix.setFormItemValue('editFlag','edit');
			}
			
			//页面初始事件
			window.onload=function(){
				debugger;
				$('#popupSelectDialog301_button').addClass('notclickn');
				$('#popupSelectDialog302_button').addClass('notclickn');
				$('#popupSelectDialog303_button').addClass('notclickn');
				
				var time = document.getElementsByName("time");
				if(time!=null&&time.length>0){
					if(time[0].checked){    //时间段选中
						//源自变量时间点 下的弹出选择不能点选
						$('#popupSelectDialog302_button').addClass('notclickn');
						
						//1选中   null未选中
						var bdywrl = Matrix.getFormItemValue('date_checkBox301');//绑定业务日历  
						var szsjz = Matrix.getFormItemValue('date_checkBox302');//设置时间值
						if(bdywrl!=null&&bdywrl=='1'){
							$('#popupSelectDialog301_button').removeClass('notclickn');
						}else{
							$('#popupSelectDialog301_button').addClass('notclickn');
							$('#popupSelectDialog301').val('');
						}
						if(szsjz!=null&&szsjz=='1'){
							$('#popupSelectDialog302_button').removeClass('notclickn');
							$('#popupSelectDialog303_button').removeClass('notclickn');
							var value = document.getElementsByName('value');//动态。静态。
							if(value!=null&&value.length>0){
								if(value[0].checked){
									$('#input301').attr('readonly',false);
									$('#popupSelectDialog303_button').addClass('notclickn');
									$('#popupSelectDialog303').val('');
								}else{
									$('#input301').attr('readonly',true);
									$('#popupSelectDialog303_button').removeClass('notclickn');
									$('#input301').val('');
								}
							}
						}else{
							$('#value_0').iCheck('disable');   //静态固定值
							$('#value_1').iCheck('disable');   //动态变量值
							$('#input301').attr('readonly',true);
							$('#popupSelectDialog303_button').addClass('notclickn');
						}
						$('#popupSelectDialog302').val('');
						
					}else if(time[1].checked){    //时间点选中
						$('#popupSelectDialog302_button').removeClass('notclickn');
						$('#date_checkBox301').iCheck('disable');
						$('#date_checkBox302').iCheck('disable');
						$('#value_0').iCheck('disable');
						$('#value_1').iCheck('disable');
						$('#input301').attr('readonly',true);
						$('#popupSelectDialog301').val('');
						$('#popupSelectDialog303').val('');
						$('#input301').val('');
					}
				}
				
				//监听时间段 时间点单选按钮改变事件
				$("input:radio[name='time']").on('ifChecked', function(event){
					  debugger;
				      var time = $(this).val();  //1时间段。2时间点
				      if(time == 1){
				    	    $('#date_checkBox301').iCheck('enable');
							$('#date_checkBox302').iCheck('enable');
						    $('#popupSelectDialog302_button').removeClass('notclickn');
						    
						    var bdywrl = Matrix.getFormItemValue('date_checkBox301');//绑定业务日历
						    var szsjz = Matrix.getFormItemValue('date_checkBox302');//设置时间值
							if(bdywrl!=null&&bdywrl=='1'){
								$('#popupSelectDialog301_button').removeClass('notclickn');
							}else{
								$('#popupSelectDialog301_button').addClass('notclickn');
								$('#popupSelectDialog301').val('');
							}
						    
							if(szsjz!=null&&szsjz=='1'){
								$('#value_0').iCheck('enable');  //静态固定值可用
						    	$('#value_1').iCheck('enable');  //动态变量值可用
								var value = document.getElementsByName('value');//动态。静态。
								if(value!=null&&value.length>0){
									if(value[0].checked){
										$('#input301').attr('readonly',false);
										$('#popupSelectDialog303_button').addClass('notclickn');
									}else{
										$('#input301').attr('readonly',true);
										$('#popupSelectDialog303_button').removeClass('notclickn');
									}
								}
							}else{
								$('#value_0').iCheck('disable');   
								$('#value_1').iCheck('disable');   
								$('#input301').attr('readonly',true);
								$('#popupSelectDialog303_button').addClass('notclickn');
							}
						}else if(time == 2){
							$('#date_checkBox301').iCheck('disable');
							$('#date_checkBox302').iCheck('disable');
							$('#popupSelectDialog301_button').addClass('notclickn');
							$('#popupSelectDialog303_button').addClass('notclickn');
							$('#popupSelectDialog302_button').removeClass('notclickn');
							$('#value_0').iCheck('disable');
							$('#value_1').iCheck('disable');
							$('#input301').attr('readonly',true);
						}
				         window.focus();
				});
				
				//绑定业务日历复选框选中
				$("input:checkbox[name='date_checkBox301']").on('ifChecked', function(event){		
					$('#popupSelectDialog301_button').removeClass('notclickn');
					$('#date_checkBox301').val(1);
					window.focus();
				});
				
				//绑定业务日历复选框取消选中
				$("input:checkbox[name='date_checkBox301']").on('ifUnchecked', function(event){
					$('#popupSelectDialog301_button').addClass('notclickn');
					$('#date_checkBox301').val('');
					window.focus();
				});
				
				//设置时间值复选框选中
				$("input:checkbox[name='date_checkBox302']").on('ifChecked', function(event){
					$('#value_0').iCheck('enable');  
		    	 	$('#value_1').iCheck('enable');  
					var value = document.getElementsByName('value');//静态。动态。
					if(value!=null&&value.length>0){
						if(value[0].checked){  
							$('#input301').attr('readonly',false);
							$('#popupSelectDialog303_button').addClass('notclickn');							
						}else{       //动态选中
							$('#input301').attr('readonly',true);
							$('#popupSelectDialog303_button').removeClass('notclickn');			
						}
					}	
					$('#date_checkBox302').val('1');
					window.focus();
				});
				//设置时间值复选框取消选中
				$("input:checkbox[name='date_checkBox302']").on('ifUnchecked', function(event){
					$('#value_0').iCheck('disable');
					$('#value_1').iCheck('disable');
					$('#input301').attr('readonly',true);
					$('#popupSelectDialog303_button').addClass('notclickn');
					$('#date_checkBox302').val('');
					window.focus();
				});
				
				
				//监听静态动态单选按钮改变事件
				$("input:radio[name='value']").on('ifChecked', function(event){
					  debugger;
				      var value = $(this).val();  //静态。动态。
				      if(value == 1){
						  $('#input301').attr('readonly',false);
						  $('#popupSelectDialog303_button').addClass('notclickn');
					  }else{
						  $('#input301').attr('readonly',true);
						  $('#popupSelectDialog303_button').removeClass('notclickn');
				      }	     
				      window.focus();
				});
			}
			
			//popupSelectDialog302和popupSelectDialog303都选择流程变量
			//打开源自变量的时间点窗口
			function openpopupSelectDialog302(){
				parent.parent.parent.openVariables4(this);     //editFlowProMainPage.jsp弹出
			}
			
			//打开动态变量值窗口
			function openpopupSelectDialog303(){
				parent.parent.parent.openVariables5(this);     //editFlowProMainPage.jsp弹出
			}
			
			//打开业务日历弹出窗口
			function openpopupSelectDialog301(){
				parent.parent.parent.openCalendar(this);       //editFlowProMainPage.jsp弹出
			}
			
		</script>
</head>
<body>

<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; height: 100%;overflow:auto;overflow-x:hidden;" enctype="application/x-www-form-urlencoded"
	<input name="isAssist" id="isAssist" type="hidden" value="${param.isAssist }"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input type="hidden" id="Id" name="Id" value="${param.Id }"/>
	<input type="hidden" id="entityId" name="entityId" value="${param.entityId }"/>
	<input type="hidden" id="editFlag" name="editFlag" />
	<table id="table301" class="tableLayout" style="width:100%;">
		<tr id="tr301">
			<td id="td0301" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label301" name="label301" id="label301" style="margin-left:5px;">
					<font size="2">时间单位</font>
			    </label>
			</td>
		</tr>
		<tr id="tr302">
			<td id="td312" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label302" name="label302" id="label302" style="margin-left:20px;">
						单位：
				</label>
				<div id="comboBox301_div" style="display: inline-table;vertical-align: middle;width:10%;">
					<select id="comboBox301" name="comboBox301" value="${assistEvent.deadLineInfo.unitType.value }" class="form-control" style="height:100%;">  
					   <option></option>              
                       <option value="1" ${assistEvent.deadLineInfo.unitType.value == 1 ? "selected" : ""}>天</option>
                       <option value="2" ${assistEvent.deadLineInfo.unitType.value == 2 ? "selected" : ""}>小时</option>
                       <option value="3" ${assistEvent.deadLineInfo.unitType.value == 3 ? "selected" : ""}>分</option>
                    </select>
				</div>							
			</td>
		</tr>										
		<tr id="tr304">
			<td id="td332" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="radio301_div" style="display: inline-table;margin-left: 20px;" >
					<input type="radio" class="box" name="time" id="time_0" value="1" ${assistEvent.deadLineInfo.deadLineType=='TimePoint'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					时间段
				</label>													
			</td>
		</tr>																						
		<tr id="tr305">
			<td id="td343" class="tdValueCls" style="width:100%;text-align:left;">
				<div style="display: inline-table;margin-left: 40px;" name="checkBox301_div" id="checkBox301_div" >
					<input type="checkbox" class="box" name="date_checkBox301" id="date_checkBox301" value="${assistEvent.deadLineInfo.isSetCalendar=='true'?'1':''}"  ${assistEvent.deadLineInfo.isSetCalendar=='true'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					绑定业务日历
				</label>
			</td>
		</tr>
		<tr id="tr306">
			<td id="td353" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label304" name="label304" id="label304" style="margin-left:60px;float:left;margin-right:5px;line-height: 35px;">
					业务日历
				</label>
				<div id="popupSelectDialog301_div" class="input-group" style="width:25%;">
					 <input type="text" id="popupSelectDialog301" name="popupSelectDialog301" value="${assistEvent.deadLineInfo.calendarId}"  class="form-control" readonly="true">
            		 <span class="input-group-addon addon-udSelect udSelect" id="popupSelectDialog301_button" onclick="openpopupSelectDialog301();"><i class="fa fa-search"></i></span>
				</div>	
			</td>						
		</tr>
		<tr id="tr307">
			<td id="td363" class="tdValueCls" style="width:100%;text-align:left;">
				<div style="display: inline-table;margin-left: 40px;" name="checkBox302_div" id="checkBox302_div" >
					<input type="checkbox" class="box" name="date_checkBox302" id="date_checkBox302" value="${assistEvent.deadLineInfo.isSetDeadLine=='true'?'1':''}" ${assistEvent.deadLineInfo.isSetDeadLine=='true'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					设置时间值
				</label>	
			</td>
		</tr>
		<tr id="tr308">
			<td id="td373" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="radio301_div"  style="display: inline-table;margin-left:60px;" >
					<input type="radio" class="box" name="value" id="value_0" value="1" ${assistEvent.deadLineInfo.valueType=='DYNAMIC'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					静态固定值
				</label>		
				<div id="input301_div" style="display: inline-table;vertical-align: middle;">
					<input id="input301" name="input301" type="text" value="${assistEvent.deadLineInfo.valueType=='STATIC'?assistEvent.deadLineInfo.durationValue:''}" class="form-control" style="height:100%;"/>
				</div>												
			</td>
		</tr>
		<tr id="tr309">
			<td id="td383" class="tdValueCls" style="width:100%;text-align:left;">
				<div style="float:left;margin-left:60px;margin-right: 3px;line-height: 35px;">
					<div id="radio303_div" style="display: inline-table;" >
						<input type="radio" class="box" name="value" id="value_1" value="2" ${assistEvent.deadLineInfo.valueType=='DYNAMIC'?'checked':''}/>
					</div>
					<label name="label0032" id="label0032" class="control-label ">
						动态变量值
					</label>	
				</div>	
				<div id="popupSelectDialog303_div" class="input-group" style="width:25%;">
					 <input type="text" id="popupSelectDialog303" name="popupSelectDialog303" value="${assistEvent.deadLineInfo.valueType=='DYNAMIC'?assistEvent.deadLineInfo.durationValue:''}"  class="form-control" readonly="true">
            		 <span class="input-group-addon addon-udSelect udSelect" id="popupSelectDialog303_button" onclick="openpopupSelectDialog303();"><i class="fa fa-search"></i></span>
				</div>			
			</td>
		</tr>
		<tr id="tr310">
			<td id="td392" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="radio304_div" style="display: inline-table;margin-left: 20px;" >
					<input type="radio" class="box" name="time" id="time_1" value="2" ${assistEvent.deadLineInfo.deadLineType=='TimePoint'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量的时间点
				</label>			
			</td>
		</tr>
		<tr id="tr311">
			<td id="td303" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="popupSelectDialog302_div" style="display: inline-table;margin-left: 40px;width:25%;">
					 <input type="text" id="popupSelectDialog302" name="popupSelectDialog302" value="${assistEvent.deadLineInfo.variableId}"  class="form-control" readonly="true">
            		 <span class="input-group-addon addon-udSelect udSelect" id="popupSelectDialog302_button" onclick="openpopupSelectDialog302();"><i class="fa fa-search"></i></span>
				</div>																
			</td>
		</tr>												
	</table>
 </form>
</div>
</body>
</html>