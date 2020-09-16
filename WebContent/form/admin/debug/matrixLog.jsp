<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.api.MDebugger"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Matrix日志记录</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	  //异步保存回调函数
      function callbackClearLogInfo(data){
      		var callStr = data.data;
      		if(callStr!=null){
      			var callJson = isc.JSON.decode(callStr);
      			var msg = callJson.message;
      			if(msg==true){
      				//将文本域值清空
      				 document.getElementById('logContent').value ="";
      			}
      		}else{
      		    parent.isc.warn("操作失败!");
      		}
      } 
      
      
      
      //清空 日志信息
      function clearLogInfo(){
         var  form0 =  document.getElementById("Form0");
     	form0.action = "<%=request.getContextPath()%>/common/debugger_clearLogInfo.action";
      	 Matrix.send("Form0",null,callbackClearLogInfo);
      } 

      //刷新
      function refreshLogInfo(){
      	  var  form0 =  document.getElementById("Form0");
     	  form0.action = "<%=request.getContextPath()%>/common/debugger_refreshLogInfo.action";
      	  form0.submit();
      }
    
     
	</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<%
String content = MDebugger.getContent();
System.out.println(content.length());
//out.print("log:"+content);

%>
<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"<%=request.getContextPath()%>/form/formInfo_saveModelInSourceView.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="<%=request.getContextPath()%>/" style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<!-- commom cols -->
<input id="formUuid" type="hidden" name="formUuid" value="${requestScope.formUuid}"/>

  
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
		style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="dataTable" jsId="dataTable" cellpadding="0px" cellspacing="0px" style="width:100%;height:100%;">
	<tr id="j_id2" jsId="j_id2">
		
		<td id="j_id4" jsId="j_id4" class="Toolbar" colspan="4" rowspan="1"
			style="border-style: none;">
			
			       
			<script>
			     	isc.ToolStripButton.create({
			     		ID:"MToolBarItem6",
			            icon:Matrix.getActionIcon("delete"),
			     		title: "清除",
			     		showDisabledIcon:false,
			     		showDownIcon:false 
			     	});
			     	MToolBarItem6.click=function(){
			        Matrix.showMask();
					clearLogInfo();
		  			Matrix.hideMask();
			     	return;
			     }
			       </script> 
			       
			       <script>
			        isc.ToolStripButton.create({
			        		ID:"MToolBarItem5",
							icon:Matrix.getActionIcon("refresh"),
			        		title: "刷新",
			        		showDisabledIcon:false,
			        		showDownIcon:false
			         });
			         MToolBarItem5.click=function(){
			         	Matrix.showMask();
			         	   refreshLogInfo();
			         	Matrix.hideMask();
			         	return false;
			         	
			         }
			     </script>
	<div id="j_id5_div" style="width: 100%; overflow: hidden;">
		<script>
			 isc.ToolStrip.create({
			 	ID:"Mj_id5",
			 	displayId:"j_id5_div",
			 	width: "100%",
			 	height: "*",
			 	position: "relative",
			 	members:[ 
				 	MToolBarItem6,
				 	MToolBarItem5
			 	]
			 });
			 		    		 
//			 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
		</script>
	</div>
		</td>
		
	</tr>
	<tr id="j_id7" jsId="j_id7">
		
		<td id="j_id9" jsId="j_id9" colspan="3" rowspan="1"
			style="border-style: none; width: 100%; height: 100%"><!-- 在此添加文本域 -->

			<textarea id="logContent" name="logContent" readonly="false" rows="" cols=""  style="height:100%;line-height:20px;width:100%;border:0px;"><%=content %></textarea>
			
		</td>
	</tr>
</table>
</form>
<script>
//	MForm0.initComplete=true;
//	MForm0.redraw();
//	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
	
	//document.getElementById('modelXmlContent').onkeydown = onTextareaKeydown;
</script>


	</div>

</body>
</html>