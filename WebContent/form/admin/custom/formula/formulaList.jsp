<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<script type="text/javascript"><!--
		//离开保存
		window.onblur = function(){
				save();
			}
		function save(){
			Matrix.saveDataGridData("DataGrid001");
			      	 var data = Matrix.itemsToJson(MDataGrid001.getData());
			      	 if(data!=null&&data!=""){
			      	 var synJson={'data':'['+data+']'};
			      	  //var items=Matrix.getDataGridSelection("DataGrid001")
			      	 
				// synJson = isc.JSON.decode(synJson);
				//如果字符串小于20则认为没有数据
				//if(newData.length>20){
					if(synJson!=null){
						var url = "<%=request.getContextPath()%>/formula/formula_saveAll.action";
						Matrix.sendRequest(url,synJson,function(){
							return true;
						});
					}
					}	
		}
   function setInput(value,record,rowNum,colNum,grid){
       var input='<a><input type='+'text'+' id=';
      input+='\"';
      input+=(record.id);
      input+='\" ';
      input+='onclick=';
      input+='\"showWindow(this);';
      input+='\" value=\"';
	  input+=(record.formula)
	  input+='\"readonly=\"true\"'
      input+= '/></a>';
    return input;
    }
	//function setCheckBox(value,record,rowNum,colNum,grid){
	//var test=<%=request.getAttribute("test")%>;
	///if(record.type!=7){
      // var checkbox='<input id=';
      //checkbox+='\"';
      //checkbox+=('preDeduction_'+(rowNum+1));
      //checkbox+='\" ';
      //checkbox+="type=";
     // checkbox+='\"checkbox';
      //checkbox+='\" ';
     // checkbox+= '/>';
   // return checkbox;
	//}else{
	//	return;
	//	}
   // }
	//function save(record){
	//	var id=record.id;
		///var  preDeduction=record.preDeduction;//预扣除
		//var dependencyPro=record.dependencyPro;//关联属性
		//var formula=document.getElementById(record.id).value;
		//if(id!=null){
		//if((preDeduction!=null&&preDeduction!="")||(dependencyPro!=null&&dependencyPro!="")||(formula!=null&&formula!="")){
			// var newData="{\'data\':{'id':'";
			// newData+=id;
			// newData+="','preDeduction':";
			// newData+=preDeduction;
			// newData+=",'dependencyPro':'";
			 //newData+=dependencyPro;
			// newData+="','formula':'";
			// if(formula!='undefined'){
			// newData+=formula;
			// }
			 //newData+="'}}";
			 // var synJson = isc.JSON.decode(newData);
				//	var url='<%=request.getContextPath()%>/formula/formula_save.action';		     	
			     	//convertEditDataGridData('MDataGrid001',true);
			    // Matrix.sendRequest(url,synJson,function(data){
						 //   var callbackStr = data.data;
						  //  var callbackJson = isc.JSON.decode(callbackStr);
						  //  if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
						      	  
						  //  }else{
						   // 	parent.isc.say('保存失败');
						  //  }
						    
						//	},null);
		//}
		//}
	//}
	//function setSelect(value,record,rowNum,colNum,grid){
	//if(record.type!=7){
     //  var   select='<select name=' + ('t1_' + i) + ' id='+ ('t1_' + i) +'>'
      // select+='</select>'
    //return select;
		//}else{
		//	return;
		//}
    //}

	//校验下拉框
	function checkValue(value,form){
		var grid = form.grid;
		var record = grid.getRecord(grid.getEditRow());
		var b1=record.entityName;
		record.dependencyPro=value;
		if(value!=null&&value!=""&&value!='1'){
		var b2=value.substring(0,value.indexOf('.'));
		if(b1==b2){
			 grid.refreshFields();
			 grid.updateRecordComponents();
			// save(record);
			return true;
		}else{
			//grid.setEditValue (grid.getEditRow(), grid.getFieldNum('dependencyPro'), "1");	
			warn("只能选择同表单变量下的数据");
		}
		}
	}
	//赋值
	function onDataGrid001_formulaDialogClose(data){
	//	alert("asdfasdf2233");
		var flag = Matrix.getFormItemValue('flag');
		var record=Matrix.getDataGridSelection('DataGrid001');	
		var dataGrid = Matrix.getMatrixComponentById('DataGrid001');
		var editRowNum = dataGrid.getEditRow();	
			if(data!=null){
				
				if(data.setType=='0'){
					dataGrid.setEditValue(editRowNum,"formula",data.conditionText);
					dataGrid.setEditValue(editRowNum,"formulaVal",data.conditionVal);
					 Matrix.setFormItemValue('formulaSetId',data.conditionVal);
			  parent.document.getElementById("formulaSetId").value=data.conditionVal;
				}
				else if(data.setType=='1'){
					var formulaSetId = JSON.stringify(data.conditionVal);
					dataGrid.setEditValue(editRowNum,"formula","【高级设置】");
					dataGrid.setEditValue(editRowNum,"formulaVal",formulaSetId);
					 Matrix.setFormItemValue('formulaSetId',formulaSetId);
			  parent.document.getElementById("formulaSetId").value=formulaSetId;
				}
				
				dataGrid.setEditValue(editRowNum,"formulaType",data.setType);
				debugger;
				
				//alert(dataGrid.getEditValue(editRowNum,"id"));
				//flag = record.id.substr(0, flag.indexOf('.'));
				MDataGrid001_formulaDialog.initSrc = webContextPath+"/form/admin/custom/formula/betweenLayer.jsp?type="+data.setType+"&flag="+flag;
				MDataGrid001_formulaDialog.src = webContextPath+"/form/admin/custom/formula/betweenLayer.jsp?type="+data.setType+"&flag="+flag;	
				MDataGrid001.redraw();
				save();
			}else if(typeof(data) == "undefined"){
				
			}else{
				dataGrid.setEditValue(editRowNum,"formula","");
				dataGrid.setEditValue(editRowNum,"formulaVal","");
				Matrix.setFormItemValue('formulaSetId',"");
		  		parent.document.getElementById("formulaSetId").value="";
		  		
		  		MDataGrid001_formulaDialog.initSrc = webContextPath+"/form/admin/custom/formula/betweenLayer.jsp?type="+''+"&flag="+flag;
				MDataGrid001_formulaDialog.src = webContextPath+"/form/admin/custom/formula/betweenLayer.jsp?type="+''+"&flag="+flag;	
				MDataGrid001.redraw();
			}
		}
