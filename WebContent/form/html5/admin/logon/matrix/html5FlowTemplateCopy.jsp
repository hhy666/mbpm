<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>
<script>
	$(function(){
		var templateName = document.getElementById('templateName').value;
		document.getElementById('name').value = templateName + "(复制)";
	})
	
	function checkName(){
		$('#namefont').html("");
		$('#idfont').html("");
		
		if( $('#name').val() == null || $('#name').val() == '' ){
			$('#namefont').html("请输入名称");
		}else{
			var name = $('#name').val();
			var customId = $('#customId').val();  //编码
			
			var custom = document.getElementById('custom').value;  //是否自定义编码  value=1 是
			var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";
			var jsonData = {};
			jsonData.customId = customId;
			jsonData.name = name;
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    
			    var nameMessage = callbackJson.nameMessage;
				$('#namefont').html(nameMessage);
				
				var idMessage = callbackJson.idMessage;
				if(custom==1){
					$('#idfont').html(idMessage)
				}
			});
		}
			
	}
	function checkId(){
		$('#namefont').html("");
		$('#idfont').html("");
		
		if( $('#customId').val() == null || $('#customId').val() == '' ){
			$('#idfont').html("请输入编码");
		}else{
			var name = $('#name').val();
			var customId = $('#customId').val();  //编码
			
			var custom = document.getElementById('custom').value;  //是否自定义代码  value=1 是
			var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";	
			var jsonData = {};
			jsonData.customId = customId;
			jsonData.name = name;
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    
			    var nameMessage = callbackJson.nameMessage;
				$('#namefont').html(nameMessage);
				
				var idMessage = callbackJson.idMessage;
				if(custom==1){
					$('#idfont').html(idMessage)
				}
			});
		}		
		
	}
	
	//自定义编码复选框选中事件
	function customChange(checkbox){
		if(checkbox.checked==true){  //选中
			checkbox.value = 1;
			document.getElementById('tr0033').style.display="";
		}else{
			document.getElementById('tr0033').style.display="none";
			checkbox.value = 2;   //取消选择改变值
			
		}
		
	}
