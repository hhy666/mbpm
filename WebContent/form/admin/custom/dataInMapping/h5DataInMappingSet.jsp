<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.matrix.form.admin.custom.trigger.model.DataMapping"%>
<%@page import="com.matrix.form.admin.custom.datainmapping.model.DataInMapping"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>数据带入详细信息页面</title>
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
   border-radius: 0;
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
</style>
<script type="text/javascript">
	var tocheck = "${tocheck}";
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
	
	var triggerJosn = "${triggerProName}"   //触发属性 编码+名称json字符串
 	//页面初始事件
	$(function(){
		debugger;
		//是否插入单据显示
		if(document.getElementById("correlation").value=='true'){
			$('#correlation').iCheck('check');
		}else{
			$('#correlation').iCheck('uncheck');
		}
		//是否显示详细信息
		if(document.getElementById("isShowDetails").value=='true'){
			$('#isShowDetails').iCheck('check');
		}else{
			$('#isShowDetails').iCheck('uncheck');
		}

		var mappingType = document.getElementById('mappingType').value;  //数据带入类型  '0':'弹出选择带入','1':'用户输入带入','2':'系统自动带入'
 		if(mappingType == '0'){   //弹出选择带入
 			 document.getElementById('tr003').style.display='';  //显示触发属性
 			 document.getElementById('tr005').style.display='';  //显示数据过滤
 			 //document.getElementById('tr006').style.display='';  //显示插入单据显示
 			 document.getElementById('tr008').style.display='';  //显示是否显示详细信息
 			 document.getElementById('tbC').style.display="none";  //显示关联条件
 			
		 }else{
			 document.getElementById('tr003').style.display='none';  //隐藏触发属性
			 document.getElementById('tr005').style.display='none';  //隐藏数据过滤
			 document.getElementById('tr006').style.display='none';  //隐藏插入单据显示
			 document.getElementById('tr008').style.display='none';  //隐藏是否显示详细信息
 			 document.getElementById('tbC').style.display="";   //隐藏关联条件
		 }
 		
 		if(typeof(triggerJosn)=='string'){
 			var triggerProName = document.getElementById("triggerProName");  //触发属性下拉框
 	
 			triggerJosn = isc.JSON.decode(triggerJosn);
 			for(var key in triggerJosn){
 				//添加一个下拉框选项
 				triggerProName.options.add(new Option(triggerJosn[key], key));
 			}
 			$('.selectpicker').selectpicker('refresh');//动态刷新
 			//设置选中的值
 			$('#triggerProName').selectpicker('val','${dimData.triggerProName}');
 			
 		}
 		
 		//监听数据带入类型下拉框改变事件
		$("#mappingType").change(function(){ 
			var value = $(this).val();           
      	   	changeType(value);
         });

	})
		
	//类型下拉框改变时
	function changeType(mappingType){
	 	var value = document.getElementById('formId').value;  //表单编码
	 	if(mappingType == '0'){   //弹出选择带入 
	 		document.getElementById('tr003').style.display='';  //显示触发属性
		 	document.getElementById('tr005').style.display='';  //显示数据过滤
		 	//document.getElementById('tr006').style.display='';  //显示插入单据显示
		 	document.getElementById('tr008').style.display='';  //显示是否显示详细信息
			document.getElementById('tbC').style.display="none";
		 	
		 	//置空
	 		reset();
	 		var toData=document.getElementById("toData_0");   //关联表单的关联属性
			var toCondition=document.getElementById("toCondition_0");   //关联表单的关联条件
			toData.innerHTML = "";
			toCondition.innerHTML = "";
			var synJson = {'data':'{"formId":"'+value+'"}'};
			var url = "<%=request.getContextPath()%>/mapping/dataMapping_setH5TargetOption.action";
			Matrix.sendRequest(url,synJson,function(data){
			    var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    if(callbackJson!=null&&callbackJson.result==true){
			    	var opt=callbackJson.option;
			    	tocheck=callbackJson.tocheck;
			    	for(var i=0;i<opt.length;i++){
			    		toData.options.add(new Option(opt[i].optText, opt[i].optValue));
			    		toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
			    	}
			    	$('.selectpicker').selectpicker('refresh');//动态刷新
			    }else{
			    	parent.isc.say('赋值失败');
			    }		    
			},null);	
			
		 }else if(mappingType == '2'){  //系统自动带入
			 document.getElementById('tr003').style.display='none';  //隐藏触发属性
			 document.getElementById('tr005').style.display='none';  //隐藏数据过滤
			 document.getElementById('tr006').style.display='none';  //隐藏插入单据显示
			 document.getElementById('tr008').style.display='none';  //隐藏是否显示详细信息
		 	 document.getElementById('tbC').style.display=""; 	
		 	 reset();
		 	 var fromCondition=document.getElementById("fromCondition_0");  //当前表单的关联条件
		 	 fromCondition.innerHTML = "";
			 var url = "<%=request.getContextPath()%>/mapping/dataMapping_setH5Automatic.action";
			 Matrix.sendRequest(url,null,function(data){
				 var callbackStr = data.data;
				 var callbackJson = isc.JSON.decode(callbackStr);
				 if(callbackJson!=null&&callbackJson.result==true){
		    		 var opt=callbackJson.option;
		    		 for(var i=0;i<opt.length;i++){
		    			fromCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
		    		 }
		    		 $('.selectpicker').selectpicker('refresh');//动态刷新
			    }else{
			    	parent.isc.say('赋值失败');
			    }
			    
			 });
		 		
			  var toData=document.getElementById("toData_0");   //关联表单的关联属性
			  var toCondition=document.getElementById("toCondition_0");  //关联表单的关联条件
			  toData.innerHTML = "";
			  toCondition.innerHTML = "";
			  var synJson = {'data':'{"formId":"'+value+'"}'};
			  var url2 = "<%=request.getContextPath()%>/mapping/dataMapping_setH5TargetOption.action";
			  Matrix.sendRequest(url2,synJson,function(data){
				    var callbackStr = data.data;
				    var callbackJson = isc.JSON.decode(callbackStr);
				    if(callbackJson!=null&&callbackJson.result==true){
				    	var opt=callbackJson.option;
				    	tocheck=callbackJson.tocheck;
				    	for(var i=0;i<opt.length;i++){
				    		toData.options.add(new Option(opt[i].optText, opt[i].optValue));
				    		toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
				    	}
				    	$('.selectpicker').selectpicker('refresh');//动态刷新
				    }else{
				    	parent.isc.say('赋值失败');
				    }
			  });
			  
		 }else{   //用户输入带入
			 document.getElementById('tr003').style.display='none';  //隐藏触发属性
			 document.getElementById('tr005').style.display='none';  //隐藏数据过滤
			 document.getElementById('tr006').style.display='none';  //隐藏插入单据显示
			 document.getElementById('tr008').style.display='none';  //隐藏是否显示详细信息
			 document.getElementById('tbC').style.display="";
		 	 reset();
		 	 var obj=document.getElementById('fromData_0');  //当前表单的关联属性
		 	 var options = obj.options;
		 	 var fromCondition=document.getElementById("fromCondition_0");  //当前表单的关联条件
		 	 fromCondition.innerHTML = "";
			 for(var i=0;i<options.length;i++){
				if(options[i].value!=''){
					fromCondition.options.add(new Option(options[i].text, options[i].value));
				}
			 }
			 var toData=document.getElementById("toData_0");  //关联表单的关联属性
			 var toCondition=document.getElementById("toCondition_0");  //关联表单的关联条件
			 toData.innerHTML = "";
			 toCondition.innerHTML = "";
			 var synJson = {'data':'{"formId":"'+value+'"}'};
			 var url = "<%=request.getContextPath()%>/mapping/dataMapping_setH5TargetOption.action";
			 Matrix.sendRequest(url,synJson,function(data){
			    var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    if(callbackJson!=null&&callbackJson.result==true){
			    	var opt=callbackJson.option;
			    	tocheck=callbackJson.tocheck;
			    	for(var i=0;i<opt.length;i++){
			    		toData.options.add(new Option(opt[i].optText, opt[i].optValue));
			    		toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
			    	}
			    	$('.selectpicker').selectpicker('refresh');//动态刷新
			    }else{
			    	Matrix.say('赋值失败');
			    }
			 });
		 }
	}
	
	//重置
	function reset(){
		//置空控件值
		document.getElementById('triggerProName').value = '';
	 	document.getElementById('popupCondition').value = '';
	 	$('.selectpicker').selectpicker('refresh');//动态刷新
		//设置选中的值
		$('#triggerProName').selectpicker('val','');
	 	//不选中复选框
		//$('#correlation').iCheck('uncheck');
		//不选中复选框
		//$('#isShowDetails').iCheck('uncheck');
	 	
		var selects = $("select[data-live-search='true']");
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
		var pselects = $("select[data-live-search='true']");
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
		document.getElementById("fromCondition_0").value="";
		document.getElementById("fromData_0").value="";
		document.getElementById("toCondition_0").value="";
		document.getElementById("toData_0").value="";
	}
	
	
	//弹出选择关联表单窗口
	function openAssociatedForms(){
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'associated',
			type : 2,
			
			title : ['选择表单'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFormTree.jsp?iframewindowid=associated&rootMid=flowdesign&rootEntityId=flowRoot'
		});
	}
	
	//选择关联表单窗口回调   给formId赋值  给目标表单加option
	function onassociatedClose(record){
		var selects = $("select[data-live-search='true']");
		var mappingType = document.getElementById("mappingType").value;
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
		var pselects = $("select[data-live-search='true']");
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
		document.getElementById("fromCondition_0").value="";
		document.getElementById("fromData_0").value="";
	 	if(record!=null && record!=""){
			var data = record.name;   //表单名称
			var value = record.id;   //表单编码
			
			var toData=document.getElementById("toData_0");
			var toCondition=document.getElementById("toCondition_0");
			toData.innerHTML = "";
			toCondition.innerHTML = "";
			var synJson = {'data':'{"formId":"'+value+'"}'};
			var url = "<%=request.getContextPath()%>/mapping/dataMapping_setH5TargetOption.action";
			Matrix.sendRequest(url,synJson,function(data2){
			    var callbackStr = data2.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    if(callbackJson!=null&&callbackJson.result==true){
			    	var opt=callbackJson.option;
			    	tocheck=callbackJson.tocheck;
			    	for(var i=0;i<opt.length;i++){
			    		toData.options.add(new Option(opt[i].optText, opt[i].optValue));
			    		toCondition.options.add(new Option(opt[i].optText, opt[i].optValue));
			    	}
			    	$('.selectpicker').selectpicker('refresh');//动态刷新
			    }else{
			    	parent.Matrix.say('赋值失败');
			    }
			    
			});
	      	Matrix.setFormItemValue('formValue',data);
			Matrix.setFormItemValue('formId',value);
	       }  
	}
	
	//打开数据过滤条件窗口
	function openpopupCondition(){
		var popupCondition = $("#popupCondition").val();  //条件
		var associatedFormId = $("#formId").val();  //获得隐藏域中选中关联表单的mUuid
		
		parent.parent.parent.isc.MFH.winObj = this;
		parent.parent.parent.layer.open({
	    	id:'m_popupCondition',
			type : 2,
			
			title : ['设置条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=m_popupCondition&entrance=DataFilter&associatedFormId="+associatedFormId+"&firstCondition="+encodeURI(popupCondition)+""
		});			
	}
	
	//数据过滤条件窗口回调
	function onpopupConditionClose(data){
		if(data){
		   var popupCondition = data.conditionText;
		   Matrix.setFormItemValue('popupCondition',popupCondition);
		}
	}
	
	//关联条件新加一行
	function addRow(element){  
		var tr = element.parentNode.parentNode; //获取当前行对象
		var index = tr.rowIndex;
		var tb = document.getElementById('tb');
		var newTr = tb.insertRow(index+1); //在下方插入新的一行
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td width=\"10%\"></td>";
		var newTd2 = newTr.insertCell();
		var select1 = document.getElementsByName("toCondition_0")[0];
		var select2 = document.getElementsByName("fromCondition_0")[0];
		var flag; 
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			flag = "<font style=\"color: #0642f7\">等于</font>";
		}else{
			flag = "<font style=\"color: #0642f7\">赋值</font>";;
		}
		var str = "<td width=\"35%\"><select style=\"width:100%;\" class=\"selectpicker show-tick form-control\" data-live-search=\"true\" title=\"请选择\">";
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
		
		var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td width=\"10%\">"+ flag +"</td>";
		
		var newTd4 = newTr.insertCell();
		str = "<td width=\"35%\"><select style=\"width:100%;\" class=\"selectpicker show-tick form-control\" data-live-search=\"true\" title=\"请选择\">";
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
		
		var newTd5 = newTr.insertCell();
		newTd5.innerHTML = "<td width=\"10%\"><span class=\"ico16 oprate_plus_16\" onclick=\"addRow(this)\"></span>&nbsp;<span id=\"del\" class=\"ico16 oprate_reduce_16\" onclick=\"delRow(this);\"></span></td>";
		
		$('.selectpicker').selectpicker('refresh');//动态刷新
	}
	
	//关联属性新加一行数据复制
	function addRow2(element){  
		var tr = element.parentNode.parentNode; //获取当前行对象
		var index = tr.rowIndex;
		var tb = document.getElementById('tb');
		var newTr = tb.insertRow(index+1); //在下方插入新的一行
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td width=\"10%\"></td>";
		var newTd2 = newTr.insertCell();
		var select1 = document.getElementsByName("toData_0")[0];
		var select2 = document.getElementsByName("fromData_0")[0];
		var flag; 
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			flag = "<font style=\"color: #0642f7\">等于</font>";
		}else{
			flag = "<font style=\"color: #0642f7\">赋值</font>";
		}
		var str = "<td width=\"35%\"><select style=\"width:100%;\" class=\"selectpicker show-tick form-control\" data-live-search=\"true\" title=\"请选择\">";
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
		
		var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td>"+ flag +"</td>";
		
		var newTd4 = newTr.insertCell();
		str = "<td width=\"35%\"><select style=\"width:100%;\" class=\"selectpicker show-tick form-control\" data-live-search=\"true\" title=\"请选择\">";
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
		
		var newTd5 = newTr.insertCell();
		newTd5.innerHTML = "<td width=\"10%\"><span class=\"ico16 oprate_plus_16\" onclick=\"addRow2(this)\"></span>&nbsp;<span id=\"del\" class=\"ico16 oprate_reduce_16\" onclick=\"delRow(this);\"></span></td>";
		
		$('.selectpicker').selectpicker('refresh');//动态刷新
	}
	
	//删除一行
	function delRow(element){  
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
			Matrix.warn("此行为不可删除项");
		}
	}
	
	//校验触发项
	function checkTrigger(){
		var mappingType = document.getElementById("mappingType").value;
		if(mappingType=="0"){   //弹出选择带入
			var value = document.getElementById("triggerProName").value;
			if(value==""||value==null||value==undefined){
				Matrix.warn("请选择触发属性!");
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}
	
	//保存
	function submitByButton(){ 
		var check = ${check};
		if(oType!=null && "update"==oType) {//修改
			if(typeof(tocheck)=='string'){
				tocheck=isc.JSON.decode(tocheck);
			}
		}
		//筛选出所有id带有_的下拉框元素
		var selects = $("select[data-live-search='true']");
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var mappingName=Matrix.getFormItemValue("name");
		var mappingType=Matrix.getFormItemValue("mappingType");
		var formId=Matrix.getFormItemValue("formId");
		var triggerProName=Matrix.getFormItemValue("triggerProName");
		
		var popupCondition=Matrix.getFormItemValue("popupCondition");    //获得条件
	    var isViewReleForm=false;				 					//是否查看关联
	    if(document.getElementById("correlation").checked==true){
	    	isViewReleForm=true;
	    } 
	    var isShowDetails=false;				 					//是否查看关联
	    if(document.getElementById("isShowDetails").checked==true){
	    	isShowDetails=true;
	    } 
		    
		var str;
		if(mappingType == '1'){  //用户输入带入
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
			str="{\"name\":\"";
			str+=mappingName;
			str+="\",\"mappingType\":\"";
			str+=mappingType;
			str+="\",\"formId\":\"";
			str+=formId;
			str+="\",\"isViewReleForm\":\"";
			str+=isViewReleForm;
			str+="\",\"isShowDetails\":\"";
			str+=isShowDetails;
			str+="\",\"popupCondition\":\"";
			str+=popupCondition;
			
			str+="\",";
			str+= "\"condition\":[";
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
							Matrix.warn("请选择主表或同一子表中的数据");
							return;
						}
					}
					if(value!=''){
						str = str+ "{\"toCondition_"+m+"\":\"";
						str += value;
						str += "\",";
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
							Matrix.warn("请选择主表或同一子表中的数据");
							return;
						}
					}
					if(value!=''){
						str = str + "\"fromCondition_"+n+"\":\"";
						str += value;
						str += "\"},";
					}
					n++;
					toPro = text;
					toVal=value;
					toType = tocheck[value];
				}
				if(m == n){
					if(fromVal == ''&& toVal != ''){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
					if(toVal == ''&& fromVal != ''){
						Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
						return;
					}
					if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
						if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
							if(typeMap[fromType] != typeMap[toType]){
								Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
								return;
							}
						}
					
					}else{
						if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
							Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
							return;
						}
					}
				}
			}
			var c=str.charAt(str.length - 1);
			if(c!='['){
				str = str.substring(0,str.length-1);
			}
			str += "],\"copyData\":[";
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
							Matrix.warn("请选择主表或同一子表中的数据");
							return;
						}
					}
					if(value!=''){
						str = str+"{\"toData_"+m+"\":\"";
						str += value;
						str += "\",";
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
							Matrix.warn("请选择主表或同一子表中的数据");
							return;
						}
					}
					if(value!=''){
						str = str+"\"fromData_"+n+"\":\"";
						str += value;
						str += "\"},";
					}
					n++;
					toPro = text;
					toVal=value;
					toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == '' && toVal == '' && copyDataRows == 1){
							Matrix.warn("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromVal == '' && toVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == '' && fromVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal!='m_ptitle'){
							if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
								if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
									if(typeMap[fromType] != typeMap[toType]){
										Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
										return;
									}
								}
							}else{
								if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
									Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
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
				str += "]}";
				
			}else if(mappingType=='2'){    //系统自动带入
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
				str="{\"name\":\"";
				str+=mappingName;
				str+="\",\"mappingType\":\"";
				str+=mappingType;
				str+="\",\"formId\":\"";
				str+=formId;
				str+="\",\"isViewReleForm\":\"";
				str+=isViewReleForm;
				str+="\",\"isShowDetails\":\"";
				str+=isShowDetails;
				str+="\",\"popupCondition\":\"";
				str+=popupCondition;
				str+="\",";
			
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
								Matrix.warn("请选择主表或同一子表中的数据");
								return;
							}
						}
						str = str+ "{\"toCondition_"+m+"\":\"";
						str += value;
						str += "\",";
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
								Matrix.warn("请选择主表或同一子表中的数据");
								return;
							}
						}
						str = str + "\"fromCondition_"+n+"\":\"";
						str += value;
						str += "\"},";
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == ''&& toVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == ''&& fromVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
					}
				}
				var c=str.charAt(str.length - 1);
				if(c!='['){
				str = str.substring(0,str.length-1);
				}
				str += "],\"copyData\":[";
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
								Matrix.warn("请选择主表或同一子表中的数据");
								return;
							}
						}
						if(value!=''){
						str = str+"{\"toData_"+m+"\":\"";
						str += value;
						str += "\",";
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
								Matrix.warn("请选择主表或同一子表中的数据");
								return;
							}
						}
					if(value!=''){
						str = str+"\"fromData_"+n+"\":\"";
						str += value;
						str += "\"},";
						}
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == ''&& toVal == '' && copyDataRows == 1){
							Matrix.warn("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromVal == ''&& toVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == ''&& fromVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
							if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
								if(typeMap[fromType] != typeMap[toType]){
									Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
									return;
								}
							}
						
						}
						else{
							if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
								Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
								return;
							}
						}
					}
				}
				var c=str.charAt(str.length - 1);
				if(c!='['){
				str = str.substring(0,str.length-1);
				}
				str += "]}";
			}else{          //弹出选择带入
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromPro;
				var toPro;
				var fromVal;
				var toVal;
				str="{\"name\":\"";
				str+=mappingName;
				str+="\",\"mappingType\":\"";
				str+=mappingType;
				str+="\",\"triggerProName\":\"";
				str+=triggerProName;
				str+="\",\"formId\":\"";
				str+=formId;;
				str+="\",\"isViewReleForm\":\"";
				str+=isViewReleForm;
				str+="\",\"isShowDetails\":\"";
				str+=isShowDetails;
				str+="\",\"popupCondition\":\"";
				str+=popupCondition;
				str+="\",";
				str+= "\"copyData\":[";
				for(var i=2;i<selects.length;i++){
					var index = selects[i].selectedIndex;
					var value = selects[i].options[index].value;
					var text = selects[i].options[index].text;
					var array = value.split("_");
					if(i%2==0){
						if(value!=''){
							str = str+"{\"toData_"+m+"\":\"";
							str += value;
							str += "\",";
						}
						m++;
						fromPro = text;
						fromVal=value;
						fromType = check[value];
					}else{
						if(value!=''){
							str = str+"\"fromData_"+n+"\":\"";
							str += value;
							str += "\"},";
						}
						n++;
						toPro = text;
						toVal=value;
						toType = tocheck[value];
					}
					if(m == n){
						if(fromVal == '' && toVal == '' && selects.length/2 == 1){
							Matrix.warn("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromVal == '' && toVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toVal == '' && fromVal != ''){
							Matrix.warn("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(typeMap[toType]=="23"||typeMap[toType]=="24"||typeMap[toType]=="25"||typeMap[toType]=="26"){
							if(typeMap[fromType]!="1"&&typeMap[fromType]!="21"&&typeMap[fromType]!="23"&&typeMap[fromType]!="24"&&typeMap[fromType]!="25"&&typeMap[fromType]!="26"){
								if(typeMap[fromType] != typeMap[toType]){
									Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
									return;
								}
							}
						}else{
							if(typeMap[fromType] != typeMap[toType] && !((typeMap[fromType] =='1' || typeMap[fromType] =='5') && (typeMap[toType] =='1' || typeMap[toType] =='5')) ){
								Matrix.warn("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
								return;
							}
						}
					}
				  }
				   var c=str.charAt(str.length - 1);
				   if(c!='['){
						str = str.substring(0,str.length-1);
					}
					str += "]}";
				}
				debugger;
				var synJson = {'data':str};	
				if(oType=='add'){
					var url = "<%=request.getContextPath()%>/mapping/dataMapping_saveDataInMapping.action";
					Matrix.sendRequest(url,synJson,function(data){
						var callbackStr = data.data;
					    var callbackJson = isc.JSON.decode(callbackStr);
					    if(callbackJson!=null&&callbackJson.result==true){
					    	Matrix.say("保存成功");
					    	parent.parent.Matrix.refreshDataGridData('DataGrid001');
					   	 	oType='update';
					   	 	var size = parent.Matrix.getGridData('DataGrid001').length;
					   	 	Matrix.setFormItemValue("uuid",size);
						 }
					});
				}else{
					var uuid=Matrix.getFormItemValue("uuid");
					var url = "<%=request.getContextPath()%>/mapping/dataMapping_updateDataInMapping.action?uuid="+uuid;
					Matrix.sendRequest(url,synJson,function(data){
						var callbackStr = data.data;
					    var callbackJson = isc.JSON.decode(callbackStr);
					    if(callbackJson!=null&&callbackJson.result==true){
				    		Matrix.say("更新成功");
				    		var mappingName = Matrix.getFormItemValue("name");
			    			var index = Matrix.getFormItemValue("uuid");
			    			parent.parent.updateName(mappingName,index);
					   	}
					});
				}
		}
	
</script>
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
	<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="form0" name="form0" value="form0" /> 
		<input type="hidden" id="validateType" name="validateType" value="jquery" />  <!-- 校验 -->
		<input type="hidden" id="oType" name="oType" value="${param.oType}" />    <!-- 操作类型  add添加  update修改 -->
		<!-- id 需要和显示值mid处理好 -->
		<input type="hidden" id="formId" name="formId" value="${dimData.formId}" />  <!-- 表单编码 -->
		<input type="hidden" id="tocheck" name="tocheck" value="${tocheck}" />  <!-- 字段完整编码 + uiType的JSON字符串 -->
		<input type="hidden" id="uuid" name="uuid" value="${param.uuid}" />  <!-- 数据带入主键即顺序号 -->
		<div id="container">
		<div id="top" style="height:calc(100% - 54px); width:100%;overflow: auto;">
			<table id="table001" class="tableLayout" style="height:auto;width:100%;">
				<tr id="tr001">
					<td id="td001" class="tdLabelCls" style="width:25%;">
						<label id="label001" name="label001">
							名称：
						</label>
					</td>
					<td id="td002" class="tdValueCls" style="width:75%;">
						<div id="name_div" style="vertical-align: middle;">
							<input id="name" name="name" type="text" value="${dimData.name}" class="form-control" style="height:100%;width:100%;" required="required"/>
						</div>
					</td>
				</tr>
				<tr id="tr002">
					<td id="td003" class="tdLabelCls" style="width:25%">
						<label id="label002" name="label002">
							类型：
						</label>
					</td>
					<td id="td004" class="tdValueCls" style="width:75%;">
						<div id="mappingType_div" style="vertical-align: middle;">
							<select id="mappingType" name="mappingType" value="${dimData.mappingType}" class="selectpicker show-tick form-control" style="height:100%;width:100%;">
		                       <option value="0" ${dimData.mappingType == 0 ? "selected" : ""}>弹出选择带入</option>
		                       <option value="1" ${dimData.mappingType == 1 ? "selected" : ""}>用户输入带入</option>
		                       <option value="2" ${dimData.mappingType == 2 ? "selected" : ""}>系统自动带入</option>                
		                    </select>
						</div>
					</td>
				</tr>
				<tr id="tr003">
					<td id="td005" class="tdLabelCls" style="width:25%">
						<label id="label003" name="label003" id="label003">
							触发属性：
						</label>
					</td>
					<td id="td006" class="tdValueCls" style="width:75%;">
						<div id="triggerProName_div" style="vertical-align: middle;">
							<select id="triggerProName" name="triggerProName" value="${dimData.triggerProName}" class="selectpicker show-tick form-control"  title="请选择" style="height:100%;width:100%;">
		                    </select>
						</div>
					</td>
				</tr>
				<tr id="tr004">
					<td id="td007" class="tdLabelCls" style="width:25%;">
						<label id="label004" name="label004" id="label004">
							关联表单：
						</label>
					</td>
					<td id="td008" class="tdValueCls" style="width:75%;">
						<div id="formValue_div" class="input-group">
							 <input type="text" id="formValue" name="formValue" value="${dimData.formName}"  placeholder="请选择表单" class="form-control" required="required" readonly="readonly" >
		            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openAssociatedForms();"><i class="fa fa-search"></i></span>
						</div>
					</td>
				</tr>
				<tr id="tr005">
					<td id="td009" class="tdLabelCls" style="width:25%;">
						<label id="label005" name="label005" id="label005">
							数据过滤：
						</label>
					</td>
					<td id="td010" class="tdValueCls" style="width:75%;">
						<div id="popupCondition_div" class="input-group">
							 <input type="text" id="popupCondition" name="popupCondition" value="${dimData.popupCondition}"  class="form-control" readonly="readonly">
		            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupCondition();"><i class="fa fa-search"></i></span>
						</div>
					</td>
				</tr>
				<tr id="tr008">
					<td id="td015" class="tdLabelCls" style="width:25%;">
						<label id="label007" name="label007" id="label007">
							显示详细信息：
						</label>
					</td>
					<td id="td016" class="tdValueCls" style="width:75%;text-align: left;">
						<div id="isShowDetails_div" name="isShowDetails_div" style="padding-left: 10px;">
							<input type="checkbox" class="box" id="isShowDetails" name="isShowDetails" value="${dimData.isShowDetails }"/>
						</div>
					</td>
				</tr>	
				<tr id="tr006" style="display:none;">
					<td id="td011" class="tdLabelCls" style="width:25%;">
						<label id="label006" name="label006" id="label006">
							插入单据显示：
						</label>
					</td>
					<td id="td012" class="tdValueCls" style="width:75%;text-align: left;">
						<div id="correlation_div" name="correlation_div" style="padding-left: 10px;">
							<input type="checkbox" class="box" id="correlation" name="correlation" value="${dimData.isViewReleForm }"/>
						</div>
					</td>
				</tr>	
				<tr id="tr007">
					<td id="td013" class="tdLabelCls" colspan="2">
						<div id="main" style="height: 100%;">
							 <table class="" id="tb" style="height: 100%;width: 100%;border-collapse:separate; border-spacing:0px 3px;">
								<tbody id="tbC" style="display: none;">
									<tr>
										<td width="10%"></td>
										<td width="35%"><span style="font-weight:bold;">关联表单</span></td>
										<td width="10%"></td>
										<td width="35%"><span style="font-weight:bold;">当前表单</span></td>
										<td width="10%"></td>
									</tr>
									<%
										if (true) {
									%>
									<tr id="condition">
										<td colspan="5" style="text-align: left;padding-left: 10px;font-weight:bold;">关联条件：</td>
									</tr>
	
									<%
									if (("2".equals(dataInMapping.getMappingType())) || (conditionCopyList != null && conditionCopyList.size() > 0)) {
										int i = 0;
										boolean flag = true;
										for (DataMapping dataMapping : conditionCopyList) {
									%>
									<tr>
										<td width="10%"></td>
										<td width="35%">
											<select id="toCondition_<%=i%>" name="toCondition_<%=i%>" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
												<%
													for (int j = 0; j < toEntVal.size(); j++) {
												%>
												<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
												<%
													}
												%>
											</select> 
											<script type="text/javascript">
												var toId = "<%=dataMapping.getToId()%>";
												$('.selectpicker').selectpicker('refresh');//动态刷新
									 			//设置选中的值
									 			$('#toCondition_<%=i%>').selectpicker('val',toId);
											</script>
										</td>
										<td width="10%"><font style="color: #0642f7">等于</font></td>
										<td width="35%">
										  <select id="fromCondition_<%=i%>" name="fromCondition_<%=i%>" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
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
										  </select> 
										   <script type="text/javascript">												
												var fromId = "<%=dataMapping.getFromId()%>";
												$('.selectpicker').selectpicker('refresh');//动态刷新
									 			//设置选中的值
									 			$('#fromCondition_<%=i%>').selectpicker('val',fromId);
										  </script>
										</td>
										<td width="10%">
											<span id="add" class="ico16 oprate_plus_16" onclick="addRow(this);"></span>
											<span id="del" class="ico16 oprate_reduce_16" onclick="delRow(this);"></span>
										</td>
									</tr>
									<%
										i++;
										}
									%>
									<tr>
										<td colspan="5">
											<hr style="height:1px;border: none;border-top:1px solid #8c8b8b;margin:0px;"/>
										</td>
									</tr>
									<%
									  } else {
									%>
									<tr>
										<td width="10%"></td>
										<td width="35%">
										  <select id="toCondition_0" name="toCondition_0" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
												<%
													for (int j = 0; j < toEntVal.size(); j++) {
												%>
												<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
												<%
													}
												%>
										  </select>
										</td>
										<td width="10%"><font style="color: #0642f7">等于</font></td>
										<td width="35%">
										    <select id="fromCondition_0" name="fromCondition_0" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
												<%
													for (int j = 0; j < fromEntVal.size(); j++) {
												%>
												<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
												<%
													}
												%>
										     </select>
										</td>
										<td width="10%">
											<span id="add" class="ico16 oprate_plus_16" onclick="addRow(this);"></span>
											<span id="del" class="ico16 oprate_reduce_16" onclick="delRow(this);"></span>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<hr style="height:1px;border: none;border-top:1px solid #8c8b8b;margin:0px;"/>
										</td>
									</tr>
									<%
										}
										}
									%>
									</tbody>
											
									<tbody>
										<tr id="division">
											<td colspan="5" style="text-align: left;padding-left: 10px;font-weight:bold;">关联属性：</td>
										</tr>
										<%
											if (copyList != null && copyList.size() > 0) {
												for (int k = 0; k < copyList.size(); k++) {
													DataMapping dataMapping = copyList.get(k);
										%>
										<tr>
											<td width="10%"></td>
											<td width="35%">
												<select id="toData_<%=k%>" name="toData_<%=k%>" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
													<%
														for (int j = 0; j < toEntVal.size(); j++) {
													%>
													<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
													<%
														}
													%>
												</select> 
												<script type="text/javascript">
													var toId = "<%=dataMapping.getToId()%>";												
													$('.selectpicker').selectpicker('refresh');//动态刷新
										 			//设置选中的值
										 			$('#toData_<%=k%>').selectpicker('val',toId);
												</script>
											</td>
											<td width="10%"><font style="color: #0642f7">赋值</font></td>
												<td width="35%">
												<select id="fromData_<%=k%>" name="fromData_<%=k%>" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
													<%
														for (int j = 0; j < fromEntVal.size(); j++) {
													%>
													<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
													<%
														}
													%>
												</select> 
												<script type="text/javascript">												
													var fromId = "<%=dataMapping.getFromId()%>";												
													$('.selectpicker').selectpicker('refresh');//动态刷新
										 			//设置选中的值
										 			$('#fromData_<%=k%>').selectpicker('val',fromId);
												</script>
											</td>
											<td width="10%">
												<span id="add" class="ico16 oprate_plus_16" onclick="addRow2(this);"></span>
												<span id="del" class="ico16 oprate_reduce_16" onclick="delRow(this);"></span>
											</td>
										</tr>
										<%
											}
										   } else {
										%>
										<tr>
											<td width="10%"></td>
											<td width="35%">
												<select id="toData_0" name="toData_0" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">											
													<%
														for (int j = 0; j < toEntVal.size(); j++) {
													%>
													<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
													<%
														}
													%>
	
											     </select>
											 </td>
											<td width="10%"><font style="color: #0642f7">赋值</font></td>
											<td width="35%">
											   <select id="fromData_0" name="fromData_0" style="width:100%;" class="selectpicker show-tick form-control" data-live-search="true" title="请选择">
													<%
														for (int j = 0; j < fromEntVal.size(); j++) {
													%>
													<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
													<%
														}
													%>
											   </select>
											</td>
											<td width="10%">
											   <span id="add" class="ico16 oprate_plus_16" onclick="addRow2(this);"></span>
											   <span id="del" class="ico16 oprate_reduce_16" onclick="delRow(this);"></span>
										    </td>
										</tr>
										<%
											}
										%>
									</tbody>
							   </table>
						   </div>
					</td>
				</tr>
		</table>
	</div>
	<div id="buttom" class="cmdLayout">	
		<input type="button" class="x-btn ok-btn" name="保存" value="保存" id="save" >
		<!--  
		<input type="button" class="x-btn ok-btn" name="保存" value="保存并关闭" id="saveAndClose" >
		<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="cancel" >
		-->
		<input type="button" class="x-btn cancel-btn" name="关闭" value="关闭" id="shut" >
		<script type="text/javascript">
			//保存
	        $("#save").on("click",function(){
	     		Matrix.showMask2();
	    		//表单验证
	    		if (!Matrix.validateForm('form0')) {
	    			Matrix.hideMask2();
	    			return false;
	    		}
	    		//触发项验证
	    		if(checkTrigger()){
	    			//保存
	    			submitByButton();
	    			Matrix.hideMask2();
	    		}else{
	    			Matrix.hideMask2();
	    		}
	        });
	        
			/*
			//保存并关闭
	        $("#saveAndClose").on("click",function(){
	     		Matrix.showMask2();
	    		//表单验证
	    		if (!Matrix.validateForm('form0')) {
	    			Matrix.hideMask2();
	    			return false;
	    		}
	    		//触发项验证
	    		if(checkTrigger()){
	    			//保存
	    			submitByButton();
	    			Matrix.hideMask2();
	    			parent.parent.Matrix.closeWindow();
	    		}else{
	    			Matrix.hideMask2();
	    		}
	        });
	        
	      	//取消
	        $("#cancel").on("click",function(){
	        	parent.parent.$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
	        	parent.parent.document.getElementById('iframeContent').src = "<%=request.getContextPath()%>/editor/common/empty.html";
	        })
	        */
	        
	        //关闭
	        $("#shut").on("click",function(){
	        	parent.parent.Matrix.closeWindow();
	        })
		</script>	
	</div>	
	</div>			
</body>
</html>