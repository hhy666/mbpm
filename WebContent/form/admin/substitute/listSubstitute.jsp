<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>委托项列表</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<script type="text/javascript">
	//提交查询
	function submitQueryByPage(){
	    Matrix.queryDataGridData('DataGrid0');
		Matrix.send("Form0");
	}	
	//重置查询输入
	function resetQueryInput(){
		MsearchEndDate.clearValue();
		MsearchStartDate.clearValue();
		MsearchItem.clearValue();
		MsearchSubstituteType.setValue('');
		MsearchScopeType.setValue('');
	}
	
	
	//添加委托项目
	function addSubstituteItem(){
		var url = "<%=request.getContextPath()%>/substitute/substituteAction_loadSaveSubsPage.action?oType=add";
		location.href =url;
	}
	
	
		//编辑行自定义显示
		function convertUIValue(value, record, rowNum, colNum,grid){
			var id = record.id;
			var url ="<%=request.getContextPath()%>/substitute/substituteAction_getSubstituteItem.action?oType=update&id="+id;
			var titleStr = "";
			titleStr+="<a href='"+url+"'>编辑</a>";
		   
			return "<div align='center'>"+titleStr+"</div>"; 
		}
		
		//删除委托项
		function deleteSubstituteItem(){
			var dataGrid = Matrix.getMatrixComponentById("DataGrid0");
		    var seArray = dataGrid.getSelection();
		    var record = null;
		    var ids = "";
		    if(seArray!=null&&seArray.length>0){
		    	var dataGridId = document.getElementById('dataGridId').value;
		    	for(var i=0;i<seArray.length;i++){
			    	record = seArray[i];
		    		if(i!=0){
		    			ids = ids+",";
		    		}
		    		ids = ids+record.id;
		    		
		    	}
		    	var deleteData = {'ids':ids,'dataGridId':dataGridId};
		    	var url = "<%=request.getContextPath()%>/substitute/substituteAction_deleteSubstituteItems.action";
		    	dataSend(deleteData,url,"POST");
		    }else{
		    	isc.say('请先选择要删除的委托项!');
		    }
		
		}
	
	
	</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; height: 100%"><script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"Form0",
	 		position:"absolute",
	 				
	 		action:"<%=request.getContextPath()%>/substitute/substituteAction_querySubstituteItems.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/substitute/substituteAction_querySubstituteItems.action"
	style="margin: 0px; overflow: auto; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" /> <input type="hidden" name="dataGridId"
	id="dataGridId" value="DataGrid0" /> <input type="hidden"
	name="processDID" id="processDID" value="${requestScope.processDID}" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>


<!-- 

