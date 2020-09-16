<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
 			function initButtons(){
 				var type = "${property.type}";
 				if(type != '9')
 					document.getElementById('tr006').style.display="none";
 				else	
 					document.getElementById('tr006').style.display="";
 				/*if(type!=null && type!='null' && type!='undefined' && type!=''){
 					if(type=='2'||type=='4' || type=='5' || type=='9'){
 					   if(){
 					   }
 						document.getElementById('tr006').style.display="";
 						MinitValue.setValue("0");
 						//if(type=='9'){//数值类型  设置默认值为0
 						//}
 					}
 				}*/
 				var editType = Matrix.getFormItemValue("editType");
 				if(editType!=null && editType.length>0){
 					if(editType=='update'){
 						document.getElementById("button003_div").style.display="none";
 						Mbutton003.setDisabled(true);
// 						Mbutton003.setRendered(false);
 					}else if(editType=='add'){
 						document.getElementById("button003_div").style.display="";
 						Mbutton003.setDisabled(false);
 						Matrix.setFormItemValue("input003","255");//长度
// 						Mbutton003.setRendered(true);
 					}
 				}
 				 
 			}
 			function setStyle(){
 			
 				//初始的时候  设置无默认值  根据不同情况，后面的时候设置默认值
 				//MinitValue.setValue("");
 				var value = Matrix.getFormItemValue('comboBox001');
 				var proType = McomboBox002.getValue();
 				var editType = Matrix.getFormItemValue("editType");
 				if(editType!='add'){
 					McomboBox002.setValue(proType);
 				}else{
 					//McomboBox002.setValue("1");
 				}
 				McomboBox002.setDisabled(false);
 				if(value!=null&&value!=""){
 					if(value=='4'||value=='5'||value=='9'){
 						document.getElementById('tr006').style.display="";
 						MinitValue.setValue("0");
 						//if(value=='9'){//数值类型  设置默认值为0
 						//}
 					}else{
 						document.getElementById('tr006').style.display="none";
 						MinitValue.setValue("");
 					}
 					if(value=='6'||value=='7'||value=='8'){
 						document.getElementById('tr005').style.display="none";
 						if(value=='7'){
 							//日期时间
 							McomboBox002.setValue("2");
 							//McomboBox002.setDisabled(true);
 						}
 					}else{
 						
 						document.getElementById('tr005').style.display="";
 					}
 					
 					if(value == '1'){
						
						/*********************长度 精度***********************/
						document.getElementById('tr005').style.display='';//显示长度tr
						document.getElementById('tr006').style.display='none';//隐藏精度tr
						
						Matrix.setFormItemValue("input003","255");//长度
						Matrix.setFormItemValue("input004","");//
			
						/***************************************************/
			
						/****************UI组件************************/
						//McomboBox002.setValue("1");
			 			McomboBox002.setDisabled(false);//随便修改
						/**********************************************/
					}
					if(value=='4'||value=='5'||value=='9'){
			 			//单精度 双精度 数值 时显示
			 			document.getElementById('tr006').style.display='';//显示精度tr
						document.getElementById('tr005').style.display='';//显示长度tr
						Matrix.setFormItemValue("input003","11");//长度为11
						Matrix.setFormItemValue("input004","2");//精度为2
						/****************UI组件************************/
						McomboBox002.setDisabled(false);//随便修改
						/**********************************************/
			 		}
					if(value == '3' || value == '9' || value == '7'){//控制显示格式
						document.getElementById('tr0061').style.display = '';
						if(value == '3' || value == '9'){
							document.getElementById('formatPatternDate_div').style.display='none';
							document.getElementById('formatPatternNumber_div').style.display='';
							Matrix.setFormItemValue("formatPatternDate", '');
							document.getElementById('displayFormatInput').value='';
						}else{
							document.getElementById('formatPatternDate_div').style.display='';
							document.getElementById('formatPatternNumber_div').style.display='none';
							Matrix.setFormItemValue("formatPatternNumber", '');
							document.getElementById('displayFormatInput').value='';
						}
						
					}else{
						document.getElementById('tr0061').style.display = 'none';
						document.getElementById('formatPatternDate_div').style.display='none';
						document.getElementById('formatPatternNumber_div').style.display='none';
						Matrix.setFormItemValue("formatPatternNumber", '');
						Matrix.setFormItemValue("formatPatternDate", '');
						document.getElementById('displayFormatInput').value='';
					}
					if(value=='7'){//日期时间
						/*********************隐藏精度***********************/
						document.getElementById('tr006').style.display='none';//隐藏精度tr
						document.getElementById('tr005').style.display='none';//隐藏长度tr
						Matrix.setFormItemValue("input003","");//
						Matrix.setFormItemValue("input004","");//
			
						/***************************************************/
			 			McomboBox002.setValue("2");
			 			//McomboBox002.setDisabled(true);
			 		}
			 		if(value=='2'){
			 			/*********************隐藏精度***********************/
						document.getElementById('tr006').style.display='none';//隐藏精度tr
						document.getElementById('tr005').style.display='';//隐藏长度tr
						Matrix.setFormItemValue("input003","20");//
						Matrix.setFormItemValue("input004","");//
						MinitValue.setValue("0");
						/***************************************************/
			 			//McomboBox002.setValue("1");
			 			McomboBox002.setDisabled(false);
			 		}
			 		
			 		if(value =='3'){
			 		   Matrix.setFormItemValue("input003","12");//
			 			document.getElementById("tr018").style.display="";
			 		}
			 		if(value == '9'){
			 			document.getElementById("tr006").style.display="";
			 			//document.getElementById("tr018").style.display="none";
			 		}else{
			 			document.getElementById("tr006").style.display="none";
			 			document.getElementById("tr018").style.display="";
			 			
			 		}
 				}
 			}
 			 //验证编码输入
	function formVarIdValidate(item, validator, value, record){
		if(value==null||value.length==0){
		  validator.errorMessage="编码不能为空!";
		  return false;
		}
		var hasInput = Matrix.validateLength(1,255, value);
		if(hasInput){
			var editType = Matrix.getFormItemValue("editType");
			if(editType=='add'){
				var allTreeData = parent.MTree0_DS.$27m;
				if(allTreeData!=null && allTreeData.length>0){
					var parentNodeId = Matrix.getFormItemValue("parentNodeId");
					for(var i = 0;i<allTreeData.length-1;i++){
						var data = allTreeData[i];
						if(data.parentId == parentNodeId){
							if(data.sid==value){
								 validator.errorMessage="编码重复!";
								 return false;
							}
						}
					}
				}
			}
		 	var isMatch = value.match(/^[a-z][\w]*$/);
		 	if(isMatch!=null){
				 return true;
		 	}
	   		//分类返回错误消息
		 	var exceptMsg = value.match(/^[a-zA-Z\d_]+$/);//
		 	if(exceptMsg==null){//含有非法字符
			 	validator.errorMessage="只能使用字母数字下划线命名";
		   		return false;
		 	}
		  	//2.以下划线 数字开头[第一位]
		 	var validateMsg1 = value.match(/^[^a-z][a-zA-Z\d_]+$/);
		 	if(validateMsg1!=null){
		  		validator.errorMessage="首字母小写";
	   			return false;
		  	} 
	   		validator.errorMessage="只能使用字母、数字和下划线命名，且以小写字母开头";
	   		return false;
	 	}
	    validator.errorMessage="编码不能为空!";
		return hasInput;
 	}
	
	  
	//验证名称输入
	function formVarNameValidate(item, validator, value, record){
		if(value==null||value.length==0){
		   validator.errorMessage="名称不能为空!";
		   return false;
		}
		var hasInput = Matrix.validateLength(1,255, value);
		if(hasInput){
			var editType = Matrix.getFormItemValue("editType");
			/*if(editType=='add'){
				var allTreeData = parent.MTree0_DS.$27m;
				if(allTreeData!=null && allTreeData.length>0){
					var parentNodeId = Matrix.getFormItemValue("parentNodeId");
					for(var i = 0;i<allTreeData.length-1;i++){
						var data = allTreeData[i];
						if(data.parentId == parentNodeId){
							if(data.name==value){
								 validator.errorMessage="名称重复!";
								 return false;
							}
						}
					}
				}
			}*/
			 var isMatch = value.match(/^[\w\u4e00-\u9fa5]+$/);
		 	 if(isMatch!=null){//非空
				 return true;
		 	 }
			 validator.errorMessage="不能使用字母汉字下划线以外的非法字符!";
	   		 return false;
	 	}
		return hasInput;
	}
	//长度校验
 	function lengthValidate(item, validator, value, record){
 		var comb = ['6','7','8','13','14'];
 		var uiType = McomboBox002.getValue();
 		if(uiType=='29'||uiType=='12'|| uiType=='27'|| uiType=='28'|| uiType=='31'){//流程意见 or 附件
 			return true;
 		}
 		if(!comb.contains(record.comboBox001)){
	 		if(value==null || value.length==0){//
	 			validator.errorMessage="长度不能为空!";
	 			return false;
	 		}
	 		var hasInput = Matrix.validateLength(1,255, value);
	 		if(hasInput){
	 			var isNum = value.match(/^\d+$/);
	 			if(!isNum){
	 				validator.errorMessage="不能含有非数字的字符!";
	 				return false;
	 			}
	 			var isMatch = value.match(/^[1-9]\d*$/);
	 			if(!isMatch){
	 				validator.errorMessage="数字格式不正确!";
	 				return false;
	 			}
	 		}
 		}
 		return true;
 	}	
 	//精度校验
 	function precisionValidate(item, validator, value, record){
 		var comb = ['4','5','9'];
 		var uiType = McomboBox002.getValue();
 		if(uiType=='29'||uiType=='12'|| uiType=='28'){//流程意见 or 附件
 			return true;
 		}
 		if(comb.contains(record.comboBox001)){
	 		if(value==null || value.length==0){//
	 			validator.errorMessage="精度不能为空!";
	 			return false;
	 		}
	 		var hasInput = Matrix.validateLength(1,255, value);
	 		if(hasInput){
	 			var isNum = value.match(/^\d+$/);
	 			if(!isNum){
	 				validator.errorMessage="不能含有非数字的字符!";
	 				return false;
	 			}
	 			var isMatch = value.match(/^[1-9]\d*$/);
	 			if(!isMatch){
	 				validator.errorMessage="数字格式不正确!";
	 				return false;
	 			}
	 		}
 		}
 		return true;
 	}
 	
 	 //获得序号
     function getNextIndex(data){
     	var index = 0;
     	if(data!=null && data.length>0){
     		for(var i = 0;i<data.length;i++){
     			var node = data[i];
     			if(node.parentId==parentNodeId){
     				index=index+1;
     			}
     		}
     	}
     	return index;
     }
 	  //获得子列表的个数
     function getCurFormVarPropertyMaxNum(data,parentNodeId,mainFormVarType){
     	var maxNum = 0;
     	var numArr = [];
     	if(data!=null && data.length>0){
     		for(var i = 0;i<data.length;i++){
     			var node = data[i];
     			if(mainFormVarType=='List' || mainFormVarType=='RList'){
	     			if(node.parentId==parentNodeId){
	     				var fdid = data[0].id;
	     				var entityId = node.entityId;
	     				if(entityId.contains(fdid+"field")){
	     					var num = entityId.replace(fdid+"field","");
		     				//var num = entityId.substr(entityId.indexOf("_")+1);
		     				numArr.add(num);
		     			}
	     			}
     			}else if(mainFormVarType=='DataObject'){
     				if(node.parentId==parentNodeId){
	     				var entityId = node.entityId;
	     				var fdid = node.parentNodeId.replace("EntityVar","");
	     				if(entityId.contains("m"+fdid+"field")){
	     					var num = entityId.replace("m"+fdid+"field","");
		     				//var num = entityId.substr(entityId.indexOf("_")+1);
		     				numArr.add(num);
		     			}
	     			}
     			}
     		}
     		maxNum = getMaxNum(numArr);
     	}
     	return maxNum;
     }
     //获得最大值
     function getMaxNum(numArr){
     	var max = 0;
     	if(numArr!=null && numArr.length>0){
     		max = parseInt(numArr[0]);
     		for(var i = 0;i<numArr.length-1;i++){
     			var n = parseInt(numArr[i+1]);
     			if(max<n){
     				max = n;
     			}
     		}
     		max = max+1;
     	}
     	return max;
     }
     //初始
 	function initForm(){
 		//初始的时候  设置无默认值  根据不同情况，后面的时候设置默认值
 		//MinitValue.setValue("");
 		
 		var phase = Matrix.getFormItemValue("phase");//当前阶段
 		var parentNodeId = Matrix.getFormItemValue('parentNodeId');
 		var canChangeEditType = Matrix.getFormItemValue("canChangeEditType");
 		var num = 0;
 		var editType = "${editType}";
 		var mainFormVarType = "${mainFormVarType}";
 		if(editType!=null && editType!='' && editType!='null'){
 			Matrix.setFormItemValue('editType',editType);
 		}
 		//精度 ， 数据字典， 显示格式  默认不显示
 		document.getElementById('tr006').style.display='none';
 		document.getElementById('tr0061').style.display='none';
 		document.getElementById('tr0042').style.display='none';
 		
 		initButtons();
 		
 		if(phase=='4'){
 			if(editType=='add'){
 					document.getElementById('tr021').style.display='none';
		 		var tree = parent.MTree0_DS.$27m;//树
		 		var formId = "";//表单编码
		 		if(tree!=null && tree.length>0){
		 			num = getCurFormVarPropertyMaxNum(tree,parentNodeId,mainFormVarType);
		 			formId = tree[0].entityId;//树的根节点编码  就是表单编码
		 		}
		 		if(formId==null || formId==''){
		 			//如果表单编码还拿不到  就用parentNodeId来获取
		 			if(parentNodeId.endWith("EntityVar")){
		 				formId = parentNodeId.replace("EntityVar","");
		 			}else if(parentNodeId.endWith("RAllListVar")){
		 				formId = parentNodeId.replace("RAllListVar","");
		 			}else if(parentNodeId.endWith("AllListVar") && !parentNodeId.endWith("RAllListVar")){
		 				formId = parentNodeId.replace("AllListVar","");
		 			}
		 		}
		 		var mid = formId+"field"+num;//属性的编码
		 		if(mainFormVarType=='DataObject'){
		 			mid = "m"+mid;//区分主表单变量属性和子表单变量属性
		 		}else if(mainFormVarType=='List' || mainFormVarType=='RList'){
		 			mid = "s"+mid;
		 		}
	 			//Matrix.setFormItemValue("input001",mid);
 			}
 			document.getElementById('tr001').style.display="none";
 		}else{
 			document.getElementById('tr001').style.display="";
 		}
 		
 		//属性类型
 		var defaultValue = MinitValue.getValue();
 		var proType = McomboBox001.getValue();
 		if(proType=='4'||proType=='5'||proType=='9'){
 			//单精度 双精度 数值 时显示
 			document.getElementById('tr006').style.display=''; 
 			//if(proType=='9'){
 				//是数值类型的
 				if(defaultValue !=null && defaultValue.length>0 && defaultValue!='null'){
 					MinitValue.setValue(defaultValue);
 				}else{
	 				MinitValue.setValue("0");
 				}
 			//}
 		}else if(proType=='7'){
 			if(editType=='add'){
	 			McomboBox002.setValue("2");
	 			//McomboBox002.setDisabled(true);
	 		}
 		}
 		if(proType == '7' || proType == '3' || proType == '9'){
 			document.getElementById('tr0061').style.display='';
 			if(proType == '7'){
 				document.getElementById('formatPatternDate_div').style.display='';
 				document.getElementById('formatPatternNumber_div').style.display='none';
 				Matrix.setFormItemValue("formatPatternNumber", '');
 			}else if(proType == '3' || proType == '9'){
 				document.getElementById('formatPatternDate_div').style.display='none';
 				document.getElementById('formatPatternNumber_div').style.display='';
 				Matrix.setFormItemValue("formatPatternDate", '');
 			}
 		}
 		var proTypeValue = '${property.type}';
 		var length = '${property.length}';
 		//UI编辑类型
 		var uiType = McomboBox002.getValue();
 		if(uiType=='29'||uiType=='12'|| uiType=='28'){
 			//附件和流程意见 不显示 类型 长度  精度  默认值 
 			document.getElementById('tr004').style.display='none';
 			document.getElementById('tr005').style.display='none';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='none';
 			
 			//文本域  属性类型默认是字符型不可修改
 			if(editType!='add'){
	 			McomboBox001.setValue(proTypeValue);
	 			Minput003.setValue(length);
 			}else{
 				McomboBox001.setValue("1");
 				document.getElementById('tr006').style.display='none';
	 			Minput003.setValue("255");
 			}
 			Minput003.setCanEdit(true);
 			McomboBox001.setDisabled(false);
 		}else if(uiType=='23'||uiType=='24'||uiType=='25'||uiType=='26'||uiType=='9'){
 			//初始加载   如果是 选部门  选人员
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr018').style.display='';
 			Minput003.setValue('200');
 			Minput003.setCanEdit(false);
 			McomboBox001.setValue('1');
 			McomboBox001.setDisabled(true);
 		}else if(uiType=='10'){
 			//文本域  属性类型默认是字符型不可修改
 			McomboBox001.setValue('1');
 			McomboBox001.setDisabled(true);
 			if(editType=='add'){
 				Minput003.setValue("255");
 			}else{
 				Minput003.setValue(length);
 			}
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr018').style.display='';
 		}else if(uiType=='30'){
 			//长度  默认值 不显示
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='none';
 			document.getElementById('tr018').style.display='none';
 			McomboBox001.setValue('8');//二进制
 			McomboBox001.setDisabled(true);
 			if(editType=='add'){
 				Minput003.setValue("255");
 			}else{
 				Minput003.setValue(length);
 				
 			}
 			
 		}else if(uiType=='2'||uiType=='3'){
 			//日期  时间
 			McomboBox001.setValue('7');//日期
 			McomboBox001.setDisabled(true);
 			document.getElementById('tr005').style.display='none';
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr018').style.display='';
 			if(uiType == '2'){
	 			document.getElementById('tr0061').style.display='';
 			}
 		}else if(uiType=='5'||uiType=='11'||uiType=='22'){
 			//列表框 下拉框 多选下拉框
 			McomboBox001.setValue("1");
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr0042').style.display='';
 			McomboBox001.setDisabled(true);
 			if(editType=='add'){
 				Minput003.setValue("255");
 			}else{
 				Minput003.setValue(length);
 				
 			}
 			Minput003.setCanEdit(true);
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr018').style.display='';
 			
 		}else if(uiType=='1'||uiType=='4'||uiType=='6'||uiType=='7'||uiType=='8'){
 			//其他情况
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr018').style.display='';
	 			if(editType=='add'){
	 				if(uiType!='4'){
	 					if(uiType=='1'||uiType=='8'){
	 						McomboBox001_VMText = [];
	 						var arrText = ['1'];
	 					 	var mapText = {'1':'字符'};
	 					 	McomboBox001.setDisabled(true);
	 					 	McomboBox001_VMTest = arrText;
	 						McomboBox001.displayValueMap = mapText;
	 						McomboBox001.setValueMap(McomboBox001_VMText);
	 						McomboBox001.setValue('1');
	 					}
		 				Minput003.setValue("255");
		 				McomboBox001.setValue("1");
		 				document.getElementById('tr006').style.display='none';
	 				}else{
	 					var arrInit = ['3','9'];
	 	 			 	var mapInit = {'3':'整数','9':'小数'};
						McomboBox001_VMInit = arrInit;
	 	 				McomboBox001.displayValueMap = mapInit;
	 	 				McomboBox001.setValueMap(McomboBox001_VMInit);
	 	 				McomboBox001.setValue('3');
	 					document.getElementById('tr006').style.display='';
	 					McomboBox001.setDisabled(false);
	 				}
	 			}else{
	 				if(uiType=='4'){
	 					var arrInit = ['3','9'];
	 	 			 	var mapInit = {'3':'整数','9':'小数'};
						McomboBox001_VMInit = arrInit;
	 	 				McomboBox001.displayValueMap = mapInit;
	 	 				McomboBox001.setValueMap(McomboBox001_VMInit);
	 	 				if('${property.type}'!='3'&&'${property.type}'!='9'){
	 	 					var type = 3;
	 	 				}else{
	 	 					var type = ${property.type};
	 	 				}
	 	 				McomboBox001.setValue(type);
		 				Minput003.setValue(length);
	 				}else if(uiType=='1'||uiType=='8'){
	 					McomboBox001_VMText = [];
						var arrText = ['1'];
					 	var mapText = {'1':'字符'};
					 	McomboBox001.setDisabled(true);
					 	McomboBox001_VMTest = arrText;
						McomboBox001.displayValueMap = mapText;
						McomboBox001.setValueMap(McomboBox001_VMText);
						if('${property.type}'!='1'){
	 	 					var type = 1;
	 	 				}else{
	 	 					var type = ${property.type};
	 	 				}
						McomboBox001.setValue(type);
	 				}else{
		 				Minput003.setValue(length);
		 				McomboBox001.setValue(proTypeValue);
	 				}
	 			}
 			
 			Minput003.setCanEdit(true);
 			
 			if(uiType=='7'){
 				//复选按钮  数据类型  是 布尔类型
 				//长度不显示  
 				document.getElementById('tr005').style.display='none';
 				McomboBox001.setValue(6);
 				McomboBox001.setDisabled(true);
 			}
 			
 		}else if(uiType=='31'){
 			//关联文档
 			document.getElementById("tr006").style.display="none";
 			document.getElementById("tr018").style.display="none";
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			if(editType=='add'){
 				Minput003.setValue("255");
 				McomboBox001.setValue("1");
 				document.getElementById('tr006').style.display='none';
 				McomboBox001.setDisabled(true);
 			}else{
 				McomboBox001.setValue("1");
 				McomboBox001.setDisabled(true);
 				Minput003.setValue(length);
 			}
 		}
 		if(uiType == '5' || uiType == '11' || uiType == '22' || uiType == '8' || uiType == '7' || uiType == '9'){
 			document.getElementById('tr0042').style.display='';
 		}else{
 			document.getElementById('tr0042').style.display='none';
 		}
 		//修改时根据 canChangeEditType 改变编辑状态
 		if(editType == 'update'){
 			if(canChangeEditType=='false'){
	 			McomboBox001.setDisabled(true);
	 			//McomboBox002.setDisabled(true);
	 		}else{
	 			//McomboBox001.setDisabled(false);
	 			//var ID = document.getElementById("comboBox002");
	 			//if(ID!=null){
	 			McomboBox002.setDisabled(false);
	 			//}
	 		}
 		}
 		
 		
 	}
 	//检查 UIType
 	function check(){
 		//初始的时候  设置无默认值  根据不同情况，后面的时候设置默认值
 		MinitValue.setValue("");
 		var editType = Matrix.getFormItemValue("editType");
 		
 		var proTypeValue = McomboBox001.getValue();
 		var length = Matrix.getFormItemValue('input003');
 		var defaultValue=MinitValue.getValue();
 		Minput003.setCanEdit(true);//长度
 		var uiType = McomboBox002.getValue();
 		var McomboBox001_VMReset =[];
 		var arrReset = ['1','3','9','6','7','8'];
	 	var mapReset = {'1':'字符','3':'整数','9':'小数','6':'布尔','7':'日期时间','8':'二进制'};
	 	McomboBox001_VMReset = arrReset;
		McomboBox001.displayValueMap = mapReset;
		McomboBox001.setValueMap(McomboBox001_VMReset);
		McomboBox001.setValue('${property.type==""?"1":property.type}');
		document.getElementById('tr006').style.display='';

 		//控制数据字典的显示
 		if(uiType == '5' || uiType == '11' || uiType == '22' || uiType == '8' || uiType == '7' || uiType == '9'){
 			document.getElementById('tr0042').style.display='';
 		}else{
 			document.getElementById('tr0042').style.display='none';
 			MselectItemsStr.setValue('');
 			document.getElementById('selectItems').value = '';
 		}
 		
 		if(uiType=='29'||uiType=='12'|| uiType=='28' || uiType=='27'){
 			//附件和流程意见 不显示 类型 长度  精度  默认值 
 			document.getElementById('tr004').style.display='none';
 			document.getElementById('tr005').style.display='none';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='none';
 			
 			//文本域  属性类型默认是字符型不可修改
 			//if(editType!='add'){
	 		//	McomboBox001.setValue(proTypeValue);
	 		//	Minput003.setValue(length);
 			//}else{
 				McomboBox001.setValue("1");
 				document.getElementById('tr006').style.display='none';
	 			Minput003.setValue("");
 			//}
 			Minput003.setCanEdit(true);
 			McomboBox001.setDisabled(false);
 		}else if(uiType=='23'||uiType=='24'||uiType=='25'||uiType=='26'||uiType=='9'){
 			//初始加载   如果是 选部门  选人员  复选按钮组
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='';
 			
 			if(editType=='add'){
 				Minput003.setValue("255");
 			}else{
 				Minput003.setValue(length);
 			}
 			Minput003.setCanEdit(false);
 			McomboBox001.setValue('1');
 			McomboBox001.setDisabled(true);
 		}else if(uiType=='10'){
 			//文本域  属性类型默认是字符型不可修改
 			McomboBox001.setValue('1');
 			McomboBox001.setDisabled(true);
 			if(editType=='add'){
 				Minput003.setValue("255");
 			}else{
 				Minput003.setValue(length);
 			}
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='';
 		}else if(uiType=='30'){
 			//长度  默认值 不显示
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='none';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='none';
 			McomboBox001.setValue('8');//二进制
 			McomboBox001.setDisabled(true);
 			//if(editType=='add'){
 			//	Minput003.setValue("");
 			//}else{
 			//	Minput003.setValue(length);
 				
 			//}
 			
 		}else if(uiType=='2'){
 			//日期  时间
 			McomboBox001.setValue("7");
 			McomboBox001.setDisabled(true);
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='none';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='';
 			document.getElementById('tr0061').style.display='';
 			document.getElementById('formatPatternDate_div').style.display='';
			document.getElementById('formatPatternNumber_div').style.display='none';
			Matrix.setFormItemValue("formatPatternNumber", '');
 		}else if(uiType=='3'){
 			//日期  时间
 			McomboBox001.setValue("1");
 			McomboBox001.setDisabled(true);
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='none';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='';
 		}else if(uiType=='5'||uiType=='11'||uiType=='22'){
 			//列表框 下拉框 多选下拉框
 			McomboBox001.setValue("1");
 			McomboBox001.setDisabled(true);
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='';
 			
 		}else if(uiType=='1'||uiType=='4'||uiType=='6'||uiType=='7'||uiType=='8'){
 			//其他情况
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			document.getElementById('tr006').style.display='none';
 			document.getElementById('tr018').style.display='';
 			if(editType=='add'){
 				if(uiType!='4'){
 					if(uiType=='1'||uiType=='8'){
 						McomboBox001_VMText = [];
 						var arrText = ['1'];
 					 	var mapText = {'1':'字符'};
 					 	McomboBox001.setDisabled(true);
 					 	McomboBox001_VMTest = arrText;
 						McomboBox001.displayValueMap = mapText;
 						McomboBox001.setValueMap(McomboBox001_VMText);
 						McomboBox001.setValue('1');	
 					}
 					Minput003.setValue("255");
 					McomboBox001.setValue("1");
 					document.getElementById('tr006').style.display='none';
 				}else{
 					var McomboBox001_VMNum =[];
 					var arrNum = ['3','9'];
 	 			 	var mapNum = {'3':'整数','9':'小数'};
 	 			 	McomboBox001_VMNum = arrNum;
 	 				McomboBox001.displayValueMap = mapNum;
 	 				McomboBox001.setValueMap(McomboBox001_VMNum);
 	 				McomboBox001.setValue('3');
 	 				//设置默认长度
	 				Minput003.setValue('12');
 					document.getElementById('tr006').style.display='';
 					McomboBox001.setDisabled(false);
 				}
 			}else{
 				if(uiType=='4'){
	 				var arrNum = ['3','9'];
	 			 	var mapNum = {'3':'整数','9':'小数'};
	 			 	McomboBox001.setDisabled(false);
	 			 	McomboBox001_VM = arrNum;
	 				McomboBox001.displayValueMap = mapNum;
	 				McomboBox001.setValueMap(McomboBox001_VM);
	 				//设置默认长度
	 				Minput003.setValue('12');
	 				if('${property.type}'!='3'&&'${property.type}'!='9'){
 	 					var type = 3;
 	 				}else{
 	 					var type = ${property.type};
 	 				}
	 				McomboBox001.setValue(type);
	 				Minput003.setValue(length);
 				}else if(uiType =='1'||uiType =='8'){
					McomboBox001_VMText = [];
					var arrText = ['1'];
				 	var mapText = {'1':'字符'};
				 	McomboBox001.setDisabled(true);
				 	McomboBox001_VMTest = arrText;
					McomboBox001.displayValueMap = mapText;
					McomboBox001.setValueMap(McomboBox001_VMText);
					if('${property.type}'!='1'){
 	 					var type = 1;
 	 				}else{
 	 					var type = ${property.type};
 	 				}
					McomboBox001.setValue(type);	
 				}else{
	 				Minput003.setValue(length);
	 				McomboBox001.setValue(proTypeValue);
 				}
 			}
 			
 			if(uiType!='4'){
 				McomboBox001.setValue("1");
 				document.getElementById('tr006').style.display='none';
 			}
 			Minput003.setCanEdit(true);
 			
 			if(uiType=='7'){
 				//复选按钮  数据类型  是 布尔类型
 				//长度不显示  
 				document.getElementById('tr005').style.display='none';
 				McomboBox001.setValue(6);
 				McomboBox001.setDisabled(true);
 			}
 			//McomboBox002.setDisabled(false);
 		}else if(uiType=='31'){
 			//关联文档
 			document.getElementById("tr006").style.display="none";
 			document.getElementById("tr018").style.display="none";
 			document.getElementById('tr004').style.display='';
 			document.getElementById('tr005').style.display='';
 			if(editType=='add'){
 				Minput003.setValue("255");
 				McomboBox001.setValue("1");
 				McomboBox001.setDisabled(true);
 				document.getElementById('tr006').style.display='none';
 			}else{
 				Minput003.setValue(length);
 				McomboBox001.setValue("1");
 				McomboBox001.setDisabled(true);
 			}
 		}
 		var value = Matrix.getFormItemValue('comboBox001');
 		if(value == '9'){
 			document.getElementById("tr006").style.display="";
 		}else{
 			document.getElementById("tr006").style.display="none";
 		}
 		if(uiType != '2'){
 			document.getElementById('tr0061').style.display='none';
 			document.getElementById('formatPatternDate_div').style.display='none';
			document.getElementById('formatPatternNumber_div').style.display='none';
			Matrix.setFormItemValue("formatPatternNumber", '');
			Matrix.setFormItemValue("formatPatternDate",'');
			document.getElementById('displayFormatInput').value='';
 		}
 		
 	}
 	
 	function setDisplayFormatValueFromDate(){
 		var value = Matrix.getFormItemValue('formatPatternDate');
 		document.getElementById('displayFormatInput').value=value;
 	}
 	function setDisplayFormatValueFromNum(){
 		var value = Matrix.getFormItemValue('formatPatternNumber');
 		document.getElementById('displayFormatInput').value=value;
 	}
 	
 	
 	//保存并继续
 	function saveAndContinue(){
 		var mid = Minput001.getValue();
		var name =Minput002.getValue();
		var type = McomboBox001.getValue();
		var length =Minput003.getValue();
		var precision = Minput004.getValue();
		var selectItems = Matrix.getFormItemValue('selectItems');
		var uiType =  McomboBox002.getValue();
		var displayFormat = Matrix.getFormItemValue("displayFormatInput");
		var editType = Matrix.getFormItemValue("editType");
		var parentNodeId = Matrix.getFormItemValue("parentNodeId");
		var json = "{'name':'"+name+"','mid':'"+mid+"','formVarId':'"+parentNodeId+"','editType':'"+editType+"'}";
		var newJsonData = isc.JSON.decode(json);
		var src = webContextPath+"/datasource/formVarPro_hasContainsThisPropertyInCurForm.action"
		Matrix.sendRequest(src,newJsonData,function(data){
			if(data!=null && data.data!=''){
				var result = isc.JSON.decode(data.data);
				if(!result.result){
					var editType = Matrix.getFormItemValue("editType");
					//var entity = Matrix.getFormItemValue("entity");
					var isRequired = Matrix.getFormItemValue("isRequired");
					var defaultValue = MinitValue.getValue();
					var objMid = Matrix.getFormItemValue("objMid");
					var tree = parent.MTree0_DS.$27m;
					var index = getNextIndex(tree);
					var data1 = "{'data':'{data:{\"mid\":\""+mid+"\",\"name\":\""+name+"\",\"type\":\""+type+"\",\"length\":\""+length+"\",\"precision\":\""+precision+"\",\"displayFormat\":\""+displayFormat+"\",\"options\":\""+selectItems+"\",\"uiType\":\""+uiType+"\",\"parentNodeId\":\""+parentNodeId+"\",\"editType\":\""+editType+"\",\"index\":\""+index+"\",\"isRequired\":\""+isRequired+"\",\"defaultValue\":\""+defaultValue+"\"";
					data1+="}}'}";
					var synJson = isc.JSON.decode(data1);
					var url ="<%=request.getContextPath()%>/datasource/formVarPro_saveOrUpdatePropertyInfo.action"; 
					Matrix.sendRequest(url,synJson,function(data){
						if(data!=null &&data.data!=''){
							var json = isc.JSON.decode(data.data);
							if(json.result){
								//1、刷新父页面树节点
						       	var parentNodeId = Matrix.getFormItemValue('parentNodeId');
						       	parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
						       	var formVarType = "${mainFormVarType}";
						       	if(formVarType=='DataObject' ){
						       		parent.redrawComponent(mid);
						       	}else if(formVarType=='List'){
							       	parent.redrawEditList(parentNodeId);//刷新父表单
							       	parent.isc.MH.reloadComponent();
						       	}else if(formVarType=='RList'){
							       	parent.isc.MH.reloadComponent();
						       	}
						       	Matrix.hideMask();
						       	Mbutton003.enable();
						       	Mbutton001.enable();
						       	//2、继续
						       window.location.reload();
							}
						}
					});
				}else{
			       	Mbutton003.enable();
					Mbutton001.enable();
					Matrix.warn("名称不能重复!");
				}
			}
		});			
 		
 	}	
