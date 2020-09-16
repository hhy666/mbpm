<%@page pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">

	$(document).ready(function(){
		<%-- //getToken
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "getToken";
		json.token = "";
		json.data = "{'logonName':'yh1','password':'1234'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //resumeActivityInstance
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "resumeActivityInstance";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'aiid':'b9304e5f-62d6-4873-8173-7f7394d01669'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //suspendActivityInstance
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "suspendActivityInstance";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'aiid':'b9304e5f-62d6-4873-8173-7f7394d01669aaaa'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //suspendProcessInstance
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "suspendProcessInstance";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'piid':'7727725d-a277-4b8d-8ef2-468be0d9de5f'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		
		<%-- //resumeProcessInstance
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "resumeProcessInstance";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'piid':'7727725d-a277-4b8d-8ef2-468be0d9de5f'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //terminateActivityInstance
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "terminateActivityInstance";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'aiid':'b9304e5f-62d6-4873-8173-7f7394d01669'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		<%-- //terminateProcessInstance
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "terminateProcessInstance";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'piid':'7727725d-a277-4b8d-8ef2-468be0d9de5f'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		
		<%-- //updateActivityInsPriority
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "updateActivityInsPriority";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'aiid':'4a5939f6-0207-4ef3-9336-8c54633fb724','newPriority':4}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		});  --%>
		
		<%-- //updateProcessInsPriority
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "updateProcessInsPriority";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'piid':'81f0ded4-67c4-4846-bdf6-88c6cf1fc381','newPriority':2}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //updateInstanceVariableData
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "updateInstanceVariableData";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'piid':'81f0ded4-67c4-4846-bdf6-88c6cf1fc381','ptid':'34ab88ee-a924-4808-b4d4-1e8181abb78c','variableName':'mTitle','variable':'123'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		//claimTask
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "claimTask";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'taskId':'d595a095-bd2c-42e9-9f27-3bedcf30fde8aaaa'}";
		var st = JSON.stringify(json);
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		});
		
		<%-- //releaseTask
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "releaseTask";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'taskId':'d595a095-bd2c-42e9-9f27-3bedcf30fde8'}";
		var st = JSON.stringify(json);
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //gobackTask
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "gobackTask";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'taskId':'d595a095-bd2c-42e9-9f27-3bedcf30fde8'}";
		var st = JSON.stringify(json);
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //transferTask
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "transferTask";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'taskId':'e7012c0d-0e4f-4949-8f43-415b2c276114','targetUserId':'402880e564b63dea0164b65329150014'}";
		var st = JSON.stringify(json);
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //completeTask
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "completeTask";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'taskId':'69fcdf24-fe21-451b-93fa-48707646a764','selectedTdid':'1576740052786','potentialOwners':'402880e564b63dea0164b652f34e0013,402880e564b63dea0164b65329150014'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		
		
		
		<%-- //completeTask
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "completeTask";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'taskId':'09b10765-4ed2-4860-9fcd-0637375de66e'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //withdraw
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "withdraw";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'taskId':'6f5dcbed-f6e8-4e11-b7a1-b66fd847fbd9'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //getAvailableTransitionsOfAct
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "getAvailableTransitionsOfAct";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'piid':'27ffe1f7-2f31-4f01-bffb-9c50c56fa065','ptid':'34ab88ee-a924-4808-b4d4-1e8181abb78c','adid':'1564118283001001'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		});  --%>
		
		<%-- //getAvailableTransitionsOfStartProc
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "getAvailableTransitionsOfStartProc";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'pdid':'mFlow025'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		});  --%>
		
		<%-- //createAndStartProcessInstance
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "createAndStartProcessInstance";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'pdid':'mFlow025','title':'test11111','plateId':'d120b506-970a-49db-be0e-1272c679142a','subMainObject':[{'entity':'flowdesign.module001.mFormFlow0080','data':{'uuid':'03c57521-448c-4bc2-9ef0-5502945f87qqqqq','smFormFlow008field1':'qqqq'}}],'mainObject':{'entity':'flowdesign.module001.mFormFlow008','data':{'mBizId':'03c57521-448c-4bc2-9ef0-5502945f87qqqqq','mmFormFlow008field0':'qqqq'}}}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url, 
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //getReadyTasks
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "getReadyTasks";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'num':'10','starNum':'1','type':'pc'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url, 
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //getReadyTaskCount
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "getReadyTaskCount";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'getReadyTaskCount':'getReadyTaskCount'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url, 
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		}); --%>
		
		<%-- //getCompletedTaskCount
		var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.command = "getCompletedTaskCount";
		json.token = "1b146cd1-e9a8-423f-844f-bf5f6b52549d";
		json.data = "{'getCompletedTaskCount':'getCompletedTaskCount'}";
		var st = JSON.stringify(json); 
		$.ajax({
			url:url, 
			type:"post",
			data:json,
			dataType:"json",
			success:function(data){
				var sd = JSON.stringify(data); 
				var result = data.result;
				if(result=="error"){
					var message = data.message;
					Matrix.warn(message);					
				}else if(result=="success"){
					var data = data.data;
					alert(data);
				}
			}
		});  --%>
	});

</script>
</head>
<body>
	
</body>
</html>