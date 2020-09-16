  
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
Matrix.ACTION_SOURCE_ID_KEY = "matrix_command_id";
Matrix.PAGE_ID_KEY="matrix_current_page_id";
Matrix.PAGE_DEF_ID_KEY="matrix_current_page_def_id";
Matrix.PAGE_FLOW_ID_KEY="matrix_current_page_flow_id";
Matrix.CUSTOM_AJAX_FLAG_KEY="matrix_custom_ajax_flag";
Matrix.GRID_DYNAMIC_PREPAGE_SUFFIX="_dynamic_perpage_count";

/***** validator start *****/
//中文、字母、数字、-、_
Matrix.CNNameRegExp = /^[a-zA-Z0-9_\u4e00-\u9fa5\-]+$/;
// 字母、数字、-、_
Matrix.ENNameRegExp = /^[a-zA-Z0-9_\-]+$/;
// 数字
Matrix.NumberRegExp = /^[0-9]*$/;

//邮箱
Matrix.validateEmail = function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	if(reg.test(str)) return true;
	return false;
};

//邮政编码
Matrix.validatePostCode = function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = /^\d{6}$/;
	if(reg.test(str)) return true;
	return false;
};

//手机号
Matrix.validateMobileTelephone=function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])[0-9]{8}$/;
	if(reg.test(str) && str.length==11) return true;
	return false;
};

//身份证
Matrix.validateIdentityCard=function(str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	//var reg = /^\d{15}(\d{2}[0-9X])?$/;
	var reg = /(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|(\d|X)?)$)/;
	if(reg.test(str)) return true;
	return false;
};

//正则表达式
Matrix.validateRegexp = function(regexp,str){
	if(str==null || str.trim().length==0) return true;
	if(regexp==null){
		return true;
	}
	str = str.trim();
	return regexp.test(str);
};

//精度
Matrix.validatePrecision=function(precision,str){
	if(str==null || str.trim().length==0) return true;
	str = str.trim();
	var reg = new RegExp("^\\d*\\.\\d{"+precision+"}$");
	if(reg.test(str)) return true;
	return false;
};

//长度
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

//验证非负整数(正整数 + 0)
Matrix.validateLong=function(str){
	if(str==null || (((typeof str) =='string') && str.trim().length==0)) return true;
	if((typeof str) =='string')
		str = str.trim();
	var reg=/^\d+$/;
	if(reg.test(str)) return true;
	return false;
};

//验证小数
Matrix.validateDouble=function(str){
	if(str==null || (((typeof str) =='string') && str.trim().length==0)) return true;
	if((typeof str) =='string')
		str = str.trim();
	var reg = /^\d*\.?\d*$/;
	if(reg.test(str)) return true;
	return false;
};

//验证非负整数(正整数 + 0)的范围
Matrix.validateLongRange = function(minValue,maxValue,str){
	if(str==null || (((typeof str) =='string') && str.trim().length==0)) return true;
	if((typeof str) =='string')
		str = str.trim();
	if(!Matrix.validateLong(str)) return false;
	var value = parseInt(str);
	if(value<minValue||value>maxValue) return false;
	return true;
};

//验证小数的范围
Matrix.validateDoubleRange = function(minValue,maxValue,str){
	if(str==null || (((typeof str) =='string') && str.trim().length==0)) return true;
	if((typeof str) =='string')
		str = str.trim();
	if(!Matrix.validateDouble(str)) return false;
	var value = parseFloat(str);
	if(value<minValue||value>maxValue) return false;
	return true;
};

//获得字符串字节数
String.prototype.getBytes = function(){
	var cArr = this.match(/[^\x00-\xff]/ig);
	if(Matrix.cnLength!=null && Matrix.cnLength>0){
		return this.length + (cArr == null ? 0 : (cArr.length*(Matrix.cnLength-1)));
	}else{
		return this.length + (cArr == null ? 0 : cArr.length);
	}
}

/***** validator end *****/
//lpz  做jstree时添加这两个变量
Matrix.URL = "matrix.rform";
Matrix.tree;
//时间格式化
Date.prototype.format = function(fmt)   
{ //author: meizz   
	if(fmt == "yyyy-MM-dd HH:mm")
		fmt="yyyy-MM-dd hh:mm";
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}  

function Mform0(){}
//spinner  按钮操作
$(document).ready(function(){
	//去除浏览器自动记录之前输入的值
	$('input:not([autocomplete]),textarea:not([autocomplete]),select:not([autocomplete])').attr('autocomplete', 'off'); 
	//时间框
	try {$('.clockpicker').clockpicker(); }	catch(err){	}
	
	//数字框
    $('.spinner .btn:first-of-type').on('click', function() {
      var btn = $(this);
      var input = btn.closest('.spinner').find('input');
      if (input.attr('max') == undefined || parseInt(input.val()) < parseInt(input.attr('max'))) {  
    	  if(input.val()!=null&&input.val()!=""){
    		 input.val(parseInt(input.val(), 10) + 1);
    	 }else{
    		 input.val(1);
    	 }
      } else {
        btn.next("disabled", true);
      }
    });
    /*$('.spinner .btn:last-of-type').on('click', function() {
      var btn = $(this);
      var input = btn.closest('.spinner').find('input');
      if (input.attr('min') == undefined || parseInt(input.val()) > parseInt(input.attr('min'))) {    
    	  if(input.val()!=null&&input.val()!=""){
     		 input.val(parseInt(input.val(), 10) - 1);
     	 }else{
     		 input.val(-1);
     	 }
      } else {
        btn.prev("disabled", true);
      }
    });*/

})
	String.prototype.replaceAll = function (FindText, RepText) { 
		regExp = new RegExp(FindText, "g"); 
		return this.replace(regExp, RepText); 
	}
//自适应高度
 $(document).ready(function() {
	 try {
		 autosize($('.resizable_textarea'));
		 //1、可以在页面上设置第一个标志  单选按钮  复选按钮的样式标志  flat和square 
	     //alert("进来了");
	     $("input[class='box']").iCheck({
		      checkboxClass: 'icheckbox_square-blue',  // 注意square和blue的对应关系,用于type=checkbox
			    radioClass: 'iradio_square-blue', // 用于type=radio
			    increaseArea: '50%' // 增大可以点击的区域
		 	}); 
		}
		catch(err){
		}
       
        
        //2、如果  form 初始了但是没有提交的情况下就想要校验的话那就加上下面这个方法 来初始化表单校验器
        //Matrix.JQInitFormValidator(formId);
      });
// 显示按钮提交遮罩
Matrix.showMask=function(){
	
}
// 隐藏按钮提交遮罩
Matrix.hideMask=function(){
	
}

//显示按钮提交遮罩
Matrix.showMask2=function(){
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

	var curDoc = document.getElementById("matrixMask");
	if(curDoc){
		curDoc.style.display="";
    }
}
// 隐藏按钮提交遮罩
Matrix.hideMask2=function(){
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

	var curDoc = document.getElementById("matrixMask");
	if(curDoc){
		curDoc.style.display="none";
    }
}

//窗口打开
Matrix.showWindow = function(windowId){
	var openFunction;
	openFunction = eval(windowId+"Open");
	if(window.eval(windowId+"Open")){//先找当前窗口
		openFunction(window);//调用open方法

	}else{
		Matrix.getOpenWindow(parent,windowId,window);//找不到着父窗口
	}
}
Matrix.getOpenWindow = function(win,windowId,data){
	if(win!=null){
		 	var dialog = win.parent;
		 	if(dialog!=null){
		 		 if(dialog.eval(windowId+"Open")){
		 			dialog.eval(windowId+"Open")(data);
		 			return;
		 		 }else{
		 			Matrix.getOpenWindow(dialog,windowId,data); 
		 		 }	 
		 	}else{
		 		return null;
		 	}
	}
	return null;
}

//H5弹出高级查询条件设置窗口
Matrix.showDataGridCustomFilter=function(dataGridId){
    if(document.getElementById('is_mobile_request') && document.getElementById('is_mobile_request').value == 'true'){  //移动端
    	layer.open({
    	    id:'DataGridCustomFilter',
    		type : 2,
    		
    		title : ['设置高级查询条件'],
    		shadeClose: false, //开启遮罩关闭
    		//maxmin: true, //开启最大化最小化按钮
    		area : [ '100%', '80%' ],
    		content :'office/html5/select/advancedQuery.jsp?iframewindowid=DataGridCustomFilter&dataGrid='+dataGridId
        });
    }else{ //pc端
    	layer.open({
    	    id:'DataGridCustomFilter',
    		type : 2,
    		
    		title : ['设置高级查询条件'],
    		shadeClose: false, //开启遮罩关闭
    		//maxmin: true, //开启最大化最小化按钮
    		area : [ '70%', '75%' ],
    		content :'office/html5/select/advancedQuery.jsp?iframewindowid=DataGridCustomFilter&dataGrid='+dataGridId
        });
    }
}



//H5选择高级查询条件回调
function onDataGridCustomFilterClose(data){
	 if(data!=null){
		 var advanceQueryValue = data.advanceQueryValue;  //高级查询条件josn
		 var dataGrid = data.dataGrid;        
		 
		 var vituralQueryHidden = document.getElementById(""+dataGrid+"_mfilter");
		 if (!vituralQueryHidden){
			 //添加高级查询隐藏域
	         var currentForm = document.getElementById('form0');
	         var advanceQueryHidden = document.createElement('input');
	         advanceQueryHidden.type = "hidden";
	         advanceQueryHidden.name = ""+dataGrid+"_mfilter";
	         advanceQueryHidden.id = ""+dataGrid+"_mfilter";
			 advanceQueryHidden.value = advanceQueryValue;
				 
	         currentForm.appendChild(advanceQueryHidden);
	         Matrix.queryDataGridData(""+dataGrid+"");
		 }else{
			 Matrix.setFormItemValue(""+dataGrid+"_mfilter",advanceQueryValue);
			 Matrix.queryDataGridData(""+dataGrid+"");
		 }
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

String.prototype.endWith=function(str){     
  var reg=new RegExp(str+"$");     
  return reg.test(this);        
}

/******** comboBox relation ajax *********/
Matrix.comboBoxRelationAjaxSend=function(comboBoxId,initflag,datalistId){


	var _comboBox = Matrix.getMatrixComponentById(comboBoxId);
	var _form = Matrix.getParentForm(comboBoxId);
	
	var rowIndex = Matrix.getFormItemValue('clickRowIndex');
	var comboBoxComId = comboBoxId;
	if(rowIndex != '' && comboBoxId.endWith('_'+rowIndex)){
		comboBoxComId = comboBoxId.substring(0, comboBoxId.length-(rowIndex+'').length-1);
	}
	var data={};
	data[comboBoxComId+"_event"]="changed";
	data["matrix_main_combobox_id"]=comboBoxId;
	data["matrix_immediate_flag"]="true";
	data["comboBoxRelationAjax"]="true";
	data["clickRowIndex"]=rowIndex;
	data["datalistId"]=datalistId;
	
	var refressHidden = document.getElementById(Matrix.REFRESH_COMPONENT_IDS);
	if(refressHidden){
		refressHidden.value = comboBoxId+","; //指定只刷新当前组件
	}else{
		data[Matrix.REFRESH_COMPONENT_IDS]=comboBoxId+","; //指定只刷新当前组件
	}
	
	if(initflag!=null && initflag=="true")
		data[comboBoxId+"_initflag"]=initflag;
	Matrix.send(_form,data);
}
/******** comboBox relation ajax end *********/
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
//获得SmartClient组件ID
Matrix.getMatrixComponentId = function(id){
	return Matrix.COMPONENT_PREFIX+id;
};
//通过编码获得SmartClient组件对象
Matrix.getMatrixComponentById = function(id){
    if(id=="DataGrid001"){
       return MDataGrid001;
    }else{
    	com = document.getElementById(id);
		if(com!=null){
			if(com.tagName=='IFRAME'){
				com.setContentsURL=function(src){com.src=src;};
				return com;
			}
			
			return null;
		}
		return null;
    }
	return null;
};
//获得页面组件
Matrix.getComponentByIds=function(componentId){//倒是协调改正
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
//获得表单元素值
Matrix.getFormItemValue=function(formItemId){
	var com = Matrix.getComponentById(formItemId);
	if(com){
		if(com.type=="checkbox"){
			if(com.checked)
				return com.value;
			return null;
		}else{
			return com.value;
		}
	}
	return null;
};

//设置表单元素值
Matrix.setFormItemValue=function(formItemId,value){
	var com = Matrix.getComponentById(formItemId);
	if(com){
		if(com.tagName=="SELECT"){
			 $("#"+formItemId).val(value).trigger("change");
		}else if(typeof(com.getAttribute("data-rule")) != "undefined"&&com.getAttribute("data-rule")=="number"){
			 $("#"+formItemId).val(value).trigger("change");
		}else{
			com.value = value;
		}
	}
};

//获得表单元素可显示
Matrix.setFormItemDisplay=function(formItemId,value){
	var com = document.getElementById(formItemId+'_div');
	if(com){
		if(value){
			com.display="";
			return;
		}else{
			com.display="none";
			return;
		}
	}else{
		com = document.getElementById(formItemId);
		if(com){
			if(value){
				com.display="";
				return;
			}else{
				com.display="none";
				return;
			}
		}
	}
	return null;
};

//设置表单元素可编辑
Matrix.setFormItemEdit=function(formItemId,value){
	var com = Matrix.getComponentById(formItemId);
	if(com){
		if(value){
			com.readOnly=true;
	    
		}else{
			com.readOnly=false;
		}
	}
};
 
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
				
							ret = item.value;
						
					}
				}
			}
		}
		
		
		return ret; // Object
	}
Matrix.isArray = function(obj) {  
	if(typeof obj=="object"&&Object.prototype.toString.call(obj) == '[object Array]'){
	 return true;
	}
return false;
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
		}else if(Matrix.isArray(val)){
			val.push(value);
		}else{
			obj[name] = value;
		}
	}
/***** Serialize a form node to a JavaScript object end *****/
//获得jsf状态标识
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
/***** form start *****/


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
	var formProxy = document.getElementById(formId);
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
	var array = $('#'+form.id).serializeArray();
	var data={};  
	$.each(array, function() {
		if (data[this.name] !== undefined) {
		if (!data[this.name].push) {
			data[this.name] = [data[this.name]];
		}
		data[this.name].push(this.value || '');
		} else {
			data[this.name] = this.value || '';
		}
		});
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
		$.ajax({
        type : method,
        url : url,
        data: data,
        error : function(){
			var result={};
        	result.data=data;
        	if(errorFun)
        		errorFun(result);
        },

        success : function(data) {
        	var result={};
        	result.data=data;
        	callbackFun(result);
        }

    });

	}
}