<table  style="width:100%;height:100%;border: 0px solid #cccccc;border-collapse: collapse;">
	<tr>
		<td style="height:100px;" colspan="2">
			<table id="j_id5" jsId="j_id5" class="query_form_content">
			
			   
			    <tr id="j_id6" jsId="j_id6" style="">
			        <td id="j_id7" jsId="j_id7" class="maintain_form_label" style="width:20%;">
			            <label id="j_id8" name="j_id8">
			                委托范围：
			            </label>
			        </td>
			        <td id="j_id9" jsId="j_id9" class="maintain_form_input">
			           <div id="searchScopeType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MsearchScopeType_VM=[];
		    var searchScopeType=isc.SelectItem.create({
		    		ID:"MsearchScopeType",
		    		name:"searchScopeType",
		    		editorType:"SelectItem",
		    		displayId:"searchScopeType_div",
		    		valueMap:[],
		    		value:"",
		    		position:"relative",
		    		width:200
		    });
		    MForm0.addField(searchScopeType);
		    MsearchScopeType_VM=['','1','2','3'];
		    MsearchScopeType.displayValueMap={'':'全部','1':'所有工作','2':'流程','3':'环节'};
		    MsearchScopeType.setValueMap(MsearchScopeType_VM);
		   
		</script>
			        </td>
			        <td id="j_id11" jsId="j_id11" class="maintain_form_label" style="width:20%;">
			            <label id="j_id12" name="j_id12">
			               委托类型：
			            </label>
			        </td>
			        <td id="j_id13" jsId="j_id13" class="query_form_input" >
			            <div id="searchSubstituteType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MsearchSubstituteType_VM=[];
		    var searchSubstituteType=isc.SelectItem.create({
		    		ID:"MsearchSubstituteType",
		    		name:"searchSubstituteType",
		    		editorType:"SelectItem",
		    		displayId:"searchSubstituteType_div",
		    		valueMap:[],
		    		value:"",
		    		position:"relative",
		    		width:200
		    });
		    MForm0.addField(searchSubstituteType);
		    MsearchSubstituteType_VM=['','1','2'];
		    MsearchSubstituteType.displayValueMap={'':'全部','1':'创建时','2':'超时时'};
		    MsearchSubstituteType.setValueMap(MsearchSubstituteType_VM);
		   
		</script>
			        </td>
			    </tr>
			    
			    <tr id="j_id6" jsId="j_id6" style="">
			        <td id="j_id7" jsId="j_id7" class="maintain_form_label" style="width:20%;">
			            <label id="j_id8" name="j_id8">
			                委&nbsp;托&nbsp;项：
			            </label>
			        </td>
			        <td id="j_id9" jsId="j_id9" class="maintain_form_input" >
			            <div id="searchItem_div" eventProxy="MForm0" class="matrixInline" style="">
			            </div>
			            <script>
			                var searchItem = isc.TextItem.create({
			                    ID: "MsearchItem",
			                    name: "searchItem",
			                    editorType: "TextItem",
			                    displayId: "searchItem_div",
			                    panelID: "Mj_id2",
			                    position: "relative",
			                    width: 200
			                });
			                MForm0.addField(searchItem);
			            </script>
			        </td>
			        <td id="j_id11" jsId="j_id11" class="query_form_label" colspan="1" rowspan="1">
			            <label id="j_id12" name="j_id12">
			               委托时间：
			            </label>
			        </td>
			        <td id="j_id13" jsId="j_id13" class="query_form_input" colspan="1" rowspan="1">
			            <div id="searchStartDate_div" eventProxy="MForm0" class="matrixInline" style="">
							</div>
							<script>
							    var MsearchStartDate_value = null;
							    var searchStartDate = isc.DateItem.create({
							        ID: "MsearchStartDate",
							        name: "searchStartDate",
							        value: MsearchStartDate_value,
							        type: "date",
							        displayId: "searchStartDate_div",
							        paseDateFun: function(value, formatPattern) {
							            return Matrix.parseDate(value, formatPattern);
							        },
							        dateFormatter: function(_1) {
							            return Matrix.formatDate(this, MsearchStartDate.formatPattern);
							        },
							        formatPattern: "yyyy-MM-dd",
							        useTextField: true,
							        enforceDate: true,
							        position: "relative",
							        validators: [{
							            type: "custom",
							            condition: function(item, validator, value, record) {
							            
							            	//校验时间区间的有效性
							            	if(value!=null){
							            		var endDate = MsearchEndDate.getValue();
							            		if(endDate!=null){
							            		   var endTime = endDate.getTime();
							            		   var valueTime = value.getTime();
							            		   
							            		   if(endTime<=valueTime){
							            		   	  validator.errorMessage = "请选择有效的时间区间!";
							            			  return false;
							            		   }
							            		
							            		}
							            	
							            	}
							            
							                return item.validateDateValue(value);
							            },
							            errorMessage: isc.DateItem.getPrototype().invalidDateStringMessage
							        }]
							    });
							    MForm0.addField(searchStartDate);
							</script>
							<b>-</b>
							 <div id="searchEndDate_div" eventProxy="MForm0" class="matrixInline" style="">
							</div>
							<script>
							    var MsearchEndDate_value = null;
							    var searchEndDate = isc.DateItem.create({
							        ID: "MsearchEndDate",
							        name: "searchEndDate",
							        value: MsearchEndDate_value,
							        type: "date",
							        displayId: "searchEndDate_div",
							        paseDateFun: function(value, formatPattern) {
							            return Matrix.parseDate(value, formatPattern);
							        },
							        dateFormatter: function(_1) {
							            return Matrix.formatDate(this, MsearchEndDate.formatPattern);
							        },
							        formatPattern: "yyyy-MM-dd",
							        useTextField: true,
							        enforceDate: true,
							        position: "relative",
							        validators: [{
							            type: "custom",
							            condition: function(item, validator, value, record) {
							            
							            	//校验时间区间的有效性
							            	if(value!=null){
							            		var startDate = MsearchStartDate.getValue();
							            		if(startDate!=null){
							            		   var startTime = startDate.getTime();
							            		   var valueTime = value.getTime();
							            		   
							            		   if(startTime>=valueTime){
							            		   	  validator.errorMessage = "请选择有效的时间区间!";
							            			  return false;
							            		   }
							            		
							            		}
							            	
							            	}
							            	
							                return item.validateDateValue(value);
							            },
							            errorMessage: isc.DateItem.getPrototype().invalidDateStringMessage
							        }]
							    });
							    MForm0.addField(searchEndDate);
							</script>
			        </td>
			    </tr>
			    
			    <tr id="j_id15" jsId="j_id15">
			        <td id="j_id16" jsId="j_id16" class="query_form_command" colspan="4" rowspan="1">
			            <div id="j_id17_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
			                <script>
			                    isc.Button.create({
			                        ID: "Mj_id17",
			                        name: "j_id17",
			                        title: "查询",
			                        panelID: "Mj_id2",
			                        displayId: "j_id17_div",
			                        position: "absolute",
			                        top: 0,
			                        left: 0,
			                        width: "100%",
			                        height: "100%",
			                        icon: Matrix.getActionIcon("query"),
			                        showDisabledIcon: false,
			                        showDownIcon: false,
			                        showRollOverIcon: false
			                    });
			                    Mj_id17.click = function() {
			                        Matrix.showMask();
			                       
			                        if(!MForm0.validate()) {
			                            Matrix.hideMask();
			                            return false;
			                        }
			                        submitQueryByPage();
			                        
			                        Matrix.hideMask();
			                    };
			                </script>
			            </div>
			            <div id="j_id18_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
			                <script>
			                    isc.Button.create({
			                        ID: "Mj_id18",
			                        name: "j_id18",
			                        title: "清空",
			                        panelID: "Mj_id2",
			                        displayId: "j_id18_div",
			                        position: "absolute",
			                        top: 0,
			                        left: 0,
			                        width: "100%",
			                        height: "100%",
			                        icon: Matrix.getActionIcon("exit"),
			                        showDisabledIcon: false,
			                        showDownIcon: false,
			                        showRollOverIcon: false
			                    });
			                    Mj_id18.click = function() {
			                        Matrix.showMask();
			                         resetQueryInput();
			                        Matrix.hideMask();
			                    };
			                </script>
			            </div>
			        </td>
			    </tr>
			</table>
		
		
		</td>
	</tr>
	-->
