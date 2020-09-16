<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.flow.action.ProcessValidationHelper"%>
<%@page import="com.matrix.template.object.WorkflowPackage"%>
<%@page import="com.matrix.flow.action.ActionConstants"%>
<%@page import="com.matrix.api.MFExecutionService"%>
<%@page import="java.util.*"%>
<%@page import="com.matrix.template.object.process.WorkflowProcess"%>
<%@page import="com.matrix.flow.action.ValidationInfo"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>流程校验信息</title>
		
		<script type="text/javascript">
		
		</script>
		
		<style type="text/css">
		table {
  display: table;
  border-collapse: separate;
  border-spacing: 2px;
  border-color: grey;
}
		.recordHeader {
  -moz-background-clip: border;
  -moz-background-inline-policy: continuous;
  -moz-background-origin: padding;
  background: #E5EDF4;
  border: 1px solid #E0EEFB;
  overflow: hidden;
  padding: 0;
  text-decoration: none;
  height: 27px;
  text-align: center;
}

.recordCell {
  border-color: #EBEADB #D5CDB5 #EBEADB #EBEADB;
  border-style: solid;
  border-width: 1px;
  border-left: 0px;
  overflow: hidden;
  padding: 0px;
  text-align: left;
  height: 27px;
}
		</style>
</head>
<body>

<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">

<% 
//获取校验结果
   ProcessValidationHelper helper = new ProcessValidationHelper();

    WorkflowPackage model = (WorkflowPackage)session.getAttribute(ActionConstants.FLOW_MODEL);
    
	String pdid = (String)model.getWorkflowProcesses().keySet().iterator().next();
	
	WorkflowProcess process = model.getWorkflowProcess(pdid);

	List infos = helper.validateProcess(process);
	
	
%>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">

		<table class="query_form_content" style="width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;">
			<tr>
			<td colSpan="3" >
							
			</td>
			<tr>
			<td  style="width:10%;" class="recordHeader" >
				顺序号			
			</td>
			<td class="recordHeader" style="width:45%;">
				描述			
			</td>
			<td  class="recordHeader"  style="width:45%;">
				位置			
			</td>
		</tr>
		
		<% 
		int i=1;
		for(Iterator iter = infos.iterator();iter.hasNext(); ){
			ValidationInfo info = (ValidationInfo)iter.next();
			//System.out.println("desc:"+info.getDesc());
			//System.out.println("location:"+info.getLocation());
		%>
		<tr>
			<td  style="width:60px;text-align: center;" >
				<%=i%>
			</td>
			<td class="recordCell">
				<%=info.getDesc()%>
			</td>
			<td class="recordCell">
				<%=info.getLocation()%>
			</td>
		</tr>
		
		<% 
		++i;
		}

		%>
</table>

</td>
</tr>

</table>
</form>

</div>

</body>
</html>