</script>
	</head>
	<body onload="initForm()">
		<div id='loading' name='loading' class='loading'>
			<script>
	Matrix.showLoading();
</script>
		</div>

		<script>
	var Mform0 = isc.MatrixForm.create( {
		ID : "Mform0",
		name : "Mform0",
		position : "absolute",
		action : "<%=request.getContextPath()%>/datasource/formVarPro_saveOrUpdatePropertyInfo.action",
		canSelectText : true,
		fields : [ {
			name : 'form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'form0_hidden_text_div'
		} ]
	});
</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>/datasource/formVarPro_saveOrUpdatePropertyInfo.action"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="20193894-6c3c-4f6b-a0ff-895c3478bf83" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
					<input type="hidden" name="canChangeEditType" id="canChangeEditType" value="${param.canChangeEditType }"/>
				<input type="hidden" name="entity" id="entity" value="${param.entity }"/>	
				<input type="hidden" name="uuid" id="uuid" value="${property.uuid }"/>	
				<input type="hidden" name="selectItems" id="selectItems" value="${property.options }"/>	
				<input type="hidden" name="parentNodeId" id="parentNodeId" value="${param.parentNodeId }"/>
				<input type="hidden" name="editType" id="editType" value="${param.editType }"/>
				<input type="hidden" name="phase" id="phase" value="${phase }"/>	
				<input type="hidden" name="mainFormVarType" id="mainFormVarType" value="${mainFormVarType }"/>
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<table id="table001" class="maintain_form_content"
					style="width: 100%;">
					<tr id="tr001" style="display:none;">
						<td id="td001" class="maintain_form_label" style="width: 30%;">
							<label id="label001" name="label001" id="label001">
								属性
							</label>
						</td>
						<td id="td002" class="maintain_form_input" style="width: 70%;">
							<div id="input001_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var input001 = isc.TextItem.create( {
		ID : "Minput001",
		name : "input001",
		editorType : "TextItem",
		displayId : "input001_div",
		position : "relative",
		autoDraw : false,
		value:"${property.mid}",
		width : 300,
		length : 100,
		validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		    	//return true;
		      		        return  formVarIdValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"编码不能为空!"
		      		 }]
		
	});
	Mform0.addField(input001);
