<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>活动时限</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
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
		//页面失去焦点事件
		window.onblur = function(){
			//onblur时判断是否处于编辑状态，处于编辑状态 就保存，没有处于编辑状态就不保存
			var editFlag = Matrix.getFormItemValue('editFlag');
			if(editFlag==null || editFlag!='edit'){
				return false;
			}
			var synJson = Matrix.formToObject('form0');
			if(synJson!=null){
				var url = "<%=request.getContextPath()%>"+"/editor/editor_saveActivityDuration.action";
				Matrix.sendRequest(url,synJson,function(){
					return true;
				});
			}
		}
		
		//页面得到焦点事件
		window.onfocus=function(){
			Matrix.setFormItemValue('editFlag','edit');
		}
		
		//页面初始事件
		window.onload=function(){
			var phase = '<%=com.matrix.form.admin.common.utils.CommonUtil.getCurPhase()%>';
			if(phase=='4'){
				document.getElementById('tr305').style.display='none';
				$('#date_checkBox301').val('1');
				$('#popupSelectDialog301').val('calendar');
				document.getElementById('tr306').style.display='none';
				//document.getElementById('tr304').style.display='none';  //隐藏掉时间断
				document.getElementById('td320').style.display='none';  //隐藏掉关联容器活动集时限
			}else{
				document.getElementById('tr305').style.display='';
				
				$('#date_checkBox301').val("${activity.deadLineInfo.isSetCalendar=='true'?'1':''}");
				$('#popupSelectDialog301').val('${activity.deadLineInfo.calendarId}');
				document.getElementById('tr306').style.display='';
				document.getElementById('tr309').style.display='';
				document.getElementById('tr310').style.display='';
				document.getElementById('tr311').style.display='';
			}
			setTimeout('setFocus()',500);
			
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
					
				}else{      //时间点选中
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
		
		function setFocus(){
			var popupSelectDialog301 = document.getElementsByName('popupSelectDialog301')[0];
			popupSelectDialog301.focus();
		}
		
		//popupSelectDialog302和popupSelectDialog303都选择流程变量
		//打开源自变量的时间点窗口
		function openpopupSelectDialog302(){
			parent.openVariables1(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//打开动态变量值窗口
		function openpopupSelectDialog303(){
			parent.openVariables2(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//打开业务日历弹出窗口
		function openpopupSelectDialog301(){
			parent.openCalendar(this);       //loadBasicActivityTreeNodePage.jsp弹出
		}
			
		</script>	
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action=""style="margin: 0px; height: 100%;overflow:auto;overflow-x:hidden;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="editFlag" id="editFlag" />
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<table id="table301" class="tableLayout" style="width:100%;">
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107"  style="width:100%;"><font id="font2">活动时限</font></td>
		</tr>
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
					<select id="comboBox301" name="comboBox301" value="${activity.deadLineInfo.unitType=='HOUR'?'2':activity.deadLineInfo.unitType=='MINUTE'?'3':'1'}" class="form-control" style="height:100%;">            
                       <option value="1" ${activity.deadLineInfo.unitType == 'DAY' ? "selected" : ""}>天</option>
                       <option value="2" ${activity.deadLineInfo.unitType == 'HOUR' ? "selected" : ""}>小时</option>
                       <option value="3" ${activity.deadLineInfo.unitType == 'MINUTE' ? "selected" : ""}>分</option>
                    </select>
				</div>		
			</td>
		</tr>
		<tr id="tr303">
			<td id="td321" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label303" name="label303" id="label303" style="margin-left:5px;">
					<font size="2">完成时限</font>
				</label>
			</td>
		</tr>
		<tr id="tr304">
			<td id="td332" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="radio301_div" style="display: inline-table;margin-left: 20px;" >
					<input type="radio" class="box" name="time" id="time_0" value="1" ${activity.deadLineInfo.deadLineType=='TimePoint'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					时间段
				</label>													
			</td>
		</tr>
		<tr id="tr305">
			<td id="td343" class="tdValueCls" style="width:100%;text-align:left;">
				<div style="display: inline-table;margin-left: 40px;" name="checkBox301_div" id="checkBox301_div" >
					<input type="checkbox" class="box" name="date_checkBox301" id="date_checkBox301" value="${activity.deadLineInfo.isSetCalendar=='true'?'1':''}"  ${activity.deadLineInfo.isSetCalendar=='true'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					绑定业务日历
				</label>
			</td>
			
		</tr>							
		<tr id="tr306" >
			<td id="td353" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label304" name="label304" id="label304" style="margin-left:60px;float:left;margin-right:5px;line-height: 35px;">
					业务日历
				</label>
				<div id="popupSelectDialog301_div" class="input-group" style="width:25%;">
					 <input type="text" id="popupSelectDialog301" name="popupSelectDialog301" value="${activity.deadLineInfo.calendarId}"  class="form-control" readonly="true">
            		 <span class="input-group-addon addon-udSelect udSelect" id="popupSelectDialog301_button" onclick="openpopupSelectDialog301();"><i class="fa fa-search"></i></span>
				</div>	
			</td>		
		</tr>
		<tr id="tr307">
			<td id="td363" class="tdValueCls" style="width:100%;text-align:left;">
				<div style="display: inline-table;margin-left: 40px;" name="checkBox302_div" id="checkBox302_div" >
					<input type="checkbox" class="box" name="date_checkBox302" id="date_checkBox302" value="${activity.deadLineInfo.isSetDeadLine=='true'?'1':''}" ${activity.deadLineInfo.isSetDeadLine=='true'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					设置时间值
				</label>	
			</td>
		</tr>
		<tr id="tr308">
			<td id="td373" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="radio301_div"  style="display: inline-table;margin-left:60px;" >
					<input type="radio" class="box" name="value" id="value_0" value="1" ${activity.deadLineInfo.valueType=='DYNAMIC'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					静态固定值
				</label>		
				<div id="input301_div" style="display: inline-table;vertical-align: middle;">
					<input id="input301" name="input301" type="text" value="${activity.deadLineInfo.valueType=='DYNAMIC'?'':activity.deadLineInfo.durationValue=='null'?'':activity.deadLineInfo.durationValue}" class="form-control" style="height:100%;"/>
				</div>												
			</td>
		</tr>								
		<tr id="tr309" style="display:none;">
			<td id="td383" class="tdValueCls" style="width:100%;text-align:left;">
				<div style="float:left;margin-left:60px;margin-right: 3px;line-height: 35px;">
					<div id="radio303_div" style="display: inline-table;" >
						<input type="radio" class="box" name="value" id="value_1" value="2" ${activity.deadLineInfo.valueType=='DYNAMIC'?'checked':''}/>
					</div>
					<label name="label0032" id="label0032" class="control-label ">
						动态变量值
					</label>	
				</div>	
				<div id="popupSelectDialog303_div" class="input-group" style="width:25%;">
					 <input type="text" id="popupSelectDialog303" name="popupSelectDialog303" value="${activity.deadLineInfo.valueType=='STATIC'?'':activity.deadLineInfo.durationValue=='null'?'':activity.deadLineInfo.durationValue}"  class="form-control" readonly="true">
            		 <span class="input-group-addon addon-udSelect udSelect" id="popupSelectDialog303_button" onclick="openpopupSelectDialog303();"><i class="fa fa-search"></i></span>
				</div>			
			</td>
		</tr>	
		<tr id="tr310" style="display:none;">
			<td id="td392" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="radio304_div" style="display: inline-table;margin-left: 20px;" >
					<input type="radio" class="box" name="time" id="time_1" value="2" ${activity.deadLineInfo.deadLineType=='TimePoint'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量的时间点
				</label>			
			</td>
		</tr>									
		<tr id="tr311" style="display:none;">
			<td id="td303" class="tdValueCls" style="width:100%;text-align:left;">
				<div id="popupSelectDialog302_div" style="display: inline-table;margin-left: 40px;width:25%;">
					 <input type="text" id="popupSelectDialog302" name="popupSelectDialog302" value="${activity.deadLineInfo.variableId}"  class="form-control" readonly="true">
            		 <span class="input-group-addon addon-udSelect udSelect" id="popupSelectDialog302_button" onclick="openpopupSelectDialog302();"><i class="fa fa-search"></i></span>
				</div>																
			</td>
		</tr>																			
		<tr id="tr312">
			<td id="td320" class="tdValueCls" style="width:100%;text-align:left;">
				<div style="display: inline-table;margin-left: 40px;" name="checkBox303_div" id="checkBox303_div" >
					<input type="checkbox" class="box" name="checkBox303" id="checkBox303" value="" disabled="true"/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					关联容器活动集时限
				</label>
			</td>
		</tr>
		<tr id="tr313">
			<td id="td321" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label305" name="label305" id="label305" style="margin-left:5px;">
					<font size="2">超时策略</font>
				</label>
			</td>
		</tr>
		<tr id="tr314">
			<td id="td332" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label306" name="label306" id="label306" style="margin-left:20px">
					策略：
				</label>
				<div id="comboBox302_div" style="display: inline-table;vertical-align: middle;width:15%;">
					<select id="comboBox302" name="comboBox302" value="${activity.deadLineInfo.timeoutPolicy=='UPGRADEPRIORITY'?'1':activity.deadLineInfo.timeoutPolicy=='SUBSTITUTE'?'2':activity.deadLineInfo.timeoutPolicy=='COMPLETE'?'3':activity.deadLineInfo.timeoutPolicy=='TERMINATE'?'4':'5'}" class="form-control" style="height:100%;">   			      
                       <option value="1" ${activity.deadLineInfo.timeoutPolicy == 'UPGRADEPRIORITY' ? "selected" : ""}>提高优先级</option>
                       <option value="2" ${activity.deadLineInfo.timeoutPolicy == 'SUBSTITUTE' ? "selected" : ""}>自动委托</option>
                       <option value="3" ${activity.deadLineInfo.timeoutPolicy == 'COMPLETE' ? "selected" : ""}>自动完成</option>
                       <option value="4" ${activity.deadLineInfo.timeoutPolicy == 'TERMINATE' ? "selected" : ""}>自动终止</option>
                       <option value="5" ${activity.deadLineInfo.timeoutPolicy != 'UPGRADEPRIORITY' and activity.deadLineInfo.timeoutPolicy != 'SUBSTITUTE' and activity.deadLineInfo.timeoutPolicy != 'COMPLETE' and activity.deadLineInfo.timeoutPolicy != 'TERMINATE' ? "selected" : ""}>无</option>
                    </select>
				</div>		
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>