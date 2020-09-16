  
function Matrix(){}

Matrix.cnLength = 2;//中文字符长度
Matrix.COMPONENT_PREFIX="M";// Matrix生成SmartClient组件ID前缀
Matrix.AJAX_REQUEST_KEY="X-Requested-With";// 异步请求常量key
Matrix.AJAX_REQUEST_VALUE="XMLHttpRequest";// 异步请求常量value
Matrix.GRID_EVENT_TYPE_SUFFIX="_GridEventType";
Matrix.GRID_EVENT_TYPE_SORT="SORT";
Matrix.GRID_EVENT_TYPE_UPDATE="UPDATE";
Matrix.GRID_EVENT_TYPE_SELECT="SELECT";
Matrix.GRID_EVENT_TYPE_DELETE="DELETE";
Matrix.GRID_EVENT_SORT_ATTR="_GridEventSortAttr";
Matrix.GRID_EVENT_SORT_TYPE_DESC="DESC";
Matrix.GRID_EVENT_SORT_TYPE_ASC="ASC";
Matrix.GRID_EVENT_SELECT_OBJECT="_GridEventSelectObject";
Matrix.GRID_EVENT_UPDATE_OBJECT="_GridEventUpdateObject";
Matrix.GRID_EVENT_DELETE_OBJECT="_GridEventDeleteObject";
Matrix.GRID_FILTER_FIELD_SUFFIX="_mfilter";
Matrix.GRID_FILTER_SORT_ATTR="_msort_attr";
Matrix.VALUE_NULL="M_NULL";
Matrix.REFRESH_FORM_ID="MATRIX_REFRESH_FORM_ID";
Matrix.REFRESH_COMPONENT_IDS="REFRESH_COMPONENT_IDS";
Matrix.OP_GRID_ID="OP_GRID_ID";
Matrix.UN_REFRESH_COMPONENT_IDS="UN_REFRESH_COMPONENT_IDS";
Matrix.ACTION_SOURCE_ID_KEY = "matrix_current_action_source_id";
Matrix.PAGE_ID_KEY="matrix_current_page_id";
Matrix.PAGE_DEF_ID_KEY="matrix_current_page_def_id";
Matrix.PAGE_FLOW_ID_KEY="matrix_current_page_flow_id";
Matrix.CUSTOM_AJAX_FLAG_KEY="matrix_custom_ajax_flag";
Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX="_dynamic_perpage_count";


//add trim function to String
String.prototype.trim = function() { 
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
}

// 获得字符串字节数
String.prototype.getBytes = function(){
	var cArr = this.match(/[^\x00-\xff]/ig);
	if(Matrix.cnLength!=null && Matrix.cnLength>0){
		return this.length + (cArr == null ? 0 : (cArr.length*(Matrix.cnLength-1)));
	}else{
		return this.length + (cArr == null ? 0 : cArr.length);
	}
}
String.prototype.endWith=function(s){
  if(s==null||s==""||this.length==0||s.length>this.length)
     return false;
  if(this.substring(this.length-s.length)==s)
     return true;
  else
     return false;
  return true;
 }

String.prototype.startWith=function(s){
  if(s==null||s==""||this.length==0||s.length>this.length)
   return false;
  if(this.substr(0,s.length)==s)
     return true;
  else
     return false;
  return true;
}


//清除指定组件刷新标识
Matrix.clearRefreshComponent=function(){
	if(document.getElementById(Matrix.REFRESH_COMPONENT_IDS))document.getElementById(Matrix.REFRESH_COMPONENT_IDS).value = "";	
	if(document.getElementById(Matrix.UN_REFRESH_COMPONENT_IDS))document.getElementById(Matrix.UN_REFRESH_COMPONENT_IDS).value = "";	
}

// 显示loading
Matrix.showLoading=function(){
	/*
	var loadingItems = document.getElementsByName("loading");
	if(loadingItems!=null && loadingItems.length>0){
		for(var i=0;i<loadingItems.length;i++){
			var loadDiv=loadingItems[i]; 
			if(loadDiv){
			  	loadDiv.style.display="";
			} 
		}
	}
	*/
	Matrix.showThrobber();
}

// 隐藏loading
Matrix.hideLoading = function(){
	/*
	var loadingItems = document.getElementsByName("loading");
	if(loadingItems!=null && loadingItems.length>0){
		for(var i=0;i<loadingItems.length;i++){
			var loadDiv=loadingItems[i]; 
			if(loadDiv){
			  	loadDiv.style.display="none";
			} 
		}
	}
	//var loadDiv=document.getElementById("loading"); 
	//if(loadDiv){
	//  	loadDiv.style.display="none";
	//} 
	*/
	Matrix.hideThrobber();
}
isc.Page.setEvent("load","Matrix.hideLoading()",isc.Page.FIRE_ONCE);

Matrix.escapeId = function(id){
	//return id.replace(":","_");
	return id;
};

// 转换null值
Matrix.convertNullValue=function(value){
	if(value!=null && value==Matrix.VALUE_NULL){
		return "";
	}
	return value;
}

// 获得SmartClient组件ID
Matrix.getMatrixComponentId = function(id){
	return Matrix.COMPONENT_PREFIX+id;
}

// 通过编码获得SmartClient组件对象
Matrix.getMatrixComponentById = function(id){
	if(id){
		try{
			var com = eval(Matrix.getMatrixComponentId(id));
			return com;
		}catch(error){}
	}
	return null;
}

// 通过编码获得HTML组件对象
Matrix.getElementByName = function(id){
	if(id){
		if(document.getElementsByName(id) || document.getElementsByName(id).length>0){
			return document.getElementsByName(id)[0];
		}
	}
	return null;
}

// 显示按钮提交遮罩
Matrix.showMask=function(){
	var docVar;
	if(window.top){
		docVar = window.top.document;
	}
	if(!docVar){
		docVar = window.document;
	}
	var maskDiv = docVar.getElementById("matrixMask");
	if(!maskDiv){
		maskDiv = docVar.createElement("div");
		maskDiv.id="matrixMask";
		maskDiv.className="matrixMask";
		docVar.body.appendChild(maskDiv);
		maskDiv.style.display="";
	}else{
		maskDiv.style.display="";
	}
}
// 隐藏按钮提交遮罩
Matrix.hideMask=function(){
	var docVar;
	if(window.top){
		docVar = window.top.document;
	}
	if(!docVar){
		docVar = window.document;
	}
	var maskDiv = docVar.getElementById("matrixMask");
	if(maskDiv){
		maskDiv.style.display = "none";
	}
}

// 添加子元素
Matrix.appendChild = function(parentId,childId){
	if(parentId && childId){
		if(document.getElementById(parentId)
			&& document.getElementById(childId)){
			document.getElementById(parentId).appendChild(document.getElementById(childId));	
		}
	}
}

/***** Ajax callback start *****/
// 异步回调执行返回语句
Matrix.run = function(str){
	var expression = str;
	if(expression.indexOf("====[")<0) return;
	expression = expression.replace("====[","");
	expression = expression.replace("]====","");
	if(expression.indexOf("\n")!=-1 || expression.indexOf("\r")!=-1){
	    expression = expression.replace(/\r/ig,"\\r");
	    expression = expression.replace(/\n/ig,"\\n");
	 }
	try{	   
	   eval(expression);
	}catch(err){
	   alert(err.message);
	}
	
};

// 获得jsf状态标识
Matrix.getViewStateId = function(str){
	var result;
	 var r = str.match(/\s*<\s*input\s*.* name="javax.faces.ViewState" \s*.*(value\s*=\s*".*")\s*\/\s*>/);
	 if(r && r.length>1){
		result = r[1].replace("\n","");
		result = result.substring(result.indexOf("\"")+1,result.lastIndexOf("\""));
	 }else{
	 	return null;
	 }
};

// 异步请求回调方法
Matrix.update = function(data,ioArgs){
	if(!data){
		return ;
	}
	var result = data.data;
	if(result==null || result.trim().length==0){
		return ;
	}
	var arr = Matrix.getSplitResult(result);
	for(var i = 0; i < arr.length;i++){
		Matrix.run(arr[i]);
	}
	var vsId = Matrix.getViewStateId(result);
	if(vsId && vsId.length>0){
		document.getElementById("javax.faces.ViewState").value=vsId;
	}
};

// 根据规则截取异步请求返回js语句
Matrix.getSplitResult = function(inputStr){
		var tempArr = inputStr.split("]====");
		var tempResult = [];
		var count=0;
		for(var t=0;t<tempArr.length;t++){
			if(tempArr[t].indexOf("====[")>=0){
			    //var mm =	tempArr[t].match(/====\[.*;/);
				var mm = tempArr[t].match(/====\[[\w\W]*[;\}]/);
				if(mm!=null){
					if(mm.length>0){
						tempResult[count]=mm[0];
						count++;
					}
				}
			}
		}
		return tempResult;
	}	
/***** Ajax callback end *****/

/***** Serialize a form node to a JavaScript object start *****/
// Matrix表单转换成对象用于异步请求 ----暂未使用
Matrix.MatrixFormToObject = function(formNode){
	if(typeof formNode == "string"){
		formNode = eval(formNode);
	}
	if(!isc.isA.MatrixForm(formNode)){
		return null;
	}
	var result = formNode.getValues();
	return result;
}

// 转换表单元素值：替换SmartClient中的hint
Matrix.convertFormItemValue=function(formNode){
	if(!formNode){
		return null;
	}
	var exclude = "file|submit|image|reset|button|";
	var formElements;
	
	if(typeof formNode == "string"){
		formNode = document.getElementById(formNode);
	}
	formElements = formNode.elements;			
	
	if(formElements){
		var i = 0;
		while(typeof formElements[i]!="undefined"){
			var item = formElements[i];
			var _in = item.name;
			var type = (item.type||"").toLowerCase();
			var isDisabled = item.disabled;
			if(type=="radio"){
				//单选按钮通过组件判断是否disabled
				if(item.getAttribute("$89")){
					var itemObj = eval(item.getAttribute("$89"));
					if(itemObj){
						isDisabled = itemObj.isDisabled();
					}
				}
			}
			if(_in && type && exclude.indexOf(type) == -1 && !isDisabled){
			//if(_in && type && exclude.indexOf(type) == -1 && !item.disabled){
				var value = Matrix.fieldToObject(item);
				if(type=="select-multiple"){
					var hidden = document.createElement("input");
					hidden.name=_in+"_value";
					hidden.type="hidden";
					hidden.value=value+"";
					formNode.appendChild(hidden);
				}else{
					item.value = value;
				}
			}
			i++;
		}
	}
}

// 表单转换成对象用于异步请求
Matrix.formToObject = function(/*DOMNode||String*/ formNode){
		// summary:
		//		Serialize a form node to a JavaScript object.
		// description:
		//		Returns the values encoded in an HTML form as
		//		string properties in an object which it then returns. Disabled form
		//		elements, buttons, and other non-value form elements are skipped.
		//		Multi-select elements are returned as an array of string values.
		//
		// example:
		//		This form:
		//		|	<form id="test_form">
		//		|		<input type="text" name="blah" value="blah">
		//		|		<input type="text" name="no_value" value="blah" disabled>
		//		|		<input type="button" name="no_value2" value="blah">
		//		|		<select type="select" multiple name="multi" size="5">
		//		|			<option value="blah">blah</option>
		//		|			<option value="thud" selected>thud</option>
		//		|			<option value="thonk" selected>thonk</option>
		//		|		</select>
		//		|	</form>
		//
		//		yields this object structure as the result of a call to
		//		formToObject():
		//
		//		|	{ 
		//		|		blah: "blah",
		//		|		multi: [
		//		|			"thud",
		//		|			"thonk"
		//		|		]
		//		|	};
		
		if(!formNode){
			return null;
		}
		var ret = {};
		var exclude = "file|submit|image|reset|button|";
		var formElements;
		
		if(typeof formNode == "string"){
			formElements = document.getElementById(formNode).elements;
		}else{
			formElements = formNode.elements;			
		}
		
		if(formElements){
			var i = 0;
			while(typeof formElements[i]!="undefined"){
				var item = formElements[i];
				var _in = item.name;
				var type = (item.type||"").toLowerCase();
				if(_in && type && exclude.indexOf(type) == -1 && !item.disabled){
					Matrix.setJsonValue(ret, _in, Matrix.fieldToObject(item));
					//if(type == "image"){
					//	ret[_in+".x"] = ret[_in+".y"] = ret[_in].x = ret[_in].y = 0;
					//}
				}
				i++;
			}
		}
		return ret; // Object
}