</script>
	<span id="MultiLabel0" style="width: 25px; height: 20px; color: #FF0000">*</span></td>
					</tr>
					
<tr id="tr021">
						<td id="td021" class="maintain_form_label" style="width: 30%;">
							<label id="label021" name="label021" id="label021">
								编码
							</label>
						</td>
						<td id="td022" class="maintain_form_input" style="width: 70%;">
						${property.mid}	</td>
					</tr>
										
					<tr id="tr002">
						<td id="td003" class="maintain_form_label" style="width: 30%;">
							<label id="label002" name="label002" id="label002">
								名称
							</label>
						</td>
						<td id="td004" class="maintain_form_input" style="width: 70%;">
							<div id="input002_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var input002 = isc.TextItem.create( {
		ID : "Minput002",
		name : "input002",
		editorType : "TextItem",
		displayId : "input002_div",
		position : "relative",
		autoDraw : false,
		value:"${property.name}",
		width : 300,
		length : 100,
		validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		    	//return true;
		      		       return  formVarNameValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"名称不能为空!"
		      		 }]
	});
	Mform0.addField(input002);
</script>
	<span id="MultiLabel1" style="width: 25px; height: 20px; color: #FF0000">*</span>					</td>
					</tr>

					<tr id="tr007">
						<td id="td012" class="maintain_form_label" colspan="1"
							style="width: 30%;">
							<label id="label006" name="label006" id="label006">
								编辑类型
							</label>
						</td>
						<td id="td013" class="maintain_form_input" colspan="1" style="width: 70%;">
							<div id="comboBox002_div" eventProxy="Mform0"
								class="matrixInline" style=""></div>
							<script>
	var valueMap =  {'1':'文本框','2':'日期框','3':'时间框','4':'数字框','5':'下拉框','22':'多选下拉框','21':'弹出选择','8':'单选框组','7':'复选框','9':'复选框组','10':'文本域','30':'大文本域','11':'列表框','23':'单选用户','24':'多选用户','25':'单选部门','26':'多选部门','27':'单文件上传','28':'多文件上传','29':'流程意见','31':'关联文档'};
	var valueArr = ['1','2','3','4','5','22','21','8','7','9','10','30','11','23','24','25','26','27','28','29','31'];
	var t = Matrix.getFormItemValue("mainFormVarType");
	if(t == 'List' || t == 'RList' ){
		valueArr = ['1','2','3','4','5','22','21','8','7','9','10','30','11','23','24','25','26','27','28','31'];
		valueMap =  {'1':'文本框','2':'日期框','3':'时间框','4':'数字框','5':'下拉框','22':'多选下拉框','21':'弹出选择','8':'单选框组','7':'复选框','9':'复选框组','10':'文本域','30':'大文本域','11':'列表框','23':'单选用户','24':'多选用户','25':'单选部门','26':'多选部门','27':'单文件上传','28':'多文件上传','31':'关联文档'};
	}
	var McomboBox002_VM = [];
	var comboBox002 = isc.SelectItem.create( {
		ID : "McomboBox002",
		name : "comboBox002",
		editorType : "SelectItem",
		displayId : "comboBox002_div",
		autoDraw : false,
		valueMap : [],
		width:300,
		changed:'check()',
		position : "relative"
	});
	Mform0.addField(comboBox002);
	McomboBox002_VM = valueArr;
	McomboBox002.displayValueMap = valueMap;
	McomboBox002.setValueMap(McomboBox002_VM);
	McomboBox002.setValue('${property.uiType}');
