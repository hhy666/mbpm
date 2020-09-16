<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改子目录</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	
	function isPublic(){
		var authListObj = document.getElementById('authListDiv');
		var isPublic = document.getElementsByName('isPublic');
		var secTr = document.getElementById('j_id35');
		//var secTitleTr = document.getElementById('j_id39');
		var secTitlelabel = document.getElementById('j_id41');
		if(isPublic[1].checked){
			authListObj.style.display='';
			secTr.style.display = '';
			//secTitleTr.style.display = '';
			secTitlelabel.style.display = '';
			//MQueryList001_tb.resizeTo(0,0);
			MQueryList001_tb.resizeTo('100%','100%');
			MQueryList001_tb.resizeTo('100%','100%');
				MQueryList001_tb.resizeTo('100%','100%');
			//MDataGrid001.resizeTo(0,0);
			MDataGrid001.resizeTo('100%','100%');
			MDataGrid001.resizeTo('100%','100%');
			MDataGrid001.resizeTo('100%','100%');
		}else{
			authListObj.style.display='none'
			secTr.style.display = 'none';
			//secTitleTr.style.display = 'none';
			secTitlelabel.style.display = 'none';
		}
	}
	function setDivStyle(){
		var parentUuid = Matrix.getFormItemValue("parentUuid");
		
		//获取当前用户编码
		var curUserId = '<%=request.getAttribute("curUserId")%>';
		Matrix.setFormItemValue('curUserId',curUserId);
		var isPublicTr0 = document.getElementById('j_id31');
		var isPublicTr1 = document.getElementById('j_id33');
		var secTr = document.getElementById('j_id35');
		//var secTitleTr = document.getElementById('j_id39');
		var secTitlelabel = document.getElementById('j_id41');
		var isPublicValue = Matrix.getFormItemValue('publicValue');
		MForm0.setValue("isPublic",isPublicValue);
		document.getElementById('authListDiv').style.display='none';
		secTr.style.display = 'none';
		//secTitleTr.style.display = 'none';
		secTitlelabel.style.display = 'none';
		if(curUserId=='admin'){//是系统管理员
			if(parentUuid=='root'){
				isPublicTr0.style.display = '';
				isPublicTr1.style.display = '';
				var isPublic = document.getElementsByName('isPublic');
				if(isPublicValue=='1'){
					isPublic[1].checked=false;
					isPublic[0].checked=true;
				}else if(isPublicValue=='0'){
					isPublic[1].checked=true;
					isPublic[0].checked=false;
				}
				if(isPublic[1].checked){
					document.getElementById('authListDiv').style.display='';
					secTr.style.display = '';
					//secTitleTr.style.display = '';
			secTitlelabel.style.display = '';
				}
			}else{
				isPublicTr0.style.display = 'none';
				isPublicTr1.style.display = 'none';
			}
			
		}else{//不是系统管理员
			
			isPublicTr0.style.display = 'none';
			isPublicTr1.style.display = 'none';
			document.getElementById('authListDiv').style.display='none';
		}
		
	}
	
 //权限上移--------------------------------------------------------
       function moveUp(){
            //数据表格所有记录集合
            var items = Matrix.getAllDataGridData('DataGrid001');
            //获得选中的当前行
            var item = Matrix.getDataGridSelection('DataGrid001');
            if(item.size()!=0){  
                var idx = MDataGrid001.getFocusRow(item);      
                if(idx!=0){
                    var targetItem=items.get(idx-1);
		    items.set(idx-1,item.get(0));
		    items.set(idx,targetItem);   
                    MDataGrid001.setData(items);
                }
            }else{
                Matrix.warn("没有数据被选中，不能执行此操作。");
                return null;
            }
	/*
var dataGrid = Matrix.getMatrixComponentById("DataGrid001");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				Matrix.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			//alert(selectedRecord.UIModule);
			var recordIndex = recordData.indexOf(selectedRecord);
			if(recordIndex>0){
			    recordIndex--;
			    //获取上条数据记录
			    var preRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex+1,preRecord);
			    
			}
		}
                    */
        }