// 表单元素转换成对象	
Matrix.fieldToObject = function(/*DOMNode||String*/ inputNode){
		// summary:
		//		Serialize a form field to a JavaScript object.
		//
		// description:
		//		Returns the value encoded in a form field as
		//		as a string or an array of strings. Disabled form elements
		//		and unchecked radio and checkboxes are skipped.	Multi-select
		//		elements are returned as an array of string values.
		var ret = null;
		var item = null;
		if(typeof inputNode == "string"){
			item = document.getElementById(inputNode);
		}else{
			item = inputNode;
		}
		if(item){
			var _in = item.name;
			// linxc test
			//var formProxy = eval("boundForm");
			//if(false && formProxy.getField(_in)){
			if(false){
			//	ret = formProxy.getValue(_in);
			}else{
				var type = (item.type||"").toLowerCase();
				if(_in && type && !item.disabled){
					if(type == "radio" || type == "checkbox"){
						if(item.checked){ ret = item.value }
					}else if(item.multiple){
						ret = [];
						var options = item.options
						if(options && options.length>0){
							for(var i=0;i<options.length;i++){
								var opt = options[i];
								if(opt.selected){
									ret.push(opt.value);
								}
							}
						}
						//if(ret.length>1){
						//	return ret.join(",");
						//}
					}else if(type=="textarea"){
						var _editor = Matrix.getMatrixComponentById(_in);
						if(_editor && _editor.getData && (typeof _editor.getData=="function")){
							ret = _editor.getData();
						}else{
							ret = item.value;
						}
					}else{
						var _obj = Matrix.getMatrixComponentById(item.name);
						if(_obj!=null && !(isc.isA.MatrixForm(_obj)) && _obj.getValue && (typeof _obj.getValue=="function")){
							if(isc.isA.DateItem(_obj)){
								if(_obj.getValue()==null){
									ret = "";
									//document.getElementById(item.name).value="";
									//document.getElementById(item.name+"_dateTextField").value="";
								}else{
									ret = item.value;
								}
								
								if(ret){
									if(ret.indexOf("$$DATE$$:")!=-1){
										ret = ret.replace("$$DATE$$:","");
									}
								}
							}else if(isc.isA.TimeItem(_obj)){
								if(_obj.getValue()==null){
									ret = "";
								}else{
									//var _itemValue = _obj.getDataElement().value;
									var _itemValue = isc.Time.toTime(_obj.getValue());
									ret = _itemValue==null?"":_itemValue;
								}
							}else{
								ret = _obj.getValue()==null?"":_obj.getValue();
							}
						}else{
							ret = item.value;
						}
					}
				}
			}
		}
		
		ret = Matrix.convertNullValue(ret);
		return ret; // Object
	}

// 将表单元素值放入json对象	
Matrix.setJsonValue = function(/*Object*/obj, /*String*/name, /*String*/value){
		//summary:
		//		For the named property in object, set the value. If a value
		//		already exists and it is a string, convert the value to be an
		//		array of values.

		//Skip it if there is no value
		if(value === null){
			return;
		}

		var val = obj[name];
		if(typeof val == "string"){ // inline'd type check
			obj[name] = [val, value];
		}else if(isA.Array(val)){
			val.push(value);
		}else{
			obj[name] = value;
		}
	}
/***** Serialize a form node to a JavaScript object end *****/

/***** form start *****/
// 通过编码获得SmartClient的代理Form
Matrix.getFormProxy = function(formId){
	if(formId==null){
		return null;
	}
	var formProxy = eval(Matrix.COMPONENT_PREFIX+formId);
	return formProxy;
}

//异步提交表单
Matrix.sendForm = function(formId,buttonId,validate,callbackFun,errorFun){
	if(formId==null || formId.trim().length==0){
		return;
	}
	var fm = document.getElementById(formId);
	if(!fm){
		return;
	}
	
	if(validate==null)validate = true;
	if(validate){
		if(!Matrix.validateForm(formId)){
			return;
		}
	}

	var vituralbuttonHidden = document.getElementById(Matrix.ACTION_SOURCE_ID_KEY);
	if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
	
	var data = {};
	if(buttonId){
		var actSourceId = document.getElementById(Matrix.ACTION_SOURCE_ID_KEY);
		if(actSourceId){
			fm.removeChild(actSourceId);
		}
		data[Matrix.ACTION_SOURCE_ID_KEY] = buttonId;
		
		data[buttonId] = buttonId;
	}
	
	Matrix.send(fm,data,callbackFun,errorFun);
}


// 提交表单
Matrix.submitForm = function(formId,buttonId,partialSubmit,validate,errorFun){
	if(formId==null || formId.trim().length==0){
		return;
	}
	var fm = document.getElementById(formId);
	if(!fm){
		return;
	}
	
	if(validate==null)validate = true;
	if(validate){
		if(!Matrix.validateForm(formId)){
			return;
		}
	}
	var data = {};
	if(buttonId){
		if(!partialSubmit){
			var hidden = document.createElement("input");
			hidden.name=buttonId;
			hidden.type="hidden";
			//hidden.value=bt.title;
			hidden.value=buttonId;
			fm.appendChild(hidden);
			
			var actSourceId = document.getElementById(Matrix.ACTION_SOURCE_ID_KEY);
			if(actSourceId){
				fm.removeChild(actSourceId);
			}
			var hidden2 = document.createElement("input");
			hidden2.type="hidden";
			hidden2.name=Matrix.ACTION_SOURCE_ID_KEY;
			hidden2.value=buttonId;
			fm.appendChild(hidden2);
		}else{
			var actSourceId = document.getElementById(Matrix.ACTION_SOURCE_ID_KEY);
			if(actSourceId){
				fm.removeChild(actSourceId);
			}
			data[Matrix.ACTION_SOURCE_ID_KEY] = buttonId;
		}
	}
	
	//转换表单中表格数据
	Matrix.convertDataGridDataOfForm(fm.id);
	
	if(partialSubmit){
		Matrix.send(fm,data,Matrix.update,errorFun);
	}else{
		Matrix.convertFormItemValue(fm);
		fm.submit();
	}
	
};

// reset表单
Matrix.resetForm = function(formId){
	if(formId==null){
		return ;
	}
	// smartclient form reset
	var formProxy = Matrix.getFormProxy(formId);
	if(formProxy)
		//formProxy.clearValues(); // clear all value
		formProxy.reset(); // reset to last time setValues point
		
	// html form reset
	var curForm = document.getElementById(formId);
	if(curForm)
		curForm.reset();
	
}

// 发送异步请求
Matrix.send = function(form,content,callbackFun,errorFun,method){
	if(form==null){
		return;
	}
	if(typeof form == "string")
		form = document.getElementById(form);
	if(!form){
		return;
	}
	var data = Matrix.formToObject(form);
	if(!data)data={};
	if(content){
		for(var name in content){
			var value = content[name];
			//Matrix.setJsonValue(data,name,value);
			data[name] = value;
		}
	}
	data[Matrix.AJAX_REQUEST_KEY]=Matrix.AJAX_REQUEST_VALUE;
	data[Matrix.REFRESH_FORM_ID]=form.id;
	var url = form.action;
	method=method?method:"POST";
	callbackFun=callbackFun?callbackFun:Matrix.update;
	//RPCManager.sendRequest({params:data,callback:callbackFun,handleError:errorFun,httpMethod:method,actionURL:url});
	Matrix.sendRequest(url,data,callbackFun,errorFun,method);
}

// 发送异步请求
Matrix.sendRequest=function(url,data,callbackFun,errorFun,method){
	if(url!=null && url.trim().length>0){
		if(data==null){
			data = {};
		}
		if((!data[Matrix.AJAX_REQUEST_KEY]) 
			|| (data[Matrix.AJAX_REQUEST_KEY]==null)){
			data[Matrix.AJAX_REQUEST_KEY] = Matrix.AJAX_REQUEST_VALUE;
		}
		method=method?method:"POST";
		RPCManager.sendRequest({actionURL:url,params:data,callback:callbackFun,handleError:errorFun,httpMethod:method});
	}
}

// 验证表单
Matrix.validateForm = function(formId){
	if(formId==null || formId.trim().length==0){
		return true;
	}	
	var formProxy = Matrix.getMatrixComponentById(formId);
	if(formProxy){
		return formProxy.validate();
	}
	return true;
}

/**
 * 找到一个元素所在的父表单元素
 * nodeId一个元素或它的id
 */
Matrix.getParentForm = function(nodeId){
	var n1;
	if(typeof nodeId == "string"){
		 n1 = document.getElementById(nodeId);
	}else{
		n1 = nodeId;
	}
	
	//要找的表单元素
	var n2=null;
	while(true){
		n2 = n1.parentNode;
		if(n2==null||n2.tagName.toUpperCase()=="FORM"||n2.tagName.toUpperCase()=="BODY"){
			break;
		}
		n1 = n2;
	}
	return n2;
};

/***** form end *****/

/***** validator start *****/
// 中文、字母、数字、-、_
Matrix.CNNameRegExp = /^[a-zA-Z0-9_\u4e00-\u9fa5\-]+$/;
// 字母、数字、-、_
Matrix.ENNameRegExp = /^[a-zA-Z0-9_\-]+$/;
// 数字
Matrix.NumberRegExp = /^[0-9]*$/;

Matrix.validateEmail = function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	if(reg.test(str)) return true;
	return false;
};

Matrix.validatePostCode = function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = /^\d{6}$/;
	if(reg.test(str)) return true;
	return false;
};

Matrix.validateMobileTelephone=function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;
	if(reg.test(str) && str.length==11) return true;
	return false;
};

Matrix.validateIdentityCard=function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	//var reg = /^\d{15}(\d{2}[0-9X])?$/;
	var reg = /(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|(\d|X)?)$)/;
	if(reg.test(str)) return true;
	return false;
};

Matrix.validateRegexp = function(regexp,str){
	if(str==null || str.trim().length==0) return true;
	if(regexp==null){
		return true;
	}
	str = str.trim();
	return regexp.test(str);
};

Matrix.validatePrecision=function(precision,str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = new RegExp("^\\d*\\.\\d{"+precision+"}$");
	if(reg.test(str)) return true;
	return false;
};

Matrix.validateLength=function(minLen,maxLen,str){
	if(str==null || str.trim().length==0){
		//if(minLen>0){
		//	return false;
		//}
		return true;
	}
	str = str.trim();
	var len = str.getBytes();
	//if(str.length<minLen||str.length>maxLen) return false;
	if(len<minLen||len>maxLen) return false;
	return true;
};

Matrix.validateLong=function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg=/^\d+$/;
	if(reg.test(str)) return true;
	return false;
};

Matrix.validateDouble=function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = /^\d*\.?\d*$/;
	if(reg.test(str)) return true;
	return false;
};

Matrix.validateLongRange = function(minValue,maxValue,str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	if(!Matrix.validateLong(str)) return false;
	var value = parseInt(str);
	if(value<minValue||value>maxValue) return false;
	return true;
};

Matrix.validateDoubleRange = function(minValue,maxValue,str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	if(!Matrix.validateDouble(str)) return false;
	var value = parseFloat(str);
	if(value<minValue||value>maxValue) return false;
	return true;
};

Matrix.validateGroupRequired = function(item, validator, value, record){
	if(item){
		if(isc.isA.RadioItem(item)){
			// 单选按钮
			if(item.getDataElement().checked){
				return true;
			}else{
				if(item.groupId!=null){
					var _items = item.form.getItems();
					for(var i=0;i<_items.length;i++){
						var _item = _items[i];
						if(isc.isA.RadioItem(_item) && item.groupId==_item.groupId){
							if(_item.getDataElement().checked){
								return true;
							}
						}
					}
				}
			}
		}else if(isc.isA.CheckboxItem(item)){
			// 复选框
			if(item.getValue()!=null && item.getValue()!=Matrix.VALUE_NULL){
				return true;
			}else{
				if(item.groupId!=null){
					var _items = item.form.getItems();
					for(var i=0;i<_items.length;i++){
						var _item = _items[i];
						if(isc.isA.CheckboxItem(_item) && item.groupId==_item.groupId){
							if(_item.getValue()!=null && _item.getValue()!=Matrix.VALUE_NULL){
								return true;
							}
						}
					}
				}
			}
		}
	}
	return false;
};

/***** validator end *****/

/***** upload file start *****/
// 上传附件验证类型
Matrix.validateUploadFileType = function(vId,enableType){
	var vObj = document.getElementById(vId);
	var filePath = vObj.value;
	fileType = filePath.substring(filePath.lastIndexOf(".")+1);
	if(enableType!=null && enableType!="" && enableType.toUpperCase().indexOf(fileType.toUpperCase())==-1){
		return false;
	}
	return true;
}

/***** upload file end *****/

/***** date start *****/
// 格式化时间---使用到了date.js
Matrix.formatDate=function(value,formatPattern){
	var result; 
	if(value instanceof Date){
		var df1 = new DateFormat(formatPattern);
		result= df1.format(value);
	}
	if(result==null) result="";
	if(result.toString().trim().length==0) result="";
	return result;
}

// 构造时间对象---使用到了date.js
Matrix.parseDate=function(value,formatPattern){
	var result; 
	if(value instanceof Date){
		return value;
	}
	var df1 = new DateFormat(formatPattern);
	result= df1.parse(value);
	return result;
}
/***** date end *****/