</script>
						</td>
					</tr>

					<tr id="tr004">
						<td id="td006" class="maintain_form_label" colspan="1"
							style="width: 30%;">
							<label id="label003" name="label003" id="label003">
								字段类型
							</label>
						</td>
						<td id="td007" class="maintain_form_input" colspan="1" style="width: 70%;">
							<div id="comboBox001_div" eventProxy="Mform0"
								class="matrixInline" style=""></div>
							<script>
	var mainFormVarType = Matrix.getFormItemValue("mainFormVarType");
/*	var map = {'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值'};
	var arr = ['1','2','3','4','5','6','7','8','9'];
	if(mainFormVarType == 'List'){
		arr = ['1','2','3','4','5','6','7','9'];
	 	map = {'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','9':'数值'};
	}
*/
	var map = {'1':'字符','3':'整数','9':'小数','6':'布尔','7':'日期时间','8':'二进制'};
	var arr = ['1','3','9','6','7','8'];
	if(mainFormVarType == 'List' || mainFormVarType == 'RList'){
		arr = ['1','3','9','6','7','8'];
	 	map = {'1':'字符','3':'整数','9':'小数','6':'布尔','7':'日期时间','8':'二进制'};
	}
	
	var McomboBox001_VM = [];
	var comboBox001 = isc.SelectItem.create( {
		ID : "McomboBox001",
		name : "comboBox001",
		editorType : "SelectItem",
		displayId : "comboBox001_div",
		autoDraw : false,
		valueMap : [],
		width:300,
		changed : 'setStyle()',
		position : "relative"
	});
	Mform0.addField(comboBox001);
	McomboBox001_VM = arr;
	McomboBox001.displayValueMap = map;
	McomboBox001.setValueMap(McomboBox001_VM);
	McomboBox001.setValue('${property.type==""?"1":property.type}');
