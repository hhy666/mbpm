<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>高级查询条件页面</title>
<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
<script src='<%=path %>/resource/html5/js/layer.min.js'></script>

<script src='<%=path %>/resource/html5/js/matrix_runtime.js'></script>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<!-- Bootstrap -->
<link href="<%=path %>/resource/html5/css/bootstrap.css" rel="stylesheet">
<link href="<%=path %>/resource/html5/css/bootstrap-select.css" rel="stylesheet">
<script src="<%=path %>/resource/html5/js/bootstrap.min.js"></script>
<script src="<%=path %>/resource/html5/js/bootstrap-select.js"></script>
<link href="<%=path %>/resource/html5/css/font-awesome.css" rel="stylesheet">
<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/clockpicker.css' rel="stylesheet"></link>
<script src="<%=path %>/resource/html5/js/demo.js"></script>
<SCRIPT SRC='<%=path %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/clockpicker.js'></SCRIPT>

<style type="text/css">
.label-td{
	 width:10%;
	 text-align:center;
	 background-color:#efefef;
}
.ico16 {
	background: rgba(0, 0, 0, 0) url("<%=path %>/resource/images/icon16.png") no-repeat scroll 0
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
label {
    display: inline-block;
    max-width: 100%;
    margin-bottom: 0px;
    font-weight: bold;
}
.form-control{
	border-radius: 0px;
}
</style>
<script>
	var num_copy=0;    //最大Id号
	var array = new Array();   //定义一个数组存放行顺序
	
	var jsonStr;           //存放字段信息
	var optionJsonStr;     //存放字段绑定基本代码或自定义代码时的下拉框选项信息   =====>包含（基本代码或自定义代码）
	var idNameMap = {};    //定义存放编码,名称的Map
	var dataGrid;
	var flag;
	
	//初始填充下拉框
	$(function(){
		 var fTid = parent.Matrix.getFormItemValue('matrix_form_tid');  //获得ftid
		 var configUUID = parent.Matrix.getFormItemValue('configUUID');
		 var formId = parent.Matrix.getFormItemValue('formId');
		 var mIsQueryMode = parent.Matrix.getFormItemValue('mIsQueryMode');
		 	
		 dataGrid = "${param.dataGrid}";   
		 flag = "${param.flag}";     //操作标志  是否是重置操作
		 //初始化加载需要用到的数据
		  $.ajax({ 
				 url: "<%=path%>/select/SelectAction_getTableCell.action?fTid="+fTid+"&configUUID="+configUUID+"&formId="+formId+"&mIsQueryMode="+mIsQueryMode,   
		         type: "post", 
		         dataType: "json", 
		         success: function(data){ 
		        	if(data){
		        		 jsonStr = data.jsonStr;              //全局变量赋值
		        		 optionJsonStr = data.optionJsonStr;
		        		
		        		 for (var i = 0; i < jsonStr.length; i++) {  
			 	            idNameMap[''+jsonStr[i].cellId+''] = jsonStr[i].cellName;   //塞入键值对
			 	         }  
		        		 var advanceQueryJson;
		        		 if(flag != 'reset'){
		        			 var advanceQueryJson = parent.Matrix.getFormItemValue(""+dataGrid+"_mfilter");   //高级查询条件json字符串
		        		 }
		          /*********************************判断 两种情况：修改和添加******************************************/		
		        
		        		 //修改操作时
		        		 if(advanceQueryJson){   //有值代表修改操作
		        			 var tb = document.getElementById('tb');  //删除掉默认行
		        			 tb.innerHTML = "";  //清空table 准备加载保存的条件
		        			 
		        			 var jsonArray =  JSON.parse(advanceQueryJson);
		        			 num_copy = jsonArray.length-1;   //最大Id号
		   					 
		        			 //初始化数组
		        			 for(i=0;i<=num_copy;i++){
		        				array.push(i);
		        			 }
		        			 
		        			 for(var num in jsonArray){
		        				 var fieldName = jsonArray[num].fieldName;    //字段变量值
		        				 var operator = jsonArray[num].operator;       //比较条件
		        				 var value = jsonArray[num].value;            //输入条件
		        				 var connector = jsonArray[num].connector;   //连接符
		        				 
		        				 var newTr = tb.insertRow(num); //插入行
		        				 
		        				 var newTd1 = newTr.insertCell();
		        				 newTd1.innerHTML = "<label>字段</label>";
		        				 newTd1.className = "label-td"; 
		        				 newTd1.style = "vertical-align:middle;"
		        				 
		        			     var newTd2 = newTr.insertCell();
		        			     newTd2.innerHTML = "<div style=\"width:90%;\"><select id=\"variable_"+num+"\" class=\"selectpicker form-control\" data-size=\"5\" title=\"请选择\" onchange=\"selectOnchange(this);\"></select></div>";
		        				 newTd2.style = "width:15%;"
		        				 for(var key in idNameMap){ 
		        			         $("#variable_"+num+"").append("<option value=" + key + ">" + idNameMap[key] + "</option>"); 
		        				 }
		        				 //缺一不可  
		        			     $("#variable_"+num+"").selectpicker('refresh');  
		        			     $("#variable_"+num+"").selectpicker('render');  
		        			     if(fieldName!=""){
		        					 $("#variable_"+num+"").selectpicker('val', fieldName);  //默认选中保存的
		        				 }
		        			     
		        			     var newTd3 = newTr.insertCell();
		        				 newTd3.innerHTML = "<label>操作</label>";
		        				 newTd3.className = "label-td"; 
		        				 newTd3.style = "vertical-align:middle;"
		        				
		        				 //等于 包含等条件
		        				 var newTd4 = newTr.insertCell();
		        				 newTd4.innerHTML = "<div style=\"width:90%;\"><select id=\"operator_"+num+"\" class=\"selectpicker form-control\">"
		        				 +"<option value=\"equals\">等于</option>"
		        				 +"<option value=\"like\">包含</option>"
		        				 +"<option value=\"isNull\">为空</option>"
		        				 +"<option value=\"notNull\">不为空</option>"
		        				 +"<option value=\">\">大于</option>"
		        				 +"<option value=\"<\">小于</option>"
		        				 +"<option value=\">=\">大于或等于</option>"
		        			     +"<option value=\"<=\">小于或等于</option>"
		        				 +"</select></div>";
		        				 newTd4.style = "width:15%;"
		        				 //缺一不可  
		        			     $("#operator_"+num+"").selectpicker('refresh');  
		        			     $("#operator_"+num+"").selectpicker('render');  
		        			     if(operator!=""){
		        					 $("#operator_"+num+"").selectpicker('val', operator);  //默认选中保存的
		        				 }

		        			     var newTd5 = newTr.insertCell();
		        				 newTd5.innerHTML = "<label>值</label>";
		        				 newTd5.className = "label-td"; 
		        				 newTd5.style = "vertical-align:middle;" 
		        				 
		        				 //根据字段类型判断  显示不同的控件
		        				 var newTd6 = newTr.insertCell();
		        				 //显示加载出所有控件类型   默认隐藏
		        				 newTd6.innerHTML = "<div id=\"txt_"+num+"\" style=\"display:none\"><input id=\"inputxt_"+num+"\" type=\"text\" class=\"form-control\" style=\"width:90%;\"/></div>"
		
								 +"<div id=\"inputDate_"+num+"_div\" class=\"date-default-width col-md-12  input-prepend input-group\" style=\"display: none; vertical-align: middle;width:90%;\">"
							     +"<input id='inputDate_"+num+"' name='inputDate_"+num+"' class='form-control layer-date' style='width:100%;'/>"
							     +"<span class=\"input-group-addon addon-udSelect udSelect\"><i class=\"fa fa-calendar\"></i></span></div>"
							     
							     +"<div id=\"inputTime_"+num+"_div\" class=\"input-group  default-width clockpicker\" style=\"display: none; vertical-align: middle;width:90%;\">"
							     +"<input id='inputTime_"+num+"' name='inputTime_"+num+"' class='form-control' style='width:100%;'/>"
							     +"<span class=\"input-group-addon addon-udSelect udSelect\"><i class=\"fa fa-clock-o\"></i></span></div>"
							        
							     +"<div id=\"wheornot_"+num+"\" style=\"display: none;\"><div style=\"width:90%;\"><select id=\"ifelse_"+num+"\" class=\"selectpicker form-control\"><option value=\"1\">是</option><option value=\"0\">否</option></select></div></div>"
							        
							     +"<div id=\"choose_"+num+"\" style=\"display: none;\"><div style=\"width:90%;\"><select id=\"option_"+num+"\" class=\"selectpicker form-control\" data-live-search=\"true\" data-size=\"5\"></select></div></div>"
							      	
							     +"<div id=\"numberSpinner_"+num+"_div\" class=\"input-group default-width col-md-12\" style=\"display:none; vertical-align: middle;width:90%;\"><input type=\"number\" id=\"numberSpinner_"+num+"\" name=\"numberSpinner_"+num+"\" class=\"form-control\" style=\"width:100%;\"></div>"
							     
							     +"<div id=\"singlePerson_"+num+"_div\" class=\"input-group\" style=\"display: none; vertical-align: middle;width:90%;\">"
							     +"<input id='singlePerson_"+num+"' name='singlePerson_"+num+"' class='form-control' style='width:100%;'/>"
							     +"<span class=\"input-group-addon addon-udSelect udSelect\" onclick=\"openSinglePerson(this);\"><i class=\"fa fa-user\" style=\"padding: 0 2px;\"></i></span></div>"							  
							     
							     +"<div id=\"singleDep_"+num+"_div\" class=\"input-group\" style=\"display: none; vertical-align: middle;width:90%;\">"
							     +"<input id='singleDep_"+num+"' name='singleDep_"+num+"' class='form-control' style='width:100%;'/>"
							     +"<span class=\"input-group-addon addon-udSelect udSelect\" onclick=\"openSingleDep(this);\"><i class=\"fa fa-th-large\" style=\"padding: 0 1px;\"></i></span></div>";							     						    
							     
							     newTd6.id = "td_"+num+"";
							     newTd6.style = "width:20%;"
							
							     //初始日期插件
					             laydate.render({
					        		 elem: '#inputDate_'+num+'', 
					        		 format: 'yyyy-MM-dd',
				        		 }) 
							     $("#ifelse_"+num+"").selectpicker('refresh');  
								 $("#ifelse_"+num+"").selectpicker('render');
								 $("#option_"+num+"").selectpicker('refresh');  
								 $("#option_"+num+"").selectpicker('render');
		        				 
		        				 if(fieldName!=""){
			        				 for(var key in jsonStr){
			        					  if(jsonStr[key].cellId == fieldName){
			        							if(jsonStr[key].cellType == 'DateItem'){    //日期框
			        							     $("#inputDate_"+num+"_div").show();       //显示并加载默认值
			        							     $("#inputDate_"+num+"").val(value);
			        							     break; 
			        							        
			        							}else if(jsonStr[key].cellType == 'TimeItem'){  //时间框
			        								 $("#inputTime_"+num+"_div").show();       //显示并加载默认值
			        							     $("#inputTime_"+num+"").val(value);
			        							     break; 
			        								
			        							}else if(jsonStr[key].cellType == 'Radio' || jsonStr[key].cellType == 'Checkbox'){     //单选按钮,复选按钮
			        								 $("#wheornot_"+num+"").show(); 
			        								 //缺一不可  
			        							     $("#ifelse_"+num+"").selectpicker('refresh');  
			        							     $("#ifelse_"+num+"").selectpicker('render');  
			        							     $("#ifelse_"+num+"").selectpicker('val', value);  //默认选中保存的
			        							     break; 
			        										 	
			        							}else if(jsonStr[key].cellType == 'RadioGroup' || jsonStr[key].cellType == 'CheckboxGroup' 
			        									|| jsonStr[key].cellType == 'ComboBox' || jsonStr[key].cellType == 'MultiFilteringSelect'){  //单选按钮组,复选按钮组,下拉框,多选下拉框
			        				
			        								 $("#choose_"+num+"").show(); 
			        								 //初始化下拉框选项
			        								 //先清空掉所有选项
			        							 	 $("#choose_"+num+"").find("option").remove();
			        							 	 //加载下拉框选项
			        								 var codeId = jsonStr[key].codeId;
			        								 var codeType = jsonStr[key].codeType;
			        								 
			        								 for(var j in optionJsonStr){
			        									 var optionObj = optionJsonStr[j];
			        									 for(var n in optionObj){
			        										 if(n == codeId){
			        											 var options = optionObj[n];
			        											 for(var m in options){
			        												 //填充下拉框选项
			        												  $("#option_"+num+"").append("<option value=" + options[m].id + ">" + options[m].name + "</option>");
			        											 }
			        										 }
			        									 }
			        								 } 
			        								 //缺一不可  
			        							     $("#option_"+num+"").selectpicker('refresh');  
			        							     $("#option_"+num+"").selectpicker('render');  
			        								 $("#option_"+num+"").selectpicker('val', value);  //默认选中保存的
			        								 break; 
			        								
			        						    }else if(jsonStr[key].cellType == 'Spinner'){   //数字框	        				
			        						    	 $("#numberSpinner_"+num+"_div").show(); 
			        						    	 $("#numberSpinner_"+num+"").val(value);
			        						    	 break; 
			        						    	 
			        							}else if(jsonStr[key].cellType == 'SingleUserSelect' || jsonStr[key].cellType == 'MultiUserSelect'){   //单选人员  多选人员			
			        						    	 $("#singlePerson_"+num+"_div").show(); 
			        						    	 $("#singlePerson_"+num+"").val(value);
			        						    	 break; 
			        						    	 		        								 
			        							}else if(jsonStr[key].cellType == 'SingleDepSelect' || jsonStr[key].cellType == 'MultiDepSelect'){   //单选部门   多选部门	      			
			        						    	 $("#singleDep_"+num+"_div").show(); 
			        						    	 $("#singleDep_"+num+"").val(value);
			        						    	 break; 
			        						    	 		        							
			        							}else{     //文本框 					
			        							     $("#txt_"+num+"").show(); 
			        							     $("#inputxt_"+num+"").val(value);
			        							     break; 
			        							     
			        							}
			        					  }else{
			        						  if(fieldName == 'defaultVlaue'){
			        							  $("#txt_"+num+"").show(); 
			        							  $("#inputxt_"+num+"").val(value); 
			        						  }	        						 
			        					  }
			        				  }
		        			  }
		        			  /***********连接符开始************/ 
		        			  
		        			   
		        			   if(connector == ""){          //没有连接符 
		        					if(jsonArray.length == 1){   //只有一行时
		        						var newTd8 = newTr.insertCell();
		        						newTd8.innerHTML = "<span id=\"add\" class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this);\"></span>";
		        						newTd8.style = "vertical-align:middle;width:10%;"
		        						
		        					}else if(num == (jsonArray.length-1)){   //最后一行时
		        						var newTd8 = newTr.insertCell();
		        						newTd8.innerHTML = "<span id=\"add\" class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this);\"></span>"
		        						+"&nbsp;"
		        						+"<span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this);\"></span>";
		        						newTd8.style = "vertical-align:middle;width:10%;"
		        					}
		        			  }else{
		        				  var newTd7 = newTr.insertCell();   
		        				  newTd7.innerHTML = "<div style=\"width:90%;\"><select id=\"connector_"+num+"\" class=\"selectpicker form-control\"><option value=\"and\">并且</option><option value=\"or\">或者</option></select></div>";
	        					  newTd7.style = "width:12%;"
	        					  //缺一不可  
	        				      $("#connector_"+num+"").selectpicker('refresh');  
	        					  $("#connector_"+num+"").selectpicker('render');
	        					  $("#connector_"+num+"").selectpicker('val', connector);  //默认选中保存的
	        					  
	        					  var newTd8 = newTr.insertCell();
	        					  newTd8.innerHTML = "<span id=\"add\" class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this);\"></span>"
	        					  +"&nbsp;"
	        					  +"<span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this);\"></span>";
	        					  newTd8.style = "vertical-align:middle;width:10%;"
		        			    	
		        			  }	
		        		   }
		        			 
		        		//添加操作时  初始化第一行下拉框字段
		        		 }else{
		        			 //初始化数组
		        			 for(i=0;i<=num_copy;i++){
			        				array.push(i);
			        		 }
		        	 		 for (var i = 0; i < jsonStr.length; i++) {  
		        	 	            $("#variable_0").append("<option value=" + jsonStr[i].cellId + ">" + jsonStr[i].cellName + "</option>");
		        	 	     }  
		        	 		
		        	 	     // 缺一不可  
		        	 	     $("#variable_0").selectpicker('refresh');  
		        	 	     $("#variable_0").selectpicker('render'); 
		        	 	     
		        	 	  	 //初始日期插件
				             laydate.render({
				        		 elem: '#inputDate_0', 
				        		 format: 'yyyy-MM-dd',
			        		 }) 
		        		 }  
		         		 //给所有的input设置 autocomplete="off"
		        		 $('input:not([autocomplete]),textarea:not([autocomplete]),select:not([autocomplete])').attr('autocomplete', 'off'); 
		        	}
	             } 
	       });
	})
	
	//添加一行
	function addRow(element){
		debugger;
		var tr = element.parentNode.parentNode; //获取当前行对象
		
		var tdChid = tr.children[5].id;
		var indexId = tdChid.substring(tdChid.indexOf("_")+1);       //所选行的id后缀数字
		
		var index = tr.rowIndex;     //当前行索引
		var tb = document.getElementById('tb');
		var newIndex = index+1;  //新行的索引
		var newTr = tb.insertRow(newIndex); //在下方插入新的一行

		for(i=0;i<array.length;i++){
			if(i==index){
				//拼接函数(索引位置, 要删除元素的数量, 元素)
				array.splice(i+1, 0, num_copy+1);          //指定位置添加元素
			}
		}
		num_copy++;       //最大Id号
		var maxIndex = num_copy;

		var newTd1 = newTr.insertCell();
		newTd1.innerHTML = "<label>字段</label>";
		newTd1.className = "label-td"; 
		newTd1.style = "vertical-align:middle;"
		
		var newTd2 = newTr.insertCell();
		newTd2.innerHTML = "<div style=\"width:90%;\"><select id=\"variable_"+maxIndex+"\" class=\"selectpicker form-control\" data-size=\"5\" title=\"请选择\" onchange=\"selectOnchange(this);\"></select></div>";
		newTd2.style = "width:15%;"
		
		for(var key in idNameMap){ 
            $("#variable_"+maxIndex+"").append("<option value=" + key + ">" + idNameMap[key] + "</option>"); 
		}
		// 缺一不可  
	    $("#variable_"+maxIndex+"").selectpicker('refresh');  
	    $("#variable_"+maxIndex+"").selectpicker('render');  
	    //$("#variable_"+newIndex+"").selectpicker('val', "flowStatus");//默认选中
	  
		var newTd3 = newTr.insertCell();
		newTd3.innerHTML = "<label>操作</label>";
		newTd3.className = "label-td"; 
		newTd3.style = "vertical-align:middle;"
		
		var newTd4 = newTr.insertCell();
		newTd4.innerHTML = "<div style=\"width:90%;\"><select id=\"operator_"+maxIndex+"\" class=\"selectpicker form-control\">"
		+"<option value=\"equals\">等于</option>"
		+"<option value=\"like\">包含</option>"
		+"<option value=\"isNull\">为空</option>"
		+"<option value=\"notNull\">不为空</option>"
	    +"<option value=\">\">大于</option>"
		+"<option value=\"<\">小于</option>"
		+"<option value=\">=\">大于或等于</option>"
	    +"<option value=\"<=\">小于或等于</option>"
		+"</select></div>";

		newTd4.style = "width:15%;"
		$("#operator_"+maxIndex+"").selectpicker('refresh');  
		$("#operator_"+maxIndex+"").selectpicker('render');
		
		var newTd5 = newTr.insertCell();
		newTd5.innerHTML = "<label>值</label>";
		newTd5.className = "label-td"; 
		newTd5.style = "vertical-align:middle;"
		
		var newTd6 = newTr.insertCell();
		newTd6.innerHTML = "<div id=\"txt_"+maxIndex+"\" style=\"display:''\"><input id=\"inputxt_"+maxIndex+"\" type=\"text\" class=\"form-control\" style=\"width:90%;\"/></div>"
		
		+" <div id=\"inputDate_"+maxIndex+"_div\" class=\"date-default-width col-md-12  input-prepend input-group\" style=\"display: none; vertical-align: middle;width:90%;\">"
        +"<input id='inputDate_"+maxIndex+"' name='inputDate_"+maxIndex+"' class='form-control layer-date' style='width:100%;'/>"
        +"<span class=\"input-group-addon addon-udSelect udSelect\"><i class=\"fa fa-calendar\"></i></span></div>"
        
        +" <div id=\"inputTime_"+maxIndex+"_div\" class=\"input-group  default-width clockpicker\" style=\"display: none; vertical-align: middle;width:90%;\">"
	    +"<input id='inputTime_"+maxIndex+"' name='inputTime_"+maxIndex+"' class='form-control' style='width:100%;'/>"
	    +"<span class=\"input-group-addon addon-udSelect udSelect\"><i class=\"fa fa-clock-o\"></i></span></div>"
	     
        +"<div id=\"wheornot_"+maxIndex+"\" style=\"display: none;\"><div style=\"width:90%;\"><select id=\"ifelse_"+maxIndex+"\" class=\"selectpicker form-control\"><option value=\"1\">是</option><option value=\"0\">否</option></select></div></div>"
        
      	+"<div id=\"choose_"+maxIndex+"\" style=\"display: none;\"><div style=\"width:90%;\"><select id=\"option_"+maxIndex+"\" class=\"selectpicker form-control\" data-live-search=\"true\" data-size=\"5\"></select></div></div>"
      	
      	+"<div id=\"numberSpinner_"+maxIndex+"_div\" class=\"input-group default-width col-md-12\" style=\"display:none; vertical-align: middle;width: 90%;\"><input type=\"number\" id=\"numberSpinner_"+maxIndex+"\" name=\"numberSpinner_"+maxIndex+"\" class=\"form-control\" style=\"width:100%;\"></div>"
      	
      	+"<div id=\"singlePerson_"+maxIndex+"_div\" class=\"input-group\" style=\"display: none; vertical-align: middle;width:90%;\">"
	    +"<input id='singlePerson_"+maxIndex+"' name='singlePerson_"+maxIndex+"' class='form-control' style='width:100%;'/>"
	    +"<span class=\"input-group-addon addon-udSelect udSelect\" onclick=\"openSinglePerson(this);\"><i class=\"fa fa-user\" style=\"padding: 0 2px;\"></i></span></div>"
	     
	    +"<div id=\"singleDep_"+maxIndex+"_div\" class=\"input-group\" style=\"display: none; vertical-align: middle;width:90%;\">"
	    +"<input id='singleDep_"+maxIndex+"' name='singleDep_"+maxIndex+"' class='form-control' style='width:100%;'/>"
	    +"<span class=\"input-group-addon addon-udSelect udSelect\" onclick=\"openSingleDep(this);\"><i class=\"fa fa-th-large\" style=\"padding: 0 1px;\"></i></span></div>";
	     						     
	     
        newTd6.id = "td_"+maxIndex+"";
        newTd6.style = "width:20%;"
        $("#ifelse_"+maxIndex+"").selectpicker('refresh');  
		$("#ifelse_"+maxIndex+"").selectpicker('render');
		$("#option_"+maxIndex+"").selectpicker('refresh');  
	    $("#option_"+maxIndex+"").selectpicker('render');
		
	    //固定单元格后面添加连接符下拉框
	    var newTd7;
	    var newTd9;
	    if(document.getElementById("connector_"+indexId+"")){   //如果当前行存在连接符选项  直接在新行添加一个
	    	newTd7 = newTr.insertCell(6);   
	    	newTd7.innerHTML = "<div style=\"width:90%;\"><select id=\"connector_"+maxIndex+"\" class=\"selectpicker form-control\"><option value=\"and\">并且</option><option value=\"or\">或者</option></select></div>";
			newTd7.style = "width:12%;"
	    	$("#connector_"+maxIndex+"").selectpicker('refresh');  
			$("#connector_"+maxIndex+"").selectpicker('render');
			
	    }else{          //当前行不存在连接符当前行添加一个
	    	newTd9 = newTr.insertCell();   //当前行添加一个空单元格
	    	newTd9.id = "emptyCell_"+maxIndex+"";
	    	newTd9.style = "width:12%;"

	        $("#emptyCell_"+indexId+"").hide();  
	    	newTd7 = tr.insertCell(6);   
	    	newTd7.innerHTML = "<div style=\"width:90%;\"><select id=\"connector_"+indexId+"\" class=\"selectpicker form-control\"><option value=\"and\">并且</option><option value=\"or\">或者</option></select></div>";
			newTd7.style = "width:12%;"
	    	$("#connector_"+indexId+"").selectpicker('refresh');  
			$("#connector_"+indexId+"").selectpicker('render');
	    }
		
		var newTd8 = newTr.insertCell();
		newTd8.innerHTML = "<span id=\"add\" class=\"ico16 oprate_plus_16 right\"  onclick=\"addRow(this);\"></span>"
		+"&nbsp;"
		+"<span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this);\"></span>";
		newTd8.style = "vertical-align:middle;width:10%;"
		
		//初始日期插件
   		laydate.render({
   			elem: '#inputDate_'+maxIndex+'', 
   			format: 'yyyy-MM-dd',
   		})
   		//给所有的input设置 autocomplete="off"
		$('input:not([autocomplete]),textarea:not([autocomplete]),select:not([autocomplete])').attr('autocomplete', 'off'); 
	}
	
	//删除一行
	function delRow(element){
		var tr = element.parentNode.parentNode;
		var index = tr.rowIndex;       //所选行的索引号
		var lastIndex = index-1;        //上一行索引号
		var tb = document.getElementById('tb');
		//是否删除上一行的连接符
		var maxIndex = array.length-1;
		if(index==0 || index==maxIndex){
			for(i=0;i<array.length;i++){
				if(i==lastIndex){
					var lastId = array[i];
					var lastTr = document.getElementById("connector_"+lastId+"").parentNode.parentNode.parentNode;     //上一行连接条件
					lastTr.deleteCell(6);
					
					if(document.getElementById("emptyCell_"+lastId+"")){
						$("#emptyCell_"+lastId+"").show();  
					}else{
						newTd9 = lastTr.insertCell(6);   //添加一个空单元格
				    	newTd9.id = "emptyCell_"+lastId+"";
				    	newTd9.style = "width:12%;"
					}
					
				}
			}
		}

		if(array.length != 1){
			//移除数组中保存的记录
			array.splice(index,1);  //删除index位置上的元素    第二个参数的意思是   删除从index开始的后几位
			tb.deleteRow(index);  //删除本行
		}
			
	}
	
	
	//下拉框改变事件
	function selectOnchange(obj){
		var oid = obj.id;
		var index = oid.substring(oid.indexOf("_")+1);       //所选行的id后缀数字
		var value = obj.options[obj.selectedIndex].value;
		
		//如果有默认值移除掉默认值
		if(document.getElementById("variable_"+index+"")){
			var firstoption = document.getElementById("variable_"+index+"").options[0]; 
			if(firstoption.value == "defaultVlaue"){
				 document.getElementById("variable_"+index+"").options.remove(0); 
			}
			// 缺一不可  
		    $("#variable_"+index+"").selectpicker('refresh');  
		    $("#variable_"+index+"").selectpicker('render');  
		}
		
	    
		//遍历
		for(var key in jsonStr){
			if(jsonStr[key].cellId == value){
				 //先隐藏掉所有div
				 var children = $("#td_"+index+"").children();
				 for(i = 0; i < children.length; i++){
				      children[i].style.display = 'none';
				 }
				 
				 if(jsonStr[key].cellType == 'DateItem'){    //日期框
					 $("#inputDate_"+index+"_div").show();  //显示
					 
				 }else if(jsonStr[key].cellType == 'TimeItem'){   //时间框
					 $("#inputTime_"+index+"_div").show();  //显示
					 
				 }else if(jsonStr[key].cellType == 'Radio' || jsonStr[key].cellType == 'Checkbox'){     //单选按钮,复选按钮
					 $("#wheornot_"+index+"").show();  
					
				 }else if(jsonStr[key].cellType == 'RadioGroup' || jsonStr[key].cellType == 'CheckboxGroup' 
						 || jsonStr[key].cellType == 'ComboBox' || jsonStr[key].cellType == 'MultiFilteringSelect'){     //单选按钮组,复选按钮组,下拉框,多选下拉框
					 $("#choose_"+index+"").show(); 
				 	 //先清空掉所有选项
				 	 $("#choose_"+index+"").find("option").remove();
				 	 //加载下拉框选项
					 var codeId = jsonStr[key].codeId;
					 var codeType = jsonStr[key].codeType;
					 
					 for(var j in optionJsonStr){
						 var optionObj = optionJsonStr[j];
						 for(var n in optionObj){
							 if(n == codeId){
								 var options = optionObj[n];
								 for(var m in options){
									 //填充下拉框选项
									  $("#option_"+index+"").append("<option value=" + options[m].id + ">" + options[m].name + "</option>");
								 }
							 }
						 }
					 } 
					 $("#option_"+index+"").selectpicker('refresh');  
					 $("#option_"+index+"").selectpicker('render');  
					 
				 }else if(jsonStr[key].cellType == 'Spinner'){     //数字框
					 $("#numberSpinner_"+index+"_div").show(); 
				 
				 }else if(jsonStr[key].cellType == 'SingleUserSelect' || jsonStr[key].cellType == 'MultiUserSelect'){   //单选人员   多选人员      				
			    	 $("#singlePerson_"+index+"_div").show(); 

				 }else if(jsonStr[key].cellType == 'SingleDepSelect' || jsonStr[key].cellType == 'MultiDepSelect'){   //单选部门  多选部门	      				
			    	 $("#singleDep_"+index+"_div").show(); 
					 
				 }else{
					 $("#txt_"+index+"").show(); 
				 }
			}
        }	
	}
	
	//点击确定保存回调
	 function submitByButton(){
		//点击确定保存之前校验是否为空
		 var str = '[';
		 
		 for(i=0;i<array.length;i++){
			 //循环一遍后置空变量 移便于校验
			 fieldName = "";
			 operator = ""
			 inputValue = "";
			 connector = ""
			 
		 	 var fieldName = $("#variable_"+array[i]+"").val();       //字段变量
 			 if(typeof(fieldName) == "undefined"){
 				fieldName = "";
		 	 }
 			 if(fieldName == '' || fieldName == 'defaultVlaue'){
 				 if(array.length != 1){
 				    alert("请填写"+(i+1)+"行的变量");
 				    return;
 				 }else{
 					fieldName = "defaultVlaue";
 				 }
 			 }
		 	 
		 	 var operator = $("#operator_"+array[i]+"").val();       // 比较条件
		 	 if(typeof(fieldName) == "undefined"){
		 		operator = "";
			 }
		
		 	 var inputValue;        //输入条件
		 	 for(var key in jsonStr){
				if(jsonStr[key].cellId == fieldName){
					 if(jsonStr[key].cellType == 'DateItem'){    //日期框
						 inputValue = $("#inputDate_"+array[i]+"").val();
					 
					 }else if(jsonStr[key].cellType == 'TimeItem'){  //时间框
						 inputValue = $("#inputTime_"+array[i]+"").val();
						 
					 }else if(jsonStr[key].cellType == 'Radio' || jsonStr[key].cellType == 'Checkbox'){     //单选按钮,复选按钮
						 inputValue = $("#ifelse_"+array[i]+"").val();           // 1或0
					 	
					 }else if(jsonStr[key].cellType == 'RadioGroup' || jsonStr[key].cellType == 'CheckboxGroup' 
							 || jsonStr[key].cellType == 'ComboBox' || jsonStr[key].cellType == 'MultiFilteringSelect'){     //单选按钮组,复选按钮组,下拉框,多选下拉框
						 inputValue = $("#option_"+array[i]+"").val();
					
					 }else if(jsonStr[key].cellType == 'Spinner'){     //数字框
						 inputValue = $("#numberSpinner_"+array[i]+"").val();
					 
					 }else if(jsonStr[key].cellType == 'SingleUserSelect' || jsonStr[key].cellType == 'MultiUserSelect'){   //单选人员   多选人员       				
				    	 inputValue = $("#singlePerson_"+array[i]+"").val();
		    	 					
					 }else if(jsonStr[key].cellType == 'SingleDepSelect' || jsonStr[key].cellType == 'MultiDepSelect'){   //单选部门  多选部门	      
						 inputValue = $("#singleDep_"+array[i]+"").val();
					 				 
					 }else{     //文本框
						 inputValue = $("#inputxt_"+array[i]+"").val();  
					 }
				}
		 	 }
		 	 if(typeof(inputValue) == "undefined"){
		 		inputValue = "";
			 }
		 	 if(inputValue == ''){
		 		if(array.length != 1){
		 			 alert("请填写"+(i+1)+"行的值");
					 return;
		 		}else{
		 			inputValue = "";
		 		}
				
			 }
		 	 
		 	 var connector = $("#connector_"+array[i]+"").val();  //连接符条件
		 	 if(typeof(connector) == "undefined"){
		 		connector = "";
			 }
		 	 str = str + '{';
		 	 str = str + '"fieldName":"'+fieldName+'",';
		 	 str = str + '"operator":"'+operator+'",';
		 	 str = str + '"value":"'+inputValue+'",';
		 	 str = str + '"connector":"'+connector+'"';
		 	 str = str + '},';
		 }
		 str = str.substring(0,str.length-1);
		 str = str +  ']';
		
		 var data = {};
		 data.advanceQueryValue = str;
		 data.dataGrid = dataGrid;
		 Matrix.closeLayerWindow(data);
	 }
	 
	//取消关闭窗口
	 function closeByButton(){
		 Matrix.closeLayerWindow();
	 }
	
	//重置置空
	function resetByButton(){
		window.location.href = "<%=path%>/office/html5/select/advancedQuery.jsp?iframewindowid=DataGridCustomFilter&dataGrid="+dataGrid+"&flag=reset";
	}
	
	var elementObj;
	
	//弹出单选人员窗口
	function openSinglePerson(obj){
		elementObj = obj;
		layer.open({
			    id:'singlePerson',
				type : 2,
				
				title : ['请选择'],
				//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '95%', '95%' ],
				content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=singlePerson"
		}); 
	}	
	//单选用户回调
	function onsinglePersonClose(data){
		if(data!=null){
			 var name=data.names;
			 $(elementObj).prev().val(name);
		}
	 }
	
	//弹出多选人员窗口
	function openMultiPerson(obj){
		elementObj = obj;
		layer.open({
			    id:'multiPerson',
				type : 2,
				
				title : ['请选择'],
				//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '95%', '95%' ],
				content : "<%=request.getContextPath()%>/office/html5/select/MultiSelectPerson.jsp?iframewindowid=multiPerson"
		}); 
	}	
	//多选用户回调
	function onmultiPersonClose(data){
		if(data!=null){
			 var name=data.names;
			 $(elementObj).prev().val(name);
		}
	 }
	
	//弹出单选部门窗口
	function openSingleDep(obj){
		elementObj = obj;
		layer.open({
			    id:'singleDep',
				type : 2,
				
				title : ['请选择'],
				//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '95%', '95%' ],
				content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=singleDep"
		}); 
	}	
	//单选用户回调
	function onsingleDepClose(data){
		if(data!=null){
			 var name=data.names;
			 $(elementObj).prev().val(name);
		}
	 }

	//弹出多选部门窗口
	function openMultiDep(obj){
		elementObj = obj;
		layer.open({
			    id:'multiDep',
				type : 2,
				
				title : ['请选择'],
				//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '95%', '95%' ],
				content : "<%=request.getContextPath()%>/office/html5/select/MultiSelectDep.jsp?iframewindowid=multiDep"
		}); 
	}	
	//多选部门回调
	function onmultiDepClose(data){
		if(data!=null){
			 var name=data.names;
			 $(elementObj).prev().val(name);
		}
	 }
</script>
</head>
<body>
	<div style="position: absolute;height: 100%;width: 100%;">
		<div style="height:calc(100% - 54px);overflow: auto;">
			<table id="tb" class="table table-bordered">
				<tr>
					<td class="label-td" style="vertical-align:middle;">
						<label>字段</label>
					</td>
					<td style="width:15%;">
						<div style="width:90%;"> 
		                    <select id="variable_0" class="selectpicker form-control" data-size="5" title="请选择" onchange="selectOnchange(this);">  
		                       
		                    </select>  
		               	 </div>
					</td>
					<td class="label-td" style="vertical-align:middle;">
						<label>操作</label>
					</td>
					<td style="width:15%;">		
						 <div style="width:90%;"> 
		                    <select id="operator_0" class="selectpicker form-control">  
		                        <option value="equals">等于</option>  
		                        <option value="like">包含</option>
		                        <option value="isNull">为空</option>
		                        <option value="notNull">不为空</option>
		                        <option value=">">大于</option>
		                        <option value="<">小于</option>
		                        <option value=">=">大于或等于</option>
		                        <option value="<=">小于或等于</option>
		                    </select>  
		               	 </div>
					</td>
					<td class="label-td" style="vertical-align:middle;">
						<label>值</label>
					</td>
					<td id="td_0" style="width:20%;"> 
		                <div id="txt_0" style="display:''">
		                 	<input id="inputxt_0" type="text" class="form-control" style="width:90%;"/>
		                </div>
		                <div id="inputDate_0_div" class="date-default-width col-md-12  input-prepend input-group" style="display: none; vertical-align: middle;width:90%;">
			                <input id="inputDate_0" name="inputDate_0" class="form-control layer-date" style="width:100%;"/>
			                <span class="input-group-addon addon-udSelect udSelect"><i class="fa fa-calendar"></i>
		                    </span>
		                </div>
		                <div id="inputTime_0_div" class="input-group  default-width clockpicker" style="display:none;vertical-align: middle;width:90%;">
			                <input id="inputTime_0" name="inputTime_0" class="form-control" style="width:100%;"/>
			                <span class="input-group-addon addon-udSelect udSelect"><i class="fa fa-clock-o"></i>
		                    </span>
		                </div>
		                <div id="wheornot_0" style="display: none;"> 
		                    <div style="width:90%;">
			                    <select id="ifelse_0" class="selectpicker form-control">  
			                        <option value="1">是</option>  
			                        <option value="0">否</option>  
			                    </select>  
		                    </div>
		               	</div>
		               	<div id="choose_0" style="display: none;"> 
		                    <div style="width:90%;">
			                    <select id="option_0" class="selectpicker form-control" data-live-search="true" data-size="5">  
			                    
			                    </select>  
		                    </div>
		               	</div>
		               	<div id="numberSpinner_0_div" class="input-group default-width col-md-12 " style="display:none;vertical-align: middle;width: 90%;">
		               		 <input type="number" id="numberSpinner_0" name="numberSpinner_0" class="form-control" style=" width:100%;" >
		               	</div>
		               	<div id="singlePerson_0_div" class="input-group" style="display: none;vertical-align: middle;width: 90%;">
							 <input id="singlePerson_0" name="singlePerson_0" class="form-control">
		            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openSinglePerson(this);"><i class="fa fa-user" style="padding: 0 2px;"></i></span>
						</div>
						<div id="singleDep_0_div" class="input-group" style="display: none;vertical-align: middle;width: 90%;">
							 <input id="singleDep_0" name="singleDep_0" class="form-control">
		            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openSingleDep(this);"><i class="fa fa-th-large" style="padding: 0 1px;"></i></span>
						</div>
					</td>
					<td style="width:12%;" id="emptyCell_0">
					
					</td>
					<td style="vertical-align:middle;width:8%;">
						<span id="add" class="ico16 oprate_plus_16 right"  onclick="addRow(this);"></span>
						<span id="del" class="ico16 oprate_reduce_16 right" onclick="delRow(this);"></span>	
					</td>
				</tr>
			</table>
		</div>
		<div class="cmdLayout" style="text-align:right;padding-right:20px;width:100%;bottom:0px;">
		   <input type="button"  class="x-btn ok-btn" name="确定" value="确定" onclick="submitByButton();">
		   <input type="button" class="x-btn ok-btn" name="重置" value="重置" onclick="resetByButton();">
		   <input type="button" class="x-btn cancel-btn" name="取消" value="取消" onclick="closeByButton();">
		</div>
	</div>
</body>
</html>