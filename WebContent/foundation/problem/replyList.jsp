<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
	//回复
	function reply(uuid){
		var sysId = Matrix.getFormItemValue('sysId');
		Matrix.setFormItemValue('fileFlag','reply');
		MDialog0.initSrc="<%=request.getContextPath()%>/problem/problemAction_dealProblemReport.action?status=reply&uuid="+uuid+"&sysId="+sysId;
		MDialog0.setHeight('700px');
		Matrix.showWindow('Dialog0');
	}
	//查看
	function readProblem(uuid){
		MDialog0.initSrc="<%=request.getContextPath()%>/problem/problemAction_dealProblemReport.action?status=read&uuid="+uuid;
		MDialog0.setHeight('700px');
		Matrix.showWindow('Dialog0');
	}
	//关闭刷新
	function onDialog0Close(){
		Matrix.refreshDataGridData('DataGrid001');
	}
	/*********************************************************/
	//根据有没有sysId加载页面
	function checkSysId(){
		var sysId = Matrix.getFormItemValue("sysId");
		var newToolBarItemArray=[];
		var toolBarItemArray = MQueryForm_tb.members;
		if(sysId!=''&&sysId!=null&&sysId.length>0){
			for(var i=0;i<toolBarItemArray.length;i++){
				if(i==2||i==3){
					continue;
				}
				newToolBarItemArray.add(toolBarItemArray[i]);
			}
			MQueryForm_tb.setMembers(newToolBarItemArray);
		}else{
			MQueryForm_tb.setMembers(toolBarItemArray);
		}
		
	}
	/*********************************************************/
</script>
</head>
<body onload="checkSysId()">
	
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>
<script> var Mform0=isc.MatrixForm.create({
	ID:"Mform0",
	name:"Mform0",
	position:"absolute",
	action:"<%=request.getContextPath()%>/matrix.rform",
	fields:[{name:'form0_hidden_text',
			 width:0,
			 height:0,
			 displayId:'form0_hidden_text_div'
	}]});