//发送同步请求
Matrix.sendSyncRequest=function(url,data,callbackFun,errorFun,method){
	if(url!=null && url.trim().length>0){
		if(data==null){
			data = {};
		}
		if((!data[Matrix.AJAX_REQUEST_KEY]) 
			|| (data[Matrix.AJAX_REQUEST_KEY]==null)){
			data[Matrix.AJAX_REQUEST_KEY] = Matrix.AJAX_REQUEST_VALUE;
		}

		method=method?method:"POST";
		$.ajax({
        type : method,
        url : url,
        async:false,  
        data: data,
        error : function(){
			var result={};
        	result.data=data;
        	if(errorFun)
        		errorFun(result);
        },

        success : function(data) {
        	var result={};
        	result.data=data;
        	callbackFun(result);
        }

    });

	}
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

/******validate form*****/

//Jquery校验表单
Matrix.JQValidateForm = function(formId){
	var id = "#"+formId;
	return $(id).validate().form();
}
//Jquery初始表单校验器  表单加载后，输入框onblur的时候校验，如果不需要初始就校验，那就不用初始
Matrix.JQInitFormValidator = function(formId){
	var id = "#"+formId;
	$(id).validate();
}
Mform0.validate = function(){
	return $("form").validate().form();
}

Mform0.redraw = function(){
}
// 验证表单
Matrix.validateForm = function(formId){
	debugger;
	if(formId==null || formId.trim().length==0){
		return true;
	}	
	if($("#validateType")){
		//如果是jquery校验就执行这里
		var validateType = $("#validateType")[0].value;
		if(validateType=='jquery'){
			var flag = Matrix.JQValidateForm(formId);
			if(flag){
				//校验复选框组必填
				var checkGroupSpan = $("span[isRequired='true'][componentType='checkBoxGroup']");
				for(var j=0;j<checkGroupSpan.length;j++){
					var checkGroupId = checkGroupSpan[j].id; 
					var checkGroupName = checkGroupSpan[j].getAttribute("groupName");
					if(checkGroupId.endWith('_div')){
						var checkBoxId = checkGroupId.substring(0,checkGroupId.indexOf("_div"))
						var checkCount = 0;
						$("input:checkbox[name^='"+checkBoxId+"']").each(function() {
					        if($(this).is(':checked')) {
					        	checkCount = checkCount + 1;
					        }
						});
						if(checkCount == 0){
							Matrix.warn(checkGroupName + "请至少勾选一个选项");
							return false;
						}
					}
				}
				/*//校验多附件上传必填
				var _inputs = document.getElementsByTagName('input');
				var len2 = _inputs.length;
				for(var i2=0;i2<len2;i2++){
					if(_inputs[i2].attributes.id){
						if(_inputs[i2].attributes.id.value.indexOf('_fileInput')>0){}
					}
				}*/
	        }
			return flag;
		}
	}else{
		var formProxy = Matrix.getMatrixComponentById(formId);
		if(formProxy){
			var flag = formProxy.validate();
			if(flag){
				//校验多附件上传
				var _inputs = document.getElementsByTagName('input');
				var len2 = _inputs.length;
				for(var i2=0;i2<len2;i2++){
					if(_inputs[i2].attributes.comType){
						var fileId = _inputs[i2].attributes.fileId.value;
						var filePrefix = _inputs[i2].attributes.filePrefix.value;
						var comName = _inputs[i2].attributes.title.value;
						var _inputFile = document.getElementById(fileId);
						var _inputFlag = false;
						var tabObj = document.getElementById(filePrefix+"viewTab");
						if(tabObj && tabObj.tBodies[0].rows.length>0){
							var tabObj1 = document.getElementById(filePrefix+"fileTab");
							if(tabObj1 && tabObj1.tBodies[0].rows.length > 0){
								_inputFlag = true;
	                        }
	                    }
	
						//显示列表无数据且文件上传未选择
						if( ((_inputFile == null ) || (_inputFile.value.length==0)) && _inputFlag == false){
							isc.warn("请上传"+comName);
							return false;
						}
					}
				}
	        }
	
			return flag;
		}
	
	//	var b = Matrix.exeFormValidate(formId);
	//	if(b == false)
	//		return false;
	
		return true;
	}
}

//添加附件校验
if($.validator)
	$.validator.addMethod('isRequired',function(value,element,params){return fileUploadRequired(value,element);},'不能为空');
function fileUploadRequired(value,element){
	var fileInputId = element.id;    //fileInpuut多文件上传组件id
	var required = $('#'+fileInputId).attr('isRequired');
	if(required){

		var count = 0;
		
		var image = $('#'+fileInputId).attr('image');
		if(typeof(image)=="undefined"||image == "false"){
			//var filesCount = $('#'+fileInputId).fileinput('getFilesCount'); //返回待上传的文件数
			count = document.getElementById(fileInputId).files.length;
			if(count ==0){ //如果当前没上传，但同一附件已有上传的则也通过
				var containerId = fileInputId.substring(0,fileInputId.indexOf("_fileInput",0))+"InputDIV";
				var containerDiv = document.getElementById(containerId);
				if(containerDiv.children.length >1)
					count = containerDiv.children.length-1;
			}
		}else{
			var initPreview = $('#'+fileInputId).fileinput('getPreview');
			var initCount = initPreview.content.length;
			var files = $('#'+fileInputId).fileinput('getFileStack');  //返回所选文件对象的数组(不会返回验证失败或已上载的文件。)
			var allFiles = $('#'+fileInputId).fileinput('getFrames');		
			count = allFiles.length - files.length;
		}
		
		if(count<1){ //获取已上传的附件
			var viewId = fileInputId.substring(0,fileInputId.indexOf("_fileInput",0))+"fileBaseViewTab";
			if (document.getElementById(viewId)) {
		        var tabObj = document.getElementById(viewId);
	        	count = tabObj.tBodies[0].rows.length;
		    }
		}
		
		if(count<1){
			//Matrix.warn("请上传文件");
			return false;
		}
	}							
		return true;
}
function GetUrlParam(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}
Matrix.closeLayerWindow = function(data,operationType){
	var iframewindowid = GetUrlParam("iframewindowid");
	var closeFunction;
	closeFunction = eval("parent.on"+iframewindowid+"Close");
	var targetWindow=parent.layer.target;
		if(targetWindow!=null&&typeof(targetWindow) != "undefined"){
			closeFunction =eval("targetWindow.on"+iframewindowid+"Close");
			if(closeFunction){
				var result = closeFunction(data,operationType);
				if( result == null || result == true){
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					parent.layer.close(index);
				}
			}else{
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
			}
		}else{
			if(closeFunction){
				var result = closeFunction(data,operationType);
				if( result == null || result == true){
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					parent.layer.close(index);
				}
			}else{
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
			}
	}
	
}
Matrix.getTopWindow = function(frame,windowId){
	if(frame!=null){
		if(frame.Matrix!=null){
		 	var dialog = frame.window;
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
Matrix.closeWindow = function(data,operationType){
	var iframewindowid = GetUrlParam("iframewindowid");
		if(iframewindowid == null || iframewindowid ==''){
			if(document.getElementById('iframewindowid')){
				iframewindowid = document.getElementById('iframewindowid').value;
			}
	}
	var closeFunction;
	closeFunction = eval("parent.on"+iframewindowid+"Close");
	var targetWindow=parent.layer.target;
		if(targetWindow!=null&&typeof(targetWindow) != "undefined"){
				closeFunction =eval("targetWindow.on"+iframewindowid+"Close");
			if(closeFunction){
				var result = closeFunction(data,operationType);
				if( result == null || result == true){
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					parent.layer.close(index);
				}
			}else{
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
			}
		}else{
			if(closeFunction){
				var result = closeFunction(data,operationType);
				if( result == null || result == true){
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					parent.layer.close(index);
				}
			}else{
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
			}
	}
	
}


//重复节增加行
Matrix.addRepeatRow = function addRow(divId, datalistId, currentindex) {
    Matrix.showMask2();

    var rowsvar = Matrix.getFormItemValue(datalistId + '_rows');
    var deleterowsvar = Matrix.getFormItemValue(datalistId + '_delrows'); // 删除数据行号
    var max = 0;
    var rowsarr = [];
    var delarr = [];
    if (rowsvar != "" && rowsvar != null) {
        rowsArr = rowsvar.split(",");
    }
    if (deleterowsvar != "" && deleterowsvar != null) {
        delarr = deleterowsvar.split(",");
    }
    var c = rowsArr.concat(delarr);
    for (var i = 0; i < c.length; i++) {
        if (parseInt(c[i]) > parseInt(max)) max = c[i];
    }
    var addindex = parseInt(max) + 1 + "";
    if (rowsvar != null && rowsvar != "") {
        var rowsArr = rowsvar.split(",");
        for (var i = 0; i < rowsArr.length; i++) {
            if (rowsArr[i] == currentindex) {
                if (i > -1) {
                    rowsArr.splice(i, 0, addindex);
                    rowsArr[i] = currentindex;
                    rowsArr[i + 1] = addindex;
                    break;
                }
            }
        }
        var addrows = "";
        for (var i = 0; i < rowsArr.length; i++) {
            var a = rowsArr[i];
            if (addrows != "") {
                addrows += ",";
            }
            addrows += a;
        }

    } else {
        addrows = addindex;
    }
    var newData = Matrix.formToObject("form0");
    newData["getNewRepeatSection"] = 'true';
    newData["repeatSecId"] = datalistId;
    newData["index"] = addindex;
    var url = webContextPath + '/matrix.rform?mHtml5Flag=true&matrix_send_request=true&matrix_form_tid=' + document.getElementById("matrix_form_tid").value;
    Matrix.sendRequest(url, newData,
    function(data) {
        if (data.data != null && data.data != "") {
            Matrix.setFormItemValue(datalistId + '_rows', addrows);
            var val = data.data;
            val = val.replaceAll("\\\\", "\\");
            var result = eval('(' + val + ')');
            var htmlContent = result.htmlContent;
            htmlContent = htmlContent.replaceAll("”", "\"");  
            var tb = document.getElementById(divId);
            var tb2 = document.createElement("div");
            // var length = document.getElementById(datalistId+"_div").childNodes;
            tb2.id = datalistId + "_div_" + addindex;
            tb2.style.width = "100%";

            htmlContent = htmlContent.replaceAll("”", "");
            // tb2.innerHTML="<div style=\"width:16px;float:left;\"><table><tr><td><span
            // class=\"repeat_ico16 operate_plus_16 right\"
            // onclick=\"Matrix.addRepeatRow('"+datalistId+"_div_"+addindex+"','"+datalistId+"','"+addindex+"');\"></span></td></tr><tr><td><span
            // class=\"repeat_ico16 operate_reduce_16 right\"
            // onclick=\"Matrix.deleteRepeatRow('"+datalistId+"_div_"+addindex+"','"+datalistId+"','"+addindex+"');\"></span></td></tr></table></div><div
            // style=\"width:100%;float:left;\">"+htmlContent+"</div>";
            if (document.getElementById('is_mobile_request') && document.getElementById('is_mobile_request').value == 'true') { // 移动端
                tb2.innerHTML = "<div style=\"width:16px;float:left;\"><table><tr><td><span  class=\"repeat_ico16 operate_plus_16 right\" onclick=\"Matrix.addRepeatRow('" + datalistId + "_div_" + addindex + "','" + datalistId + "','" + addindex + "');\"></span></td><td style='padding-left:8px'><span class=\"repeat_ico16 operate_reduce_16 right\" onclick=\"Matrix.deleteRepeatRow('" + datalistId + "_div_" + addindex + "','" + datalistId + "','" + addindex + "');\"></span></td></tr></table></div><div id='" + datalistId + "_div2_" + addindex + "'style=\"width:100%;float:left;\"></div>";
            } else { // pc端
                tb2.innerHTML = "<div style=\"width:16px;float:left;\"><table><tr><td><span  class=\"repeat_ico16 operate_plus_16 right\" onclick=\"Matrix.addRepeatRow('" + datalistId + "_div_" + addindex + "','" + datalistId + "','" + addindex + "');\"></span></td></tr><tr><td><span class=\"repeat_ico16 operate_reduce_16 right\" onclick=\"Matrix.deleteRepeatRow('" + datalistId + "_div_" + addindex + "','" + datalistId + "','" + addindex + "');\"></span></td></tr></table></div><div id='" + datalistId + "_div2_" + addindex + "'style=\"width:100%;float:left;\"></div>";
            }

            var parentEl = tb.parentNode;

            if (parentEl.lastChild == tb) {
                parentEl.appendChild(tb2);
            } else {
                parentEl.insertBefore(tb2, tb.nextSibling);
            }

        }
        var dataDiv = document.getElementById(datalistId + "_div2_" + addindex);
        dataDiv.innerHTML = htmlContent;
        var jsContent = result.jsContent;

        if (jsContent != null && jsContent != "") {
            jsContent = jsContent.replaceAll("<script>", "");
            jsContent = jsContent.replaceAll("<\/script>", "");
            eval(jsContent);
        }
        $('.box').iCheck({
            labelHover: false,
            cursor: true,
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%'
        });
        $('.clockpicker').clockpicker();
        Matrix.hideMask2();
    });
}

    //重复节删除行
Matrix.deleteRepeatRow= function deleteRow(divId,datalistId,currentindex){
	   Matrix.showMask2();
	   
       var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
       var deleterowsvar = Matrix.getFormItemValue(datalistId+'_delrows');//删除数据行号
       if(deleterowsvar!=null&&deleterowsvar!="")
          deleterowsvar = deleterowsvar+","+currentindex;
       else
          deleterowsvar = currentindex;
       if(rowsvar!=""&&rowsvar!=null){
         var rowsArr = rowsvar.split(",");
         if(rowsArr.length==1){
        	 layer.alert('不能删除最后一行！');
        	 Matrix.hideMask2();
             return false;
         }else{
	         var parent=document.getElementById(datalistId+"_div");
	         var child = document.getElementById(divId);
	         //parent.removeChild(child);
	         child.parentElement.removeChild(child);
	         //parent.children[3].removeChild(child);
	            for (var i = 0; i < rowsArr.length; i++) {
	              if (rowsArr[i] == currentindex){
	                 if(i>-1) {
	                    rowsArr.splice(i, 1);
	                 }
	              }
	            }
         }
	       var deleterows = "";
	       for(var i=0;i<rowsArr.length;i++){
	          var a = rowsArr[i];
	          if(deleterows!="")
	          deleterows+=",";
	          deleterows+=a;
	       }
	       Matrix.setFormItemValue(datalistId+'_rows',deleterows);
		   Matrix.setFormItemValue(datalistId+'_delrows',deleterowsvar);
    }
    
    Matrix.hideMask2();
}

	var _clickTd;   //重复节选中td


	//显示重复节增加行和删除行的按钮
	function showPlusAndReduceButton(obj,dataListId,rowIndex){
	  _clickTd = obj;

		Matrix.setFormItemValue('clickRowIndex',rowIndex);   //选中行的重复表数据序号
		Matrix.setFormItemValue('clickDataGrid',dataListId);  //选中行所在的重复表id
		var img = $("#img");//得到元素
		if(img){
			img[0].style.visibility = "visible";
			var target = obj.parentElement;
			var pos = getElementPos(target);
			pos.left = pos.left;
			 if(pos.left >16)
			   pos.left = pos.left-16;
			img.offset(pos);
		    var span = document.getElementById('addImg');
			span.onclick=function(){
				 Matrix.addRepeatRowForTable(obj,dataListId+"_div_"+rowIndex,dataListId,rowIndex);
			}
			 var delspan = document.getElementById('delImg');
				 delspan.onclick=function(){
				 Matrix.deleteRepeatRowForTable(obj,dataListId+"_div_"+rowIndex,dataListId,rowIndex);
			 }
		}
	
	}
	
  //增加行
 Matrix.addRepeatRowForTable =  function addRowForTable(obj,divId,datalistId,currentindex,gridId){
     Matrix.showMask2();

     var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');     //重复表数据行号
     var deleterowsvar = Matrix.getFormItemValue(datalistId+'_delrows');//删除数据行号
     var max = 0;
     var rowsArr = [];
     var delarr = [];
     if(rowsvar!=""&&rowsvar!=null){
         rowsArr = rowsvar.split(",");
      }
     if(deleterowsvar!=""&&deleterowsvar!=null){
	     delarr = deleterowsvar.split(",");
     }
     
     if(rowsArr.length == 0){
        max = 0;
     }else{
	     var c = rowsArr.concat(delarr);
	     for(var i=0;i<c.length;i++){
	            if(parseInt(c[i])>parseInt(max))
		            max = c[i];
	     }
     }
     var addindex = parseInt(max)+1+"";
     if(rowsArr.length == 0){
        addindex = 0;
     }
     
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         var isInScope = false;  //在当前范围内
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == currentindex){
               if(i>-1) {
				   rowsArr.splice(i, 0,addindex);
				   rowsArr[i] = currentindex;
				   rowsArr[i+1] = addindex;
				   isInScope = true;
				   break;
               }
             }
         }
         if(isInScope == false){  //不在当前范围内,追加
         	rowsArr[rowsArr.length] = addindex;
         }
         
         var addrows = "";
         for(var i=0;i<rowsArr.length;i++){
			 var a = rowsArr[i];
				if(addrows!=""){
					addrows+=",";
				}
			 addrows+=a;
         }

    }
    else{
        addrows = addindex;
       }
       Matrix.setFormItemValue(datalistId+'_rows',addrows);
       
      var newData = Matrix.formToObject("form0");
      newData["getNewRepeatSection"]='true';
      newData["repeatSecId"]=datalistId;
      newData["index"]=addindex;
      var url = webContextPath+'/matrix.rform?mHtml5Flag=true&matrix_send_request=true&matrix_form_tid='+document.getElementById("matrix_form_tid").value;
      Matrix.sendRequest(url,newData,function(data){
        if(data.data!=null&&data.data!=""){
          Matrix.setFormItemValue(datalistId+'_rows',addrows);
          var val = data.data;
          val = val.replaceAll("\\\\","\\");
        var result = eval('(' + val + ')');
        var htmlContent = result.htmlContent;

         var tr = obj.parentNode;
         var rowIndex = tr.rowIndex;
         var table = tr.parentNode.parentElement;
         var row = table.insertRow(rowIndex);
          htmlContent = htmlContent.replaceAll("”","\"");
         row.innerHTML=htmlContent;
         swapnode(tr,row);
 		numberCheck(datalistId);

		  var jsContent = result.jsContent;
			 if(jsContent!=null&&jsContent!=""){
			   jsContent = jsContent.replaceAll("<script>","");
						jsContent = jsContent.replaceAll("<\/script>","");

			  eval(jsContent);
			 }

			 var checkId = datalistId.substring(0, datalistId.length)+"_trCheckBox_"+rowIndex;
			 debugger;
	 		//	setTimeout("$('.box').iCheck({ checkboxClass: 'icheckbox_square-blue',radioClass: 'iradio_square-blue', increaseArea: '20%'  }); ", 100 );
// 			setTimeout("$('input').iCheck({ checkboxClass: 'icheckbox_square-blue', increaseArea: '20%'  }); ", 100 );
	 			$('.clockpicker').clockpicker();
         }
         
         Matrix.hideMask2();
    });
}	


  //增加行
 Matrix.addRepeatRowsWithData =  function addRowForTable(obj,divId,datalistId,currentindex,data){
     Matrix.showMask2();

     var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');     //重复表数据行号
     var deleterowsvar = Matrix.getFormItemValue(datalistId+'_delrows');//删除数据行号
     var max = 0;
     var rowsArr = [];
     var delarr = [];
     if(rowsvar!=""&&rowsvar!=null){
         rowsArr = rowsvar.split(",");
      }
     if(deleterowsvar!=""&&deleterowsvar!=null){
	     delarr = deleterowsvar.split(",");
     }
     
     if(rowsArr.length == 0 && delarr.length == 0){
        max = 0;
     }else{
	     var c = rowsArr.concat(delarr);
	     for(var i=0;i<c.length;i++){
	            if(parseInt(c[i])>parseInt(max))
		            max = c[i];
	     }
     }
     var addindex = parseInt(max)+1+"";
   /*  if(parseInt(max) == 0)
    	 addindex = "0";
    */ if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         var jsondata = eval(data);
    	 if(jsondata.length == 1){
             var isInScope = false;  //在当前范围内
             for (var i = 0; i < rowsArr.length; i++) {
                 if (rowsArr[i] == currentindex){
                   if(i>-1) {
    				   rowsArr.splice(i, 0,addindex);
    				   rowsArr[i] = currentindex;
    				   rowsArr[i+1] = addindex;
    				   isInScope = true;
    				   break;
                   }
                 }
             }
             if(isInScope == false){  //不在当前范围内,追加
            	 rowsArr[rowsArr.length] = addindex;
             }
             
             var addrows = "";
             for(var i=0;i<rowsArr.length;i++){
    			 var a = rowsArr[i];
    				if(addrows!=""){
    					addrows+=",";
    				}
    			 addrows+=a;
             }
    	 }else{
    		 var addrows = "";
             for(var i=0;i<rowsArr.length;i++){
    			 var a = rowsArr[i];
    				if(addrows!=""){
    					addrows+=",";
    				}
    			 addrows+=a;
             }
    		 if(jsondata.length > 1){
    			 addindex = addindex -1;
                 for(var i=0;i<jsondata.length;i++){
      				if(addrows!=""){
      					addrows+=",";
      				}
      				addrows=addrows+(parseInt(addindex)+parseInt(i)+1);
      			 
                 }
       			addindex = addindex +1;
        	 }
    	 }

         
    	 

    }
    else{
    	addrows = "";
    	addindex = addindex -1;
    	var jsondata = eval(data);
        for(var i=0;i<jsondata.length;i++){
				if(addrows!=""){
					addrows+=",";
				}
     			 addrows=addrows+(parseInt(addindex)+parseInt(i)+1);
        }
		addindex = addindex +1;

    }
       Matrix.setFormItemValue(datalistId+'_rows',addrows);
       
      var newData = Matrix.formToObject("form0");
      newData["getNewRepeatSection"]='true';
      newData["repeatSecId"]=datalistId;
      newData["index"]=addindex;
      newData["isAddMulti"]="true";
      newData["newRowsInfo"]=data;
      
      var url = webContextPath+'/matrix.rform?mHtml5Flag=true&matrix_send_request=true&matrix_form_tid='+document.getElementById("matrix_form_tid").value;
      Matrix.sendRequest(url,newData,function(data){
        if(data.data!=null&&data.data!=""){
          Matrix.setFormItemValue(datalistId+'_rows',addrows);
          var val = data.data;
          val = val.replaceAll("\\\\","\\");
        var resultData = eval('(' + val + ')');
        
        var rows = resultData.rows;
        
        for(var i=0;i<rows.length;i++){  
			var result =  rows[i];

	        var htmlContent = result.htmlContent;
	
	         var tr = obj.parentNode;
	         var rowIndex = tr.rowIndex;
	         var table = tr.parentNode.parentElement;
	         var row = table.insertRow(rowIndex);
	          htmlContent = htmlContent.replaceAll("”","\"");
	         row.innerHTML=htmlContent;
	         swapnode(tr,row);
	
			  var jsContent = result.jsContent;
				 if(jsContent!=null&&jsContent!=""){
				   jsContent = jsContent.replaceAll("<script>","");
				   jsContent = jsContent.replaceAll("<\/script>","");
	
				   eval(jsContent);
				 }
	
	 			setTimeout("$('input').iCheck({ checkboxClass: 'icheckbox_square-blue', increaseArea: '20%'  }); ", 100 );
	 			$('.clockpicker').clockpicker();
           }
        }	  
        numberCheck(datalistId);	

         Matrix.hideMask2();
    });
}	