/***** list grid start *****/
// 格式化表格显示值
Matrix.formatter = function(value,formatStyle,formatPattern,record,rowNum, colNum,grid){
	
	// 取空值
	var _emptyCellValue = Matrix.getDataGridEmptyCellValue(grid,colNum);

	if(value==null||""==value.toString().trim()) return _emptyCellValue;
	
	var result = value.toString();
	if("number"==formatStyle){
		result= Matrix.formatNumber(value.toString(),formatPattern);
	}else if("currency"==formatStyle){
		var numStartIndex = 0;
		for(var i = 0; i < formatPattern.length;i++){
			var item = formatPattern.charAt(i);
			numStartIndex = i;
			if("."==item||"#"==item||","==item){
				break;
			}
		}

		result= formatPattern.substring(0,numStartIndex)+Matrix.formatNumber(value.toString(),formatPattern.substring(numStartIndex));
	}else if("date"==formatStyle){
		
		if(value instanceof Date){
			var df1 = new DateFormat(formatPattern);
			result= df1.format(value);
		}
	}
	if(result==null || result.toString().trim().length==0) result=_emptyCellValue;

	return result;
};

// 格式化表格数值型数据显示值
Matrix.formatNumber = function(number,pattern){
    var str            = number.toString();
    var strInt;
    var strFloat;
    var formatInt;
    var formatFloat;
    if(/\./g.test(pattern)){
        formatInt        = pattern.split('.')[0];
        formatFloat        = pattern.split('.')[1];
    }else{
        formatInt        = pattern;
        formatFloat        = null;
    }
    if(/\./g.test(str)){
        if(formatFloat!=null){
            var tempFloat    = Math.round(parseFloat('0.'+str.split('.')[1])*Math.pow(10,formatFloat.length))/Math.pow(10,formatFloat.length);
            strInt        = (Math.floor(number)+Math.floor(tempFloat)).toString();                
            strFloat    = /\./g.test(tempFloat.toString())?tempFloat.toString().split('.')[1]:'0';            
        }else{
            strInt        = Math.round(number).toString();
            strFloat    = '0';
        }
    }else{
        strInt        = str;
        strFloat    = '0';
    }
    if(formatInt!=null){
        var outputInt    = '';
        var zero        = formatInt.match(/0*$/)[0].length;
        var comma        = null;
        if(/,/g.test(formatInt)){
            comma        = formatInt.match(/,[^,]*/)[0].length-1;
        }
        var newReg        = new RegExp('(\\d{'+comma+'})','g');

        if(strInt.length<zero){
            outputInt        = new Array(zero+1).join('0')+strInt;
            outputInt        = outputInt.substr(outputInt.length-zero,zero)
        }else{
            outputInt        = strInt;
        }

        var 
        outputInt            = outputInt.substr(0,outputInt.length%comma)+outputInt.substring(outputInt.length%comma).replace(newReg,(comma!=null?',':'')+'$1')
        outputInt            = outputInt.replace(/^,/,'');

        strInt    = outputInt;
    }

    if(formatFloat!=null){
        var outputFloat    = '';
        var zero        = formatFloat.match(/^0*/)[0].length;

        if(strFloat.length<zero){
            outputFloat        = strFloat+new Array(zero+1).join('0');
            //outputFloat        = outputFloat.substring(0,formatFloat.length);
            var outputFloat1    = outputFloat.substring(0,zero);
            var outputFloat2    = outputFloat.substring(zero,formatFloat.length);
            outputFloat        = outputFloat1+outputFloat2.replace(/0*$/,'');
        }else{
            outputFloat        = strFloat.substring(0,formatFloat.length);
        }

        strFloat    = outputFloat;
    }else{
        if(pattern!='' || (pattern=='' && strFloat=='0')){
            strFloat    = '';
        }
    }

    return strInt+(strFloat==''?'':'.'+strFloat);
};

// 格式化表格链接型数据显示值
Matrix.buildLink  = function(url,text){
		var u = "";
		if(url){
		 u = url.toString().trim();
		}
		var t = text;	
		if(u.indexOf('javascript:')!=0 && u.indexOf('http://')!=0){
			u = webContextPath+"/"+u;
		}
		/*
		if(u.indexOf('javascript:')!=-1){
			u = u.replace("javascript:","");
			return "<a onclick='"+u+"' herf='#'>"+t+"</a>";	
		}
		*/
		if(u.indexOf("\"")!=-1){
			return "<a href='"+u+"'>"+t+"</a>";
		}
		return "<a href=\""+u+"\">"+t+"</a>";
};

Matrix.getDataGridEmptyCellValue=function(grid,colNum){
	var _emptyCellValue = "&nbsp;";
	if(grid!=null && colNum!=null){
		var _field = grid.getField(colNum);
		if(_field){
			if(_field.emptyCellValue!=null && !isc.is.emptyString(_field.emptyCellValue)){
				_emptyCellValue = _field.emptyCellValue;
			}else{
				if(grid.emptyCellValue!=null && !isc.is.emptyString(grid.emptyCellValue)){
					_emptyCellValue = grid.emptyCellValue;
				}
			}
		}else{
			if(grid.emptyCellValue!=null && !isc.is.emptyString(grid.emptyCellValue)){
				_emptyCellValue = grid.emptyCellValue;
			}
		}
	}
	return _emptyCellValue;
}


// 格式化表格自定义类型数据显示值
Matrix.conditionFormatter = function(value,options,row,rowNum, colNum,grid){
	var newValue = "";

	// 取空值
	//var _emptyCellValue = Matrix.getDataGridEmptyCellValue(grid,colNum);

	if(options!=null && options.length>0){
		for(var i = 0; i < options.length; i++){
			if(i!=0){
				newValue += "&nbsp;";
			}
			var op = options[i];
			var result = false;
			result = eval("result = "+op._condition);
			if(result && op._value!=null){
				
				/*
				if(op._value==null){
					op._value = _emptyCellValue;
				}
				*/
				
				if("link_type"==op._type){
					newValue += Matrix.buildLink(op._link,op._value);
				}else if("text_type" == op._type){
					newValue +=  op._value;
				}else if("picture_type" == op._type){
					var _alt = "";
					if(op._alt!=null){
						_alt = " alt='"+op._alt+"'";
					}
					newValue += "<img "+_alt+" style='border:0px' src='"+op._value+"' height='20'>";
				}else if("picture_flow_link" == op._type){
					var ps = op._params;
					var _alt = "";
					if(op._alt!=null){
						_alt = " alt='"+op._alt+"'";
					}
					var str= "<a style='text-decoration: none;' href ='#' onclick=\"(function(event){Matrix.continuePageFlow('"+op._actionSourceId+"','"+op._params+"',event);return false;})(event);\">";
					str+="<img "+_alt+" style='border:0px' src='"+op._value+"' >"+"</a>";
					newValue += str;
				}else if("picture_link_type" == op._type){
					var _alt = "";
					if(op._alt!=null){
						_alt = " alt='"+op._alt+"'";
					}
					newValue += Matrix.buildLink(op._link,"<img "+_alt+" src='"+op._value+"' height='20'>");
				}else if("flow_link_type"==op._type){
					var ps = op._params;
					var str= "<a href ='#' onclick=\"(function(event){Matrix.continuePageFlow('"+op._actionSourceId+"','"+op._params+"',event);return false;})(event);\">"+op._value+"</a>";
					//alert(str);
					newValue += str;
				}else if("func_type"==op._type){
					var func;
					eval("func="+op._value);
					newValue += func(value,row);
				}
			}
		}
	}else{
		if(value!=null){
			newValue = value;
		}
	}
	
	if(newValue==null){
		var _emptyCellValue = Matrix.getDataGridEmptyCellValue(grid,colNum);
		newValue = _emptyCellValue;
	}

	return newValue;
};

// 格式化表格自定义类型数据中页面流链接实现
Matrix.continuePageFlow = function(actionSourceId,params,e){
	var event = e||window.event;
	var src = event.srcElement||event.target;  
	var form = Matrix.getParentForm(src);
	form.action=webContextPath+"/flowdo.flow";

	var vituralActionSourceHidden = document.getElementById(Matrix.ACTION_SOURCE_ID_KEY);
	if(vituralActionSourceHidden){
		vituralActionSourceHidden.parentNode.removeChild(vituralActionSourceHidden);
	}
	
	var hidden = document.createElement("input");
	hidden.type="hidden";
	hidden.name=Matrix.ACTION_SOURCE_ID_KEY;
	hidden.value=actionSourceId;
	form.appendChild(hidden);
	
	var continueHidden = document.createElement("input");
	continueHidden.type="hidden";
	continueHidden.name="continueflow";
	continueHidden.value="true";
	form.appendChild(continueHidden);
	
	if(params&&params.length>0){
		var paires = params.split(",");
		for(var i = 0; i < paires.length; i++){
			var entry = paires[i].split("=");
			var paramHidden = document.createElement("input");
			paramHidden.type="hidden";
			paramHidden.name=entry[0];
			paramHidden.value=entry[1];
			form.appendChild(paramHidden);
		}
	}
	//转换表单值
	Matrix.convertFormItemValue(form);
	form.submit();
	
};

// 将表格行转换成json字符串
Matrix.itemsToJson = function(items,dataGrid){
	var result = "";
	if(items!=null){
		
		if(!isc.isAn.Array(items)){
			var items2 = new Array();
			items2.add(items);
			items = items2;
		}
		
		var newItems = isc.JSON.decode(isc.JSON.encode(items)); 

		for(var _index=0;_index<newItems.length;_index++){
			var item = newItems[_index];
			if(item==null){
				continue;
			}
			
			// 如果是数据表格数据将删除标识移除
			if(dataGrid&&dataGrid.selection)
				delete item[dataGrid.selection.selectionProperty];
			
			var obj = {};
			for(i in item){
				// 删除表格项多余属性 $81y、$29a、_selection_
				if(i.startsWith("_selection_"))continue;
				if(i.startsWith("_recordComponents_"))continue;
				if(i=="$81y")continue;
				if(i=="$29a")continue;
				
				if(i.indexOf("_")!=0){
					if(isc.isAn.Array(item[i]))
						obj[i] = item[i][0];
					else
						obj[i] = item[i];
				}
				
			}
			
			if(result.length>0) result+=",";
			
				var ao = {};
			for(p in obj){
				if(obj[p] instanceof Date){
					var d = obj[p];
					alert(d.getYear()+"-"+d.getMonth()+"-"+d.getDate()+"-"+d.getHours()+"-"+d.getMinutes()+"-"+d.getSeconds());
					var y =(d.getYear()<1000)? (1900+d.getYear()):d.getYear(); 
					var m = (d.getMonth()+1<10)?("0"+(d.getMonth()+1)):(d.getMonth()+1);
					var dd = (d.getDate()<10)?("0"+d.getDate()):d.getDate();
					var h = (d.getHours()<10)?("0"+d.getHours()):d.getHours();
					var mm = (d.getMinutes()<10)?("0"+d.getMinutes()):d.getMinutes();
					var s = (d.getSeconds()<10)?("0"+d.getSeconds()):d.getSeconds();
					ao[p] =y +"-"+m+"-"+dd+" "+h+":"+mm+":"+s;
				}else{
					if(isc.Browser.isIE){
						var d = obj[p];
						if( ((typeof d == "string") || (d instanceof String)) && (d.length == 10 && d.substring(4,5)=="-" && d.substring(7,8) =="-") ){
							 //if(d.match(/^\d{4}(\-|\/|\.)\d{1,2}\1\d{1,2}$/)){ 
								d = d + " 00:00:00";
							//}	
							ao[p] = d;
						}else{
							ao[p] = obj[p];
                        }

					}else{
						ao[p] = obj[p];
                    }
				}
				
			}
			result += isc.JSON.encode(ao);
		}
	}
	return result;
};

/** 
 * 给表格添加一行
 */
Matrix.addDataGridData = function(dataGridId){
	// 保存表格数据，返回验证结果
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	if(!_curGrid.canEdit){
		isc.warn("该表格不支持编辑。");
		return false;
	}
	
	// 添加一个标识，在级联下拉中使用
	//_curGrid.newRowFlag = true;
	// 创建一行
	_curGrid.startEditingNew();
	
	return false;
}

// 保存表格编辑数据
Matrix.saveDataGridData = function(dataGridId){
	// 保存表格数据，返回验证结果
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	if(_curGrid.canEdit){
		return _curGrid.saveAllEdits();
	}
	return true;
}

