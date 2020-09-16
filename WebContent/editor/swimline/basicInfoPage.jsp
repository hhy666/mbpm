<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import=" com.matrix.template.object.resource.Swimline" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>流程泳道基本信息</title>
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
	window.onload=function(){
		setTimeout('setFocus()',500);
	}
	function setFocus(){
		var input002 = document.getElementsByName('input002')[0];
		input002.focus();
	}
	function save(flag){
		var swimlineId = Matrix.getFormItemValue('input001');
		var name = Matrix.getFormItemValue('input002');
		parent.window.parent.updateSwimlineName(swimlineId,name);
		
		var type = Matrix.getFormItemValue('type');
		parent.window.parent.initProperties('Container',swimlineId);   //初始右侧泳道属性
		var url = "<%=request.getContextPath()%>/editor/editor_updateSwimLineBasicInfo.action";
		var data = Matrix.formToObject('form0');
		Matrix.sendRequest(url,data,function(data2){
			if(flag){

			}else if(!flag){
				Matrix.say("保存成功！");
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
	<input name="data" id="data" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="swimlineId" id="swimlineId" type="hidden" value="${param.swimlineId}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId}"/>
	<input name="iframewindowid" id="iframewindowid" type="hidden" value="Dialog001"/>
	<%
		Swimline swimLine = (Swimline)request.getAttribute("swimLine");
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
					<input id="input001" name="input001" type="text" value="${swimLine.id}" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
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
					<input id="input002" name="input002" type="text" value="${swimLine.name}" class="form-control" style="height:100%;width:100%;"/>
				</div>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td005" class="tdLabelCls" style="width: 25%;">
				 <label id="label003" name="label003" id="label003">
					描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：
				</label>
			</td>
			<td id="td018" class="tdValueCls" style="width: 75%;">
				<div id="inputTextArea002_div">
					<%
					if(swimLine.getDescription()!=null && swimLine.getDescription().trim().length()>0){
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;"><%=swimLine.getDescription()%></textarea>
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
	</table>
 </form>
</div>
</body>
</html>