//删除行
Matrix.deleteRepeatRowForTable= function deleteRowForTable(obj,divId,datalistId,currentindex,gridId){
     Matrix.showMask2();

	_clickTd=null;
	
     debugger;
		var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
		var firstFlag = Matrix.getFormItemValue(datalistId+'_firstrow');  //是否默认输出空行
		 if("true" == firstFlag && rowsvar!=""&&rowsvar!=null){  //只有一条不允许删除
				  var rowsArr = rowsvar.split(",");
				  if(rowsArr.length==1){
					  Matrix.hideMask2();
					  Matrix.warn("不能删除最后一行！");
					  return false;
				  }
		 }

		var deleterowsvar = Matrix.getFormItemValue(datalistId+'_delrows');//删除数据行号

     //如果是新添加的,删除新添加行记录
     var rowsarr = [];
	var isNew = false;
     var addrows = "";
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
		 var newrowsarr = [];
		 var k = 0;
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == currentindex){
                isNew = true;
             }else{
				newrowsarr[k]=rowsArr[i];
				++k;
             }
         }
         for(var i=0;i<newrowsarr.length;i++){
			 var a = newrowsarr[i];
				if(addrows!=""){
					addrows+=",";
				}
			 addrows+=a;
         }
    }

	//if(isNew == false){ //是否新添加的均记录删除行,为了页面不出现重复行编码
		if(deleterowsvar!=null&&deleterowsvar!="")
			deleterowsvar = deleterowsvar+","+currentindex;
		else
			deleterowsvar = currentindex;
    //}


        if(rowsvar!=""&&rowsvar!=null){
          var rowsArr = rowsvar.split(",");
          if(rowsArr.length==0){
			  Matrix.hideMask2();
			 // Matrix.warn("不能删除最后一行！");
			 // return false;
          }else{
			var tr = obj.parentNode;
			var rowIndex = tr.rowIndex;
			var table = tr.parentNode.parentElement;
			table.deleteRow(rowIndex);
			var img = document.getElementById('img');//得到元素
			img.style.visibility = "hidden";
				 for (var i = 0; i < rowsArr.length; i++) {
				   if (rowsArr[i] == currentindex){
					  if(i>-1) {
						 rowsArr.splice(i, 1);
					  }
				   }
				 }
			  }
			var deleterows = "";
			for(var i=0;i<rowsArr.length;i++){
			   var a = rowsArr[i];
			   if(deleterows!="")
			   deleterows+=",";
			   deleterows+=a;
			}
			Matrix.setFormItemValue(datalistId+'_rows',addrows);
      	    Matrix.setFormItemValue(datalistId+'_delrows',deleterowsvar);
			
		 	numberCheck(datalistId);
	     }
        
		  Matrix.hideMask2();

}

	//定义通用的函数交换两个结点的位置
	function swapnode(node1,node2){
	//获取父结点
	var _parent=node1.parentNode;
	//获取两个结点的相对位置
	var _t1=node1.nextSibling;
	var _t2=node2.nextSibling;
	//将node2插入到原来node1的位置
	if(_t1)_parent.insertBefore(node2,_t1);
	else _parent.appendChild(node2);
	//将node1插入到原来node2的位置
	if(_t2)_parent.insertBefore(node1,_t2);
	else _parent.appendChild(node1);
	}

	//定义通用的函数交换两个结点的位置
	function swapNode2(node1,node2){
		//获取父结点
		var _parent=node1.parentNode;
		//获取两个结点的相对位置
		var _t1=node1.nextSibling;
		var _t2=node2.nextSibling;
		//将node2插入到原来node1的位置
		if(_t1)_parent.insertBefore(node2,_t1);
		else _parent.appendChild(node2);
		//将node1插入到原来node2的位置
		if(_t2)_parent.insertBefore(node1,_t2);
		else _parent.appendChild(node1);
	}
	
	
	function getElementPos(el) {
	  var ua = navigator.userAgent.toLowerCase();
	  var isOpera = (ua.indexOf('opera') != -1);
	  var isIE = (ua.indexOf('msie') != -1 && !isOpera); // not opera spoof
	  if (el.parentNode === null || el.style.display == 'none') {
	      return false;
	  }
	  var parent = null;
	  var pos = [];
	  var box;
	  if (el.getBoundingClientRect) {//IE，google
	      box = el.getBoundingClientRect();
	      var scrollTop = document.documentElement.scrollTop;
	      var scrollLeft = document.documentElement.scrollLeft;
	      if(navigator.appName.toLowerCase()=="netscape"){//google
	      	scrollTop = Math.max(scrollTop, document.body.scrollTop);
	      	scrollLeft = Math.max(scrollLeft, document.body.scrollLeft);
	      }
	      return { left : box.left + scrollLeft, top : box.top + scrollTop };
	  } else if (document.getBoxObjectFor) {// gecko
	      box = document.getBoxObjectFor(el);
	      var borderLeft = (el.style.borderLeftWidth) ? parseInt(el.style.borderLeftWidth) : 0;
	      var borderTop = (el.style.borderTopWidth) ? parseInt(el.style.borderTopWidth) : 0;
	      pos = [ box.x - borderLeft, box.y - borderTop ];
	  } else {// safari & opera
	      pos = [ el.offsetLeft, el.offsetTop ];
	      parent = el.offsetParent;
	      if (parent != el) {
	          while (parent) {
	              pos[0] += parent.offsetLeft;
	              pos[1] += parent.offsetTop;
	              parent = parent.offsetParent;
	          }
	      }
	      if (ua.indexOf('opera') != -1 || (ua.indexOf('safari') != -1 && el.style.position == 'absolute')) {
	          pos[0] -= document.body.offsetLeft;
	          pos[1] -= document.body.offsetTop;
	      }
	  }
	  if (el.parentNode) {
	      parent = el.parentNode;
	  } else {
	      parent = null;
	  }
	  while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML') { // account for any scrolled ancestors
	      pos[0] -= parent.scrollLeft;
	      pos[1] -= parent.scrollTop;
	      if (parent.parentNode) {
	          parent = parent.parentNode;
	      } else {
	          parent = null;
	      }
	  }
	  return {
	      left : pos[0],
	      top : pos[1]
	  };
	
	
	
		
	}
	
	
//==============lpz  jstree component start=======================================
	
	
	/**
 *刷新树节点
 */