//提交数据表格选中的项
Matrix.selectDataGridData = function(dataGridId,actionId,msg){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	if(!_curGrid.getSelection() || _curGrid.getSelection().length==0){
		isc.warn("没有数据被选中，不能执行此操作。");
		return false;
	}	
	if(msg){
		if(!window.confirm(msg)){
			return false;
		}
	}
	
	if(_curGrid.canEdit && _curGrid.hasChanges()){
		// 保存表格编辑数据
		if(!Matrix.saveDataGridData(dataGridId)){
			isc.warn("表格包含非法数据。");
			return false;
		};
	}
	
    //选中对象的JSON字符串表示
    var result = Matrix.itemsToJson(_curGrid.getSelection(),_curGrid);
    var result2 = "";
    if(_curGrid.getSelection().length==1){
    	result2 = result;
    }else{
    	result2 = Matrix.itemsToJson(_curGrid.getSelection()[0]);
    }
    
	if(actionId){
	    //要找的表单元素
	    var n2=Matrix.getParentForm(_curGrid.displayId);	
		if(n2!=null &&n2.nodeType==1&&n2.tagName.toUpperCase()=="FORM"){
			// 获得表格组件查询条件和排序属性
			var data = _curGrid.getFilterVaulesAndSortAttrObj();
			data[Matrix.escapeId(dataGridId)+"_"+Matrix.escapeId(actionId)+Matrix.GRID_EVENT_TYPE_SUFFIX]=Matrix.GRID_EVENT_TYPE_SELECT;	
			data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_SELECT_OBJECT]=result;
			data[Matrix.REFRESH_COMPONENT_IDS]=_curGrid.name+",";
			data[Matrix.OP_GRID_ID]=_curGrid.name;
			
			Matrix.send(n2,data);
		}
		return false;
	}else{
		if(document.getElementById(Matrix.escapeId(dataGridId)+"_selections"))document.getElementById(Matrix.escapeId(dataGridId)+"_selections").value=result;
		if(document.getElementById(Matrix.escapeId(dataGridId)+"_selection"))document.getElementById(Matrix.escapeId(dataGridId)+"_selection").value=result2;
		return true;
    }
};

/**
 * 删除数据表格选中的项
 */
Matrix.deleteDataGridData = function(dataGridId,actionId,msg){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	/*
	if(!_curGrid.getSelection() || _curGrid.getSelection().length==0){
		isc.warn("没有数据被选中，不能执行此操作。");
		return false;
	}	
	if(msg){
		if(!window.confirm(msg)){
			return false;
		}
	}
	if(_curGrid.canEdit && _curGrid.hasChanges()){
		// 保存表格编辑数据
		if(!Matrix.saveDataGridData(dataGridId)){
			isc.warn("表格包含非法数据。");
			return false;
		};
	}
	
	
	//选中对象的JSON字符串表示
    var result = Matrix.itemsToJson(_curGrid.getSelection(),_curGrid);
    
	if(actionId){
	    //要找的表单元素
	    var n2=Matrix.getParentForm(_curGrid.displayId);	
		if(n2!=null &&n2.nodeType==1&&n2.tagName.toUpperCase()=="FORM"){
			// 获得表格组件查询条件和排序属性
			var data = _curGrid.getFilterVaulesAndSortAttrObj();
			//data[Matrix.escapeId(dataGridId)+"_"+Matrix.escapeId(actionId)+Matrix.GRID_EVENT_TYPE_SUFFIX]=Matrix.GRID_EVENT_TYPE_SELECT;	
			data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_TYPE_SUFFIX]=Matrix.GRID_EVENT_TYPE_DELETE;	
			data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_SELECT_OBJECT]=result;
			data[Matrix.REFRESH_COMPONENT_IDS]=_curGrid.name+",";
			data[Matrix.OP_GRID_ID]=_curGrid.name;
			Matrix.send(n2,data);
		}
	}
	//else{
		//_curGrid.removeSelectedData();
	//}
	*/
	_curGrid.removeSelectedData();
	
	return true;
}

/**
 * 提交数据表格中修改或删除的数据
 */
Matrix.updateDataGridData = function(dataGridId,actionId,msg){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	if(_curGrid.canEdit && _curGrid.hasChanges()){
		// 保存表格编辑数据
		if(!Matrix.saveDataGridData(dataGridId)){
			isc.warn("表格包含非法数据。");
			return false;
		};
	}
	
	// 新增数据
	var insertItems = _curGrid.insertItems;
	// 修改数据
	var updateItems = _curGrid.updateItems;
	// 删除数据
	var deleteItems = _curGrid.deleteItems;
	
	// 合并新增和修改数据
	var items = [];
	for(var i=0;i<insertItems.length;i++){
		items.push(insertItems[i]);
	}
	for(var i=0;i<updateItems.length;i++){
		items.push(updateItems[i]);
	}
	
	if(items.length==0&&deleteItems==0){
		isc.warn("没有数据被修改，不能执行此操作。");
		return false;
	}	
	
	if(msg){
		if(!window.confirm(msg)){
			return false;
		}
	}
	
	//选中对象的JSON字符串表示
	var result = Matrix.itemsToJson(items);
	var deletedResult = Matrix.itemsToJson(deleteItems);
	
	//要找的表单元素
	var n2=Matrix.getParentForm(_curGrid.displayId);
	
	if(n2!=null &&n2.nodeType==1&&n2.tagName.toUpperCase()=="FORM"){
		
		// 获得表格组件查询条件和排序属性
		var data = _curGrid.getFilterVaulesAndSortAttrObj();
		
		if(actionId){
			data[Matrix.escapeId(dataGridId)+"_"+Matrix.escapeId(actionId)+Matrix.GRID_EVENT_TYPE_SUFFIX]=Matrix.GRID_EVENT_TYPE_UPDATE;	
		}else{
			data[Matrix.escapeId(dataGridId)+Matrix.escapeId(actionId)+Matrix.GRID_EVENT_TYPE_SUFFIX]=Matrix.GRID_EVENT_TYPE_UPDATE;	
		}
		data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_UPDATE_OBJECT]=result;
		data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_DELETE_OBJECT]=deletedResult;
		data[Matrix.REFRESH_COMPONENT_IDS]=_curGrid.name+",";
		data[Matrix.OP_GRID_ID]=_curGrid.name;
		Matrix.send(n2,data);
		// 清空表格记录修改数据
		_curGrid.insertItems = []; 
		_curGrid.updateItems = []; 
		_curGrid.deleteItems = []; 
	}
	return false;
};

/**
 * 将修改、添加、删除行数据放入隐藏域中
 */
Matrix.convertEditDataGridData = function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	if(_curGrid.canEdit && _curGrid.hasChanges()){
		// 保存表格编辑数据
		if(!Matrix.saveDataGridData(dataGridId)){
			isc.warn("表格包含非法数据。");
			return false;
		};
	}
	
	
	
	
	// 新增数据
	var insertItems = _curGrid.insertItems;
	// 修改数据
	var updateItems = _curGrid.updateItems;
	// 删除数据
	var deleteItems = _curGrid.deleteItems;
	
	/*
	if((insertItems==null || insertItems.length==0)
		&& (updateItems==null || updateItems.length==0)
		&& (deleteItems==null || deleteItems.length==0)){
		isc.warn("没有数据被修改。");
		return false;
	}
	*/
	//修改对象的JSON字符串表示
	var insertResult = Matrix.itemsToJson(insertItems);
	var updateResult = Matrix.itemsToJson(updateItems);
	var deleteResult = Matrix.itemsToJson(deleteItems);
    document.getElementById(Matrix.escapeId(dataGridId)+"_insert_rows").value=insertResult;
    document.getElementById(Matrix.escapeId(dataGridId)+"_update_rows").value=updateResult;
    document.getElementById(Matrix.escapeId(dataGridId)+"_delete_rows").value=deleteResult;
    
    // 清空表格记录修改数据
	_curGrid.insertItems = []; 
	_curGrid.updateItems = []; 
	_curGrid.deleteItems = []; 
	
	return true;
}


Matrix.getDataGridIdsHiddenOfForm=function(formId){
	return document.getElementById("matrix_form_datagrid_"+formId);
}
// 转换表单内表格数据
Matrix.convertDataGridDataOfForm=function(formId){
	var gridIds = Matrix.getDataGridIdsHiddenOfForm(formId)?Matrix.getDataGridIdsHiddenOfForm(formId).value:null;
	if(gridIds!=null && gridIds.trim().length>0){
		gridIds = gridIds.split(",");
		for(var i=0;i<gridIds.length;i++){
			var gridId = gridIds[i];
			if(gridId!=null && gridId.trim().length>0){
				var curGrid = Matrix.getMatrixComponentById(gridId);
				Matrix.saveDataGridData(gridId);
				
				// 新增数据
				var insertRows = curGrid.insertItems;
				// 修改数据
				var updateRows = curGrid.updateItems;
				// 删除数据
				var deleteRows = curGrid.deleteItems;
				// 选中数据
				var selection = curGrid.getSelection();
				var selectionRows = null;
			    var selectionRow = null;
			    if(selection!=null && selection.length>0){
			    	selectionRows = selection;
			    	selectionRow = selection[0];
			    }
			    
			    //修改对象的JSON字符串表示
				if(document.getElementById(gridId+"_all_rows")){
					var allResult = Matrix.itemsToJson(curGrid.getData());
			    	document.getElementById(gridId+"_all_rows").value=allResult;
				}
			    if(document.getElementById(gridId+"_selections")){
					var selectionsResult = Matrix.itemsToJson(selectionRows);
			    	document.getElementById(gridId+"_selections").value=selectionsResult;
			    }	
			    if(document.getElementById(gridId+"_selection")){
					var selectionResult = Matrix.itemsToJson(selectionRow);
			    	document.getElementById(gridId+"_selection").value=selectionResult;
			    }
			    
			    if(curGrid.canEdit){
				    if(document.getElementById(gridId+"_insert_rows")){
						var insertResult = Matrix.itemsToJson(insertRows);
				    	document.getElementById(gridId+"_insert_rows").value=insertResult;
				    }
				    if(document.getElementById(gridId+"_update_rows")){
						var updateResult = Matrix.itemsToJson(updateRows);
				    	document.getElementById(gridId+"_update_rows").value=updateResult;
				    }
				    if(document.getElementById(gridId+"_delete_rows")){
						var deleteResult = Matrix.itemsToJson(deleteRows);
				    	document.getElementById(gridId+"_delete_rows").value=deleteResult;
				    }	
			    }
			}
		}
		
		
	}
}




/** 
 * 排序
 */
Matrix.sortDataGridData = function(dataGridId,fieldName,sortType){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	if(_curGrid.confirmDiscardEdits){
		// 判断表格是否编辑提示
		if(_curGrid.canEdit && _curGrid.hasChanges()){
			if(window.confirm(_curGrid.confirmDiscardEditsMessage)){
			}else{
				return false;
			}
		}
	}
	
	if(fieldName==null || fieldName.trim().length()==0){
		isc.warn("请指定要排序的表格字段。");
		return false;
	}
	
	if(sortType!=null && sortType.toUpperCase()==Matrix.GRID_EVENT_SORT_TYPE_ASC){
		sortType = Matrix.GRID_EVENT_SORT_TYPE_ASC;
	}else{
		sortType = Matrix.GRID_EVENT_SORT_TYPE_DESC;
	}
	
	//要找的表单元素	
	var n2=Matrix.getParentForm(_curGrid.displayId);	
	if(n2!=null &&n2.nodeType==1&&n2.tagName.toUpperCase()=="FORM"){
		var data = _curGrid.getFilterValuesObj(); //获得过滤条件
		data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_TYPE_SUFFIX]=Matrix.GRID_EVENT_TYPE_SORT;
		data[Matrix.escapeId(dataGridId)+Matrix.GRID_EVENT_SORT_ATTR]=fieldName+" "+sortType;
		data[Matrix.REFRESH_COMPONENT_IDS]=_curGrid.name+",";
		data[Matrix.OP_GRID_IDS]=_curGrid.name;
		Matrix.send(n2,data);
	}
	return false;
}

