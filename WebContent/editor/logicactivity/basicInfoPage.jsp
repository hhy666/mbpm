<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.matrix.template.object.activity.Activity" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>逻辑活动基本信息页面</title>
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
	<script type="text/javascript">
	//页面加载设置初始样式
	window.onload = function(){
		setTimeout('setFocus()',300);
		var type = Matrix.getFormItemValue('type');
		if(type!=null && type!='null' && type.length>0 && type!='undefined'){
		    //StartAct  StopAct  ConditionAct  SplitAct  JoinAct
			if(type=='StopAct') {//完成
				$('#input002').attr('readonly',true);
			}else{
				$('#input002').attr('readonly',false);
			}
			if(type=='ConditionAct'){//条件
				document.getElementById('tr003').style.display="";
				document.getElementById('td010').style.display="none";
				document.getElementById('td011').style.display="none";
				document.getElementById('tr005').style.display="none";
				document.getElementById('td007').style.display="none";
				document.getElementById('tr006').style.display="none";
				document.getElementById('td008').style.display="none";
				document.getElementById('tr007').style.display="none";
				document.getElementById('td009').style.display="none";
			}
			if(type=='SplitAct'){//并发
				document.getElementById('tr003').style.display="";
				document.getElementById('td010').style.display="none";
				document.getElementById('td011').style.display="none";
				document.getElementById('tr005').style.display="none";
				document.getElementById('td007').style.display="none";
				document.getElementById('tr006').style.display="none";
				document.getElementById('td008').style.display="none";
				document.getElementById('tr007').style.display="none";
				document.getElementById('td009').style.display="none";
			}
			if(type=='JoinAct'){//合并
				document.getElementById('tr003').style.display="";
				document.getElementById('tr004').style.display="";
				document.getElementById('td010').style.display="";
				document.getElementById('td011').style.display="";
				document.getElementById('tr005').style.display="";
				document.getElementById('td007').style.display="";
				document.getElementById('tr006').style.display="";
				document.getElementById('td008').style.display="";
				document.getElementById('tr007').style.display="";
				document.getElementById('td009').style.display="";
			}	
		}
		
		//监听多人执行单选按钮组改变事件
		$("input:radio[name='excuteMethod']").on('ifChecked', function(event){
		     setTimeout('setFocus()',500);
		});
	}
	window.onblur = function(){
		var data = Matrix.formToObject("form0");
		var url = "<%=request.getContextPath()%>/editor/editor_updateLogicActivityBasicPro.action";
		Matrix.sendRequest(url,data,function(){});
	}
	function setFocus(){
		var input001 = document.getElementsByName('input002')[0];
		input001.focus();
	}
	</script>
</head>
<body>

<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow-x: hidden;overflow-y: auto;">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_getCurActivityEditProperty.action" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input name="data" id="data" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType }"/>
	<input name="iframewindowid" id="iframewindowid" type="hidden" value="Dialog001"/>
	<%
		Activity activity = (Activity)request.getAttribute("logicActivity");
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
					<input id="input001" name="input001" type="text" value="${logicActivity.id}" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
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
					<input id="input002" name="input002" type="text" value="${logicActivity.name}" class="form-control" style="height:100%;width:100%;"/>
				</div>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td015" class="tdLabelCls" style="width: 25%;">
				 <label id="label015" name="label015" id="label015">
				 	描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：
				 </label>
			</td>
			<td id="td018" class="tdValueCls" style="width: 75%;">
				<div id="inputTextArea002_div">
					<%
					if(activity.getDescription()!=null && activity.getDescription().trim().length()>0){
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;"><%=activity.getDescription()%></textarea>
					<% 
					}else{
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;"></textarea>
					<%
					}
					%>
				</div>
		     </td>
		</tr>		
	 	<tr id="tr004" style="display:none;">
			<td id="td010" class="tdLabelCls" style="display:none;width:20%;">
				<label id="label004" name="label003" id="label003">
					执行方式：
				</label>
			</td>
			<td id="td011" style="width:80%;border-left:0px;display:none;"></td>
		</tr>
		<tr id="tr005" style="display:none;">
			<td id="td007" class="tdValueCls" colspan="2" style="display:none;width:100%;text-align:left;padding-left:15%;border-bottom:0px;">
				<div id="radio301_div" style="display: inline-table;" >
					<input type="radio" class="box" name="excuteMethod" id="excuteMethod_0" value="1" ${logicActivity.transitionRestriction.join.type=='AND'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					完成所有并发分之后合并
				</label>
			</td>
		</tr>
		<tr id="tr006" style="display:none;">
			<td id="td008" class="tdValueCls" colspan="2" style="display:none;width:100%;text-align:left;padding-left:15%;border-top:0px;border-bottom:0px;">
				<div id="radio302_div" style="display: inline-table;" >
					<input type="radio" class="box" name="excuteMethod" id="excuteMethod_1" value="2" ${logicActivity.transitionRestriction.join.type=='XOR'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					完成一条并发分支后即合并，并且终止其他同一并发的分支
				</label>
			</td>
		</tr>
		<tr id="tr007" style="display:none;">
			<td id="td009" class="tdValueCls" colspan="2" style="display:none;width:100%;text-align:left;padding-left:15%;border-top:0px;">
				<div id="radio303_div" style="display: inline-table;" >
					<input type="radio" class="box" name="excuteMethod" id="excuteMethod_2" value="3" ${logicActivity.transitionRestriction.join.type=='OR'?'checked':''}/>
				</div>	
				<label name="label0032" id="label0032" class="control-label ">
					完成一条并发分支后即合并，保留其他同一并发的分支
				</label>
			</td>
		</tr>
	</table>
 </form>
</div>
</body>
</html>