Matrix.refreshTreeNode = function(node){
	if(node && Matrix.tree){
		if(node.reference){
			var inst = $.jstree.reference(node.reference),
        	obj = inst.get_node(node.reference);
			Matrix.tree.refresh_node(obj);
		
		}else{
			Matrix.tree.refresh_node(node);
		}
	}
}

//
Matrix.forceFreshTreeNode = function(treeId,nodeId){
	if(treeId){
		var curTree = jQuery.jstree.reference("#"+treeId+"_div");
		if(curTree && nodeId){
			var node = curTree.get_node(nodeId);
			if(node){
				curTree.refresh_node(node);
			}
		}
	}
}
//上移
Matrix.moveUpTreeNode = function(node,item,menu,colNum){
	if(node){
		Matrix.moveTreeNode(node,"moveup");
	}
}
//下移
Matrix.moveDownTreeNode = function(node,item,menu,colNum){
	Matrix.moveTreeNode(node,"movedown");
}
/**
 *移动树节点
 */
Matrix.moveTreeNode = function(node,moveType){
	var instance = $.jstree.reference(node.reference);//当前节点实例
	if(instance){
		var curNode = instance.get_node(node.reference);//当前节点
	    if(Matrix.tree){
		    var parentNode = Matrix.tree.get_node(curNode.parent);
		    if(parentNode){
			    var children = parentNode.children;
			    if(children){
				    var curNodeIndex = children.indexOf(curNode.id);
				    var childrenSize = children.length;
				    var isPost = false; // 异步标识
    				var targetNode = null;
    				var moveFun = null;
    				//参数
    				var content = {};
    				content["treeComponentId"] = "Tree0";
					content["matrix_form_tid"] = $("#matrix_form_tid").val();
					content["REFRESH_COMPONENT_IDS"] = "Tree0,";
					content["mHtml5Flag"] = true;
					content["MATRIX_REFRESH_FORM_ID"]=$("#form0").val();
					content["form0"]=$("#form0").val();
					content["X-Requested-With"]="XMLHttpRequest";
					var currentNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,curNode);//当前节点
					var parentTreeNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,parentNode);//父节点
					var url=Matrix.URL;
					
    				if(moveType=='moveup'){//上移
    					content["actionType"] = "moveup";
				     	if(curNodeIndex>0){//不是第一条  可上移
				    		
				    		var preNode = Matrix.tree.get_node(children[curNodeIndex-1]);//上一条
							targetNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,preNode);//符合数据结构的上一条数据节点对象
							
							var nodeData ="{currentNode:"+JSON.stringify(currentNode)+",parentNodeData:"+JSON.stringify(parentTreeNode)+",previousNodeData:"+JSON.stringify(targetNode)+"}";
				    		content["data"] = nodeData;
				    	}else{
				    		alert("第一个节点不能上移");
				    		return;
				    	}
			    	}else if(moveType == 'movedown'){
			    		content["actionType"] = "movedown";
			    		if(curNodeIndex<children.length-1){//不是最后一条
			    			var nextNode = Matrix.tree.get_node(children[curNodeIndex+1]);//下一条
							targetNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,nextNode);//符合数据结构的下一条数据节点对象
							var nodeData ="{currentNode:"+JSON.stringify(currentNode)+",parentNodeData:"+JSON.stringify(parentTreeNode)+",nextNodeData:"+JSON.stringify(targetNode)+"}";
				    		content["data"] = nodeData;
			    		}else{
				    		alert("最后一个节点不能下移");
				    		return;
				    	}
			    	}
			    	Matrix.sendRequest(url,content,function(result){
			    		if(result){
					    	var synJson =  eval('('+result.data+')');		
			    			if(synJson.result){
			    				Matrix.refreshTreeNode(parentNode);//刷新父节点
			    			}
			    		}
				    },"post");
			    }
		    }
	    }
	}
}

///删除树节点
Matrix.removeUpTreeNode = function(node,item,menu,colNum){
	
	if(node){
		var instance = $.jstree.reference(node.reference);//当前节点实例
		if(instance){
			var curNode = instance.get_node(node.reference);//当前节点
			if(!confirm("确认删除"+curNode.text+"?")){
				return;
			}
			if(Matrix.tree){
		    	var parentNode = Matrix.tree.get_node(curNode.parent);
		    	if(parentNode){
		    		var content = {};
    				content["treeComponentId"] = "Tree0";
					content["matrix_form_tid"] = $("#matrix_form_tid").val();
					content["REFRESH_COMPONENT_IDS"] = "Tree0,";
					content["mHtml5Flag"] = true;
					content["MATRIX_REFRESH_FORM_ID"]=$("#form0").val();
					content["form0"]=$("#form0").val();
					content["X-Requested-With"]="XMLHttpRequest";
					var currentNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,curNode);//当前节点
					var parentTreeNode = Matrix.jstreeNode2MatrixTreeNode(Matrix.tree,parentNode);//父节点
					var nodeData ="{currentNode:"+JSON.stringify(currentNode)+",parentNodeData:"+JSON.stringify(parentTreeNode)+"}";
					content["actionType"] = "remove";
					var url=Matrix.URL;
					content["data"] = nodeData;
					Matrix.sendRequest(url,content,function(result){
			    		if(result){
					    	var synJson =  eval('('+result+')');		
			    			if(synJson.result){
			    				Matrix.refreshTreeNode(parentNode);//刷新父节点
			    			}
			    		}
				    },"post");
		    	}
		    }
		}
	}
}
/**
 *根据tree和nodeId获得node对象
 */
/*Matrix.getComponentById = function(tree,nodeId){
	if(tree && nodeId){
		return tree.get_node(nodeId);
	}
	return null;
}
*/

//获得页面组件
Matrix.getComponentById=function(componentId){
	if(componentId!=null){
		com = document.getElementById(componentId);
		if(com!=null){
			return com;
		}
	}
	
	return null;
};

/**
 *  发送异步请求
 *  if you want to use this method,'jquery.min.js' must be included in form page
 *  a: url  default value is  Matrix.URL
 *  b: json data
 *  c: call back method
 *  d: send type   'post' or 'get' default value is 'post'
 */
/*Matrix.sendRequest = function(a,b,c,d){
	if(d==null || d==''){
		d = "post";
	}
	if(a==null || a==''){
		a = Matrix.URL;
	}
	//发送异步请求
	$.ajax({
        type: d,
        url: a,
        data: b,
        success: c
    });
}

*/

/**
 * jstree 节点数据 转换为 MatrixTree 节点的数据
 */
Matrix.jstreeNode2MatrixTreeNode = function(tree,node){
	var json = "";
	if(node){
		json +="{";
		json += Matrix.getTreeNodeJsonStr(node);
		if(node.children && node.children.length>0){
			json+=",\"children\":[";
				for(var i = 0;i<node.children.length;i++){
					var childStr = "{";
					var child = tree.get_node(node.children[i]);
					childStr += Matrix.getTreeNodeJsonStr(child);
					childStr +="}";
					if(i<node.children.length-1){
						childStr +=",";
					}
					json += childStr;
				}
			
			json+="]";
		}
		json +="}";
		var jsonObj = JSON.parse(json);
		return jsonObj;
	}
}


Matrix.getTreeNodeJsonStr = function(node){
	var json = "";
	if(node){
		json += "\"id\":\""+node.id+"\",";
		json +="\"entityId\":\""+node.original.entityId+"\",";
		json +="\"icon\":\""+node.icon+"\",";
		json +="\"isFolder\":\""+node.original.isFolder+"\",";
		json +="\"text\":\""+node.text+"\",";
		json +="\"menuId\":\""+node.original.menuId+"\",";
		json +="\"cascade\":\""+node.original.cascade+"\",";
		if(node.original.extr1!=null && node.original.extr1.length>0){
			json +="\"extr1\":\""+node.original.extr1+"\",";
		}
		if(node.original.extr2!=null && node.original.extr2.length>0){
			json +="\"extr2\":\""+node.original.extr2+"\",";
		}
		if(node.original.extr3!=null && node.original.extr3.length>0){
			json +="\"extr3\":\""+node.original.extr3+"\",";
		}
		if(typeof(node.original.loaded) === 'boolean'){
			json +="\"loaded\":"+node.original.loaded+",";
		}
		if(typeof(node.original.loadAll)=== 'boolean'){
			json +="\"loadAll\":"+node.original.loadAll+",";
		}
		if(node.original.onSelect!="null" && node.original.onSelect!="undefined"){
			json +="\"onSelect\":\""+node.original.onSelect+"\",";
		}
		
		json +="\"componentId\":\""+node.original.componentId+"\",";
		json +="\"parentId\":\""+node.parent+"\"";
	}
	return json;
}



/******************************handTreeNodeHref相关方法 开始************************/

/**
 *直接从matrixSmartClient.js中拷贝出这几个方法，放到这里，handTreeNodeHref肯定有问题
 *之后再寻求解决办法，例如可不可以用别的方法来代替这几个方法
 */
//处理节点上的值
function treeNodeFunctionHandle(treeNode,functionname){   
   if(functionname.indexOf("treeNode.")==0){
     var propertyName=functionname.substring(functionname.indexOf(".")+1);
     if(propertyName){
	     if(treeNode[propertyName]!=null){
	        return treeNode[propertyName];
	     }
     }     
   }
   return null;
}

//处理父节点上的值
function treeNodeParentNodeFunctionHandle(treeNode,functionname){
	var treeId =document.getElementById("matrix_treeId").value;
   var tree = $("#"+treeId);// 获得所属tree
   var tempfunctionname=functionname;
   var temptreenode=treeNode;
   var item=null;
   //循环处理parentNode.parentNode...取变量的情况   
   while(tempfunctionname.indexOf("parentNode.")==0){
     item=null;
     tempfunctionname=tempfunctionname.substring(tempfunctionname.indexOf(".")+1);
     if(tree.jstree('get_parent',treeNode)){
       temptreenode=tree.jstree('get_node',tree.jstree('get_parent',treeNode));;
       if(temptreenode){
         //if(temptreenode.parent!="#"){
           item=temptreenode.original;
         //}
       }
     }  
     if(item==null){
       tempfunctionname="";
     }     
   }
   if(item){   
     if(item[tempfunctionname]!=null){
        return item[tempfunctionname];
     }  
   } 
   return null;
}

//用于处理链接上的js函数
function treeInternalFunctionHandle(treeNode,functionname){
     var functions1=new Array("treeNodeFunctionHandle","treeNodeParentNodeFunctionHandle");
     for(var i=0;i<functions1.length;i++){
        var myfunction=eval(functions1[i]);
        var value=myfunction(treeNode,functionname);
        if(value){
          return value;
        }
     }
     return functionname;
}
//处理链接
function handTreeNodeHref(treeNode,href){
   if(href.indexOf("?")!=-1){   
     var paramString=href.substring(href.indexOf("?")+1);
     var sourceUrl=href.substring(0,href.indexOf("?"));
      if(paramString!=""){
    	var params=paramString.split("&");
    	for(var j=0;j<params.length;j++){
    		 var paramValues=params[j].split("=");
    		 if(paramValues.length==2){
    		     paramValues[1]=treeInternalFunctionHandle(treeNode,paramValues[1]);
    		 }
    		 params[j]=paramValues.join("=");
    	}
    	paramString=params.join("&");
      }
      href=sourceUrl+"?"+paramString;
    }
   if(href.indexOf("mHtml5Flag=true")==-1){
	   if(href.indexOf("?")==-1){
		   href=href+"?mHtml5Flag=true";
	   }else{
		   href=href+"&mHtml5Flag=true";
	   }
   }
   //href=href.replace(".rform",".rform");
    return href;
}
/*****************************handTreeNodeHref 相关方法结束*************************/

//==============lpz  jstree component end=======================================
	
