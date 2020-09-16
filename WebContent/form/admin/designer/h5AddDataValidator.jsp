<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>数据验证器H5编辑页面</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">
	//更新时对页面进行初始化操作
	$(function(){ 
		var opType = $('#opType').val();
		if(opType!=null && opType=="update"){
			var validatorType = "${requestScope.validatorType}";
			
			//update validator echo  message
			if(validatorType!=null){
				//0.change validatorType component
				$('#validatorType').val(validatorType);
				//验证器类型不可以修改
				$('#validatorType').attr("disabled",true)
			    //1.get rows div module div
	            var precisionDiv = document.getElementById("precisionDiv");
	            var expressionDiv = document.getElementById("expressionDiv");
	            var minValueDiv = document.getElementById("minValueDiv");
	            var maxValueDiv = document.getElementById("maxValueDiv");
	            var functionNameDiv = document.getElementById("functionNameDiv");
	            var errorMessage = document.getElementById("errorMessage");
	            
	            //回显错误消息值
	            $('#errorMessage').val("${requestScope.errorMessage}");
					//2. according  type show input
	            if((validatorType == 'email')||(validatorType == 'postCode')||(validatorType == 'mobileTelephone')||(validatorType == 'identityCard')){
	                //hide row div 
	            	precisionDiv.style.display = 'none';
	            	expressionDiv.style.display = 'none';
	            	minValueDiv.style.display = 'none';
	            	maxValueDiv.style.display = 'none';
	            	functionNameDiv.style.display = 'none';            	
	            }else if(validatorType == "precision"){//精度验证器
	            	precisionDiv.style.display = 'table-row';
	            	expressionDiv.style.display = 'none';
	            	minValueDiv.style.display = 'none';
	            	maxValueDiv.style.display = 'none';
	            	functionNameDiv.style.display = 'none';
	            	// echo show precision value
	                $('#precision').val("${requestScope.precision}");
	            }else if((validatorType == 'regexp')||(validatorType == 'jsExpression')){//正则表达式，js表达式
	            	precisionDiv.style.display = 'none';
	            	expressionDiv.style.display = 'table-row';
	            	minValueDiv.style.display = 'none';
	            	maxValueDiv.style.display = 'none';
	            	functionNameDiv.style.display = 'none';
	            	//回显表达式
	            	$('#expression').val("${requestScope.expression}");;
	            }else if(validatorType == 'jsFunction'){//js方法
	            	precisionDiv.style.display = 'none';
	            	expressionDiv.style.display = 'none';
	            	minValueDiv.style.display = 'none';
	            	maxValueDiv.style.display = 'none';
	            	functionNameDiv.style.display = 'table-row';
	            	$('#functionName').val("${requestScope.functionName}");;
	            }else if((validatorType == 'longRange')||(validatorType == 'doubleRange')||(validatorType == 'length')){
	            	precisionDiv.style.display = 'none';
	            	expressionDiv.style.display = 'none';
	            	minValueDiv.style.display = 'table-row';
	            	maxValueDiv.style.display = 'table-row';
	            	functionNameDiv.style.display = 'none';
	                $('#minValue').val("${requestScope.minValue}");;
	                $('#maxValue').val("${requestScope.maxValue}");;
	            }
			}
		}
		
		$("#save").on("click",function(){
			$('#validateMessage').val('');
     		Matrix.showMask2();
    		//表单验证
    		if (!Matrix.validateForm('form0')) {
    			Matrix.hideMask2();
    			return false;
    		} 	
    		debugger;
    		//最小值验证
    		if (!minValueValidate()) {
    			var validateMessage = $('#validateMessage').val();
    			Matrix.warn(validateMessage);
    			Matrix.hideMask2();
    			return false;
    		}
    		//最大值验证
    		if (!maxValueValidate()) {
    			var validateMessage = $('#validateMessage').val();
    			Matrix.warn(validateMessage);
    			Matrix.hideMask2();
    			return false;
    		}
    		//方法名称验证
			if (!functionNameValidator()) {
				var validateMessage = $('#validateMessage').val();
    			Matrix.warn(validateMessage);
				Matrix.hideMask2();
    			return false;
    		}
			//精度验证
			if (!precisionValidator()) {
				var validateMessage = $('#validateMessage').val();
    			Matrix.warn(validateMessage);
				Matrix.hideMask2();
    			return false;
    		}
			//错误消息验证
			if (!errorMessageValidator()) {
				var validateMessage = $('#validateMessage').val();
    			Matrix.warn(validateMessage);
				Matrix.hideMask2();
    			return false;
			}
    		//保存
    		var data = convertDataByType();
			Matrix.closeWindow(data);
            Matrix.hideMask2(); 		
        });
		
		$("#cancel").on("click",function(){
			Matrix.closeWindow();
		});
	})     
            
	//验证器类型下拉框改变事件
    function validatorChanged(){
  		var value = $('#validatorType').val();
	    //get rows div module div
	    var precisionDiv = document.getElementById("precisionDiv");
	    var expressionDiv = document.getElementById("expressionDiv");
	    var minValueDiv = document.getElementById("minValueDiv");
	    var maxValueDiv = document.getElementById("maxValueDiv");
	    var functionNameDiv = document.getElementById("functionNameDiv");
     	//clear module value
     	clearInputValue();
   
		//according  type show input
        if((value == 'email')||(value == 'postCode')||(value == 'mobileTelephone')||(value == 'identityCard')){
        	precisionDiv.style.display = 'none';
        	expressionDiv.style.display = 'none';
        	minValueDiv.style.display = 'none';
        	maxValueDiv.style.display = 'none';
        	functionNameDiv.style.display = 'none';
        }else if(value == "precision"){//精度验证器
        	precisionDiv.style.display = 'table-row';
        	expressionDiv.style.display = 'none';
        	minValueDiv.style.display = 'none';
        	maxValueDiv.style.display = 'none';
        	functionNameDiv.style.display = 'none';
        }else if((value == 'regexp')||(value == 'jsExpression')){//正则表达式，js表达式
        	precisionDiv.style.display = 'none';
        	expressionDiv.style.display = 'table-row';
        	minValueDiv.style.display = 'none';
        	maxValueDiv.style.display = 'none';
        	functionNameDiv.style.display = 'none';
        }else if(value == 'jsFunction'){//js方法
        	precisionDiv.style.display = 'none';
        	expressionDiv.style.display = 'none';
        	minValueDiv.style.display = 'none';
        	maxValueDiv.style.display = 'none';
        	functionNameDiv.style.display = 'table-row';
        }else if((value == 'length')||(value == 'longRange')||(value == 'doubleRange')){
        	precisionDiv.style.display = 'none';
        	expressionDiv.style.display = 'none';
        	minValueDiv.style.display = 'table-row';
        	maxValueDiv.style.display = 'table-row';
        	functionNameDiv.style.display = 'none';        
        }
    }
    
    //清除输入框的值
    function clearInputValue(){	 
    	$('#precision').val('');
    	$('#expression').val('');
    	$('#minValue').val('');
    	$('#maxValue').val('');
    	$('#functionName').val('');
    }
    
    //保存
    function convertDataByType(){
        var data = null;
    	//1.get validator type
    	var opType = $('#opType').val();   //操作标志  add添加 update修改
    	var validatorType = $('#validatorType').val();
    	var componentType = $('#componentType').val();
    	var errorMessage = $('#errorMessage').val();
        if(errorMessage==null)errorMessage="";
    	if(validatorType == "precision"){//精度验证器
       	     var precision = $('#precision').val();
       	     precision = precision==null?"":precision;
        	 data = "{'opType':'"+opType+"','componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'precision':'"+precision+"','errorMessage':\""+errorMessage+"\"}}";
        	 
        }else if((validatorType == 'regexp')||(validatorType == 'jsExpression')){//正则表达式，js表达式
        	 var expression = $('#expression').val();
        	 data = "{'opType':'"+opType+"','componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'expression':'"+expression+"','errorMessage':\""+errorMessage+"\"}}";
        	
        }else if(validatorType == 'jsFunction'){//js方法
        	 var functionName = $('#functionName').val();
             data = "{'opType':'"+opType+"','componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'functionName':'"+functionName+"','errorMessage':\""+errorMessage+"\"}}";
            
        }else if((validatorType == 'length')||(validatorType == 'longRange')||(validatorType == 'doubleRange')){ 
             var minValue = $('#minValue').val();
             var maxValue = $('#maxValue').val();
             minValue = minValue==null?"":minValue;
             maxValue = maxValue==null?"":maxValue;
           	 data = "{'opType':'"+opType+"','componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'minValue':'"+minValue+"','maxValue':'"+maxValue+"','errorMessage':\""+errorMessage+"\"}}";
            
        }else{//only errorMessage input
        	data = "{'opType':'"+opType+"','componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'errorMessage':\""+errorMessage+"\"}}";
        }
        return data;
    }         
            
            
  	//最小值验证length', 'longRange', 'doubleRange
	 function minValueValidate(){
	  	//获取当前验证器类型
	  	var validatorType = $('#validatorType').val();
	  	if(validatorType=='length'){//字符长度  非负整数（正整数 + 0）
	  		var value = $('#minValue').val();
	  		var hasInput =  Matrix.validateLength(1,9, value);
		    if(hasInput){
		  	    if(Matrix.validateLong(value)){
		  	    	var maxValue = $('#maxValue').val();
		  	    	if(maxValue!=null){
			  	    	if(Matrix.validateLong(maxValue)){
			  	    		var maxNum = maxValue*1;
			  	    		var minNum = value*1;
			  	    		if(minNum<=maxNum){
			  	    			return true;
			  	    		}else{
			  	    			$('#validateMessage').val("最小值应该小于最大值");
			  	    		    return false;
			  	    		}
			  	    	}
		  	    	}
		  	    	return true;
		  	    }
		  	    $('#validateMessage').val("最小值只能使用非负整数");
		      	return false;
		    }else{
		    	$('#validateMessage').val("最小值长度不大于9");
			    return false;
		    }
	      	
	  	}else if(validatorType=='longRange'){  //整数范围
	  		var value = $('#minValue').val();
	  		var hasInput =  Matrix.validateLength(1,9, value);
		    if(hasInput){
		    	var isMatch = value.match(/^-?[0-9]+$/);//只能为数字
		  	    if(isMatch!=null){
		  	    	var maxValue = $('#maxValue').val();
		  	    	if(maxValue!=null){
			  	    	var maxMatch = maxValue.match(/^-?[0-9]+$/); //数字
			  	    	if(maxMatch!=null){
			  	    		var maxNum = maxValue*1;
			  	    		var minNum = value*1;
			  	    		if(minNum<=maxNum){
			  	    			return true;
			  	    		}else{
			  	    		   $('#validateMessage').val("最小值应该小于最大值");
			  	    		   return false;
			  	    		}
			  	    	}
		  	    	} 
		  	    	return true;
		  	    }
		  	  	$('#validateMessage').val("最小值只能使用整数");
		      	return false;
		    }else{
		    	$('#validateMessage').val("最小值长度不大于9");
			    return false;
		    }    
	  		
	  	}else if(validatorType=='doubleRange'){  //小数范围
	  		var value = $('#minValue').val();
	  		var isMatch = value.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);//小数或者整数
	  		if(isMatch!=null){
	  		     var maxValue = $('#maxValue').val();
	  		     if(maxValue!=null){
		  		     var maxMatch = maxValue.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);
		  		     if(maxMatch!=null){
		  		     	var maxNum = maxValue*1; //将字符串转化为值类型
		  		     	var minNum = value*1;
		  		     	if(minNum<=maxNum){
		  		     		return true;
		  		     	}else{
		  		     	    $('#validateMessage').val("最小值应该小于最大值");
		  		     	    return false;
		  		        }
	  		         }
	  		     }  
	  		     return true;
	  		}
	  		$('#validateMessage').val("最小值只能输入数字格式");
	  	    return false;
	  	}
	  	//根据不同类型进行不同的正则验证[可以为空]
	    return true;
	  }          
       
  	  //最大值校验
	  function maxValueValidate(){
		  	//获取当前验证器类型
		  	var validatorType = $('#validatorType').val();
		  	if(validatorType=='length'){ //字符长度   非负整数（正整数 + 0）
		  		var value = $('#maxValue').val();
		  		var hasInput =  Matrix.validateLength(1,9, value);
			    if(hasInput){
			    	if(Matrix.validateLong(value)){
			  	    	var minValue = $('#minValue').val();
			  	    	if(minValue!=null){
				  	    	if(Matrix.validateLong(minValue)){
				  	    		var minNum = minValue*1;
				  	    		var maxNum = value*1;
				  	    		if(maxNum>=minNum){
				  	    			return true;
				  	    		}else{
				  	    		   $('#validateMessage').val("最小值应该小于最大值");
				  	    		   return false;
				  	    		}	  	    	
				  	    	}
			  	    	}		  	    
			  	    	return true;
			  	    }
			  	    $('#validateMessage').val("最大值只能使用非负整数");
			      	return false;
			    }else{
			    	$('#validateMessage').val("最大值长度不大于9");
				    return false;
			    }
		  	    
		      	
		  	}else if(validatorType=='longRange'){ //整数范围
		  		var value = $('#maxValue').val();
		  		var hasInput =  Matrix.validateLength(1,9, value);
			    if(hasInput){
			    	var isMatch = value.match(/^-?[0-9]+$/);//只能为数字
			  	    if(isMatch!=null){
			  	    	var minValue = $('#minValue').val();;
			  	    	if(minValue!=null){
				  	    	var minMatch = minValue.match(/^-?[0-9]+$/);//数字
				  	    	if(minMatch!=null){
				  	    		var minNum = minValue*1;
				  	    		var maxNum = value*1;
				  	    		if(maxNum>=minNum){
				  	    			return true;
				  	    		}else{
				  	    			$('#validateMessage').val("最小值应该小于最大值");
				  	    		   return false;
				  	    		}
				  	    	}
			  	    	}
			  	    	return true;
			  	    }		  	   
			  	  	$('#validateMessage').val("最大值只能使用整数");
			      	return false;
			    }else{
			    	$('#validateMessage').val("最大值长度不大于9");
				    return false;
			    }
		  		
		  	
		  	}else if(validatorType=='doubleRange'){//小数范围
		  		var value = $('#maxValue').val();
		  		var isMatch = value.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);//小数或者整数
		  		if(isMatch!=null){
		  			 var minValue = $('#minValue').val();;
		  		     if(minValue!=null){
			  		     var minMatch = minValue.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);
			  		     if(minMatch!=null){
			  		     	var minNum = minValue*1; //将字符串转化为值类型
			  		     	var maxNum = value*1;
			  		     	if(maxNum>=minNum){
			  		     		return true;
			  		     	}else{
			  		     		$('#validateMessage').val("最小值应该小于最大值");
			  		     	    return false;
			  		        }
		  		         }
		  		     }  
		  		     return true;
		  		}
		  		$('#validateMessage').val("最大值范围只能输入数字格式");
		  	    return false;
		  	}
		  	//根据不同类型进行不同的正则验证[可以为空]
		    return true;	  
		  }
		  
	  //functionName 英文验证 字母数字数字下划线 且不能以数字开头/^[a-zA-Z\_]+[a-zA-Z\_\d]+$/
	  function functionNameValidator(){
		  var validatorType = $('#validatorType').val();
		  if(validatorType=='jsFunction'){//为JS方法验证才验证		
			 var value = $('#functionName').val();
		     var hasInput =  Matrix.validateLength(1,255, value);
		     if(hasInput){
		     	var isMatch = value.match(/^[a-zA-Z_]+[a-zA-Z_\d]+$/);
		     	if(isMatch!=null){//符合输入
		     		return true;
		     	}
		     	$('#validateMessage').val("方法名请按正确的格式输入");
		  		return false;
		     }else{
		    	$('#validateMessage').val("方法名长度不大于255");
			  	return false;
		     }
		  }
	     return true;
	  }
		 
	  
	 //精度验证
     function precisionValidator(){
    	 var validatorType = $('#validatorType').val();
       	 if(validatorType=='precision'){   
       		  var value = $('#precision').val();     
	       	  var hasInput =  Matrix.validateLength(1,9, value);
			  if(hasInput){
				  if(Matrix.validateLong(value)){
		         	  return true;
		          }else{
		        	  $('#validateMessage').val("精度只能使用非负整数");
			  		  return false;
		          }    
			  }else{
				  $('#validateMessage').val("精度长度不大于9");
				  return false;
			  }
       	 }	
       	 return true;
      }    
	 
     //错误消息验证 中文英文 常用符号
	 function errorMessageValidator(){	
		var value = $('#errorMessage').val();
	    var hasInput =  Matrix.validateLength(1,255, value);
	    if(hasInput){
	       if(value == null || value == ''){
   			   return true;
   		   }
	       var isMatch=value.match(/^[a-zA-Z0-9_\u4e00-\u9fa5]+[\?!\？！]{0,1}$/);
	       if(isMatch!=null){
	       		return true;
	       }
	       $('#validateMessage').val("错误消息请按正确的格式输入");
	       return false;
	    }else{
	       $('#validateMessage').val("错误消息长度不大于255");
	       return false;
	    }
	 }
