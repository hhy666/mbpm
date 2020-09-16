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
	<title>任务分派</title>
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
		//页面失去去焦点时保存数据
		window.onblur = function(){
			var data = Matrix.formToObject('form0');
			var editFlag = Matrix.getFormItemValue('editFlag');
			if(editFlag!='edit'){
				if(data!=null){
					var url = "<%=request.getContextPath()%>/editor/editor_updateTaskAssignInfo.action";
					Matrix.sendRequest(url,data,function(){});
				}
			
			}
		}
		//页面初始事件
		window.onload=function(){
			debugger;
			setTimeout('setFocus()',500);//初始加载设置焦点
			var excuteWay = '${activity.taskCreationType}';//执行方式
			if(excuteWay!=null && excuteWay!='' && excuteWay!='undefined' && excuteWay!='null'){
				//确保执行方式存在
				if(excuteWay=='Pull'){//竟取方式
					$('#radioGroup001_0').iCheck('enable');   //指定到人
					$('#radioGroup001_1').iCheck('enable');  //指定到范围
				}else if(excuteWay=='Push'){//推送方式
					$('#radioGroup002_0').iCheck('enable');  //轮转 
					$('#radioGroup002_1').iCheck('enable');  //负载均衡
				}else if(excuteWay=='PushAllSequence' || excuteWay=='PushAllParallel'){
					$('#executeWay').val(3);
					$('#radioGroup003_0').iCheck('enable');   //多人串行
					$('#radioGroup003_1').iCheck('enable');  //多人并行
					if(excuteWay=='PushAllParallel'){
						$('#popupSelectDialog1_button').removeClass('notclickn');  //终止条件	
					}		
				}
			}
			
			//监听分派方式单选按钮组改变事件
			$("input:radio[name='executeWay']").on('ifChecked', function(event){
				 debugger;
			     var executeWay = $(this).val();  //1.单人执行（竞取方式）  2. 单人执行（推送方式）  3. 多人执行
			     if(executeWay == 1){
			    	$('#radioGroup001_0').iCheck('enable');    //指定到人
			    	$('#radioGroup001_1').iCheck('enable');  //指定到范围
			    	
			    	$('#radioGroup002_0').iCheck('disable');  //轮转 
					$('#radioGroup002_1').iCheck('disable');  //负载均衡
					
					$('#radioGroup003_0').iCheck('disable');   //多人串行
					$('#radioGroup003_1').iCheck('disable');  //多人并行
					$('#input0').val();
					$('#popupSelectDialog1_button').addClass('notclickn');  //终止条件	
					
			     }else if(executeWay == 2){
			    	$('#radioGroup001_0').iCheck('disable');    //指定到人
				    $('#radioGroup001_1').iCheck('disable');  //指定到范围
					
				    $('#radioGroup002_0').iCheck('enable');  //轮转 
					$('#radioGroup002_1').iCheck('enable');  //负载均衡
					
					$('#radioGroup003_0').iCheck('disable');   //多人串行
					$('#radioGroup003_1').iCheck('disable');  //多人并行
					$('#input0').val();
					$('#popupSelectDialog1_button').addClass('notclickn');  //终止条件	
					
			     }else if(executeWay == 3){
			    	//0和1的子项都禁用
					$('#radioGroup001_0').iCheck('disable');    //指定到人
				    $('#radioGroup001_1').iCheck('disable');  //指定到范围
					
				    $('#radioGroup002_0').iCheck('disable');  //轮转 
					$('#radioGroup002_1').iCheck('disable');  //负载均衡
					
					$('#radioGroup003_0').iCheck('enable');   //多人串行
					$('#radioGroup003_1').iCheck('enable');  //多人并行
					var mpe = document.getElementsByName("radioGroup003");
					if(mpe[0].checked){
						$('#popupSelectDialog1_button').addClass('notclickn');  //终止条件	
						$('#input0').val();
					}else{
						$('#popupSelectDialog1_button').removeClass('notclickn');  //终止条件	
					}
			     }
			    
			});
			
			//监听多人执行单选按钮组改变事件
			$("input:radio[name='radioGroup003']").on('ifChecked', function(event){
				 debugger;
			     var mpe = $(this).val();  //3.多人执行(串行)  4.多人执行(并行)
			     if(mpe == 3){
			    	 $('#popupSelectDialog1_button').addClass('notclickn');  //终止条件	
			     }else if(mpe == 4){
			    	 $('#popupSelectDialog1_button').removeClass('notclickn');  //终止条件	
			     }
			     setTimeout('setFocus()',500);
			});
			
			//由上一活动指定执行人员复选框选中
			$("input:checkbox[name='checkBox001']").on('ifChecked', function(event){		
				$('#checkBox001').val(1);
				window.focus();
			});
			
			//由上一活动指定执行人员取消选中
			$("input:checkbox[name='checkBox001']").on('ifUnchecked', function(event){
				$('#checkBox001').val('');
				window.focus();
			});
		}
		
		
		
		//终止条件弹出条件编辑窗口
		function openpopupSelectDialog1(){
			parent.openEndCondition(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//设置焦点
		function setFocus(){
			var input0 = document.getElementsByName('input0')[0];
			input0.focus();
		}
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/mobile/flowEdit_dealHumanActivity.action"
	style="margin: 0px; height: 100%;overflow:auto;overflow-x: hidden;" enctype="application/x-www-form-urlencoded">
	<input name="authId" id="authId" type="hidden" value="${activity.authItemId }"/>
	<input name="data" id="data" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="editFlag" id="editFlag" type="hidden"/>
	
	<table id="table201" class="tableLayout" style="width:100%;">
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107"  style="width:100%;text-align:left;">
				<font id="font2">任务分派通用属性</font>
			</td>
		</tr>
		<tr id="tr201">
			<td id="td201" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label201" name="label201" id="label001" style="margin-left:10px">
					分派方式
				</label>
			</td>
		</tr>
		<tr id="tr202">
			<td id="td202" class="tdValueCls" style="width:100%;text-align:left;line-height: 35px;">
				<div id="radio001_div" style="display: inline-table;margin-left: 20px;" >
					<input type="radio" class="box" name="executeWay" id="executeWay_0" value="1" ${activity.taskCreationType=='Pull'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					单人执行（竞取方式）
				</label>	
			</td>
		</tr>
		<tr id="tr203">
			<td id="td203" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label202" name="label202" style="margin-left:40px;line-height: 35px;">
					指定方式：
				</label>
				<span id="radioGroup001_div" style="width:100%;">
					<input type="radio" class="box" name="radioGroup001" id="radioGroup001_0" value="1" ${activity.pullTaskType=='DYNAMIC'?'':'checked'} disabled="disabled"/>
					<label name="label0032" id="label0032" class="control-label " style="margin-right: 20px;">
						指定到人
					</label>						
				
					<input type="radio" class="box" name="radioGroup001" id="radioGroup001_1" value="2" ${activity.pullTaskType=='DYNAMIC'?'checked':''} disabled="disabled"/>
					<label name="label0032" id="label0032" class="control-label ">
						指定到范围
					</label>													
				</span>
			</td>
		</tr>
		<tr id="tr204">
			<td id="td204" class="tdValueCls" style="width:100%;text-align:left;line-height: 35px;">
				<div id="radio002_div" style="display: inline-table;margin-left: 20px;" >
					<input type="radio" class="box" name="executeWay" id="executeWay_1" value="2" ${activity.taskCreationType=='Push'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					单人执行（推送方式）
				</label>
			</td>
		</tr>
		<tr id="tr205">
			<td id="td205" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label003" name="label003" id="label003" style="margin-left:40px;line-height: 35px;">
					推送方式：
				</label>
				<span id="radioGroup002_div" style="width:100%;">	
					<input type="radio" class="box" name="radioGroup002" id="radioGroup002_0" value="1" ${activity.pushTaskType=='Cycle'?'checked':''} disabled="disabled"/>
					<label name="label0032" id="label0032" class="control-label " style="margin-right: 20px;">
						轮转法
					</label>	
				
					<input type="radio" class="box" name="radioGroup002" id="radioGroup002_1" value="2" ${activity.pushTaskType=='Cycle'?'':'checked'} disabled="disabled"/>
					<label name="label0032" id="label0032" class="control-label ">
						负载均衡法
					</label>				
				</span>
			</td>
		</tr>
		<tr id="tr206">
			<td id="td206" class="tdValueCls" style="width:100%;text-align:left;line-height: 35px;">
				<div id="radio003_div" style="display: inline-table;margin-left: 20px;" >
					<input type="radio" class="box" name="executeWay" id="executeWay_2" value="3" ${activity.taskCreationType!='Pull' and activity.taskCreationType!='Push' ? 'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					多人执行
				</label>
			</td>
		</tr>
		<tr id="tr207">
			<td id="td207" class="tdValueCls"  style="width:100%;text-align:left;line-height: 35px;">
				<span id="radioGroup003_div" style="width:100%;margin-left:30px;">
					<input type="radio" class="box" name="radioGroup003" id="radioGroup003_0" value="3" ${activity.taskCreationType=='PushAllSequence'?'checked':''} disabled="disabled"/>
					<label name="label0032" id="label0032" class="control-label " style="margin-right: 20px;">
						多人执行(串行)
					</label>	
				
					<input type="radio" class="box" name="radioGroup003" id="radioGroup003_1" value="4" ${activity.taskCreationType!='PushAllSequence'?'checked':''} disabled="disabled"/>
					<label name="label0032" id="label0032" class="control-label ">
						多人执行(并行)
					</label>			
				</span>
			</td>
		</tr>
		<tr id="tr208">
			<td id="td208" class="tdValueCls" style="width:100%;text-align:left;">
				<label id="label204" name="label0204" id="label204" style="margin-left:40px;float:left;margin-right:5px;line-height: 35px;">
					终止条件：
				</label>
				<div id="input0_div" class="input-group" style="width:40%;margin-left:10px;height: 100%;">
					 <input type="text" id="input0" name="input0" style="height: 100%;" value="${activity.terminateMultiCondition.value==null?'':activity.terminateMultiCondition.value}"  class="form-control" readonly="true">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog1();" id="popupSelectDialog1_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr209">
			<td id="td209" class="tdValueCls" style="width:100%;text-align:left;line-height: 35px;">
				<div style="display: inline-table;margin-left: 10px;" name="checkBox001_div" id="checkBox001_div" >
					<input type="checkbox" class="box" name="checkBox001" id="checkBox001" value="${activity.userDefinedFlag=='true'?'1':''}" ${activity.userDefinedFlag=='true'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					由上一活动指定执行人员
				</label>
			</td>
		</tr>
		
	</table>
 </form>
</div>
</body>
</html>