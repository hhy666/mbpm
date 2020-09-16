<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.admin.custom.trigger.model.DataMapping"%>
<%@page
	import="com.matrix.form.admin.custom.datainmapping.model.DataInMapping"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数据代入!</title>
<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></script>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<style type="text/css">
.bottom {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	height: 35px;
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
}
tr {
	height: 30px;
}
</style>
<script type="text/javascript">
		var tocheck="${tocheck}";
		var oType = "${param.oType}";
		//editType 对应关系
		var map = {'1':'文本框','2':'日期框','3':'时间框',
					  			'4':'数字框','5':'下拉框','22':'多选下拉框','6':'单选按钮','7':'复选按钮','8':'单选按钮组','9':'复选按钮组','10':'文本域','30':'大文本域',
					  			'11':'列表框','12':'单文件上传','28':'多文件上传','14':'富文本框',
					  			'20':'隐藏域','21':'弹出选择','23':'单选用户','24':'多选用户','25':'单选部门','26':'多选部门',
					  			'29':'流程意见'
					  			};
					  			
		var typeMap={'1':'1','2':'2','3':'3',
					  			'4':'4','5':'5','22':'22','6':'5','7':'7','8':'8','9':'9','10':'10','30':'30',
					  			'11':'11','12':'单文件上传','28':'多文件上传','14':'富文本框',
					  			'20':'20','21':'1','23':'23','24':'24','25':'25','26':'26',
					  			'29':'29'
					  			};//将两个不同组件值设为一样  实现可以在不同的组件中实现数据带入
		window.onload=function(){
			debugger;
			if(document.getElementById("correlation").value=='true'){
				document.getElementById("correlation").checked="checked";
			}
			 var flag=Matrix.getFormItemValue("mappingType");
	 		if(flag!=null&&flag=='0'){
	 			 document.getElementById('j_id13').style.display='';  //显示数据过滤
	 			 document.getElementById('j_id14').style.display='';  //显示关联
	 			 document.getElementById('tbC').style.display="none";
	 			 MtriggerProName.enable();
			 }else{
				 document.getElementById('j_id13').style.display='none';  //隐藏数据过滤
				 document.getElementById('j_id14').style.display='none';  //隐藏关联
	 			document.getElementById('tbC').style.display="";
	 			MtriggerProName.disable(); 	
			 }
		}
		//window.onblur = function(){//离开页面时保存
		 	//MdataFormSubmitButton.click();
		 	///alert("22222");
	//隐藏触发项
	function setStyle(){
	//var childListC = document.getElementById('tbC').childNodes;
	//var childListP = document.getElementById('tbP').childNodes;
	//for(var i=0,len=childListC.length;i<len-1;i++){
    //document.getElementById('tbC').removeChild(childListC[i]);
	//}
	//for(var i=0,len=childListP.length;i<len-1;i++){
   /// document.getElementById('tbP').removeChild(childListP[i]);
	//}
	var value=Matrix.getFormItemValue('formId');//获取表单编码
	 var flag=Matrix.getFormItemValue("mappingType");
	
	/// if(value!=null&&value!=""){
	 if(flag!=null&&flag=='0'){
	 	 document.getElementById('j_id13').style.display='';  //显示数据过滤
	 	 document.getElementById('j_id14').style.display='';  //显示关联
		 document.getElementById('tbC').style.display="none";
	 	 // document.getElementById('triggerProName').value="empty_emp";
	 	MtriggerProName.enable();
	 	rest();
	 	var toData=document.getElementById("toData_0");//重新赋值
			var toCondition=document.getElementById("toCondition_0");
			toData.innerHTML = "";
			toCondition.innerHTML = "";
			toData.options.add(new Option("---------请选择---------", "empty_emp"));
			toCondition.options.add(new Option("---------请选择---------", "empty_emp"));
				var data2 = {'data':{'formId':value}};
			var url = "<%=request.getContextPath()%>/mapping/dataMapping_setTargetOption.action";
				dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    		var opt=callbackJson.option;
						    		 tocheck=callbackJson.tocheck;
						    		for(var i=0;i<opt.length;i++){
						    			toData.options.add(new Option(opt[i].optText, opt[i].optValue));
						    			toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
						    		}
						    	if(flag=='1'){
						      	  //toData.options.add(new Option('流程标题','m_ptitle'));
						      	  }
						    }else{
						    	parent.isc.say('赋值失败');
						    }
						    
							},null);		
	 }else if(flag!=null&&flag=='2'){
		 document.getElementById('j_id13').style.display='none';
		 document.getElementById('j_id14').style.display='none';  
	 		document.getElementById('tbC').style.display="";
	 		MtriggerProName.setValue("empty_emp");
	 		MtriggerProName.disable();
	 		rest();
	 	var fromCondition=document.getElementById("fromCondition_0");
	 	 fromCondition.innerHTML = "";
		fromCondition.options.add(new Option("---------请选择---------", "empty_emp"));
		var url = "<%=request.getContextPath()%>/mapping/dataMapping_setAutomatic.action";
		dataSend(null,url,"POST",function(data2){
			 var callbackStr = data2.data;
			 var callbackJson = isc.JSON.decode(callbackStr);
			if(callbackJson!=null&&callbackJson.result==true){
						    		var opt=callbackJson.option;
						    		for(var i=0;i<opt.length;i++){
						    			fromCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
						    		}
						      	  
						    }else{
						    	parent.isc.say('赋值失败');
						    }
						    
							},null);
			var toData=document.getElementById("toData_0");
			var toCondition=document.getElementById("toCondition_0");
			toData.innerHTML = "";
			toCondition.innerHTML = "";
			toData.options.add(new Option("---------请选择---------", "empty_emp"));
			toCondition.options.add(new Option("---------请选择---------", "empty_emp"));
				var data = {'data':{'formId':value}};
			var url2 = "<%=request.getContextPath()%>/mapping/dataMapping_setTargetOption.action";
				dataSend(data,url2,"POST",function(data){
						    var callbackStr = data.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    		var opt=callbackJson.option;
						    		 tocheck=callbackJson.tocheck;
						    		for(var i=0;i<opt.length;i++){
						    			toData.options.add(new Option(opt[i].optText, opt[i].optValue));
						    			toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
						    		}
						    	if(flag=='1'){
						      	  //toData.options.add(new Option('流程标题','m_ptitle'));
						      	  }
						    }else{
						    	parent.isc.say('赋值失败');
						    }
						    
							},null);
	 }else{
		 document.getElementById('j_id13').style.display='none';
		 document.getElementById('j_id14').style.display='none';
		 document.getElementById('tbC').style.display="";
	 	MtriggerProName.setValue("empty_emp");
	 	MtriggerProName.disable();
	 	rest();
	 	 var obj=document.getElementById('fromData_0');
	 	  var options = obj.options;
	 	 var fromCondition=document.getElementById("fromCondition_0");
	 	 fromCondition.innerHTML = "";
		for(var i=0;i<options.length;i++){
		fromCondition.options.add(new Option(options[i].text, options[i].value));
		}
		var toData=document.getElementById("toData_0");//重新赋值
			var toCondition=document.getElementById("toCondition_0");
			toData.innerHTML = "";
			toCondition.innerHTML = "";
			toData.options.add(new Option("---------请选择---------", "empty_emp"));
			toCondition.options.add(new Option("---------请选择---------", "empty_emp"));
				var data2 = {'data':{'formId':value}};
			var url = "<%=request.getContextPath()%>/mapping/dataMapping_setTargetOption.action";
				dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    		var opt=callbackJson.option;
						    		 tocheck=callbackJson.tocheck;
						    		for(var i=0;i<opt.length;i++){
						    			toData.options.add(new Option(opt[i].optText, opt[i].optValue));
						    			toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
						    		}
						    	if(flag=='1'){
						      	 // toData.options.add(new Option('流程标题','m_ptitle'));
						      	  }
						    }else{
						    	parent.isc.say('赋值失败');
						    }
						    
							},null);
	 }
	// }else{
	 	//warn("请选择关联表单");
	 	//return;
	 }
	//}
	function rest(){
		var selects = document.getElementsByTagName("select");
		var divisionTr = document.getElementById("division");//获取分界线所在行
	var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		for(var i=((lineIndex-3)*2)-2;i>0;i=i-2){
			 var tr = selects[i].parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('tb');
			var conditionTr = document.getElementById("condition");//获取分界线所在行
			var conIndex = conditionTr.rowIndex;//获取分界线的行号
			if(index!=conIndex+1){
					tb.deleteRow(index);			
				
			}
		}
		var pselects = document.getElementsByTagName("select");
		for(var i=pselects.length-2;i>2;i=i-2){
			 var tr = pselects[i].parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('tb');
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var divisiondex = divisionTr.rowIndex;//获取分界线的行号
			if(index!=divisiondex+1){
					tb.deleteRow(index);			
				
			}
		}
		document.getElementById("fromCondition_0").value="empty_emp";
		document.getElementById("fromData_0").value="empty_emp";
		document.getElementById("toCondition_0").value="empty_emp";
		document.getElementById("toData_0").value="empty_emp";
	}
	//给formId赋值  给目标表单加option
	function onflowClose(record){
	var selects = document.getElementsByTagName("select");
	var mappingType=Matrix.getFormItemValue("mappingType");
		var divisionTr = document.getElementById("division");//获取分界线所在行
	var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		for(var i=((lineIndex-3)*2)-2;i>0;i=i-2){
			 var tr = selects[i].parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('tb');
			var conditionTr = document.getElementById("condition");//获取分界线所在行
			var conIndex = conditionTr.rowIndex;//获取分界线的行号
			if(index!=conIndex+1){
					tb.deleteRow(index);			
				
			}
		}
		var pselects = document.getElementsByTagName("select");
		for(var i=pselects.length-2;i>2;i=i-2){
			 var tr = pselects[i].parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('tb');
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var divisiondex = divisionTr.rowIndex;//获取分界线的行号
			if(index!=divisiondex+1){
					tb.deleteRow(index);			
				
			}
		}
		document.getElementById("fromCondition_0").value="empty_emp";
		document.getElementById("fromData_0").value="empty_emp";
	 if(record!=null && record!=""){
			var value=eval('('+record+')');  
			var data;
			var value;
			data=value.text;
			value=value.id;
			var toData=document.getElementById("toData_0");
			var toCondition=document.getElementById("toCondition_0");
			toData.innerHTML = "";
			toCondition.innerHTML = "";
			toData.options.add(new Option("---------请选择---------", "empty_emp"));
			toCondition.options.add(new Option("---------请选择---------", "empty_emp"));
				var data2 = {'data':{'formId':value}};
			var url = "<%=request.getContextPath()%>/mapping/dataMapping_setTargetOption.action";
				dataSend(data2,url,"POST",function(data2){
						    var callbackStr = data2.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    		var opt=callbackJson.option;
						    		 tocheck=callbackJson.tocheck;
						    		for(var i=0;i<opt.length;i++){
						    			toData.options.add(new Option(opt[i].optText, opt[i].optValue));
						    			toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
						    		}
						    	if(mappingType=='1'){
						      	  toData.options.add(new Option('流程标题','m_ptitle'));
						      	  }
						    }else{
						    	parent.isc.say('赋值失败');
						    }
						    
							},null);
      		Matrix.setFormItemValue('formValue',data);
			Matrix.setFormItemValue('formId',value);
      }  
	}
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
			flag = "==";
		}else{
			flag = "<--";
		}
		var str = "<td width=\"35%\"><select style=\"width:90%;\" class=\"select\">";
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
		str = "<td width=\"35%\"><select style=\"width:90%;\" class=\"select\">";
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
	}
	
		function addRow2(element){  //新加一行数据复制
		var tr = element.parentNode.parentNode; //获取当前行对象
		var index = tr.rowIndex;
		var tb = document.getElementById('tb');
		var newTr = tb.insertRow(index+1); //在下方插入新的一行
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td width=\"10%\"></td>";
		var newTd2 = newTr.insertCell();
		var select1 = document.getElementsByName("fromData_0")[0];
		var select2 = document.getElementsByTagName("select")[1];
		var flag; 
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			flag = "==";
		}else{
			flag = "<--";
		}
		var str = "<td width=\"35%\"><select style=\"width:90%;\" class=\"select\">";
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
			newTd3.innerHTML = "<td>"+ flag +"</td>";
		
		var newTd4 = newTr.insertCell();
		str = "<td width=\"35%\"><select style=\"width:90%;\" class=\"select\">";
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
			newTd5.innerHTML = "<td width=\"10%\"><span class=\"ico16 oprate_plus_16 right\" onclick=\"addRow2(this)\"></span>&nbsp;<span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this);\"></span></td>";
	}
	
	function delRow(element){  //删除一行
			var tr = element.parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('tb');
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var lineIndex = divisionTr.rowIndex;//获取分界线的行号
			var divisionTr = document.getElementById("condition");//获取分界线所在行
			var conIndex = divisionTr.rowIndex;//获取分界线的行号
			if(index!=conIndex+1&&index!=lineIndex+1){
			if(index < lineIndex){
				if(lineIndex != 4){
					tb.deleteRow(index);
					return;				
				}
			}
			if(index > lineIndex){
				if(tb.rows.length-lineIndex > 2){
					tb.deleteRow(index);
					return;
				}
			}
			}else{
				warn("此行为不可删除项");
			}
		}
	//校验触发项
	function checkTrigger(){
	var mappingType=Matrix.getFormItemValue("mappingType");
		if(mappingType=="0"){
		var value=Matrix.getFormItemValue("triggerProName");
		if(value==""||value==null||value==undefined){
			warn("请选择触发属性!");
			return false;
		}else{ return true;}
		}else{
			return true;
		}
	}
	function submitByButton(){ //点击确认
			var check=${check};
			//map=isc.JSON.decode(map);
		if (oType != null && "update" == oType) {//添加
			if(typeof(tocheck)=='string'){
			tocheck=isc.JSON.decode(tocheck);
			}
		}
			var selects = document.getElementsByTagName("select");
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var lineIndex = divisionTr.rowIndex;//获取分界线的行号
			var mappingName=Matrix.getFormItemValue("name");
			var mappingType=Matrix.getFormItemValue("mappingType");
			var formId=Matrix.getFormItemValue("formId");
			var triggerProName=Matrix.getFormItemValue("triggerProName");
			
		    var popupConditionOne=Matrix.getFormItemValue("popupCondition");    //获得条件
		    //条件里面单引号里面如果还有引号
		   	var popupCondition = popupConditionOne.replace(/'/g, '"');  
		    var isViewReleForm=false;				 					//是否查看关联
		    if(document.getElementById("correlation").checked==true){
		    	isViewReleForm=true;
		    } 
		    
			var str;
			if(mappingType == '1'){  //等于1说明操作类型为用户带入
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromPro;
				var toPro;
				var fromVal;
				var toVal;
				var fromFlag;
				var toFlag;
				var flag=0;
				var tflag=0;
				str="{\'data\':{'name':'";
			str+=mappingName;
			str+="','mappingType':'";
			str+=mappingType;
			str+="','formId':'";
			str+=formId;
			str+="','isViewReleForm':'";
			str+=isViewReleForm;
			str+="','popupCondition':'";
			str+=popupCondition;
			
			str+="',";
				str+= "\'condition\':[";
				var conditionRows = lineIndex-3; // 获得条件行数
				for(var i=0;i<conditionRows*2;i++){
					var index = selects[i].selectedIndex;
					var value = selects[i].options[index].value;
					var text = selects[i].options[index].text;
					var arry = value.split(".");
					var table=text.substring(1,3);
					if(i%2 == 0){
						if("子表"==table){
							if(flag==0){
								fromFlag=arry[0]; 
								flag++;
							}
							if(arry[0]!=fromFlag){
							warn("请选择主表或同一子表中的数据");
							return;
							}
						}
						if(value!='empty_emp'){
						str = str+ "{'fromCondition_"+m+"':'";
						str += value;
						str += "',";
						}
						m++;
						fromPro = text;
						fromVal=value;
						fromType = check[value];
					}else{
						if("子表"==table){
							if(tflag==0){
								toFlag=arry[0]; 
								tflag++;
							}					
							if(arry[0]!=toFlag){
								warn("请选择主表或同一子表中的数据");
								return;
							}
						}
						if(value!='empty_emp'){
						str = str + "'toCondition_"+n+"':'";
						str += value;
						str += "'},";
						}
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == 'empty_emp'&& toVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == 'empty_emp'&& fromVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
							if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
								if(typeMap[fromType] != typeMap[toType]){
									warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
									return;
								}
							}
						
						}
						else{
							if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
//							if(typeMap[fromType] != typeMap[toType]){
								warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
								return;
							}
						}
					}
				}
				var c=str.charAt(str.length - 1);
				if(c!='['){
				str = str.substring(0,str.length-1);
				}
				str += "],'copyData':[";
				m = 0;
				n = 0;
				var copyDataRows = selects.length/2-conditionRows;//获取复制数据的行数
				for(var i=0;i<copyDataRows*2;i++){
					var j = i + conditionRows*2;
					var index = selects[j].selectedIndex;
					var value = selects[j].options[index].value;
					var text = selects[j].options[index].text;
					var arry = value.split(".");
					var table=text.substring(1,3);
					if(i%2==0){
						if("子表"==table){
						if(flag==0){
								fromFlag=arry[0]; 
								flag++;
							}
							if(arry[0]!=fromFlag){
							warn("请选择主表或同一子表中的数据");
							return;
							}
						}
						if(value!='empty_emp'){
						str = str+"{'fromData_"+m+"':'";
						str += value;
						str += "',";
						}
						m++;
						fromPro = text;
						fromval=value;
						fromType = check[value];
					}else{
							if("子表"==table){
							if(tflag==0){
								toFlag=arry[0]; 
								tflag++;
							}	
								if(arry[0]!=toFlag){
								warn("请选择主表或同一子表中的数据");
								return;
								}
							}
					if(value!='empty_emp'){
						str = str+"'toData_"+n+"':'";
							str += value;
							str += "'},";
					}
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == 'empty_emp'&& toVal == 'empty_emp' && copyDataRows == 1){
							warn("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromVal == 'empty_emp'&& toVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == 'empty_emp'&& fromVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal!='m_ptitle'){
						if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
							if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
								if(typeMap[fromType] != typeMap[toType]){
									warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
									return;
								}
							}
						
						}
						else{
							if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
//							if(typeMap[fromType] != typeMap[toType]){
								warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
								return;
							}
						}
						}
					}
				}
				var c=str.charAt(str.length - 1);
				if(c!='['){
				str = str.substring(0,str.length-1);
				}
				str += "]}}";
			}else if(mappingType=='2'){
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromPro;
				var toPro;
				var fromVal;
				var toVal;
				var fromFlag;
				var toFlag;
				var flag=0;
				var tflag=0;
				str="{\'data\':{'name':'";
			str+=mappingName;
			str+="','mappingType':'";
			str+=mappingType;
			str+="','formId':'";
			str+=formId;
			str+="','isViewReleForm':'";
			str+=isViewReleForm;
			str+="','popupCondition':'";
			str+=popupCondition;
			str+="',";
			
				str+= "\'condition\':[";
				var conditionRows = lineIndex-3; // 获得条件行数
				for(var i=0;i<conditionRows*2;i++){
					var index = selects[i].selectedIndex;
					var value = selects[i].options[index].value;
					var text = selects[i].options[index].text;
					var arry = value.split(".");
					var table=text.substring(1,3);
					if(i%2 == 0){
						if("子表"==table){
							if(flag==0){
								fromFlag=arry[0]; 
								flag++;
							}
							if(arry[0]!=fromFlag){
							warn("请选择主表或同一子表中的数据");
							return;
							}
						}
						str = str+ "{'fromCondition_"+m+"':'";
						str += value;
						str += "',";
						m++;
						fromPro = text;
						fromVal=value;
						fromType = check[value];
					}else{
						if("子表"==table){
							if(tflag==0){
								toFlag=arry[0]; 
								tflag++;
							}					
							if(arry[0]!=toFlag){
								warn("请选择主表或同一子表中的数据");
								return;
							}
						}
						str = str + "'toCondition_"+n+"':'";
						str += value;
						str += "'},";
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == 'empty_emp'&& toVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == 'empty_emp'&& fromVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
					}
				}
				var c=str.charAt(str.length - 1);
				if(c!='['){
				str = str.substring(0,str.length-1);
				}
				str += "],'copyData':[";
				m = 0;
				n = 0;
				var copyDataRows = selects.length/2-conditionRows;//获取复制数据的行数
				for(var i=0;i<copyDataRows*2;i++){
					var j = i + conditionRows*2;
					var index = selects[j].selectedIndex;
					var value = selects[j].options[index].value;
					var text = selects[j].options[index].text;
					var arry = value.split(".");
					var table=text.substring(1,3);
					if(i%2==0){
						if("子表"==table){
						if(flag==0){
								fromFlag=arry[0]; 
								flag++;
							}
							if(arry[0]!=fromFlag){
							warn("请选择主表或同一子表中的数据");
							return;
							}
						}
						if(value!='empty_emp'){
						str = str+"{'fromData_"+m+"':'";
						str += value;
						str += "',";
						}
						m++;
						fromPro = text;
						fromval=value;
						fromType = check[value];
					}else{
							if("子表"==table){
							if(tflag==0){
								toFlag=arry[0]; 
								tflag++;
							}	
								if(arry[0]!=toFlag){
								warn("请选择主表或同一子表中的数据");
								return;
								}
							}
					if(value!='empty_emp'){
						str = str+"'toData_"+n+"':'";
						str += value;
						str += "'},";
						}
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == 'empty_emp'&& toVal == 'empty_emp' && copyDataRows == 1){
							warn("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromVal == 'empty_emp'&& toVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == 'empty_emp'&& fromVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
							if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
								if(typeMap[fromType] != typeMap[toType]){
									warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
									return;
								}
							}
						
						}
						else{
							if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
//							if(typeMap[fromType] != typeMap[toType]){
								warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
								return;
							}
						}
					}
				}
				var c=str.charAt(str.length - 1);
				if(c!='['){
				str = str.substring(0,str.length-1);
				}
				str += "]}}";
			}else{
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromPro;
				var toPro;
				var fromVal;
				var toVal;
				str="{\'data\':{'name':'";
			str+=mappingName;
			str+="','mappingType':'";
			str+=mappingType;
			str+="','triggerProName':'";
			str+=triggerProName;
			str+="','formId':'";
			str+=formId;;
			str+="','isViewReleForm':'";
			str+=isViewReleForm;
			str+="','popupCondition':'";
			str+=popupCondition;
			str+="',";
				str+= "\'copyData\':[";
				for(var i=2;i<selects.length;i++){
					var index = selects[i].selectedIndex;
					var value = selects[i].options[index].value;
					var text = selects[i].options[index].text;
					var array = value.split("_");
					if(i%2==0){
					if(value!='empty_emp'){
						str = str+"{'fromData_"+m+"':'";
						str += value;
						str += "',";
						}
						m++;
						fromPro = text;
						fromVal=value;
						fromType = check[value];
					}else{
					if(value!='empty_emp'){
						str = str+"'toData_"+n+"':'";
						str += value;
						str += "'},";
						}
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == 'empty_emp'&& toVal == 'empty_emp' && selects.length/2 == 1){
							warn("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromVal == 'empty_emp'&& toVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == 'empty_emp'&& fromVal != 'empty_emp'){
							warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
							if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
								if(typeMap[fromType] != typeMap[toType]){
									warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
									return;
								}
							}
						
						}
						else{
							if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
//							if(typeMap[fromType] != typeMap[toType]){
								warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
								return;
							}
						}
					}
				}
				var c=str.charAt(str.length - 1);
				if(c!='['){
				str = str.substring(0,str.length-1);
				}
				str += "]}}";
			}
			//var strObj = str.replace(/'/g, '"');  单引号变成双引号
			
			var data=isc.JSON.decode(str);
			if(oType=='add'){
			var url = "<%=request.getContextPath()%>/mapping/dataMapping_save.action";
			Matrix.sendRequest(url,data,function(data){
				var callbackStr = data.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
						    	say("保存成功");
							   	 	parent.Matrix.refreshDataGridData('DataGrid001');
							   	 	oType='update';
							   	 	var size=parent.MDataGrid001.getData().size();
							   	 	Matrix.setFormItemValue("uuid",size);
							   	 	}
			});
			}else{
				var uuid=Matrix.getFormItemValue("uuid");
				var urlu = "<%=request.getContextPath()%>/mapping/dataMapping_update.action?uuid="+uuid;
				Matrix.sendRequest(urlu,data,function(data){
				var callbackStr = data.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
						    	say("更新成功");
							   	 	parent.Matrix.refreshDataGridData('DataGrid001');
							   	 	}
			});
			}
	}