// 格式化表格显示值
Matrix.formatter = function(value,formatStyle,formatPattern,record,rowNum){
	
	// 取空值
	var _emptyCellValue = "";

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
	
Matrix.exportDataGridData=function(gridId, type, exportCells){
	exportGrid(gridId, type, exportCells);
}

function exportDataGridData(gridId, type, exportCells){
	exportGrid(gridId, type, exportCells);
}

function exportGrid(gridId, type, exportCells){
    var newData = Matrix.formToObject("form0");
  var formTid = document.getElementById('matrix_form_tid').value;
  if(document.getElementById('configUUID')){ //业务定制
	  var configUUID = document.getElementById('configUUID').value;
	  var formId = document.getElementById('formId').value;
	  var url = webContextPath+'/matrix.rform?mHtml5Flag=true&export_data_grid_id='+gridId+'&formId='+formId+'&configUUID='+configUUID+'&mIsQueryMode=true&export_data_grid_type='+type+'&export_data_grid_cells='+exportCells+'&matrix_form_tid='+formTid;
	 
	 window.location.href = url;
  }else{//设计开发
	  var formTid = document.getElementById('matrix_form_tid').value;
	  //var formTid = document.getElementById('matrix_form_tid').value;
	  var url = webContextPath+'/matrix.rform?mHtml5Flag=true&export_data_grid_id='+gridId+'&matrix_form_tid='+formTid+'&export_data_grid_type='+type+'&export_data_grid_cells='+exportCells+'&matrix_form_tid='+formTid;
	 
	// window.location.href = url;
	  var currentForm = document.getElementById('form0');
      
		if(currentForm){
			
			var fmAction = currentForm.action;
			if(currentForm.action.indexOf("?")==-1){
				currentForm.action += "?export_data_grid_id="+gridId;
			}else{
				currentForm.action += "&export_data_grid_id="+gridId;
			}
			if(type){
				currentForm.action += "&export_data_grid_type="+type;
			}
			if(exportCells && exportCells!=""){
				currentForm.action += "&export_data_grid_cells="+exportCells;
			}
			Matrix.submitForm(currentForm.id);
			currentForm.action = fmAction;
		}
		
  }

}

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

	Matrix.getDataGridEmptyCellValue=function(){
		var _emptyCellValue = "&nbsp;";
		return _emptyCellValue;
	}

	// 格式化表格自定义类型数据显示值
	Matrix.conditionFormatter = function(value,options,row,index){
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
			var _emptyCellValue = Matrix.getDataGridEmptyCellValue();
			newValue = _emptyCellValue;
		}

		return newValue;
	};
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
	//选择单个用户
	function mSelectUser(clientId,id){
		//Matrix.showMask();
		if(document.getElementById('is_mobile_request') && document.getElementById('is_mobile_request').value == 'true'){
			 var pageii = layer.open({
					id:clientId,
					type : 2,
					
					title : ['单选人员'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '90%', '90%' ],
					content : webContextPath+'/office/html5/select/SingleSelectPerson.jsp?iframewindowid=SelectUserDialog&clientId='+clientId+'&id='+id
					});
		}else{
			 var pageii = layer.open({
					id:clientId,
					type : 2,
					
					title : ['单选人员'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '70%', '90%' ],
					content : 'office/html5/select/SingleSelectPerson.jsp?iframewindowid=SelectUserDialog&clientId='+clientId+'&id='+id
					});
		}
	}

	//单个用户回调方法
	function onSelectUserDialogClose(data){
		if(data!=null){
			var userName = data.names;var userId = data.ids;
			document.getElementById(data.clientId).value=userName;
			document.getElementById(data.id).value=userId;
			var ele = document.getElementById(data.clientId);
			ele.focus();ele.blur();
//			document.getElementById(data.clientId).blur();
		}
	}

	//选择多个用户
	function mSelectUsers(clientId,id){
		if(document.getElementById('is_mobile_request') && document.getElementById('is_mobile_request').value == 'true'){
			var pageii = layer.open({
				id:clientId,
				type : 2,
				
				title : ['多选人员'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '100%', '100%' ],
				content : 'office/html5/select/MultiSelectPerson.jsp?iframewindowid=SelectUsersDialog&clientId='+clientId+'&id='+id
				});
		}else{
			var pageii = layer.open({
				id:clientId,
				type : 2,
				
				title : ['多选人员'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '70%', '90%' ],
				content : 'office/html5/select/MultiSelectPerson.jsp?iframewindowid=SelectUsersDialog&clientId='+clientId+'&id='+id
				});
		}
	}

	//多个用户回调方法
	function onSelectUsersDialogClose(data){
		if(data!=null){
			var userName = data.names;var userId = data.ids;
			document.getElementById(data.clientId).value=userName;
			document.getElementById(data.id).value=userId;
			document.getElementById(data.clientId).blur();
		}
	}

	//选择单个部门
	function mSelectDep(clientId,id){
		var pageii = layer.open({
			id:clientId,
			type : 2,
			
			title : ['单选部门'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '90%' ],
			content : webContextPath+'/office/html5/select/SingleSelectDep.jsp?iframewindowid=SelectDepDialog&clientId='+clientId+'&id='+id
			});
	}

	//单个部门回调方法
	function onSelectDepDialogClose(data){
		if(data!=null){
			var depName = data.names;
			var sequenceId = data.ids;
			document.getElementById(data.clientId).value=depName;
			document.getElementById(data.id).value=sequenceId;
			var ele = document.getElementById(data.clientId);
			ele.focus();ele.blur();
//			document.getElementById(data.clientId).blur();
		}
	}
	//选择多个部门
	function mSelectDeps(clientId,id){
		if(document.getElementById('is_mobile_request') && document.getElementById('is_mobile_request').value == 'true'){
			var pageii = layer.open({
				id:clientId,
				type : 2,
				
				title : ['多选部门'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '100%', '100%' ],
				content : 'office/html5/select/MultiSelectDep.jsp?iframewindowid=SelectDepsDialog&clientId='+clientId+'&id='+id
				});	
		}else{
			var pageii = layer.open({
				id:clientId,
				type : 2,
				
				title : ['多选部门'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '70%', '90%' ],
				content : 'office/html5/select/MultiSelectDep.jsp?iframewindowid=SelectDepsDialog&clientId='+clientId+'&id='+id
				});	
		}
	}

	//多个部门回调方法
	function onSelectDepsDialogClose(data){
		if(data!=null){
			var depName = data.names;
			var sequenceId = data.ids;
			document.getElementById(data.clientId).value=depName;
			document.getElementById(data.id).value=sequenceId;
			document.getElementById(data.clientId).blur();
		}
	}
	
	Matrix.str2Json = function(data){
	   return eval(data);
	}

//返回数据表格返回的第一行
Matrix.getGridSelection = function(gridId){
   var selections = $('#'+gridId+'_table').bootstrapTable('getSelections');
   return selections;   
/*   if(selections.length>0)
      return selections[0];
   else 
      return null;
*/         
}
//返回数据表格所有选中行
Matrix.getGridSelections = function(gridId){
   var selections = $('#'+gridId+'_table').bootstrapTable('getSelections');
   return selections;   
}

//返回数据表格所有数据
Matrix.getGridData = function(gridId){
   var data = $('#'+gridId+'_table').bootstrapTable('getData',true);
   return data;
}

//修改数据表格指定行
Matrix.updateRow = function(gridId,index, row){
   $('#'+gridId+'_table').bootstrapTable('updateRow',row);
}

//为SmartClient版本迁移提供
function isc(){}

 function jsonFunc(){
    this.encode=function(data){
		return JSON.stringify(data);
	}
    this.decode=function(str){
        str = str.replaceAll("'", "\"");
		return JSON.parse(str);    
    }
 }

isc.JSON=new jsonFunc();

//窗口定义
isc.say=function(message){
	//isc.say(message);
	//layer.msg(message, {icon: 1});
	Matrix.say("提示信息",message);
}

//警告窗口
isc.warn=function(message){
	//isc.warn(message);
	//layer.msg(message, {icon: 0});
	Matrix.warn("警告信息",message);
}

//确认窗口
isc.confirm=function(message,callback,properties){
	// callback param is result
	// properties eg: { buttons : [Dialog.OK, Dialog.CANCEL] }
	//isc.confirm(message,callback,properties);
	if(properties!=null&&properties!=""){
		//layer.confirm( message,{  time: 0,properties,yes:function (index) {layer.close(index);callback()},no:function (index){Matrix.hideMask();return false;}});
	}else{
		layer.confirm( message,{  time: 0,btn: ['确定', '取消'],yes:function (index) {layer.close(index);callback()},no:function (index){Matrix.hideMask2();return false;}});
	}
}

//提示信息窗口
Matrix.say=function(message,title){
	//isc.say(message);
	toastr.options = {
	  "closeButton": true,
	  "positionClass": "toast-top-center",
	  "progressBar": false
	}
   	 toastr.info(message,title);
}

//提示信息窗口
Matrix.info=function(message,title){
	//isc.say(message);
	toastr.options = {
	  "closeButton": true,
	  "positionClass": "toast-top-center",
	  "progressBar": false
	}
   	 toastr.info(message,title);
}

//警告窗口
Matrix.warn=function(message,title){
	//isc.warn(message);
	toastr.options = {
	  "closeButton": true,
	  "positionClass": "toast-top-center",
	  "progressBar": false
	}
   	toastr.warning(message,title);
	
}

//成功信息
Matrix.success=function(message,title){
	//isc.warn(message);
	toastr.options = {
	  "closeButton": true,
	  "positionClass": "toast-top-center",
	  "progressBar": false
	}
   	toastr.success(message,title);
	
}

//错误信息
Matrix.error=function(message,title){
	//isc.warn(message);
	toastr.options = {
	  "closeButton": true,
	  "positionClass": "toast-top-center",
	  "progressBar": false
	}
   	toastr.error(message,title);
	
}


//确认窗口
Matrix.confirm=function(message,callback,properties){
	// callback param is result
	// properties eg: { buttons : [Dialog.OK, Dialog.CANCEL] }
	isc.confirm(message,callback,properties);
}

String.prototype.replaceAll = function (FindText, RepText) {
    regExp = new RegExp(FindText, "g");
    return this.replace(regExp, RepText);
}

function MDataGrid001(){}

//返回数据表格返回的第一行
MDataGrid001.getSelection = function(){
	return Matrix.getGridSelection('DataGrid001'); 
}

//返回数据表格所有选中数据
MDataGrid001.getSelections = function(){
	return Matrix.getGridSelections('DataGrid001');   
}

//返回数据表格所有数据
MDataGrid001.getData = function(){
   return Matrix.getGridData('DataGrid001');   
}



Matrix.validateDataGridSelection=function(dataGridId){
	if(Matrix.getGridSelection(dataGridId)==null || Matrix.getGridSelection(dataGridId).length==0){
		Matrix.warn("没有选中表格数据！");
		return false;
	}
	return true;
}
//查询数据表格
Matrix.queryDataGridData=function(dataGridId){
	$('#'+dataGridId+'_table').pageNumber = 1;
	$('#'+dataGridId+'_table').bootstrapTable('setPageNumber', 1);
   $('#'+dataGridId+'_table').bootstrapTable('refresh');
}

//刷新数据表格
Matrix.refreshDataGridData=function(dataGridId){
   if(document.getElementById(dataGridId+"_selection"))
   		document.getElementById(dataGridId+"_selection").value = "";
   if(document.getElementById(dataGridId+"_selections"))		
   		document.getElementById(dataGridId+"_selections").value = "";
   if(document.getElementById(dataGridId+"_all_rows"))		
   		document.getElementById(dataGridId+"_all_rows").value = "";
   $('#'+dataGridId+'_table').bootstrapTable('refresh');
}

Matrix.getDataGridSelectionRecordProperty=function(dataGridId, propName){
   
   var selections = Matrix.getGridSelection(dataGridId);
   if(selections.length>0){
      var selection = selections[0];
   
      return selection[propName];
   }else{
   		return null;
   }
}


// 转换表单内表格数据
Matrix.convertDataGridDataOfForm=function(formId){

			    if(document.getElementById("DataGrid001_selections")){
					var selectionResult = JSON.stringify(MDataGrid001.getSelection('DataGrid001'));
			    	document.getElementById("DataGrid001_selections").value=selectionResult;
			    }	
			    if(document.getElementById("DataGrid001_selection")){
			        var selections = MDataGrid001.getSelection('DataGrid001');
			        if(selections.length>0){
      					selection = selections[0];
						var selectionsResult = JSON.stringify(selection);
				    	document.getElementById("DataGrid001_selection").value=selectionsResult;
			        }
			    }
			      if(document.getElementById("DataGrid002_selections")){
					var selectionResult = JSON.stringify(Matrix.getGridSelection('DataGrid002'));
			    	document.getElementById("DataGrid002_selections").value=selectionResult;
			    }	
			    if(document.getElementById("DataGrid002_selection")){
			        var selections = Matrix.getGridSelection('DataGrid002');
			        if(selections.length>0){
      					selection = selections[0];
						var selectionsResult = JSON.stringify(selection);
				    	document.getElementById("DataGrid002_selection").value=selectionsResult;
			        }
			    }
			      if(document.getElementById("DataGrid003_selections")){
					var selectionResult = JSON.stringify(Matrix.getGridSelection('DataGrid003'));
			    	document.getElementById("DataGrid003_selections").value=selectionResult;
			    }	
			    if(document.getElementById("DataGrid003_selection")){
			        var selections = Matrix.getGridSelection('DataGrid003');
			        if(selections.length>0){
      					selection = selections[0];
						var selectionsResult = JSON.stringify(selection);
				    	document.getElementById("DataGrid003_selection").value=selectionsResult;
			        }
			    }
			    

}

function formatDataDate(record,value){
	return value;
}	

//删除树节点
postRemoveTreeNode=function(treeNode,removeOperation){   
	// 异步删除树节点
	// Callback for handling a successful load.
	var treeId =document.getElementById("matrix_treeId").value;
	var curTree = $("#"+treeId);// 获得所属tree
	 var gotData = function(data){
	 	if(data){
	 		data = data.data;
			if(data && data.length>0){
				data=isc.JSON.decode(data);
				if(data && data.result){
				  if(removeOperation){
				    	removeOperation(treeNode);
				  }			  
				}
			}
		}
	};
	
	// 父节点		
	var parentNode = curTree.jstree('get_node',curTree.jstree('get_parent',treeNode)).original;
	
	var content = {};
	content["treeComponentId"] = treeId.replace("_div","");
	content["actionType"] = "remove";
	var nodeData = "{currentNode:"+isc.JSON.encode(treeNode)+",parentNodeData:"+isc.JSON.encode(parentNode)+"}";
	content["data"] = nodeData;
	content[Matrix.REFRESH_COMPONENT_IDS] = treeId.replace("_div","")+",";
	Matrix.send("form0",content,gotData);
},
handRemoveTreeNode=function(treeNode){
	// 删除树节点    
	var treeId =document.getElementById("matrix_treeId").value;
	var curTree = $("#"+treeId);// 获得所属tree
	if(curTree){
		curTree.jstree(true).delete_node([treeNode.id]);
	}
}
Matrix.deleteTreeNode=function(target,message,deleteCallback){
	//Matrix.confirm(message,postRemoveTreeNode(target,deleteCallback));  
	layer.confirm( message,{  time: 0,yes:function (index) {layer.close(index);postRemoveTreeNode(target,deleteCallback)},no:function (index){Matrix.hideMask2();return false;}});
}
//树节点点击事件 
nodeClick=function(viewer, node, recordNum){
	// 点击树节点
	var clickFun = null;// this.handSelect;
//	if(node.onSelectAction){
//	  if(node.onSelectAction=="true"){ 
//	 	  clickFun=this.postSelect;	
//	  }
//  	}else if(viewer.onSelectAction){
//	 	if(viewer.onSelectAction=="true"){
//	 	 	clickFun=this.postSelect;	
//		}
//  	}
//  	if(viewer.onSelect){
//	 	if(viewer.onSelect!=""){
//	 	  	clickFun=eval(viewer.onSelect);
//	 	}
//  	}
    if(node.onSelect){
    	if(node.onSelect!=""){   	
    		clickFun=eval(node.onSelect);  
      	}	
  	}
  	clickFun(viewer, node, recordNum);
}

/********************************************只为smartClient和html5平滑迁移***********************************************************************/
isc_Snapbar_0={};
MHorizontalContainer001Panel2={};
MHorizontalContainer001Panel2.setBackgroundColor=function(){};

Matrix.addRepeatLastRow=function(gridId){
	addRepeatLastRow(gridId);
}

function addRepeatLastRow(gridId){  //重复表添加一行


   var datalistId = gridId + "D";
   var obj = null;
//   var obj = _clickTd;  //传所在的td element
   
   var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

   if(obj == null || clickDataGrid != datalistId){   //没有选中行,添加到最后一行
   	  var tableId = gridId + "-table";
	  var table = document.getElementById(tableId);
	  var rows = table.rows.length;
      obj = table.rows[rows-1].cells[0];
   }
   
     var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');     //重复表数据行号
     var deleterowsvar = Matrix.getFormItemValue(datalistId+'_delrows');//删除数据行号
     var max = 0;
     var rowsArr = [];
     var delarr = [];
     if(rowsvar!=""&&rowsvar!=null){
         rowsArr = rowsvar.split(",");
      }
     if(deleterowsvar!=""&&deleterowsvar!=null){
	     delarr = deleterowsvar.split(",");
     }
     
     if(rowsArr.length == 0){
        max = 0;
     }else{
	     var c = rowsArr.concat(delarr);
	     for(var i=0;i<c.length;i++){
	            if(parseInt(c[i])>parseInt(max))
		            max = c[i];
	     }
     }
//     var addindex = parseInt(max)+1+"";
     var addindex = parseInt(max)+"";
   
   Matrix.addRepeatRowForTable(obj,null,datalistId,addindex);
}