//权限下移-----------------------------------------------------------------
        function moveDown(){
          /*  var items = Matrix.getAllDataGridData('DataGrid001');
            //获得选中的当前行
           var item = Matrix.getDataGridSelection('DataGrid001');
             var idx = MDataGrid001.getFocusRow(item);    
            if(item!=items[items.size()]){
                var targetItem=items[idx+1];
                items.set(idx+1,item.get(0));
	        items.set(idx,targetItem); 
                MDataGrid001.setData(items); 
            }
*/
var dataGrid = Matrix.getMatrixComponentById("DataGrid001");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				Matrix.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			var listSize = recordData.getLength();
			if(recordIndex<listSize-1){
			    recordIndex++;
			    //获取上条数据记录
			    var afterRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex-1,afterRecord);
			}
		}
        }
//添加权限--------------------------------------------------------
    function addAuths(){
        Matrix.showWindow("Dialog11");    
    }
//删除------------------------------------------------------------
   function deleteRecord(){
       var list = Matrix.getComponentById("DataGrid001").getSelection();
        if(list.get(0)){
           Matrix.deleteDataGridData('DataGrid001');
        }else{
            Matrix.warn("数据没有被选中。");
          }
   }
	function getDataGridData(){
		var gridData = Matrix.getAllDataGridData('DataGrid001');//获得数据表格所有数据
		var isPublic = document.getElementsByName('isPublic');//获得单选按钮组对象
		var dataArr = "";
		
		if(isPublic[0].checked){//否
			if(gridData!=null&&gridData.length>0){//数据表格中有数据
				dataArr = "[";
				for(var i = 0;i < gridData.length;i++){
      				if(i!=gridData.length-1){
      					dataArr+="{'userId':'"+gridData[i].userId+"',";
      					dataArr+="'depId':'"+gridData[i].depId+"',";
      					dataArr+="'depName':'"+gridData[i].depName+"',";
      					dataArr+="'roleName':'"+gridData[i].roleName+"',";
      					dataArr+="'userName':'"+gridData[i].userName+"',";
      					dataArr+="'index':'"+i+"',";
      					dataArr+="'type':'"+gridData[i].type+"',";
      					dataArr+="'roleId':'"+gridData[i].roleId+"'},";
      				}else{
      					dataArr+="{'userId':'"+gridData[i].userId+"',";
      					dataArr+="'depId':'"+gridData[i].depId+"',";
      					dataArr+="'depName':'"+gridData[i].depName+"',";
      					dataArr+="'roleName':'"+gridData[i].roleName+"',";
      					dataArr+="'userName':'"+gridData[i].userName+"',";
      					dataArr+="'index':'"+i+"',";
      					dataArr+="'type':'"+gridData[i].type+"',";
      					dataArr+="'roleId':'"+gridData[i].roleId+"'}";
      				}
      			}
      			dataArr += "]";
			}else{
				return;
			}
		}else{//是
			dataArr="";
		}
		Matrix.setFormItemValue('dataGridData',dataArr);
	}
</script>
</head>
<body onload='setDivStyle()'>
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 		ID:"MForm0",
 		name:"MForm0",
 		position:"absolute",
 		//action:"<%=request.getContextPath()%>/catalog_updateCatalogNode.action",
 		
 		fields:[{
 		  name:'Form0_hidden_text',
 		  width:0,
 		  height:0,
 		  displayId:'Form0_hidden_text_div'
 		  }]
 	   });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="" style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState"
	id="javax.faces.ViewState" value="j_id1:j_id2" />
	 <input type="hidden" id="matrix_current_page_id" name="matrix_current_page_id"
	value="/console/catalog/AddSubCatalog" />
	
<div id="tabContainer0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;"><script> 
	var MtabContainer0 = isc.TabSet.create({
			ID:"MtabContainer0",
			displayId:"tabContainer0_div",
			height: "100%",width: "100%",
			position: "relative",
			align: "center",
			tabBarPosition: "top",
			tabBarAlign: "left",
			showPaneContainerEdges: false,
			showTabPicker: true,
			showTabScroller: true,
			selectedTab: 1,
			tabBarControls : [
				isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"300px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
			            })
		    ],
		    
		    tabs: [ {
		             title: "修改子目录",
		             pane:isc.MatrixHTMLFlow.create({
		             		ID:"MtabContainer0Panel0",
		             		width: "100%",height: "100%",
		             		overflow: "hidden",
		             		contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"
		             })
		    } ]
      });
      
      document.getElementById('tabContainer0_div').style.display='none';
      MtabContainer0.selectTab(0);
      isc.Page.setEvent("load","MtabContainer0.selectTab(0);");
      </script></div>