<table class="query_form_content"
	style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px;">
	<tr>
		<td class="query_form_toolbar" colspan="2">
		
		<script> 
				isc.ToolStripButton.create({
					ID:"Mbutton001",icon:Matrix.getActionIcon("query"),
					title: "查询",showDisabledIcon:false,showDownIcon:false 
				});
				Mbutton001.click=function(){
					 Matrix.showMask();
                     if(!MForm0.validate()) {
                         Matrix.hideMask();
                         return false;
                     }
                     submitQueryByPage();
                     Matrix.hideMask();
				}
				</script> <script>
					isc.ToolStripButton.create({
						ID:"Mbutton002",icon:Matrix.getActionIcon("add"),
						title: "添加",showDisabledIcon:false,showDownIcon:false 
					});
					Mbutton002.click=function(){
						Matrix.showMask();
                  		addSubstituteItem();
                         
                         Matrix.hideMask();
					}
				</script> <script>
				isc.ToolStripButton.create({
					ID:"Mbutton003",icon:Matrix.getActionIcon("delete"),
					title: "删除",showDisabledIcon:false,showDownIcon:false 
				});
				Mbutton003.click=function(){
					 Matrix.showMask();
                     deleteSubstituteItem();//删除
                     Matrix.hideMask();
				}
				</script>
	 	<script>
	 	var MsearchScopeType_VM=[]; 
	 	var comboBox001=isc.SelectItem.create({
	 	ID:"MsearchScopeType",
		name:"searchScopeType",
	 	editorType:"SelectItem",displayId:"comboBox001_div",
	 	valueMap:[],position:"relative"});
	 	MForm0.addField(comboBox001);
	 	
	    MsearchScopeType_VM=['','1','2','3'];
	    MsearchScopeType.displayValueMap={'':'全部','1':'所有工作','2':'流程','3':'环节'};
	 	MsearchScopeType.setValueMap(MsearchScopeType_VM);
	 	MsearchScopeType.setValue(null);
	 	
	 	
	 	var MsearchSubstituteType_VM=[]; 
	 	var comboBox002=isc.SelectItem.create({
		 	ID:"MsearchSubstituteType",
			name:"searchSubstituteType",
			editorType:"SelectItem",
			displayId:"comboBox002_div",
		 	valueMap:[],
		 	position:"relative"
	 	});
	 	MForm0.addField(comboBox002);
	    MsearchSubstituteType_VM=['','1','2'];
	    MsearchSubstituteType.displayValueMap={'':'全部','1':'创建时','2':'超时时'};
	    MsearchSubstituteType.setValueMap(MsearchSubstituteType_VM);
	 	
	 	isc.ToolStripButton.create({ID:"MtoolBarItem001",icon:"[skin]/images/matrix/actions/save.png",title: "操作",showDisabledIcon:false,showDownIcon:false });MtoolBarItem001.click=function(){Matrix.showMask();if(!true){Matrix.hideMask();return false;}if(!MForm0.validate()){Matrix.hideMask();return false;}var vituralbuttonHidden = document.getElementById('matrix_command_id');if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);var currentForm = document.getElementById('form0');var buttonHidden = document.createElement('input');buttonHidden.type='hidden';buttonHidden.name='matrix_command_id';buttonHidden.id='matrix_command_id';buttonHidden.value='toolBarItem001';currentForm.appendChild(buttonHidden);var buttonIdHidden = document.createElement('input');buttonIdHidden.type='hidden';buttonIdHidden.name='toolBarItem001';buttonIdHidden.value='toolBarItem001';document.getElementById('form0').appendChild(buttonIdHidden);var _mgr=Matrix.convertDataGridDataOfForm('form0');if(_mgr!=null&&_mgr==false){Matrix.hideMask();return false;}Matrix.convertFormItemValue('form0');document.getElementById('form0').submit();Matrix.hideMask();}</script><script>isc.ToolStripButton.create({ID:"MtoolBarItem002",icon:"[skin]/images/matrix/actions/save.png",title: "操作",showDisabledIcon:false,showDownIcon:false });MtoolBarItem002.click=function(){Matrix.showMask();if(!true){Matrix.hideMask();return false;}if(!MForm0.validate()){Matrix.hideMask();return false;}var vituralbuttonHidden = document.getElementById('matrix_command_id');if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);var currentForm = document.getElementById('form0');var buttonHidden = document.createElement('input');buttonHidden.type='hidden';buttonHidden.name='matrix_command_id';buttonHidden.id='matrix_command_id';buttonHidden.value='toolBarItem002';currentForm.appendChild(buttonHidden);var buttonIdHidden = document.createElement('input');buttonIdHidden.type='hidden';buttonIdHidden.name='toolBarItem002';buttonIdHidden.value='toolBarItem002';document.getElementById('form0').appendChild(buttonIdHidden);var _mgr=Matrix.convertDataGridDataOfForm('form0');if(_mgr!=null&&_mgr==false){Matrix.hideMask();return false;}Matrix.convertFormItemValue('form0');document.getElementById('form0').submit();Matrix.hideMask();}</script><script>isc.ToolStripButton.create({ID:"MtoolBarItem003",icon:"[skin]/images/matrix/actions/save.png",title: "操作",showDisabledIcon:false,showDownIcon:false });MtoolBarItem003.click=function(){Matrix.showMask();if(!true){Matrix.hideMask();return false;}if(!MForm0.validate()){Matrix.hideMask();return false;}var vituralbuttonHidden = document.getElementById('matrix_command_id');if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);var currentForm = document.getElementById('form0');var buttonHidden = document.createElement('input');buttonHidden.type='hidden';buttonHidden.name='matrix_command_id';buttonHidden.id='matrix_command_id';buttonHidden.value='toolBarItem003';currentForm.appendChild(buttonHidden);var buttonIdHidden = document.createElement('input');buttonIdHidden.type='hidden';buttonIdHidden.name='toolBarItem003';buttonIdHidden.value='toolBarItem003';document.getElementById('form0').appendChild(buttonIdHidden);var _mgr=Matrix.convertDataGridDataOfForm('form0');if(_mgr!=null&&_mgr==false){Matrix.hideMask();return false;}Matrix.convertFormItemValue('form0');document.getElementById('form0').submit();Matrix.hideMask();}</script>
		<div id="toolBar001_div"
			style="width: 100%; height: 28px; overflow: hidden;">
		<script>
		isc.ToolStrip.create({ID:"MtoolBar001",
		displayId:"toolBar001_div",width: "100%",height: "100%",
		position: "relative",members: [ 
			isc.MatrixHTMLFlow.create({ID:"Mlabel001",contents:"<div  id='Mlabel001_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >委托范围</div>"}),
			isc.MatrixHTMLFlow.create({ID:"comboBox001",contents:"<div id='comboBox001_div' eventProxy='MForm0' class='toolBarItemComboBox' ></div>"}),
			isc.MatrixHTMLFlow.create({ID:"Mlabel002",contents:"<div  id='Mlabel002_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >委托类型</div>"}),
			isc.MatrixHTMLFlow.create({ID:"comboBox002",contents:"<div id='comboBox002_div' eventProxy='MForm0' class='toolBarItemComboBox' ></div>"}),
			Mbutton001,Mbutton002,Mbutton003 
		] });
	isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MtoolBar001.resizeTo(0,0);MtoolBar001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);