function addRowsOfRepeatGrid(gridId, data){  //重复表添加多行

    var datalistId = gridId + "D";
    var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

    var tableId = gridId + "-table";
    var table = document.getElementById(tableId);
    var rows = table.rows.length;
    obj = table.rows[rows-1].cells[0];
   
     var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');     //重复表数据行号
     var deleterowsvar = Matrix.getFormItemValue(datalistId+'_delrows');//删除数据行号
     var max = 0;
     var rowsArr = [];
     var delarr = [];
     if(rowsvar!=""&&rowsvar!=null){
         rowsArr = rowsvar.split(",");
      }
     if(deleterowsvar!=""&&deleterowsvar!=null){
	     delarr = deleterowsvar.split(",");
     }
     
     if(rowsArr.length == 0){
        max = 0;
     }else{
	     var c = rowsArr.concat(delarr);
	     for(var i=0;i<c.length;i++){
	            if(parseInt(c[i])>parseInt(max))
		            max = c[i];
	     }
     }
     var addindex = parseInt(max)+"";
   
   Matrix.addRepeatRowsWithData(obj,null,datalistId,addindex, data);
   
   numberCheck(gridId); //重置序号
}

function getTrOfTable(gridId,rowIndex){
	  var tableId = gridId + "-table";
	  var table = document.getElementById(tableId);
      return table.rows[rowIndex+1];


}

function deleteRepeatCurRow(gridId){
	   var datalistId = gridId + "D";
	   var obj = _clickTd;  //传所在的td element

	 var rowIndex = Matrix.getFormItemValue('clickRowIndex');   //选中行的重复表数据序号
	 var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

     if(clickDataGrid != datalistId){
     	Matrix.say("请选中要删除行");
     	return;
     }

	Matrix.deleteRepeatRowForTable(obj,null,datalistId,rowIndex);
	
	_clickTd = null;

}

Matrix.deleteRowsOfRepeat=function(gridId){ //删除重复表中的选中行

	deleteRowsOfRepeatGrid(gridId);
}


function deleteRowsOfRepeatGrid(gridId){
	   var datalistId = gridId + "D";

	 var rowIndex = Matrix.getFormItemValue('clickRowIndex');   //选中行的重复表数据序号
	 var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

     var deletedRows = false;
	 var rowsvar = document.getElementById(gridId+'D_rows').value;//通过特定的class 获得复选框组集合
	 if(rowsvar!=null && rowsvar.length>0){
		   var rowsArr = rowsvar.split(",");
    		for (var i = 0; i < rowsArr.length; i++) {
    			var rowIndex = rowsArr[i];
              	if(rowIndex>-1) {
              	    var checkEle = document.getElementById(gridId+'_trCheckBox_'+rowIndex); 
					var value = checkEle.value;
					if($("#"+gridId+'_trCheckBox_'+rowIndex).is(':checked')){
					//if(value=='1'||value=='true'){
					    var obj = checkEle.parentNode.parentNode.parentNode;
						Matrix.deleteRepeatRowForTable(obj,null,datalistId,rowIndex);
						deletedRows = true;
       				}
              	}		
			}
	 }

     if(deletedRows == false){
     	Matrix.say("请选中要删除行");
     	return;
     }

	//Matrix.deleteRepeatRowForTable(obj,null,datalistId,rowIndex);
	
	_clickTd = null;

}

Matrix.moveUpSelectedRow=function(gridId){ 
	moveUpSelectedRow(gridId);
}

//使表格行上移
function moveUpSelectedRow(gridId){ 
 	 var datalistId = gridId + "D";
	 var obj = _clickTd;  //传所在的td element
	 
	 var selectedCount = 0;
	 var rowIndex = 0;
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
	 if(rowsvar!=null && rowsvar.length>0){
		   var rowsArr = rowsvar.split(",");
    		for (var i = 0; i < rowsArr.length; i++) {
    			var rowNumber = rowsArr[i];
              	if(rowNumber>-1) {
              	    var checkEle = document.getElementById(gridId+'_trCheckBox_'+rowNumber); 
					var value = checkEle.value;
					if($("#"+gridId+'_trCheckBox_'+rowNumber).is(':checked')){
					    obj = checkEle.parentNode.parentNode.parentNode;
						selectedCount = selectedCount + 1;
						rowIndex = rowNumber;
       				}
              	}		
			}
	 }

     if(selectedCount == 0){
     	Matrix.say("请选中要上移行");
     	return;
     }

     if(selectedCount > 1){
     	Matrix.say("只能选中一行进行上移");
     	return;
     }

	 var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

     var curIndex = 0;   //当前行索引
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                curIndex = i;
                break;
             }
         }
    }
    
    if(curIndex == 0){
     	Matrix.say("第一行不能再往上移动!");
     	return;
    }
    
    curIndex = curIndex+1;  //加上标题行

	//通过链接对象获取表格行的引用
	 var tableId = gridId + "-table";
	  var table = document.getElementById(tableId);
	var _row=table.rows[curIndex];
	var _prerow=table.rows[curIndex-1];
	
	//如果不是第一行，则与上一行交换顺序
	if(_prerow){
		swapNode2(_row,_prerow);
	}
	
	//行号交换位置
	var rowsArr = [];
     var addrows = "";
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
		 var newrowsarr = [];
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                var value = rowsArr[i]; 
                newrowsarr[i]=rowsArr[i-1];
                newrowsarr[i-1]=value;
                //++i;
             }else{
				newrowsarr[i]=rowsArr[i];
             }
         }
         for(var i=0;i<newrowsarr.length;i++){
			 var a = newrowsarr[i];
				if(addrows!=""){
					addrows+=",";
				}
			 addrows+=a;
         }
    }

	Matrix.setFormItemValue(datalistId+'_rows',addrows);
	
	numberCheck(gridId);
}

//使表格行上移
function moveUpSelectedRow2(gridId){ 
 	 var datalistId = gridId + "D";
	 var obj = _clickTd;  //传所在的td element

	 var rowIndex = Matrix.getFormItemValue('clickRowIndex');   //选中行的重复表数据序号
	 var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

     if(clickDataGrid != datalistId){
     	Matrix.say("请选中要上移行");
     	return;
     }

     var curIndex = 0;   //当前行索引
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                curIndex = i;
                break;
             }
         }
    }
    
    if(curIndex == 0){
     	Matrix.say("第一行不能再往上移动!");
     	return;
    }
    
    curIndex = curIndex+1;  //加上标题行

	//通过链接对象获取表格行的引用
	 var tableId = gridId + "-table";
	  var table = document.getElementById(tableId);
	var _row=table.rows[curIndex];
	var _prerow=table.rows[curIndex-1];
	
	//如果不是第一行，则与上一行交换顺序
	if(_prerow){
		swapNode2(_row,_prerow);
	}
	
	//行号交换位置
	var rowsArr = [];
     var addrows = "";
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
		 var newrowsarr = [];
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                var value = rowsArr[i]; 
                newrowsarr[i]=rowsArr[i-1];
                newrowsarr[i-1]=value;
                ++i;
             }else{
				newrowsarr[i]=rowsArr[i];
             }
         }
         for(var i=0;i<newrowsarr.length;i++){
			 var a = newrowsarr[i];
				if(addrows!=""){
					addrows+=",";
				}
			 addrows+=a;
         }
    }

	Matrix.setFormItemValue(datalistId+'_rows',addrows);
	
	numberCheck(gridId);  //重置序号

}

Matrix.moveDownSelectedRow=function(gridId){ 
	moveDownSelectedRow(gridId);
}

//使表格行下移
function moveDownSelectedRow(gridId){ 
 	 var datalistId = gridId + "D";
	 var obj = _clickTd;  //传所在的td element
	 
	 var selectedCount = 0;
	 var rowIndex = 0;
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
	 if(rowsvar!=null && rowsvar.length>0){
		   var rowsArr = rowsvar.split(",");
    		for (var i = 0; i < rowsArr.length; i++) {
    			var rowNumber = rowsArr[i];
              	if(rowNumber>-1) {
              	    var checkEle = document.getElementById(gridId+'_trCheckBox_'+rowNumber); 
					var value = checkEle.value;
					if($("#"+gridId+'_trCheckBox_'+rowNumber).is(':checked')){
					    obj = checkEle.parentNode.parentNode.parentNode;
						selectedCount = selectedCount + 1;
						rowIndex = rowNumber;
       				}
              	}		
			}
	 }
	 
	 if(selectedCount == 0){
     	Matrix.say("请选中要下移行");
     	return;
     }

     if(selectedCount > 1){
     	Matrix.say("只能选中一行进行下移");
     	return;
     }
    
   var curIndex = 0;   //当前行索引
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                curIndex = i;
                break;
             }
         }

	    if(curIndex == (rowsArr.length-1)){
	        Matrix.say('最后一行,不能再下移!');
	        return;
	    }

    }  
    
    curIndex = curIndex+1;  //加上标题行

	//通过链接对象获取表格行的引用
	 var tableId = gridId + "-table";
	  var table = document.getElementById(tableId);
	var _row=table.rows[curIndex];
	var _nextrow=table.rows[curIndex+1];
	
	//如果不是最后一行，则与下一行交换顺序
	if(_nextrow){
		swapNode2(_row,_nextrow);
	}
	
	//行号交换位置
	var rowsArr = [];
     var addrows = "";
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
		 var newrowsarr = [];
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                var value = rowsArr[i]; 
                newrowsarr[i]=rowsArr[i+1];
                newrowsarr[i+1]=value;
                ++i;
             }else{
				newrowsarr[i]=rowsArr[i];
             }
         }
         for(var i=0;i<newrowsarr.length;i++){
			 var a = newrowsarr[i];
				if(addrows!=""){
					addrows+=",";
				}
			 addrows+=a;
         }
    }

	Matrix.setFormItemValue(datalistId+'_rows',addrows);

	numberCheck(gridId);  //重置序号

}

//使表格行下移
function moveBottomSelectedRow(gridId){ 
 	 var datalistId = gridId + "D";
	 var obj = _clickTd;  //传所在的td element
	 
	 var selectedCount = 0;
	 var rowIndex = 0;
	 var totalCount = 0;
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
	 if(rowsvar!=null && rowsvar.length>0){
		   var rowsArr = rowsvar.split(",");
    		for (var i = 0; i < rowsArr.length; i++) {
    			var rowNumber = rowsArr[i];
              	if(rowNumber>-1) {
              	    var checkEle = document.getElementById(gridId+'_trCheckBox_'+rowNumber); 
					var value = checkEle.value;
					if($("#"+gridId+'_trCheckBox_'+rowNumber).is(':checked')){
					    obj = checkEle.parentNode.parentNode.parentNode;
						selectedCount = selectedCount + 1;
						rowIndex = rowNumber;
       				}
              	}		
				totalCount = totalCount +1;
			}
	 }
	 
	 if(selectedCount == 0){
     	Matrix.say("请选中要下移行");
     	return;
     }

     if(selectedCount > 1){
     	Matrix.say("只能选中一行进行下移");
     	return;
     }
    
   var curIndex = 0;   //当前行索引
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                curIndex = i;
                break;
             }
         }

	    if(curIndex == (rowsArr.length-1)){
	        Matrix.say('最后一行,不能再下移!');
	        return;
	    }

    }  
    
    curIndex = curIndex+1;  //加上标题行

	//通过链接对象获取表格行的引用
	 var tableId = gridId + "-table";
	  var table = document.getElementById(tableId);
	  
	  while(curIndex <totalCount){
	    rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
	  	var _row=table.rows[curIndex];
		var _nextrow=table.rows[curIndex+1];
		
		//如果不是最后一行，则与下一行交换顺序
		if(_nextrow){
			swapNode2(_row,_nextrow);
		}
		
		//行号交换位置
		var rowsArr = [];
	     var addrows = "";
	     if(rowsvar!=null&&rowsvar!=""){
	         var rowsArr = rowsvar.split(",");
			 var newrowsarr = [];
			 var i =0;
	         while (i < rowsArr.length) {
	             if (rowsArr[i] == rowIndex){
	                var value = rowsArr[i]; 
	                newrowsarr[i]=rowsArr[i+1];
	                newrowsarr[i+1]=value;
	                ++i;
	             }else{
					newrowsarr[i]=rowsArr[i];
	             }
	             i++;
	         }
	         for(var i=0;i<newrowsarr.length;i++){
				 var a = newrowsarr[i];
					if(addrows!=""){
						addrows+=",";
					}
				 addrows+=a;
	         }
	    }
	
		Matrix.setFormItemValue(datalistId+'_rows',addrows);
		curIndex = curIndex+1;
	  }
	  

		numberCheck(gridId);  //重置序号


}


//使表格行下移
function moveDownSelectedRow2(gridId){ 
 	 var datalistId = gridId + "D";
	 var obj = _clickTd;  //传所在的td element

	 var rowIndex = Matrix.getFormItemValue('clickRowIndex');   //选中行的重复表数据序号
	 var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

     if(clickDataGrid != datalistId){
     	Matrix.say("请选中要下移行");
     	return;
     }

     var curIndex = 0;   //当前行索引
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                curIndex = i;
                break;
             }
         }

	    if(curIndex == (rowsArr.length-1)){
	        Matrix.say('最后一行,不能再下移!');
	        return;
	    }

    }
    
    
    curIndex = curIndex+1;  //加上标题行

	//通过链接对象获取表格行的引用
	 var tableId = gridId + "-table";
	  var table = document.getElementById(tableId);
	var _row=table.rows[curIndex];
	var _nextrow=table.rows[curIndex+1];
	
	//如果不是最后一行，则与下一行交换顺序
	if(_nextrow){
		swapNode2(_row,_nextrow);
	}
	
	//行号交换位置
	var rowsArr = [];
     var addrows = "";
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
		 var newrowsarr = [];
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                var value = rowsArr[i]; 
                newrowsarr[i]=rowsArr[i+1];
                newrowsarr[i+1]=value;
                ++i;
             }else{
				newrowsarr[i]=rowsArr[i];
             }
         }
         for(var i=0;i<newrowsarr.length;i++){
			 var a = newrowsarr[i];
				if(addrows!=""){
					addrows+=",";
				}
			 addrows+=a;
         }
    }

	Matrix.setFormItemValue(datalistId+'_rows',addrows);

	numberCheck(gridId);  //重置序号

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