</script>
<script src="<%=path%>/resource/html5/js/jquery.min.js"></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
</head>
<body>
	<%
		List<DataMapping> conditionCopyList = new ArrayList<DataMapping>();
		List<DataMapping> copyList = new ArrayList<DataMapping>();
		DataInMapping dataInMapping = new DataInMapping();
	%>
	<%
		String oType = request.getParameter("oType");
		if (oType.equals("update")) {
			dataInMapping = (DataInMapping) request.getAttribute("dimData");
			conditionCopyList = dataInMapping.getConditionList();
			copyList = dataInMapping.getPropetyList();
		}
		List<String> fromEntVal = (List<String>) request.getAttribute("fromEntVal");
		List<String> fromColVal = (List<String>) request.getAttribute("fromColVal");
		List<String> fromEnAmVal = (List<String>) request.getAttribute("fromEnAmVal");
		List<String> fromColAmVal = (List<String>) request.getAttribute("fromColAmVal");
		List<String> toEntVal = (List<String>) request.getAttribute("toEntVal");
		List<String> toColVal = (List<String>) request.getAttribute("toColVal");
		String index = new String("1"); //所修改数据的index
		String optString = new String("0");// 判断是添加(0)还是修改(1)
	%>
	<jsp:include page="/form/admin/common/loading.jsp" />
	<div id="j_id1" jsId="j_id1"
		style="position: relative; _layout: flowlayout; width: 100%; height: 100%;">
		<script>
	var MForm0 = isc.MatrixForm.create( {
		ID : "MForm0",
		name : "MForm0",
		position : "absolute",
		action : "",
		fields : [ {
			name : 'Form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'Form0_hidden_text_div'
		} ]
	});