</script>
<div
	style="width: 100%; height: 100%; overflow: auto; position: relative;">
	<form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/problem/problemAction_replyProblemReports.action?flag=reply" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="form0" value="form0" />
		<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid001"/>
		<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
		<input type="hidden" id="userId" name="userId" value="${param.userId }"/>
		<input type="hidden" id="pageSize" name="pageSize" value="${param.pageSize }"/>
		<input type="hidden" id="curPageNum" name="curPageNum" value="${param.curPageNum }"/>
		<input type="hidden" id="fileFlag" name="fileFlag" />
		<input type="hidden" id="userName" name="userName" value="${param.userName }">
		<input type="hidden" id="userId" name="userId" value="${param.userId }" /> 
		<input type="hidden" id="email" name="email" value="${param.email }"/>
		<input type="hidden" id="telephone" name="telephone" value="${param.telephone }"/>
		<input type="hidden" id="status" name="status" value="1"/>
		<input type="hidden" id="sysId" name="sysId" value="${param.sysId }"/>
		<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
			
			<div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;" >
				<script> 
					var MTabContainer001 = isc.TabSet.create({
							ID:"MTabContainer001",
							displayId:"TabContainer001_div",
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
									ID:"MTabBar001",
									width:"300px",
									contents:"<div id='TabBar001_div' style='text-align:right;' ></div>"}) 
								],
								tabs: [ 
									{title: "问题回复列表",
									 autoDraw: false,
									 pane:isc.MatrixHTMLFlow.create(
									 	{ID:"MTabPanel001",
									 	 autoDraw: false,
									 	 width: "100%",
									 	 height: "100%",
									 	 overflow: "hidden",
									 	 contents:"<div id='TabPanel001_div' style='width:100%;height:100%'></div>"})} ] });document.getElementById('TabContainer001_div').style.display='';MTabPanel001.draw();isc.Page.setEvent("load","MTabContainer001.selectTab(0);");</script></div>
			<div id="TabPanel001_div2" style="width:100%;height:100%;overflow:hidden;" class="matrixInline">
			<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
				<tr><td class="query_form_toolbar" colspan="2">
				<script> 
					var QueryField002=isc.TextItem.create({
							ID:"MQueryField002",
							name:"QueryField002",
							editorType:"TextItem",
							displayId:"QueryField002_div",
							position:"relative"
						});
						Mform0.addField(QueryField002);
				</script>
		<script> 
					var inputSysIdValue=isc.TextItem.create({
							ID:"MinputSysIdValue",
							name:"inputSysIdValue",
							width:200,
							editorType:"TextItem",
							displayId:"inputSysIdValue_div",
							position:"relative"
						});
						Mform0.addField(inputSysIdValue);
				</script>
				<script> 
					var MconditionType_VM=[]; 
					var conditionType=isc.SelectItem.create({
							ID:"MconditionType",
							name:"conditionType",
							editorType:"SelectItem",
							displayId:"conditionType_div",
							autoDraw:false,
							valueMap:[],
							value:"0",
							position:"relative",
							width:72
					});
					Mform0.addField(conditionType);
					MconditionType_VM=['0','1','-1'];
					MconditionType.displayValueMap={'0':'未回复','1':'已回复','-1':'全部'};
					MconditionType.setValueMap(MconditionType_VM);
					MconditionType.setValue('0');
				</script>
				<script>
					isc.ToolStripButton.create({
							ID:"MtoolBarItem",
							icon:"[skin]/images/matrix/actions/query.png",
							title: "查询",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem.click=function(){
							Matrix.showMask();
							Matrix.refreshDataGridData('DataGrid001');
							Matrix.hideMask();
						}
				</script>
				<script>
				//添加问题报告，只显示问题报告部分不显示回复部分
					isc.ToolStripButton.create({
						ID:"MtoolBarItem003",
						icon:"[skin]/images/matrix/actions/edit.png",
						title: "回复",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem003.click=function(){
						var select = MDataGrid001.getSelection();
						Matrix.showMask();
						if(select.length==1){
							var uuid = select.get(0).uuid;
							reply(uuid);
						}else if(select.length==0){
							Matrix.warn('请先选中一条问题报告!');
						}else{
							Matrix.warn('只能选中一条进行操作!');
						}
						Matrix.hideMask();
					}
				</script>
				
				
				<div id="MQueryForm_tb_div"  style="width:100%;height:30px;;overflow:hidden;position:absolute;top:0px;"  >
					<script>
						isc.ToolStrip.create({
							ID:"MQueryForm_tb",
							displayId:"MQueryForm_tb_div",
							width: "100%",height: "100%",
							position: "relative",
							members: [ 
								isc.MatrixHTMLFlow.create({
									ID:"MQueryField002_Label",
									contents:"<div  id='MQueryField002_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >标题</div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"QueryField002",
									contents:"<div id='QueryField002_div' eventProxy='Mform0' style='width:150px;' class='toolBarItemInputText' ></div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"MinputSysIdValue_Label",
									contents:"<div  id='MinputSysIdValue_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >系统编号</div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"inputSysIdValue",
									contents:"<div id='inputSysIdValue_div' eventProxy='Mform0' style='width:200px;' class='toolBarItemInputText'></div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"MconditionType_Label",
									contents:"<div id='MconditionType_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >状态</div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"conditionType",
									contents:"<div id='conditionType_div' eventProxy='Mform0' style='width:72px' class='toolBarItemInputText' ></div>"
								}),
								MtoolBarItem,
								MtoolBarItem003     	
							] 
							
						});
						isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm_tb.resizeTo(0,0);MQueryForm_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);
				</script>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="border-style:none;width:100%;;margin:0px;padding:0px;position:absolute;top:31px;bottom:37px;">
			<div id="DataGrid001_div" class="matrixComponentDiv" style="width:100%;height:100%;">
				<script> var MDataGrid001_DS=<%=request.getAttribute("lists")%>;
						 isc.MatrixListGrid.create({
						 	ID:"MDataGrid001",
						 	name:"DataGrid001",
						 	displayId:"DataGrid001_div",
						 	position:"relative",
						 	width:"100%",
						 	height:"100%",
						 	recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                        		  reply(record.uuid);
                     		},
						 	fields:[
						 		{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
						 		{title:"标题",matrixCellId:"title",name:"title",canEdit:false,editorType:'Text',type:'text'},
						 		{title:"报告时间",matrixCellId:"reportDate",name:"reportDate",canEdit:false,editorType:'Text',type:'text'},
						 		{title:"回复时间",matrixCellId:"replyDate",name:"replyDate",canEdit:false,editorType:'Text',type:'text'},
						 		//{title:"系统编号",matrixCellId:"reportorSysId",name:"reportorSysId",canEdit:false,editorType:'Text',type:'text'},
						 		{title:"状态",matrixCellId:"replyStatus",name:"replyStatus",canEdit:false,editorType:'RadioGroup',type:'text',valueMap:{'0':'未回复','1':'已回复'}},
						 		
						 	],
						 	
						 	autoSaveEdits:false,
						 	isMLoaded:false,
						 	autoDraw:false,
						 	autoFetchData:true,
						 	selectionType:"multiple",
						 	selectionAppearance:"rowStyle",
						 	alternateRecordStyles:true,
						 	canSort:true,
						 	autoFitFieldWidths:false,
						 	startLineNumber:1,
						 	editEvent:"doubleClick",
						 	canCustomFilter:true,
						 	exportCells:[
						 		{id:'title',title:'标题'},
						 		{id:'model',title:'报告时间'},
						 		{id:'status',title:'状态'}
						 	],
						 	showRecordComponents:true,
						 	showRecordComponentsByCell:true
						 });
						 isc.MatrixDataSource.create({
						 	ID:'MDataGrid001_custom_filter_ds',
						 	fields:[
						 		{title:"标题",name:"title",type:'text',editorType:'Text'},
						 		{title:"报告时间",name:"model",type:'text',editorType:'Text',valueMap:{'0':'列布局','1':'行布局'}},
						 		{title:"状态",name:"layout",type:'text',editorType:'Text'},
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
						 		MDataGrid001_custom_filter_btn,
						 		isc.HTMLFlow.create({
						 			width:'5%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		}),
						 		MDataGrid001_custom_filter_btn_cancel,
						 		isc.HTMLFlow.create({
						 			width:'30%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		})
						 	]
						 });
						 isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');
						 isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
						 if(Matrix.getDataGridIdsHiddenOfForm('form0')){
						 	Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
			</script>
			<script>
				var	curPageNum = <%=request.getAttribute("curPageNum")%>;
				var totalPageNum = <%=request.getAttribute("totalPageNum")%>;
				var totalSize = <%=request.getAttribute("totalSize")%>;
			isc.Page.setEvent("load","Matrix.fillDataPaginator('blpageDataGrid001',"+curPageNum+","+totalPageNum+",5,'DataGrid001',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			<script>
			isc.Page.setEvent("load","Matrix.fillDataPaginator('brpageDataGrid001',"+curPageNum+","+totalPageNum+",5,'DataGrid001',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			
			</div>
				<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
				<input id="DataGrid001_data_entity" name="DataGrid001_data_entity" value="foundation.portal.Portal" type="hidden" />
		</td>
	</tr>
	<tr style="width: 100%;height:35px;">
		<td class="toolStrip"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;">
			<span id="blpageDataGrid001" class="paginator">
				<span id="blpageDataGrid001:status" class="paginator_status">
				</span>
			</span>
		</td>
		<td class="toolStrip" 
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align:right; margin: 0px; padding: 0px;">
			<span id="brpageDataGrid001" class="paginator" style="float:right;">
				<span id="brpageDataGrid001:first" class="paginator_first">
					<img id="brpageDataGrid001_fI" src="<%=request.getContextPath()%>/resource/images/paginator/first.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:previous" class="paginator_previous">
					<img id="brpageDataGrid001_pI" src="<%=request.getContextPath()%>/resource/images/paginator/pre.gif" border="0" line-height="30px"/>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:go" class="paginator_go" >
					<span class="go_prefix" line-height="30px">
						第
					</span>
					<span id="brpageDataGrid001:goText" class="paginator_go_text" line-height="30px">
					</span>
					<span class="go_suffix" line-height="30px">
						页
					</span>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:next" class="paginator_next">
					<img id="brpageDataGrid001_nI" src="<%=request.getContextPath()%>/resource/images/paginator/next.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:last" class="paginator_last" line-height="30px">
					<img id="brpageDataGrid001_lI" src="<%=request.getContextPath()%>/resource/images/paginator/last.gif"	border="0" line-height="30px"/>
				</span>
				<span class="paginator_clean" line-height="30px">
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:refresh" class="paginator_refresh" line-height="30px">
					<img src="<%=request.getContextPath()%>/resource/images/paginator/refresh.png" title="刷新" onclick="Matrix.pagingByGoButton('DataGrid001','brpageDataGrid001',1);"/>
				</span>
				<span>
					&nbsp;&nbsp;
				</span>
				<span id="DataGrid001_brpageDataGrid001_dynamic_perpage_count_div" eventProxy="Mform0" class="matrixInline" line-height="30px">
				</span>
			<script>var DataGrid001_brpageDataGrid001_dynamic_perpage_count=
				isc.SelectItem.create({ID:"MDataGrid001_brpageDataGrid001_dynamic_perpage_count",
									   name:"DataGrid001_brpageDataGrid001_dynamic_perpage_count",
									   paginator:"brpageDataGrid001",
									   editorType:"SelectItem",
									   width:80,
									   displayId:"DataGrid001_brpageDataGrid001_dynamic_perpage_count_div",
									   value:"0",
									   valueMap:{'0':'每页记录','10':'每页10条','20':'每页20条','30':'每页30条','40':'每页40条','50':'每页50条','-1':'全部数据'}});
									   Mform0.addField(DataGrid001_brpageDataGrid001_dynamic_perpage_count);
									   MDataGrid001_brpageDataGrid001_dynamic_perpage_count.observe(MDataGrid001_brpageDataGrid001_dynamic_perpage_count,
									   "changed",
									   "Matrix.dynamicPagingDataGridData('DataGrid001','brpageDataGrid001',MDataGrid001_brpageDataGrid001_dynamic_perpage_count.getValue())");
			 </script>
		</span>
	</td>
	</tr>
</table>
</div>
<script>
	function getParamsForDialog0(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		autoCenter: true,
		position:"absolute",
		width: "900px",
		title: "问题报告",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
		<script>MDialog0.hide();
		</script>
		
</form>
</div>
<script>document.getElementById('TabPanel001_div').appendChild(document.getElementById('TabPanel001_div2'));</script><div id="TabBar001_div2" style="text-align:right"  class="matrixInline"></div>
<script>document.getElementById('TabBar001_div').appendChild(document.getElementById('TabBar001_div2'));</script><script>document.getElementById('TabContainer001_div').style.display='';</script>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>

</html>