</script>
</head>
<body>
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
		action : "<%=request.getContextPath()%>/formula/formula_queryAll.action",
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
			action="<%=request.getContextPath()%>/formula/formula_queryAll.action"
			style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;"
			enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" /> <input
				type="hidden" name="flag" id="flag" /> <input type="hidden"
				name="is_mobile_request" /> <input type="hidden"
				id="matrix_form_tid" name="matrix_form_tid"
				value="7d741943-5cd8-441f-8dba-126cfb07db62" /> <input
				type="hidden" id="formulaSetId" name="formulaSetId" value="" /> <input
				type="hidden" id="matrix_form_datagrid_form0"
				name="matrix_form_datagrid_form0" value="" />
			<div type="hidden" id="form0_hidden_text_div"
				name="form0_hidden_text_div"
				style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState"
				id="javax.matrix.faces.ViewState" value="" />
			<table class="query_form_content"
				style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
				<tr>
					<td colspan="2"
						style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
						<div id="DataGrid001_div" class="matrixComponentDiv"
							style="width: 100%; height: 100%;">
							<script>
	//var MDataGrid001_DS =<%=session.getAttribute("newList")%>
	var MDataGrid001_DS = <%=request.getAttribute("formList")%>;
	isc.MatrixListGrid.create( {
		ID:"MDataGrid001",
		name:"DataGrid001",
		canSort:false,
		width:"100%",
		height:"100%",
		showAllRecords:true,
		displayId:"DataGrid001_div",
		position:"relative",
		canHover:true,
		fields:[{//行号
						title:"&nbsp;",
						name:"MRowNum",
						canSort:false,
						canExport:false,
						canDragResize:false,
						showDefaultContextMenu:false,
						autoFreeze:true,
						autoFitEvent:'none',
						width:45,
						canEdit:false,
						canFilter:false,
						autoFitWidth:false,
						formatCellValue:function(value, record, rowNum, colNum,grid){
								if(grid.startLineNumber==null)return '&nbsp;';
								return grid.startLineNumber+rowNum;
						}
					   },
			{
			title : "名称",
			matrixCellId : "name",
			name : "name",
			canEdit : false,
			editorType : 'Text',
			width:'20%',
			type : 'text'
		},  {
			title : "字段类型",
			matrixCellId : "type",
			name : "type",
			canEdit : false,
			editorType : 'select',
			width:'20%',
			type : 'text',
			valueMap:{'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'业务对象'},
			displayValueMap:{'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'业务对象'},
		},{
			title : "预扣除",
			matrixCellId : "preDeduction",
			name : "preDeduction",
			canEdit:true,
			width:40,
			editorType:'Checkbox',
			type:'boolean',
			showHover:false,
			editorProperties:{
				isDisabled:function isc_FormItem_isDisabled(){
										var _2=this.form;_3=_2.grid;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _5 = "type";
												var _6 = _3.fields.findIndex(_3.fieldIdProperty,_5);
												var _formItem = _3.getEditFormItem(_5);
												var _7 =_formItem.getValue();
												if((_7 && _7!=2)&&(_7 && _7!=3)&&(_7 && _7!=4)&&(_7 && _7!=5)&&(_7 && _7!=8)&&(_7 && _7!=9)){//为13,14时不可用
													return true;
				  			 					
										  		}
										  	}
										}
										var _1=this.disabled;
										if(!_1){
											if(this.parentItem!=null)
												_1=this.parentItem.isDisabled();
											else{
												_1=this.form.isDisabled();
												if(!_1&&this.containerWidget!=this.form)
												_1=this.containerWidget.isDisabled()
											}
										}
										return _1
									}
			},
			changed: function(form, item, value){
			debugger;
				var grid = Matrix.getMatrixComponentById("DataGrid001");
				var record = grid.getSelectedRecord();;
				var _preDeduction = grid.getEditFormItem("preDeduction");
				if(value==true){
				if(form!=null){
					if(record.type!=2&&record.type!=3&&record.type!=4&&record.type!=5&&record.type!=8&&record.type!=9){
						//item.checked=false;
						_preDeduction.setDisabled(true);
					}else{
						_preDeduction.setDisabled(false);
					}
					}
				}else{grid.setEditValue (grid.getRecordIndex (record), grid.getFieldNum('dependencyPro'), "1"); 
				}
				//Matrix.saveDataGridData("DataGrid001");
				//save(record);
				}
			},{
			title : "关联属性",
			matrixCellId : "dependencyPro",
			name : "dependencyPro",
			canEdit : true,
			editorType : 'select',
			width:'20%',
			type : 'text',
			showHover:false,
			valueMap:<%=request.getAttribute("disValueMap")%>,
		 	displayValueMap:<%=request.getAttribute("disValueMap")%>,
			changed:function(form, item, value){
					  			if(value){//选中时触发
					  				checkValue(value,form);
					  			}
					  		},
		
			editorProperties:{
			//是否可用
				isDisabled:function isc_FormItem_isDisabled(){
									var _2=this.form;_3=_2.grid;
										if(_3){
											var _4 = _3.getRecord(_3.getEditRow());
											if(_4){
												var _5 = "type";
												var _8="preDeduction";
												var _6 = _3.fields.findIndex(_3.fieldIdProperty,_5);
												var _formItem = _3.getEditFormItem(_5);
												var _preValue=_3.getEditFormItem(_8)
												var _7 =_formItem.getValue();
												var _10 =_preValue.getValue();
												if((_7 && _7==7)||_10==""||_10==null){//不等是为true
													return true;
				  			 					
										  		}
										  	}
										}
										var _1=this.disabled;
										if(!_1){
											if(this.parentItem!=null)
												_1=this.parentItem.isDisabled();
											else{
												_1=this.form.isDisabled();
												if(!_1&&this.containerWidget!=this.form)
												_1=this.containerWidget.isDisabled()
											}
										}
										return _1
									}}
		},{
			title : "计算公式",
			matrixCellId : "formula",
			name : "formula",
			canEdit : true,
			editorType : 'PopupSelect',
			width:'20%',
			type : 'text',
			//formatCellValue:function(value, record, rowNum, colNum,grid){return setInput(value,record,rowNum,colNum,grid);(value,record, rowNum, colNum,grid);}
		} ],
			autoSaveEdits:true,
			  autoFetchData:true,
			  alternateRecordStyles:true,
			  showDefaultContextMenu:false,
			  canAutoFitFields:false,
			  startLineNumber:1,
			  canEdit:true,
			  selectionType: "multiple",
              canDragSelect: true,
              editEvent: "click",
			  showRecordComponents:true,
			  showHover:true,
			  showRecordComponentsByCell:true,
			   canEditCell:function(rowNum, colNum){
			       //需要考虑禁用的都设置为可用 然后根据类型设置这些字段的可编辑性
			       //初始化时设置Cell是否可编辑
			  		var record = this.getRecord(rowNum);
	                fieldName = this.getFieldName(colNum);
			  		if(record!=null){
			  		    var type = record.type;
			  		    if("7" == type){//设计开发
			  		    	return false;
			  		    }
			  		}
                   return this.Super("canEditCell", arguments);//默认处理
			  },
			  
			  rowClick:function(record, recordNum, fieldNum){//rocordNum 从0开始
			  debugger;
			  Matrix.setFormItemValue('formulaSetId',record.formulaVal);
			  parent.document.getElementById("formulaSetId").value=record.formulaVal;
			  	var setType=record.formulaType;
			  	//alert(setType);
			  	var flag=record.id;
			  	var num=false;
			  	if(record.type==2||record.type==3||record.type==4||record.type==5||record.type==9){
			  		num=true;
			  	}
			  	flag = flag.substr(0, flag.indexOf('.'));
			  	Matrix.setFormItemValue('flag',flag);
			  	if(setType=='0'){ //普通设置
				//var content = record.formulaVal;
					
				MDataGrid001_formulaDialog.initSrc = "<%=request.getContextPath()%>/form/admin/custom/formula/betweenLayer.jsp?type="+setType+"&flag="+flag+"&num="+num;
				MDataGrid001_formulaDialog.src = "<%=request.getContextPath()%>/form/admin/custom/formula/betweenLayer.jsp?type="+setType+"&flag="+flag+"&num="+num;
			}else{  //高级设置
				MDataGrid001_formulaDialog.initSrc = "<%=request.getContextPath()%>/form/admin/custom/formula/betweenLayer.jsp?type="+setType+"&flag="+flag+"&num="+num;
				MDataGrid001_formulaDialog.src = "<%=request.getContextPath()%>/form/admin/custom/formula/betweenLayer.jsp?type="+setType+"&flag="+flag+"&num="+num;
			}
			      //先取编辑值
			      var type= MDataGrid001.getEditedRecord (recordNum).type;//获取编辑值如果编辑过
			  
			         if(type==null){
			         	type = record.type;
			         }
			     
				      var preDeductionField = MDataGrid001.getField("preDeduction");
				      if(type!=2&&type!=3&&type!=4&&type!=5&&type!=8&&type!=9){
						    preDeductionField.canEdit= false;
				    
				      }else{
				            preDeductionField.canEdit = true;
				      }
			   
			      return this.Super("rowClick", arguments);
			  },
		exportCells : [ {
			id : 'name',
			title : '名称'
		}, {
			id : 'type',
			title : '字段类型'
		}, {
			id : 'preDeduction',
			title : '预扣除'
		}, {
			id : 'dependencyPro',
			title : '关联属性'
		},{
			id : 'formula',
			title : '计算公式'
		} ],
		showRecordComponents : true,
		showRecordComponentsByCell : true
	});
	isc.MatrixDataSource.create( {
		ID : 'MDataGrid001_custom_filter_ds',
		fields : [ {
			title : "名称",
			name : "name",
			type : 'text',
			editorType : 'Text'
		},  {
			title : "字段类型",
			name : "type",
			type : 'text',
			editorType : 'SelectItem',
			valueMap:{'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'业务对象'},
			displayValueMap:{'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'业务对象'}
			},{
			title : "预扣除",
			name : "preDeduction",
			type : 'boolean',
			editorType : 'Checkbox'
			},{
			title : "关联属性",
			name : "dependencyPro",
			type : 'text',
			editorType : 'SelectItem'
			},{
			title : "计算公式",
			name : "formula",
			type : 'text',
			editorType : 'Text',
			formatCellValue:function(value, record, rowNum, colNum,grid){return setInput(value,record,rowNum,colNum,grid);(value,record, rowNum, colNum,grid);}
		} ]
	});
	isc.FilterBuilder.create( {
		ID : 'MDataGrid001_custom_filter',
		dataSource : MDataGrid001_custom_filter_ds,
		overflow : 'auto',
		topOperatorAppearance : "none"
	});
	isc.Button.create( {
		ID : 'MDataGrid001_custom_filter_btn',
		title : "确认",
		autoDraw : false,
		click : "MDataGrid001.hideCustomFilter()"
	});
	isc.Button.create( {
		ID : 'MDataGrid001_custom_filter_btn_reset',
		title : "重置",
		autoDraw : false,
		click : "MDataGrid001_custom_filter.clearCriteria()"
	});
	isc.Button.create( {
		ID : 'MDataGrid001_custom_filter_btn_cancel',
		title : "取消",
		autoDraw : false,
		click : "MDataGrid001_custom_filter_window.hide()"
	});
	isc.Window.create( {
		ID : 'MDataGrid001_custom_filter_window',
		title : "高级查询",
		autoCenter : true,
		overflow : "auto",
		isModal : true,
		autoDraw : true,
		height : 300,
		width : 500,
		canDragResize : true,
		showMaximizeButton : true,
		items : [ MDataGrid001_custom_filter ],
		showFooter : true,
		footerHeight : 20,
		footerControls : [ isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid001_custom_filter_btn, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid001_custom_filter_btn_reset, isc.HTMLFlow.create( {
			width : '5%',
			contents : "&nbsp;",
			autoDraw : false
		}), MDataGrid001_custom_filter_btn_cancel, isc.HTMLFlow.create( {
			width : '30%',
			contents : "&nbsp;",
			autoDraw : false
		}) ]
	});
	MDataGrid001_custom_filter.resizeTo('100%', '100%');
	MDataGrid001_custom_filter_window.hide();
	isc.Page.setEvent(isc.EH.LOAD,function(){
						 	MDataGrid001.isMLoaded=true;
						 	MDataGrid001.draw();
						 	MDataGrid001.setData(MDataGrid001_DS);
						 	MDataGrid001.resizeTo('100%','100%');
						 isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
						 if(Matrix.getDataGridIdsHiddenOfForm('form0')){
						 	Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
			</script>
						</div> <input id="DataGrid001_selection" name="DataGrid001_selection"
						type="hidden" /> <input id="DataGrid001_data_entity"
						name="DataGrid001_data_entity" value="foundation.portal.Portal"
						type="hidden" />

					</td>
				</tr>
				<tr style="width: 100%; height: 35px;">
					<td class="toolStrip"
						style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;">
						<span id="blpageDataGrid001" class="paginator"> <span
							id="blpageDataGrid001:status" class="paginator_status"> </span>
					</span>
					</td>
					<td class="toolStrip"
						style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align: right; margin: 0px; padding: 0px;">
						<span id="brpageDataGrid001" class="paginator"
						style="float: right;"> <span id="brpageDataGrid001:first"
							class="paginator_first"> </span> <span
							id="brpageDataGrid001:previous" class="paginator_previous">

						</span> <span class='paginator_separator'> </span> <span
							id="brpageDataGrid001:go" class="paginator_go"> <span
								class="go_prefix" line-height="30px"> </span> <span
								id="brpageDataGrid001:goText" class="paginator_go_text"
								line-height="30px"> </span> <span class="go_suffix"
								line-height="30px"> </span>
						</span> <span class='paginator_separator'> </span> <span
							id="brpageDataGrid001:next" class="paginator_next"> </span> <span
							id="brpageDataGrid001:last" class="paginator_last"
							line-height="30px"> </span> <span class="paginator_clean"
							line-height="30px"> </span> <span class='paginator_separator'>

						</span> <span id="brpageDataGrid001:refresh" class="paginator_refresh"
							line-height="30px"> <a href="javascript:#"></a>
						</span> <span> &nbsp;&nbsp; </span> <span
							id="DataGrid001_brpageDataGrid001_dynamic_perpage_count_div"
							eventProxy="Mform0" class="matrixInline" line-height="30px">
						</span>
					</span>
					</td>
				</tr>
			</table>
			<script>
	function getParamsForDataGrid001_formulaDialog(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDataGrid001_formulaDialog",
		id:"DataGrid001_formulaDialog",
		name:"DataGrid001_formulaDialog",
		autoCenter: true,
		position:"absolute",
		height : "100%",
		width : "85%",
		title: "计算公式设置",
		canDragReposition : true,
		showMinimizeButton : false,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		targetDialog : "parent",
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
					"maximizeButton", "closeButton" ],
		showFooter : false
		});
		</script>
			<script>
			
			MDataGrid001_formulaDialog.hide();
			
			var ratio = detectZoom();if(ratio != 100){setTimeout(reInitGridScroll,100);}
		</script>
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