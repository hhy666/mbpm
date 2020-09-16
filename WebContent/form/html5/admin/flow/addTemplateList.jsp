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
<link href='<%=request.getContextPath() %>/resource/html5/css/jquery-editable-select.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/jquery-editable-select.min.js'></script>
<link href='<%=request.getContextPath() %>/resource/html5/css/switchery.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/switchery.min.js'></script>
<style type="text/css">
	select{
	    appearance:none;  
	    -moz-appearance:none;  
	    -webkit-appearance:none;
	    background: url("<%=path %>/image/query.png") no-repeat scroll right center transparent;
	    padding-right: 14px;
	    border: none;			//去边框
		border-bottom: 1px solid #666666;   //设置底部边框
		line-height: 24px;      
	}

	.colorChoose{
		cursor:pointer;
		margin-right:10px;
		display:inline-flex;
		border-radius:50%;
		width:24px;
		height:24px;
	}
	
	.colorChoose:hover{
		width:28px;
		height:28px;
	}
</style>
<script type="text/javascript">

	//颜色初始化
	function colorInit(){
		var type = $('#type').val();
		var color = $('#color').val();
		if(color==null||color==""){
			$('.colorChoose').css('border','0px');
			if(type==2){
				$('.colorChoose.type2').css('border','2px solid black');
				$('#color').val('rgb(91,155,213)');
			}else if(type==3){
				$('.colorChoose.type3').css('border','2px solid black');
				$('#color').val('rgb(130,188,255)');
			}
		}
	}

	$(function(){
		colorInit();
		var templateType = $('#templateType').val();
		
		//颜色选择
		$('.colorChoose').click(function(){
			$('.colorChoose').css('border','0px');
			$(this).css('border','2px solid black');
			var background = $(this).css('background-color');
			$('#color').val(background);
		});
		/*
		if(templateType=="2"){
			$('#color').val('rgb(91, 155, 213)');
		}else if(templateType=="3"){
			$('#color').val('rgb(130, 188, 255)');
		}
		$('#color_select').val('${color}');		
		$('#color_select').css('background','${color}');		
		*/
		
		var addType = '${param.addType }';
		
		//不需要了 先隐藏掉 是否新建子表单
		document.getElementById('tr0031').style.display='none';
		
		//是否显示自定义编码 文本框
		var custom = '${param.custom}';
		if(custom == '1'){
			document.getElementById('custom').checked = true;  //选中复选框
			document.getElementById('custom').value = 1; 
			document.getElementById('tr0033').style.display="";
		}else{
			document.getElementById('tr0033').style.display="none";
		}
		
		var operation = '${operation }';
		
		if(addType == 'dir'){   //添加目录
			document.getElementById('tr0031').style.display='none';
			$("#tr0035").remove();
			document.getElementById('tr0032').style.display='none';   //显示自定义代码功能
			document.getElementById('tr001').style.display='';  //显示基本属性
			document.getElementById('tr0034').style.display='';  //显示高级属性
			document.getElementById('label0033').innerText='模块编码：';
		}else if(addType == 'template'){    //添加模板
			document.getElementById('tr0031').style.display='none';
			$("#tr0035").remove();
			document.getElementById('tr0032').style.display='none';   //隐藏自定义代码功能
			document.getElementById('tr001').style.display='';  //显示基本属性
			document.getElementById('tr0034').style.display='';   //显示高级属性
		}else if(operation == 'update'){     //编辑目录
			document.getElementById('tr0031').style.display='none';
			document.getElementById('tr0032').style.display='none';   //隐藏自定义代码功能
			document.getElementById('tr001').style.display='none';  //隐藏基本属性
			document.getElementById('tr0034').style.display='none';  //隐藏高级属性
			document.getElementById('tr0035').style.display='';  //显示模块编码行
		}
		
		//自定义编码复选框选中
		$("input:checkbox[name='custom']").on('ifChecked', function(event){	
			$('#custom').val(1);
			document.getElementById('tr0033').style.display="";
			var addType = '${param.addType }';
			if(addType=='dir'){
				$('#customId').attr('readonly',false);
			}
		});
		
		//自定义编码复选框取消选中
		$("input:checkbox[name='custom']").on('ifUnchecked', function(event){
			$('#custom').val(2);
			document.getElementById('tr0033').style.display="none";
			if(addType=='dir'){
				$('#customId').attr('readonly',true);
			}
		});
		
		var elem = document.querySelector('.js-switch');
		var init = new Switchery(elem,{size:"small",color:"rgb(91, 155, 213)"});
		
		elem.onchange = function() {
		   if(elem.checked){
			   document.getElementById('tr0032').style.display="";
			   if(document.getElementById('tr0033')){
				   var custom = document.getElementById('custom');
				   if(custom.checked == true){
					   document.getElementById('tr0033').style.display="";
				   }else{
					   document.getElementById('tr0033').style.display="none";
				   }			 				   
			   }
			   if(document.getElementById('tr0035')){
				   document.getElementById('tr0035').style.display="";
			   }
			   if(addType == 'template'){    //添加模板
				   document.getElementById('tr0021').style.display="";
			   }
		   }else{
			   document.getElementById('tr0032').style.display="none";
			   if(document.getElementById('tr0033')){
				   document.getElementById('tr0033').style.display="none";
			   }
			   if(document.getElementById('tr0035')){
				   document.getElementById('tr0035').style.display="none";
			   }
			   if(addType == 'template'){    //添加模板
				   document.getElementById('tr0021').style.display="none";
			   }
		   }
		};
	})
	
	function checkName(){
		var addType = '${param.addType }';
		var operation = '${operation }';
		
		$('#namefont').html("");
		$('#idfont').html("");
		
		
		if($('#name').val() == null || $('#name').val() == ''){
			$('#namefont').html("请输入名称");
		}else{
			var name = $('#name').val();
			var customId = $('#customId').val();  //编码
			
			var custom = document.getElementById('custom').value;  //是否自定义代码  value=1 是
			var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
			
			var jsonData = {};
			jsonData.addType = addType;   //dir添加目录   template添加模板     
			jsonData.operation = operation;  //update编辑目录
			jsonData.custom = custom;
			jsonData.customId = customId;
			jsonData.name = name;
			if(operation == 'update'){  //编辑目录
				var uuid = $('#uuid').val();
				jsonData.uuid = uuid;
			}
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
		var addType = '${param.addType }';
		var operation = '${operation }';
		
		$('#namefont').html("");
		$('#idfont').html("");
		
		if($('#customId').val() == null || $('#customId').val() == ''){
			$('#idfont').html("请输入编码");
		}else{
			var name = $('#name').val();
			var customId = $('#customId').val();  //编码
			
			var custom = document.getElementById('custom').value;  //是否自定义代码  value=1 是
			var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
			var jsonData = {};
			jsonData.addType = addType;   //dir添加目录   template添加模板     
			jsonData.operation = operation;  //update编辑目录
			jsonData.custom = custom;
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
			var addType = '${param.addType }';
			if(addType='dir'){
				$('#customId').attr('readonly',false);
			}
		}else{
			document.getElementById('tr0033').style.display="none";
			checkbox.value = 2;   //取消选择改变值
			if(addType='dir'){
				$('#customId').attr('readonly',true);
			}
			
		}
	}
	
	function controlHidden(){
		$('#tr0032').slideToggle(200,function(){
			if($('#tr0032').is(':hidden')){
				$('#toolBarItem001 > span').attr("class", "glyphicon glyphicon-chevron-up");
			}else{
				$('#toolBarItem001 > span').attr("class", "glyphicon glyphicon-chevron-down")  
			}
		});
		$('#tr0021').slideToggle(200,function(){
			if($('#tr0021').is(':hidden')){
				$('#toolBarItem001 > span').attr("class", "glyphicon glyphicon-chevron-up"); 
			}else{
				$('#toolBarItem001 > span').attr("class", "glyphicon glyphicon-chevron-down")
			}
		});
	}
	
	//弹出共享数据源表单窗口
	function openShareForm(){
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'shareForm',
			type : 2,
			
			title : ['选择表单'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '30%', '50%' ],
			content : '<%=path %>/editor/common/selectFormTree.jsp?iframewindowid=shareForm&rootMid=flowdesign&rootEntityId=flowRoot'
		});
	}
	
	//选择共享数据源表单窗口回调   给formId赋值  给目标表单加option
	function onshareFormClose(record){
		if(record!=null && record!=""){
			var name = record.name;   //表单名称
			var id = record.id;   //表单编码
			$('#shareFormName').val(name);
			$('#shareFormId').val(id);
		}
	}
	
	//清除已选择的共享数据源表单
	function clearShareForm(){
		$('#shareFormName').val('');
		$('#shareFormId').val('');
	}
