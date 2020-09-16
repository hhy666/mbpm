<%@page  import="java.util.*" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
    <jsp:include page="/foundation/common/taglib.jsp" />
	<jsp:include page="/foundation/common/resource.jsp" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resource/css/formulaset.css"/>
	<script type="text/javascript">
		window.onload = function(){
			document.getElementById("formulaStr").value="${firstCondition}";
		}
		
		var typeJsonStr = "${typeJsonStr}";
		var typeJsonObj = eval("("+typeJsonStr+")");
		
		var depVariable = [];
		for(var key in typeJsonObj){
			if(typeJsonObj[key]==25 ||typeJsonObj[key]==26){
				depVariable.push(key);
			}
		}
		
		var optionJsonStr = "${optionJsonStr}";   
		
		function getDepVariable(){
			return JSON.stringify(depVariable); ;
		}
	
		function changeClass(element){
			var lis = document.getElementsByTagName("li");
			var i = 0;
			for(;i < lis.length; i++){
				lis[i].className = "";
			}
			var li = element.parentNode;
			li.className="current";
			
			var selects = document.getElementsByTagName("select");
			var j = 0;
			for(;j < selects.length; j++){
				selects[j].style.display = 'none';
			}
			if(li.id == 'field_li'){
				document.getElementById('fieldSelect').style.display='';
			}
			if(li.id == 'org_li'){
				document.getElementById('orgSelect').style.display='';
			}
			if(li.id == 'date_li'){
				document.getElementById('dateSelect').style.display='';
			}
			if(li.id == 'system_li'){
				document.getElementById('systemSelect').style.display='';
			}
		}
		function dblClickField(selection){
			var value ;
			if(selection.type == 'select-multiple'){
				var index =  selection.selectedIndex;
				value = selection.options[index].text;
				value = "{" + value + "}";//防止编码与值互相转换时有包含字符替换错误
			}else if(selection.type == 'select-one'){
				var index =  selection.selectedIndex;
				value = selection.options[index].text;
				value = "[" + value + "]";
			}else{
				value = selection.value;
			}
		  	var obj = document.getElementById("formulaStr");
		  	if(document.selection){
		  		var sel = document.selection.createRange(); 
		  		sel.text = value; 
		  	}else if(typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number'){
		  		var startPos = obj.selectionStart, 
					endPos = obj.selectionEnd, 
					cursorPos = startPos, 
					tmpStr = obj.value; 
		  		if(tmpStr == ""){
		  			cursorPos += value.length;
		  			obj.value = value + tmpStr.substring(endPos, tmpStr.length); 
		  		}else{
		  			obj.value = tmpStr.substring(0, startPos) + " " + value + tmpStr.substring(endPos, tmpStr.length); 
		  			cursorPos += value.length+1; 
		  		}
		  		obj.selectionStart = obj.selectionEnd = cursorPos; 
		  	}else{
		  		obj.value += value; 
		  	}
		  	obj.focus();
		  }
		  
		  function clearTextArae(){
		  	var obj = document.getElementById("formulaStr");
		  	obj.value = "";
		  }
		  
		  function doit(opration){
		  	var obj = document.getElementById("formulaStr");
		  	if(document.selection){
		  		var sel = document.selection.createRange(); 
		  		sel.text = opration; 
		  	}else if(typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number'){
		  		var startPos = obj.selectionStart, 
					endPos = obj.selectionEnd, 
					cursorPos = startPos, 
					tmpStr = obj.value; 
		  		if(tmpStr == ""){
		  			cursorPos += opration.length;
		  			obj.value = opration + tmpStr.substring(endPos, tmpStr.length); 
		  		}else{
		  			obj.value = tmpStr.substring(0, startPos) + " " + opration + tmpStr.substring(endPos, tmpStr.length); 
		  			cursorPos += opration.length+1; 
		  		}
		  		obj.selectionStart = obj.selectionEnd = cursorPos; 
		  	}else{
		  		obj.value += opration; 
		  	}
		  	obj.focus();
		  }
		  
		  function more(){
		  	var morelable = document.getElementById('morelable');
		  	var lesslable = document.getElementById('lesslable');
		  	var others = document.getElementById('others');
		  	morelable.style.display = 'none';
		  	lesslable.style.display = '';
		  	others.style.display = '';
		  }
		  function less(){
		  	var morelable = document.getElementById('morelable');
		  	var lesslable = document.getElementById('lesslable');
		  	var others = document.getElementById('others');
		  	morelable.style.display = '';
		  	lesslable.style.display = 'none';
		  	others.style.display = 'none';
		  }
		  function closeWindow(){
		  	Matrix.closeWindow();
		  }
		  
		  //求日期差
		  function getDaySub(){
		  	Matrix.showWindow('daySub');
		  }
		  function ondaySubClose(data){
		  	if(data != null){
			  	dblClickField(data);
		  	}
		  }
		  //取年  取月 取日 取星期几
		  function showGet(type){
		  	if(type == 'year'){
		  		Mget.setTitle('取年');
		  		Matrix.setFormItemValue('type','year');
		  	}
		  	
		  	if(type == 'month'){
		  		Mget.setTitle('取月');
		  		Matrix.setFormItemValue('type','month');
		  	}
		  	
		  	if(type == 'day'){
		  		Mget.setTitle('取日');
		  		Matrix.setFormItemValue('type','day');
		  	}
		  	
		  	if(type == 'weekDay'){
		  		Mget.setTitle('取星期几');
		  		Matrix.setFormItemValue('type','weekDay');
		  	}
		  	
		  	if(type == 'season'){
		  		Mget.setTitle('取季');
		  		Matrix.setFormItemValue('type','season');
		  	}
		  	
		  	if(${param.sign=='utili'}){
		  	Mget.initSrc = "<%=request.getContextPath()%>/utilization/form_getYMDW.action?formId=${param.formId}&isYMDW=1";
			Mget.src = "<%=request.getContextPath()%>/utilization/form_getYMDW.action?formId=${param.formId}&isYMDW=1";
			}
		  	Matrix.showWindow('get');
		  }
		  function ongetClose(data){
		  	var type = Matrix.getFormItemValue('type');
		  	if(data != null){
		  		data.value = type + data.value;
		  		dblClickField(data);
		  	}
		  }
		  
		  function addSpace(value){  //操作按钮选择后加空格
			  var obj = document.getElementById("formulaStr");
			  
			  var startPos = obj.selectionStart,
			  endPos = obj.selectionEnd, 
			  cursorPos = startPos, 
			  tmpStr = obj.value; 
			  if(tmpStr == ""){
				  obj.value = value + tmpStr.substring(endPos, tmpStr.length);
				  cursorPos += value.length;
			  }else{
				  obj.value = tmpStr.substring(0, startPos) + " " + value + tmpStr.substring(endPos, tmpStr.length);
				  cursorPos += value.length+1;
			  } 
  			  obj.selectionStart = obj.selectionEnd = cursorPos; 
  			  obj.focus();
		  }
		  
		  //单选部门
		   function showDep(){
			  layer.open({
			    	id:'layer05',
					type : 2,
					
					title : ['设置部门条件'],
					closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '80%', '80%' ],
					content : "<%=path%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer05"
				});

		  }
		  //单选角色
		  function showRole(){
			  layer.open({
			    	id:'layer06',
					type : 2,
					
					title : ['设置部门条件'],
					closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '80%', '80%' ],
					content : "<%=path%>/office/html5/select/SingleSelectRole.jsp?iframewindowid=layer06"
				});

		  }
		  //单选人员
		   function showPerson(){
			  layer.open({
			    	id:'layer04',
					type : 2,
					
					title : ['设置部门条件'],
					closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '80%', '90%' ],
					content : "<%=path%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layer04"
				});

		  }
		   //当前部门
		   function showCurrentDep(){
			   layer.open({
			    	id:'layer08',
					type : 2,
					
					title : ['设置部门条件'],
					closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '80%', '80%' ],
					content : "<%=path%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer08"
				});
		   }
		  
		  //单选部门回调
		   function onlayer05Close(data){
				if(data!=null){
					var name = data.names;
					var prefixName="";
        			var obj = document.getElementById("formulaStr");
        			if(obj==null || obj==''){
        				obj = "";
        			}
        			prefixName=prefixName+"{部门(";
        			prefixName=prefixName+name;
        			prefixName=prefixName+")}";
        			addSpace(prefixName)
				}
		   }
		  //单选角色回调
		   function onlayer06Close(data){
				if(data!=null){
					var name = data.names;
					var prefixName="";
        			var obj = document.getElementById("formulaStr");
        			if(obj==null || obj==''){
        				obj = "";
        			}
        			prefixName=prefixName+"{角色(";
        			prefixName=prefixName+name;
        			prefixName=prefixName+")}";
        			addSpace(prefixName)
				}
		   }
		  //单选人员回调
		   function onlayer04Close(data){
				if(data!=null){
					var name = data.names;
					var prefixName="";
        			var obj = document.getElementById("formulaStr");
        			if(obj==null || obj==''){
        				obj = "";
        			}
        			prefixName=prefixName+"{人员(";
        			prefixName=prefixName+name;
        			prefixName=prefixName+")}"
        			addSpace(prefixName)
				}
		 }
		   //当前部门回调
			 function onlayer08Close(data){
				 if(data!=null){
					var name = data.names;
					var prefixName="";
	     			var obj = document.getElementById("formulaStr");
	     			if(obj==null || obj==''){
	     				obj = "";
	     			}
	     			prefixName=prefixName+"{当前部门(";
	     			prefixName=prefixName+name;
	     			prefixName=prefixName+")}";
	     			
	     			addSpace(prefixName);
				}
			 } 
		  
		  
		  //多选包含部门
		  function showMultiDep(){
			  layer.open({
			    	id:'layer01',
					type : 2,
					
					title : ['设置部门条件'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '90%', '90%' ],
					content : "<%=path%>/editor/common/selectCondition.jsp?iframewindowid=layer01&condition=depCondition"
				});

		  }
		  //多选包含角色
		  function showMultiRole(){
				layer.open({
			    	id:'layer02',
					type : 1,
					
					title : ['设置角色条件'],
					closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '90%', '90%' ],
					content : "<%=path%>/editor/common/selectCondition.jsp?iframewindowid=layer02&condition=roleCondition"
				});
		  }
		  
		  //多选选择部门回调
		  function onlayer01Close(data){
				if(data!=null){
					var name = data.name;
        			var obj = document.getElementById("formulaStr");
        			if(obj==null || obj==''){
        				obj = "";
        			}
        			addSpace(name);
				}
			
		 }
		  //多选选择角色回调
		  function onlayer02Close(data){
			   if(data!=null){
				 var name = data.name;
		      		var id = data.id;
		      		var obj = document.getElementById("formulaStr");
	      			if(obj==null || obj==''){
	      				obj = "";
	      			}
	      			addSpace(name);
			  }
		  }
		  //获得optionJsonStr
		  function getOptionJsonStr(){
			  return optionJsonStr;
		  }
		  
		  
		  //选中的表单数据域类型
		  function checkvalue(){
			  if(document.getElementById('fieldSelect').style.display==""){
				  var select=document.getElementById("fieldSelect");
				  var index = select.selectedIndex;
				  var value=select.options[index].text;   //选中的表单数据域
			  }
			  if(document.getElementById('orgSelect').style.display==""){
				  var select=document.getElementById("orgSelect");
				  var index = select.selectedIndex;
				  var value=select.options[index].text;   //选中的表单数据域
			  }
			  if(document.getElementById('dateSelect').style.display==""){
				  var select=document.getElementById("dateSelect");
				  var index = select.selectedIndex;
				  var value=select.options[index].text;   //选中的表单数据域
			  }
			  return value;
		  }
		  
		  //流水号
		  function showSerialNumber(){
			  layer.open({
			    	id:'layer07',
					type : 2,
					
					title : ['设置流水号'],
					closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '85%', '65%' ],
					content : "<%=path%>/office/html5/select/SelectSerialNumber.jsp?iframewindowid=layer07"
			  });
		  }
		  //流水号选中回调
		  function onlayer07Close(data){
			  if(data!=null){
				 var name=data.name;
			  }else{
				  return;
			  }
			  var obj = document.getElementById("formulaStr");
    		  if(obj==null || obj==''){
    			  obj = "";
    		  }
    		  addSpace(name);
		  }
		  
		  
		  
		  //Extend选项
		  function showExtend(){
			  if(document.getElementById('fieldSelect').style.display==""){
				  var select=document.getElementById("fieldSelect");
				  var index = select.selectedIndex;
				  if(index == -1){
					 layer.alert("请选择表单域！",{icon: 2});
				  	 return;
				  }
				  var value=select.options[index].text;   //选中的表单数据域
				  var editorType = typeJsonObj[value];    //表单数据类型
				  layer.open({
				    	id:'layer03',
						type : 2,
						
						title : ['Extend设置'],
						//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
						shadeClose: false, //开启遮罩关
						area : [ '80%', '91%' ],
						content : "<%=path%>/editor/common/extend.jsp?iframewindowid=layer03&editorType="+editorType
				  });
				  
			  }			  
			  if(document.getElementById('orgSelect').style.display==""){
				  layer.alert("请选择表单域！",{icon: 2});
				  return;
			  }			   
			  if(document.getElementById('dateSelect').style.display==""){
				  layer.alert("请选择表单域！",{icon: 2});
				  return;
			  }
  
		  }
		  
		  //extend选中数据回调
		  function onlayer03Close(data){
			  if(data!=null){
				  var name=data.name;
				  var obj = document.getElementById("formulaStr");
      			  if(obj==null || obj==''){
      				obj = "";
      			  }
      			addSpace(name);
			  }
		  }
		  
		  
		  function showIncluding(type){ //显示包含或不包含窗口
		  	 var select = document.getElementById('fieldSelect');
		  	 var index = select.selectedIndex;
		  	 if(index == -1){
		  	 	warn('请选择文本类型的字段');
		  	 	return;
		  	 }
		  	 var value = select.options[index].value;
		  	 var text = select.options[index].text;
		  	 var editorType = typeJsonObj[value];
		  	 if(editorType == '' || editorType != '1'){
		  	 	warn('请选择文本类型的字段');
		  	 }else{
		  	 	Mincluding.initSrc = "<%=request.getContextPath()%>/form/admin/custom/queryList/including.jsp?formId=${param.formId}&type="+type+"&text="+text;
		  	 	Matrix.showWindow('including');
		  	 }
		  }
		  function onincludingClose(data){
		  	if(data != null){
		  		dblClickField(data);
		  	}
		  }
		  function getDate(){
		  	 var select = document.getElementById('fieldSelect');
		  	 var index = select.selectedIndex;
		  	 if(index == -1){
		  	 	warn('请选择日期类型的字段');
		  	 	return;
		  	 }
		  	 var value = select.options[index].value;
		  	 var text = select.options[index].text;
		  	 var editorType = typeJsonObj[value];
		  	 if(editorType == '' || editorType != '2'){
		  	 	warn('请选择日期类型的字段');	
		  	 }else{
		  	 	var data = {};
		  	 	data.value = "date({";
		  	 	data.value += text;
		  	 	data.value += "})";
		  	 	dblClickField(data);
		  	 }
		  }
		  function getTime(){
		  	 var select = document.getElementById('fieldSelect');
		  	 var index = select.selectedIndex;
		  	 if(index == -1){
		  	 	warn('请选择时间类型的字段');
		  	 	return;
		  	 }
		  	 var value = select.options[index].value;
		  	 var text = select.options[index].text;
		  	 var editorType = typeJsonObj[value];
		  	 if(editorType == '' || editorType != '3'){
		  	 	warn('请选择时间类型的字段');	
		  	 }else{
		  	 	var data = {};
		  	 	data.value = "date({";
		  	 	data.value += text;
		  	 	data.value += "})";
		  	 	dblClickField(data);
		  	 }
		  }
		  function inOperate(){
		  	 var select = document.getElementById('fieldSelect');
		  	 var index = select.selectedIndex;
		  	 if(index == -1){
		  	 	warn('请选择时间类型的字段');
		  	 	return;
		  	 }
		  	 var value = select.options[index].value;
		  	 var text = select.options[index].text;
		  	 var editorType = typeJsonObj[value];
		  	 if(editorType == '' || editorType != '1'){
		  	 	warn('请选择文本类型的字段');	
		  	 }else{
		  	 	var data = {};
		  	 	data.value = "in ({";
		  	 	data.value += text;
		  	 	data.value += "},())";
		  	 	dblClickField(data);
		  	 }
		  }
		 
		  function evalValue(){
		  		//获得文本域中的已有的值
			  	var condition = document.getElementById('formulaStr').value;
			  	if(condition == ''||condition==null){
			  		var newdata=null;
			  		Matrix.closeWindow(newdata);
			 		return;
			  	}
			  	var x = ["==",">",">=","<","=<","like","not_like","include","in","isNull(","isNotNull(","true","ifAnyRow","ifAllRow","{部门包含","{部门不包含","{角色包含","{角色不包含","部门包含","人员包含","角色包含"];
			  	var flag = true;
			  	for(var i=0; i<x.length&&flag; i++){
			  		if(condition.contains(x[i])){
			  			flag = false;
			  		}
			  	}
		
			  	if(flag){
			  		alert("未包含条件运算符：(==|>|>=|<|=<|like|not_like|include|in|ifAllRow|ifAnyRow|部门包含|部门不包含|角色包含|角色不包含|人员包含)");
			  		return;
			  	}
			  	if(condition.contains('"')){
			  		alert('不能包含英文双引号');
			  		return;
			  	}
			  	if(condition.contains('“')){
			  		alert('不能包含中文双引号');
			  		return;
			  	}
			  	if(condition.contains('”')){
			  		alert('不能包含英文双引号');
			  		return;
			  	}
			  	if(condition.contains('‘')){
			  		alert('不能包含中文单引号');
			  		return;
			  	}
			  	if(condition.contains('’')){
			  		alert('不能包含中文单引号');
			  		return;
			  	}
			  	
			  	/*var conditionArr = condition.split(";");//把不同的条件切分开
				for(var i = 0;i<conditionArr.length;i++){
				  	var array = conditionArr[i].split(" ");
				  	if(array.length<3){
				  		warn("请在每个运算符(=|>|>=|<|=<|like|not_like|include|in|部门包含|部门不包含|角色包含|角色不包含)两侧空一格!");
				  		return ;
				  	}	
				}*/	
			  	
			  	var url = "<%=request.getContextPath()%>/trigger/conditionTrans_outToIn.action";
				var param = '{"condition":"'+condition+'"}';
				var synJson = isc.JSON.decode(param);
				Matrix.sendRequest(url,synJson,function(data){
					var result = data.data;
					Matrix.closeWindow(result);
				});
		  }
	</script>
  </head>
  
  <body>
  	<input id="type" name="type" type="hidden"/> <!-- 区分是取年 还是取日 还是取月 -->
  	<input id="including" name="including" type="hidden"/> <!-- 区分是包含还是不包含 -->
  	<input id="formId" name="formId" type="hidden" value="${param.formId}"/> 
    <div style="width: 100%; height: 90%;margin-top:8px;" class="font_size12" align="center">
			<div id="modelSet" style="height: 100%; line-height: 50px;">
				<div id="model1" style="display: ''">
					<form id="formulaForm">
						<div style="width: 95%; height: 90px;">
							<textarea id="formulaStr" name="formulaStr"
								style="width: 100%; height: 90px;"></textarea>
						</div>
						<div style="width: 100%; height: 30px; margin-top: 10px;">
							<div style="float: left; margin-left: 5px;height:35px;">
								双击选中数据域到公式框
							</div>
							<div style="float: right;">
								<a id="btnreset" class="common_button common_button_gray"
									href="javascript:void(0);" onclick="clearTextArae()">重置</a>
								<a id="helpbutton" class="common_button common_button_gray"
									href="javascript:void(0);" onclick="">帮助</a>
							</div>
						</div>

						<div style="width:100%;height:calc(100% - 130px);margin-top: 10px;">
							<div style="height: 300px; width: 60%;float: left;" class="left"
								id="dataDiv">
								<div id="tabs" style="width: 99%;">
									<div id="tabs_head" class="common_tabs clearfix"
										style="width: 99%;">
										<ul class="left" style="float:left" >
											<li id="field_li" class="current">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="表单数据域">
														表单数据域 </span> </a>
											</li>
											
											<li id="org_li" class="">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="组织机构变量">
														组织机构变量</span> </a>
											</li>
											<li id="date_li" class="">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="日期变量">
														日期变量 </span> </a>
											</li>
										</ul>
									</div>
									<div id="tabs_body" class="common_tabs_body"
										style="width: 99%; ">
										<div id="field_div" class="show" style="">
											<select id="fieldSelect" class="w100b"
												ondblclick="dblClickField(this)" style="height:80%;display:'';"
												name="fieldSelect" multiple="multiple">
												<c:forEach var="text" items="${entVal}">
													<option value="${text}">${text}</option>
												</c:forEach>
											</select>
											
											<select id="orgSelect" class="w100b" ondblclick="dblClickField(this)" size="15" name="orgSelect" style="display:none;">
												<c:forEach var="orgVar" items="${orgVars}">
													<option value="${orgVar}">${orgVar}</option>
												</c:forEach>
											</select>
											<select id="dateSelect" class="w100b" ondblclick="dblClickField(this)" size="15" name="dateSelect" style="display:none;">
												<c:forEach var="dateVar" items="${dateVars}">
													<option value="${dateVar}">${dateVar}</option>
												</c:forEach>
											</select>
											
										</div>
									</div>
								</div>
							</div>
							<div id="functionarea" class="right"
								style="width: 40%;height:85%; margin-top: 10px; overflow: auto;">
								<div style="overflow: visible;">
									<div class="clearfix" style="width:100%">  <!-- + - * / 块 -->
										<div id="addButton" class="left margin_l_10" width="25%">
											<a id="add" class="form_btn" onclick="doit('+')"
												href="javascript:void(0)"> <span class="plus_16"></span>
											</a>
										</div>
										<div id="minusButton" class="left margin_l_10" width="25%">
											<a id="minus" class="form_btn" onclick="doit('-')"
												href="javascript:void(0)"> <span class="minus_16"></span>
											</a>
										</div>
										<div id="multiplyButton" class="left margin_l_10" width="25%">
											<a id="multiply" class="form_btn" onclick="doit('*')"
												href="javascript:void(0)"> <span class="multiply_16"></span>
											</a>
										</div>
										<div id="divisionButton" class="left margin_l_10" width="25%">
											<a id="division" class="form_btn" onclick="doit('/')"
												href="javascript:void(0)"> <span class="divide_16"></span>
											</a>
										</div>
									</div>
									<div class="clearfix margin_t_10" style="width:100%">  <!-- ( ) 块 -->
										<div id="bracketLeftButton" class="left margin_l_10"
											width="25%">
											<a id="bracketLeft" class="form_btn" onclick="doit('(')"
												href="javascript:void(0)"> <span class="brackl_16"></span>
											</a>
										</div>
										<div id="bracketRightButton" class="left margin_l_10">
											<a id="bracketRight" class="form_btn" onclick="doit(')')"
												href="javascript:void(0)"> <span class="brackr_16"></span>
											</a>
										</div>
									</div>
									<div class="margin_t_10 align_left" >  <!-- 分界线块  -->
										<hr
											style="height: 1px; color: #CCCCCC;  width: 80%; text-align: left;">
									</div>
									<div class="clearfix" style="width:100%">
										<div class="clearfix margin_t_10">  <!-- 不等号块 -->
											<div id="bigthanButton" class="left margin_l_10" width="25%">
												<a class="form_btn" onclick="doit('>')" href="javascript:void(0)">
													<span class="gt_16"></span>
												</a>
											</div>
											<div id="bigAndEqualButton" class="left margin_l_10" width="25%">
												<a class="form_btn" onclick="doit('>=')" href="javascript:void(0)">
													<span class="gt_eq_16 w32 "></span>
												</a>
											</div>
											<div id="smallthanButton" class="left margin_l_10" width="25%">
												<a class="form_btn" onclick="doit('<')" href="javascript:void(0)">
													<span class="lt_16"> </span>
												</a>
											</div>
											<div id="smallAndEqualButton" class="left margin_l_10" width="25%">
												<a class="form_btn" onclick="doit('<=')" href="javascript:void(0)">
													<span class="lt_eq_16 w32"> </span>
												</a>
											</div>
										</div>
										<div class="clearfix margin_t_10">
											<div id="equalButton" class="left margin_l_10" width="25%">
												<a class="form_btn" onclick="doit('==')" href="javascript:void(0)">
													<span class="equal_16"></span>
												</a>
											</div>
											<div id="notEqualButton" class="left margin_l_10">
												<a class="form_btn" onclick="doit('<>')" href="javascript:void(0)">
													<span class="brack_angle_16 w32"> </span>
												</a>
											</div>
											<div id="extendButton" class="left margin_l_10">
												<a class="form_btn w75" onclick="showExtend();" title="" href="javascript:void(0)">扩 展</a>
											</div>
										</div>
										<div class="clearfix margin_t_10">
											<div id="depButton" class="margin_l_10 left">
												<a class="form_btn w32" onclick="showDep();" title="" href="javascript:void(0)">部门</a>
											</div>
											<div id="roleButton" class="margin_l_10 left">
												<a class="form_btn w32" onclick="showRole();" title="" href="javascript:void(0)">角色</a>
											</div>
											<div id="roleButton" class="margin_l_10 left">
												<a class="form_btn w32" onclick="showPerson();" title="" href="javascript:void(0)">人员</a>
											</div>
											<div id="depButton" class="margin_l_10 left" style="display: none;">
												<a class="form_btn w75" onclick="showCurrentDep();" title="" href="javascript:void(0)">当前部门</a>
											</div>
										</div>
										<div class="clearfix margin_t_10">
											<div id="likeButton" class="margin_l_10 left">
												<a class="form_btn w32" onclick="showIncluding('like');" title="like({表单数据域},‘字符串’)" href="javascript:void(0)">包含</a>
											</div>
											<div id="notlikeButton" class="left margin_l_10">
												<a class="form_btn w75" onclick="showIncluding('not_like');" title="not_like({表单数据域},‘字符串’)" href="javascript:void(0)">不包含</a>
											</div>
											<div id="notlikeButton" class="left margin_l_10">
												<a class="form_btn w75" onclick="showSerialNumber();" title="" href="javascript:void(0)">流水号</a>
											</div>
										</div>
										<div class="margin_t_10 align_left">  <!-- 分界线块  -->
											<hr
												style="height: 1px; color: #CCCCCC; width: 80%; text-align: left;">
										</div>
										<div class="clearfix margin_l_10" style="width:100%;">  <!-- and or in not 块 -->
											<div id="andButton" class="left">
												<a class="form_btn" title="条件表达式1 and 条件表达式2" onclick="doit('and')" href="javascript:void(0)">and</a>
											</div>
											<div id="orButton" class="left margin_l_10">
												<a class="form_btn" title="条件表达式1 or 条件表达式2" onclick="doit('or')" href="javascript:void(0)">or</a>
											</div>
											<div id="notButton" class="left margin_l_10">
												<a class="form_btn" title="not ( 条件表达式)" onclick="doit('not()')" href="javascript:void(0)">not</a>
											</div>
											
											<div id="notButton" class="left margin_l_10" formulaattr="'componentType':'componentType_condition','conditionType':'conditionType_noFunction,conditionType_sql,conditionType_hign_auth,conditionType_BizCheck'" isadvanced="true">
												<a class="form_btn" onclick="inOperate()" title="in ( {选人} , ‘人员1,人员2’ )" href="javascript:void(0)">in</a>
											</div>
											
										</div>
										
										<div class="function clearfix margin_t_10">
										</div>
										<div id="moreorlesstr" style="display: block;width: 100%">
											<div style="text-align: right; width: 100%">
												<div id="morelable" class="font_size12 hand"
													onclick="more()"
													style="width: 100%; line-height: 30px; float:right;display: ''">
													更多
													<span class="ico16 arrow_2_b"></span>
												</div>
												<div id="lesslable" class="font_size12 hand"
													onclick="less()"
													style="width: 100%; line-height: 30px; float:right;display: none;">
													收起
													<span class="ico16 arrow_2_t"></span>
												</div>
											</div>
										</div>
										<div style="display: none" id="others">
											<div class="clearfix margin_t_10">
												<div id="depButton" class="margin_l_10 left">
													<a class="form_btn w89" onclick="showMultiDep();" title="" href="javascript:void(0)">包含部门</a>
												</div>
												<div id="roleButton" class="margin_l_10 left">
													<a class="form_btn w89" onclick="showMultiRole();" title="" href="javascript:void(0)">包含角色</a>
												</div>
											</div>
											<div class="clearfix margin_t_10"
												style="display: block;height">
												<div id="nullButton" class="left margin_l_10">
													<a class="form_btn w89" title="null" onclick="doit('null')" href="javascript:void(0)">空值</a>
												</div>
												<div id="differDateButton" class="left margin_l_10">
													<a class="form_btn w89" title="differDate({日期1},{日期2}) " onclick="getDaySub();" href="javascript:void(0)">日期差</a>
												</div>
											</div>
											<div class="clearfix margin_t_10"
												style="display: block;">
												<div id="sumButton" class="left">
													<a class="form_btn w89 margin_l_10" onclick="showGet('year');"
														href="javascript:void(0)">取年</a>
												</div>
												<div id="monthButton" class="left margin_l_10">
													<a class="form_btn w89" onclick="getYMDW('month');"
														href="javascript:void(0)">取月</a>
												</div>
											</div>
											<div class="clearfix margin_t_10"
												style="display: block;">
												<div id="dayButton" class="left">
													<a class="form_btn w89 margin_l_10" onclick="showGet('day');"
														href="javascript:void(0)">取日</a>
												</div>
												<div id="weekButton" class="left margin_l_10">
													<a class="form_btn w89" onclick="showGet('weekDay');"
														href="javascript:void(0)">取星期几</a>
												</div>
											</div>
										
											<div class="clearfix margin_t_10"
												style="display: block;">
												<div id="dateButton" class="left">
													<a class="form_btn w89 margin_l_10" onclick="getDate();" title="date({表单数据域})"
														href="javascript:void(0)">取日期</a>
												</div>
												<div id="timeButton" class="left margin_l_10">
													<a class="form_btn w89" onclick="getTime()" title="time({表单数据域})"
														href="javascript:void(0)">取时间</a>
												</div>
											</div>
											
											<div class="clearfix margin_t_10"
												style="display: block;">
												<div id="monthButton" class="left margin_l_10">
													<a class="form_btn w89" onclick="showGet('season');"
														href="javascript:void(0)">取季</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div id="footer" align="center" style="margin-left:0px;">
			<table style="width:100%;height:100%" id="ft">
				<tr id="tr102" name="tr102">
									<td id="td102" name="td102" style="width: 100%; height: 32px;"
										class="cmdLayout" colspan="3">
										<div id="button001_div" class="matrixInline"
											style="position: relative;; width: 100px;; height: 22px;">
											<script>
						isc.Button.create({
							ID:"Mbutton001",
							name:"button001",
							title:"确认",
							displayId:"button001_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							//icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton001.click=function(){
							Matrix.showMask();
							evalValue();
							Matrix.hideMask();
							};
						</script>
										</div>
										<div id="button002_div" class="matrixInline"
											style="position: relative;; width: 100px;; height: 22px;">
											<script>
							isc.Button.create({
								ID:"Mbutton002",
								name:"button002",
								title:"取消",
								displayId:"button002_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								//icon:"[skin]/images/matrix/actions/delete.png",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton002.click=function(){
								Matrix.showMask();
								Matrix.closeWindow();
								Matrix.hideMask();
							};
						</script>
										</div>
									</td>
								</tr>
			</table>
		</div>
		<script>
		isc.Window.create( {
			ID : "MdaySub",
			id : "daySub",
			name : "daySub",
			autoCenter : true,
			position : "absolute",
			height : "50%",
			width : "50%",
			title : "日期差",
			canDragReposition : true,
			showMinimizeButton : false,
			showMaximizeButton : true,
			showCloseButton : true,
			showModalMask : false,
			modalMaskOpacity : 0,
			isModal : true,
			autoDraw : false,
			headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
					"maximizeButton", "closeButton" ],
			initSrc : "<%=request.getContextPath()%>/query/form_getYMDW.action?formId=${param.formId}&isYMDW=0",
			src : "<%=request.getContextPath()%>/query/form_getYMDW.action?formId=${param.formId}&isYMDW=0",
			showFooter : false
		});
		</script>
		<script>
			MdaySub.hide();
		</script>
		<script>
		isc.Window.create( {
			ID : "Mget",
			id : "get",
			name : "get",
			autoCenter : true,
			position : "absolute",
			height : "50%",
			width : "50%",
			canDragReposition : false,
			showMinimizeButton : false,
			showMaximizeButton : false,
			showCloseButton : true,
			showModalMask : false,
			modalMaskOpacity : 0,
			isModal : true,
			autoDraw : false,
			headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
					"maximizeButton", "closeButton" ],
			initSrc : "<%=request.getContextPath()%>/query/form_getYMDW.action?formId=${param.formId}&isYMDW=1",
			src : "<%=request.getContextPath()%>/query/form_getYMDW.action?formId=${param.formId}&isYMDW=1",
			showFooter : false
		});
		</script>
		<script>
			Mget.hide();
		</script>
		<script type="text/javascript">
		isc.Window.create({
			ID : "Mincluding",
			id : "including",
			name : "including",
			autoCenter : true,
			position : "absolute",
			height : "50%",
			width : "50%",
			title : "条件",
			canDragReposition : false,
			//targetDialog : "MainDialog",
			showMinimizeButton : true,
			showMaximizeButton : false,
			showCloseButton : true,
			showModalMask : false,
			modalMaskOpacity : 0,
			isModal : true,
			autoDraw : false,
			headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
			showFooter : false
		});
		</script>
		<script>
			Mincluding.hide();
		</script>
  </body>
</html>