</script>
		<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
			action="query/code_addCode.action" style="margin: 0px; height: 100%;"
			enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="Form0" value="Form0" /> <input
				type="hidden" id="parentNodeId" name="parentNodeId"
				value="${param.parentNodeId}" />
			<!-- add or update -->
			<input type="hidden" id="oType" name="oType" value="${param.oType}" />

			<input type="hidden" id="parentUUID" name="parentUUID"
				value="${codeNode.parentId}" />
			<!-- id 需要和显示值mid处理好 -->
			<input type="hidden" id="type" name="type" value="${codeNode.type}" />
			<input type="hidden" id="formId" name="formId"
				value="${dimData.formId}" /> <input type="hidden" id="tocheck"
				name="tocheck" value="${tocheck}" /> <input type="hidden"
				id="order" name="order" value="${codeNode.index}" /> <input
				type="hidden" id="uuid" name="uuid" value="${param.uuid}" />
			<div type="hidden" id="Form0_hidden_text_div"
				name="Form0_hidden_text_div"
				style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
			<div id="tabContainer0_div" class="matrixComponentDiv"
				style="width: 100%; height: 100%;; position: relative;">
				<script>
	var MtabContainer0 = isc.TabSet
			.create( {
				ID : "MtabContainer0",
				displayId : "tabContainer0_div",
				height : "100%",
				width : "100%",
				position : "relative",
				align : "center",
				tabBarPosition : "top",
				tabBarAlign : "left",
				showPaneContainerEdges : false,
				showTabPicker : true,
				showTabScroller : true,
				selectedTab : 1,
				tabBarControls : [ isc.MatrixHTMLFlow.create( {
					ID : "MtabContainer0Bar0",
					width : "300px",
					contents : "<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
				}) ],
				tabs : [ {
					title : ("add" == "${param.oType}") ? "添加数据带入" : "更新数据带入", 
					pane : isc.MatrixHTMLFlow
							.create( {
								ID : "MtabContainer0Panel0",
								width : "100%",
								height : "100%",
								overflow : "hidden",
								contents : "<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"
							})
				} ]
			});
	document.getElementById('tabContainer0_div').style.display = 'none';
	MtabContainer0.selectTab(0);
	isc.Page.setEvent("load", "MtabContainer0.selectTab(0);");
