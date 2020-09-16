<%@page  import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="description" content="this is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"></link>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resource/css/formulaset.css">
		<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/html5/js/jquery.min.js"></script>
	    <script SRC="<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js"></script>
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
		<script type="text/javascript">
		  function dblClickField(selection){
			var value ;
			if(selection.value == ''||selection.value.length<0){
				var index =  selection.selectedIndex;
				value = selection.options[index].text;
				value = "{" + value + "}";
			/*}else if(selection.type == 'select-one'){
				var index =  selection.selectedIndex;
				value = selection.options[index].text;
				value = "[" + value + "]";*/
			}else{
			    if(selection.value.indexOf("sum(")>=0 || selection.value.indexOf("aver(")>=0 
				    || selection.value.indexOf("max(")>=0 || selection.value.indexOf("min(")>=0){
					value = selection.value;
			    }else{
					value = "{"+selection.value+ "}";;
			    }
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
		  
		  function doit(opration){
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
		  function clearTextArae(){
		  	var obj = document.getElementById("formulaStr");
		  	obj.value = "";
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
		  
		  function getYMDW(type){ //取年、月、日、星期几  操作
		  	if(type == 'year'){
		  		MgetYMDW.setTitle('取年');
		  		Matrix.setFormItemValue('type','year');
		  	}
		  	if(type == 'month'){
		  		MgetYMDW.setTitle('取月');
		  		Matrix.setFormItemValue('type','month');
		  	}
		  	if(type == 'day'){
		  		MgetYMDW.setTitle('取日');
		  		Matrix.setFormItemValue('type','day');
		  	}
		  	if(type == 'weekDay'){
		  		MgetYMDW.setTitle('取星期几');
		  		Matrix.setFormItemValue('type','weekDay');
		  	}
		  	if(type == 'season'){
		  		MgetYMDW.setTitle('取季');
		  		Matrix.setFormItemValue('type','season');
		  	}
		  	Matrix.showWindow('getYMDW');
		  }
		  function ongetYMDWClose(data){
		  	var type = Matrix.getFormItemValue('type');
		  	if(data != null){
		  		data.value = type + data.value;
		  		dblClickField(data);
		  	}
		  }
		  //求日期差
		  function getDaySub(){
		  	Matrix.showWindow('daySub');
		  }
		  //求日期时间差
		  function getDayTimeSub(){
		  	Matrix.showWindow('dayTimeSub');
		  }
		  function ondaySubClose(data){
		  	if(data != null){
			  	dblClickField(data);
		  	}
		  }
		  function ondayTimeSubClose(data){
		  	if(data != null){
		  		var str=data.value;
		  		var value=str.replace("Date","Time");
		  		data.value=value;
			  	dblClickField(data);
			  	
		  	}
		  }
		   function checkFieldType(str,str_2,type){  //检查字段是不是字表字段 type=0 检查字段是不是主表字段 type = 1检查是否为子表字段
		  	var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							 select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
		  	 var index = select.selectedIndex;
		  	 if(index == -1){
		  	 	if(type == 0){
		  	 		alert('请选择主表字段');
		  	 	}else{
		  	 		alert("请选择子表字段");
		  	 	}
		  	 	return false;
		  	 }
		  	 var text = select.options[index].text;
		  	 if(text.search(str) == -1){
		  	  if(text.search(str_2) == -1){
		  	 	if(type == 0){
		  	 		alert('请选择主表字段');
		  	 	}else{
		  	 		alert("请选择子表字段");
		  	 	}
		  	 	return false;
		  	 	}else{
		  	 		return true;
		  	 	}
		  	 } 
		  	 return true;
		  }
		  function subTotal(){ //重复表合计
		  	 var flag = checkFieldType("重复表\\]","重复节\\]",1);
		  	 if(flag){
			  	var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
			  	 var index = select.selectedIndex;
			  	 var text = select.options[index].text;
			  	 var data = {};
			  	 data.value = "sum({"+text+"})";
			  	 dblClickField(data);
		  	 }
		  }
		  function subAvg(){ //重复表平均
		  	 var flag = checkFieldType("重复表\\]","重复节\\]",1);
		  	 if(flag){
			  	var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							 select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
			  	 var index = select.selectedIndex;
			  	 var text = select.options[index].text;
			  	 var data = {};
			  	 data.value = "aver({"+text+"})";
			  	 dblClickField(data);
		  	 }
		  }
		  function subMax(){ //重复表最大
		  	  var flag = checkFieldType("重复表\\]","重复节\\]",1);
		  	 if(flag){
			  	 var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							 select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
			  	 var index = select.selectedIndex;
			  	 var text = select.options[index].text;
			  	 var data = {};
			  	 data.value = "max({"+text+"})";
			  	 dblClickField(data);
		  	 }
		  }
		  function subMin(){ //重复表最小
		  var flag = checkFieldType("重复表\\]","重复节\\]",1);
		  	 if(flag){
			  	var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							 select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
			  	 var index = select.selectedIndex;
			  	 var text = select.options[index].text;
			  	 var data = {};
			  	 data.value = "min({"+text+"})";
			  	 dblClickField(data);
		  	 }
		  }
		  
		  function subClassify(type){//重复表分类操作，type 有 sum aver max min
		    Matrix.setFormItemValue("subClassifyType",type);
		    Matrix.showWindow("condition");
		  }
		  function onconditionClose(result){
		    if(result!=null){
			    var type = Matrix.getFormItemValue("subClassifyType");
			    var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							 select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
			  	var index = select.selectedIndex;
			  	var text = select.options[index].text;
			  	var data = eval("("+result+")");
			  	var str = type +"({"+text+"},"+data.conditionText+")";
			  	var obj = {};
			  	obj.value = str;
			  	dblClickField(obj);
		  	}
		  }
		  function getInt(){  //取整数操作
		  		var flag = checkFieldType("主表\\]","主表\\]",0);
		  		if(flag){
			  		var value = document.getElementById('fieldSelect').value;
			  		var lis = document.getElementsByTagName("li");
		  		var i = 0;
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 value = document.getElementById('fieldSelect').value;
						}
						if(lis[i].id == 'org_li'){
							 value = document.getElementById('orgSelect').value;//b表数据
						}
					}
				}
			  	    var data = {};
			  	    data.value = "getInt({"+value+"})";
			  	    dblClickField(data);
		  		}
 		  }
 		  function getMod(){  //取余数操作
 		  		var flag = checkFieldType("主表\\]","主表\\]",0);
 		  		if(flag){
	 		  		var value = document.getElementById('fieldSelect').value;
	 		  		var lis = document.getElementsByTagName("li");
	 		  		var i = 0;
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 value = document.getElementById('fieldSelect').value;
						}
						if(lis[i].id == 'org_li'){
							 value = document.getElementById('orgSelect').value;//b表数据
						}
					}
				}
	 		  		MgetMod.initSrc ="<%=request.getContextPath()%>/formula/formula_getDivider.action?targetFormId=${param.targetFormId}&value="+value;
	 		  		MgetMod.src = "<%=request.getContextPath()%>/formula/formula_getDivider.action?targetFormId=${param.targetFormId}&value="+value; 
	 		  		Matrix.showWindow("getMod");
 		  		}
 		  }
 		  function ongetModClose(data){
 		  	if(data != null){
 		  		dblClickField(data);
 		  	}
 		  }
 		  function changeModel(){ //切换设置模式
 		  	var formulaStr = document.getElementById("formulaStr").value;
 		  	if(formulaStr == "" || formulaStr == null){
 		  		window.location.href="<%=request.getContextPath()%>/form/admin/custom/formula/advancedSet.jsp?iframewindowid=${param.iframewindowid}&flag=${param.flag}";
 		  	}else{
 		  		if(window.confirm("切换会是计算式丢失,是否继续？")){
 		  			window.location.href="<%=request.getContextPath()%>/form/admin/custom/formula/advancedSet.jsp?iframewindowid=${param.iframewindowid}&flag=${param.flag}";
 		  		}
 		  	}
 		  }
 		   function isNull(){ //为空判断
			  	 var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							 select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
			  	 var index = select.selectedIndex;
			  	if(index != -1){
			  	 var text = select.options[index].text;
			  	 var data = {};
			  	 data.value = "isNull({"+text+"})";
			  	 dblClickField(data);
			  	}else{
			  		alert('请选择字段');
			  	}
		  }
		  function isNotNull(){ //数字大小写转换
		  		var lis = document.getElementsByTagName("li");
		  		var i = 0;
		  		var select = document.getElementById('fieldSelect');
				for(;i < lis.length; i++){
					if(lis[i].className == "current"){
						if(lis[i].id == 'field_li'){
								 select = document.getElementById('fieldSelect');
						}
						if(lis[i].id == 'org_li'){
							 select = document.getElementById('orgSelect');//b表数据
						}
					}
				}
			  	 var index = select.selectedIndex;
			  	if(index != -1){
			  	 var text = select.options[index].text;
			  	 var data = {};
			  	 data.value = "isNotNull({"+text+"})";
			  	 dblClickField(data);
			  	}else{
			  		alert('请选择字段');
			  	}
		  }
 		  function evalValue(){
 		  		var url = "<%=request.getContextPath()%>/trigger/dataCopy_outToIn.action?targetFormId=${param.targetFormId}";
 		  		var content = document.getElementById("formulaStr").value;
 		  		if(content.contains('"')){//只允许英文单引号  标记
		  		alert('不能包含英文双引号');
		  		return;
		  	}
		  	if(content.contains('“')){
		  		alert('不能包含中文双引号');
		  		return;
		  	}
		  	if(content.contains('”')){
		  		alert('不能包含英文双引号');
		  		return;
		  	}
		  	if(content.contains('‘')){
		  		alert('不能包含中文单引号');
		  		return;
		  	}
		  	if(content.contains('’')){
		  		alert('不能包含中文单引号');
		  		return;
		  	}
 		  		if(content.indexOf("流程标题")<0){
	 		  		var jsonStr = '{"condition":"'+content+'"}';
	 		  		var synJson = isc.JSON.decode(jsonStr);
	 		  		Matrix.sendRequest(url,synJson,function(result){
	 		  			if(result != null){
	 		  				var data = eval("("+result.data+")");
	 		  				data.setType = 0;//setType 为设置类型，1：高级设置，0：普通设置
	 		  				parent.ontargetFormClose(data);
	 		  				Matrix.closeWindow(data);
	 		  			}
	 		  		});
 		  		}else{
 		  			if(content=='{流程标题}'){
 		  			var jsonStr = '{"condition":"'+content+'"}';
 		  			var synJson = isc.JSON.decode(jsonStr);
 		  			Matrix.sendRequest(url,synJson,function(result){
 		  				if(result != null){
 		  				var data = eval("("+result.data+")");
 		  				data.setType = 0;//setType 为设置类型，1：高级设置，0：普通设置
 		  				parent.ontargetFormClose(data);
 		  				Matrix.closeWindow(data);
 		  			}
 		  		});
 		  			}else{
 		  				warn("流程标题为特殊字段只能单独选中");
 		  			}
 		  		}
 		  }
 		  function closeWindow(){
 		  	Matrix.closeWindow();
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
 		  
 		 //流水号
		  function showSerialNumber(){
 			 var mid = document.getElementById("mid").value;
			  layer.open({
			    	id:'layer07',
					type : 2,
					
					title : ['设置流水号'],
					//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '85%', '65%' ],
					content : "<%=path%>/office/html5/select/SelectSerialNumber.jsp?iframewindowid=layer07&mid="+mid
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
		
	  --></script>
	</head>

	<body>
		<input name="type" id="type" type="hidden"/> <!-- 区别是取年、取月、取日还是取星期几操作 -->
		<input name="formulaSetId" id="formulaSetId" type="hidden" />
		<input name="subClassifyType" id="subClassifyType" type="hidden"/> <!-- 区别是取年、取月、取日还是取星期几操作 -->
		<input name="elseResult" id="elseResult" type="hidden"/> <!-- 区别是取年、取月、取日还是取星期几操作 -->
		<input name="iframewindowid" id="iframewindowid" type="hidden" value="<%=request.getParameter("iframewindowid") %>"/>
		<input name="mid" id="mid" type="hidden" value="${mid }"/>
		<div style="width: 100%; height: 100%;margin-left:15px;margin-top:2px;" class="font_size12">
			<div id="modelSet" style="height: 100%; line-height: 40px;">
		<!--  	<%  String isResult = request.getParameter("isResult");
				if(isResult == null){
			 %>
				<label>
					<input type="radio" value="1" id="nomalSet" name="modelSet"
						checked="checked">
					普通设置
				</label>
				<label style="margin-left: 30px">
					<input type="radio" value="2" id="advancedSet" name="modelSet" onclick="changeModel();" />
					高级设置
				</label>
				<%} %>-->
				<div id="model1" style="display: '';margin-top:10px;">
					<form id="formulaForm" action="" method="post" name="myForm">
						<div style="width: 95%; height: 90px;">
							<textarea id="formulaStr" name="formulaStr"
								class="form-control" style="height:100px;resize:none;">${condition}</textarea>
						</div>
						<div style="width: 100%; height: 30px; margin-top: 10px;padding-right: 40px;">
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
						 <div> 
						<div style="width:100%;height:calc(100% - 130px);margin-top: 10px;">
							<div style="width: 60%;float: left;" class="left"
								id="dataDiv">
								<div id="tabs" style="width: 99%;">
									<div id="tabs_head" class="common_tabs clearfix"
										style="width: 99%;">
										<ul class="left">
											<li id="field_li" class="current">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="${formName_a}">
														(简称a表)表单数据域 </span> </a>
											</li>
											<%
												String operateType = request.getParameter("operateType");
												if(!"add".equals(operateType)){//操作类型为增加时不显示b表单数据
											 %>
											<li id="org_li" class="">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="${formName_b}">
														(简称b表)表单数据域</span> </a>
											</li>
											<%} %>
											<!-- <li id="date_li" class="">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="日期变量">
														日期变量 </span> </a>
											</li> -->
										</ul>
									</div>
									<div id="tabs_body" class="common_tabs_body"
										style="width: 99%;">
										<div id="field_div" class="show" style="">
											<select id="fieldSelect" class="w100b"
												ondblclick="dblClickField(this)" style="height:60%;display:'';"
												name="fieldSelect" multiple="multiple">
												<c:forEach var="text" items="${aentVal}">
													<option value="${text}">${text}</option>
												</c:forEach>
											</select>
											<% if(!"add".equals(operateType)){%>
											<select id="orgSelect" class="w100b" ondblclick="dblClickField(this)" size="15" name="orgSelect" style="height:60%;display:none;">
												<c:forEach var="text" items="${bentVal}">
													<option value="${text}">${text}</option>
												</c:forEach>
											</select>
											<%} %>
											<!--  
											<select id="dateSelect" class="w100b" ondblclick="dblClickField(this)" size="15" name="dateSelect" style="display:none;">
												<c:forEach var="dateVar" items="${dateVars}">
													<option value="${dateVar}">${dateVar}</option>
												</c:forEach>
											</select>
											-->
										</div>
									</div>
								</div>
							</div>
							<div id="functionarea" class="right"
								style="height: 315px; width: 35%; margin-top: 10px; overflow: auto;">
								<div style="overflow: visible;">
									<div class="clearfix" style="width:100%">
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
									<div class="clearfix margin_t_10">
										<div id="bracketLeftButton" class="left margin_l_10"
											width="25%">
											<a id="bracketLeft" class="form_btn" onclick="doit('(')"
												href="javascript:void(0)"> <span class="brackl_16"></span>
											</a>
										</div>
										<div id="bracketRightButton" class="left margin_l_10"
											width="25%">
											<a id="bracketRight" class="form_btn" onclick="doit(')')"
												href="javascript:void(0)"> <span class="brackr_16"></span>
											</a>
										</div>
									</div>
									<div class="margin_t_10 align_left">
										<hr
											style="height: 1px; color: #CCCCCC; width: 170px; text-align: left;">
									</div>
									<div style="width: 200px">
										<div class="function clearfix margin_t_10">
											<div id="sumButton" class="left margin_l_10">
												<a class="form_btn w85" onclick="subTotal()"
													href="javascript:void(0)">重复表合计</a>
											</div>
											<div id="averButton" class="left margin_l_10">
												<a class="form_btn w85" onclick="subAvg();"
													href="javascript:void(0)">重复表平均</a>
											</div>
										</div>
										<div class="function clearfix margin_t_10">
											<div id="maxButton" class="left margin_l_10">
												<a class="form_btn w85" onclick="subMax();"
													href="javascript:void(0)">重复表最大</a>
											</div>
											<div id="minButton" class="left margin_l_10">
												<a class="form_btn w85" onclick="subMin();"
													href="javascript:void(0)">重复表最小</a>
											</div>
										</div>
										<div class="function clearfix margin_t_10">
											<div id="maxButton" class="left margin_l_10">
												<a class="form_btn w85" onclick="getDaySub('daySub')"
													href="javascript:void(0)">日期差</a>
											</div>
											<div id="minButton" class="left margin_l_10">
												<a class="form_btn w85" onclick="getDayTimeSub();"
													href="javascript:void(0)">日期时间差</a>
											</div>
										</div>
										<div id="moreorlesstr" style="display: block;">
											<div style="text-align: right; width: 100%">
												<div id="morelable" class="font_size12 hand"
													onclick="more()"
													style="width: 170px; line-height: 30px; display: ''">
													更多
													<span class="ico16 arrow_2_b"></span>
												</div>
												<div id="lesslable" class="font_size12 hand"
													onclick="less()"
													style="width: 170px; line-height: 30px; display: none;">
													收起
													<span class="ico16 arrow_2_t"></span>
												</div>
											</div>
										</div>
										<div style="display: none" id="others">
											<div class="function clearfix margin_t_10 morefunction"
												style="display: block">
												<div id="sumifButton" class="left">
													<a class="form_btn w85 margin_l_10"
														title="sumif({表单数据域},条件表达式)"
														onclick="subClassify('sumif')"
														href="javascript:void(0)">重复表分类合计</a>
												</div>
												<div id="averifButton" class="left margin_l_10"
													isadvanced="true">
													<a class="form_btn w85" title="averif({表单数据域},条件表达式)"
														onclick="subClassify('averif')"
														href="javascript:void(0)">重复表分类平均</a>
												</div>
											</div>
											<div class="function clearfix margin_t_10 morefunction"
												style="display: block;">
												<div id="maxifButton" class="left">
													<a class="form_btn w85 margin_l_10" onclick="subClassify('maxif')"
														href="javascript:void(0)">重复表分类最大</a>
												</div>
												<div id="minifButton" class="left margin_l_10">
													<a class="form_btn w85" onclick="subClassify('minif')"
														href="javascript:void(0)">重复表分类最小</a>
												</div>
											</div>
											<div class="function clearfix margin_t_10 morefunction"
												style="display: block;">
												<div id="sumButton" class="left">
													<a class="form_btn w85 margin_l_10" onclick="getInt()"
														href="javascript:void(0)">取整数</a>
												</div>
												<div id="averButton" class="left margin_l_10">
													<a class="form_btn w85" onclick="getMod()"
														href="javascript:void(0)">取余数</a>
												</div>
											</div>
											<div class="function clearfix margin_t_10 morefunction"
												style="display: block;">
												<div id="yearButton" class="left">
													<a class="form_btn w85 margin_l_10" onclick="getYMDW('year')"
														href="javascript:void(0)">取年</a>
												</div>
												<div id="mouthButton" class="left margin_l_10">
													<a class="form_btn w85" onclick="getYMDW('month')"
														href="javascript:void(0)">取月</a>
												</div>
											</div>
											<div class="function clearfix margin_t_10 morefunction"
												style="display: block;">
												<div id="dayButton" class="left">
													<a class="form_btn w85 margin_l_10" onclick="getYMDW('day')"
														href="javascript:void(0)">取日</a>
												</div>
												<div id="weekdayButton" class="left margin_l_10">
													<a class="form_btn w85" onclick="getYMDW('weekDay')"
														href="javascript:void(0)">取星期几</a>
												</div>
											</div>
											
											<div class="clearfix margin_t_10"
												style="display: block;">
												<div id="monthButton" class="left margin_l_10">
													<a class="form_btn w85" onclick="getYMDW('season');"
														href="javascript:void(0)">取季</a>
												</div>
												<div id="notlikeButton" class="left margin_l_10">
													<a class="form_btn w85" onclick="showSerialNumber();" title="" href="javascript:void(0)">流水号</a>
												</div>
											</div>
											<div class="function clearfix margin_t_10 morefunction"
												style="display: block;">
												<div id="dayButton" class="left">
													<a class="form_btn w85 margin_l_10" onclick="isNull('day')"
														href="javascript:void(0)">为空</a>
												</div>
												<div id="weekdayButton" class="left margin_l_10">
													<a class="form_btn w85" onclick="isNotNull('weekDay')"
														href="javascript:void(0)">不为空</a>
												</div>
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
			   <tr style="text-align:center;">
			  	 <td>
			  		<button class="x-btn ok-btn " type="button" name="submit2" id="butt1" onClick="evalValue();">确认</button>
			    	<button class="x-btn cancel-btn " type="button" name="butt1" id="butt2" onClick="closeWindow();">取消</button>
				 </td>
			   </tr>
			</table>
		</div>
		<!-- ******************弹出窗口******************** -->
		<script> //取年、月、日、星期几窗口
		isc.Window.create( {
			ID : "MgetYMDW",
			id : "getYMDW",
			name : "getYMDW",
			autoCenter : true,
			position : "absolute",
			height : "50%",
			width : "50%",
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
			initSrc : "<%=request.getContextPath()%>/formula/formula_getSysData.action?isYMDW=1&formType=subForm",//isYMDW 是用来判断是取年、月、日、星期几操作，还是求日期差操作
			src : "<%=request.getContextPath()%>/formula/formula_getSysData.action?isYMDW=1&formType=subForm",
			showFooter : false
		});
		</script>
		<script>
			MgetYMDW.hide();
		</script>
		
		<script>//求日期差窗口
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
			initSrc : "<%=request.getContextPath()%>/formula/formula_getSysData.action?isYMDW=0",
			src : "<%=request.getContextPath()%>/formula/formula_getSysData.action?isYMDW=0",
			showFooter : false
		});
		</script>
		<script>
			MdaySub.hide();
		</script>
		<script>//求日期差窗口
		isc.Window.create( {
			ID : "MdayTimeSub",
			id : "dayTimeSub",
			name : "dayTimeSub",
			autoCenter : true,
			position : "absolute",
			height : "50%",
			width : "50%",
			title : "日期时间差",
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
			initSrc : "<%=request.getContextPath()%>/formula/formula_getSysData.action?isYMDW=0",
			src : "<%=request.getContextPath()%>/formula/formula_getSysData.action?isYMDW=0",
			showFooter : false
		});
		</script>
		<script>
			MdayTimeSub.hide();
		</script>
		<script>//重复表分类操作
		isc.Window.create( {
			ID : "Mcondition",
			id : "condition",
			name : "condition",
			autoCenter : true,
			position : "absolute",
			height : "90%",
			width : "100%",
			title : "条件",
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
			initSrc : "<%=request.getContextPath()%>/formula/formula_loadConditionSet.action?formType=subForm",
			src : "<%=request.getContextPath()%>/formula/formula_loadConditionSet.action?formType=subForm",
			showFooter : false
		});
		</script>
		<script>
			Mcondition.hide();
		</script>
		<script>//求日期差窗口
		isc.Window.create( {
			ID : "MgetMod",
			id : "getMod",
			name : "getMod",
			autoCenter : true,
			position : "absolute",
			height : "50%",
			width : "50%",
			title : "取余数",
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
			showFooter : false
		});
		</script>
		<script>
			MgetMod.hide();
		</script>
	</body>
</html>
