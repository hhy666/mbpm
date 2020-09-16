<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@page import="com.matrix.form.admin.custom.trigger.model.DataMapping"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style type="text/css">
		
a:link { 
font-size: 12px; 
color: #000000; 
text-decoration:none;
} 
a:visited { 
font-size: 12px; 
color: #000000; 
text-decoration:none;
} 
a:hover { 
font-size: 12px; 
color: #999999; 
text-decoration:none;
} 

.bottom {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	height: 35px;
}

.ico16 {
	background: rgba(0, 0, 0, 0) url("../resource/images/icon16.png") no-repeat scroll 0
		0;
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
.select{
    display: block;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    font-size: smaller;
}
.inputText{
	display: block;
    height: 34px;
    font-size: 14px;
    line-height: 1.42857;
    color: rgb(85, 85, 85);
    background-color: rgb(255, 255, 255);
    background-image: none;
    box-shadow: rgba(0, 0, 0, 0.075) 0px 1px 1px inset;
    padding: 6px 12px;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(204, 204, 204);
    border-image: initial;
    border-radius: 4px;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    font-size: smaller;
}
tr{
	height:30px;
}
.tj{
    background-size: 100%;
    /* color: white; */
    display: -moz-inline-stack;
    display: inline-block;
    vertical-align: middle;
    zoom: 1;
    border-width: 1px;
    border-color: #357ebd;
    border-style: solid;
}
.tj_success{
 	background-color: #428bca;
 	 background-size: 100%;
    /* color: white; */
    display: -moz-inline-stack;
    display: inline-block;
    vertical-align: middle;
    zoom: 1;
    border-width: 1px;
    border-color: #357ebd;
    border-style: solid;
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
	/**
	function addRow(element){  //新加一行
		var tr = element.parentNode.parentNode; //获取当前行对象
		var index = tr.rowIndex;
		var tb = document.getElementById('tb');
		var newTr = tb.insertRow(index+1); //在下方插入新的一行
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td width=\"10%\"></td>";
		var newTd2 = newTr.insertCell();
		var select1 = document.getElementsByTagName("select")[0];
		var select2 = document.getElementsByTagName("select")[1];
		var flag; 
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			flag = "=";
		}else{
			flag = "-->";
		}
		var str = "<td width=\"35%\"><select>";
		for(var i=0;i<select1.length;i++){
			str += "<option value=\"";
			str += select1[i].value;
			str += "\">"
			str += select1[i].text;
			str += "</option>";
		}
		str += "</select>";
		str += "</td>";
		newTd2.innerHTML = str;
		
		var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td width=\"10%\">"+ flag +"</td>";
		
		var newTd4 = newTr.insertCell();
		str = "<td width=\"35%\"><select>";
		for(var i=0;i<select2.length;i++){
			str += "<option value=\"";
			str += select2[i].value;
			str += "\">"
			str += select2[i].text;
			str += "</option>";
		}
		str += "</select>";
		str += "</td>";
		newTd4.innerHTML = str;
		
		var newTd5 = newTr.insertCell();
			newTd5.innerHTML = "<td width=\"10%\"><span class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this)\"></span>&nbsp;<span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this);\"></span></td>";
	}**/
	
	var array = new Array();   //定义一个数组存放复制数据顺序
	for(i=0;i<=num_copy;i++){
		array.push(i);
	}
	
	function addRow(element){  //新加一行
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
			flag = "==";
			var str = "<td width=\"30%\"><select id=\"fromCondition_"+num_condition+"\" name=\"fromCondition_"+num_condition+"\" style=\"width:100%;\" class=\"select\" onmouseover=\"showSelectTitle(this);\">";
		for(var i=0;i<select1.length;i++){
			str += "<option value=\"";
			str += select1[i].value;
			str += "\">"
			str += select1[i].text;
			str += "</option>";
		}
		str += "</select>";
		str += "</td>";
		newTd2.innerHTML = str;
		}else{
		num_copy++;
			flag = "-->";
		var	str = "<td width=\"30%\">";
		str+="<input type=\"text\" id =\"targetForm_"+num_copy+"\" name=\"targetForm_"+num_copy+"\" style=\"width:100%;\" class=\"inputText\" onclick=\"showTarget(this)\" onmouseover=\"showTitle(this);\"/>"
		str+="<input  id =\"targetFormVal_"+num_copy+"\" name=\"targetFormVal_"+num_copy+"\" type=\"hidden\"/>"
		str+= "</td>";
		str_2="<td width=\"3%\" style=\"font-weight:bold;\" ><button type=\"button\" id =\"tarCondition_"+num_copy+"\" name=\"tarCondition_"+num_copy+"\" class=\"tj\" href=\"javascript:void(0\" onclick=\"showCondition(this)\"/>条件</button>"
		str_2+="<input type=\"hidden\" id =\"tarConditionVal_"+num_copy+"\" name=\"tarConditionVal_"+num_copy+"\" />"
		str_2+= "<\/td>";
		newTd2.innerHTML = str;
		newTd7.innerHTML = str_2;
		}
		
		var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td width=\"10%\">"+ flag +"</td>";
		var newTd4 = newTr.insertCell();
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
		var str = "<td width=\"35%\"><select id=\"toCondition_"+num_condition+"\" id=\"toCondition_"+num_condition+"\" style=\"width:100%;\" class=\"select\" onmouseover=\"showSelectTitle(this);\">";
		for(var i=0;i<select2.length;i++){
			str += "<option value=\"";
			str += select2[i].value;
			str += "\">"
			str += select2[i].text;
			str += "</option>";
		}
		 str+= "</select>";
		str += "</td>";
		
		newTd4.innerHTML = str;
		}else{
			var str = "<td width=\"35%\"><select id=\"fromData_"+num_copy+"\" name=\"fromData_"+num_copy+"\" style=\"width:100%;\" class=\"select\" onmouseover=\"showSelectTitle(this);\">";
		for(var i=0;i<select2.length;i++){
			str += "<option value=\"";
			str += select2[i].value;
			str += "\">"
			str += select2[i].text;
			str += "</option>";
		}
		str += "</select>";
		str += "</td>";
		
		newTd4.innerHTML = str;
		}
		var newTd5 = newTr.insertCell();
			newTd5.innerHTML = "<td width=\"12%\"><span class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this)\"></span>	<span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this);\"></span></td>";
	}
	
	function delRow(element){  //删除一行
			var tr = element.parentNode.parentNode;
			var index = tr.rowIndex;       //所选行的行号
			var tb = document.getElementById('tb');
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var lineIndex = divisionTr.rowIndex;//获取分界线的行号
			if(index < lineIndex){      //删除的是原表单和目标表单条件
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
	function showTarget(element){
		parent.dataCopy=this;
		Matrix.setFormItemValue("elemId",element.id);
		 var arr=element.id.split("_");
		 parent.tarForm =document.getElementById(arr[0]+"Val_"+arr[1]).value;
		//Matrix.showWindow('targetForm');
		var targetFormId ="${param.targetFormId}";
		var operateType="${param.operateType}";
		var tarForm = document.getElementById(arr[0]+"Val_"+arr[1]).value
		parent.openTargetCondition(targetFormId,operateType,tarForm);
	}	
	function showCondition(element){
		parent.dataCopy=this;
		Matrix.setFormItemValue("elemId",element.id);
		 var arr=element.id.split("_");
		parent.firstCondition =document.getElementById(arr[0]+"Val_"+arr[1]).value;
		//Matrix.showWindow('tarCondition');
		var targetFormId = "${param.targetFormId}";
		var id = Matrix.getFormItemValue("elemId");;
	    var arr=id.split("_");
	    var firstCondition = Matrix.getFormItemValue(arr[0]+"Val_"+arr[1]);
	    var optString = optString;
		parent.openDataCopyCondiation(targetFormId,arr,firstCondition,optString);
	}	
	
	function setTargetValue(data){
	 var id=Matrix.getFormItemValue("elemId");
	 var arr=id.split("_");
	 if(data!=null && data!=''){
					Matrix.setFormItemValue(id,data.conditionText);
					Matrix.setFormItemValue(arr[0]+"Val_"+arr[1],data.conditionVal);
				}
	}
	function setConditionValue(data){
	 var id=Matrix.getFormItemValue("elemId");
	 var arr=id.split("_");
	 if(data!=null && data!=''){
		Matrix.setFormItemValue(arr[0]+"Val_"+arr[1],data.conditionVal);
		 document.getElementById(id).className = 'tj_success';  
	}else{
		Matrix.setFormItemValue(arr[0]+"Val_"+arr[1],null);
		document.getElementById(id).className = 'tj'; 
		}
	}
	
	function getTargetNumber(tValue){
		if(tValue == null || tValue=="")
			return 1;
		
		var number = 0;
		var selects = document.getElementsByTagName("select");
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取原表单select的value对应类型组成的JSON串
	
		var synJson = isc.JSON.decode(fromTypeJsonStr);
		if(lineIndex != 1){  //不等于1说明操作类型为修改
			for(var i=0;i<num_copy+1;i++){
				///var j = i + conditionRows*2;
				if(document.getElementById("fromData_"+i)!=undefined&&document.getElementById("fromData_"+i)!=null&&document.getElementById("fromData_"+i)!="undefined"){
					var  fromData= document.getElementById("fromData_"+i);
					var  fromDataVal= document.getElementById("fromData_"+i).value;
					var  targetFormVal= document.getElementById("targetFormVal_"+i).value;
					var  tarCondition= document.getElementById("tarConditionVal_"+i).value;
					if(fromDataVal == tValue)
						++number;
				}	
			}	
		}else{
			var m = 0;
			var n = 0;
			var fromType;
			var toType;
			var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取原表单select的value对应类型组成的JSON串
			var toTypeJsonStr = "${toTypeJsonStr}";//获取目标表单select的value对应类型组成的JSON串
			var fromTypeJsonObj = eval("("+fromTypeJsonStr+")");
			var toTypeJsonObj = eval("("+toTypeJsonStr+")");
			var fromPro;
			var toPro;
			str = '[{"copyData":{';
			for(var i=0;i<num_copy+1;i++){
				///var j = i + conditionRows*2;
				if(document.getElementById("fromData_"+i)!=undefined&&document.getElementById("fromData_"+i)!=null&&document.getElementById("fromData_"+i)!="undefined"){
					var  targetFormVal= document.getElementById("targetFormVal_"+i).value;
					var  tarCondition= document.getElementById("tarConditionVal_"+i).value;	
					var  fromDataVal= document.getElementById("fromData_"+i).value;
					
					if(fromDataVal == tValue)
						++number;
				}
			}
		}
			
		return number;
			
	}
	
	function submitByButton(){ //点击确认
			var selects = document.getElementsByTagName("select");
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var lineIndex = divisionTr.rowIndex;//获取分界线的行号
			var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取原表单select的value对应类型组成的JSON串
		
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
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toType == null && fromType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType == null && toType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType == null && toType == null){//后加的校验   都为空的时候也提示
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						/*if(fromType != toType){
							alert("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
							return;
						}*/
					}
				}
				str = str.substring(0,str.length-1);
				str += '}},{"copyData":{';
				m = 0;
				n = 0;
				var copyDataRows = selects.length/2-conditionRows;//获取复制数据的行数
				//for(var i=0;i<num_copy+1;i++){
					///var j = i + conditionRows*2;
				for(var i=0;i<array.length;i++){
					if(document.getElementById("fromData_"+array[i])!=undefined&&document.getElementById("fromData_"+array[i])!=null&&document.getElementById("fromData_"+array[i])!="undefined"){
					var  fromData= document.getElementById("fromData_"+array[i]);
					var  fromDataVal= document.getElementById("fromData_"+array[i]).value;
					var  targetFormVal= document.getElementById("targetFormVal_"+array[i]).value;
					var  tarCondition= document.getElementById("tarConditionVal_"+array[i]).value;
					
					var number = getTargetNumber(fromDataVal);
					if(number >1){
						alert("不允许重复赋值给相同目标选项！");
						return;
					}
					
					//var fromData = selects[j].options[index].text;
						str = str+'"toData_'+n+'":"';
						str += fromDataVal;
						str += '",';
						//fromPro = text;
						//fromType = fromTypeJsonObj[value];
						str = str+'"fromData_'+n+'":"';
						str += targetFormVal;
						str += '",';
						str = str+'"tarCondition_'+n+'":"';
						if(tarCondition!=null&&tarCondition!=""){
						str += tarCondition;
						}
						str += '",';
						//toPro = text;
						//toType = toTypeJsonObj[value];
						n++;
						if(fromDataVal == "empty_emp" && targetFormVal == "" && copyDataRows == 1){
							alert("必须要有原表字段拷贝到目标表字段!");
							return;
						}
						if(fromDataVal == "empty_emp" && targetFormVal != ""){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromDataVal != "empty_emp" && targetFormVal == ""||targetFormVal == null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromDataVal == "empty_emp" && targetFormVal == ""){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						/**
						if(fromType != toType){
							alert("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
							return;
						}**/
						
					}
				}
				str = str.substring(0,str.length-1);
				str += '}}]';
			}else{
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取原表单select的value对应类型组成的JSON串
				var toTypeJsonStr = "${toTypeJsonStr}";//获取目标表单select的value对应类型组成的JSON串
				var fromTypeJsonObj = eval("("+fromTypeJsonStr+")");
				var toTypeJsonObj = eval("("+toTypeJsonStr+")");
				var fromPro;
				var toPro;
				str = '[{"copyData":{';
				//for(var i=0;i<num_copy+1;i++){
				for(var i=0;i<array.length;i++){
					///var j = i + conditionRows*2;
					if(document.getElementById("fromData_"+array[i])!=undefined&&document.getElementById("fromData_"+array[i])!=null&&document.getElementById("fromData_"+array[i])!="undefined"){
					var  fromData= document.getElementById("fromData_"+array[i]);
					var  fromDataVal= document.getElementById("fromData_"+array[i]).value;
					var  targetFormVal= document.getElementById("targetFormVal_"+array[i]).value;
					var  tarCondition= document.getElementById("tarConditionVal_"+array[i]).value;
					
					var number = getTargetNumber(fromDataVal);
					if(number >1){
						alert("不允许重复赋值给相同目标选项！");
						return;
					}
					//var fromData = selects[j].options[index].text;
						str = str+'"toData_'+n+'":"';
						str += fromDataVal;
						str += '",';
						//fromPro = text;
						//fromType = fromTypeJsonObj[value];
						str = str+'"fromData_'+n+'":"';
						str += targetFormVal;
							str += '",';
						str = str+'"tarCondition_'+n+'":"';
						if(tarCondition!=null&&tarCondition!=""){
						str += tarCondition;
						}
							str += '",';
						//toPro = text;
						//toType = toTypeJsonObj[value];
						n++;
						if(fromDataVal == "empty_emp" && targetFormVal == "" && copyDataRows == 1){
							alert("必须要有原表字段拷贝到目标表字段!");
							return;
						}
						if(fromDataVal == "empty_emp" && targetFormVal != ""){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromDataVal != "empty_emp" && targetFormVal == ""||targetFormVal == null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromDataVal == "empty_emp" && targetFormVal == ""){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}/**
						if(fromType != toType){
							alert("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
							return;
						}**/
						
					}
				}
				str = str.substring(0,str.length-1);
				str += '}}]';
			}
			debugger;
			/*
			for(var i=0;i<parent.document.getElementsByTagName("iframe").length;i++){
				if(parent.document.getElementsByTagName("iframe")[i].id.indexOf('layui-layer-iframe')!=-1){
					var iframe = parent.document.getElementsByTagName("iframe")[i].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
				}
			}
			*/
			/*
			if(parent.document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow.Matrix){
				var iframe = parent.document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
			}else{
				var iframe = parent.document.getElementsByTagName("iframe")[2].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
			}
			*/
			
			if(str != null && str != ''){
				parent.iframeJs.Matrix.setFormItemValue('dataCopyStr',str);
			}
			Matrix.closeWindow();
	}
	
	function showTitle(element){
		element.title=element.value;
	}
	
	function showSelectTitle(element){
		var obj = element;
        for (i=0;i<obj.length;i++) {//下拉框的长度就是它的选项数.
           if (obj[i].selected== true ) {
          	 var text=obj[i].text;//获取当前选择项的 值 .
          		obj.title = text;
			}
		}
	}
	