Matrix.setCheckBoxChecked=function(id){
	if(id!=null && id.length>0){
		if(id.indexOf("_headCheckBox")>=0){//判断点击的是头复选框  editListId+"_headCheckBox"
			var editListId = id.substr(0,id.indexOf('_'));//获得editListId
			var checkBox = Matrix.getComponentById(id);//获得该复选框对象
			var value = checkBox.value;//获得复选框对象的值
			var rowsvar = document.getElementById(editListId+'D_rows').value;//通过特定的class 获得复选框组集合
			if($("#"+id).is(':checked')){
			//if(value=='1'||value=='true'){//如果选中  分别选中trChecks
				if(rowsvar!=null && rowsvar.length>0){
				   var rowsArr = rowsvar.split(",");
        			for (var i = 0; i < rowsArr.length; i++) {
        				var rowIndex = rowsArr[i];
              				if(rowIndex>-1) {
								//document.getElementById(editListId+'_trCheckBox_'+i).value=value;
								//document.getElementById(editListId+'_trCheckBox_'+i).checked=true;
								$("#"+editListId+'_trCheckBox_'+rowIndex).iCheck('check');
              				}
              		}		
				}
			}else{
				if(rowsvar!=null && rowsvar.length>0){
				   var rowsArr = rowsvar.split(",");
        			for (var i = 0; i < rowsArr.length; i++) {
        				var rowIndex = rowsArr[i];
              				if(rowIndex>-1) {
								//document.getElementById(editListId+'_trCheckBox_'+i).value='';
								//document.getElementById(editListId+'_trCheckBox_'+i).checked=false;
								$("#"+editListId+'_trCheckBox_'+rowIndex).iCheck('uncheck');
              				}
              		}		
				}
			}
		}else{
			//如果不是头复选框
			return false;
		}
	}
}

//使表格行上移至顶部
function moveTopSelectedRow(gridId){ 
 	 var datalistId = gridId + "D";
	 var obj = _clickTd;  //传所在的td element
	 
	 var selectedCount = 0;
	 var rowIndex = 0;
	 var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
	 if(rowsvar!=null && rowsvar.length>0){
		   var rowsArr = rowsvar.split(",");
    		for (var i = 0; i < rowsArr.length; i++) {
    			var rowNumber = rowsArr[i];
			if(rowNumber>-1) {
			    var checkEle = document.getElementById(gridId+'_trCheckBox_'+rowNumber); 
						var value = checkEle.value;
						if($("#"+gridId+'_trCheckBox_'+rowNumber).is(':checked')){
						    obj = checkEle.parentNode.parentNode.parentNode;
							selectedCount = selectedCount + 1;
							rowIndex = rowNumber;
					}
			}
		}
	 }

     if(selectedCount == 0){
     	Matrix.say("请选中要上移行");
     	return;
     }

     if(selectedCount > 1){
     	Matrix.say("只能选中一行进行上移");
     	return;
     }

     var clickDataGrid = Matrix.getFormItemValue('clickDataGrid');  //选中行所在的重复表id

     var curIndex = 0;   //当前行索引
     var rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
     if(rowsvar!=null&&rowsvar!=""){
         var rowsArr = rowsvar.split(",");
         for (var i = 0; i < rowsArr.length; i++) {
             if (rowsArr[i] == rowIndex){
                curIndex = i;
                break;
             }
         }
    }
    
    if(curIndex == 0){
     	Matrix.say("第一行不能再往上移动!");
     	return;
    }
    
    curIndex = curIndex+1;  //加上标题行

     while(curIndex > 1){
     	rowsvar = Matrix.getFormItemValue(datalistId+'_rows');
	     //通过链接对象获取表格行的引用
		 var tableId = gridId + "-table";
		  var table = document.getElementById(tableId);
		var _row=table.rows[curIndex];
		var _prerow=table.rows[curIndex-1];
		
		//如果不是第一行，则与上一行交换顺序
		if(_prerow){
			swapNode2(_row,_prerow);
		}
		
		//行号交换位置
		var rowsArr = [];
	     var addrows = "";
	     if(rowsvar!=null&&rowsvar!=""){
		 var rowsArr = rowsvar.split(",");
			 var newrowsarr = [];
		 for (var i = 0; i < rowsArr.length; i++) {
		     if (rowsArr[i] == rowIndex){
			var value = rowsArr[i]; 
			newrowsarr[i]=rowsArr[i-1];
			newrowsarr[i-1]=value;
			//++i;
		     }else{
			newrowsarr[i]=rowsArr[i];
		     }
		 }
		 for(var i=0;i<newrowsarr.length;i++){
				 var a = newrowsarr[i];
					if(addrows!=""){
						addrows+=",";
					}
				 addrows+=a;
		 }
	    }

		Matrix.setFormItemValue(datalistId+'_rows',addrows);
		curIndex = curIndex -1;
     }
	
}

/*
 * entity 附件对象全路径
 * fileName 文件名属性编码
 * mappingType  文件类型属性编码
 * comId  文件ID属性编码
 * idValue 实际文件编码值
 * storeType  存储类型  file/db
 * filePath   文件存储路径
 */

//预览文件
function mViewFile(entity,fileName,mappingType,comId,idValue,storeType,filePath){
	 var viewFile = layer.open({
		id:'viewFile',
		type : 2,
		
		title : ['文件预览'],
		closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
		shadeClose: false, //开启遮罩关闭
		area : [ '70%', '90%' ],
		content : 'uploadFileHelperServlet?iframewindowid=ViewFile&entity='+entity+'&name='+fileName+'&mappingType='+mappingType+'&id='+comId+'&idValue='+idValue+'&type=viewFile&storeType='+storeType+'&filePath='+filePath
		});
}

//序号
function numberCheck(datalistId){
	var tableId = datalistId+"-table";
	if(datalistId.endWith('D'))
		tableId = datalistId.substring(0,datalistId.length-1)+"-table";
    var length = $("#"+tableId).children().children("tr").length;
	for(var i=0;i<=length;i++){
		if($("#"+tableId+" tr td.subtableNumberStyle"))
			$("#"+tableId+" tr td.subtableNumberStyle").eq(i).find("label").html(i);
	}
}

//显示查询窗口
function showSelectWindow(targetFormId,dialogId, index){
 var newData = Matrix.formToObject("form0");
	  newData["targetFormId"]=targetFormId;
	  newData["index"]=index;
      newData["matrix_user_command"]='getQueryFilter';
      var url = webContextPath+'/matrix.rform?matrix_send_request=true&matrix_form_tid='+document.getElementById("matrix_form_tid").value;
      Matrix.sendRequest(url,newData,function(data){
           Matrix.setFormItemValue('mQuerySetConditions',data.data);
		   Matrix.showWindow(dialogId);	

      });
}

//临时方法
function setComponetSec(gridId, comId, comType, secType, isRequired) {
	var rowsvar = Matrix.getFormItemValue(gridId + '_rows');
	if (rowsvar == "" || rowsvar == null) {
		return;
	}

	var rowsArr = rowsvar.split(",");
	for (var i = 0; i < rowsArr.length; i++) {
		var index = rowsArr[i];
		var id = comId + '_' + index;
		// var com = eval('M'+comId+'_'+index);
		// com.setCanEdit(false);
		// ///////////////////////////////
		if (comType == '0' || comType == '4' || comType == '5') {
			var matrixElement = document.getElementById(id);
		}
		if (secType == 0) {// // 浏览不可编辑
			if (comType == '6') {// 附件上传
				if (document.getElementById(id + '_div')) {
					document.getElementById(id + '_div').style.display = "";
				}
			} else {
				var displayId = id + "_div";
				if (document.getElementById(displayId)) {// 设置组件显示
					document.getElementById(displayId).style.display = "inline-table";
				}
			}
			if (comType == '0') {
				matrixElement.setAttribute('readOnly', 'true');
				matrixElement.parentNode.setAttribute('readOnly', 'true');
				matrixElement.className = matrixElement.className
						+ ' textItemReadOnly ';
			} else if (comType == '1') {// 是日期控件
				var cObj = document.getElementById(id);
				cObj.readOnly = true;
				var comEle = document.getElementById(id);
				comEle.className = comEle.className.replaceAll2(' required ',
						' ');
				comEle.className = comEle.className + ' textItemReadOnly ';
			} else if (comType == '2' || comType == '3') {// 2-复选按钮组3-单选按钮组
				var length = document.getElementById(displayId).childNodes[0].rows.length;
				length = 12;
				for (var j = 0; j < length; j++) {
					var element = id + "_" + j;
					var matrixElement = document.getElementById(element);
					if (!matrixElement)
						break;
					matrixElement.readOnly = true;
					matrixElement.className = matrixElement.className
							+ ' textItemReadOnly ';
				}
			} else if (comType == '4') {// 弹出选择
				var displayPopButton = id + "_button_div";
				if (document.getElementById(displayPopButton)) {
					document.getElementById(displayPopButton).style.display = "none";
				}
				var matrixPopId = document.getElementById(id);
				matrixPopId.readOnly = true;
				matrixPopId.className = matrixElement.className
						+ ' textItemReadOnly ';
			} else if (comType == '5') {// 选人选部门
				matrixElement.className = matrixElement.className
						+ ' textItemReadOnly ';
				matrixElement.style.backgroundColor = "";
				var imgEle = document.getElementById(id + '_btn');
				imgEle.setAttribute('readonly', 'true');
			} else if (comType == '6') {// 附件上传
				if (document.getElementById(id + 'box')) {
					document.getElementById(id + 'box').style.display="none";
					document.getElementById(id + 'box').setAttribute(
							'readOnly', 'true');
					document.getElementById(id + 'fileNameDIV').setAttribute(
							'readOnly', 'true');
				}
			}
		} else if (secType == 1) {// 编辑
			if (comType == '6') {// 附件上传
				if (document.getElementById(id + '_div')) {
					document.getElementById(id + '_div').style.display = "";
				}
			} else {
				var displayId = id + "_div";
				if (document.getElementById(displayId)) {// 设置组件显示
					document.getElementById(displayId).style.display = "inline-table";
				}
			}
			if (comType == '0') {
				matrixElement.removeAttribute('readOnly');
				matrixElement.parentNode.removeAttribute('readOnly');
				matrixElement.className = matrixElement.className.replaceAll2(
						' textItemReadOnly ', '');
			} else if (comType == '1') {// 是日期控件
				var cObj = document.getElementById(id);
				cObj.readOnly = false;
				var comEle = document.getElementById(id);
				comEle.className = comEle.className.replaceAll2(
						' textItemReadOnly ', '');
				comEle.className = comEle.className + ' required ';
			} else if (comType == '2' || comType == '3') {
				var length = document.getElementById(displayId).childNodes[0].rows.length;
				length = 12;
				for (var j = 0; j < length; j++) {
					var element = id + "_" + j;
					var matrixElement = document.getElementById(element);
					if (!matrixElement)
						break;
					matrixElement.readOnly = false;
					matrixElement.className = matrixElement.className
							.replaceAll2(' textItemReadOnly ', '');
				}
			} else if (comType == '4') {// 弹出选择
				var displayPopButton = id + "_button_div";
				document.getElementById(displayPopButton).style.display = "";
				var matrixPopId = document.getElementById(id);
				matrixPopId.readOnly = false;
				matrixElement.className = matrixElement.className.replaceAll2(
						' textItemReadOnly ', '');
			} else if (comType == '5') {// 选人选部门
				matrixElement.style.backgroundColor = "#fff";
				var imgEle = document.getElementById(id + '_btn');
				imgEle.removeAttribute('readonly');
				matrixElement.setAttribute('readonly', 'false');
				var comEle = document.getElementById(id);
				comEle.className = comEle.className.replaceAll2(
						' textItemReadOnly ', ' ');
			} else if (comType == '6') {// 附件上传
				if (document.getElementById(id + 'box')) {
					document.getElementById(id + 'box').style.display="";
					document.getElementById(id + 'box').removeAttribute('readonly');
					document.getElementById(id + 'fileNameDIV').removeAttribute('readonly');
				}
			}
		} else {// 隐藏
			var displayPopButton = id + "_div";
			document.getElementById(displayPopButton).style.display = "none";// 处理隐藏
		}// 添加 tr 和 tabpanlel 的显示隐藏
		if (isRequired == 'true') {// 必填
			if (comType == '0' || comType == '4' || comType == '5') {
				matrixElement.required = true;
				var matrixElement = document.getElementById(id);
				matrixElement.className = matrixElement.className
						+ ' required ';
			} else if (comType == '1') {
				var comEle = document.getElementById(id);
				comEle.className = comEle.className.replaceAll2(
						' textItemReadOnly ', ' ');
				comEle.className = comEle.className + ' required ';
			} else if (comType == '2' || comType == '3') {
				var element = id + "_" + 0;
				var matrixElement = document.getElementById(element);
				if (matrixElement)
					matrixElement.required = true;

			}
		} else if (isRequired == 'false') {// 非必填
			if (comType == '0' || comType == '4' || comType == '5') {
				matrixElement.required = false;
				var matrixElement = document.getElementById(id);
				matrixElement.className = matrixElement.className.replaceAll2(
						' required ', '');
			} else if (comType == '1') {
				var comEle = document.getElementById(id);
				comEle.className = comEle.className.replaceAll2(' required ',
						'');
			} else if (comType == '2' || comType == '3') {
				var element = id + "_" + 0;
				var matrixElement = document.getElementById(element);
				if (matrixElement)
					matrixElement.removeAttribute("required");
			}
		}
	}
}

String.prototype.replaceAll2 = function(s1,s2){
	return this.replace(new RegExp(s1,"gm"),s2);
}


//重复表上传附件变量
var mFileNumbers = {};
var mFileOldNumbers = {};
var mFileOldIndexs = {};
var mFileFiles = {};
var mFileMax = {};
var mFileAnnexType = {};

//重复表添加多附件
function mRepeatFileAddNextInput(obj,fileId) {
	    var number =  eval( "mFileFiles."+fileId+"number");
	    var oldnumber =  0;
	    var index =  eval( "mFileFiles."+fileId+"index");
	    var files =  eval( "mFileFiles."+fileId+"files");
	    var annexType =  eval( "mFileFiles."+fileId+"annexType");
	    var annexNum =  eval( "mFileFiles."+fileId+"annexNum");
	
	    if (!mRepeatFileCheckExtensions(obj, annexType)) {
	    	mRepeatFileShowMessage(fileType + '类型的文件不在允许的上传范围内');
	    	mRepeatFileRemoveInput(index,fileId);
	        mRepeatFileAddInput(index,fileId);
	        return false;
	    }
	    
	    if (!validateFileSize(obj, obj.id, 50)) {
	    	mRepeatFileRemoveInput(index,fileId);
	        mRepeatFileAddInput(index,fileId);
	        return false;
	    }
	    if (document.getElementById(fileId+"fileBaseViewTab")) {
	        var tabObj = document.getElementById(fileId+"fileBaseViewTab");
	        oldnumber = tabObj.tBodies[0].rows.length;
	    }
	    if (annexNum && ((number + oldnumber) >= annexNum)) {
	    	mRepeatFileRemoveInput(index,fileId);
	        mRepeatFileAddInput(index,fileId);
	        mRepeatFileShowMessage('您最多只能上传'+annexNum+'个文件');
	        return false;
	    }

	    
	    number++;
	    document.getElementById(fileId+"InputDIV" + index).style.display = 'none';
	    var s = obj.value.lastIndexOf("\\");
	    if (s < 0) {
	        s = obj.value.lastIndexOf("/");
	    }
	    var filename = obj.value.substring(s + 1);
	    var nameHTML = "";
	    nameHTML += " <li id = '"+fileId+"fileNameDIV" + index + "'class='margin_r_10' > ";
	    nameHTML += " <span title='" + filename + "' > ";
	    nameHTML += filename;
	    nameHTML += " </span>";
	    nameHTML += "<em  onclick=\"mRepeatFileDeleteOne('"+fileId+"',"+index+")\" class='ico16 affix_del_16' title='刪除'></em> ";
	    nameHTML += " </li>";
	    document.getElementById(fileId+"fileNameDIV").innerHTML += nameHTML;
	    files.put(index, obj.value);
	    index++;
	    mRepeatFileAddInput(index,fileId);

	    eval( "mFileFiles."+fileId+"index = "+ index);
	    eval( "mFileFiles."+fileId+"number = "+ number);
	    return true;
    
}

