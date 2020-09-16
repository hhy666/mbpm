<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.model.action.ServiceClassHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	//提交表单
	function submitButton(){
		//提交之前先校验
		if(!M_mform_01.validate()){
			Matrix.hideMask();
			return false;
		}
	
		 var opType = document.getElementById("opType").value;
	     var _form = document.getElementById("_mform_01");
	    
		 if("add"==opType){//添加
		 	var addUrl = "<%=request.getContextPath()%>/number/serialNumber_addSerialNum.action";
		 	_form.action = addUrl;
		 	
		 }else if("update"==opType){
		    var updateUrl = "<%=request.getContextPath()%>/number/serialNumber_updateSerialNum.action";
		 	_form.action = updateUrl;
		 }
		 
		 Matrix.convertFormItemValue('_mform_01');
		 _form.submit();
		
	}
	
	//初始
	function initPage(){
		var repeatMsg = "${requestScope.rMsg}";
		if(repeatMsg=="true"){
			isc.warn("流水号编码重复!");
		}
		
		var opType="${requestScope.opType}";
		if(opType=="update"){
			Mid.setCanEdit(false);
		}
	}
	
	//********************************************************
	//通用验证方法 
	function commonValidate(value, regexExp, validator){
		if(value==null||value.length==0){
		    validator.errorMessage="非空字段!";
			return false;
		}  
		var hasInput =  Matrix.validateLength(1,255, value);
		if(hasInput){
			var isMatch = value.match(regexExp);
			if(isMatch!=null){
				return true;
			}else{
				return false;
			}
		
		}else{
			return false;
		} 
	
	}
	
	
	
	
	//id验证 
	function idValidator(item, validator, value, record){
		//var id = Matrix.getFormItemValue("id");
		var regexExp =/^[A-Za-z][\w]*$/;
		return commonValidate(value,regexExp,validator);
		
	}
	//name验证
	function nameValidator(item, validator, value, record){
		//var name = Matrix.getFormItemValue("name2");
		var regexExp =/^[\w\u4e00-\u9fa5]+$/;
		return commonValidate(value, regexExp,validator);
	
	}
	
	function prefixValidator(item, validator, value, record){
		if(value==null||value.length==0){
			return true;
		}
		var regexExp = /^[\$\{\}\[\]\(\)\.<>\-\w\u4e00-\u9fa5\s]+$/;
		return commonValidate(value, regexExp,validator);
		
	}
	
	function postfixValidator(item, validator, value, record){
		if(value==null||value.length==0){
			return true;
		}
		var regexExp = /^[\$\{\}\[\]\(\)\.<>\-\w\u4e00-\u9fa5\s]+$/;
		return commonValidate(value, regexExp,validator);
	
	}
	
	//规则非空
	function ruleValidator(item, validator, value, record){
		var regexExp =/^[A-Z]+$/;
		return commonValidate(value, regexExp,validator);
		
	}
	
	//间隔符()[]<> 
	function sepValidator(item, validator, value, record){
		if(value==null || value.length==0){
			return true;
		}
		
		var regexExp =/^[\-\w_\.,;\:\s\u4e00-\u9fa5]+$/;
		return commonValidate(value, regexExp,validator);
		
	}
	
	//起始值 未填默认为0
	function startNumValidator(item, validator, value, record){
		if(value==null||value.length==0){
			value ="0";
			MstartNum.setValue(0);
		}
		var regexExp =/^[0-9]*$/;
		return commonValidate(value, regexExp,validator);
	}
	//步长 默认为1
	function stepValidator(item, validator, value, record){
		if(value==null||value.length==0){
			value ="1";
			Mstep.setValue(1);
		}
		var regexExp =/^[1-9][0-9]*$/;
		return commonValidate(value, regexExp,validator);
	}
	
	function lengthValidator(item, validator, value, record){
		var regexExp =/^[1-9][0-9]*$/;
		return commonValidate(value, regexExp,validator);
	}
	
	
	function stateValidator(item, validator, value, record){
	
		var regexExp =/^[0-1]+$/;
		return commonValidate(value, regexExp,validator);
	}
	
	
	
</script>

</head>
<body onload="initPage()">
		
<%

com.matrix.form.test.render.PropertiesRender render2 = new com.matrix.form.test.render.PropertiesRender();
	String content = render2.render(request, response);
	out.print(content);	
%>


</body>
</html>