</script>
	</head>
	<body>
	<input type="hidden" id="elemId" name="elemId" value=""/>
	<jsp:include page="/form/admin/common/loading.jsp"/>
	<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto">
<script> 
var MForm0=isc.MatrixForm.create({
			ID:"MForm0",
			name:"MForm0",
			position:"absolute",
			action:"",
			fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]
		});</script>
	
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
		<form id="Form0" action="">
			<input name="iframewindowid" id="iframewindowid" type="hidden" value="<%=request.getParameter("iframewindowid") %>" />
			<div id="main" style="height:92%;overflow:auto;">
				<table class="" id="tb"
					style="width: 100%; overflow: auto;">
					<tbody>
						<tr>
							<td width="5%"></td>
							<td width="30%">
								<span style="margin-left:40px;">原表单</span>
							</td>
							<td width="10%"></td>
							<td width="10%"></td>
							<td width="35%">
								<span style="margin-left:35px;">目标表单</span>
							</td>
							<td width="10%"></td>
						</tr>
						<%if(!"add".equals(operateType)){%>
						<tr>
							<td colspan="6" >
								条件：
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
								<select id="fromCondition_<%=i%>" name="fromCondition_<%=i%>" style="width:100%;" class="select" onmouseover="showSelectTitle(this);">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var select = document.getElementById("fromCondition_<%=i%>");
									var options = select.options;
									var fromId = "<%=dataMapping.getFromId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == fromId){
											options[i].selected = true;
											break;
										}
									}
								</script>
							</td>
							<td width="10%"></td>
							<td width="10%">
								==
							</td>
							<td width="35%">
								<select id="toCondition_<%=i%>" name="toCondition_<%=i%>" style="width:100%;" class="select" onmouseover="showSelectTitle(this);">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var select = document.getElementById("toCondition_<%=i%>");
									var options = select.options;
									var toId = "<%=dataMapping.getToId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == toId){
											options[i].selected = true;
											break;
										}
									}
								</script>
							</td>
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
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
								<select id="fromCondition_0" name="fromCondition_0" style="width:100%;" class="select" onmouseover="showSelectTitle(this);">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%"></td>
							<td width="10%">
								==
							</td>
							<td width="35%">
								<select id="toCondition_0" name="toCondition_0" style="width:100%;" class="select" onmouseover="showSelectTitle(this);">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
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
								复制数据：
							</td>
						</tr>
						<% if(copyList != null && copyList.size() > 0){
    					for(int k = 0;k<copyList.size();k++){
    						DataMapping dataMapping = copyList.get(k);
    					%>
    					<tr id="<%=k%>">
							<td width="5%"></td>
							<td width="30%">
								<input type="text" id ="targetForm_<%=k%>" name="targetForm_<%=k%>" style="width:100%;" class="inputText" onclick="showTarget(this);" onmouseover="showTitle(this);"  value="<%=dataMapping.getFromIdText()%>">
								<input type="hidden" id ="targetFormVal_<%=k%>" name="targetFormVal_<%=k%>" value="<%=dataMapping.getFromId()%>">
								
							</td>
							<td width="10%" style="font-weight:bold;">
							<button type="button" id ="tarCondition_<%=k%>" name="tarCondition_<%=k%>" href="javascript:void(0)" class="<%if(dataMapping.getCondition()!=null&&dataMapping.getCondition().trim().length()>0&&!"null".equals(dataMapping.getCondition())){out.print("tj_success");}else{out.print("tj");}%>" onclick="showCondition(this)">条件</button>
								<input type="hidden" id ="tarConditionVal_<%=k%>" name="tarConditionVal_0" value="<%=dataMapping.getCondition()%>">
							</td>
							
							<td width="10%">
								-->
							</td>
							<td width="35%">
								<select id="fromData_<%=k%>" name="fromData_<%=k%>" style="width:100%;" class="select" onmouseover="showSelectTitle(this);">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var select = document.getElementById("fromData_<%=k%>");
									var options = select.options;
									var fromId = "<%=dataMapping.getToId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == fromId){
											options[i].selected = true;
											break;
										}
									}
								</script>
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this);"></span>
							</td>
						</tr>
    				<%}
    			}else{%>
						<tr>
							<td width="5%"></td>
							<td width="30%">
								<input type="text" id ="targetForm_0" class="inputText" name="targetForm_0" style="width:100%;" onclick="showTarget(this);" onmouseover="showTitle(this);">
								<input type="hidden" id ="targetFormVal_0" name="targetFormVal_0">
								
							</td>
							<td width="10%" style="font-weight:bold;">
							<button type="button" id ="tarCondition_0" name="tarCondition_0" href="javascript:void(0)" class="tj" onclick="showCondition(this)">条件</button>
								<input type="hidden" id ="tarConditionVal_0" name="tarConditionVal_0">
							</td>
							<td width="10%">
								-->
							</td>
							<td width="35%">
								<select id="fromData_0" name="fromData_0" style="width:100%;" class="select" onmouseover="showSelectTitle(this);">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this);"></span>
							</td>
						</tr>
						<%} %>
						<tr><td style="height:10px;"></td></tr>
					</tbody>
				</table>
			</div>
			<div class="bottom" align="center" style="background-color: #F8F8F8;">
					<div id="dataFormSubmitButton_div"
						class="matrixInline matrixInlineIE"
						style="position: relative;; width: 100px;; height: 22px;">
						<script>
	isc.Button.create( {
		ID : "MdataFormSubmitButton",
		name : "dataFormSubmitButton",
		title : "确认",
		displayId : "dataFormSubmitButton_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		//icon : Matrix.getActionIcon("save"),
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	MdataFormSubmitButton.click = function() {
		Matrix.showMask();
		submitByButton();
		Matrix.hideMask();
	};
</script>
					</div>
					<div id="dataFormCancelButton_div"
						class="matrixInline matrixInlineIE"
						style="position: relative;; width: 100px;; height: 22px;">
						<script>
	isc.Button.create( {
		ID : "MdataFormCancelButton",
		name : "dataFormCancelButton",
		title : "关闭",
		displayId : "dataFormCancelButton_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		//icon : Matrix.getActionIcon("exit"),
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	MdataFormCancelButton.click = function() {
		Matrix.showMask();
		Matrix.closeWindow();
		Matrix.hideMask();
	};
</script>
					</div>
				</div>
				
			<script>
			<%-- 
			isc.Window.create( {
				ID : "MtargetForm",
				id : "targetForm",
				name : "targetForm",
				autoCenter : true,
				position : "absolute",
				height : "98%",
				width : "82%",
				title : "计算公式",
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
				showFooter : false,
				initSrc : "<%=request.getContextPath()%>/form/admin/custom/trigger/tarTransit.jsp?targetFormId=${param.targetFormId}&operateType=${param.operateType}",
				src : "<%=request.getContextPath()%>/form/admin/custom/trigger/tarTransit.jsp?targetFormId=${param.targetFormId}&operateType=${param.operateType}",
				targetDialog : "pdailog"
			});
			--%>
		</script>
		<script>
			<%-- 
			function getParamsFortarCondition() {
			debugger;
				var targetFormId = "${param.targetFormId}";
				var id = Matrix.getFormItemValue("elemId");;
				 var arr=id.split("_");
				var firstCondition = Matrix.getFormItemValue(arr[0]+"Val_"+arr[1]);
				var params = '&';
				var value;
				value = null;
				try {
					value = eval(optString);
				} catch (error) {
					value = optString;
				}
				if (value != null) {
					value = "optString=" + value;
					params += value;
				}
				params += "&";
				try {
					value = eval(targetFormId);
				} catch (error) {
					value = targetFormId;
				}
				if (value != null) {
					value = "targetFormId=" + value;
					params += value;
				}
				return params;
			}
			isc.Window.create( {
				ID : "MtarCondition",
				id : "tarCondition",
				name : "tarCondition",
				autoCenter : true,
				position : "absolute",
				height : "98%",
				width : "82%",
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
				showFooter : false,
				initSrc : "<%=request.getContextPath()%>/form/admin/custom/trigger/transit.jsp",
				src : "<%=request.getContextPath()%>/form/admin/custom/trigger/transit.jsp",
				targetDialog : "pdailog"
			});
			--%>
		</script>		
		</form>
		<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>
	</body>
	
</html>