</script>
			</div>
			<div id="tabContainer0Bar0_div2" style="text-align: right"
				class="matrixInline"></div>
			<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(
			document.getElementById('tabContainer0Bar0_div2'));
</script>
			<div id="tabContainer0Panel0_div2"
				style="width: 100%; height: 100%; overflow: auto;"
				class="matrixInline">
				<div style="text-valign: center; position: relative">
					<table id="j_id3" jsId="j_id3" class="maintain_form_content">
						<tr id="j_id9" jsId="j_id9">
							<td id="j_id110" jsId="j_id110" class="maintain_form_label"
								colspan="1" rowspan="1" style="text-align: left; width: 20%">
								<label id="j_id11" name="j_id11" style="margin-left: 10px">
									名称： </label>
							</td>
							<td id="j_id12" jsId="j_id12" class="maintain_form_input"
								colspan="3" rowspan="1" style="width: 80%">
								<div id="name_div" eventProxy="MForm0"
									class="matrixInline matrixInlineIE" style="width: 70%"></div> <script>
	var name2 = isc.TextItem.create( {
		ID : "Mname",
		name : "name",
		editorType : "TextItem",
		displayId : "name_div",
		position : "relative",
		value : "${dimData.name}",
		width : "100%",
		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return inputNameValidate(item, validator, value, record);
			},
			errorMessage : "名称不能为空!"
		} ]
	});
	MForm0.addField(name2);
