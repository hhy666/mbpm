<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.matrix.template.object.activity.Activity" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>逻辑活动高级属性页面</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="text/css">
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
		function setFocus(){
			var inputTextArea001 = document.getElementsByName('inputTextArea001')[0];
			inputTextArea001.focus();
		}
		window.onblur = function(){
			var data = Matrix.formToObject("form0");
			//双引号处理----asd
				if(data.inputTextArea001.indexOf("\"") >= 0 || data.inputTextArea001.indexOf("“") >= 0 || data.inputTextArea001.indexOf("”") >= 0 ){
					data.inputTextArea001 = data.inputTextArea001.replaceAll("\"","----#&#----");
				}
				if(data.inputTextArea002.indexOf("\"") >= 0 || data.inputTextArea002.indexOf("“") >= 0 || data.inputTextArea002.indexOf("”") >= 0 ){
					data.inputTextArea002 = data.inputTextArea002.replaceAll("\"","----#&#----");
				}
			var url = "<%=request.getContextPath()%>/editor/editor_updateLogicActivityAdvancePro.action";
			Matrix.sendRequest(url,data,function(){});
		}
		
		//开始条件弹出条件编辑窗口
		function openpopupSelectDialog001(){
			var conditionValue = Matrix.getFormItemValue('inputTextArea001');
			parent.Matrix.setFormItemValue('conditionValue',conditionValue);
			parent.openSatrtCondition(this);     //loadLogicActivityTreeNodePage.jsp弹出
		}
		
		//完成条件弹出条件编辑窗口
		function openpopupSelectDialog002(){
			var conditionValue = Matrix.getFormItemValue('inputTextArea002');
			parent.Matrix.setFormItemValue('conditionValue',conditionValue);
			Matrix.setFormItemValue('editFlag','edit');
			parent.openFinishCondition(this);     //loadLogicActivityTreeNodePage.jsp弹出
		}
	
		window.onload=function(){
			var type = Matrix.getFormItemValue("type");
			if(type!=null && type.length>0 && type!='undefined'){
				if(type=='StopAct'){
					//完成
					document.getElementById("tr002").style.display='none';
					document.getElementById("td003").style.display='none';
					document.getElementById("td004").style.display='none';
					
					document.getElementById("tr013").style.display='none';
					document.getElementById("td017").style.display='none';
					
				}else if(type=='ConditionAct'){//条件
					document.getElementById("tr002").style.display='none';
					document.getElementById("td003").style.display='none';
					document.getElementById("td004").style.display='none';
					document.getElementById("tr003").style.display='none';
					document.getElementById("td010").style.display='none';
					document.getElementById("td015").style.display='none';
					document.getElementById("tr005").style.display='none';
					document.getElementById("td007").style.display='none';
					document.getElementById("tr009").style.display='none';
					document.getElementById("td008").style.display='none';
					document.getElementById("tr010").style.display='none';
					document.getElementById("td009").style.display='none';
					
					document.getElementById("tr011").style.display='none';
					document.getElementById("td016").style.display='none';
					document.getElementById("tr013").style.display='none';
					document.getElementById("td017").style.display='none';
				
				}else if(type=='SplitAct'){//并发
					document.getElementById("tr002").style.display='none';
					document.getElementById("td003").style.display='none';
					document.getElementById("td004").style.display='none';
					document.getElementById("tr003").style.display='none';
					document.getElementById("td010").style.display='none';
					document.getElementById("td015").style.display='none';
					document.getElementById("tr005").style.display='none';
					document.getElementById("td007").style.display='none';
					document.getElementById("tr009").style.display='none';
					document.getElementById("td008").style.display='none';
					document.getElementById("tr010").style.display='none';
					document.getElementById("td009").style.display='none';
					
					document.getElementById("tr011").style.display='none';
					document.getElementById("td016").style.display='none';
					document.getElementById("tr013").style.display='';
					document.getElementById("td017").style.display='';
				}else if(type=='JoinAct'){//合并
					document.getElementById("tr002").style.display='';
					document.getElementById("td003").style.display='';
					document.getElementById("td004").style.display='';
					document.getElementById("tr003").style.display='none';
					document.getElementById("td010").style.display='none';
					document.getElementById("td015").style.display='none';
					document.getElementById("tr005").style.display='none';
					document.getElementById("td007").style.display='none';
					document.getElementById("tr009").style.display='none';
					document.getElementById("td008").style.display='none';
					document.getElementById("tr010").style.display='none';
					document.getElementById("td009").style.display='none';
					
					document.getElementById("tr011").style.display='none';
					document.getElementById("td016").style.display='none';
					document.getElementById("tr013").style.display='none';
					document.getElementById("td017").style.display='none';
				}
			}
			
			$("input:radio[name='takeMethod']").on('ifChecked', function(event){		
				window.focus();
			});
			
			//复选框选中
			$("input:checkbox[name='checkBoxGroup001_0']").on('ifChecked', function(event){
				$(this).val(1);
			    window.focus();
			});
			//复选框取消选中
			$("input:checkbox[name='checkBoxGroup001_0']").on('ifUnchecked', function(event){
				$(this).val('');
			    window.focus();
			});
		}
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow:auto;">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0"/>
	<input name="version" id="version" type="hidden">
	<input name="editFlag" id="editFlag" type="hidden"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId }"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType }"/>
	<%
		Activity logicActivity = (Activity)request.getAttribute("logicActivity");
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
					<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;" readonly="readonly">${logicActivity.preCondition.value }</textarea>
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
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;" readonly="readonly">${logicActivity.postCondition.value }</textarea>
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog002();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
	 	<tr id="tr003" style="">
			<td id="td010" class="tdValueCls" style="width:20%;border-bottom:0px;">
				<label id="label004" name="label003" id="label003">
					完成方式：
				</label>
			</td>
			<td id="td015" style="width:80%;border-left:0px;display:none;"></td>
		</tr>
		<tr id="tr005" style="">
			<td id="td007" class="tdValueCls" colspan="2" style="width:100%;text-align:left;padding-left:10%;border-bottom:0px;">
				<div id="radio301_div" style="display: inline-table;" >
					<input type="radio" class="box" name="takeMethod" id="takeMethod_0" value="1" ${takeMethod=='completeAND'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					完成流程分支，无其它运行中流程分支时结束流程
				</label>
			</td>
		</tr>
		<tr id="tr009" style="">
			<td id="td008" class="tdValueCls" colspan="2" style="width:100%;text-align:left;padding-left:10%;border-top:0px;border-bottom:0px;">
				<div id="radio302_div" style="display: inline-table;" >
					<input type="radio" class="box" name="takeMethod" id="takeMethod_1" value="2" ${takeMethod=='terminate'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					完成流程分支，结束流程并终止其它运行中流程分支
				</label>
			</td>
		</tr>
		<tr id="tr010" style="">
			<td id="td009" class="tdValueCls" colspan="2" style="width:100%;text-align:left;padding-left:10%;border-top:0px;border-bottom:0px;">
				<div id="radio303_div" style="display: inline-table;" >
					<input type="radio" class="box" name="takeMethod" id="takeMethod_2" value="3" ${takeMethod=='completeOR'?'checked':''}/>
				</div>	
				<label name="label0032" id="label0032" class="control-label ">
					完成流程分支，结束流程并保留其它运行中流程分支
				</label>
			</td>
		</tr>
		<tr id="tr011" style="">
			<td id="td016" class="tdLayout" colspan="2" style="width:100%;text-align:left;padding-left:10%;border-top:0px;">
				<div id="radio304_div" style="display: inline-table;" >
					<input type="radio" class="box" name="takeMethod" id="takeMethod_3" value="4" ${takeMethod=='completeBranch'?'checked':''}/>
				</div>	
				<label name="label0032" id="label0032" class="control-label ">
					完成流程分支，不影响流程
				</label>
			</td>
		</tr>
		<tr id="tr013" style="">
			<td id="td017" colspan="2" style="padding-left: 2px;padding-top: 2px;border-style:none;height:27px;">
				<div name="checkBoxGroup001_0_div" id="checkBoxGroup001_0_div" style="display: inline-table;margin-left: 10px;" >
					<input type="checkbox" class="box" name="checkBoxGroup001_0" id="checkBoxGroup001_0" value="${logicActivity.singleAvailableActInsFlag=='false'?'':'1'}"  ${logicActivity.singleAvailableActInsFlag=='false'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					限制唯一有效活动实例
				</label>
			</td>
		</tr>
	</table>
 </form>
</div>
</body>
</html>