</script>
						</td>
						
					</tr>
					<tr id="tr005">
						<td id="td008" class="maintain_form_label" colspan="1"
							style="width: 30%;">
							<label id="label004" name="label004" id="label004">
								长度
							</label>
						</td>
						<td id="td009" class="maintain_form_input" colspan="1" style="width: 70%;">
							<div id="input003_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var input003 = isc.TextItem.create( {
		ID : "Minput003",
		name : "input003",
		editorType : "TextItem",
		displayId : "input003_div",
		position : "relative",
		value:'${property.length}',
		autoDraw : false,
		width : 300,
		
		validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		       return  lengthValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"长度不能为空!"
		      		 }]
	});
	Mform0.addField(input003);
</script>
						</td>
					</tr>
					
					<tr id="tr0061">
						<td id="td0101" class="maintain_form_label" colspan="1"
							style="width: 30%;">
							<label id="label0051" name="label0051" id="label0051">
								显示格式
							</label>
						</td>
						<td id="td0111" class="maintain_form_input" colspan="1" style="width: 70%;">
						<input id="displayFormatInput" type="hidden" value="${property.displayFormat}">
							<div id="formatPatternDate_div" eventProxy="Mform0" class="matrixInline" style=""></div>
<script>
	var MformatPatternDate_VM = [];
	var formatPatternDate = isc.ComboBoxItem.create({
		ID: "MformatPatternDate",
		name: "formatPatternDate",
		editorType: "ComboBoxItem",
		displayId: "formatPatternDate_div",
		autoDraw: false,
		valueMap: [],
		changed : 'setDisplayFormatValueFromDate()',
		value : '${property.displayFormat}',
		position: "relative",
		width: 300,
		validators: [{
			type: "custom",
			condition: function (item, validator, value, record) {
				return Matrix.validateRegexp(Matrix.OtherProRegExp, value);
			}, errorMessage: "不能包含怪字符"
		}],
		attrName: 'formatPattern'
	});
	Mform0.addField(formatPatternDate);
	MformatPatternDate_VM = ['', 'yyyy-MM-dd', 'yyyy年MM月dd日', 'yyyy-MM-dd hh:mm', 'yyyy年MM月dd日 hh:mm'];
	MformatPatternDate.displayValueMap = {
		'': '',
		'yyyy-MM-dd': 'yyyy-MM-dd',
		'yyyy年MM月dd日': 'yyyy年MM月dd日',
		'yyyy-MM-dd hh:mm': 'yyyy-MM-dd hh:mm',
		'yyyy年MM月dd日 hh:mm': 'yyyy年MM月dd日 hh:mm'
	};
	MformatPatternDate.setValueMap(MformatPatternDate_VM);
	MformatPatternDate.setValue('${property.displayFormat }');
