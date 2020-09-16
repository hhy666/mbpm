<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.api.instance.process.ProcessInstance,
				java.text.SimpleDateFormat,java.util.*" %>

<%
	ProcessInstance processIns = (ProcessInstance)request.getAttribute("processIns");
	SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String processInsId = "";
		String processInsName = "";
		String processInsDesc = "";
		String processInsStatus = "";
		String processInsCreatedDate = "";
		String processInsCreator = "";
		String processInsStartedDate = "";
		String processInsExpiredDate = "";
		String processInsStarter = "";
		String processInsPriority = "";
		String processInsLastModifiedDate = "";
		String processInsCompletedDate = "";
		String parentProcessName ="";
		if(processIns!=null){
			processInsId = processIns.getPiid();
			processInsName = processIns.getProcessName();
			processInsDesc = processIns.getDesc();
			processInsStatus = processIns.getStatus().toCNStr();
			if(processIns.getCreatedDate()!=null){
				processInsCreatedDate = df.format(processIns.getCreatedDate());
			}
			processInsCreator = processIns.getCreator();
			if(processIns.getStartedDate()!=null){
				processInsStartedDate = df.format(processIns.getStartedDate());
			}
			if(processIns.getExpiredDate()!=null){
				processInsExpiredDate = df.format(processIns.getExpiredDate());
			}
			processInsStarter = processIns.getStarter();
			if(processIns.getLastModifiedDate()!=null){
				processInsLastModifiedDate = df.format(processIns.getLastModifiedDate());
			}
			if(processIns.getCompletedDate()!=null){
				processInsCompletedDate = df.format(processIns.getCompletedDate());
			}
			int priority = processIns.getPriority();
			switch(priority){
				case 0: processInsPriority="普通";break;
				case 1: processInsPriority="中级";break;
				case 2: processInsPriority="高级";break;
				case 3: processInsPriority="特级";break;
			}
			
			if(processIns.getParentPName()!=null){
				parentProcessName = processIns.getParentPName();
			}
		}
		
		
		
    

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程实例信息</title>
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
		canSelectText: true,
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
			id="j_id6" name="j_id6" style="margin-left: 10px"> 流程实例编码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=processInsId%>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 流程实例名称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=processInsName%>
		</td>
	</tr>
	

	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 描述：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=processInsDesc%>
		</td>
	</tr>
	<tr id="j_id114" jsId="j_id114">
			<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id116" name="j_id116" style="margin-left:10px">状态：</label>
			</td>
			<td id="j_id117" jsId="j_id117" class="maintain_form_input insRight" colspan="1" rowspan="1">
				
			<%=processInsStatus%>
			  
			  </td>
		</tr>
		
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 创建时间：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input insRight" colspan="1"
			rowspan="1">
		<%=processInsCreatedDate%>
		
	</td>
	</tr>
	
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 创建人：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" colspan="1" rowspan="1">
		<%=processInsCreator%>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 启动时间：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=processInsStartedDate %>
		</td>
	</tr>
	

	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 完成期限：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input insRight" colspan="1" rowspan="1">
		<%=processInsExpiredDate%>
		</td>
	</tr>
	<tr id="j_id114" jsId="j_id114">
			<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id116" name="j_id116" style="margin-left:10px">启动人员：</label>
			</td>
			<td id="j_id117" jsId="j_id117" class="maintain_form_input insRight" colspan="1" rowspan="1">
				
			<%=processInsStarter%>
			  
			  </td>
		</tr>
		
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 优先级：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input insRight" colspan="1"
			rowspan="1">
		<%=processInsPriority %>
		
	</td>
	</tr>
	
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 最后修改时间：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input insRight" colspan="1" rowspan="1">
		<%=processInsLastModifiedDate %>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 完成时间：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input insRight" colspan="1" rowspan="1">
			<%=processInsCompletedDate %>
		</td>
	</tr>
	
	
</table>

<script>

	MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>