</script>
</head>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" id="color" name="color" value="${color}">
			<input type="hidden" id="type" name="type" value="${param.type}">
			<input type="hidden" id="shareFormId" name="shareFormId">
			<input type="hidden" name="form0" value="form0" />
			
			<div style="height:calc(100% - 54px);width: 100%;overflow: auto;">
				<table id="table001" class="tableLayout" style="width: 100%;">
					<tr id="tr001">
	  					<td id="td009" class="tdLayout" colspan="2" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
	  						<div style="text-align: left;padding-left: 10px;">
	  							<label>基本属性</label>			
	  						</div>				
						</td>
	  				</tr>
					<tr id="tr002">
						<td id="td003" class="tdLayout"
							style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
							id="label002" name="label002" id="label002" class="control-label ">
								名称：</label></td>
						<td id="td004" class="tdLayout" style="width: 100%;"><div
								id="input002_div" class="input-group col-md-12 "
								style="display: inline-table; vertical-align: middle; width: 100%;">
								<input id="name" name="name" type="text" value="${templateName }"
									class="form-control "
									style="width: 100%; height: 100%; padding-left: 5px;"
									autocomplete="off" onblur="checkName();">
							</div> <font id="namefont" color="red">${requestScope.nameEchoMessage }</font>
						</td>
					</tr>
					<tr id="tr0031" style="display:none;">
						<td id="td0051" class="tdLayout"
							style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
							name="label0031" id="label0031" class="control-label ">
								是否新建表单：</label></td>
						<td id="td0061" class="tdLayout" style="width: 60%;">
							<div class="form-group;" style="display: inline-table;">
								&nbsp;<input type="checkbox" class="box" id="checkBox001"
									name="subItems" checked="checked"
									style="position: absolute; opacity: 0;" value="1" />
							</div>
						</td>
					</tr>
					<tr id="tr0035" style="display:none">
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">模块编码：</label>
						</td>
						<td class="tdLayout" style="width: 100%;">
							<div id="input002_div" class="input-group col-md-12" style="display: inline-table; vertical-align: middle; width: 100%;">
								<input readonly="readonly" id="customId" name="customId" type="text" value="${uuid}" class="form-control" style="width: 100%; height: 100%; padding-left: 5px;" autocomplete="off" onblur="checkId();">
							</div>
							<font id="idfont" color="red">${requestScope.idEchoMessage }</font>
						</td>
					</tr>
					<tr>
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">颜色：</label>
						</td>
						<td class="tdLayout" style="padding-left:10px;width: 60%;vertical-align: bottom;position: relative;">
								<%-- <input type="text" id="label_Color" name="color" style="width:220px;" value="${color}!=null?{color}:'#82bcff'" class="form-control"> --%>
							<!-- <select id="color_select" id="label_Color" style="width:80%" class="form-control select2-accessible">
								<option value="rgb(0, 0, 0)">rgb(0, 0, 0)</option>
								<option value="rgb(231, 230, 230)">rgb(231, 230, 230)</option>
								<option value="rgb(68, 84, 106)" >rgb(68, 84, 106)</option>
								<option value="rgb(91, 155, 213)">rgb(91, 155, 213)</option>
								<option value="rgb(237, 125, 49)">rgb(237, 125, 49)</option>
								<option value="rgb(165, 165, 165)">rgb(165, 165, 165)</option>
								<option value="rgb(255, 192, 0)">rgb(255, 192, 0)</option>
								<option value="rgb(68, 114, 196)">rgb(68, 114, 196)</option>
								<option value="rgb(255, 0, 0)">rgb(255, 0, 0)</option>
							</select> -->
							<div class="colorChoose type2" style="border:2px solid black;background:rgb(91,155,213)"></div>
							<div class="colorChoose" style="background:rgb(249,109,100)"></div>
							<div class="colorChoose" style="background:rgb(13,179,166)"></div>
							<div class="colorChoose" style="background:rgb(245,197,71)"></div>
							<div class="colorChoose" style="background:rgb(172,146,236)"></div>
							<div class="colorChoose type3" style="background:rgb(130,188,255)"></div>
						</td>
	  				</tr>
					<tr id="tr003">
						<td id="td005" class="tdLayout"
							style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)"><label
							id="label003" name="label003" id="label003" class="control-label ">
								备注：</label></td>
						<td id="td006" class="tdLayout" style="height:108px;width: 60%;"><div
								id="inputTextArea001_div" class="col-md-12 input-group "
								style="height: 100%;width: 100%;">
								<textarea id="desc" name="desc" class="form-control "
									style="width: 100%; height: 100%;resize: none;">${templateDesc }</textarea>
							</div></td>
					</tr>
					<tr id="tr0034">
	  					<td id="td008" class="tdLayout" colspan="2" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
	  						<div style="text-align: left;padding-left: 10px;">
	  							<label>高级属性</label>
	  							<!--  
								<button type="button" id="toolBarItem001" class="x-btn cancel-btn toolBarItem" onclick="controlHidden();">
									<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
								</button>
								-->
								<input type="checkbox" class="js-switch"/>
	  						</div>				
						</td>
	  				</tr>
	  				<tr id="tr0032" style="display:none;">
						<td id="td0052" class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label">自定义编码：</label>
						</td>
						<td id="td0062" class="tdLayout" style="width: 60%;">
							<div class="form-group;" style="display: inline-table;margin-left: 3px;" name="checkBox002_div" id="checkBox002_div" >
								<input type="checkbox" name="custom" id="custom" onchange="customChange(this);" value="2" class="box"/>
							</div>
						</td>
					</tr>
					<tr id="tr0033" style="display:none">
						<td id="td0053" class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label	name="label0033" id="label0033" class="control-label ">表单编码：</label>
						</td>
						<td id="td0063" class="tdLayout" style="width: 100%;">
							<div id="input002_div" class="input-group col-md-12" style="display: inline-table; vertical-align: middle; width: 100%;">
								<input id="customId" name="customId" type="text" value="${uuid}" class="form-control" style="width: 100%; height: 100%; padding-left: 5px;" autocomplete="off" onblur="checkId();">
							</div>
							<font id="idfont" color="red">${requestScope.idEchoMessage }</font>
						</td>
					</tr>
	  				<tr id="tr0021" style="display:none;">
						<td id="td0031" class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<labelclass="control-label ">共享数据源表单：</label>
						</td>
						<td id="td0041" class="tdLayout" style="width: 60%;">
							<div id="formValue_div" class="input-group">
								 <input type="text" id="shareFormName" name="shareFormName" value=""  placeholder="请选择表单" class="form-control" readonly="readonly" >
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openShareForm();" style="border-left: 0px;border-radius: 0px"><i class="fa fa-search"></i></span>
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="clearShareForm();" style="border-radius: 0px"><i class="fa fa-times"></i></span>
							</div>			
						</td>
					</tr>
				</table>
			</div>
			
			<div class="cmdLayout">
						<button type="button" id="button001" class="x-btn ok-btn ">保存</button>
						<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>

						<input id="templateType" type="hidden" name="templateType"
						value='${param.type}' /> <input id="parentId" type="hidden" name="parentId"
						value="${param.parentId }" /> <input id="uuid" type="hidden"
						name="uuid" value="${uuid }"> 
						<input id="tempCls" type="hidden" name="tempCls" value="${param.tempCls }">
						<input id="type" type="hidden" name="type" value="${param.type }">
						<script>
		$('#button001').click(function(){
			//设置确定按钮不可用  防止重复提交
			$('#button001').attr("disabled",true);
			
			var addType = '${param.addType }';
			var operation = '${operation}';
			var name = $('#name').val();  //名称
			var customId = $('#customId').val();  //编码
			var custom = document.getElementById('custom').value;  //是否自定义编码 value=1 是
			
			if(name.length<0 || name.length>40){
				Matrix.warn('名称长度不符合标准！');
				$('#button001').attr("disabled",false);
				return;
			}
			
			$('#namefont').html("");
			$('#idfont').html("");
			if(addType == 'dir' || addType == 'template'){   //添加目录  | 添加协同事项
				var flag1 =false;
				var flag2 =false;
				
				if(name == null || name == ''){
					$('#namefont').html("请输入名称");
				}else{
					flag1 = true;
				}
				if(custom == 1 && (customId == null || customId == '')){
					$('#idfont').html("请输入编码");
				}else{
					flag2 = true;
				}
				if(!(flag1 & flag2)){
					$('#button001').attr("disabled",false);
					return;
				}
				
				var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
				var jsonData = {};
				jsonData.addType = addType;   //dir添加目录   template添加模板     
				jsonData.operation = operation;  //update编辑目录
				jsonData.custom = custom;
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
					
					if($('#namefont').html() == '' && $('#idfont').html() == ''){ 
						if(addType == 'dir'){   //添加目录  
							$("#form0").attr("action", "<%=request.getContextPath()%>/templet/tem_h5AddData.action");
							$('#form0').submit();
						}else if(addType == 'template'){  //添加模板
							$("#form0").attr("action", "<%=request.getContextPath()%>/templet/tem_h5AddTemplateData.action");
							$('#form0').submit();
						}
					}else{
						$('#button001').attr("disabled",false);
					}
				});
				
			}else if(operation == 'update'){   //编辑目录
				if(name == null || name == ''){
					$('#namefont').html("请输入名称");
					$('#button001').attr("disabled",false);
					return;
				}
				var uuid = $('#uuid').val();
				var url="<%=request.getContextPath()%>/templet/tem_copyBefore.action";	
				var jsonData = {};
				jsonData.addType = addType;   //dir添加目录   template添加模板     
				jsonData.operation = operation;  //update编辑目录
				jsonData.customId = customId;
				jsonData.name = name;
				jsonData.uuid = uuid;
				Matrix.sendRequest(url,jsonData,function(data){
					var callbackStr = data.data;
				    var callbackJson = isc.JSON.decode(callbackStr);
				    
				    var nameMessage = callbackJson.nameMessage;
					$('#namefont').html(nameMessage);
					
					if($('#namefont').html() == ''){ 
						$("#form0").attr("action", "<%=request.getContextPath()%>/templet/tem_h5EditData.action");
						$('#form0').submit();
					}else{
						$('#button001').attr("disabled",false);
					}
				});    
			}
		});

							$('#button002').click(
									function() {
										var index = parent.layer
												.getFrameIndex(window.name);
										parent.layer.close(index);
									});
						</script>
				</div>
		</form>
	</div>
</body>
</html>
