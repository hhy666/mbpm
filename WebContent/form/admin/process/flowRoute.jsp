<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'flowRoute.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<SCRIPT SRC='<%=request.getContextPath()%>/resource/html5/js/jquery.min.js'></SCRIPT>
  </head>
  
  <body>
  <form action="" method="post" id="form0" name="form0">
	</form>
     <script type="text/javascript">
  	 // var form0 = $('#form0') //父页面form
  	 //var form0 = parent.$('#form0');
	 var form1 = document.getElementById('form0')//本页面form
	  //var array = $(form0).serializeArray();//序列化父页面数据
	  //var length=array.length;

	var form = parent.document.getElementById("form0");  
	
	var data = parent.Matrix.formToObject(form);
	if(!data)data={};
	
	  var elements = new Array();  
	  var tagElements = form.getElementsByTagName('input');  
	  debugger;
//	  if(array!=null&&length>0){
	  if(tagElements!=null&&tagElements.length>0){
//	 	 for(var i=0;i<length;i++){
	  for (var j = 0; j < tagElements.length; j++){ 
	     var ele = tagElements[j]; 
	  		var input = document.createElement('input');  //创建input节点
			input.setAttribute('type', 'hidden');  //定义类型是hidden
//			input.setAttribute('name', array[i].name);
//			input.setAttribute('id', array[i].name);  
//			input.setAttribute('value', array[i].value);  
			input.setAttribute('name', ele.name);
			input.setAttribute('id', ele.id);  
			input.setAttribute('value', data[ele.name]);  
			form1.appendChild(input); //添加到form中显示
	 	 }
	 	 
	 	 var input = document.createElement('input');  //创建input节点
			input.setAttribute('type', 'hidden');  //定义类型是hidden
			input.setAttribute('name', 'iframewindowid');
			input.setAttribute('id', 'iframewindowid');  
			input.setAttribute('value', '<%=request.getParameter("iframewindowid")%>');  
			form1.appendChild(input); //添加到form中显示
		<%-- if("${param.mHtml5Flag}"=="true"){//不需要h5
			form1.action="<%=request.getContextPath()%>/selectTransition/selectTransition_turn2TransitionPage.action?iframewindowid=<%=request.getParameter("iframewindowid")%>&pdid=${param.pdid}&adid=${param.adid}&aiid=${param.aiid}&piid=${param.piid}&ptid=${param.ptid}&mHtml5Flag=true";//更改提交路径
		}else{ --%>
	 	 form1.action="<%=request.getContextPath()%>/selectTransition/selectTransition_turn2TransitionPage.action?iframewindowid=<%=request.getParameter("iframewindowid")%>&pdid=${param.pdid}&adid=${param.adid}&aiid=${param.aiid}&piid=${param.piid}&ptid=${param.ptid}";//更改提交路径
//	 	 }
	 	 form1.submit();
	  }
  </script>
  	
  </body>
</html>
