<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.admin.catalog.model.CatalogInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link href='<%=request.getContextPath() %>/resource/html5/css/fileinput.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/fileinput.min.js'></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/zh.js'></script>

<script type="text/javascript">
	$(function(){
		 var currentNodeName = parent.$('#module option:selected').text();
		 var currentNodeId = parent.$('#module option:selected').val();
		 
		 $('#popupSelectDialog001').val(currentNodeName);
		 $('#parentId').val(currentNodeId);
		 
		 var templateType = $('#templateType').val();
		 if(templateType != 3){  //基础数据没有流程  协同才显示流程
			 $('#tr0035').css('display','');
		 }
		 $('#uploadFile').fileinput({
			 language: 'zh',
			 uploadUrl: '<%=path %>/ImpAndExpTempServlet?flag=readCode',
			 enctype: 'multipart/form-data',
			 allowedFileExtensions: ['zip'],
			 uploadAsync: true,   //默认异步上传
			 uploadExtraData: function (previewId, index) {
				 var data = {};
				 data.fileUuid = $('#fileUuid').val();
				 return data;
			 },
			 showUpload: false,   //是否显示上传按钮
			 showRemove: false,   //是否显示删除/清空按钮。默认值true
			 showPreview: false,   //是否显示文件的预览图。默认值true
			 showCaption: false,  //是否显示文件标题，默认为true
			 showBrowse: true,    //是否显示文件浏览/选择按钮。默认值true
			 showCancel: false,     //是否显示文件上传取消按钮以中止正在进行的上传
			 msgPlaceholder: '请选择zip格式的文件',   //未选择文件时的提示信息
		 }).on('change', function(event) {
			 $('#uploadFile').fileinput('upload');      //上传
			 $('.kv-upload-progress').css('display','none');   //隐藏掉进度状态条
		 }).on('fileuploaded', function (event, data, previewId, index) {       //文件上传成功
			 debugger;
			 if(data.response!=null && data.response!=''){
				 var messgage = data.response.messgage;
				 if(messgage == 'readSuccess'){
					 var formInfo = data.response.formInfo;
					 for(var i in formInfo){
						 var formTemplateId = i;
						 var formTemplateName = formInfo[i];
						 $('#formName').val(formTemplateName);
						 $('#formId').val(formTemplateId);
						 
						 $('#recordFormId').val(formTemplateId);  //记录表单编码
					 }
					 var fileUuid = data.response.fileUuid;
					 $('#fileUuid').val(fileUuid);
						 
					 var tb = document.getElementById('tb');  //table对象
					 $("#tb tr").not(':eq(0)').remove();    //删除除第一行之外的所有行
					 var index = document.getElementById('tr008').rowIndex;   //在这行下边插入不固定数量的行
					 var flowInfo = data.response.flowInfo;
					 for(var j in flowInfo){
						 var flowTemplateId = j;
						 var flowTemplateName = flowInfo[j];
						 
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
						 +"<input id=\"flowId"+index+"\" name=\"flowId"+index+"\" type=\"text\" class=\"form-control\" value=\""+flowTemplateId+"\" onblur=\"checkFlowId("+index+");\""
						 +"style=\"width: 100%; height: 100%;text-align:center;padding-left: 5px;\" autocomplete=\"off\"></div>";
						 newTd3.className = "tdLayout"; 
						 
						 var newTd4 = newTr.insertCell();
						 newTd4.innerHTML = "<font id=\"checkMessage"+index+"\" color=\"red\"></font>";
						 newTd4.className = "tdLayout"; 
						 newTd4.style="text-align: center";
						 
						 var newTd5 = newTr.insertCell();
						 newTd5.innerHTML = "<label id=\"recordFlowId"+index+"\" name=\"recordFlowId"+index+"\" class=\"control-label\">"+flowTemplateId+"</label>";
						 newTd5.className = "tdLayout"; 
						 newTd5.style="display:none;";
					 }
				 }else{
					 layer.alert("文件内容错误");	
					 $('#uploadFile').fileinput('reset').fileinput("enable");      //重启
				 }
			 }
			
		 }).on('fileuploaderror', function(event, data, msg) {			
			//layer.alert(msg);		 
		 });
	})
	
	//校验表单名称是否重复
	function checkFormName(){
		$('#namefont').html("");
		$('#idfont').html("");
		
		if( $('#formName').val() == null || $('#formName').val() == '' ){
			$('#namefont').html("请输入名称");
		}else{
			var formName = $('#formName').val();
			var formId = $('#formId').val();  //编码
			
			var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
			var jsonData = {};
			jsonData.addType = "template";
			jsonData.name = formName;
			jsonData.customId = formId;
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    
			    var nameMessage = callbackJson.nameMessage;
				$('#namefont').html(nameMessage);
				
				var idMessage = callbackJson.idMessage;
				$('#idfont').html(idMessage);
			});
		}
	}
	
	//校验表单编码是否重复
	function checkFormId(){
		$('#namefont').html("");
		$('#idfont').html("");
		
		if( $('#formId').val() == null || $('#formId').val() == '' ){
			$('#idfont').html("请输入编码");
		}else{
			var formName = $('#formName').val();
			var formId = $('#formId').val();  //编码
			var recordFormId = $('#recordFormId').val();  //记录的原始表单编码
			
			var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
			var jsonData = {};
			jsonData.addType = "template";
			jsonData.name = formName;
			jsonData.customId = formId;
			jsonData.recordFormId = recordFormId;
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    
				var nameMessage = callbackJson.nameMessage;
				$('#namefont').html(nameMessage);
					
				var idMessage = callbackJson.idMessage;
				$('#idfont').html(idMessage);
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
	
	//校验流程名称是否重复
	function checkFlowName(index){
		$("#checkMessage"+index+"").html("");
		
		if($("#flowName"+index+"").val() == null || $("#flowName"+index+"").val() == ''){
			$("#checkMessage"+index+"").html("请输入名称");
		}else{
			var name = $("#flowName"+index+"").val();
			var flowId = $("#flowId"+index+"").val();  //编码
			
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
	
			var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";
			var jsonData = {};
			jsonData.customId = flowId;
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
			var flowId = $("#flowId"+index+"").val();  //编码
			var name = $("#flowName"+index+"").val();
			var recordFlowId = $("#recordFlowId"+index+"").html();  //记录的原始流程编码
			//先校验是否与已输入的其它流程名称重复
			var tb = document.getElementById('tb');  //table对象
			var maxIndex = tb.rows.length-1;  //表格最大索引
			
			for(var i=1;i<=maxIndex;i++){
				if(i!=index){
					if(flowId == $("#flowId"+i+"").val()){
						$("#checkMessage"+index+"").html("编码重复");
						return;
					}
				}
			}
			var url="<%=request.getContextPath()%>/templet/tem_copyFlowTempBefore.action";
			var jsonData = {};
			jsonData.customId = flowId;
			jsonData.name = name;
			jsonData.recordFlowId = recordFlowId;
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    var idMessage = callbackJson.idMessage;
				$("#checkMessage"+index+"").html(idMessage);
			});
		}
	}