</script>
<div id="formatPatternNumber_div" eventProxy="Mform0" class="matrixInline" style=""></div>
<script>
	var MformatPatternNumber_VM = [];
	var formatPatternNumber = isc.ComboBoxItem.create({
		ID: "MformatPatternNumber",
		name: "formatPatternNumber",
		editorType: "ComboBoxItem",
		displayId: "formatPatternNumber_div",
		autoDraw: false,
		valueMap: [],
		changed: 'setDisplayFormatValueFromNum()',
		value : '${property.displayFormat}',
		position: "relative",
		width: 300,
		validators: [{
			type: "custom",
			condition: function (item, validator, value, record) {
				return Matrix.validateRegexp(Matrix.OtherProRegExp, value);
			}, errorMessage: "不能包含怪字符"
		}],
		attrName: 'formatPattern'
	});
	Mform0.addField(formatPatternNumber);
	MformatPatternNumber_VM = ['', '#.##%', '#,###.##', 'DHM',  'DAY'];
	MformatPatternNumber.displayValueMap = {
		'': '',
		'#.##%': '百分号',
		'#,###.##': '千分位',
		'DHM': '天*时*分',
		'DAY': '天',
	};
	MformatPatternNumber.setValueMap(MformatPatternNumber_VM);
	MformatPatternNumber.setValue('${property.displayFormat }');