</script> <span id="MultiLabel1"
								style="width: 19px; height: 20px; color: #FF0000">*</span> <span
								id="nameEchoMessage" style="color: #FF0000">${idEchoMessage}</span>
							</td>
						</tr>
						<tr id="j_id19" jsId="j_id19">
							<td id="j_id20" jsId="j_id20" class="maintain_form_label"
								colspan="1" rowspan="1" style="text-align: left; width: 20%;">
								<label id="j_id51" name="j_id51" style="margin-left: 10px">
									类型： </label>
							</td>
							<td id="j_id22" jsId="j_id22" class="maintain_form_input"
								style="width: 30%">
								<div id="mappingType_div" eventProxy="MForm0"
									class="matrixInline matrixInlineIE" style="width: 90%"></div> <script>
	var MmappingType_VM=[];
		    var mappingType=isc.SelectItem.create({
		    		ID:"MmappingType",
		    		name:"mappingType",
		    		editorType:"SelectItem",
		    		displayId:"mappingType_div",
		    		valueMap:[],
		    		value:"${dimData.mappingType=='1'?'1':dimData.mappingType=='2'?'2':'0'}",
		    		position:"relative",
		    		width:"100%",
		    		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return inputNameValidate(item, validator, value, record);
			},
			errorMessage : "类型不能为空!"
		} ],
			changed:"setStyle();"
		    });
		    MForm0.addField(mappingType);
		    MmappingType_VM=['0','1','2'];
		    MmappingType.displayValueMap={'0':'弹出选择带入','1':'用户输入带入','2':'系统自动带入'};
		    MmappingType.setValueMap(MmappingType_VM);
		   // MmappingType.setValue('0');