</script></div>










		</td>
	</tr>



	<!-- 数据表格 -->
	<tr id="j_id7" jsId="j_id7">

		<td id="j_id9" jsId="j_id9" rowspan="1" colspan="2"
			style="border-style: none;">
		<div id="DataGrid0_div" class="matrixComponentDiv"
			style="width: 100%; height: 100%;"><script>
		 	
				scopeDisplayValueMap = {'1':'所有工作','2':'流程','3':'环节'};
				subsTypeDisplayValueMap = {'1':'创建时','2':'超时时'}		 	
				isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:true,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
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
						   {title:'委托项',name:'subsItem',canSort:false }//有可能时流程或者环节
						   ,
						   {title:'委托范围',width:'20%',name:'SCOPE_TYPE',
						   		valueMap:['1','2','3'],
					  		    autoFetchDisplayMap:true,
						  		editorProperties:{
						  			displayValueMap:scopeDisplayValueMap
      							},
      							formatCellValue:function(value, record, rowNum, colNum,grid){
						  			if(value==null){
						  				return "";
						  			}
					  				return scopeDisplayValueMap[value];
					  			}
      						}
						   ,
						   {title:'委托类型',width:'15%',name:'SUBSTITUTE_TYPE',
						   		valueMap:['1','2'],
					  		    autoFetchDisplayMap:true,
						  		editorProperties:{
						  			displayValueMap: subsTypeDisplayValueMap
					  			}
					  			,
      							formatCellValue:function(value, record, rowNum, colNum,grid){
						  			if(value==null){
						  				return "";
						  			}
					  				return subsTypeDisplayValueMap[value];
					  		   }
					  		}
						   ,
						   
						   {title:'开始时间',width:'15%',name:'VALID_FROM'}
						   ,
						   {title:'结束时间',width:'15%',name:'VALID_TO'}
						   ,
						   {title:'操作',width:'15%',name:'editItem',canSort:false,
						   		formatCellValue:function(value, record, rowNum, colNum,grid){
					  				return convertUIValue(value,record, rowNum, colNum,grid);
					  		}}
					 
					 
					 ],
				  //设置UI组件和扩展组件关联关系
				  
				  autoSaveEdits:false,
				  autoFetchData:true,
				  alternateRecordStyles:true,
				  showDefaultContextMenu:false,
				  canAutoFitFields:false,
				  startLineNumber:1,
				  canEdit:false,
				  selectionType: "multiple",
              	  canDragSelect: true,
	              editEvent: "click",
				  showRecordComponents:true,
				  showRecordComponentsByCell:true,
				  canEditCell2:function(rowNum, colNum){
	                   return this.Super("canEditCell", arguments);//默认处理
				  } 
				});
				if("${requestScope.subsListData}".length>0){
					MDataGrid0.setData(${requestScope.subsListData});
				
				}
				isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
				
	     
	
	
			</script></div>
		<input id="MDataGrid0_data_rows" name="MDataGrid0_data_rows"
			type="hidden" /></td>
	</tr>

	<!-- 

	<tr id="j_id35" jsId="j_id35">
		<td id="j_id36" jsId="j_id36" class="Toolbar" colspan="2" rowspan="1"
			align="center" style="border-style: none; height: 25px;"
			height="25px">

		<div id="CommandButton4_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
                                        isc.Button.create({
                                            ID: "MCommandButton4",
                                            name: "CommandButton4",
                                            title: "增加",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton4_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("add"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton4.click = function() {
                                            Matrix.showMask();
                                     		addSubstituteItem();
                                            
                                            Matrix.hideMask();
                                        };
                                    </script></div>
		<div id="CommandButton5_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;"><script>
                                        isc.Button.create({
                                            ID: "MCommandButton5",
                                            name: "CommandButton5",
                                            title: "删除",
                                            panelID: "Mj_id19",
                                            displayId: "CommandButton5_div",
                                            position: "absolute",
                                            top: 0,
                                            left: 0,
                                            width: "100%",
                                            height: "100%",
                                            icon: Matrix.getActionIcon("delete"),
                                            showDisabledIcon: false,
                                            showDownIcon: false,
                                            showRollOverIcon: false
                                        });
                                        MCommandButton5.click = function() {
                                            Matrix.showMask();
                                            deleteSubstituteItem();//删除
                                            Matrix.hideMask();
                                        };
                                    </script></div>
		</td>
	</tr>
	-->
	<tr>
		<td style="height: 5px"></td>
	</tr>

</table>

</form>
<script type="text/javascript">
	
	
	//播放弹出框
	isc.Window.create({
		ID:"MDialogVideo",
		id:"DialogVideo",
		name:"DialogVideo",
		autoCenter: true,
		position:"absolute",
		height: "500",
		width: "600",
		title: "播放流程实例",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialogVideo.hide();
	
	
	//ViewDetail
	
	//详细弹出框
	isc.Window.create({
		ID:"MDialogViewDetail",
		id:"DialogViewDetail",
		name:"DialogViewDetail",
		autoCenter: true,
		position:"absolute",
		height: "420",
		width: "600",
		title: "流程实例详细信息",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"
		]
	 });
	MDialogViewDetail.hide();

</script> <script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script></div>
</body>
</html>