// 渲染分页条
Matrix.fillDataPaginator = function(paginatorId,currentPage,pageCount,pageGroupCount,dataGridId, totalCount){
//	if(pageCount>0){
	if(true){
		eval(Matrix.escapeId(paginatorId)+"_currentPage="+currentPage);
		
		//添加状态条
		var status = document.getElementById(paginatorId+":status");
		if(status){
			//status.innerHTML="共&nbsp;"+pageCount+"&nbsp;页&nbsp;"+totalCount+"&nbsp;条记录&nbsp;&nbsp;";
			status.innerHTML="共&nbsp;"+totalCount+"&nbsp;条记录&nbsp;&nbsp;当前第&nbsp;"+currentPage+"/"+pageCount+"&nbsp;页";
		}  
		
		var numberLink = "";
		var start = 1; 
		var end = pageGroupCount;
		if(currentPage!=1){
			if((currentPage==pageGroupCount||(currentPage+1)%pageGroupCount==0)&&(currentPage+1)!=pageGroupCount){
				start = currentPage;
			}else{
				var group = Math.floor(currentPage/pageGroupCount);
				if(group==0){
					start = pageGroupCount*group+1;
				}else if(group==1){
					start = pageGroupCount*group;
				}else{
					start = pageGroupCount*group-1;
				}
			}
			end = ((start + pageGroupCount-1)<pageCount)?(start + pageGroupCount-1):pageCount;
		}else{
			end = pageGroupCount>pageCount?pageCount:pageGroupCount;
		}
		
		//添加分页页码
		var pageNumbers = document.getElementById(paginatorId+":pageNumbers");
		if(pageNumbers){
			for(var i = start; i <= end; i++){
				if(i==currentPage){
					numberLink += "<span class='pagenumber_text'>";
					numberLink += i;
				}else{
					numberLink += "<span class='pagenumber_link'>";
					numberLink = numberLink+ "<a  title='第"+i+"页' href='javascript:void(0)'  onclick='javascript:Matrix.pagingDataGridData(\""+dataGridId+"\",\""+paginatorId+"\","+i+");return false;'>"+i+"</a>";
				}
	
				numberLink += "</span>";
			}
			pageNumbers.innerHTML=numberLink;
		}
			
		//给首页、末页、前一页、后一页添加行为
		var first = document.getElementById(paginatorId+":first");
		if(first){
			var firstLink = document.getElementById(paginatorId+"_fA");
			if(currentPage>1){
				var firstStr = "<a id='"+paginatorId+"_fA' class='first_link'  title='第一页' href='javascript:void(0)'  onclick='javascript:Matrix.pagingDataGridData(\""+dataGridId+"\",\""+paginatorId+"\","+1+");return false;'>";
				if(firstLink==null){
					first.innerHTML = firstStr+first.innerHTML+"</a>";
				}else{
					first.innerHTML = firstStr+firstLink.innerHTML+"</a>";
				}
			}else{
				if(firstLink){
					first.innerHTML = firstLink.innerHTML;
				}
			}
		}
			
		var last = document.getElementById(paginatorId+":last");
		if(last){
			var lastLink = document.getElementById(paginatorId+"_lA");
			if(currentPage<pageCount){
				var lastStr = "<a  id='"+paginatorId+"_lA' class='last_link' title='最后一页' href='javascript:void(0)' onclick='javascript:Matrix.pagingDataGridData(\""+dataGridId+"\",\""+paginatorId+"\","+pageCount+");return false;'>";
				if(lastLink==null){
					last.innerHTML = lastStr+last.innerHTML+"</a>";
				}else{
					last.innerHTML = lastStr+lastLink.innerHTML+"</a>";
				}
			}else{
				if(lastLink){
					last.innerHTML = lastLink.innerHTML;
				}
			}
		}
		
		var previous = document.getElementById(paginatorId+":previous");
		if(previous){
			var previousLink = document.getElementById(paginatorId+"_pA");
			if(currentPage>1){
				var previousStr = "<a id='"+paginatorId+"_pA' class='previous_link'  href='javascript:void(0)' title='前一页' onclick='Matrix.pagingDataGridData(\""+dataGridId+"\",\""+paginatorId+"\","+(currentPage-1)+");return false;'>";
				if(previousLink==null){
					previous.innerHTML = previousStr+previous.innerHTML+"</a>";
				}else{
					previous.innerHTML = previousStr+previousLink.innerHTML+"</a>";
				}
			}else{
				if(previousLink){
					previous.innerHTML = previousLink.innerHTML;
				}
			}
		}
		
		var next = document.getElementById(paginatorId+":next");
		if(next){
			var nextLink = document.getElementById(paginatorId+"_nA");
			if(currentPage<pageCount){
				var nextStr = "<a id='"+paginatorId+"_nA' class='next_link' title='下一页' href='javascript:void(0)'  onclick='javascript:Matrix.pagingDataGridData(\""+dataGridId+"\",\""+paginatorId+"\","+(currentPage+1)+");return false;'>";
				if(nextLink==null){
					next.innerHTML = nextStr+next.innerHTML+"</a>";
				}else{
					next.innerHTML = nextStr+nextLink.innerHTML+"</a>";
				}
			}else{
				if(nextLink){
					next.innerHTML = nextLink.innerHTML;
				}
			}
		}
		
		//判断导航条只读
		if(currentPage<=1){
			var fI = document.getElementById(paginatorId+"_fI");
			if(fI){
				if(fI.src.indexOf("matrix/resource/images/paginator/first.gif")>=0){
					fI.src = fI.src.replace("first.gif","first_gray.gif");
				}
			}
			
			var pI = document.getElementById(paginatorId+"_pI");
			if(pI){
				if(pI.src.indexOf("matrix/resource/images/paginator/pre.gif")>=0){
					pI.src = pI.src.replace("pre.gif","pre_gray.gif");
				}
			}
			
		}
		
		if(currentPage>=pageCount){
			var nI = document.getElementById(paginatorId+"_nI");
			if(nI){
				if(nI.src.indexOf("matrix/resource/images/paginator/next.gif")>=0){
					nI.src = nI.src.replace("next.gif","next_gray.gif");
				}
			}
		
			var lI = document.getElementById(paginatorId+"_lI");
			if(lI){
				if(lI.src.indexOf("matrix/resource/images/paginator/last.gif")>=0){
					lI.src = lI.src.replace("last.gif","last_gray.gif");
				}
			}
		}
		if(currentPage<pageCount){
			var nI = document.getElementById(paginatorId+"_nI");
			if(nI){
				if(nI.src.indexOf("matrix/resource/images/paginator/next_gray.gif")>=0){
					nI.src = nI.src.replace("next_gray.gif","next.gif");
				}
			}
		
			var lI = document.getElementById(paginatorId+"_lI");
			if(lI){
				if(lI.src.indexOf("matrix/resource/images/paginator/last_gray.gif")>=0){
					lI.src = lI.src.replace("last_gray.gif","last.gif");
				}
			}
		}
			
		if(currentPage>1){
			var fI = document.getElementById(paginatorId+"_fI");
			if(fI){
				if(fI.src.indexOf("matrix/resource/images/paginator/first_gray.gif")>=0){
					fI.src = fI.src.replace("first_gray.gif","first.gif");
				}
			}
			
			var pI = document.getElementById(paginatorId+"_pI");
			if(pI){
				if(pI.src.indexOf("matrix/resource/images/paginator/pre_gray.gif")>=0){
					pI.src = pI.src.replace("pre_gray.gif","pre.gif");
				}
			}
		}
	
		//添加跳转文本框
		var goSpan =  document.getElementById(paginatorId+":go");
		var go = document.getElementById(paginatorId+":goText");
		if(go){
			var input = document.getElementById(paginatorId+"_goInput");
			var goText;
			if(input!=null){
				goText = input;
			}else{
				goText = document.createElement("input");
				goText.id=paginatorId+"_goInput";
				goText.title="跳转页数";
				goText.onkeydown=function(event){
					var ev= window.event||e;
					if (ev.keyCode==13){
						Matrix.pagingByGoButton(dataGridId,paginatorId,pageCount);
					}
				}
				go.appendChild(goText);
			}
			goText.value=currentPage;
			
				/*
			if(goText){
				goText.value=currentPage;
				var goButton="";
				goButton+="<img src=\""+webContextPath+"/resource/images/go.gif\"";
				goButton+=" title=\"执行跳转\"";
				goButton+=" onclick=\"Matrix.pagingByGoButton('"+dataGridId+"','"+paginatorId+"',"+pageCount+");\"/>";
				var imgSpan = document.getElementById(paginatorId+"_goSpan");
				if(imgSpan==null){
					imgSpan =  document.createElement("span");
					imgSpan.id=paginatorId+"_goSpan";
					imgSpan.className="goSpan";
					goSpan.appendChild(imgSpan);
					imgSpan.innerHTML = goButton;
				}else{
					imgSpan.innerHTML = goButton;
				}
			}
				*/
		}
		
		//刷新
		var refreshSpan =  document.getElementById(paginatorId+":refresh");
		if(refreshSpan){
			var refreshButton="";
			refreshButton+="<img src=\""+webContextPath+"/matrix/resource/images/paginator/refresh.png\"";
			refreshButton+=" title=\"刷新\"";
			refreshButton+=" onclick=\"Matrix.pagingByGoButton('"+dataGridId+"','"+paginatorId+"',"+pageCount+");\"/>";
			refreshSpan.innerHTML = refreshButton;
		}
		
	}
	
};

//分页跳转页数
Matrix.pagingByGoButton=function(dataGridId,paginatorId,pageCount){
    var goText = document.getElementById(paginatorId+"_goInput");
    if(goText){
    	var v = parseInt(goText.value);
		if(!isNaN(v)){
			if(v>pageCount){ v = pageCount;}
			if(v<1){ v = 1;}
			Matrix.pagingDataGridData(dataGridId,paginatorId,v);
		}
    }
}

//跳转页数
Matrix.pagingDataGridData = function(dataGridId,pageNavigatorId,pageNumber,comfirmValue){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	
	if(!(isc.isA.MatrixListGrid(_curGrid) || isc.isA.MatrixTileGrid(_curGrid))){
		return false;
	}
	
	if(_curGrid.canEdit && _curGrid.confirmDiscardEdits){
		// 判断表格是否编辑提示
		if(_curGrid.hasChanges()){
			if(!window.confirm(_curGrid.confirmDiscardEditsMessage)){
				return false;
			}
		}
	}
	
	//要找的表单元素
	var n=Matrix.getParentForm(pageNavigatorId);
	
	if(n!=null &&n.nodeType==1&&n.tagName.toUpperCase()=="FORM"){
	
		// 获得表格组件查询条件和排序属性
		var data = _curGrid.getFilterVaulesAndSortAttrObj();
		
		// 分页数据
		data[Matrix.escapeId(pageNavigatorId)+"_page"]=pageNumber;
		
		// 动态分页数据
		var dynamicPagingNum = _curGrid.dynamicPerPage;
		//if(dynamicPagingNum){
		//	data[Matrix.escapeId(dataGridId)+"_dynamic_perpage_count"]=dynamicPagingNum;
		//}
		if(dynamicPagingNum!=null){
			if(document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX)){
				document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX).value = dynamicPagingNum;
			}else{
				data[dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX]=dynamicPagingNum;
			}
			//data[Matrix.escapeId(dataGridId)+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX]=dynamicPagingNum;
		}else{
			if(document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX)){
				document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX).value = "";
			}
		}
		
		if(document.getElementById(Matrix.REFRESH_COMPONENT_IDS)){
			document.getElementById(Matrix.REFRESH_COMPONENT_IDS).value=_curGrid.name+","+pageNavigatorId+",";
		}else{
			data[Matrix.REFRESH_COMPONENT_IDS]=_curGrid.name+","+pageNavigatorId+",";
		}
		//data[Matrix.REFRESH_COMPONENT_IDS]=_curGrid.name+","+pageNavigatorId+",";
		data[Matrix.OP_GRID_ID]=_curGrid.name;
		
		// 异步刷新
		Matrix.send(n,data);
	}
};

//动态分页
Matrix.dynamicPagingDataGridData=function(dataGridId,pageNavigatorId,dynamicPagingNum){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	
	if(!(isc.isA.MatrixListGrid(_curGrid) || isc.isA.MatrixTileGrid(_curGrid))){
		return false;
	}
	
	if(_curGrid.canEdit && _curGrid.confirmDiscardEdits){
		// 判断表格是否编辑提示
		if(_curGrid.hasChanges()){
			if(!window.confirm(_curGrid.confirmDiscardEditsMessage)){
				return false;
			}
		}
	}
	
	//要找的表单元素
	var n=Matrix.getParentForm(pageNavigatorId);
	
	if(n!=null &&n.nodeType==1&&n.tagName.toUpperCase()=="FORM"){
	
		// 获得表格组件查询条件和排序属性
		var data = _curGrid.getFilterVaulesAndSortAttrObj();
		
		// 分页数据
		if(dynamicPagingNum){
		    _curGrid.dynamicPerPage = dynamicPagingNum;
			//data[Matrix.escapeId(dataGridId)+"_dynamic_perpage_count"]=dynamicPagingNum;
			if(document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX)){
				document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX).value = dynamicPagingNum;
			}else{
				data[Matrix.escapeId(dataGridId)+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX]=dynamicPagingNum;
			}
		}
		
		data[Matrix.REFRESH_COMPONENT_IDS]=_curGrid.name+","+pageNavigatorId+",";
		data[Matrix.OP_GRID_ID]=_curGrid.name;
		
		// 异步刷新
		Matrix.send(n,data);
	}
}

//显示数据表格自定义条件
Matrix.showDataGridCustomFilter=function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	_curGrid.showCustomFilter();
}

//隐藏数据表格自定义条件
Matrix.hideDataGridCustomFilter=function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	_curGrid.hideCustomFilter();
}