</script>
							</td>
							<td id="j_id234" jsId="j_id234" class="maintain_form_label"
								rowspan="1" style="text-align: left; width: 20%"><label
								id="j_id77" name="j_id77" style="margin-left: 10px">
									触发属性： </label></td>
							<td id="j_id233" jsId="j_id233" class="maintain_form_input"
								rowspan="1" style="width: 20%">
								<div id="triggerProName_div" eventProxy="MForm0"
									class="matrixInline matrixInlineIE" style="width: 90%"></div> <script>

	var MtriggerProName_VM=<%=request.getAttribute("valmap")%>;
		    var triggerProName=isc.SelectItem.create({
		    		ID:"MtriggerProName",
		    		name:"triggerProName",
		    		editorType:"SelectItem",
		    		valueMap:[],
		    		displayValueMap:<%=request.getAttribute("triggerProName")%>,
		    		displayId:"triggerProName_div",
		    		value:"${dimData.triggerProName!=null?dimData.triggerProName:dimData.triggerProName!=''?dimData.triggerProName:'empty_emp'}",
		    		position:"relative",
		    		width:"100%"
		    });
		    MForm0.addField(triggerProName);
		    MtriggerProName.setValueMap(MtriggerProName_VM);
</script>
							</td>
						</tr>
						<tr id="j_id19" jsId="j_id19">
							<td id="j_id101" jsId="j_id101" class="maintain_form_label"
								colspan="1" rowspan="1" style="text-align: left; width: 20%">
								<label id="j_id111" name="j_id111" style="margin-left: 10px">
									关联表单： </label>
							</td>
							<td id="j_id121" jsId="j_id121" class="maintain_form_input"
								colspan="3" rowspan="1" style="width: 80%; height: 40px;">
								<div id="formId_div" eventProxy="MForm0"
									class="matrixInline matrixInlineIE"
									style="width: 70%; height: 40px;"></div> 
								 <script>
									var formValue = isc.TextItem.create( {
										ID : "MformValue",
										name : "formValue",
										editorType : "TextItem",
										displayId : "formId_div",
										position : "relative",
										value : "${dimData.formName}",
										width : "100%",
										height:"100%",
										click:" Matrix.showWindow('flow');",
										hint:"请选择表单",
										showHintInField:true,
										canEdit:false,
										required:true,
									});
									MForm0.addField(formValue);
								</script> 
							<span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span> 
							<span id="nameEchoMessage" style="color: #FF0000">${echoMessage}</span>
						   </td>
						</tr>

						<!--数据过滤  -->
						<tr id="j_id13" jsId="j_id13" style="display: none;">
							<td id="j_id113" jsId="j_id113" class="maintain_form_label"
								colspan="1" rowspan="1" style="text-align: left; width: 20%"">
								<label id="j_id11" name="j_id11" style="margin-left: 10px">
									数据过滤： </label>
							</td>
							<td id="j_id12" jsId="j_id12" class="maintain_form_input"
								colspan="3" rowspan="1" style="width:80%;">
								<div id="popupCondition_div" eventProxy="MForm0"
									class="matrixInline matrixInlineIE" style="width: 70%;height: 70px; "></div> <script>
									var popupCondition2 = isc.TextAreaItem.create( {
										ID : "MpopupCondition",
										name : "popupCondition",
										editorType : "TextAreaItem",
										displayId : "popupCondition_div",
										position : "relative",
										value : "${dimData.popupCondition}",
										width : "100%",
										height:70,
										canEdit : false,
									});
									MForm0.addField(popupCondition2);
							</script> <span id="MultiLabel1"
								style="width: 19px; height: 20px; color: #FF0000"> <input
									type="button" value="设置" onclick="popup()" />
									 <script type="text/javascript">
										
											function popup(){
												var conditionValue=MpopupCondition.getValue();   //获得文本框的条件值
												var associatedFormId=Matrix.getFormItemValue('formId');;  //获得隐藏域中选中关联表单的mUuid
												parent.parent.openCondiation(conditionValue,associatedFormId,this);		
											}
										
										  </script>
							</span>

							</td>
						</tr>
						
						<tr id="j_id14" jsId="j_id14" style="display:none;">
							<td id="j_id114" jsId="j_id114" class="maintain_form_label"
								colspan="1" rowspan="1" style="text-align: left; width: 20%">
								<label id="j_id15" name="j_id15" style="margin-left: 10px">
									插入单据显示： </label>
							</td>
							<td id="j_id16" jsId="j_id16" class="maintain_form_input"
								colspan="3" rowspan="1" style="width: 80%;">
								<input type="checkbox" id="correlation" value="${dimData.isViewReleForm}"  style="vertical-align: middle; margin-top: -2px; margin-bottom: 1px;" />
							</td>
						</tr>

						<tr id="j_id201" jsId="j_id201">
							<td id="j_id10" jsId="j_id10" colspan="4" rowspan="1"
								style="width: 100%">
								<div id="main" style="height: 92%;">
									<table class="" id="tb" style="width: 100%; overflow: auto;">
										<tbody id="tbC">
											<tr>
												<td width="10%"></td>
												<td width="35%"><span style="margin-left: 40px;">当前表单</span>
												</td>
												<td width="10%"></td>
												<td width="35%"><span style="margin-left: 35px;">关联表单</span>
												</td>
												<td width="10%"></td>
											</tr>
											<%
												if (true) {
											%>
											<tr id="condition">
												<td colspan="5">关联条件：</td>
											</tr>

											<%
												if (("2".equals(dataInMapping.getMappingType()))
															|| (conditionCopyList != null && conditionCopyList.size() > 0)) {
														int i = 0;
														boolean flag = true;
														for (DataMapping dataMapping : conditionCopyList) {
											%>
											<tr>
												<td width="10%"></td>
												<td width="35%"><select id="fromCondition_<%=i%>" style="width:90%;" class="select"
													name="fromCondition_<%=i%>">
														<option value="empty_emp">---------请选择---------</option>
														<%
															if ("2".equals(dataInMapping.getMappingType())) {
																			for (int j = 0; j < fromEnAmVal.size(); j++) {
														%>
														<option value="<%=fromEnAmVal.get(j)%>"><%=fromColAmVal.get(j)%></option>
														<%
															}
														%>
														<%
															} else {
																			for (int j = 0; j < fromEntVal.size(); j++) {
														%>
														<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
														<%
															}
																		}
														%>
												</select> <script type="text/javascript">
									var select = document.getElementById("fromCondition_<%=i%>");
									var options = select.options;
									var fromId = "<%=dataMapping.getFromId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == fromId){
											options[i].selected = true;
											break;
										}
									}
								</script></td>
												<td width="10%">==</td>
												<td width="35%"><select id="toCondition_<%=i%>" style="width:90%;" class="select"
													name="toCondition_<%=i%>">
														<option value="empty_emp">---------请选择---------</option>
														<%
															for (int j = 0; j < toEntVal.size(); j++) {
														%>
														<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
														<%
															}
														%>
												</select> <script type="text/javascript">
									var select = document.getElementById("toCondition_<%=i%>");
									var options = select.options;
									var toId = "<%=dataMapping.getToId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == toId){
											options[i].selected = true;
											break;
										}
									}
								</script></td>
												<td width="10%"><span id="add"
													class="ico16 oprate_plus_16 right" onclick="addRow(this);"></span>
													<span id="del" class="ico16 oprate_reduce_16 right"
													onclick="delRow(this);"></span></td>
											</tr>
											<%
												i++;
														}
											%>
											<tr>
												<td colspan="5">
													<hr />
												</td>
											</tr>
											<%
												} else {
											%>
											<tr>
												<td width="10%"></td>
												<td width="35%"><select id="fromCondition_0" style="width:90%;" class="select"
													name="fromCondition_0">
														<option value="empty_emp">---------请选择---------</option>
														<%
															for (int j = 0; j < fromEntVal.size(); j++) {
														%>
														<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
														<%
															}
														%>
												</select></td>
												<td width="10%">==</td>
												<td width="35%"><select id="toCondition_0" style="width:90%;" class="select"
													name="toCondition_0">
														<option value="empty_emp">---------请选择---------</option>
														<%
															for (int j = 0; j < toEntVal.size(); j++) {
														%>
														<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
														<%
															}
														%>
												</select></td>
												<td width="10%"><span id="add"
													class="ico16 oprate_plus_16 right" onclick="addRow(this);"></span>
													<span id="del" class="ico16 oprate_reduce_16 right"
													onclick="delRow(this);"></span></td>
											</tr>
											<tr>
												<td colspan="5">
													<hr />
												</td>
											</tr>
											<%
												}
												}
											%>
										</tbody>
										<!--********************** 数据复制部分 ************************ -->
										<tbody>
											<tr id="division">
												<td colspan="5">关联属性：</td>
											</tr>
											<%
												if (copyList != null && copyList.size() > 0) {
													for (int k = 0; k < copyList.size(); k++) {
														DataMapping dataMapping = copyList.get(k);
											%>
											<tr>
												<td width="10%"></td>
												<td width="35%"><select id="fromData_<%=k%>" style="width:90%;" class="select"
													name="fromData_<%=k%>">
														<option value="empty_emp">---------请选择---------</option>
														<%
															for (int j = 0; j < fromEntVal.size(); j++) {
														%>
														<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
														<%
															}
														%>
												</select> <script type="text/javascript">
									var select = document.getElementById("fromData_<%=k%>");
									var options = select.options;
									var fromId = "<%=dataMapping.getFromId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == fromId){
											options[i].selected = true;
											break;
										}
									}
								</script></td>
												<td width="10%"><--</td>
												<td width="35%"><select id="toData_<%=k%>" style="width:90%;" class="select"
													name="toData_<%=k%>">
														<option value="empty_emp">---------请选择---------</option>
														<%
															for (int j = 0; j < toEntVal.size(); j++) {
														%>
														<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
														<%
															}
														%>
														<%
															if ("1".equals(dataInMapping.getMappingType())) {
														%>
														<option value="m_ptitle">流程标题</option>
														<%
															}
														%>
												</select> <script type="text/javascript">
									var select = document.getElementById("toData_<%=k%>");
									var options = select.options;
									var toId = "<%=dataMapping.getToId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == toId){
											options[i].selected = true;
											break;
										}
									}
								</script></td>
												<td width="10%"><span id="add"
													class="ico16 oprate_plus_16 right" onclick="addRow2(this);"></span>
													<span id="del" class="ico16 oprate_reduce_16 right"
													onclick="delRow(this);"></span></td>
											</tr>
											<%
												}
												} else {
											%>
											<tr>
												<td width="10%"></td>
												<td width="35%"><select id="fromData_0" style="width:90%;" class="select"
													name="fromData_0">
														<option value="empty_emp">---------请选择---------</option>
														<%
															for (int j = 0; j < fromEntVal.size(); j++) {
														%>
														<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
														<%
															}
														%>
												</select></td>
												<td width="10%"><--</td>
												<td width="35%"><select id="toData_0" name="toData_0" style="width:90%;" class="select">
														<option value="empty_emp">---------请选择---------</option>
														<%
															for (int j = 0; j < toEntVal.size(); j++) {
														%>
														<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
														<%
															}
														%>

												</select></td>
												<td width="10%"><span id="add"
													class="ico16 oprate_plus_16 right" onclick="addRow2(this);"></span>
													<span id="del" class="ico16 oprate_reduce_16 right"
													onclick="delRow(this);"></span></td>
											</tr>
											<%
												}
											%>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