</script>
</head>
<body>
<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="multipart/form-data">
	<input id="parentId" type="hidden" name="parentId"  /> 
	<input id="nodeId" type="hidden" name="nodeId" value="${param.nodeId }">
	<input id="templateType" type="hidden" name="templateType" value="${param.templateType }">
	<input id="recordFormId" type="hidden" name="recordFormId" value="">  <!-- 记录上传成功的文件的表单编码 -->
	<input id="flowNameAndStr" type="hidden" name="flowNameAndStr" value="">
	<input id="fileUuid" type="hidden" name="fileUuid" value="">  <!-- 记录上传成功的文件UUID -->
	<table id="table001" class="tableLayout" style="width: 100%;">
		<tr id="tr004">
			<td id="td007" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)">
				<label id="label001" name="label003" id="label003" class="control-label ">选择文件：</label>
			</td>
			<td id="td006" class="tdLayout" style="width:60%;">
				<input id="uploadFile" name="file" type="file" data-show-caption="true">
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLayout"
				style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
				id="label002" name="label002" id="label002" class="control-label ">
					名称：</label></td>
			<td id="td004" class="tdLayout" style="width: 60%;"><div
					id="input002_div" class="input-group col-md-12 "
					style="display: inline-table; vertical-align: middle; width: 80%;">
					<input id="formName" name="formName" type="text" class="form-control "
						style="width: 100%; height: 100%; padding-left: 5px;"
						autocomplete="off" onblur="checkFormName();">
				</div> <font id="namefont" color="red">${requestScope.nameEchoMessage }</font>
			</td>
		</tr>
		<tr id="tr0033">
			<td id="td0053" class="tdLayout"
				style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
				name="label0033" id="label0033" class="control-label ">
					表单编码：</label></td>
			<td id="td0063" class="tdLayout" style="width: 60%;"><div
					id="input002_div" class="input-group col-md-12 "
					style="display: inline-table; vertical-align: middle; width: 80%;">
					<input id="formId" name="formId" type="text" value=""
						class="form-control "
						style="width: 100%; height: 100%; padding-left: 5px;"
						autocomplete="off" onblur="checkFormId();">
				</div><font id="idfont" color="red">${requestScope.idEchoMessage }</font>
			</td>
		</tr>
		<tr id="tr0021">
			<td id="td0031" class="tdLayout"
				style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
				id="label0021" name="label0021" id="label0021"
				class="control-label "> 目标路径：</label></td>
			<td id="td0041" class="tdLayout" style="width: 60%;">
				<!-- 
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
					 -->
					 <div id="input0021_div" class="input-group col-md-12 "
					style="display: inline-table; vertical-align: middle; width: 80%;">
					<input id="popupSelectDialog001" name="popupSelectDialog001"
						type="text" class="form-control has-feedback-right "
						style="width: 100%; height: 100%;" readonly="readonly"/> 
					</div> 
				</script>
			</td>
		</tr>
		<tr id="tr0035" style="display: none;">
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
		<tr id="tr0037">
			<td id="td007" class="cmdLayout" colspan="2" rowspan="1">
				<button type="button" id="button001" class="x-btn ok-btn ">确认</button>
				<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>
				<script>
				$('#button001').click(function() {
					if($('.file-caption-name').val()=='' || $('.file-caption-name').attr('title')=='验证错误'){
						layer.alert('请选择一个zip文件！');
						return false;
					}
					
					//设置确定按钮不可用  防止重复提交
					document.getElementById("button001").style.disabled = "disabled";
					$('#button001').attr("disabled",true);
					
					//置空
					var tb = document.getElementById('tb');  //table对象
					var maxIndex = tb.rows.length-1;  //表格最大索引
					
					$('#namefont').html("");
					$('#idfont').html("");
					$('#targetPath').html("");
					for(var i=1;i<=maxIndex;i++){
						$("#checkMessage"+i+"").html("");
					}
					
					/*
					if($('#popupSelectDialog001').val()==null || $('#popupSelectDialog001').val()==''){
						$('#targetPath').html("请输入路径");
						$('#button001').attr("disabled",false);
						return false;
					}
					*/
					
					var name = $('#formName').val();   //模板名称
					var formId = $('#formId').val();  //表单编码
					var recordFormId = $('#recordFormId').val();  //记录的原始表单编码
					
					//拼接出流程名称和编码的json
					var str = '['; 
					for(var i=1;i<=maxIndex;i++){
						 var flowName = $("#flowName"+i+"").val();
						 var flowId = $("#flowId"+i+"").val();
						 var recordFlowId = $("#recordFlowId"+i+"").html();
						 str = str + '{';
					 	 str = str + '"index":"'+i+'",';
					 	 str = str + '"recordFlowId":"'+recordFlowId+'",';
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
					 newData.customId = formId;
					 newData.recordFormId = recordFormId;
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
						 	 var fileUuid = $('#fileUuid').val();
							 var url = "<%=path %>/ImpAndExpTempServlet?flag=import&fileUuid="+fileUuid;
							 $('#form0').attr("action", url);
							 $('#form0').submit();	
						 }else{
							 $('#button001').attr("disabled",false);
						 }
					 });
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
