<%@page import="java.util.List"%>
<%@page import="com.matrix.form.admin.custom.datainmapping.model.DataInMapping"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.admin.custom.trigger.model.DataMapping"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>触发事件数据拷贝设置页面</title>
<link href='<%=request.getContextPath() %>/resource/html5/css/matrix_runtime.css' rel="stylesheet">
<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/custom.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>
<!-- bootstrap select和layer资源 -->
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
<!-- iCheck资源 -->
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/icheck.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/autosize.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>

<style type="text/css">
    *{
		-webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
	body, ul{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	}
	div, ul{
		box-sizing: border-box;
	}
	#container{
	    position: absolute;
	    height: 100%;
	    width: 100%;
	    overflow: hidden;
	}
	.form-control {
	   border-radius: 4px;
	 }
	.ico16 {
		background: rgba(0, 0, 0, 0) url("../image/icon16.png") no-repeat scroll
			0 0;
		cursor: pointer;
		display: inline-block;
		height: 16px;
		line-height: 16px;
		vertical-align: middle;
		width: 16px;
	}

	.oprate_reduce_16 {
		background-position: -192px -16px;
	}
	
	.oprate_plus_16 {
		background-position: -176px -16px;
	}
	tr {
		height: 36px;
	}
	.tj{
	    text-decoration: none;
	    -webkit-border-radius: 2px;
	    -moz-border-radius: 2px;
	    border-radius: 2px;
	    cursor: pointer;
	    height: 30px;
	    line-height: 28px;
	    text-align: center;
	    border: 1px solid transparent;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    -webkit-transition: background;
	    -moz-transition: background;
	    -o-transition: background;
	    transition: background;
	    -webkit-transition-duration: .3s;
	    -moz-transition-duration: .3s;
	    -o-transition-duration: .3s;
	    transition-duration: .3s;
	    width:50px;
	    margin-left: 3px;
	    font-size: 14px;
	    color: #333;
	    border-color: #ccc;
	}
	.tj:hover{
		background-color: #ebebeb;
	}
	.tj_success{
		 text-decoration: none;
	    -webkit-border-radius: 2px;
	    -moz-border-radius: 2px;
	    border-radius: 2px;
	    cursor: pointer;
	    height: 30px;
	    line-height: 28px;
	    text-align: center;
	    border: 1px solid transparent;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    -webkit-transition: background;
	    -moz-transition: background;
	    -o-transition: background;
	    transition: background;
	    -webkit-transition-duration: .3s;
	    -moz-transition-duration: .3s;
	    -o-transition-duration: .3s;
	    transition-duration: .3s;
	    width:50px;
	    margin-left: 3px;
	    font-size: 14px;
	    vertical-align: middle;
	    color: #fff;
	   	border-color: #2e6da4;
	    background-color: #337ab7;
	}
	.tj_success:hover{
		background-color: #205b8e;
   		border-color: #ccc;
	}