<tr id="tr117">
					<td id="td133" colspan="3" rowspan="1"
							style="width: 100%;height:50px"/>
</tr>							
						<tr id="j_id27" jsId="j_id27">
							<td id="j_id28" jsId="j_id28" class="cmdLayout"
								colspan="4" rowspan="1" style="width: 100%;border-top: 0px;">
								<div id="dataFormSubmitButton_div"
									class="matrixInline matrixInlineIE"
									style="position: relative; width: 100px; height: 22px;">
									<script>
	isc.Button.create( {
		ID : "MdataFormSubmitButton",
		name : "dataFormSubmitButton",
		title : "保存",
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
		//表单验证
		if (!MForm0.validate()) {
			Matrix.hideMask();
			return false;
		}

		//触发项验证
		if(checkTrigger()){
		submitByButton();
		Matrix.hideMask();
		}else{
			Matrix.hideMask();
		}
	};
</script>
								</div> <!--								</td>-->
						</tr>
					</table>
				</div>


			</div>
			<script>
	document.getElementById('tabContainer0Panel0_div').appendChild(
			document.getElementById('tabContainer0Panel0_div2'));
	document.getElementById('tabContainer0_div').style.display = '';
</script>
			<script>
	function getParamsForflow() {
		var params = '&';
		var value;
		value = null;
		try {
			value = eval("1");
		} catch (error) {
			value = "1"
		}
		if (value != null) {
			value = "test=" + value;
			params += value;
		}
		return params;
	}
	isc.Window.create( {
		ID : "Mflow",
		id : "flow",
		name : "flow",
		autoCenter : true,
		position : "absolute",
		height : "95%",
		width : "70%",
		title : "选择表单",
		canDragReposition : true,
		showMinimizeButton : false,
		showMaximizeButton : true,
targetDialog : "mainDialog2",
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
		   				"maximizeButton", "closeButton" ],
		   		getParamsFun : getParamsForflow,
		   		initSrc : "<%=request.getContextPath()%>/form/admin/custom/queryList/formId.jsp?rootMid=flowdesign&rootEntityId=flowRoot",
		   		src : "<%=request.getContextPath()%>/form/admin/custom/queryList/formId.jsp?rootMid=flowdesign&rootEntityId=flowRoot",
		   		showFooter : false
		   	});
		   </script>
		   				<script>
		   	Mflow.hide();
		   </script>
		   			</form>
		   			<script>
		   	MForm0.initComplete = true;
		   	MForm0.redraw();
		   	isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
		   </script>
		   		</div>

</body>
</html>