//构造表单自定义条件
Matrix.queryDataGridData=function(dataGridId,refresh){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	if(!(isc.isA.MatrixListGrid(_curGrid) || isc.isA.MatrixTileGrid(_curGrid))){
		return false;
	}
	
	
	if(_curGrid.canEdit && _curGrid.confirmDiscardEdits){
		// 判断表格是否编辑提示
		if(_curGrid.hasChanges()){
			if(!window.confirm(_curGrid.confirmDiscardEditsMessage)){
				return false;
			}
		}
	}
	
	var fm = Matrix.getParentForm(_curGrid.displayId);
	// 获得表格组件查询条件
	var filters = _curGrid.getFilterValuesObj();
	var filterId = dataGridId+Matrix.GRID_FILTER_FIELD_SUFFIX;
	var filterHidden = document.getElementById(filterId);
	if(filters!=null){
		var filterValue = filters[filterId];
		if(filterValue){
			if(filterHidden){
				filterHidden.value = filterValue;
			}else{
				var hidden = document.createElement("input");
				hidden.name=filterId;
				hidden.id=filterId;
				hidden.type="hidden";
				hidden.value=filterValue;
				fm.appendChild(hidden);
			}
		}else{
			if(filterHidden){
				filterHidden.value = "";
			}
		}
	}else{
		if(filterHidden){
			filterHidden.value = "";
		}
	}
	
	// 获得表格组件排序条件
	var sortValue = _curGrid.getSortAttr();
	var sortId = dataGridId+Matrix.GRID_FILTER_SORT_ATTR;
	var sortHidden = document.getElementById(sortId);
	if(sortValue!=null){
		if(sortValue){
			if(sortHidden){
				sortHidden.value = sortValue;
			}else{
				var hidden = document.createElement("input");
				hidden.name=sortId;
				hidden.id=sortId;
				hidden.type="hidden";
				hidden.value=sortValue;
				fm.appendChild(hidden);
			}
		}else{
			if(sortHidden){
				sortHidden.value = "";
			}
		}
	}else{
		if(sortHidden){
			sortHidden.value = "";
		}
	}
	var refressHidden = document.getElementById(Matrix.REFRESH_COMPONENT_IDS);
	if(refressHidden){
		//refressHidden.value = refressHidden.value+_curGrid.name+",";
		refressHidden.value = _curGrid.name+","; //只刷新当前表格
	}else{
		var hidden = document.createElement("input");
		hidden.name=Matrix.REFRESH_COMPONENT_IDS;
		hidden.id=Matrix.REFRESH_COMPONENT_IDS;
		hidden.type="hidden";
		hidden.value=_curGrid.name+",";
		fm.appendChild(hidden);
	}
	
	//动态分页值
	var dynamicPagingNum = _curGrid.dynamicPerPage;
	if(dynamicPagingNum!=null){
		if(document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX)){
			document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX).value = dynamicPagingNum;
		}else{
			var hidden = document.createElement("input");
			hidden.name=dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX;
			hidden.id=dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX;
			hidden.type="hidden";
			hidden.value=dynamicPagingNum;
			fm.appendChild(hidden);
		}
	}else{
		if(document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX)){
			document.getElementById(dataGridId+Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX).value = "";
		}
	}
	
	if(refresh){
		// 异步刷新
		Matrix.send(fm);
		return false;
	}
	
	return true;
}

// 导出数据
Matrix.exportDataGridData=function(dataGridId,exportType){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	
	if(!isc.isA.MatrixListGrid(_curGrid)){
		return false;
	}
	
	// 设置导出文件类型
	if(exportType){
		var exportTypeId = dataGridId+"_custom_export_type";
		var exportTypeEle = document.getElementById(exportTypeId); 
		if(exportTypeEle){
			exportTypeEle.value = exportType;
		}else{
			var fm = Matrix.getParentForm(_curGrid.displayId);
			if(fm){
				exportTypeEle = document.createElement("input");
				exportTypeEle.id=exportTypeId;
				exportTypeEle.name=exportTypeId;
				exportTypeEle.type="hidden";
				exportTypeEle.value = exportType;
				fm.appendChild(exportTypeEle);
			}
		}
	}
	
	// 弹出设置导出窗口
	var windowId = dataGridId+"_custom_export_window";
	var _win = Matrix.getMatrixComponentById(windowId);
	if(_win){
		_win.show();
	}else{
		var submitID = Matrix.getMatrixComponentId(dataGridId+"_custom_export_btn");
		var cancelID = Matrix.getMatrixComponentId(dataGridId+"_custom_export_btn_cancel");
		var contentID = Matrix.getMatrixComponentId(dataGridId+"_custom_export_content");
		var cellID = Matrix.getMatrixComponentId(dataGridId+"_custom_export_cell");
		var allCellID = Matrix.getMatrixComponentId(dataGridId+"_custom_export_all_cell");
		var winID = Matrix.getMatrixComponentId(windowId);
		_win = isc.Window.create({ID:winID,title:"导出列设置",autoCenter:true,isModal:true,
			autoDraw:false,height:400,width:550,canDragResize:true,
			items: [
				isc.HStack.create({ID:contentID,membersMargin:2,align:'center',layoutAlign:'center',autoDraw:false,width:'100%',
					members:[
						isc.MatrixPartsListGrid.create({ID:allCellID,width:'47%',height:"100%",
							recordDoubleClick:cellID+".transferSelectedData("+allCellID+")",
							fields:[{name:"title"}],
							data:[],
							panelID:winID,dragDataAction: "move"}),
						isc.VStack.create({width:'3%', height:74, align:'center',layoutAlign:'center', membersMargin:10, 
							members:[
								isc.Button.create({title:'>>', width:30,
									click:cellID+".getData().addList("+allCellID+".getData());"+allCellID+".setData([]);"}),
								isc.Button.create({title:'>', width:30,
									click:cellID+".transferSelectedData("+allCellID+")"}),
								isc.Button.create({title:'<', width:30,
									click:allCellID+".transferSelectedData("+cellID+")"}),
								isc.Button.create({title:'<<', width:30,
									click:allCellID+".getData().addList("+cellID+".getData());"+cellID+".setData([]);"})
							]
						}),
						isc.MatrixPartsListGrid.create({ID:cellID,width:'47%',data:[],
							recordDoubleClick:allCellID+".transferSelectedData("+cellID+")",height:"100%",
							fields:[{name:"title"}],
							panelID:winID})
						]
				})
			],
			showFooter:true,footerHeight:20,
			footerControls:[
				isc.HTMLFlow.create({width:'30%',contents:"&nbsp;"}),
				isc.Button.create({ID:submitID,title:"导出",autoDraw:false,click:"Matrix.exportDataGridDataSubmit('"+dataGridId+"')"}),
				isc.HTMLFlow.create({width:'5%',contents:"&nbsp;"}),
				isc.Button.create({ID:cancelID,title:"取消",autoDraw:false,click:winID+".hide()"}),
				isc.HTMLFlow.create({width:'30%',contents:"&nbsp;"})
			]
		});
		if(_curGrid.exportCells){
			var allCellGrid = eval(allCellID);
			if(allCellGrid){
				allCellGrid.setData(_curGrid.exportCells);
			}
		}
		_win.show();
	}
	return false;
}

// 确认导出数据
Matrix.exportDataGridDataSubmit=function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	
	if(!isc.isA.MatrixListGrid(_curGrid)){
		return false;
	}
	
	// 导出类型
	var exportType=null;
	var exportTypeEle = document.getElementById(dataGridId+"_custom_export_type");
	if(exportTypeEle){
		exportType = exportTypeEle.value;
	}
	
	// 获得导出列
	var exportCell = "";
	var exportCellComponent = Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId+"_custom_export_cell"));
	if(exportCellComponent){
		var exportData = exportCellComponent.getData();
		if(exportData){
			for(var _index=0;_index<exportData.length;_index++){
				var data = exportData[_index];
				if(data==null){
					continue;
				}
				if(exportCell==""){
					exportCell = data.id;
				}else{
					exportCell += ","+data.id;
				}
			}
		}else{
			exportCell = null;
		}
	}
	
	var fm = Matrix.getParentForm(_curGrid.displayId);
	if(fm){
		// 设置查询条件
		Matrix.queryDataGridData(dataGridId);
		
		var fmAction = fm.action;
		if(fm.action.indexOf("?")==-1){
			fm.action += "?export_data_grid_id="+dataGridId;
		}else{
			fm.action += "&export_data_grid_id="+dataGridId;
		}
		if(exportType){
			fm.action += "&export_data_grid_type="+exportType;
		}
		if(exportCell && exportCell!=""){
			fm.action += "&export_data_grid_cells="+exportCell;
		}
		Matrix.submitForm(fm.id);
		fm.action = fmAction;
	}
	var _win = Matrix.getMatrixComponentById(dataGridId+"_custom_export_window");
	if(_win){
		_win.hide();
	}
	return false;
}

// 清除表格排序条件
Matrix.clearDataGridSort=function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return false;
	}
	_curGrid.clearSortAttr();
	return true;
}

/***** list grid end *****/

/***** menu *****/
// 刷新树节点
Matrix.refreshTreeNode = function(target,item,menu,colNum){
	var curTree = eval(target.$42c);
	if(curTree){
		curTree.refreshTreeNode(target);
	}
}

// 下移树节点
Matrix.moveDownTreeNode = function(target,item,menu,colNum){
	var curTree = eval(target.$42c);
	if(curTree){
		curTree.moveTreeNode(target,"movedown");
	}
}

// 上移树节点
Matrix.moveUpTreeNode = function(target,item,menu,colNum){
	var curTree = eval(target.$42c);
	if(curTree){
		curTree.moveTreeNode(target,"moveup");
	}
}

// 删除树节点
Matrix.removeUpTreeNode = function(target,item,menu,colNum){
	var curTree = eval(target.$42c);
	if(curTree){
		curTree.removeTreeNode(target);
	}
}

// 刷新树节点
Matrix.forceFreshTreeNode = function(treeId,nodeId){
	if(treeId && nodeId){
		var curTreeGrid = Matrix.getMatrixComponentById(treeId);
		if(curTreeGrid){
			curTreeGrid.refreshTreeNodeByNodeId(nodeId);
		}
	}
}
/***** menu end *****/

/***** window *****/

var href=window.location.href;
var iframewindowid;
var idkey="iframewindowid";
if(href.indexOf(idkey)!=-1){
	  href=href.substring(href.indexOf(idkey)+(idkey+"=").length);
	  if(href.indexOf("&")!=-1){
		iframewindowid=href.substring(0,href.indexOf("&"));
	  }
	  else{
		iframewindowid=href;
	  }     	  
}

Matrix.closeWindow = function(data,operationType){
	if(!iframewindowid){
		iframewindowid = document.getElementById("iframewindowid")?document.getElementById("iframewindowid").value:null;
	}
	if(iframewindowid){
		var win = Matrix.getMatrixComponentById(iframewindowid);
		var isParentWin = false;
		
		//从父窗口中找
		if(win==null || !win.isVisible()){
			isParentWin = true;
			win = Matrix.getTopWindow(window.parent,iframewindowid);
			//win = parent.Matrix.getMatrixComponentById(iframewindowid);
		}

		if(win!=null){
			var closeFunction;
			if(win.agencyWindow!=null){
				//页面窗口已指定
				var agencyWindow = win.agencyWindow;
				closeFunction = eval("agencyWindow.on"+win.agencyDialogId+"Close");
			}else{
				if(isParentWin){
					closeFunction = eval("parent.on"+iframewindowid+"Close");
			}else{
					closeFunction = eval("window.on"+iframewindowid+"Close");
				}
			}

			if(closeFunction){
			   var result = closeFunction(data,operationType);
			   if( result == null || result == true){
			   	 if(win.isVisible()){
					 win.hide();
			   	 }
			   }
			}else{
				if(win.isVisible()){
					 win.hide();
			   	 }
			}
		}
	}
}

Matrix.closeWindowById = function(winId,data,operationType){
	if(winId){
		var win = Matrix.getMatrixComponentById(winId);
		if(win!=null){
			var closeFunction;
			if(win.agencyWindow!=null){
				//页面窗口已指定
				var agencyWindow = win.agencyWindow;
				closeFunction = eval("agencyWindow.on"+win.agencyDialogId+"Close");
			}else{
				closeFunction = eval("window.on"+winId+"Close");
			}
			if(closeFunction){
			   var result = closeFunction(data,operationType);
			   if( result == null || result == true){
			   	 if(win.isVisible()){
				 	win.hide();
				 }
			   }
			}else{
			   	 if(win.isVisible()){
					win.hide();
				 }
			}
		}
	}
}

Matrix.showWindow = function(windowId){
	var win = Matrix.getMatrixComponentById(windowId);
	if(win){
		/*
		var src = win.getInitSrc();
		if(win.initSrc){
			var src = win.initSrc;
			var params = "";
			if(win.getParamsFun){
				params = win.getParamsFun();
			}
			if(src.indexOf("?")!=-1){
				src+="&"+params;
			}else{
				src+="?&"+params;
			}
			win.setSrc(src);
		}
		win.setSrc(src);
		*/
		Matrix.clearWindow(win);
		win.isMatrixWindow = true;
		win.show();
	}
}