<div id="tabContainer0Bar0_div2" style="text-align: right"
	class="matrixInline"></div>
<script>

document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
</script>
<div id="tabContainer0Panel0_div2"
	style="width: 100%; height: 100%; overflow: hidden;"
	class="matrixInline">
<div id="j_id2_div2" style="width: 100%; height: 100%; overflow: auto;"
	class="matrixInline">

<table id="j_id3" jsId="j_id3" class="maintain_form_content">
    <tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id11" name="j_id11"
			style="margin-left: 10px">编码：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="definedId_div" eventProxy="MForm0" class="matrixInline matrixInlineIE"
			style=""></div>
		<script>
		      var definedId=isc.TextItem.create({
		      		ID:"MdefinedId",
		      		name:"definedId",
		      		editorType:"TextItem",
		      		displayId:"definedId_div",
		      		position:"relative",
		      		value:"${catalogNode.mid}",
		      		disabled:true,
		      		width:290,
		      		required:true
		       });
		       MForm0.addField(definedId);
		      </script> <span id="MultiLabel1"
			style="width: 18px; height: 20px; color: #FF0000">*</span>
			</td>
	</tr>
	
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id6" name="j_id6"
			style="margin-left: 10px">名称：</label></td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="name_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
       		    var name2=isc.TextItem.create({
       		    		ID:"Mname",
       		    		name:"name",
       		    		editorType:"TextItem",
       		    		displayId:"name_div",
       		    		value:"${catalogNode.name}",
       		    		position:"relative",
       		    		
       		    		width:290,
       		    		validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		         	return inputNameValidate(item, validator, value, record);
		      		         },
		      		         errorMessage:"名称不能为空!"
		      		 	}]
       		    });
       		    MForm0.addField(name2);
       	    </script> <span id="MultiLabel0"
			style="width: 17px; height: 20px; color: #FF0000">*</span>
			<span id="nameEchoMessage"
			style="color: #FF0000">${nameEchoMessage}</span>
			</td>
	</tr>
	
	
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id22" name="j_id22"
			style="margin-left: 10px"> 描述：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="InputTextArea0_div" eventProxy="MForm0" class="matrixInline"
			style="height:100px;"></div>
		<script>
			 var desc=isc.TextAreaItem.create({
			 		ID:"Mdesc",
			 		name:"desc",
			 		editorType:"TextAreaItem",
			 		displayId:"InputTextArea0_div",
			 		position:"relative",
			 		value:"${catalogNode.desc}",
			 		width:400,height:100
			 });
			MForm0.addField(desc);
		</script>
		</td>
	</tr>
	<tr id="j_id31" jsId="j_id31">
                            	<td id="j_id32" jsId="j_id32" class="maintain_form_label" colspan="1" rowspan="1">
                            		 <label id="j_id34" name="j_id34" style="margin-left:10px;">
                                             是否公共：
                                    </label>
                            	</td>
                            	<td id="j_id33" jsId="j_id33" class="maintain_form_input"  colspan="1" rowspan="1">
                            		
                 <div id="isPublic_1_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style="padding-top: 2px;border-style:none;;width:50px;"></div>
				<div id="isPublic_0_div" style="padding-left: 2px;padding-top: 2px;border-style:none;;width:50px;" eventProxy="MForm0" class="matrixInline matrixInlineIE"></div>           		
<script> var isPublic_0=isc.RadioItem.create({
					ID:"MisPublic_0",
					name:"isPublic",
					editorType:"RadioItem",
					displayId:"isPublic_0_div",
					value:"${catalogNode.isPublic==0?catalogNode.isPublic:0}",
					title:"否",
					position:"relative",
					groupId:"isPublic",
					changed:"isPublic()"
				});
				MForm0.addField(isPublic_0);</script>
				