</script>
						</td>
					</tr>
					
					<tr id="tr0042">
						<td id="td0062" class="maintain_form_label" colspan="1"
							style="width: 30%;">
							<label id="label0032" name="label0032" id="label0032">
								数据字典
							</label>
						</td>
						<td id="td0072" class="maintain_form_input" colspan="1" style="width: 70%;">
							<table id='selectItems_table' ,width:315 style='width:315px;height:22px;table-layout:fixed;border-collapse:collapse;border-spacing:0;padding:0;margin:0;'>
								<tr>
									<td style='padding:0;'>
										<div id="selectItems_div" style='width:100%;height:100%' eventProxy="Mform0"></div>
									</td>
									<td style='width:20px;height:100%;text-align:center;padding:0;'>
										<div id='selectItems_button_div' style='position:relative;width:100%;height:100%;vertical-align:middle;' class='matrixInline'>
											<img id='selectItems_button' src='<%=request.getContextPath() %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query_advance.png' onclick='onselectItemsClick();' />
										</div>
									</td>
								</tr>
							</table>
							<script>
								function onselectItemsClick() {
									layer.open({
										type:2,
										title:['设置下拉选项'],
										area:['85%','100%'],
										content:'<%=request.getContextPath()%>/form/admin/custom/queryList/h5Options.jsp?command=edit&mode=propertyedit&parentType=DataCell&iframewindowid=selectItemsDialog'
									});						
									/* Matrix.showMask();
						
									var x = eval("Matrix.showWindow('selectItemsDialog');");
									if (x != null && x == false) {
										Matrix.hideMask();
										return false;
									}
									Matrix.hideMask(); */
									
								};
							</script>
							<script>
								var selectItemsStr = isc.TextItem.create({
									ID: "MselectItemsStr",
									name: "selectItemsStr",
									editorType: "TextItem",
									displayId: "selectItems_div",
									width: "100%",
									position: "relative",
									value:'${property.optionsStr}',
									autoDraw: false,
									validators: [{
										type: "custom",
										condition: function (item, validator, value, record) {
											return Matrix.validateRegexp(Matrix.OtherProRegExp, value);
										}, errorMessage: "不能包含怪字符"
									}],
									canEdit: false
								});
								Mform0.addField(selectItemsStr);
							</script>
							<script>
								function getParamsForselectItemsDialog() {
									var params = '&';
									var value;
									value = null;
									try {
										value = eval("edit");
									} catch (error) {
										value = "edit"
									}
									if (value != null) {
										value = "command=" + value;
										params += value;
									}
									value = null;
									params += '&';
									try {
										value = eval("propertyedit");
									} catch (error) {
										value = "propertyedit"
									}
									if (value != null) {
										value = "mode=" + value;
										params += value;
									}
									value = null;
									params += '&';
									try {
										value = eval("DataCell");
									} catch (error) {
										value = "DataCell"
									}
									if (value != null) {
										value = "parentType=" + value;
										params += value;
									}
									return params;
								}
								isc.Window.create({
									ID: "MselectItemsDialog",
									id: "selectItemsDialog",
									name: "selectItemsDialog",
									position: "absolute",
									height: "90%",
									width: "550px",
									title: "设置下拉选项",
									autoCenter: true,
									animateMinimize: false,
									canDragReposition: false,
								//	targetDialog: "MainDialog",
									showHeaderIcon: false,
									showTitle: true,
									showMinimizeButton: false,
									showMaximizeButton: false,
									showCloseButton: true,
									showModalMask: false,
									isModal: true,
									autoDraw: false,
									getParamsFun: getParamsForselectItemsDialog,
									initSrc: "<%=request.getContextPath() %>/form/admin/custom/queryList/h5Options.jsp",
									src: "<%=request.getContextPath() %>/form/admin/custom/queryList/h5Options.jsp"
								});
						
								function onselectItemsDialogClose(data) {
						
									if (data == null) return true;
									if (isc.isA.String(data)) data = isc.JSON.decode(data);
									if (data['info'] != null) {
										var field = Mform0.getField('selectItemsStr');
										if (field != null) {
											Matrix.setFormItemValue('selectItems', data['info']);
											Mform0.setValue('selectItemsStr', data['infoStr']);
											if (field.editorExit != null && isc.isA.Function(field.editorExit)) field.editorExit(Mform0, field);
										} else {
											field = document.getElementById('selectItems');
											if (field != null) {
												field.value = data['info']
											}
										}
									}
						
								}
							</script>
						</td>
						
					</tr>
					
					
					<tr id="tr006">
						<td id="td010" class="maintain_form_label" colspan="1"
							style="width: 30%;">
							<label id="label005" name="label005" id="label005">
								精度
							</label>
						</td>
						<td id="td011" class="maintain_form_input" colspan="1" style="width: 70%;">
							<div id="input004_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var input004 = isc.TextItem.create( {
		ID : "Minput004",
		name : "input004",
		editorType : "TextItem",
		displayId : "input004_div",
		value:'${property.precision}',
		position : "relative",
		autoDraw : false,
		width : 300,
		validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		       return  precisionValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"精度不能为空!"
		      		 }]
	});
	Mform0.addField(input004);
