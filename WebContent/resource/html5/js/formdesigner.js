
	//h5EditFormVar.jsp 数据源选业务对象回调
	function onM_SelectDataClose(data){
		elements = $("div.layui-layer-content");
		elements[0].firstChild.contentWindow.onM_SelectDataClose(data);
	}

//获取属性页的iframe窗口对象
	var matrixPropertyElements;
	var matrixPropertyIframe;


	$(function(){
		if(isc.MH.phase != 3){  //实施
			 matrixPropertyElements = $("div[eventproxy*='MMatrixPropertyCode']");
			 matrixPropertyIframe = matrixPropertyElements[0].firstChild;
		}
		
	})

//表单设计时字段属性页面选择数据字典回调
function onm_selectItemsClose(data){
	this.isc.MFH.winObj.onm_selectItemsClose(data);
}
	
//选择样式窗口回调 -- formproperty.jsp
function onm_styleClose(data){
	if(data){
		var style = data.style;
		matrixPropertyIframe.contentWindow.document.getElementById('style').value = style;
		//去后台保存
		var element = {};
		element.name = 'style';
		element.value = style;
		matrixPropertyIframe.contentWindow.updatePropertiesByType(element);
		//刷新
		isc.MH.reloadComponent();
	}
}

//表单联合校验条件窗口回调  -- formproperty.jsp
function onm_validationClose(data){
	if(data){
		var jointValidation = data.conditionText;
		matrixPropertyIframe.contentWindow.document.getElementById('jointValidation').value = jointValidation;
	    
	    var data2 = {};
	    data2['type'] = 'form';
		data2['attrName'] = 'jointValidation';
		data2['attrValue'] = jointValidation;
		$.ajax({
			 url: 'designer/designProperties_updatePropertiesByType.action',   
	         type: "post", 
	         dataType: "json", 
	         data: data2, 
	         success: function(data){ 
             } 
       });	
	}
}

//表单联合校验条件窗口回调  -- formproperty.jsp
function onm_validation2Close(data){
	if(data){
		var jointValidation = data.validationValue;
		
	    var data2 = {};
	    data2['type'] = 'form';
		data2['attrName'] = 'jointValidation2';
		data2['attrValue'] = jointValidation;
		$.ajax({
			 url: 'designer/designProperties_updatePropertiesByType.action',   
	         type: "post", 
	         dataType: "json", 
	         data: data2, 
	         success: function(data){ 
             } 
       });	
	}
}

//数据唯一选择窗口回调 -- formproperty.jsp
function onm_dataUniqueClose(data){
	if(data){
		var dataUnique = data.unionPKText;
		matrixPropertyIframe.contentWindow.document.getElementById('dataUnique').value = dataUnique;
	    
	    var data2 = {};
	    data2['type'] = 'form';
		data2['attrName'] = 'dataUnique';
		data2['attrValue'] = dataUnique;
		$.ajax({
			 url: 'designer/designProperties_updatePropertiesByType.action',   
	         type: "post", 
	         dataType: "json", 
	         data: data2, 
	         success: function(data){ 
             } 
       });	
	}      
}

//数据计算列表窗口回调  -- formproperty.jsp
function onm_dataFormulaClose(data){
	if(data){
		//暂时不需要 选择数据计算是一个按钮弹出
	}      	
}

//计算公式设置条件窗口回调  -- h5FormulaList.jsp
function onm_formulaClose(data){
	if(data){
		var setType = data.setType;   //0.普通设置    1.高级设置
		var suffixId = data.suffixId;   //选中行字段编码
		var index = data.index;    //记录的table选中行索引
		var item = this.isc.MFH.winObj.Matrix.getGridData('DataGrid001');   //所有数据
		var record = item[index];
		
		if(setType=='0'){
			this.isc.MFH.winObj.document.getElementById('formula_'+suffixId).value = data.conditionText;   //条件文本
			this.isc.MFH.winObj.document.getElementById('formulaSetId').value = data.conditionVal;     //记录当前选择行的计算公式条件编码
			
			record.formulaType = setType;     //条件类型
			record.formula = data.conditionText;     //条件
			record.formulaVal = data.conditionVal;     //条件编码
			this.isc.MFH.winObj.$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:record});
			
		}else if(setType=='1'){
			this.isc.MFH.winObj.document.getElementById('formula_'+suffixId).value = '【高级设置】';   //条件文本
			var formulaSetId = JSON.stringify(data.conditionVal);
			this.isc.MFH.winObj.document.getElementById('formulaSetId').value = formulaSetId;     //记录当前选择行的计算公式条件编码
			
			record.formulaType = setType;     //条件类型
			record.formula = '【高级设置】';     //条件
			record.formulaVal = formulaSetId;     //条件编码
			this.isc.MFH.winObj.$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:record});
	   }
	}      	
}