<script> var isPublic_1=isc.RadioItem.create({
					ID:"MisPublic_1",
					name:"isPublic",
					editorType:"RadioItem",
					displayId:"isPublic_1_div",
					value:"${catalogNode.isPublic==1?catalogNode.isPublic:1}",
					title:"是",
					position:"relative",
					groupId:"isPublic",
					changed:"isPublic();"
				});
				MForm0.addField(isPublic_1);
				//MForm0.setValue("isPublic",'0');
				</script>
                            	</td>
                            </tr>
                            
	<tr id="j_id35" jsId="j_id35" style="height:200px;">
		<td id="j_id40" jsId="j_id40" class="maintain_form_label" colspan="1" rowspan="1">
                            		 <label id="j_id41" name="j_id41" style="margin-left:10px;">
                                             授权信息：
                                    </label>
                            	</td>
		<td id="j_id36" jsId="j_id36" class="maintain_form_input" style="height:200px;"
			colspan="1" >
			<div  style="height:100%;width:100%;" id='authListDiv' class="matrixInline matrixInlineIE">
				<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
					<tr>   								
						<td class="query_form_toolbar" class="maintain_form_command" colspan="2" >
							<input id="j_id0" type="hidden" name="j_id0" value="" />
							<script>isc.ToolStripButton.create({
										ID:"MtoolBarItem001",
										icon:"[skin]/images/matrix/actions/add.png",
										title: "添加",
										showDisabledIcon:false,
										showDownIcon:false 
									});
									MtoolBarItem001.click=function(){
										Matrix.showMask();
										var x = eval("addAuths();");
										if(x!=null && x==false){
											Matrix.hideMask();
											return false;
										}
										Matrix.hideMask();
									}
							</script>
							<script>isc.ToolStripButton.create({
										ID:"MtoolBarItem002",
										icon:"[skin]/images/matrix/actions/delete.png",
										title: "删除",
										showDisabledIcon:false,
										showDownIcon:false 
									});
									MtoolBarItem002.click=function(){
										Matrix.showMask();
										var x = eval("deleteRecord();");
										if(x!=null && x==false){
											Matrix.hideMask();
											return false;
										}
										Matrix.hideMask();
									}
							</script>
							<script>isc.ToolStripButton.create({
										ID:"MtoolBarItem003",
										icon:"[skin]/images/matrix/actions/move_up.png",
										showDisabledIcon:false,
										showDownIcon:false 
									});
									MtoolBarItem003.click=function(){
										Matrix.showMask();
										var x = eval("moveUp();");
										if(x!=null && x==false){
											Matrix.hideMask();
											return false;
										}
										Matrix.hideMask();
									}
							</script>
							<script>isc.ToolStripButton.create({
										ID:"MtoolBarItem004",
										icon:"[skin]/images/matrix/actions/move_down.png",
										showDisabledIcon:false,
										showDownIcon:false 
									});
									MtoolBarItem004.click=function(){
										Matrix.showMask();
										var x = eval("moveDown();");
										if(x!=null && x==false){
											Matrix.hideMask();
											return false;
										}
										Matrix.hideMask();
									}
							</script>
							<div id="QueryList001_tb_div"  style="height:30px;width:100%;;overflow:hidden;" class="matrixInline matrixInlineIE" >
								<script>isc.ToolStrip.create({
										ID:"MQueryList001_tb",
										displayId:"QueryList001_tb_div",
										width: "100%",
										height: "100%",
										position: "relative",
										members: [ 
											MtoolBarItem001,
											MtoolBarItem002,
											MtoolBarItem003,
											MtoolBarItem004 
										] 
									});
									isc.Page.setEvent(isc.EH.RESIZE,function(){
										isc.Page.setEvent(isc.EH.RESIZE,"MQueryList001_tb.resizeTo(0,0);MQueryList001_tb.resizeTo('100%','100%');",null);},
										isc.Page.FIRE_ONCE);
								</script>
							</div>
						</td>
					</tr>
					<tr>
						<td style="overflow:hidden;" class="maintain_form_command" colspan="2" >
							<div id="DataGrid001_div" class="matrixComponentDiv" style="height:100%;width:100%;">
									<script> 
										var MDataGrid001_DS=<%=request.getAttribute("list")%>;
										isc.MatrixListGrid.create({
											ID:"MDataGrid001",
											name:"DataGrid001",
											displayId:"DataGrid001_div",
											position:"relative",
											width:"100%",
											height:"100%",
											showAllRecords:true,
											fields:[
												{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
												{title:"类型",matrixCellId:"type",name:"type",canEdit:false,editorType:'Text',type:'text',valueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'},displayValueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'}},
												{title:"用户名称",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'},
												{title:"部门名称",matrixCellId:"depName",name:"depName",canEdit:false,editorType:'Text',type:'text'},
												{title:"角色名称",matrixCellId:"roleName",name:"roleName",canEdit:false,editorType:'Text',type:'text'}
											],
											autoSaveEdits:false,
											//groupByField:'type',
											isMLoaded:false,
											autoDraw:false,
											autoFetchData:true,
											selectionType:"single",
											selectionAppearance:"rowStyle",
											alternateRecordStyles:true,
											showRollOver:true,
											canSort:true,
											autoFitFieldWidths:false,
											cellDoubleClick:function(record, rowNum, colNum){
																updateRecord();
																(record, rowNum, colNum);},
											startLineNumber:1,
											canEdit:true,
											editEvent:"doubleClick",
											canCustomFilter:true,
											exportCells:[
													{id:'type',title:'类型'},
													{id:'userName',title:'用户名称'},
													{id:'depName',title:'部门名称'},
													{id:'roleName',title:'角色名称'}
											],
											showRecordComponents:true,
											showRecordComponentsByCell:true
										});
										isc.MatrixDataSource.create({
											ID:'MDataGrid001_custom_filter_ds',
											fields:[
												{title:"类型",name:"type",valueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'},
												displayValueMap:{'1':'人员','2':'部门','3':'角色','4':'岗位'},
												type:'text',editorType:'Text'},
												{title:"用户名称",name:"userName",type:'text',editorType:'Text'},
												{title:"部门名称",name:"depName",type:'text',editorType:'Text'},
												{title:"角色名称",name:"roleName",type:'text',editorType:'Text'}
											]
										});
										isc.FilterBuilder.create({
											ID:'MDataGrid001_custom_filter',
											dataSource:MDataGrid001_custom_filter_ds,
											topOperatorAppearance:"none"
										});
										isc.Button.create({
											ID:'MDataGrid001_custom_filter_btn',
											title:"确认",
											autoDraw:false,
											click:"MDataGrid001.hideCustomFilter()"
										});
										isc.Button.create({
											ID:'MDataGrid001_custom_filter_btn_cancel',
											title:"取消",
											autoDraw:false,
											click:"MDataGrid001_custom_filter_window.hide()"
										});
										isc.Window.create({
											ID:'MDataGrid001_custom_filter_window',
											title:"高级查询",
											autoCenter:true,
											overflow:"auto",
											isModal:true,
											autoDraw:false,
											height:300,
											width:500,
											canDragResize:true,
											showMaximizeButton:true,
											items: [MDataGrid001_custom_filter],
											showFooter:true,
											footerHeight:20,
											footerControls:[
												isc.HTMLFlow.create({
														width:'30%',
														contents:"&nbsp;",
														autoDraw:false
												}),
												MDataGrid001_custom_filter_btn,isc.HTMLFlow.create({
														width:'5%',
														contents:"&nbsp;",
														autoDraw:false
												}),
												MDataGrid001_custom_filter_btn_cancel,isc.HTMLFlow.create({
														width:'30%',
														contents:"&nbsp;",
														autoDraw:false
												})
											]
										});
										isc.Page.setEvent(isc.EH.LOAD,function(){
												MDataGrid001.isMLoaded=true;
												MDataGrid001.draw();
												MDataGrid001.setData(MDataGrid001_DS);
												MDataGrid001.resizeTo('100%','100%');
												isc.Page.setEvent(isc.EH.RESIZE,function(){
													isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);
												},
												isc.Page.FIRE_ONCE);
											},
											isc.Page.FIRE_ONCE);
											if(Matrix.getDataGridIdsHiddenOfForm('form0')){
												Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'
											}
									</script>
								</div>
							<input id="matrix_matrix_dataGrid_DataGrid001" name="matrix_matrix_dataGrid_DataGrid001" type="hidden" value="DataGrid001" />
							<input id="DataGrid001_all_rows" name="DataGrid001_all_rows" type="hidden" />
							<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
							
						</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<script>function getParamsForDialog11(){
			var params='&';
			var value;
			return params;
		}
		isc.Window.create({
			ID:"MDialog11",
			id:"Dialog11",
			name:"Dialog11",
			autoCenter: true,
				position:"absolute",
				height: "300px",
				width: "400px",
				title: "添加权限",
				canDragReposition: true,
				showMinimizeButton:false,
				showMaximizeButton:false,
				showCloseButton:true,
				showModalMask: false,
				modalMaskOpacity:0,
				isModal:true,
				autoDraw:false,
				headerControls:["headerIcon","headerLabel","closeButton"],
				getParamsFun:getParamsForDialog11,initSrc:"<%=request.getContextPath()%>/form/admin/foundation/secScopeItem.jsp",
				src:"<%=request.getContextPath()%>/form/admin/foundation/secScopeItem.jsp",
				showFooter: false 
		});
		</script>
		<script>MDialog11.hide();</script>
		<script>function onDialog11Close(data){
			if(data ==null) 
				return true;
			if(isc.isA.String(data)) 
				data=isc.JSON.decode(data);
			var newRow = {};
			newRow.userName=data['userName'];
			newRow.roleName=data['roleName'];
			newRow.depName=data['depName'];
			newRow.type=data['type'];
			newRow.userId=data['userId'];
			newRow.roleId=data['roleId'];
			newRow.depId=data['depId'];
			newRow.index=data['index'];
			newRow.flowUuid=data['flowUuid'];
			var dataGrid = Matrix.getMatrixComponentById('DataGrid001');
			dataGrid.addData(newRow);

}</script>
	<tr id="j_id27" jsId="j_id27">
		<td id="j_id28" jsId="j_id28" class="maintain_form_command"
			colspan="2" rowspan="1">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
				isc.Button.create({
					ID:"MdataFormSubmitButton",
					name:"dataFormSubmitButton",
					title:"保存",
					displayId:"dataFormSubmitButton_div",
					position:"absolute",
					top:0,left:0,
					width:"100%",
					height:"100%",
					icon:Matrix.getActionIcon("save"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
				});
				MdataFormSubmitButton.click=function(){
				Matrix.showMask();
				
				if(!MForm0.validate()){
					Matrix.hideMask(); 
					return false;
				}
				
				getDataGridData();
				Matrix.convertFormItemValue('Form0');
				
				
				document.getElementById('Form0').action="<%=request.getContextPath()%>/catalog_updateCatalogNode.action";
				document.getElementById('Form0').submit();
				Matrix.hideMask();
				};
		</script></div>
		</td>
	</tr>
	
</table>
</div>
<script>Matrix.appendChild('j_id2_div','j_id2_div2');</script>
   <input id="mid" type="hidden" name="mid" value="${catalogNode.mid}" />
    <input id="tenantId" type="hidden" name="tenantId" value="${catalogNode.tenantId}" />
    <input id="phase" type="hidden" name="phase" value="${catalogNode.phase}" />
	<input id="curUserId" type="hidden" name="curUserId" />
	<input id="createdUser" type="hidden" name="createdUser" value="${catalogNode.createdUser}"/>
	<input id="uuid" type="hidden" name="uuid" value="${catalogNode.uuid}" />
	<input id="publicValue" type="hidden" name="publicValue" value="${catalogNode.isPublic }"/>
	<input id="parentUuid" type="hidden" name="parentUuid" value="${catalogNode.parentUuid}" />
	<input id="type" type="hidden" name="type" value="${catalogNode.type}" />
	<input id="index" type="hidden" name="index" value="${catalogNode.index}" />
	<input id="createdDate" type="hidden" name="createdDate" value="${catalogNode.createdDate}" />
	<!-- 在更新过程中传递节点信息 -->
	<input id="parentId" type="hidden" name="parentId" value="${param.entityId}" />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
	
	<input id="comType" type="hidden" name="comType" value="${catalogNode.comType}" />
	<input id="subItems" type="hidden" name="subItems" value="${catalogNode.subItems}" />
	<input type='hidden' id='dataGridData' name='dataGridData' value=""/>
</div>

<script>document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));</script>
<script>document.getElementById('tabContainer0_div').style.display='';</script>
</form>
<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>

</body>
</html>