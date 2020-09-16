<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML >
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                添加验证器
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <script type="text/javascript">
            	//更新时对页面进行初始化操作
            	function initPage(){
            		var opType = parent.MDialog0.opType;
            		if(opType!=null && opType=="update"){
            			var validatorType = "${requestScope.validatorType}";
            			
            			//update validator echo  message
            			if(validatorType!=null){
            				//0.change validatorType component
            				var validTypeComp = Matrix.getMatrixComponentById("validatorType");
            				validTypeComp.setValue(validatorType);
            				//验证器类型不可以修改
            				validTypeComp.setCanEdit(false);
            			    //1.get rows div module div
			                var precisionDiv = document.getElementById("precisionDiv");
			                var expressionDiv = document.getElementById("expressionDiv");
			                var minValueDiv = document.getElementById("minValueDiv");
			                var maxValueDiv = document.getElementById("maxValueDiv");
			                var functionNameDiv = document.getElementById("functionNameDiv");
			                var errorMessage = Matrix.getMatrixComponentById("errorMessage");
			                
			                //回显错误消息值
			                errorMessage.setValue("${requestScope.errorMessage}");
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
			                    var precision = Matrix.getMatrixComponentById("precision");
			                    precision.setValue("${requestScope.precision}");
			                }else if((validatorType == 'regexp')||(validatorType == 'jsExpression')){//正则表达式，js表达式
			                	precisionDiv.style.display = 'none';
			                	expressionDiv.style.display = 'table-row';
			                	minValueDiv.style.display = 'none';
			                	maxValueDiv.style.display = 'none';
			                	functionNameDiv.style.display = 'none';
			                	//回显表达式
			                	var expression = Matrix.getMatrixComponentById("expression");
			              		expression.setValue("${requestScope.expression}");
			                }else if(validatorType == 'jsFunction'){//js方法
			                	precisionDiv.style.display = 'none';
			                	expressionDiv.style.display = 'none';
			                	minValueDiv.style.display = 'none';
			                	maxValueDiv.style.display = 'none';
			                	functionNameDiv.style.display = 'table-row';
			                	var functionName = Matrix.getMatrixComponentById("functionName");
			                	functionName.setValue("${requestScope.functionName}");
			                }else if((validatorType == 'longRange')||(validatorType == 'doubleRange')||(validatorType == 'length')){
			                	precisionDiv.style.display = 'none';
			                	expressionDiv.style.display = 'none';
			                	minValueDiv.style.display = 'table-row';
			                	maxValueDiv.style.display = 'table-row';
			                	functionNameDiv.style.display = 'none';
			                	var minValue = Matrix.getMatrixComponentById("minValue");
	                            var maxValue = Matrix.getMatrixComponentById("maxValue");
			                	minValue.setValue("${requestScope.minValue}");
			                	maxValue.setValue("${requestScope.maxValue}");
			                
			                }
            			}
            		}
            	
            	}
            
            
            
            
                //按钮改变时 根据值来判断显示对应的div
                function validatorChanged(form, item, value){
              
                //1.get rows div module div
                var precisionDiv = document.getElementById("precisionDiv");
                var expressionDiv = document.getElementById("expressionDiv");
                var minValueDiv = document.getElementById("minValueDiv");
                var maxValueDiv = document.getElementById("maxValueDiv");
                var functionNameDiv = document.getElementById("functionNameDiv");
	             //clear module value
	             clearInputValue();
               
          			//2. according  type show input
	                if((value == 'email')||(value == 'postCode')||(value == 'mobileTelephone')||(value == 'identityCard')){
	                    //hide row div 
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
                
                //clear input module value but errorMessage
                function clearInputValue(){	 
	                //1.get input module
	                var precision = Matrix.getMatrixComponentById("precision");
	                var expression = Matrix.getMatrixComponentById("expression"); 
	                var minValue = Matrix.getMatrixComponentById("minValue");
	                var maxValue = Matrix.getMatrixComponentById("maxValue");
	                var functionName = Matrix.getMatrixComponentById("functionName");
	                //2.clear  value 
	                precision.clearValue();
	                expression.clearValue();
	                minValue.clearValue();
	                maxValue.clearValue();
	                functionName.clearValue();
                
                }
                
                //according to validator type convert submit data
                function convertDataByType(){
                    var data = null;
                	//1.get validator type
                	var validatorType = Matrix.getMatrixComponentById("validatorType").getValue();
                	var componentType = document.getElementById("componentType").value;
	                var errorMessage = Matrix.getMatrixComponentById("errorMessage").getValue();
	                if(errorMessage==null)errorMessage="";
                	if(validatorType == "precision"){//精度验证器
	               	     var precision = Matrix.getMatrixComponentById("precision").getValue();
	               	     //if(precision==null)precision ="";
	               	      precision = precision==null?"":precision;
	                	 data = "{'componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'precision':'"+precision+"','errorMessage':\""+errorMessage+"\"}}";
	                }else if((validatorType == 'regexp')||(validatorType == 'jsExpression')){//正则表达式，js表达式
	                	 var expression = Matrix.getMatrixComponentById("expression").getValue();
	                	 data = "{'componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'expression':'"+expression+"','errorMessage':\""+errorMessage+"\"}}";
	                	
	                }else if(validatorType == 'jsFunction'){//js方法
	                	 var functionName = Matrix.getMatrixComponentById("functionName").getValue();
	                     data = "{'componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'functionName':'"+functionName+"','errorMessage':\""+errorMessage+"\"}}";
	                    
	                }else if((validatorType == 'length')||(validatorType == 'longRange')||(validatorType == 'doubleRange')){
	                     var minValue = Matrix.getMatrixComponentById("minValue").getValue();
	                     var maxValue = Matrix.getMatrixComponentById("maxValue").getValue();
	                   
	                     minValue = minValue==null?"":minValue;
	                      maxValue = maxValue==null?"":maxValue;
	                   	 data = "{'componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'minValue':'"+minValue+"','maxValue':'"+maxValue+"','errorMessage':\""+errorMessage+"\"}}";
	                    
	                }else{//only errorMessage input
	                	data = "{'componentType':'"+componentType+"','validatorType':'"+validatorType+"','data':{'errorMessage':\""+errorMessage+"\"}}";
	                
	                }
                    return data;
                }
                
                
          //最小值验证length', 'longRange', 'doubleRange
		  function  minValueValidate(item, validator, value, record){
		   if(value==null){
		   			return true;
		   	}
		  	//获取当前验证器类型
		  	var validatorType = Matrix.getMatrixComponentById("validatorType").getValue();
		  	var isMatch = null;
		  	if((validatorType=='length')||(validatorType=='longRange')){//长度验证器
		  		
		  	
		  	    isMatch = value.match(/^-?[0-9]+$/);//只能为数字
		  	    if(isMatch!=null){
		  	       isMatch = null;
		  	    	var maxValue = Matrix.getMatrixComponentById("maxValue").getValue();
		  	    	if(maxValue!=null){
			  	    	var  maxMatch = maxValue.match(/^-?[0-9]+$/);//数字
			  	    	if(maxMatch!=null){
			  	    		var maxNum = maxValue*1;
			  	    		var minNum = value*1;
			  	    		if(minNum<=maxNum){
			  	    			return true;
			  	    		}else{
			  	    		   validator.errorMessage="最小值应该小于最大值!";
			  	    		   return false;
			  	    		}
			  	    	
			  	    	}
		  	    	}
		  	    
		  	    	return true;
		  	    }
		  	    if(validatorType=='length'){
		  	   		 validator.errorMessage="长度只能使用整数";
		  	    }else{
		  	    	validator.errorMessage="最小值只能使用数字";
		  	    }
		      	return false;
		  	}else if(validatorType=='doubleRange'){//双精度
		   		
		  		isMatch = value.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);//小数或者整数
		  		if(isMatch!=null){
		  			 isMatch = null;
		  		     var maxValue = Matrix.getMatrixComponentById("maxValue").getValue();
		  		     if(maxValue!=null){
			  		     var maxMatch = maxValue.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);
			  		     if(maxMatch!=null){
			  		     	var maxNum = maxValue*1; //将字符串转化为值类型
			  		     	var minNum = value*1;
			  		     	if(minNum<=maxNum){
			  		     		return true;
			  		     	}else{
			  		     	   validator.errorMessage="最小值不大于最大值";
			  		     	   return false;
			  		     }
		  		     }
		  		  }  
		  		     return true;
		  		}
		  		validator.errorMessage="只能输入数字格式";
		  	    return false;
		  	}
		  	//根据不同类型进行不同的正则验证[可以为空]
		    return true;
		  }
		  
		  function  maxValueValidate(item, validator, value, record){
		  	if(value==null){
		   			return true;
		   		}
		  	//获取当前验证器类型
		  	var validatorType = Matrix.getMatrixComponentById("validatorType").getValue();
		  	var isMatch = null;
		  	if((validatorType=='length')||(validatorType=='longRange')){//长度验证器
		  	
		  	    isMatch = value.match(/^-?[0-9]+$/);//只能为数字
		  	    if(isMatch!=null){
		  	       isMatch = null;
		  	    	var minValue = Matrix.getMatrixComponentById("minValue").getValue();
		  	    	if(minValue!=null){
			  	    	var  minMatch = minValue.match(/^-?[0-9]+$/);//数字
			  	    	if(minMatch!=null){
			  	    		var minNum = minMatch*1;
			  	    		var maxNum = value*1;
			  	    		if(maxNum>=minNum){
			  	    			return true;
			  	    		}else{
			  	    		   validator.errorMessage="最大值不小于最小值!";
			  	    		   return false;
			  	    		}
			  	    	
			  	    	}
		  	    	}
		  	    
		  	    	return true;
		  	    }
		  	    if(validatorType=='length'){
		  	   		 validator.errorMessage="长度只能使用整数";
		  	    }else{
		  	    	validator.errorMessage="最小值只能使用数字";
		  	    }
		      	return false;
		  	}else if(validatorType=='doubleRange'){//双精度
		  		isMatch = value.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);//小数或者整数
		  		if(isMatch!=null){
		  			 isMatch = null;
		  		     var minValue = Matrix.getMatrixComponentById("minValue").getValue();
		  		     if(minValue!=null){
			  		     var minMatch = minValue.match(/^-?[0-9]*([.]{1}[0-9]+){0,1}$/);
			  		     if(minMatch!=null){
			  		     	var minNum = minValue*1; //将字符串转化为值类型
			  		     	var maxNum = value*1;
			  		     	if(maxNum>=minNum){
			  		     		return true;
			  		     	}else{
			  		     	   validator.errorMessage="最大值不小于最大值";
			  		     	   return false;
			  		     }
		  		     }
		  		  }  
		  		     return true;
		  		}
		  		validator.errorMessage="只能输入数字格式";
		  	    return false;
		  	}
		  	//根据不同类型进行不同的正则验证[可以为空]
		    return true;
		  
		  }
		  
		 //错误消息验证 中文英文 常用符号
		 function errorMessageValidator(item, validator, value, record){
		   if(value==null||value.length==0){
			  validator.errorMessage="非空字段!";
			  return false;
			}
		    var hasInput =  Matrix.validateLength(1,255, value);
		    if(hasInput){
		       var isMatch=value.match(/^[a-zA-Z0-9_\u4e00-\u9fa5]+[\?!\？！]{0,1}$/);
		       if(isMatch!=null){
		       		return true;
		       }
		       validator.errorMessage="请按正确的格式输入!";
		       return false;
		    }
		    return true;
		 }
		 
		 
		 
		 //functionName 英文验证 字母数字数字下划线 且不能以数字开头/^[a-zA-Z\_]+[a-zA-Z\_\d]+$/
		  function functionNameValidator(item, validator, value, record){
			  var validatorType = Matrix.getMatrixComponentById("validatorType").getValue();
			  if(validatorType=='jsFunction'){//为JS方法验证才验证
			  
			  	if(value==null||value.length==0){
				  validator.errorMessage="非空字段!";
				  return false;
				}
			     var hasInput =  Matrix.validateLength(1,255, value);
			     if(hasInput){
			     	var isMatch = value.match(/^[a-zA-Z_]+[a-zA-Z_\d]+$/);
			     	if(isMatch!=null){//符合输入
			     		return true;
			     	}
			         	validator.errorMessage="请按正确的格式输入!";
			  		    return false;
			     }else{
			     	validator.errorMessage="方法名不为空!";
			  	    return false;
			     }
			  }
		     return true;
		  }
		 //精度验证 数字
         function precisionValidator(item, validator, value, record){
         	  var validatorType = Matrix.getMatrixComponentById("validatorType").getValue();
         	  if(validatorType=='precision'){
         	  	if(value==null||value.length==0){
				  validator.errorMessage="非空字段!";
				  return false;
				}
			         	  	
         	    var hasInput =  Matrix.validateLength(1,255, value);
         	    if(hasInput){
         	         var isMatch = value.match(/^[0-9]+$/);
         	         if(isMatch!=null){
         	         	return true;
         	         }else{
         	             validator.errorMessage="请按正确的格式输入!";
			  		    return false;
         	         }
         	         
         	    }
         	  }	
         	return true;
         }       
         
         //表达式验证[><={}[]]&正则表达式[非中文]
         function expressionValidator(item, validator, value, record){
         	
           var validatorType = Matrix.getMatrixComponentById("validatorType").getValue();
           if(validatorType=='regexp'){
           	 if(value==null||value.length==0){
			  validator.errorMessage="非空字段!";
			  return false;
			}
           
           	/* 
           		var isMatch = value.match(/^[a-zA-Z_\\\[\]\^\$\/]+$/);
	           	 if(isMatch!=null){
	           	 	return true;
	           	 }
           	  	validator.errorMessage="请按正确的格式输入!";
              	return false;
             */
           }else if(validatorType=='jsExpression'){
           
           	  if(value==null||value.length==0){
			    validator.errorMessage="非空字段!";
			    return false;
			  }
			  /* 
              var isMatch = value.match(/^[a-zA-Z_{}\[\]]+$/);
              if(isMatch!=null){
              	return true;
              }
         	  validator.errorMessage="请按正确的格式输入!";
              return false;
              */
           }
              return true;
         }
         
         
         
         
           
            </script>
        </head>
        
        <body onload="initPage()">
           <jsp:include page="/form/admin/common/loading.jsp"/>
            <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
                <script>
                    var MForm0 = isc.MatrixForm.create({
                        ID: "MForm0",
                        name: "MForm0",
                        position: "absolute",
                        action: "",
                        fields: [{
                            name: 'Form0_hidden_text',
                            width: 0,
                            height: 0,
                            displayId: 'Form0_hidden_text_div'
                        }]
                    });
                </script>
                <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
                style="margin:0px;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="Form0" value="Form0" />
                    <input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}"/>
                     <input id="componentType" type="hidden" name="componentType" value="${param.componentType}"/>
                    
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;">
                    </div>
                  
                    <div style="text-valign:center;position:relative">
                        <table id="j_id3" jsId="j_id3" class="maintain_form_content" style="width:100%;">
                            <tr id="j_id4" jsId="j_id4">
                                <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1"
                                style="width:25%;">
                                    <label id="j_id6" name="j_id6" >
                                        验证器：
                                    </label>
                                </td>
                                <td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
                                    <div id="validatorType_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var MvalidatorType_VM = [];
                                        var validatorType = isc.SelectItem.create({
                                            ID: "MvalidatorType",
                                            name: "validatorType",
                                            editorType: "SelectItem",
                                            displayId: "validatorType_div",
                                            valueMap: [],
                                            value: "email",
                                            position: "relative",
                                            width: 180,
                                            changed:function(form, item, value){
                                            		validatorChanged(form, item, value);
                                            }
                                        });
                                        MForm0.addField(validatorType);
                                        MvalidatorType_VM = ['email', 'postCode', 'mobileTelephone', 'identityCard', 'precision', 'regexp', 'length', 'longRange', 'doubleRange', 'jsFunction', 'jsExpression'];
                                        MvalidatorType.displayValueMap = {
                                            'email': 'Email验证器',
                                            'postCode': '邮编验证器',
                                            'mobileTelephone': '手机验证器',
                                            'identityCard': '身份证验证器',
                                            'precision': '小数精度验证器',//整型存储
                                            'jsFunction': 'JS方法验证器',
                                            'length': '字符长度验证器',
                                            'regexp': '正则表达式验证器',
                                            'jsExpression': 'JS表达式验证器',
                                            'longRange': '整数范围验证器',
                                            'doubleRange': '小数范围验证器'
                                        };
                                        MvalidatorType.setValueMap(MvalidatorType_VM);
                                        MvalidatorType.setValue('email');
                                    </script>
                                </td>
                            </tr>
                            <tr id="minValueDiv" jsId="minValueDiv" style="display:none">
                                <td id="j_id49" jsId="j_id49" class="maintain_form_label" colspan="1"
                                rowspan="1" >
                                    <label id="j_id50" name="j_id50" >
                                        最小值：
                                    </label>
                                </td>
                                <td id="j_id51" jsId="j_id51" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="minValue_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var minValue = isc.TextItem.create({
                                            ID: "MminValue",
                                            name: "minValue",
                                            editorType: "TextItem",
                                            displayId: "minValue_div",
                                            position: "relative",
                                            width: 180,
                                             validators:[{
										      		    type:"custom",
										      		    condition:function(item, validator, value, record){
										      		       return minValueValidate(item, validator, value, record);
										      		       
										      		     },
										      		     errorMessage:"输入格式不正确!"
										      		 }]
                                        });
                                        MForm0.addField(minValue);
                                    </script>
                                </td>
                            </tr>
                            <tr id="maxValueDiv" jsId="maxValueDiv" style="display:none">
                                <td id="j_id53" jsId="j_id53" class="maintain_form_label" colspan="1"
                                rowspan="1" >
                                    <label id="j_id54" name="j_id54" >
                                        最大值：
                                    </label>
                                </td>
                                <td id="j_id55" jsId="j_id55" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="maxValue_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var maxValue = isc.TextItem.create({
                                            ID: "MmaxValue",
                                            name: "maxValue",
                                            editorType: "TextItem",
                                            displayId: "maxValue_div",
                                            position: "relative",
                                            width: 180,
                                            validators:[{
										      		    type:"custom",
										      		    condition:function(item, validator, value, record){
										      		       return maxValueValidate(item, validator, value, record);
										      		       
										      		     },
										      		     errorMessage:"输入格式不正确!"
										      		 }]
                                        });
                                        MForm0.addField(maxValue);
                                        
                                    </script>
                                </td>
                            </tr>
                            <tr id="functionNameDiv" jsId="functionNameDiv" style="display:none">
                                <td id="j_id63" jsId="j_id63" class="maintain_form_label" colspan="1"
                                rowspan="1" >
                                    <label id="j_id64" name="j_id64" >
                                        方法名：
                                    </label>
                                </td>
                                <td id="j_id65" jsId="j_id65" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="functionName_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var functionName = isc.TextItem.create({
                                            ID: "MfunctionName",
                                            name: "functionName",
                                            editorType: "TextItem",
                                            displayId: "functionName_div",
                                            position: "relative",
                                            width: 180,
                                            validators:[{
										      		  type:"custom",
										      		  condition:function(item, validator, value, record){
										      		      return functionNameValidator(item, validator, value, record);
										      		       
										      		    },
										      		     errorMessage:"输入格式不正确!"
										      		 }]
                                        });
                                        MForm0.addField(functionName);
                                    </script>
                                </td>
                            </tr>
                            <tr id="expressionDiv" jsId="expressionDiv" style="display:none">
                                <td id="j_id39" jsId="j_id39" class="maintain_form_label" colspan="1"
                                rowspan="1" >
                                    <label id="j_id40" name="j_id40" >
                                        表达式：
                                    </label>
                                </td>
                                <td id="j_id41" jsId="j_id41" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="expression_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var expression = isc.TextItem.create({
                                            ID: "Mexpression",
                                            name: "expression",
                                            editorType: "TextItem",
                                            displayId: "expression_div",
                                            position: "relative",
                                            width: 180,
                                            validators:[{
										      		  type:"custom",
										      		  condition:function(item, validator, value, record){
										      		      return expressionValidator(item, validator, value, record);
										      		       
										      		    },
										      		     errorMessage:"输入格式不正确!"
										      		 }]
                                        });
                                        MForm0.addField(expression);
                                    </script>
                                </td>
                            </tr>
                            <tr id="precisionDiv" jsId="precisionDiv" style="display:none">
                                <td id="j_id29" jsId="j_id29" class="maintain_form_label" colspan="1"
                                rowspan="1" >
                                    <label id="j_id30" name="j_id30" >
                                        精度：
                                    </label>
                                </td>
                                <td id="j_id31" jsId="j_id31" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="precision_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var precision = isc.TextItem.create({
                                            ID: "Mprecision",
                                            name: "precision",
                                            editorType: "TextItem",
                                            displayId: "precision_div",
                                            position: "relative",
                                            width: 180,
                                             validators:[{
										      		    type:"custom",
										      		    condition:function(item, validator, value, record){
										      		       return precisionValidator(item, validator, value, record);
										      		       
										      		     },
										      		     errorMessage:"输入格式不正确!"
										      		 }]
                                        });
                                        MForm0.addField(precision);
                                    </script>
                                </td>
                            </tr>
                            <tr id="j_id22" jsId="j_id22">
                                <td id="j_id23" jsId="j_id23" class="maintain_form_label" colspan="1"
                                rowspan="1" >
                                    <label id="j_id24" name="j_id24" >
                                        错误消息：
                                    </label>
                                </td>
                                <td id="j_id25" jsId="j_id25" class="maintain_form_input" colspan="1"
                                rowspan="1">
                                    <div id="errorMessage_div" eventProxy="MForm0" class="matrixInline" style="">
                                    </div>
                                    <script>
                                        var errorMessage = isc.TextItem.create({
                                            ID: "MerrorMessage",
                                            name: "errorMessage",
                                            editorType: "TextItem",
                                            displayId: "errorMessage_div",
                                            position: "relative",
                                            width: 180
                                        });
                                        MForm0.addField(errorMessage);
                                    </script>
                                </td>
                            </tr>
                            <tr id="j_id71" jsId="j_id71">
                                <td id="j_id72" jsId="j_id72" class="maintain_form_command" colspan="2"
                                rowspan="1">
                                    <div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:70px;;height:22px;">
                                        <script>
                                            isc.Button.create({
                                                ID: "MdataFormSubmitButton",
                                                name: "dataFormSubmitButton",
                                                title: "保存",
                                                displayId: "dataFormSubmitButton_div",
                                                position: "absolute",
                                                top: 0,
                                                left: 0,
                                                width: "100%",
                                                height: "100%",
												icon:Matrix.getActionIcon("save"),
                                                showDisabledIcon: false,
                                                showDownIcon: false,
                                                showRollOverIcon: false
                                            });
                                            MdataFormSubmitButton.click = function() {
                                                Matrix.showMask();
                                          
                                                if (!MForm0.validate()) {
                                                    Matrix.hideMask();
                                                    return false;
                                                }
												var data = convertDataByType();
												Matrix.closeWindow(data);
                                                Matrix.hideMask();
                                            };
                                        </script>
                                    </div>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:70px;;height:22px;">
                                        <script>
                                            isc.Button.create({
                                                ID: "MdataFormCancelButton",
                                                name: "dataFormCancelButton",
                                                title: "关闭",
                                                displayId: "dataFormCancelButton_div",
                                                position: "absolute",
                                                top: 0,
                                                left: 0,
                                                width: "100%",
                                                height: "100%",
                                                icon:Matrix.getActionIcon("exit"),
                                                showDisabledIcon: false,
                                                showDownIcon: false,
                                                showRollOverIcon: false
                                            });
                                            MdataFormCancelButton.click = function() {
                                                Matrix.showMask();
                                                var x = eval("Matrix.closeWindow();");
                                                if (x != null && x == false) {
                                                    Matrix.hideMask();
                                                    return false;
                                                }

                                                Matrix.hideMask();
                                            };
                                        </script>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <input id="id2" type="hidden" name="id2" />
                   
                </form>
                <script>
                    MForm0.initComplete = true;
                    MForm0.redraw();
                    isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
                </script>
            </div>
        </body>
    
    </html>