//数据过滤条件窗口回调 -- h5DataInMappingSet.jsp
function onm_popupConditionClose(data){
	this.isc.MFH.winObj.onpopupConditionClose(data);
}

//触发事件首次满足条件条件窗口回调 -- h5TriggerSet.jsp
function onm_firstConditionClose(data){
	this.isc.MFH.winObj.onfirstConditionClose(data);
}

//触发事件数据拷贝设置窗口回调 -- h5TriggerSet.jsp
function onm_dataCopySetClose(data){
	this.isc.MFH.winObj.ondataCopySetClose(data);
}

//触发事件选择消息模板窗口回调 -- h5TriggerSet.jsp
function onm_msgContentClose(data){
	this.isc.MFH.winObj.onmsgContentClose(data);
}

isc.defineClass("MatrixFormHandler").addProperties({
	mNewComponent:null,  //新建组件js对象
	mNewTitle:null,
	mNewSid:null,
	mFormvar:null,

	mIsRedrawFlag:false,   //当前是否为刷新的标志

	//记录一级弹出窗口对象
	winObj:null,
	MselectedComId:null,  //当前选中组件编码

	initComProp:function(selectItem){
		var id = selectItem.id;
		if(id == this.MselectedComId){  //如果当前就是该组件，不再做刷新
			return;
		}
	    this.MselectedComId = id;
	    
	    if(matrixPropertyIframe){
	    	 //主动触发失焦事件
		    matrixPropertyIframe.blur();
		    //初始控件属性
		    matrixPropertyIframe.contentWindow.initProperties(id);
	    }
	},

	//根据编码刷新当前组件
	redrawComponent:function(componentId){
	 	if(componentId!=null && componentId.length>0){
	 		var url = webContextPath+"/redraw.daction";
	 		var json = "{'command':'refreshComponent','comId':'"+componentId+"'}";
	 		var synJson = isc.JSON.decode(json);
	 		Matrix.sendRequest(url,synJson,function(data){
	 			if(data!=null && data.data!=''){
	 				isc.MFH.mIsRedrawFlag = true;
	 				var result = data.data;
	 				try {
	 					eval(result);
	 				}catch(err) {
	 					console.log("转换异常");
	 				}
	 				
	 				isc.MFH.mIsRedrawFlag =false;
	 			}
	 		});
	 	}
	},	

	//加载刷新右侧属性标签页
	initProperties:function(){
		var selectItem = isc.MH.selectedItems[0]
		var id = selectItem.id;
	    //初始控件属性
		matrixPropertyIframe.contentWindow.initProperties(id);
	},
 	
	clearComProp:function(){
		if(isc.MFH.mIsRedrawFlag == true){ //刷新控件的时候不执行属性页调整
			return;
		}
		if(matrixPropertyIframe){
			//默认无控件选择
			matrixPropertyIframe.contentWindow.$("#emptyMessage").show();
			matrixPropertyIframe.contentWindow.$("#controlProperties").hide();
		}
	},
	
	editComProp:function(selectItem){
		var params = "";
		debugger;
		
		if(isc.MH.phase != 3){  //实施阶段只有标签页和重复表可以双击
			if(selectItem.componentType){
				var componentType = this.getComponentType(selectItem);
				if(componentType == "EditList" || componentType == "TabContainer" || componentType == "comboBox"){
					
				}else{
					return;
				}
			}
		}
		
		if(isc.isA.MDPane(selectItem) || isc.isA.MDHTMLPane(selectItem)){
			//布局内容、控制区域双击弹出容器属性
			selectItem=selectItem.getMParent();
		}
		
		isc.MH.tempComponent = selectItem;
		if(selectItem==isc.MH.rootCanvas){
			//修改表单属性
			params+=isc.MC.SERVER_PARAMS.componentType+"="+isc.MC.COMPONENT_TYPE.Form;
			params +="&"+isc.MC.SERVER_PARAMS.command+"="+isc.MC.COMMAND.edit;
			
			matrixPropertyIframe.contentWindow.clickBlank();
			return;
		}else if(isc.isA.String(selectItem)){
			if(isc.MC.COMPONENT_TYPE.Form==selectItem){
				//修改表单属性
				params+=isc.MC.SERVER_PARAMS.componentType+"="+isc.MC.COMPONENT_TYPE.Form;
				params +="&"+isc.MC.SERVER_PARAMS.command+"="+isc.MC.COMMAND.edit;
			}
		}else if(isc.isA.MTComponent(selectItem)){
			//复合组件创建导航
			params+=isc.MC.SERVER_PARAMS.componentType+"="+selectItem.type;
			params+="&"+isc.MC.SERVER_PARAMS.componentIndex+"="+selectItem.mindex;
			params+="&id="+selectItem.id;
			params+="&name="+selectItem.name;
			params+="&entity="+selectItem.entity;
			params+="&formvar="+selectItem.formvar;
			if(selectItem.mparent!=null){
				params+="&"+isc.MC.SERVER_PARAMS.parentId+"="+selectItem.mparent.id;
			}
			params +="&"+isc.MC.SERVER_PARAMS.command+"="+isc.MC.COMMAND.create;
		}else{
			//修改组件属性
			var componentType = this.getComponentType(selectItem);
			if("userSelect" == componentType
					|| "userSelect" == componentType
					|| "depSelect" == componentType
					|| "depsSelect" == componentType
					|| "singleFile" == componentType
					|| "multiFile" == componentType
					|| "flowComment" == componentType
					|| "statisticalChart" == componentType
					|| "relativeArchive" == componentType
					|| "flowCommentList" == componentType
					){
				componentType = "CustomComponent";
			}
			params+=isc.MC.SERVER_PARAMS.componentType+"="+componentType;
			params+="&"+isc.MC.SERVER_PARAMS.componentId+"="+this.getComponentId(selectItem);
			params +="&"+isc.MC.SERVER_PARAMS.command+"="+isc.MC.COMMAND.edit;
		}
		var src = isc.MC.DESIGNER_REQUEST_URL+"?"+params;
		
		//params +="&command=create";
		//var src = isc.MC.DESIGNER_REQUEST_URL+"?command=showProperties";
		//src+="&componentId="+this.getComponentId(mcomponent);
		//设置属性窗口标题
	/*	MMDPropertyWindow.setTitle(this.getPropertWindowTitle(mcomponent));
		//MMDPropertyWindow.initSrc = src;
	
	    //实施阶段表单属性窗口大小调大
		if(mcomponent == 'form' && (isc.MH && isc.MH.phase==isc.MC.PHASE_CUSTOMIZE)){
			MMDPropertyWindow.setWidth('90%');
			MMDPropertyWindow.setHeight('90%');
	    }
		MMDPropertyWindow.setSrc(src);
		Matrix.showWindow("MDPropertyWindow");
	*/	//MMDPropertyWindow.show();
	
	  if(selectItem == 'form'){
		    var propDialog = layer.open({
				id:"propDialog",
				type : 2,
				
				title : ['编辑表单属性'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '85%', '90%' ],
				content : src
			});
	  }else{
		    var propDialog = layer.open({
				id:"propDialog",
				type : 2,
				
				title : ['编辑控件属性'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '85%', '90%' ],
				content : src
			});
	  }
	},
	
	getComponentId:function(mcomponent){
		// 获得组件编码
		if(isc.isA.MDMultiFileUpload(mcomponent)
			|| isc.isA.MDFileUpload(mcomponent)
			|| isc.isA.MDPaginator(mcomponent)){
			// 多文件上传、单文件上传、分页条
			return mcomponent.id;
		}
		
		if(isc.isA.MDDataList(mcomponent)){
			//datalist返回组件编码
			return mcomponent.componentId;
		}
		if(isc.isA.MDFormItem(mcomponent)){
			if(mcomponent.component)
				return mcomponent.component.id;
		}
		return mcomponent.id;
	},
	
	getComponentType:function(mcomponent){
		if(mcomponent.componentType){
			return mcomponent.componentType;
		}
		
		if(isc.isA.MDFormItem(mcomponent)){
			// 表单组件
			var item = mcomponent.component;
			if(isc.isA.SpinnerItem(item)){
				return isc.MC.COMPONENT_TYPE.SpinnerItem;
			}else if(isc.isA.RadioItem(item)){
				return isc.MC.COMPONENT_TYPE.RadioItem;
			}else if(isc.isA.RadioGroupItem(item)){
				return isc.MC.COMPONENT_TYPE.RadioGroupItem;
			}else if(isc.isA.ComboBoxItem(item)){
				return isc.MC.COMPONENT_TYPE.ComboBoxItem;
			}else if(isc.isA.PasswordItem(item)){
				return isc.MC.COMPONENT_TYPE.PasswordItem;
			}else if(isc.isA.TextAreaItem(item)){
				return isc.MC.COMPONENT_TYPE.TextAreaItem;
			}else if(isc.isA.DateItem(item)){
				return isc.MC.COMPONENT_TYPE.DateItem;
			}else if(isc.isA.TextItem(item)){
				return isc.MC.COMPONENT_TYPE.TextItem;
			} 
		}else if(isc.isA.MDVStack(mcomponent) || isc.isA.MDHStack(mcomponent)){
			// 布局判断是绝对还是相对
			if(mcomponent.mlayout!=null && mcomponent.mlayout=="absolute"){
				return isc.MC.COMPONENT_TYPE.AbsoluteLayout;
			}else{
				return isc.MC.COMPONENT_TYPE.RelativeLayout;
			}
		}
		return null;
	
	},

	
	getNewTitle:function(){
		return this.mNewTitle;
	},
	
	getFormvar:function(){
		return this.mFormvar;
	},

    getNewSid:function(){
    	return this.mNewSid;
    },
	
	setNewTitle:function(title){
		this.mNewTitle = title;
	},
	
	setFormVar:function(value){
		this.mFormvar = value;
	},
    
    setNewSid:function(sid){
    	this.mNewSid = sid;
    },
	
	getNewComponent:function(){
		return this.mNewComponent;
	},
	
	setNewComponent:function(mpcomponent){
		this.mNewComponent = mpcomponent;
	},
	
	editProp:function(mpcomponent){

		if(isc.MH.phase==3){  //设计开发
			if(!isc.isA.MTFormItem(mpcomponent) && mpcomponent.type == "table" ){ 
				this.mNewComponent = mpcomponent;
				var url = webContextPath+"/form/html5/admin/designer/createtable.jsp";
				var formVarPage = layer.open({
					id:"editFormVar",
					type : 2,
					
					title : ['添加表格'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '40%', '40%' ],
					content : url
				});
				return false;
			}
		}else{ //实施
			if(isc.isA.MTFormItem(mpcomponent) && mpcomponent.sid == null){   //新添加基本表单组件，如果当前为实施阶段，改为弹出配置信息后添加
				
				if(mpcomponent.mparent && mpcomponent.mparent.name == "TestLayout"){
					layer.msg("请先添加布局,基本组件只能添加到布局内!", {icon: 1});
					return false;
				}
				
				this.mNewComponent = mpcomponent;
				var componentType = mpcomponent.editorType;
				var url = webContextPath+"/datasource/formVarPro_controlLoadProperty.action?componentType="+componentType+"&parentNodeId=&editType=add&mainFormVarType=DataObject";
				var formVarPage = layer.open({
					id:"editFormVar",
					type : 2,
					
					title : ['添加字段'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '60%' ],
					content : url
				});
				return false;
			}	
			
			if(mpcomponent.type == 'CustomComponent'){
				this.mNewComponent = mpcomponent;
				var componentType = mpcomponent.customType;
				var url = webContextPath+"/datasource/formVarPro_controlLoadProperty.action?componentType="+componentType+"&parentNodeId=&editType=add&mainFormVarType=DataObject";
				var formVarPage = layer.open({
					id:"editFormVar",
					type : 2,
					
					title : ['添加字段'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '60%' ],
					content : url
				});
				return false;
			}
			
			if(!isc.isA.MTFormItem(mpcomponent) && mpcomponent.type == "table" ){ 
				
				//判断如果同级的包括表格，默认添加到最后
				var mparent = mpcomponent.mparent;
				var children = mparent.children;
				for(var i=0;i<children.length;i++){
					var item = children[i];
					if("table" == item.componentType){
						mpcomponent.mindex = children.length;
						debugger;
						break;
					}
				}	
				
				this.mNewComponent = mpcomponent;
				var url = webContextPath+"/form/html5/admin/designer/createtable.jsp";
				var formVarPage = layer.open({
					id:"editFormVar",
					type : 2,
					
					title : ['添加表格'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '40%', '40%' ],
					content : url
				});
				return false;
			}
		}
		
		//从数据源拖入添加的控件,构造MTFormItem对象
		if(!isc.isA.MTFormItem(mpcomponent) && mpcomponent.sid){  
			var newcomponent = MTFormItem.create();
			newcomponent.mtitle = mpcomponent.name;
			newcomponent.editorType = mpcomponent.editorType;
			newcomponent.sid = mpcomponent.sid;
			newcomponent.mindex = mpcomponent.mindex;
			newcomponent.mparent = mpcomponent.mparent;
			newcomponent.formvar = mpcomponent.formvar;
			newcomponent.entity = mpcomponent.entity;
			mpcomponent = newcomponent;
			
	    }else if(!isc.isA.MTFormItem(mpcomponent) && (mpcomponent.type == "List" || mpcomponent.type == "RList") ){  //子表
		    var reg=new RegExp("RAllListVar$"); 
			var newcomponent = null;
		    if(reg.test(mpcomponent.formvar)){
				newcomponent = isc.MTDataList.create();
	        }else{
				newcomponent = isc.MTEditList.create();
	        }
		    
			newcomponent.mtitle = mpcomponent.name;
			newcomponent.editorType = mpcomponent.editorType;
			newcomponent.mindex = mpcomponent.mindex;
			newcomponent.mparent = mpcomponent.mparent;
			newcomponent.formvar = mpcomponent.formvar;
			newcomponent.id = mpcomponent.id;
			newcomponent.entity = mpcomponent.entity;
			mpcomponent = newcomponent;
	    }else if(!isc.isA.MTFormItem(mpcomponent) && mpcomponent.type == "DataObject" ){  //子表
			var newcomponent = isc.MTEditForm.create();
		    
			newcomponent.mtitle = mpcomponent.name;
			newcomponent.editorType = mpcomponent.editorType;
			newcomponent.mindex = mpcomponent.mindex;
			newcomponent.mparent = mpcomponent.mparent;
			newcomponent.formvar = mpcomponent.formvar;
			newcomponent.id = mpcomponent.id;
			newcomponent.entity = mpcomponent.entity;
			mpcomponent = newcomponent;
	    }

		// 创建组件
		if(!isc.MH.enableToUpdate(mpcomponent.mparent)){
			// 父组件不可编辑则返回
			return false;
		}
		
		//基础控件判断可否创建,设置弹出输入参数
		if("RList" == mpcomponent.type){

		}else if( !mpcomponent.enableToCreate()){
			// 当前组件是否允许被创建
			return false;
		}
		
		if( mpcomponent.initComponent()){
			// 是否需要弹出输入参数
			return false;
		}
		
		// 确认创建组件
		isc.MH.createComponentSubmit(mpcomponent);
		
		return false;
		
	},
	
	createComponent:function(mpcomponent){
		// 确认创建组件
		isc.MH.createComponentSubmit(mpcomponent);
		
		return false;
	}
})

// 初始表单外挂核心对象
isc.MFH = MatrixFormHandler.create();