function mRepeatFileChecks() {
    var number =  eval( "mFileFiles."+fileId+"number");
    var files =  eval( "mFileFiles."+fileId+"files");
    var index =  eval( "mFileFiles."+fileId+"index");
    if (number == 0 || files.isEmpty()) {
        alert("选择您要上传的文件(单次上传小于50 MB)");
        return;
    }
    $("#b1").disable();
    //show();
    for (var i = 1; i <= index; i++) {
        var o = document.getElementById("file" + i);
        if (!o) {
            continue;
        }
        if (!o.value) {
            document.getElementById(fileId+"InputDIV" + i).parentNode.removeChild(document.getElementById(fileId+"InputDIV" + i));
        }
    }
    document.getElementById('form_upload').submit();
}

function mRepeatFileCheckExtensions(obj, enableType) {
    var filePath = obj.value;
    if (!filePath) {
        return false;
    }
    fileType = filePath.substring(filePath.lastIndexOf(".") + 1);
    if (enableType != null && enableType != "" && enableType.toUpperCase().indexOf(fileType.toUpperCase()) == -1) {
        return false;
    }
    return true;
}


function mRepeatFileAddInput(i,fileId) {
    var e = document.createElement("div");
    e.setAttribute("id", fileId+"InputDIV" + i);
    e.className = "file_unload clearfix";
    var fileNameIndexFlag = i;
    var inputHTML1 = "";
    inputHTML1 += "<a class=\"common_button2 common_button_icon file_click\" href=\"###\"><em class=\"ico16 affix_16\"></em>添加";
    inputHTML1 += " <input type = \"file\" name=\""+fileId+"file" + i + "\"  isRequired=\"true\" image=\"false\"  id=\""+fileId+"_fileInput" + i + "\" onchange=\"mRepeatFileAddNextInput(this,'"+fileId+"')\" onkeydown=\"return false\" onkeypress=\"return false\" style=\"width: 100%\"/>";
    inputHTML1 += "</a>";
    e.innerHTML = inputHTML1;
    document.getElementById(fileId+"InputDIV").appendChild(e);
}

function mRepeatFileDeleteOne(fileId,i) {
	debugger;
	var max = eval( "mFileFiles."+fileId+"max");
    if (max > 0) {
    	max--;
	    eval( "mFileFiles."+fileId+"max = "+ max);
    }
    //var pos = mRepeatFileGetIndex(i,fileId);
    mRepeatFileRemoveInput(i,fileId);
  
    var files =  eval( "mFileFiles."+fileId+"files");
    files.remove(i);
    
    //eval( "mFileFiles."+fileId+"files = "+ files);
}
function mRepeatFileShowMessage(msg) {
    alert(msg);
}

function mRepeatFileGetIndex(index,fileId) {
    var name = fileId+'fileNameDIV' + index;
    var container = document.getElementById(fileId+"fileNameDIV");
    var children = container.getElementsByTagName('div');
    var len = children.length;
    var result = 0;
    for (i = 0; i < len; i++) {
        var element = children[i];
        result++;
        if (name == element.id) {
            return result;
        }
    }
    return - 1;
}

function mRepeatFileRemoveInput(i,fileId) {
    var errorNode = false;
    //var pos = mRepeatFileGetIndex(i,fileId);
    try {
        document.getElementById(fileId+"InputDIV" + i).parentNode.removeChild(document.getElementById(fileId+"InputDIV" + i));
    } catch(e) {
        errorNode = true;
    }
    try {
        document.getElementById(fileId+"fileNameDIV" + i).parentNode.removeChild(document.getElementById(fileId+"fileNameDIV" + i));
    } catch(e) {
        errorNode = true;
    }
    if (!errorNode) {
        //var UFIDA_Upload1 = document.getElementById("UFIDA_Upload1");
        //UFIDA_Upload1.DeleteItemFromList(i - 1);
        
        var number =  eval( "mFileFiles."+fileId+"number");
        number--;
        eval( "mFileFiles."+fileId+"number = "+ number);
    }
}

function mRepeatFileDeleteFile(rowId,fileId,tabId,boxId){  
	$.ajax({ type: "post",  url: "/mbpm/uploadFileHelperServlet",  data:getFileJsonData(fileId) });
	var tabObj = document.getElementById(tabId);
	
	debugger;
	var tdEle = document.getElementById(rowId);
	if(tdEle){
		tdEle.style.display="none";
	}

	document.getElementById(boxId).style.cssText="display:block";
}
/**
 * 设置组件权限
 * 
 * @param comId
 * @returns
 */
Matrix.blurJSDisplay = function(comId) {
	debugger;
	var ftid = document.getElementById("matrix_form_tid").value;
	var url = webContextPath
			+ '/matrix.rform?comId='
			+ comId
			+ '&matrix_send_request=true&matrix_user_command=getSecurityById&matrix_form_tid='
			+ ftid;
	var formdata = Matrix.formToObject('form0');
	Matrix.sendRequest(
					url,
					formdata,
					function(data) {
						if (data != null && data.data != null) {
							var arrstr = data.data;
							var arr = eval(arrstr);
							for (var i = 0; i < arr.length; i++) {
								var element = arr[i];
								var id = element.id;
								var comType = element.comType;// 控件类型1-日期2-复选按钮组3-单选按钮组4-弹出选择
								// 设置必填 弹出选择是前面的输入框
								// 日期先不管
								// 单选按钮组和复选按钮组是代码选项设置必填
								// 其他都是基本组件
								var gridId = element.gridId;// 如果组件为重复表控件，有值，否则为空
								var secType = element.secType;// 0-浏览1-编辑2-隐藏
								var isRequired = element.isRequired;// 是否必填true-是必填false-不是必填
								// 如果是重复表字段，单独处理
								if (gridId != null && gridId != '') {
									setComponetSec(gridId, id, comType,
											secType, isRequired);
									continue;
								}
								if (comType == '0' || comType == '4'
										|| comType == '5') {
									var matrixElement = document
											.getElementById(id);
								}
								if (secType == 0) {// // 浏览不可编辑
									if (comType == '6') {// 附件上传
										if (document
												.getElementById(id + '_div')) {
											document
													.getElementById(id + '_div').style.display = "";
										}
									} else {
										var displayId = id + "_div";
										if (document.getElementById(displayId)) {// 设置组件显示
											document.getElementById(displayId).style.display = "inline-table";
										}
									}
									if (comType == '0') {
										matrixElement.setAttribute('readOnly',
												'true');
										matrixElement.parentNode.setAttribute(
												'readOnly', 'true');
										matrixElement.className = matrixElement.className
												+ ' textItemReadOnly ';
									} else if (comType == '1') {// 是日期控件
										var cObj = document.getElementById(id);
										cObj.readOnly = true;
										var comEle = document
												.getElementById(id);
										comEle.className = comEle.className
												.replaceAll2(' required ', ' ');
										comEle.className = comEle.className
												+ ' textItemReadOnly ';
									} else if (comType == '2' || comType == '3') {// 2-复选按钮组3-单选按钮组
										var length = document
												.getElementById(displayId).childNodes[0].rows.length;
										length = 12;
										for (var j = 0; j < length; j++) {
											var element = id + "_" + j;
											var matrixElement = document
													.getElementById(element);
											if (!matrixElement)
												break;
											matrixElement.readOnly = true;
											matrixElement.className = matrixElement.className
													+ ' textItemReadOnly ';
										}
									} else if (comType == '4') {// 弹出选择
										var displayPopButton = id
												+ "_button_div";
										if (document
												.getElementById(displayPopButton)) {
											document
													.getElementById(displayPopButton).style.display = "none";
										}
										var matrixPopId = document
												.getElementById(id);
										matrixPopId.readOnly = true;
										matrixPopId.className = matrixElement.className
												+ ' textItemReadOnly ';
									} else if (comType == '5') {// 选人选部门
										matrixElement.className = matrixElement.className
												+ ' textItemReadOnly ';
										matrixElement.style.backgroundColor = "";
										var imgEle = document.getElementById(id
												+ '_btn');
										imgEle.setAttribute('readonly', 'true');
									} else if (comType == '6') {// 附件上传
										if (document.getElementById(id
												+ 'box')) {
											document.getElementById(id + 'box').style.display="none";
											document.getElementById(id + 'box').setAttribute('readOnly',
											'true');
											document.getElementById(id + 'fileNameDIV').setAttribute('readOnly',
											'true');
										}
									}
								} else if (secType == 1) {// 编辑
									if (comType == '6') {// 附件上传
										if (document
												.getElementById(id + '_div')) {
											document
													.getElementById(id + '_div').style.display = "";
										}
									} else {
										var displayId = id + "_div";
										if (document.getElementById(displayId)) {// 设置组件显示
											document.getElementById(displayId).style.display = "inline-table";
										}
									}
									if (comType == '0') {
										matrixElement
												.removeAttribute('readOnly');
										matrixElement.parentNode
												.removeAttribute('readOnly');
										matrixElement.className = matrixElement.className
												.replaceAll2(
														' textItemReadOnly ',
														'');
									} else if (comType == '1') {// 是日期控件
										var cObj = document.getElementById(id);
										cObj.readOnly = false;
										var comEle = document
												.getElementById(id);
										comEle.className = comEle.className
												.replaceAll2(
														' textItemReadOnly ',
														'');
										comEle.className = comEle.className
												+ ' required ';
									} else if (comType == '2' || comType == '3') {
										var length = document
												.getElementById(displayId).childNodes[0].rows.length;
										length = 12;
										for (var j = 0; j < length; j++) {
											var element = id + "_" + j;
											var matrixElement = document
													.getElementById(element);
											if (!matrixElement)
												break;
											matrixElement.readOnly = false;
											matrixElement.className = matrixElement.className
													.replaceAll2(
															' textItemReadOnly ',
															'');
										}
									} else if (comType == '4') {// 弹出选择
										var displayPopButton = id
												+ "_button_div";
										document
												.getElementById(displayPopButton).style.display = "";
										var matrixPopId = document
												.getElementById(id);
										matrixPopId.readOnly = false;
										matrixElement.className = matrixElement.className
												.replaceAll2(
														' textItemReadOnly ',
														'');
									} else if (comType == '5') {// 选人选部门
										matrixElement.style.backgroundColor = "#fff";
										var imgEle = document.getElementById(id
												+ '_btn');
										imgEle.removeAttribute('readonly');
										matrixElement.setAttribute('readonly',
												'false');
										var comEle = document
												.getElementById(id);
										comEle.className = comEle.className
												.replaceAll2(
														' textItemReadOnly ',
														' ');
									} else if (comType == '6') {// 附件上传
										if (document.getElementById(id
												+ 'box')) {
											document.getElementById(id + 'box').style.display="";
											document.getElementById(id + 'box').removeAttribute('readonly');
											document.getElementById(id + 'fileNameDIV').removeAttribute('readonly');
										}
									}
								} else {// 隐藏
									var displayPopButton = id + "_div";
									document.getElementById(displayPopButton).style.display = "none";// 处理隐藏
								}// 添加 tr 和 tabpanlel 的显示隐藏
								if (isRequired == 'true') {// 必填
									if (comType == '0' || comType == '4'
											|| comType == '5') {
										matrixElement.required = true;
										var matrixElement = document
												.getElementById(id);
										matrixElement.className = matrixElement.className
												+ ' required ';
									} else if (comType == '1') {
										var comEle = document
												.getElementById(id);
										comEle.className = comEle.className
												.replaceAll2(
														' textItemReadOnly ',
														' ');
										comEle.className = comEle.className
												+ ' required ';
									} else if (comType == '2' || comType == '3') {
										var element = id + "_" + 0;
										var matrixElement = document
												.getElementById(element);
										if (matrixElement)
											matrixElement.required = true;

									} else if (comType =='6') {
										// 附件上传
										if (document.getElementById(id
												+ 'InputDIV')) {
											$($("input[id^='"+id+"_fileInput']")[0]).attr('isRequired','true');
											document.getElementById(id + 'fileNameDIV').setAttribute('required',
											'true');
										}
									}
								} else if (isRequired == 'false') {// 非必填
									if (comType == '0' || comType == '4'
											|| comType == '5') {
										matrixElement.required = false;
										var matrixElement = document
												.getElementById(id);
										matrixElement.className = matrixElement.className
												.replaceAll2(' required ', '');
									} else if (comType == '1') {
										var comEle = document
												.getElementById(id);
										comEle.className = comEle.className
												.replaceAll2(' required ', '');
									} else if (comType == '2' || comType == '3') {
										var element = id + "_" + 0;
										var matrixElement = document
												.getElementById(element);
										if (matrixElement)
											matrixElement
													.removeAttribute("required");
									} else if (comType =='6') {
										// 附件上传
										if (document.getElementById(id
												+ 'InputDIV')) {
											$($("input[id^='"+id+"_fileInput']")[0]).removeAttr('isRequired','true');
											document.getElementById(id + 'fileNameDIV').removeAttribute('required');
										}
									}
								}
							}
						}
					});
}

Matrix.clearPopupSelectData  = function(comId,clearDataCallback) {
	if($("#"+comId+"Id").length>0){
		$("#"+comId+"Id").val("");
	}
	$("#"+comId).val("").trigger("blur");
	if(clearDataCallback!=null) clearDataCallback.call(comId);
}

Matrix.exportEditList  = function(listId) {
	var tableId = listId + "-table";
	var formId="";
	if(document.getElementById("formId")){
		formId=document.getElementById("formId").value;
	}
	var url = webContextPath+'/matrix.rform?matrix_send_request=true&matrix_form_tid='+document.getElementById("matrix_form_tid").value+'&formId='+formId;
	var formId = 'exportFrom';
	if($("#" + formId).length>0){
		$("#" + formId).remove();
	}
	var html = '<form id="' + formId + '" action="' + url
			+ '" method="post" style="display:none">';
	html += '</form>';
	$('body').append(html);
	$("#" + tableId).clone(true).appendTo("#" + formId);  
	$("#" + formId).append("<input type='hidden' name='export_edit_list_id' value='"+listId+"' />");
	$("#" + formId).append("<input type='hidden' name='form0' id='form0' value='"+form0+"' />");
	//$("#" + formId).append("<input type='hidden' name='matrix_command_id' id='matrix_command_id' value='"+toolBarId+"' />");
	$("#" + formId).submit();//.remove();
	
}