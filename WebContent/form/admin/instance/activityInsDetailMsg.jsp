<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page
	import=" com.matrix.api.instance.activity.ActivityInstance,
		java.text.SimpleDateFormat,
	    com.matrix.api.instance.activity.*,
	    com.matrix.client.TextUtils"%>

<%
	String dialogId = request.getParameter("dialogId");
	ActivityInstance activityIns = (ActivityInstance)request.getAttribute("activityIns");
	SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	String stringType = "String";
	String actInsId = "";
	String actInsName = "";
	String actInsDesc = "";
	String actInsPiid = "";
	String processName = "";
	String actBiid = null;
	String actBlockName = "";
	String actStartMode = "";
	String actFinishMode = "";
	String actStatus = "";
	String errorReason = "";
	String actPriority = "";
	String actStarter = "";
	String actStartedDate = "";
	String actLastModifiedDate = "";
	String actCompletedDate = "";
	String actTypeStr = "";
	if(activityIns!=null){
		actInsId = activityIns.getAiid();
		actInsName = activityIns.getActivityName();
		actInsDesc = activityIns.getDesc();
		actInsPiid = activityIns.getPiid();
		processName = activityIns.getProcessName();
		actBiid = activityIns.getBiid();//活动集编码
		actBlockName = activityIns.getBlockName();//活动集名称
		actStartMode = "Automatic".equals(activityIns.getStartMode().toString())?"自动":"手动";
		actFinishMode = "Automatic".equals(activityIns.getFinishMode().toString())?"自动":"手动";
		actStatus = activityIns.getStatus().toCNStr();
		errorReason = activityIns.getErrorReason();
		int priority = activityIns.getPriority();
		switch(priority){
			case 0: actPriority="普通";break;
			case 1: actPriority="中级";break;
			case 2: actPriority="高级";break;
			case 3: actPriority="特级";break;
		}
		actStarter = activityIns.getStarter()!=null?activityIns.getStarter():"";
		if(activityIns.getStartedDate()!=null){
			actStartedDate = df.format(activityIns.getStartedDate());
		}
		if(activityIns.getLastModifiedDate()!=null){
			actLastModifiedDate = df.format(activityIns.getLastModifiedDate());
		}
		if(activityIns.getCompletedDate()!=null){
			actCompletedDate = df.format(activityIns.getCompletedDate());
		}
		int actType = activityIns.getActivityType().getValue();
		switch(actType){
			case 1: actTypeStr="逻辑活动";break;
			case 2: actTypeStr="活动集";break;
			case 3: actTypeStr="子流程";break;
			case 4: actTypeStr="人工活动";break;
			case 6: actTypeStr="自动活动";break;
		}
	}

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>活动实例信息</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<style type="text/css">
	.insRight{
		margin-left:2px;
	}


</style>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/catalog_updateForm.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="<%=request.getContextPath()%>/catalog_updateForm.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>


<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content" style="height:100%">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 活动实例编码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=actInsId%>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 活动名称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=actInsName%>
		</td>
	</tr>
	
	








	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 描述：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=actInsDesc%>
		</td>
	</tr>
	<tr id="j_id114" jsId="j_id114">
			<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id116" name="j_id116" style="margin-left:10px">流程实例编码：</label>
			</td>
			<td id="j_id117" jsId="j_id117" class="maintain_form_input insRight" colspan="1" rowspan="1">
				
			<%=actInsPiid%>
			  
			  </td>
		</tr>
		
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 流程名称：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input insRight" colspan="1"
			rowspan="1">
		<%=processName%>
		
	</td>
	</tr>
	
	<%
		if(actBiid!=null && actBiid.trim().length()>0){
	%>
	
		<tr id="j_id4" jsId="j_id4">
			<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
				rowspan="1" style="width: '20%'"><label
				id="j_id6" name="j_id6" style="margin-left: 10px"> 活动集编码：</label>
			</td>
			<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=actBiid%>
			</td>
		</tr>
		
		
		<tr id="j_id9" jsId="j_id9">
			<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
				rowspan="1" style="width: '20%'">
				<label id="j_id11" name="j_id11" style="margin-left: 10px"> 活动集名称：</label></td>
			<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" colspan="1" rowspan="1">
				<%=actBlockName %>
			</td>
		</tr>
	
	<%} %>
	
	
	
	
	
	
	
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 启动方式：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" colspan="1" rowspan="1">
		<%=actStartMode%>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 完成方式：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=actFinishMode %>
		</td>
	</tr>
	

	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 活动类型：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input insRight" colspan="1" rowspan="1">
		<%=actTypeStr%>
		</td>
	</tr>
	<tr id="j_id114" jsId="j_id114">
			<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id116" name="j_id116" style="margin-left:10px">状态：</label>
			</td>
			<td id="j_id117" jsId="j_id117" class="maintain_form_input insRight" colspan="1" rowspan="1">
				
			<%=actStatus%>
			  
			  </td>
		</tr>
		
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 优先级：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input insRight" colspan="1"
			rowspan="1">
		<%=actPriority %>
		
	</td>
	</tr>
	
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 启动人：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" colspan="1" rowspan="1">
		<%=actStarter %>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 启动时间：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=actStartedDate %>
		</td>
	</tr>
	
	<tr id="j_id43" jsId="j_id43">
		<td id="j_id53" jsId="j_id53" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id63" name="j_id63" style="margin-left: 10px"> 最后修改时间：</label>
		</td>
		<td id="j_id73" jsId="j_id73" class="maintain_form_input insRight" colspan="1" rowspan="1">
		<%=actLastModifiedDate %>
		</td>
	</tr>
	<tr id="j_id93" jsId="j_id93">
		<td id="j_id103" jsId="j_id103" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 完成时间：</label></td>
		<td id="j_id1233" jsId="j_id1233" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=actCompletedDate %>
		</td>
	</tr>
	
	
</table>

<script>

	MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>