</script>
</head> 
<body>           
    <form id="form0" name="form0" eventProxy="MForm0" method="post" action="" style="margin:0px;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
         <input type="hidden" id="form0" name="form0" value="form0" /> 
         <!-- 校验 -->
		 <input type="hidden" id="validateType" name="validateType" value="jquery" />  
		 <!-- 弹出窗口编码 -->
         <input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}"/>
         <!-- 操作标志  add添加  update修改 -->
         <input id="opType" type="hidden" name="opType" value="${param.opType}"/>
         <!-- 校验信息 -->
         <input id="validateMessage" type="hidden" name="validateMessage" value=""/>
         
         <input id="componentType" type="hidden" name="componentType" value="${param.componentType}"/>
          
          
         <div id="container" style=" position: absolute;height: 100%;width: 100%;overflow: hidden;padding: 10px"> 
         	 <div id="top" style="height:calc(100% - 54px); width:100%;overflow: auto;">            
                 <table id="table001" class="tableLayout" style="width: 100%;">
                     <tr id="tr001">
                         <td id="td001" class="tdLabelCls" style="width: 25%;">                      
                          	<label>验证器：</label>
					     </td>  
                         <td id="td002" class="tdValueCls" style="width:75%;">
							 <div id="validatorType_div" style="vertical-align: middle;">
								<select id="validatorType" name="validatorType" value="" class="form-control" style="height:100%;width:100%;" onchange="validatorChanged();">
			                       <option value="email">Email验证器</option>
			                       <option value="postCode">邮编验证器</option>
			                       <option value="mobileTelephone">手机验证器</option>
			                       <option value="identityCard">身份证验证器</option>
			                       <option value="precision">小数精度验证器</option>
			                       <option value="jsFunction">JS方法验证器</option>
			                       <option value="length">字符长度验证器</option>
			                       <option value="regexp">正则表达式验证器</option>
			                       <option value="jsExpression">JS表达式验证器</option>
			                       <option value="longRange">整数范围验证器</option>
			                       <option value="doubleRange">小数范围验证器</option>
			                    </select>
							 </div>
						  </td>                                     
                     </tr>
                     <tr id="minValueDiv" style="display:none">
  						 <td id="td003" class="tdLabelCls" style="width: 25%">
							<label>最小值：</label>
						 </td>
						 <td id="td004" class="tdValueCls" style="width: 75%;">
						    <div id="minValue_div" style="vertical-align: middle;">
								<input id="minValue" name="minValue" type="number" value="" class="form-control" style="height:100%;width:100%;" required="required"/>
						    </div>
						 </td>
					 </tr>
					 <tr id="maxValueDiv" style="display:none">
  						 <td id="td005" class="tdLabelCls" style="width: 25%">
							<label>最大值：</label>
						 </td>
						 <td id="td006" class="tdValueCls" style="width: 75%;">
						    <div id="maxValue_div" style="vertical-align: middle;">
								<input id="maxValue" name="maxValue" type="number" value="" class="form-control" style="height:100%;width:100%;" required="required"/>
						    </div>
						 </td>
					 </tr>
					 <tr id="functionNameDiv" style="display:none">
  						 <td id="td005" class="tdLabelCls" style="width: 25%">
							<label>方法名: </label>
						 </td>
						 <td id="td006" class="tdValueCls" style="width: 75%;">
						    <div id="functionName_div" style="vertical-align: middle;">
								<input id="functionName" name="functionName" type="text" value="" class="form-control" style="height:100%;width:100%;" required="required"/>
						    </div>
						 </td>
					 </tr>
                     <tr id="expressionDiv" style="display:none">
  						 <td id="td007" class="tdLabelCls" style="width: 25%">
							<label>表达式： </label>
						 </td>
						 <td id="td008" class="tdValueCls" style="width: 75%;">
						    <div id="expression_div" style="vertical-align: middle;">
								<input id="expression" name="expression" type="text" value="" class="form-control" style="height:100%;width:100%;" required="required"/>
						    </div>
						 </td>
					 </tr>    
                     <tr id="precisionDiv" style="display:none">
  						 <td id="td009" class="tdLabelCls" style="width: 25%">
							<label>精度： </label>
						 </td>
						 <td id="td010" class="tdValueCls" style="width: 75%;">
						    <div id="precision_div" style="vertical-align: middle;">
								<input id="precision" name="precision" type="number" value="" class="form-control" style="height:100%;width:100%;" required="required"/>
						    </div>
						 </td>
					 </tr>           
                     <tr id="errorMessageDiv">
  						 <td id="td011" class="tdLabelCls" style="width: 25%">
							<label> 错误消息： </label>
						 </td>
						 <td id="td012" class="tdValueCls" style="width: 75%;">
						    <div id="errorMessage_div" style="vertical-align: middle;">
								<input id="errorMessage" name="errorMessage" type="text" value="" class="form-control" style="height:100%;width:100%;"/>
						    </div>
						 </td>
					 </tr> 
			   	 </table>
			  </div>	     
              <div id="buttom" class="cmdLayout">
              		<input type="button" class="x-btn ok-btn" name="保存" value="保存" id="save" >
              		<input type="button" class="x-btn cancel-btn" name="关闭" value="关闭" id="cancel" >
              </div>      
           </div>
       </form>                 
   </body>
</html>