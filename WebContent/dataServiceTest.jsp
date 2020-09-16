<%@page pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script type="text/javascript">
	$(document).ready(function(){
		
		//load
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "load";
		json.token = "12544e86-8133-4b81-be6b-b6a26757e52basd";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','id':'06503cf9-5849-4849-a020-61cafd8a59dd'}";
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
		
		<%-- //delete 
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "delete";
		json.token = "token";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','id':'20e82778-9997-40aa-99af-cd9bedbc1237'}";
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
		
		<%-- //deleteBatch 
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "deleteBatch";
		json.token = "token";
		json.data = "{'data':[{'entity':'flowdesign.module001.mFormFlow008','id':'20e82778-9997-40aa-99af-cd9bedbc1237'},{'entity':'flowdesign.module001.mFormFlow008','id':'20e82778-9997-40aa-99af-cd9bedbc1236'}]}";
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
		
		<%-- //update
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "update";
		json.token = "token";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','data':{'mBizId':'0f4bb99e-34ba-4898-aab2-6b6e6acab4d5','mmFormFlow008field0':'1'}}";
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
			},
			error:function(data){
				alert(123);
			}
		}); --%>
		
		<%-- //updatebatch
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "updateBatch";
		json.token = "token";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','data':[{'mBizId':'03c57521-448c-4bc2-9ef0-5502945f87dc','mmFormFlow008field0':'1'},{'mBizId':'06503cf9-5849-4849-a020-61cafd8a59dd','mmFormFlow008field0':'1'}]}";
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
		}) --%>
		
		
		<%-- //save
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "save";
		json.token = "token";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','data':{'mBizId':'20e82778-9997-40aa-99af-cd9bedbc9999','mmFormFlow008field0':'1'}}";
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
		
		
		<%-- //saveBatch
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "saveBatch";
		json.token = "token";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','data':[{'mBizId':'03c57521-448c-4bc2-9ef0-5502945fqwer','mmFormFlow008field0':'2'},{'mBizId':'06503cf9-5849-4849-a020-61cafd8aasdf','mmFormFlow008field0':'2'}]}";
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
		}) --%>
		
		
		<%-- //saveOrUpdate
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "saveOrUpdate";
		json.token = "token";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','data':{'mBizId':'20e82778-9997-40aa-99af-cd9bedbc1236','mmFormFlow008field0':'4'}}";
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
		
		<%-- //saveOrUpdateBatch
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "saveOrUpdateBatch";
		json.token = "token";
		json.data = "{'entity':'flowdesign.module001.mFormFlow008','data':[{'mBizId':'20e82778-9997-40aa-99af-cd9bedbc1236','mmFormFlow008field0':'5'},{'mBizId':'20e82778-9997-40aa-99af-cd9bedbc1237','mmFormFlow008field0':'5'}]}";
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
		}) --%>
		
		<%-- //queryPage
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "queryPage";
		json.token = "token";
		json.data = "{'hql':'from flowdesign.module001.mFormFlow008','startIndex':1,'maxResults':2}";
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
		
		<%-- //queryList
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "queryList";
		json.token = "token";
		json.data = '{"hql":"from flowdesign.module001.mFormFlow008 where mBizId = \'282eaf02-dd2f-463c-8420-6fb157df3194\'"}';
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
		
		<%-- //queryList2
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "queryList2";
		json.token = "token";
		json.data = "{'hql':'from flowdesign.module001.mFormFlow008','startIndex':1,'maxResults':2}";
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
		
		<%-- //queryValue
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "queryValue";
		json.token = "token";
		json.data = '{"hql":"select mBizId from flowdesign.module001.mFormFlow008 where mBizId = \'282eaf02-dd2f-463c-8420-6fb157df3194\'"}';
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
		
		<%-- //executeUpdate
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "executeUpdate";
		json.token = "token";
		json.data = '{"hql":"update flowdesign.module001.mFormFlow008 set mmFormFlow008field0 = 10 where mBizId = \'582a7801-34ba-4029-a816-b783adcdffa4\'"}';
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
		
		<%-- //executeDelete
		var url = "<%=request.getContextPath()%>/dataService";
		var json = {};
		json.command = "executeDelete";
		json.token = "token";
		json.data = '{"hql":"delete from flowdesign.module001.mFormFlow008 where mBizId = \'0b079ea8-95ac-48f9-bca5-5c90f5081d66\'"}';
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
		
		
		<%-- var url = "<%=request.getContextPath()%>/flowService";
		var json = {};
		json.logonName = "yh1";
		json.password = "1234";
		$.ajax({
			url:url,
			type:"post",
			data:json,
			dataType:"text",
			success:function(data){
				alert(data);
			}
		}); --%>
	});
</script>
</head>
<body>
</body>
</html>