Matrix.clearWindow = function(mwindow){
	if(mwindow){
		if(mwindow.isShowed){
			if(mwindow.targetWin){
				mwindow.targetWin.clear();
			}else{
				mwindow.clear();
			}
		}
	} 
}

Matrix.getTopWindow = function(frame,windowId){
	if(frame!=null){
		if(frame.Matrix!=null){
		 	var dialog = frame.Matrix.getMatrixComponentById(windowId);
		 	if(dialog!=null){
		 		return dialog;
		 	}else{
		 		if(frame==top){
		 			return null;
		 		}
		 		return Matrix.getTopWindow(frame.parent,windowId);
		 	}
		}else{
			if(frame==top){
	 			return null;
	 		}
	 		return Matrix.getTopWindow(frame.parent,windowId);
		}
	}
	return null;
}

Matrix.submitWindow = function(form){
	var data = null;
	if(form!=null){
		data = Matrix.formToObject(form);
		Matrix.closeWindow(data);
	}else{
		Matrix.closeWindow(data);
	}
	return false;
}

/***** window end *****/

/***** img *****/
// 自动缩放ISC图片
Matrix.autoDrawISCImg=function(image){
	if(image){
		var canvasName = image.getCanvasName();
		var imgName = canvasName+image.name;
		var img = Matrix.getElementByName(imgName);
		if(img){
			Matrix.autoDrawImage(img,image.width,image.height);
		}
	}
}

// 自动缩放图片
Matrix.autoDrawImage = function(imgd,iwidth,iheight){
	try{
		var image=new Image();
		image.src=imgd.src;
		if(image.width>0 && image.height>0){
			if(image.width/image.height>= iwidth/iheight){
				if(image.width>iwidth){ 
					imgd.width=iwidth;
					imgd.height=(image.height*iwidth)/image.width;
				}else{
					imgd.width=image.width; 
					imgd.height=image.height;
				}
			}else{
				if(image.height>iheight){ 
					imgd.height=iheight;
					imgd.width=(image.width*iheight)/image.height; 
				}else{
					imgd.width=image.width; 
					imgd.height=image.height;
				}
			}
		}
		//imgd=image;
	}catch(e){}
} 
/***** img end *****/

/******** custom ajax *********/
// 自定义发送异步请求
/*
 *@actionResourceId: 事件源编码
 *@content: 自定义json数据，如：{item1:123,item2:'value2',item3:false}
 *@callbackFun：回调函数，如不设置默认调用Matrix.customAjaxCallbackFun
 *@errorFun：出错调用函数，如不设置默认调用直接弹出提示
 *@method：请求方式，POST、GET等，默认POST
*/
Matrix.customAjaxSend = function(actionResourceId,content,callbackFun,errorFun,method){
	
	var data = {};
	
	// 构造页面流跳转需要参数
	if(actionResourceId){
		Matrix.setJsonValue(data,Matrix.ACTION_SOURCE_ID_KEY,actionResourceId);
	}else{
		return false;
	}
	
	var viewState = document.getElementById("javax.faces.ViewState");
	if(viewState){
		viewState = viewState.value;
		if(viewState){
			//Matrix.setJsonValue(data,"javax.faces.ViewState",viewState);
		}
	}
	var url;
	var currentPageId = document.getElementById(Matrix.PAGE_ID_KEY);
	if(currentPageId){
		currentPageId = currentPageId.value;
		if(currentPageId){
			Matrix.setJsonValue(data,Matrix.PAGE_ID_KEY,currentPageId);
			//url = webContextPath+"/"+currentPageId+".page";
			url = webContextPath+"/flowdo.flow";
		}
	}
	if(url==null || url==""){
		return;
	}
	
	var currentFlowId = document.getElementById(Matrix.PAGE_FLOW_ID_KEY);
	if(currentFlowId){
		currentFlowId = currentFlowId.value;
		if(currentFlowId){
			Matrix.setJsonValue(data,Matrix.PAGE_FLOW_ID_KEY,currentFlowId);
		}
	}
	
	var currentPageDefId = document.getElementById(Matrix.PAGE_DEF_ID_KEY);
	if(currentPageDefId){
		currentPageDefId = currentPageDefId.value;
		if(currentPageDefId){
			Matrix.setJsonValue(data,Matrix.PAGE_DEF_ID_KEY,currentPageDefId);
		}
	}
		
	data["continueflow"]="true";
	
	data[Matrix.CUSTOM_AJAX_FLAG_KEY]="true";//自定义ajax请求标识
	
	data[Matrix.AJAX_REQUEST_KEY]=Matrix.AJAX_REQUEST_VALUE;
	
	// 整合自定义数据
	if(content){
		for(var name in content){
			var value = content[name];
			Matrix.setJsonValue(data,name,value);
		}
	}
	
	method=method?method:"POST";
	callbackFun=callbackFun?callbackFun:Matrix.customAjaxCallbackFun;
	RPCManager.sendRequest({params:data,callback:callbackFun,handleError:errorFun,httpMethod:method,actionURL:url});
	return false;
}

// 自定义异步请求默认回调方法
Matrix.customAjaxCallbackFun=function(data){
	if(data){
		if(data.data){
			try{eval(data.data);}catch(error){}
		}
	}
}
/******** custom ajax end *********/

/******** comboBox relation ajax *********/
Matrix.comboBoxRelationAjaxSend=function(comboBoxId,initflag){
	var _comboBox = Matrix.getMatrixComponentById(comboBoxId);
	var _form = Matrix.getParentForm(_comboBox.displayId);
	var data={};
	data[comboBoxId+"_event"]="changed";
	data["matrix_main_combobox_id"]=comboBoxId;
	data["matrix_immediate_flag"]="true";
	
	var refressHidden = document.getElementById(Matrix.REFRESH_COMPONENT_IDS);
	if(refressHidden){
		refressHidden.value = comboBoxId+","; //指定只刷新当前组件
	}else{
		data[Matrix.REFRESH_COMPONENT_IDS]=comboBoxId+","; //指定只刷新当前组件
	}
	if(initflag!=null)
		data[comboBoxId+"_initflag"]=initflag;
	Matrix.send(_form,data);
}
/******** comboBox relation ajax end *********/

//显示loading
Matrix.showThrobber=function(_1,_2){
	var _6 = document.getElementById("loading");
	if(!_6){
		return;
	}
	_6.style.display="";
	_6.className="loading";
	_6.style.zIndex=9999999999999;
	/*
	_6.style.position="absolute";
	_6.style.left="0";_6.style.top="0";
	_6.style.width="100%";
	_6.style.height="100%";
	*/
	var _7=document.createElement("TABLE"),_8=document.createElement("TBODY"),_9=document.createElement("TR");
	_7.height="30";
	_7.width="100";
	_7.style.position="absolute";
	_7.style.left="50%";_7.style.top="50%";
	var _10=document.createElement("TD"),_11=document.createElement("IMG");
	if(_2){
		_2 = isc.Page.getImgURL(_2);
	}else{
		_2 = isc.Page.getImgURL("[SKIN]/loadingSmall.gif");
	}
	_11.src=_2;
	_10.appendChild(_11);
	_9.appendChild(_10);
	if(_1){
		var _12=document.createTextNode(_1);
		_10=document.createElement("TD");
		_10.className=_2;
		_10.appendChild(_12);
		_9.appendChild(_10)
	}else{
		var _12=document.createTextNode("请稍等...");
		_10=document.createElement("TD");
		_10.appendChild(_12);
		_9.appendChild(_10)
	}
	_8.appendChild(_9);
	_7.appendChild(_8);
	_6.appendChild(_7);
};
//隐藏loading
Matrix.hideThrobber=function(){
	var _6 = document.getElementById("loading");
	if(_6){
		_6.style.display="none";
	}
};

//获得操作按钮图片路径
Matrix.getActionIcon=function(action,type){
	if(action!=null){
		if(type==null){
			type=".png";
		}
		return Matrix.getSkinIcon("/matrix/actions/"+action+type);
	}
	return "";
}
//获得组件图片路径
Matrix.getComponentIcon=function(component,type){
	if(component!=null){
		if(type==null){
			type=".png";
		}
		return Matrix.getSkinIcon("/matrix/component/"+component+type);
	}
	return "";
}
//获得树节点图片路径
Matrix.getTreeNodeIcon=function(node,type){
	if(node!=null){
		if(type==null){
			type=".png";
		}
		return Matrix.getSkinIcon("/matrix/tree/"+node+type);
	}
	return "";
}
//获得风格下的图片路径
Matrix.getSkinIcon=function(url){
	if(url!=null){
		if(!url.startWith("/")){
			url = "/"+url;
		}
		return isc.Page.getImgURL("[SKIN]"+url);
	}
	return "";
}


Matrix.resetComponentProperty=function(mitem){
	// 重置组件属性
	if(mitem!=null){
		
		var attrName = mitem.attrName;
		var attrValue = mitem.getValue();
		if(attrValue==null){
			attrValue = "";
		}
		
		//判断组件如未修改则返回
		/*
		if(mitem.mvalue==attrValue){
			return false;
		}else{
			mitem.mvalue=attrValue;
		}
		*/
		if(!Matrix.validateComponentFieldProperty(mitem)){
			return false;
		}
		var componentType = document.getElementById("componentType");
		if(componentType!=null){
			componentType = componentType.value;
		}
		var data = {};
		data["attrName"] = attrName;
		data["attrValue"] = attrValue;
		data["componentType"] = componentType;
		data["command"] = "updateAttribute";
		Matrix.sendRequest(webContextPath+"/designer.daction",data);
	}
};
Matrix.validateComponentFieldProperty=function(mitem){
	// 验证属性输入值
	var mform = mitem.form;
	var merrors = {};
	var msuccesss = true;
	if(mitem && mform){
		var unkonwnError={unknownErrorMessage:mform.unknownErrorMessage,serverValidationMode:"full"};
		var result=mform.validateField(mitem,mitem.validators,mitem.getValue(),mform.getValues(),unkonwnError);
		if(result!=null){
			if(result.errors!=null){
				if(isc.isA.RadioItem(mitem) && mitem.ID){
					mform.addValidationError(merrors,mitem.ID,result.errors);
				}else{
					mform.addValidationError(merrors,mitem.name,result.errors);
				}
				msuccesss = false;
			}
		}
		mform.setErrors(merrors);
		mform.showErrors(merrors,{});
	}
	return msuccesss;
}


//-----------------接口--------------------
//获得页面组件
Matrix.getComponentById=function(componentId){
	if(componentId!=null){
		var com = Matrix.getMatrixComponentById(componentId);
		if(com!=null){
			return com;
		}
		com = document.getElementById(componentId);
		if(com!=null){
			return com;
		}
	}
	
	return null;
};

//隐藏组件
Matrix.hideComponent=function(componentId){
	var com = Matrix.getComponentById(componentId);
	if(com){
		var displayId = component.displayId;
		if(displayId!=null){
			var disDiv = document.getElementById(displayId);
			if(disDiv){
				disDiv.style.display = "none";
			}else{
				if(com.hide){
					com.hide();
				}
			}
		}else{
			if(com.hide){
				com.hide();
			}
		}
	}else{
		com = document.getElementById(componentId);
		if(com){
			com.style.display = "none";
		}
	}
};

//显示组件
Matrix.showComponent=function(componentId){
	var com = Matrix.getComponentById(componentId);
	if(com){
		var displayId = component.displayId;
		if(displayId!=null){
			var disDiv = document.getElementById(displayId);
			if(disDiv){
				disDiv.style.display = "";
			}else{
				if(com.show){
					com.show();
				}
			}
		}else{
			if(com.show){
				com.show();
			}
		}
	}else{
		com = document.getElementById(componentId);
		if(com){
			com.style.display = "";
		}
	}
};

//获得表单元素值
Matrix.getFormItemValue=function(formItemId){
	var com = Matrix.getComponentById(formItemId);
	if(com){
		if(com.form && isc.isA.MatrixForm(com.form)){
			return Matrix.convertNullValue(com.form.getValue(formItemId));
		}
		return Matrix.convertNullValue(com.value);
	}
	return null;
};

//设置表单元素值
Matrix.setFormItemValue=function(formItemId,value){
	var com = Matrix.getComponentById(formItemId);
	if(com){
		if(com.form && isc.isA.MatrixForm(com.form)){
			com.form.setValue(formItemId,value);
		}else{
			com.value = value;
		}
		
	}
};

//获得组件所在的表单对象
Matrix.getFormOfComponent=function(componentId){
	var com = Matrix.getComponentById(componentId);
	if(com){
		if(com.displayId){
			return Matrix.getParentForm(com.displayId);
		}
	}
	return Matrix.getParentForm(componentId);
};

//获得数据表格选中记录
Matrix.getDataGridSelection=function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return null;
	}
	return _curGrid.getSelection();
};

//获得数据表格选中记录
Matrix.getAllDataGridData=function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格。");
		return null;
	}
	return _curGrid.getData();
};