</script>
						</td>
					</tr>
					<tr id="tr018" >
					<td id="td014" class="maintain_form_label" colspan="1" style="width:30%">
						<label id="label011" name="label011">
							默认值:
						</label>
					</td>
					<td id="td015" class="maintain_form_input" style="width:70%">
		<div id="initValue_div" eventProxy="Mform0" class="matrixInline"
					style=""></div>
				
				 
			<script> 
						var MinitValue_VM=[]; 
						var initValue=isc.ComboBoxItem.create({
								ID:"MinitValue",
								name:"defaultValue",
								editorType:"ComboBoxItem",
								displayId:"initValue_div",
								autoDraw:false,
								valueMap:[],
								position:"relative",
								width:300,
								validators:[{
									type:"custom",
									condition:function(item, validator, value, record){
										return Matrix.validateRegexp(Matrix.OtherProRegExp,value);
									},
									errorMessage:"不能包含怪字符"}],
								attrName:'initValue',
								editorExit:'Matrix.resetComponentProperty(item);'});
								Mform0.addField(initValue);
								MinitValue_VM=['_0','_1','_2','_3','_12','_13','_10','_11','_4','_5','_9','_6','_7','_8'];
								MinitValue.displayValueMap={'_0':'当前用户编码','_1':'当前用户名称','_2':'当前用户部门编码','_3':'当前用户部门名称','_12':'当前用户上级部门编码','_13':'当前用户上级部门名称','_10':'当前用户一级部门编码','_11':'当前用户一级部门名称','_4':'当前用户机构编码','_5':'当前用户机构名称','_9':'流水号','_6':'当前日期','_7':'当前时间','_8':'当前日期时间'};
								MinitValue.setValueMap(MinitValue_VM);
								MinitValue.setValue("${defaultValue}");
			</script>
				 
				 </td>
	</tr>
	
	<tr id="tr019" >
	<td id="td016"  class="maintain_form_label" colspan="1" style="display:none;width:30%">
						<label id="label012" name="label012">
							必填:
						</label>
					</td>
					<td id="td017"  class="maintain_form_input" style="display:none;width:70%">
		<div id="isRequired_div" eventProxy="Mform0"></div>
												<script> var isRequired=isc.CheckboxItem.create({
															ID:"MisRequired",
															name:"isRequired",
															editorType:"CheckboxItem",
															displayId:"isRequired_div",
															valueMap:{"":false,"1":true},
															title:"",
															position:"relative",
															//groupId:"checkBoxGroup001",
															autoDraw:false
														});
														Mform0.addField(isRequired);
														Mform0.setValue("isRequired","${property.isRequired=='false'?'':'1'}");
												</script>
				
				 </td>
	</tr>
					<tr id="tr003">
						<td id="td005" class="cmdLayout" style="z-index:0" colspan="2">
							<div id="button001_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>
	isc.Button.create( {
		ID : "Mbutton001",
		name : "button001",
		title : "保存",
		displayId : "button001_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		//icon : "[skin]/images/matrix/actions/save.png",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton001.click = function() {
		Mbutton001.disable();
		
		Matrix.showMask();
		if(!Mform0.validate()){//表单验证
			Matrix.hideMask();
			Mbutton001.setDisabled(false);
			return false;
		}else{
			Matrix.showMask();
			var mid = Minput001.getValue();
			var name =Minput002.getValue();
			var type = McomboBox001.getValue();
			var length =Minput003.getValue();
			var selectItems = Matrix.getFormItemValue("selectItems");
			var precision = Minput004.getValue();
			var uiType =  McomboBox002.getValue();
			var editType = Matrix.getFormItemValue("editType");
			var parentNodeId = Matrix.getFormItemValue("parentNodeId");
			var json = "{'name':'"+name+"','mid':'"+mid+"','formVarId':'"+parentNodeId+"','editType':'"+editType+"'}";
			var newJsonData = isc.JSON.decode(json);
			var src = webContextPath+"/datasource/formVarPro_hasContainsThisPropertyInCurForm.action"
			Matrix.sendRequest(src,newJsonData,function(data){
				if(data!=null && data.data!=''){
					var result = isc.JSON.decode(data.data);
					if(!result.result){
						var editType = Matrix.getFormItemValue("editType");
						var displayFormat = Matrix.getFormItemValue("displayFormatInput");
						//var entity = Matrix.getFormItemValue("entity");
						var isRequired = Matrix.getFormItemValue("isRequired");
						var defaultValue = MinitValue.getValue();
						var objMid = Matrix.getFormItemValue("objMid");
						var tree = parent.MTree0_DS.$27m;
						var index = getNextIndex(tree);
						var data1 = "{'data':'{data:{\"mid\":\""+mid+"\",\"name\":\""+name+"\",\"type\":\""+type+"\",\"length\":\""+length+"\",\"precision\":\""+precision+"\",\"displayFormat\":\""+displayFormat+"\",\"options\":\""+selectItems+"\",\"uiType\":\""+uiType+"\",\"parentNodeId\":\""+parentNodeId+"\",\"editType\":\""+editType+"\",\"index\":\""+index+"\",\"isRequired\":\""+isRequired+"\",\"defaultValue\":\""+defaultValue+"\"";
						data1+="}}'}";
						var synJson = isc.JSON.decode(data1);
						var validataUrl = "<%=request.getContextPath()%>/datasource/formVarPro_validataUpdate.action"; 
						Matrix.sendRequest(validataUrl,synJson,function(data){
							if(data.data!="error"){
								var url ="<%=request.getContextPath()%>/datasource/formVarPro_saveOrUpdatePropertyInfo.action"; 
								Matrix.sendRequest(url,synJson,function(data){
									if(data!=null &&data.data!=''){
										var json = isc.JSON.decode(data.data);
										if(json.result){
											//1、刷新父页面树节点
						       				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
						       				parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
						       				var formVarType = "${mainFormVarType}";
						       				if(formVarType=='DataObject' ){
						       					parent.redrawComponent(mid);
						       				}else if(formVarType=='List'){
							       				parent.redrawEditList(parentNodeId);//刷新父表单
							       				parent.isc.MH.reloadComponent();
						       				}else if(formVarType=='RList'){
							       				parent.isc.MH.reloadComponent();
						       				}
						       				Matrix.hideMask();
						       				Mbutton001.enable();
						       				//2、关闭窗口
						       				Matrix.closeWindow();
						       				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
						       				parent.layer.close(index);
										}
									}
								});
							}else{
								Mbutton001.enable();
								Matrix.warn("表里有数据不能修改字段类型！");
							}
						});
					}else{
						Mbutton001.enable();
						Matrix.warn("名称不能重复!");
					}
				}
			});
		}
	};
</script>
							</div>
							
							
	<div id="button003_div" class="matrixInline"
			style="position: relative;; width: 150px;; height: 22px;">
		<script>
			isc.Button.create( {
				ID : "Mbutton003",
				name : "button003",
				title : "保存并继续",
				displayId : "button003_div",
				position : "absolute",
				top : 0,
				left : 0,
				width : "100%",
				height : "100%",
				//icon : "[skin]/images/matrix/actions/save.png",
				showDisabledIcon : false,
				showDownIcon : false,
				showRollOverIcon : false
			});
			Mbutton003.click = function() {
				Mbutton003.disable();
				Matrix.showMask();
				
				if(!Mform0.validate()){//表单验证
					Matrix.hideMask();
					Mbutton003.setDisabled(false);
					return false;
				}else{
					Matrix.showMask();
					saveAndContinue();
					
				}
			};
		</script>
	</div>
							
	<div id="button002_div" class="matrixInline"
			style="position: relative;; width: 100px;; height: 22px;">
		<script>
			isc.Button.create( {
				ID : "Mbutton002",
				name : "button002",
				title : "取消",
				displayId : "button002_div",
				position : "absolute",
				top : 0,
				left : 0,
				width : "100%",
				height : "100%",
				//icon : "[skin]/images/matrix/actions/exit.png",
				showDisabledIcon : false,
				showDownIcon : false,
				showRollOverIcon : false
			});
			Mbutton002.click = function() {
				Mbutton002.disable();
				Matrix.showMask();
				Matrix.closeWindow();
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
				Matrix.hideMask();
			};
		</script>
	</div>
						</td>
					</tr>
				</table>

			</form>
		</div>
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>