</style>
<script type="text/javascript">
	var num_condition=${num_condition};
	var num_copy=${num_copy};
	var map = {'1':'文本框','2':'日期框','3':'时间框',
						  			'4':'数字框','5':'下拉框','22':'多选下拉框','6':'单选按钮','7':'复选按钮','8':'单选按钮组','9':'复选按钮组','10':'文本域','30':'大文本域',
						  			'11':'列表框','12':'单文件上传','28':'多文件上传','14':'富文本框',
						  			'20':'隐藏域','21':'弹出选择','23':'单选用户','24':'多选用户','25':'单选部门','26':'多选部门',
						  			'29':'流程意见'
					  			};
	
	var array = new Array();   //定义一个数组存放复制数据顺序
	for(i=0;i<=num_copy;i++){
		array.push(i);
	}
	
	//添加一行
	function addRow(element){  
		var tr = element.parentNode.parentNode; //获取当前行对象
		var id = tr.id;   //当前行Id
		var index = tr.rowIndex;
		var tb = document.getElementById('tb');
		var newTr = tb.insertRow(index+1); //在下方插入新的一行
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			
		}else{
			for(i=0;i<=num_copy;i++){
				if(i==index-lineIndex-1){
					//拼接函数(索引位置, 要删除元素的数量, 元素)
					array.splice(i+1, 0, num_copy+1);          //指定位置添加元素
				}
			}
		}
		var newTd1 = newTr.insertCell();
		newTd1.innerHTML = "<td width=\"5%\"></td>";
		var newTd2 = newTr.insertCell();
		var newTd7 = newTr.insertCell();
		var select1 = document.getElementsByTagName("select")[0];
		var select2 = document.getElementsByTagName("select")[1];
		if("add"=="${param.operateType}"){
			select2 = document.getElementsByTagName("select")[0];
		}
		var flag; 
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			num_condition++;
			flag = "<font style=\"color: #0642f7\">等于</font>";
			var str = "<td width=\"30%\"><select id=\"fromCondition_"+num_condition+"\" name=\"fromCondition_"+num_condition+"\" style=\"width:100%;\" class=\"selectpicker show-tick form-control\" data-live-search=\"true\" title=\"请选择\">";
			for(var i=0;i<select1.length;i++){
				if(select1[i].value!=''){
					str += "<option value=\"";
					str += select1[i].value;
					str += "\">"
					str += select1[i].text;
					str += "</option>";
				}
			}
			str += "</select>";
			str += "</td>";
			newTd2.innerHTML = str;
		}else{
			num_copy++;
			flag = "<font style=\"color: #0642f7\">赋值</font>";
			var	str = "<td width=\"30%\">";
			str+="<input type=\"text\" id =\"targetForm_"+num_copy+"\" name=\"targetForm_"+num_copy+"\" style=\"width:100%;\" class=\"form-control\" onclick=\"showTarget(this)\" onmouseover=\"showTitle(this);\"/>"
			str+="<input  id =\"targetFormVal_"+num_copy+"\" name=\"targetFormVal_"+num_copy+"\" type=\"hidden\"/>"
			str+= "</td>";
			str_2="<td width=\"3%\"><div id =\"tarCondition_"+num_copy+"\" name=\"tarCondition_"+num_copy+"\" class=\"tj\" onclick=\"showCondition(this)\"/><span>条件</span></div>"
			str_2+="<input type=\"hidden\" id =\"tarConditionVal_"+num_copy+"\" name=\"tarConditionVal_"+num_copy+"\" />"
			str_2+= "<\/td>";
			newTd2.innerHTML = str;
			newTd7.innerHTML = str_2;
		}
		
		var newTd3 = newTr.insertCell();
		newTd3.innerHTML = "<td width=\"10%\">"+ flag +"</td>";
		var newTd4 = newTr.insertCell();
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			var str = "<td width=\"35%\"><select id=\"toCondition_"+num_condition+"\" id=\"toCondition_"+num_condition+"\" style=\"width:100%;\" class=\"selectpicker show-tick form-control\" data-live-search=\"true\" title=\"请选择\">";
			for(var i=0;i<select2.length;i++){
				if(select2[i].value!=''){
					str += "<option value=\"";
					str += select2[i].value;
					str += "\">"
					str += select2[i].text;
					str += "</option>";
				}
			}
			str+= "</select>";
			str += "</td>";
			
			newTd4.innerHTML = str;
		}else{
			var str = "<td width=\"35%\"><select id=\"fromData_"+num_copy+"\" name=\"fromData_"+num_copy+"\" style=\"width:100%;\" class=\"selectpicker show-tick form-control\" data-live-search=\"true\" title=\"请选择\">";
			for(var i=0;i<select2.length;i++){
				if(select2[i].value!=''){
					str += "<option value=\"";
					str += select2[i].value;
					str += "\">"
					str += select2[i].text;
					str += "</option>";
				}
			}
			str += "</select>";
			str += "</td>";
			
			newTd4.innerHTML = str;
		}
		var newTd5 = newTr.insertCell();
		newTd5.innerHTML = "<td width=\"12%\"><span class=\"ico16 oprate_plus_16\" onclick=\"addRow(this)\"></span>	<span id=\"del\" class=\"ico16 oprate_reduce_16\" onclick=\"delRow(this);\"></span></td>";
		newTd5.style = "padding-left: 10px;"
		
		$('.selectpicker').selectpicker('refresh');//动态刷新
	}
	
	//删除一行
	function delRow(element){  
		var tr = element.parentNode.parentNode;
		var index = tr.rowIndex;       //所选行的行号
		var tb = document.getElementById('tb');
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		if(index < lineIndex){      //删除的是源表单和目标表单条件
			if(lineIndex != 4){
				tb.deleteRow(index);
				return;				
			}
		}
		if(index > lineIndex){      //删除的是复制数据条件
			if(tb.rows.length-lineIndex > 3){
				tb.deleteRow(index);
				return;
			}
		}
	}
	
	//复制数据点击文本框弹出条件窗口
	function showTarget(element){
		Matrix.setFormItemValue("elemId",element.id);
		var arr=element.id.split("_");
		var conditionalId = document.getElementById(arr[0]+"Val_"+arr[1]).value  //条件编码
		var targetFormId ="${param.targetFormId}";   //目标表单编码
		var operateType="${param.operateType}";   //操作类型  add添加    update修改  addRepeat添加重复表
		layer.open({
	    	id:'target',
			type : 2,
			
			title : ['设置计算公式'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '100%', '100%' ],
			content : "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=target&entrance=DataCopyTextBox&associatedFormId="+targetFormId+"&operateType="+operateType+"&conditionalId="+encodeURIComponent(conditionalId)
		});		
	}	
	
	//点击文本框弹出条件窗口回调
	function ontargetClose(data){
		if(data!=null && data!=''){
			var id = Matrix.getFormItemValue("elemId");
			var arr=id.split("_");
			Matrix.setFormItemValue(id,data.conditionText);
			Matrix.setFormItemValue(arr[0]+"Val_"+arr[1],data.conditionVal);
		}
	}
	
	//复制数据点击条件按钮弹出条件窗口
	function showCondition(element){
		Matrix.setFormItemValue("elemId",element.id);
		var arr = element.id.split("_");
		var conditionalId = Matrix.getFormItemValue(arr[0]+"Val_"+arr[1]); //条件编码
	    var optString = optString;
		layer.open({
	    	id:'condition',
			type : 2,
			
			title : ['设置条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '100%', '100%' ],
			content : "<%=request.getContextPath()%>/condition/condition_loadConditionSet.action?iframewindowid=condition&entrance=DataCopyButton&conditionalId="+encodeURIComponent(conditionalId)
		});			
	}	
	
	
	function onconditionClose(data){
		if(data!=null && data!=''){
			var id = Matrix.getFormItemValue("elemId");
			var arr=id.split("_");
			Matrix.setFormItemValue(arr[0]+"Val_"+arr[1],data.conditionVal);
			if(data.conditionVal!=''){
				document.getElementById(id).className = 'tj_success';  
			}else{
				document.getElementById(id).className = 'tj';  
			}
			
		}
	}
	
	function getTargetNumber(tValue){
		if(tValue == null || tValue=="")
			return 1;
		
		var number = 0;
		var selects = document.getElementsByTagName("select");
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取源表单select的value对应类型组成的JSON串
	
		var synJson = isc.JSON.decode(fromTypeJsonStr);
		if(lineIndex != 1){  //不等于1说明操作类型为修改
			for(var i=0;i<num_copy+1;i++){
				if(document.getElementById("fromData_"+i)!=undefined&&document.getElementById("fromData_"+i)!=null&&document.getElementById("fromData_"+i)!="undefined"){
					var fromData= document.getElementById("fromData_"+i);
					var fromDataVal= document.getElementById("fromData_"+i).value;
					var targetFormVal= document.getElementById("targetFormVal_"+i).value;
					var tarCondition= document.getElementById("tarConditionVal_"+i).value;
					if(fromDataVal == tValue)
						++number;
				}	
			}	
		}else{
			var m = 0;
			var n = 0;
			var fromType;
			var toType;
			var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取源表单select的value对应类型组成的JSON串
			var toTypeJsonStr = "${toTypeJsonStr}";//获取目标表单select的value对应类型组成的JSON串
			var fromTypeJsonObj = eval("("+fromTypeJsonStr+")");
			var toTypeJsonObj = eval("("+toTypeJsonStr+")");
			var fromPro;
			var toPro;
			str = '[{"copyData":{';
			for(var i=0;i<num_copy+1;i++){
				if(document.getElementById("fromData_"+i)!=undefined&&document.getElementById("fromData_"+i)!=null&&document.getElementById("fromData_"+i)!="undefined"){
					var targetFormVal= document.getElementById("targetFormVal_"+i).value;
					var tarCondition= document.getElementById("tarConditionVal_"+i).value;	
					var fromDataVal= document.getElementById("fromData_"+i).value;
		
					if(fromDataVal == tValue)
						++number;
				}
			}
		}	
		return number;
			
	}
	
	//确认
	function submitByButton(){ 
			var selects = document.getElementsByTagName("select");
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var lineIndex = divisionTr.rowIndex;//获取分界线的行号
			var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取源表单select的value对应类型组成的JSON串
		
			var synJson = isc.JSON.decode(fromTypeJsonStr);
			var toTypeJsonStr = "${toTypeJsonStr}";//获取目标表单select的value对应类型组成的JSON串
			var fromTypeJsonObj = eval("("+fromTypeJsonStr+")");
			var toTypeJsonObj = eval("("+toTypeJsonStr+")");
			var str;
			if(lineIndex != 1){  //不等于1说明操作类型为修改
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromPro;
				var toPro;
				str = '[{"condition":{';
				var conditionRows = lineIndex-3; // 获得条件行数
				for(var i=0;i<conditionRows*2;i++){
					var index = selects[i].selectedIndex;
					var value = selects[i].options[index].value;
					
					var text = selects[i].options[index].text;
					if(i%2 == 0){
						str = str+ '"fromCondition_'+m+'":"';
						str += value;
						str += '",';
						m++;
						fromPro = text;
						fromType = fromTypeJsonObj[value];
					}else{
						str = str + '"toCondition_'+n+'":"';
						str += value;
						str += '",';
						n++;
						toPro = text;
						toType = toTypeJsonObj[value];
					}
					if(m == n){
						if(fromType == null && toType != null){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toType == null && fromType != null){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType == null && toType != null){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType == null && toType == null){//后加的校验   都为空的时候也提示
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}					
					}
				}
				str = str.substring(0,str.length-1);
				str += '}},{"copyData":{';
				m = 0;
				n = 0;
				var copyDataRows = selects.length/2-conditionRows;//获取复制数据的行数
				for(var i=0;i<array.length;i++){
					if(document.getElementById("fromData_"+array[i])!=undefined&&document.getElementById("fromData_"+array[i])!=null&&document.getElementById("fromData_"+array[i])!="undefined"){
					var  fromData= document.getElementById("fromData_"+array[i]);
					var  fromDataVal= document.getElementById("fromData_"+array[i]).value;
					var  targetFormVal= document.getElementById("targetFormVal_"+array[i]).value;
					var  tarCondition= document.getElementById("tarConditionVal_"+array[i]).value;
					
					var number = getTargetNumber(fromDataVal);
					if(number >1){
						Matrix.warn("不允许重复赋值给相同目标选项！");
						return;
					}
					
					str = str+'"toData_'+n+'":"';
					str += fromDataVal;
					str += '",';
					str = str+'"fromData_'+n+'":"';
					str += targetFormVal;
					str += '",';
					str = str+'"tarCondition_'+n+'":"';
					if(tarCondition!=null&&tarCondition!=""){
					str += tarCondition;
					}
					str += '",';
					n++;
					if(fromDataVal == "" && targetFormVal == "" && copyDataRows == 1){
						Matrix.warn("必须要有原表字段拷贝到目标表字段!");
						return;
					}
					if(fromDataVal == "" && targetFormVal != ""){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
					if(fromDataVal != "" && targetFormVal == ""||targetFormVal == null){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
					if(fromDataVal == "" && targetFormVal == ""){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
				  }
				}
				str = str.substring(0,str.length-1);
				str += '}}]';
			}else{
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取源表单select的value对应类型组成的JSON串
				var toTypeJsonStr = "${toTypeJsonStr}";//获取目标表单select的value对应类型组成的JSON串
				var fromTypeJsonObj = eval("("+fromTypeJsonStr+")");
				var toTypeJsonObj = eval("("+toTypeJsonStr+")");
				var fromPro;
				var toPro;
				str = '[{"copyData":{';	
				for(var i=0;i<array.length;i++){
					if(document.getElementById("fromData_"+array[i])!=undefined&&document.getElementById("fromData_"+array[i])!=null&&document.getElementById("fromData_"+array[i])!="undefined"){
					var  fromData= document.getElementById("fromData_"+array[i]);
					var  fromDataVal= document.getElementById("fromData_"+array[i]).value;
					var  targetFormVal= document.getElementById("targetFormVal_"+array[i]).value;
					var  tarCondition= document.getElementById("tarConditionVal_"+array[i]).value;
					
					var number = getTargetNumber(fromDataVal);
					if(number >1){
						Matrix.warn("不允许重复赋值给相同目标选项！");
						return;
					}					
					str = str+'"toData_'+n+'":"';
					str += fromDataVal;
					str += '",';			
					str = str+'"fromData_'+n+'":"';
					str += targetFormVal;
					str += '",';
					str = str+'"tarCondition_'+n+'":"';
					if(tarCondition!=null&&tarCondition!=""){
					str += tarCondition;
					}
					str += '",';
					n++;
					if(fromDataVal == "" && targetFormVal == "" && copyDataRows == 1){
						Matrix.warn("必须要有原表字段拷贝到目标表字段!");
						return;
					}
					if(fromDataVal == "" && targetFormVal != ""){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
					if(fromDataVal != "" && targetFormVal == ""||targetFormVal == null){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
					if(fromDataVal == "" && targetFormVal == ""){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
				}
			  }
			  str = str.substring(0,str.length-1);
			  str += '}}]';
			}
			debugger;
			if(str != null && str != ''){
				//formdesigner.js中记录的一级弹出窗口对象
				var data = {};
				data.dataCopyStr = str;
				Matrix.closeWindow(data);
			}
	}
	
	function showTitle(element){
		element.title=element.value;
	}
</script>
</head>
<body>
	  <%
	  	List<DataMapping> conditionCopyList = (List<DataMapping>) request.getAttribute("conditionCopyList");
	  	List<DataMapping> copyList = (List<DataMapping>) request.getAttribute("copyList");
	  	List<String> fromEntVal = (List<String>) request.getAttribute("fromEntVal");
	  	List<String> fromColVal = (List<String>) request.getAttribute("fromColVal");
	  	List<String> toEntVal = (List<String>) request.getAttribute("toEntVal");
	  	List<String> toColVal = (List<String>) request.getAttribute("toColVal");
	  	String operateType = request.getParameter("operateType");
	  	String index = request.getParameter("index");  //所修改数据的index
	  	String optString = request.getParameter("optString");// 判断是添加(0)还是修改(1)
	  %>
	  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	  	  <input type="hidden" id="elemId" name="elemId" value=""/>
	  	  <div id="container">
	  	    <div id="top" style="height:calc(100% - 54px); width:100%;overflow: auto;">
				<table id="tb" class="" style="width: 100%;">
					<tbody>
						<tr>
							<td width="5%"></td>
							<td width="30%" style="text-align: center;">
								<span style="font-weight:bold;">源表单</span>
							</td>
							<td width="10%"></td>
							<td width="10%"></td>
							<td width="35%" style="text-align: center;">
								<span style="font-weight:bold;">目标表单</span>
							</td>
							<td width="10%"></td>
						</tr>
						<%if(!"add".equals(operateType)){%>
						<tr>
							<td colspan="6" >
								<span style="padding-left: 10px;font-weight:bold;">条件：</span>
							</td>
						</tr>

						<%
    			  if(conditionCopyList != null && conditionCopyList.size()>0){
    			  int i = 0;
    			  boolean flag = true;
    			  for(DataMapping dataMapping : conditionCopyList){
    			%>
						<tr>
							<td width="5%"></td>
							<td width="30%">
								<select id="fromCondition_<%=i%>" name="fromCondition_<%=i%>" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">								
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var fromId = "<%=dataMapping.getFromId()%>";									
									$('.selectpicker').selectpicker('refresh');//动态刷新
						 			//设置选中的值
						 			$('#fromCondition_<%=i%>').selectpicker('val',fromId);
								</script>
							</td>
							<td width="10%"></td>
							<td width="10%">
								<font style="color: #0642f7;">等于</font>
							</td>
							<td width="35%">
								<select id="toCondition_<%=i%>" name="toCondition_<%=i%>" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">								
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var toId = "<%=dataMapping.getToId()%>";									
									$('.selectpicker').selectpicker('refresh');//动态刷新
						 			//设置选中的值
						 			$('#toCondition_<%=i%>').selectpicker('val',toId);
								</script>
							</td>
							</td>
							<td width="10%" style="padding-left: 10px;">
								<span id="add" class="ico16 oprate_plus_16"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16"
									onclick="delRow(this);"></span>
							</td>
						</tr>
						<% i++;}%>
						<tr>
							<td colspan="6">
								<hr/>
							</td>
						</tr>
  						<%}else{%>
						<tr>
							<td width="5%"></td>
							<td width="30%">
								<select id="fromCondition_0" name="fromCondition_0" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%"></td>
							<td width="10%">
								<font style="color: #0642f7;">等于</font>
							</td>
							<td width="35%">
								<select id="toCondition_0" name="toCondition_0" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							
							</td>
							<td width="10%" style="padding-left: 10px;">
								<span id="add" class="ico16 oprate_plus_16"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16"
									onclick="delRow(this);"></span>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<hr/>
							</td>
						</tr>
						<%} }%>
						
				<!--********************** 数据复制部分 ************************ -->
						<tr id="division">
							<td colspan="6">
								<span style="padding-left: 10px;font-weight:bold;">复制数据：</span>
							</td>
						</tr>
						<% if(copyList != null && copyList.size() > 0){
    					for(int k = 0;k<copyList.size();k++){
    						DataMapping dataMapping = copyList.get(k);
    					%>
    					<tr id="<%=k%>">
							<td width="5%"></td>
							<td width="30%">
								<input type="text" id ="targetForm_<%=k%>" name="targetForm_<%=k%>" style="width:100%;" class="form-control" onclick="showTarget(this);" onmouseover="showTitle(this);"  value="<%=dataMapping.getFromIdText()%>">
								<input type="hidden" id ="targetFormVal_<%=k%>" name="targetFormVal_<%=k%>" value="<%=dataMapping.getFromId()%>">			
							</td>
							<td width="10%">
								<div id ="tarCondition_<%=k%>" name="tarCondition_<%=k%>" class="<%if(dataMapping.getCondition()!=null&&dataMapping.getCondition().trim().length()>0&&!"null".equals(dataMapping.getCondition())){out.print("tj_success");}else{out.print("tj");}%>" onclick="showCondition(this);">
								     <span>条件</span>
								</div> 
								<input type="hidden" id ="tarConditionVal_<%=k%>" name="tarConditionVal_0" value="<%=dataMapping.getCondition()%>">
							</td>
							
							<td width="10%">
								<font style="color: #0642f7;">复制</font>
							</td>
							<td width="35%">
								<select id="fromData_<%=k%>" name="fromData_<%=k%>" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var fromId = "<%=dataMapping.getToId()%>";									
									$('.selectpicker').selectpicker('refresh');//动态刷新
						 			//设置选中的值
						 			$('#fromData_<%=k%>').selectpicker('val',fromId);
								</script>
							</td>
							<td width="10%" style="padding-left: 10px;">
								<span id="add" class="ico16 oprate_plus_16"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16"
									onclick="delRow(this);"></span>
							</td>
						</tr>
    				<%}
    			}else{%>
						<tr>
							<td width="5%"></td>
							<td width="30%">
								<input type="text" id ="targetForm_0" class="form-control" name="targetForm_0" style="width:100%;" onclick="showTarget(this);" onmouseover="showTitle(this);">
								<input type="hidden" id ="targetFormVal_0" name="targetFormVal_0">
								
							</td>
							<td width="10%">
								<div id ="tarCondition_0" name="tarCondition_0" class="tj" onclick="showCondition(this);">
								     <span>条件</span>
								</div>
								<input type="hidden" id ="tarConditionVal_0" name="tarConditionVal_0">
							</td>
							<td width="10%">
								<font style="color: #0642f7;">赋值</font>
							</td>
							<td width="35%">
								<select id="fromData_0" name="fromData_0" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%" style="padding-left: 10px;">
								<span id="add" class="ico16 oprate_plus_16"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16"
									onclick="delRow(this);"></span>
							</td>
						</tr>
						<%} %>
						<tr><td style="height:10px;"></td></tr>
					</tbody>
				</table>
			</div>
			<div id="buttom" class="cmdLayout">	
				<input type="button" class="x-btn ok-btn" name="确认" value="确认" id="save" >
				<input type="button" class="x-btn cancel-btn" name="关闭" value="关闭" id="cancel" >
				<script type="text/javascript">
			        $("#save").on("click",function(){
			     		Matrix.showMask2();
		    			//保存
		    			submitByButton();
		    			Matrix.hideMask2();
			    		
			        });
		        	$("#cancel").on("click",function(){
			        	Matrix.closeWindow();
			        })
				</script>	
			</div>
		 </div>
	</form>
  </body>
</html>