</script>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post"
			action=""
			style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
			enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<div type="hidden" id="form0_hidden_text_div"
				name="form0_hidden_text"
				style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
			<table id="table001" class="tableLayout" style="width: 100%;">
				<tr id="tr002">
					<td id="td003" class="tdLayout"
						style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
						id="label002" name="label002" id="label002" class="control-label ">
							复制名称：</label></td>
					<td id="td004" class="tdLayout" style="width: 60%;"><div
							id="input002_div" class="input-group col-md-12 "
							style="display: inline-table; vertical-align: middle; width: 80%;">
							<input id="name" name="name" type="text" class="form-control "
								style="width: 100%; height: 100%; padding-left: 5px;"
								autocomplete="off" onblur="checkName();">
						</div> <font id="namefont" color="red">${requestScope.nameEchoMessage }</font>
					</td>
				</tr>
				<tr id="tr0032">
					<td id="td0052" class="tdLayout"
						style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
						name="label0032" id="label0032" class="control-label ">
							是否自定义编码：</label></td>
					<td id="td0062" class="tdLayout" style="width: 60%;">
						<div class="form-group;" style="display: inline-table;" name="checkBox002_div" id="checkBox002_div" >
							<input type="checkbox" name="custom" id="custom" onchange="customChange(this);" value="2" />
						</div>
					</td>
				</tr>
				<tr id="tr0033" style="display:none;">
					<td id="td0053" class="tdLayout"
						style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
						name="label0033" id="label0033" class="control-label ">
							编码：</label></td>
					<td id="td0063" class="tdLayout" style="width: 60%;"><div
							id="input002_div" class="input-group col-md-12 "
							style="display: inline-table; vertical-align: middle; width: 80%;">
							<input id="customId" name="customId" type="text" value=""
								class="form-control "
								style="width: 100%; height: 100%; padding-left: 5px;"
								autocomplete="off" onblur="checkId();">
						</div><font id="idfont" color="red">${requestScope.idEchoMessage }</font>
					</td>
				</tr>
				<tr id="tr004">
					<td id="td007" class="cmdLayout" colspan="2" rowspan="1">
						<button type="button" id="button001" class="x-btn ok-btn ">保存</button>
						<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>
						<input id="templateName" type="hidden" name="templateName" value="${templateName }">
						<input id="templateId" type="hidden" name="templateId" value="${templateId }">
						<script>
							$('#button001').click(function() {
									//设置确定按钮不可用  防止重复提交
									$('#button001').attr("disabled",true);
									
									var custom = document.getElementById('custom').value;  //是否自定义编码 value=1 是
									$('#namefont').html("");
									$('#idfont').html("");
									if(custom==1){  //自定义编码
										var name = $('#name').val();  //名称
										var customId = $('#customId').val();  //编码
										//请求到后台统一校验
										var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";	
										var jsonData = {};
										jsonData.customId = customId;
										jsonData.name = name;
										Matrix.sendRequest(url,jsonData,function(data){
											var callbackStr = data.data;
											var callbackJson = isc.JSON.decode(callbackStr);
											
											 var nameMessage = callbackJson.nameMessage;
											 $('#namefont').html(nameMessage);
											 
											 var idMessage = callbackJson.idMessage;
											 $('#idfont').html(idMessage);
											
											 if($('#namefont').html() == '' && $('#idfont').html() == ''){ 
												 var url = "<%=request.getContextPath()%>/templet/tem_copyTemplate.action";
												    var sendData = {};
												    sendData.templateId = document.getElementById('templateId').value;
												    sendData.custom = document.getElementById('custom').value;
												    sendData.name = document.getElementById('name').value;
												    sendData.customId = document.getElementById('customId').value;
												    
												    Matrix.sendRequest(url,sendData,function(data){
												        if(data!=null && data.data=='true'){
												          parent.oncopyFlowTemplateDialogClose();			
												          var index = parent.layer.getFrameIndex(window.name);
														  parent.layer.close(index);
												        }else{
												          Matrix.warn('复制出错！');
												        }
												    });	
											 }else{
												 $('#button001').attr("disabled",false);
											 }
											 
											 
										});
										
												
									}else{   //按默认生成编码
										var flag = false;
									
										 if ($('#name').val() == null || $('#name').val() == '') {
											 $('#button001').attr("disabled",false);
										     $('#namefont').html("请输入名称");
										 }else{   
												var name = $('#name').val();  //名称
												var customId = $('#customId').val();  //编码
												var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";	
												var jsonData = {};
												jsonData.customId = customId;
												jsonData.name = name;
												Matrix.sendRequest(url,jsonData,function(data){
													var callbackStr = data.data;
													var callbackJson = isc.JSON.decode(callbackStr);
													
													var nameMessage = callbackJson.nameMessage;
													$('#namefont').html(nameMessage);
													
													if($('#namefont').html() == ''){
														flag = true;
													}else{
														flag = false;
													}
													if(!flag){
														$('#button001').attr("disabled",false);
														return;
													}
													var url = "<%=request.getContextPath()%>/templet/tem_copyTemplate.action";
												    var sendData = {};
												    sendData.templateId = document.getElementById('templateId').value;
												    sendData.custom = document.getElementById('custom').value;
												    sendData.name = document.getElementById('name').value;
												    
												    Matrix.sendRequest(url,sendData,function(data){
												        if(data!=null && data.data=='true'){
												          parent.oncopyFlowTemplateDialogClose();
												          var index = parent.layer.getFrameIndex(window.name);
														  parent.layer.close(index);
												        }else{
												          Matrix.warn('复制出错！');
												        }
												    });
											   });
										  }
									 }		 							
							});  

						   $('#button002').click(function() {
									var index = parent.layer.getFrameIndex(window.name);
									parent.layer.close(index);
						   });
						</script>
					</td>
				</tr>
			</table>

		</form>
	</div>
</body>
</html>