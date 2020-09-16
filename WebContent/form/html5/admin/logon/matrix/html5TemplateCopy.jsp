<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8' />
<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>
<script>
	$(function(){
		 var flowTemplateMap = eval('(' + '${flowTemplateMap}' + ')');
		 var tb = document.getElementById('tb');  //table对象
		 var index = document.getElementById('tr008').rowIndex;   //在这行下边插入不固定数量的行
		 for(var i in flowTemplateMap){
			 var flowTemplateName = flowTemplateMap[i] + "(复制)";
			 
			 index = index + 1;    //要插入的行的索引
			 var newTr = tb.insertRow(index);  //插入新行
			 
			 var newTd1 = newTr.insertCell();
			 newTd1.innerHTML = "<label id=\"label"+index+"\" name=\"label"+index+"\" class=\"control-label\">"+index+"</label>";
			 newTd1.className = "tdLayout"; 
			 newTd1.style = "text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)";
			 
			 var newTd2 = newTr.insertCell();
			 newTd2.innerHTML = "<div id=\"flowName_div"+index+"\" class=\"input-group col-md-12\" style=\"width: 100%;margin-left:0%;vertical-align: middle; background-color: rgb(248, 248, 248);\">"
			 +"<input id=\"flowName"+index+"\" name=\"flowName"+index+"\" type=\"text\" class=\"form-control\" value=\""+flowTemplateName+"\" onblur=\"checkFlowName("+index+");\""
			 +"style=\"width: 100%; height: 100%;text-align:center;padding-left: 5px;\" autocomplete=\"off\"></div>";
			 newTd2.className = "tdLayout"; 
			 newTd2.style = "background-color: rgb(248, 248, 248)";
			
			
			 var newTd3 = newTr.insertCell();
			 newTd3.innerHTML = "<div id=\"flowId_div"+index+"\" class=\"input-group col-md-12\" style=\"display: inline-table;margin-left:0%;vertical-align: middle; width: 100%;\">"
			 +"<input id=\"flowId"+index+"\" name=\"flowId"+index+"\" type=\"text\" class=\"form-control\" onblur=\"checkFlowId("+index+");\""
			 +"style=\"width: 100%; height: 100%;text-align:center;padding-left: 5px;\" autocomplete=\"off\"></div>";
			 newTd3.className = "tdLayout"; 
			 
			 var newTd4 = newTr.insertCell();
			 newTd4.innerHTML = "<font id=\"checkMessage"+index+"\" color=\"red\"></font>";
			 newTd4.className = "tdLayout"; 
			 newTd4.style="text-align: center";
			 
			 var newTd5 = newTr.insertCell();
			 newTd5.innerHTML = "<label id=\"templateId"+index+"\" name=\"templateId"+index+"\" class=\"control-label\">"+i+"</label>";
			 newTd5.className = "tdLayout"; 
			 newTd5.style="display:none;";
		 }
	})
	
	//校验流程名称是否重复
	function checkFlowName(index){
		$("#checkMessage"+index+"").html("");
		
		if($("#flowName"+index+"").val() == null || $("#flowName"+index+"").val() == ''){
			$("#checkMessage"+index+"").html("请输入名称");
		}else{
			var name = $("#flowName"+index+"").val();
			var customId = $("#flowId"+index+"").val();  //编码
			
			//先校验是否与已输入的其它流程名称重复
			var tb = document.getElementById('tb');  //table对象
			var maxIndex = tb.rows.length-1;  //表格最大索引
			
			for(var i=1;i<=maxIndex;i++){
				if(i!=index){
					if(name == $("#flowName"+i+"").val()){
						$("#checkMessage"+index+"").html("名称重复");
						return;
					}
				}
			}
			
			var custom = document.getElementById('custom').value;  //是否自定义编码  value=1 是
			var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";
			var jsonData = {};
			jsonData.customId = customId;
			jsonData.name = name;
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    
				var nameMessage = callbackJson.nameMessage;
				$("#checkMessage"+index+"").html(nameMessage);
			});
		}
	}
	
	//校验流程编码是否重复
	function checkFlowId(index){
		$("#checkMessage"+index+"").html("");
		
		if($("#flowId"+index+"").val() == null || $("#flowId"+index+"").val() == ''){
			$("#checkMessage"+index+"").html("请输入编码");
		}else{
			var customId = $("#flowId"+index+"").val();  //编码
			var name = $("#flowName"+index+"").val();
			
			//先校验是否与已输入的其它流程名称重复
			var tb = document.getElementById('tb');  //table对象
			var maxIndex = tb.rows.length-1;  //表格最大索引
			
			for(var i=1;i<=maxIndex;i++){
				if(i!=index){
					if(customId == $("#flowId"+i+"").val()){
						$("#checkMessage"+index+"").html("编码重复");
						return;
					}
				}
			}
			var custom = document.getElementById('custom').value;  //是否自定义编码  value=1 是
			var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";
			var jsonData = {};
			jsonData.customId = customId;
			jsonData.name = name;
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    var idMessage = callbackJson.idMessage;
				$("#checkMessage"+index+"").html(idMessage);
			});
		}
	}
	

	function checkName(){
		$('#namefont').html("");
		$('#idfont').html("");
		
		if( $('#name').val() == null || $('#name').val() == '' ){
			$('#namefont').html("请输入名称");
		}else{
			var name = $('#name').val();
			var customId = $('#customId').val();  //编码
			var custom = document.getElementById('custom').value;  //是否自定义编码  value=1 是
			var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
			
			var jsonData = {};
			jsonData.addType = "template";
			jsonData.name = name;
			jsonData.customId = customId;
			jsonData.custom = custom;
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
			var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
			
			var jsonData = {};
			jsonData.addType = "template";
			jsonData.name = name;
			jsonData.customId = customId;
			jsonData.custom = custom;
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
	
	function checkPath(){
		if($('#popupSelectDialog001').val() == null || $('#popupSelectDialog001').val() == ''){
			$('#targetPath').html("请输入路径");
		}else {
			$('#targetPath').html("");
		}
	}
	
	//自定义编码复选框选中事件
	function customChange(checkbox){
		if(checkbox.checked==true){  //选中
			checkbox.value = 1;
			document.getElementById('tr0033').style.display="";
			document.getElementById('tr0035').style.display="";
		}else{
			document.getElementById('tr0033').style.display="none";
			document.getElementById('tr0035').style.display="none";
			checkbox.value = 2;   //取消选择改变值
			
		}
		var templateType = document.getElementById('templateType').value;
		if(templateType == 3){  //基础数据没有流程  协同才显示流程
			document.getElementById('tr0035').style.display="none";
		}
		
	}
</script>
<body>

	<div
		style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;"
		id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post"
			action="<%=request.getContextPath()%>/templet/tem_copyNode.action"
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
							名称：</label></td>
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
							表单编码：</label></td>
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
				<tr id="tr0021">
					<td id="td0031" class="tdLayout"
						style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
						id="label0021" name="label0021" id="label0021"
						class="control-label "> 目标路径：</label></td>
					<td id="td0041" class="tdLayout" style="width: 60%;">
						<div id="input0021_div" class="input-group col-md-12 "
							style="display: inline-table; vertical-align: middle; width: 80%;">
							<input id="popupSelectDialog001" name="popupSelectDialog001"
								type="text" class="form-control has-feedback-right "
								style="width: 100%; height: 100%;" readonly="readonly" onblur="checkPath();"/> 
							<span
								class="input-group-addon addon-udSelect udSelect" onclick="showDialog();"> 
								<i class="fa fa-search" " aria-hidden="true"></i>
							</span>
						</div> 
						<span><font id="targetPath" color="red"></font></span>
						<script>
							function showDialog() {
								var templateType = $('#templateType').val();//公文还是协同
								layer.open({
							    	id:'dir',
									type : 2,//iframe 层
									
									title : ['选择目标目录'],
									closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
									shadeClose: false, //开启遮罩关闭
									area : [ '50%', '90%' ],
									content : '<%=request.getContextPath()%>/form/html5/admin/logon/matrix/html5TemplateSelectTree.jsp?isCopyTime=1&templateType='+ templateType+'&iframewindowid=dir'
								});
							}
							//选择目录窗口关闭回调
							function ondirClose(data){
								$('#popupSelectDialog001').val(data.pathStr);
								$('#parentId').val(data.id);
							}
						</script>
					</td>
				</tr>
				<!-- <tr id="tr0031">
					<td id="td0051" class="tdLayout"
						style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
						id="label0031" name="label0031" id="label0031" class="control-label ">
							是否新建表单：</label></td>
					<td id="td0061" class="tdLayout" style="width: 60%;">
						<div class="form-group;" style="display: inline-table;" >
							&nbsp;
							<input type="checkbox" class="box" id="checkBox001" name="subItems_1" checked="checked" style="position: absolute; opacity: 0;" value="1"/>
							&nbsp;表单&nbsp;
							</div>
							<div class="form-group;" style="display: inline-table;" >
								<input type="checkbox" class="box" id="checkBox002" name="subItems_2" checked="checked" style="position: absolute; opacity: 0;" value="2"/>&nbsp;逻辑服务&nbsp;
							</div>
					</td>
				</tr> -->
				<tr id="tr003">
					<td id="td005" class="tdLayout"
						style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
						id="label003" name="label003" id="label003" class="control-label ">
							描述：</label></td>
					<td id="td006" class="tdLayout" style="width: 60%;"><div
							id="inputTextArea001_div" class="col-md-12 input-group "
							style="width: 100%;">
							<textarea id="desc" name="desc" " class="form-control "
								style="width: 100%; height: 100%;resize: none;"></textarea>
						</div></td>
				</tr>
				<tr id="tr0035" style="display:none;">
					<td id="td0054" colspan="3">
						<div style="overflow:auto;">
						<table id="tb" name="tb" style="width:100%;">
							<tr id="tr008">
								<td id="td007" class="tdLayout"
									style="width: 10%; text-align: center; vertical-align: middle; background-color: #b5dbeb"><label
									id="label007" name="label007" id="label007" class="control-label ">
										序号</label></td>
								<td id="td005" class="tdLayout"
									style="width: 30%; text-align: center; vertical-align: middle; background-color: #b5dbeb"><label
									id="label005" name="label005" id="label005" class="control-label ">
										流程名称</label></td>
								<td id="td005" class="tdLayout"
									style="width: 35%; text-align: center; vertical-align: middle; background-color: #b5dbeb"><label
									id="label006" name="label006" id="label006" class="control-label ">
										流程编码</label></td>
								<td id="td009" class="tdLayout"
									style="width: 25%; text-align: center; vertical-align: middle; background-color: #b5dbeb">
									<label id=label008 name="label008" id="label008" class="control-label ">
										校验信息</label>
								</td>
								<td id="td010" class="tdLayout"
									style="width: 0%; text-align: center; vertical-align: middle; background-color: #b5dbeb;display:none;">
									<label id=label010 name="label010" id="label010" class="control-label ">
										</label>
								</td>
							</tr>
							
						</table>
						</div>
					</td>
					
				</tr>
				<tr id="tr0036">
					<td style="height:50px;"></td>
				</tr>
				<tr id="tr004">
					<td id="td007" class="cmdLayout" colspan="2" rowspan="1">
						<button type="button" id="button001" class="x-btn ok-btn ">保存</button>
						<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>

						<input id="parentId" type="hidden" name="parentId"  /> 
						<input id="id" type="hidden" name="id" value="${nodeid }">
						<input id="templateType" type="hidden" name="templateType" value="${templateType }">
						<input id="flowNameAndStr" type="hidden" name="flowNameAndStr" value="">
						<script>
						
						$('#button001').click(function() {
									//设置确定按钮不可用  防止重复提交
									var index = layer.load(1, {shade: [0.1,'#fff']}); //0代表加载的风格，支持0-2
									document.getElementById("button001").style.disabled = "disabled";
									$('#button001').attr("disabled",true);
									
									var custom = document.getElementById('custom').value;  //是否自定义编码 value=1 是
									if(custom==1){  //自定义编码
										//置空
										var tb = document.getElementById('tb');  //table对象
										var maxIndex = tb.rows.length-1;  //表格最大索引
										
										$('#namefont').html("");
										$('#idfont').html("");
										$('#targetPath').html("");
										for(var i=1;i<=maxIndex;i++){
											$("#checkMessage"+i+"").html("");
										}
										
										if($('#popupSelectDialog001').val()==null || $('#popupSelectDialog001').val()==''){
											$('#targetPath').html("请输入路径");
										}
										
										var name = $('#name').val();   //模板名称
										var customId = $('#customId').val();  //表单编码
										
										//拼接出流程名称和编码的json
										var str = '['; 
										for(var i=1;i<=maxIndex;i++){
											 var flowName = $("#flowName"+i+"").val();
											 var flowId = $("#flowId"+i+"").val();
											 str = str + '{';
										 	 str = str + '"index":"'+i+'",';
										 	 str = str + '"templateId":"'+$("#templateId"+i+"").html()+'",';
										 	 str = str + '"flowName":"'+flowName+'",';
										 	 str = str + '"flowId":"'+flowId+'"';
										 	 str = str + '},';
										}
										if(str.indexOf(',')>0){
											 str = str.substring(0,str.length-1);
										}										
										 str = str +  ']';
										
										
										
										 var newData = {};
										 newData.name = name;
										 newData.customId = customId;
										 newData.flowCondition = str;
										 
										 document.getElementById('flowNameAndStr').value = str;   //放入表单隐藏域
										 
										 //请求到后台统一校验
										 var url="<%=request.getContextPath()%>/templet/tem_copyCheckAll.action";
										 Matrix.sendRequest(url,newData,function(data){
											 var callbackStr = data.data;
											 var callbackJson = isc.JSON.decode(callbackStr);
											 
											 var nameMessage = callbackJson.nameMessage;
											 $('#namefont').html(nameMessage);
											 
											 var idMessage = callbackJson.idMessage;
											 $('#idfont').html(idMessage);
											 
											 var flag = true;
											 var templateType = $('#templateType').val();
											 if(templateType != 3){  //基础数据没有流程 所以没有校验    协同才显示流程
												 var flowIdAndNameMessage = callbackJson.flowIdAndNameMessage;
												 for(var key in flowIdAndNameMessage){
													 var obj = flowIdAndNameMessage[key];
													 
													 var index = obj.index;
													 var flowNameMessage = obj.flowNameMessage;
													 var flowIdMessage = obj.flowIdMessage;
													 
													 $("#checkMessage"+index+"").html(flowNameMessage+"&nbsp;&nbsp;"+flowIdMessage);
												 }
												 var children = $("font[id^='checkMessage']");  
												 for(i = 0; i < children.length; i++){
													 if(children[i].innerHTML != '&nbsp;&nbsp;'){
														 flag = false;
													 }
												  }
											 }
											 
											 if( $('#namefont').html() == '' && $('#idfont').html() == '' && flag){   //所有校验都通过才能提交表单						
												if(parent.document.getElementById('maskDiv')){
													 parent.document.getElementById('maskDiv').style.display='block';
												}
												 $('#form0').submit();	
											 }else{
												 $('#button001').attr("disabled",false);
											 }
										 });
										  
									}else{    //按默认生成编码
										var flag = false;
										
										//置空
										$('#namefont').html("");
										$('#targetPath').html("");
										
										if($('#popupSelectDialog001').val()==null || $('#popupSelectDialog001').val()==''){
											$('#targetPath').html("请输入路径");
										}else{
											flag = true;
										}
										
										//非空验证
										if($('#name').val()==null || $('#name').val()==""){
											$('#button001').attr("disabled",false);
											$('#namefont').html("请输入名称");
										}else{
											var name = $('#name').val();  //名称
											var customId = $('#customId').val();  //编码
											var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
											var jsonData = {};
											jsonData.addType = "template";
											jsonData.name = name;
											jsonData.customId = customId;
											jsonData.custom = custom;
											Matrix.sendRequest(url,null,function(data){
												var callbackStr = data.data;
												var callbackJson = isc.JSON.decode(callbackStr);
												
												var nameMessage = callbackJson.nameMessage;
												$('#namefont').html(nameMessage);
													 
												if( $('#namefont').html() == '' && flag){
													if(parent.document.getElementById('maskDiv')){
														parent.document.getElementById('maskDiv').style.display='block';
													}
													$('#form0').submit();		
												}else{
													$('#button001').attr("disabled",false);
												}
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