//刷新数据表格
Matrix.refreshDataGridData=function(dataGridId){
	Matrix.queryDataGridData(dataGridId,true);
};

//字符串转JSON
Matrix.jsonDecode=function(value){
	if(value!=null && value.trim().length>0){
		value = isc.JSON.decode(value);
	}
	return value;
};

//JSON转字符串
Matrix.jsonEncode=function(value){
	if(value!=null && value.trim().length>0){
		value = isc.JSON.encode(value);
	}
	return value;
};

//提示信息窗口
Matrix.say=function(message){
	isc.say(message);
}

//警告窗口
Matrix.warn=function(message){
	isc.warn(message);
}

//确认窗口
Matrix.confirm=function(message,callback,properties){
	// callback param is result
	// properties eg: { buttons : [Dialog.OK, Dialog.CANCEL] }
	isc.confirm(message,callback,properties);
}

Matrix.validateDataGridSelection=function(dataGridId){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		isc.warn("非法数据表格！");
		return false;
	}
	if(_curGrid.getSelection()==null || _curGrid.getSelection().length==0){
		isc.warn("没有选中表格数据！");
		return false;
	}
	return true;
}

Matrix.getDataGridSelectionRecordProperty=function(dataGridId,property){
	var _curGrid;
	_curGrid=Matrix.getMatrixComponentById(Matrix.escapeId(dataGridId));
	if(_curGrid==null){
		return null;
	}
	if(_curGrid.getSelection()==null || _curGrid.getSelection().length==0){
		return null;
	}
	var record = _curGrid.getSelection()[0];
	if(record){
		return record[property];
	}
	return null;
}

/*******************************offline*************************************/
//离线导出表单html
Matrix.goOffline=function(){
     var mform = Matrix.getParentForm('matrix_form_tid');
     var oldAction = mform.action;
     mform.action=webContextPath+"/FormOfflineServlet";
     mform.submit();
     mform.action=oldAction;
     return false;
}

//离线保存数据-指定编码
Matrix.offlineSave=function(isFile){
	if(isFile!=false){
		isc.askForValue("请指定表单离线数据存储的编码",
			"Matrix.offlineSaveSubmit(value)",{title:"&nbsp;",width:300});
	}else{
		isc.askForValue("请指定表单离线数据存储的编码",
			"Matrix.offlineSaveSubmit(value,false)",{title:"&nbsp;",width:300});
	}
     return false;
}

//离线保存数据
Matrix.offlineSaveSubmit=function(key,isFile){	
	if(key==null){
        return false;
    }
    var ftid = document.getElementById("matrix_form_tid").value;
    if(key.trim().length==0){
        key = ftid;
    }
	var mform = Matrix.getParentForm('matrix_form_tid');
    var formObj = Matrix.formToObject(mform);            
	var formId = mform.name;
    //处理表单中表格数据
	var gridIds = Matrix.getDataGridIdsHiddenOfForm(formId)?Matrix.getDataGridIdsHiddenOfForm(formId).value:null;
	if(gridIds!=null && gridIds.trim().length>0){
		var gridDatas = new Array();
		gridIds = gridIds.split(",");
		for(var i=0;i<gridIds.length;i++){
			var gridId = gridIds[i];
			if(gridId!=null && gridId.trim().length>0){
				var dataGrid = Matrix.getMatrixComponentById(gridId);
				if(dataGrid.canEdit){
				    var gridData = {};
					gridData.gridId = gridId;
				    Matrix.saveDataGridData(gridId); 
					// 新增数据
					//gridData.insertRows = dataGrid.insertItems;
					
					var datas = dataGrid.getData();
					var newDatas = new Array();
					if(datas!=null && datas.length>0){
						for(var j=0;j<datas.length;j++){
							var data = datas[j];
							if(data){
								var newData = {};
								for(p in data){
									if(dataGrid.getField(p)){
										newData[p] = data[p];
									}																		
								}
								newDatas.add(newData);
							}
						}
					}
					gridData.insertRows = newDatas;
					gridDatas.add(gridData);
				}
			}
		}
		formObj.gridDatas = gridDatas;
	}
	if(isFile!=false){
		//写入离线文件
		var filePath = Matrix.getLocalPath();
		filePath = filePath.replace(filePath.substring(filePath.indexOf("/form/")),"/data/");
		Matrix.writeFile(isc.JSON.encode(formObj),filePath,key);
	}else{
		isc.Offline.put(key,isc.JSON.encode(formObj));
	}	         
	return false;
}

//恢复离线保存数据-指定编码
Matrix.onlineRestore=function(isFile){
	  if(isFile!=false){
	   isc.MatrixWindow.create({
			ID:"matrixOfflineRestoreFileWindow",
		    title:"指定要恢复的离线数据",
		    width:280,
		    height:120,
		    autoCenter: true,
		    isModal: true,		
		    showModalMask: false,
			modalMaskOpacity:0,
		    autoDraw: false,
		    closeClick:function () {
		    	this.Super("closeClick", arguments);
		    },
		    items: [
		    	isc.VLayout.create({
		    		width: "100%",
		    		height: "100%",
		   			members:[
					   isc.DynamicForm.create({
							autoDraw: false,
							width:"100%",
							padding:10,
							align:"left",
							fields: [
								  {ID:"MatrixOfflineRestoreFile",title:"文件",titleAlign:"left",editorType:"text",width:210}
							]
						}),
				        isc.HLayout.create({
				            padding:10,
		    				membersMargin: 10,
		    				align:"center",
				        	members:[
				        		 isc.IButton.create({
		            				type: "button",width:50,title:"确认",click:function(){
										var filePath = MatrixOfflineRestoreFile.getValue();
										if(filePath==null || filePath.trim().length==0){
											isc.warn("请指定要恢复的离线数据文件！");
											return false;
										}
		            					matrixOfflineRestoreFileWindow.hide();
		            					Matrix.onlineRestoreSubmit(filePath,isFile);
		            				}
		        				 }),
				        		 isc.IButton.create({
		            				type: "button",width:50,title:"取消",click: "matrixOfflineRestoreFileWindow.hide();"
		        				 })
				        	]
				        })
		        	]
		        })
		    ]
			
		});

		matrixOfflineRestoreFileWindow.show();
	  }else{
		 isc.askForValue("请指定要恢复表单离线数据存储的编码",
			"Matrix.onlineRestoreSubmit(value,false)",{title:"&nbsp;",width:300});		
	  }
		
      
      return false;
}

//恢复离线保存数据
Matrix.onlineRestoreSubmit=function(key,isFile){
   var formObj = null;
   if(isFile!=false){
	    //读入离线文件
		formObj = Matrix.readFile(key);
   }else{
		if(key==null || key.trim().length==0){
			 key = document.getElementById("matrix_form_tid").value;
			 if(key==null || key.trim().length==0){
					Matrix.warn("表单离线数据存储的编码为空，操作失败！");
					return false;
			 }
		}
		formObj = isc.JSON.decode(isc.Offline.get(key));
   }	
	
	if(formObj!=null){
		if(isc.isA.String(formObj))formObj = isc.JSON.decode(formObj);
		for(i in formObj){
			if(i=="gridDatas"){
				var gridDatas = formObj.gridDatas;
				if(gridDatas!=null && gridDatas.length>0){
					for(var j=0;j<gridDatas.length;j++){
						var gridData = gridDatas[j];
						if(gridData && gridData.gridId && gridData.insertRows){
							var dataGrid = Matrix.getMatrixComponentById(gridData.gridId);
							dataGrid.setData(gridData.insertRows);
						}
					}
				}
			}else if(isc.isAn.Array(formObj[i])){
				Matrix.setFormItemValue(i,formObj[i][0]);
			}else{
				Matrix.setFormItemValue(i,formObj[i]);
			}
	 	}
	}
    return false;
}

//读文件
Matrix.readFile=function(fileFullName){
	if(!isc.Browser.isIE){
		isc.warn("读文件功能只支持IE浏览器！");
		return null;
	}
	if (Matrix.fileExists(fileFullName)){
       var fso, f;
       fso = new ActiveXObject("Scripting.FileSystemObject");
       f = fso.OpenTextFile(fileFullName, 1);
       var str = f.ReadAll();
       f.Close();
       return (str);
	}else{
	  isc.warn("文件#["+fileFullName+"]不存在！");
	  return null;
	}
}

//写文件
Matrix.writeFile=function(fileContent,filePath,fileName,fileType){
	if(!isc.Browser.isIE){
		isc.warn("写文件功能只支持IE浏览器！");
		return false;
	}
	if(fileName==null || fileName.trim().length==0){
		isc.warn("文件名称！");
		return false;
	}
	if(fileType==null){
		fileType = "txt";
	}
	var fileFullName = filePath+fileName+"."+fileType;
	var isExists = Matrix.fileExists(fileFullName);
	var result = true;
	var fso, f;
	if(isExists){
		var message = "文件#["+fileFullName+"]已经存在,是否覆盖？";
		isc.confirm(message,
			function(value){
				if(value){
					fso = new ActiveXObject("Scripting.FileSystemObject");
			        f = fso.OpenTextFile(fileFullName, 2, true);
			        f.Write(fileContent);
			        f.Close();
				}else{
					result = false;
				}
			}			
		);
	}else{
		fso = new ActiveXObject("Scripting.FileSystemObject");
        f = fso.OpenTextFile(fileFullName, 2, true);
        f.Write(fileContent);
        f.Close();
	}
    return result;
}

//判断文件是否存在
Matrix.fileExists=function(fileFullName){
    //文件是否存在
    if(!isc.Browser.isIE){
		isc.warn("判断文件是否存在功能只支持IE浏览器！");
		return false;
	}
    var fso, exis;
    fso = new ActiveXObject("Scripting.FileSystemObject");
    exis=fso.FileExists(fileFullName);
    return exis;
}

//获得当前文件路径
Matrix.getLocalPath=function getlocal(){
    //得到本地路径
    var temp = window.location+"";
    temp = temp.substr(8);
    temp=temp.split("/")
    temp.pop()
    var str=temp.join("/")+"/"
    return str
}
/*******************************offline*************************************/






//校验文件大小
Matrix.validateFileSize=function(target, vId, maxSize){
	 var fileSize = 0;
        var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
        if (isIE && !target.files) {
            var filePath = target.value;
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            if (!fileSystem.FileExists(filePath)) {
                var file = document.getElementById(vId);
                file.outerHTML = file.outerHTML;
                return false;
            }
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;
        } else {
            fileSize = target.files[0].size;
        }
        var size = fileSize / (1024 * 1024);
        if (size > maxSize) {
            isc.warn("附件大小不能大于"+maxSize+"M!");
                var file = document.getElementById(vId);
                file.outerHTML = file.outerHTML;
            return false;
        }
        if (size <= 0) {
            isc.warn("附件大小不能为0M！");
            var file = document.getElementById(vId);
            file.outerHTML = file.outerHTML;
            return false;
        }
        return true;
	}

//显示消息提示
 Matrix.showMessage=function showMessage(message,timeoutValue){
	document.getElementById("msgdiv").style.display='';
	//head
	var html = "<div style=height:30px;width:300px;background-color:#e9e9e9;><span style=float:left;padding-left:5px;line-height:30px;>消息提醒</span><a id='aClose' style=width:32px;text-align:center;float:right;padding-right:0px;line-height:30px;text-decoration:none; href='javascript:Matrix.exitView();' title='关闭'>X</a></div>";
	
	//body
	html+="<div id='msgBody' style='width:300px;height:140px;text-align:center;'><p style='margin:0 auto;width:260px;word-break: break-all;color:blue;text-align:left;'>"+message+"</p></div>";
	document.getElementById("msgdiv").innerHTML=html;

	//消息提示框显示之后执行淡出方法
	if( timeoutValue && timeoutValue>0 && document.getElementById('msgdiv').style.display==''){
		//10秒之后淡出
		setInterval("Matrix.fadeOut();",timeoutValue);
		//淡出之后清空消息
		//document.getElementById('message').value='';
	}
 }

var val = 100;

Matrix.fadeOut=function fadeOut(){
    var speed =  200;//0.2秒调用一次本方法
    var opacity =  0;//初始化透明度变化值为0
    //提示框对象
    var div = document.getElementById('msgdiv');
	div.filters ? div.style.filter = 'alpha(opacity=' + val + ')' : div.style.opacity = val / 100;
    //循环将透明值以5递减,即淡出效果
	val -= 5;
    if (val >= opacity) {
		//定时调用fadeOut方法
        setTimeout(arguments.callee, speed);
    }else if (val < 0) {
		//元素透明度为0后隐藏元素
		//var elem = document.getElementById('divId');
        div.style.display = 'none';
	val = 100;
    } 
 }

Matrix.exitView=  function exitView(){	
	document.getElementById("msgdiv").style.display="none";
	//点击按钮之后 清空message中的值
	//document.getElementById("message").value='';
 }

