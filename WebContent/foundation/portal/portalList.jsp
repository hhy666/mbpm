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
	
	<%--弹出新增门户信息--%>
	function showAddDialog(){
	var type=document.getElementById("type").value;
		MDialog0.initSrc="<%=request.getContextPath()%>/portal/portalAction_addPortal.action?type="+type;
		Matrix.showWindow('Dialog0');
	}
	<%--新增门户信息窗口关闭 刷新数据表格--%>
	function onDialog0Close(){
		Matrix.refreshDataGridData('DataGrid001');
	}
	
    <%--上移门户--%>
    function movePortalUp(uuid,index){
    	var selectedRow = index;
    	var curPageFirstRow = MDataGrid001.getData().get(0).index;
    	if(selectedRow==curPageFirstRow) return;
    	var beforeSelected;
    	for(var i = 0;i<MDataGrid001.getData().length;i++){
    		if(MDataGrid001.getData().get(i).uuid==uuid){
    			beforeSelected = MDataGrid001.getData().get(i-1).uuid;
    		}
    	}
		var url = "<%=request.getContextPath()%>/portal/portalAction_movePortalUp.action";
		var newData = "{'beforeSelected':'"+beforeSelected+"','uuid':'"+uuid+"'}";
		var synJson = isc.JSON.decode(newData);
		Matrix.sendRequest(url,synJson,function(data){
			if(data.data){
				var json = isc.JSON.decode(data.data);
				if(json.result==true){
					Matrix.refreshDataGridData('DataGrid001');
				}
			}
		});
    }
    <%--下移门户--%>
    function movePortalDown(uuid,index){
    	var selectedRow = index;
    	var curPageLastRow = MDataGrid001.getData().get(MDataGrid001.getData().length-1).index;
    	if(selectedRow==curPageLastRow)return;
    	var nextSelected;
    	for(var i = 0;i<MDataGrid001.getData().length;i++){
    		if(MDataGrid001.getData().get(i).uuid==uuid){
    			nextSelected = MDataGrid001.getData().get(i+1).uuid;
    		}
    	}
    	var url = "<%=request.getContextPath()%>/portal/portalAction_movePortalDown.action";
		var newData = "{'nextSelected':'"+nextSelected+"','uuid':'"+uuid+"'}";
		var synJson = isc.JSON.decode(newData);
		Matrix.sendRequest(url,synJson,function(data){
			if(data.data){
				var json = isc.JSON.decode(data.data);
				if(json.result==true){
					//MDataGrid001.removeSelectedData();
					Matrix.refreshDataGridData('DataGrid001');
				}
			}
		});
    }
    <%--弹出更新门户信息--%>
    function doubleClickUpdateFormVersion(record){
		MDialog1.initSrc="<%=request.getContextPath()%>/portal/portalAction_updatePortal.action?uuid="+record.uuid+"&type="+record.type;	
		Matrix.showWindow('Dialog1');
	}	
	<%--更新门户信息关闭 刷新数据表格--%>
	function onDialog1Close(){
		Matrix.refreshDataGridData('DataGrid001');
	}
	<%--弹出门户权限信息--%>
	function addPortalAuth(id){
		MDialog2.initSrc="<%=request.getContextPath()%>/portal/portalAction_authList.action?portaluuid="+id;
		Matrix.showWindow('Dialog2');
	}
	<%--设置内容--%>
	function editContent(uuid){
		window.location.href="<%=request.getContextPath()%>/portal/partsAction_findPartsByPortalId.action?type=${param.type}&uuid="+uuid;
	}
	function forwardFrame(){
		var select = MDataGrid001.getSelection();
		if(select!=null&&select.length>0){
			var data = select[0];
			var uuid = data.uuid;//选中行的主键
			var src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action?portalId="+uuid+"&isView=1";
			Matrix.getMatrixComponentById("BorderPanel001Panel2").setContentsURL(src);
		}
	}

	
</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var Mform0=isc.MatrixForm.create({
 				ID:"Mform0",
 				name:"Mform0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>
	<input name="type" id="type" type="hidden" value="${param.type }"/>
		<input name="parentNodeId" id="parentNodeId" type="hidden" value="${param.entityId }"/>
	<div style="padding-left: 5px;padding-top: 5px">
			<image id="image001" style="width:40px;height:30px;display:inline-block;vertical-align:top;margin-right:8px;padding-left:5px;padding-bottom:8px;" name="image001" src="<%=request.getContextPath()%>/resource/images/collaborationthemespace.png" />
              <span id="label011" style="font-size:13px;vertical-align:bottom; " name="label011"/>门户管理&gt;门户管理</span>
			
		</div>
	<div id="VerticalContainer001_div" class="matrixInline" style="width:100%;height:100%;;overflow:hidden;">
	<script>isc.VLayout.create({
				ID:"MVerticalContainer001",
				displayId:"VerticalContainer001_div",
				position: "relative",
				height: "100%",
				width: "100%",
				align: "center",
				overflow: "auto",
				defaultLayoutAlign: "center",
				members: [ 
					isc.MatrixHTMLFlow.create({
						ID:"MBorderPanel001Panel1",
						width: "100%",height: '50%',
						overflow: "hidden",
						showResizeBar:true,
						resizeBarTarget:"",
						contents:"<div id='BorderPanel001Panel1_div' class='matrixComponentDiv'></div>"
					}),
					isc.HTMLPane.create({
						ID:"MBorderPanel001Panel2",
						width: "100%",height: '50%',
						overflow: "hidden",
						showEdges:false,
						contentsType:"page",
						contentsURL:"<%=request.getContextPath()%>/foundation/portal/portalFirst.jsp?count=<%=request.getAttribute("totalSize")%>"
				}) ],
				canSelectText: true 
			});
		</script>
	</div>
	<div id="BorderPanel001Panel1_div2" style="width:100%;height:100%;overflow:hidden;" class="matrixInline">
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
					isc.ToolStripButton.create({
							ID:"MtoolBarItem",
							icon:"<%=request.getContextPath()%>/resource/images/query.png",
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
					isc.ToolStripButton.create({
						ID:"MtoolBarItem001",
						icon:"<%=request.getContextPath()%>/resource/images/new.png",
						title: "添加",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem001.click=function(){
						Matrix.showMask();
						showAddDialog();
						Matrix.hideMask();
					}
				</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem0001",
						icon:"<%=request.getContextPath()%>/resource/images/edit.png",
						title: "修改",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem0001.click=function(){
						var select = MDataGrid001.getSelection();
						if(select.length == 1){
							var id = select.get(0).uuid;
							var type = select.get(0).type;
							MDialog1.initSrc="<%=request.getContextPath()%>/portal/portalAction_updatePortal.action?uuid="+id+"&type="+type;	
							Matrix.showWindow('Dialog1');
						}else{
							isc.warn('请选择一条数据!');
							return;
						}
					
					}
					</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem002",
						icon:"<%=request.getContextPath()%>/resource/images/delete.png",
						title: "删除",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem002.click=function(){
						var select = MDataGrid001.getSelection();
						if(select.length>0&&select!=null){
							var ids ="";
							for(var i=0;i<select.length;i++){
								if(i!=select.length-1){
									ids+=select.get(i).uuid;
									ids+=",";
								}else{
									ids+=select.get(i).uuid;
								}
							}
							isc.confirm('确认删除?',function(value){
								if(value){
									var url = "<%=request.getContextPath()%>/portal/portalAction_deletePortal.action";
									var newData = "{'uuid':'"+ids+"'}";
									var synJson = isc.JSON.decode(newData);
									Matrix.sendRequest(url,synJson,function(data){
												if(data.data){
													var json = isc.JSON.decode(data.data);
													if(json.result==true){
														Matrix.refreshDataGridData('DataGrid001');
													}else if(json.result == 'default'){
														Matrix.warn('禁止删除默认门户！');
													}
												}
											});
								}
							});
						}else{
							isc.warn('请选择数据!');
							return;
						}
					
					}
					</script>
					<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem003",
							icon:"<%=request.getContextPath()%>/resource/images/moveup.png",
							title: "上移",
							showDisabledIcon:false,showDownIcon:false 
						});
						MtoolBarItem003.click=function(){
							var select = MDataGrid001.getSelection();
							if(select.length>0&&select!=null){
								if(select.length>1){
									isc.warn("只能选择一条数据上移!");
									return;
								}
								var uuid = select.get(0).uuid;
								var index = select.get(0).index;
								movePortalUp(uuid,index);
							}else{
								isc.warn("请先选中数据!");
							}
						}
					</script>
					<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem004",
							icon:"<%=request.getContextPath()%>/resource/images/movedown.png",
							title: "下移",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem004.click=function(){
							var select = MDataGrid001.getSelection();
						
							if(select.length>0&&select!=null){
								if(select.length>1){
									isc.warn("只能选择一条数据下移!");
									return;
								}
								var id = select.get(0).uuid;
								var index = select.get(0).index;
								movePortalDown(id,index);
							}else{
								isc.warn("请先选中数据!");
							}
						}
					</script>
				
					<script>
					var type = document.getElementById("type").value;
					if(type==1){
						isc.ToolStripButton.create({
							ID:"MtoolBarItem005",
							icon:"<%=request.getContextPath()%>/resource/images/setAuth.png",
							title: "授权",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem005.click=function(){
							var select = MDataGrid001.getSelection();
							if(select.length>0&&select!=null){
								if(select.length>1){
									isc.warn("请选择一条门户数据!");
									return;
								}
								var id = select.get(0).uuid;
								addPortalAuth(id);
							}else{
								isc.warn("请先选中数据!");
							}
						}
						}
					</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem006",
						icon:"<%=request.getContextPath()%>/resource/images/edit.png",
						title: "设置内容",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem006.click=function(){
						Matrix.showMask();
						var select = MDataGrid001.getSelection();
						if(select.length>0&&select!=null){
							if(select.length>1){
								isc.warn("请选择一条门户数据!");
								return;
							}
							var uuid = select.get(0).uuid;
							editContent(uuid);
							
						}else{
							isc.warn("请选择门户数据!");
							Matrix.hideMask();
							return;
						}
						Matrix.hideMask();
					}
				</script>
				<script>
					isc.ToolStripButton.create({
							ID:"MtoolBarItem007",
							icon:"<%=request.getContextPath()%>/resource/images/preview.png",
							title: "预览",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem007.click=function(){
							var select = MDataGrid001.getSelection();
							if(select && select.length>0){
								var id = select.get(0).uuid;
								window.open("<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action?portalId="+id);
							}else{
								isc.warn("请先选中数据!");
							}
						}
					</script>
					
				<div id="QueryForm59ca4db3ea95422cac1938910af18114_tb_div"  style="width:100%;height:44px;;overflow:hidden;position:absolute;top:0px;"  >
					<script>
					var type = document.getElementById("type").value;
					if(type==1){
						isc.ToolStrip.create({
							ID:"MQueryForm59ca4db3ea95422cac1938910af18114_tb",
							displayId:"QueryForm59ca4db3ea95422cac1938910af18114_tb_div",
							width: "100%",height: "100%",
							position: "relative",
							members: [ 
								isc.MatrixHTMLFlow.create({
									ID:"MQueryField002_Label",
									contents:"<div  id='MQueryField002_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >标题</div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"QueryField002",
									contents:"<div id='QueryField002_div' eventProxy='Mform0' style='margin-top:4px;width:150px;' class='toolBarItemInputText' ></div>"
								}),
								MtoolBarItem,     	
								MtoolBarItem001,	
								MtoolBarItem0001,
								MtoolBarItem003,
								MtoolBarItem004,	
								MtoolBarItem002,	
								MtoolBarItem005,	
								MtoolBarItem006,	
								MtoolBarItem007
							] 
							
						});
						}else{
						isc.ToolStrip.create({
							ID:"MQueryForm59ca4db3ea95422cac1938910af18114_tb",
							displayId:"QueryForm59ca4db3ea95422cac1938910af18114_tb_div",
							width: "100%",height: "100%",
							position: "relative",
							members: [ 
								isc.MatrixHTMLFlow.create({
									ID:"MQueryField002_Label",
									contents:"<div  id='MQueryField002_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >标题</div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"QueryField002",
									contents:"<div id='QueryField002_div' eventProxy='Mform0' style='margin-top:4px;width:150px;' class='toolBarItemInputText' ></div>"
								}),
								MtoolBarItem,     	
								MtoolBarItem001,
								MtoolBarItem0001,	
								MtoolBarItem003,	
								MtoolBarItem004,	
								MtoolBarItem002,	
								MtoolBarItem006,	
								MtoolBarItem007
							] 
							
						});
						}
						isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm59ca4db3ea95422cac1938910af18114_tb.resizeTo(0,0);MQueryForm59ca4db3ea95422cac1938910af18114_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);
				</script>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2"
			style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
		<div id="DataGrid001_div" class="matrixComponentDiv"
			style="width: 100%;">
				<script> var MDataGrid001_DS=<%=request.getAttribute("lists")%>;
						 isc.MatrixListGrid.create({
						 	ID:"MDataGrid001",
						 	name:"DataGrid001",
						 	displayId:"DataGrid001_div",
						 	position:"relative",
						 	recordClick:'forwardFrame()',
						 	width:"100%",
						 	height:"100%",
						 	recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                        		doubleClickUpdateFormVersion(record);
                     		},
						 	fields:[
						 		{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
						 		{title:"门户标题",matrixCellId:"title",name:"title",canEdit:false,editorType:'Text',type:'text'},
						 		//{title:"布局模式",matrixCellId:"model",name:"model",canEdit:false,editorType:'Text',type:'text',valueMap:{'0':'列布局','1':'行布局'}},
						 		{title:"列数",matrixCellId:"layout",name:"layout",canEdit:false,editorType:'Text',type:'text',valueMap:{'0':'','1':'1列','2':'2列','3':'3列'}},
						 		//{title:"布局样式",matrixCellId:"partSize",name:"partSize",canEdit:false,editorType:'Text',type:'text'},
						 		{title:"状态",matrixCellId:"status",name:"status",canEdit:false,editorType:'RadioGroup',type:'text',valueMap:{'0':'已启用','1':'已禁用'}}
						 	],
						 	canHover:true,
						 	showHover:true,
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
						 		{id:'title',title:'门户标题'},
						 		{id:'model',title:'布局模式'},
						 		{id:'layout',title:'列数'},
						 		{id:'partSize',title:'布局样式'},
						 		{id:'status',title:'状态'}
						 	],
						 	showRecordComponents:true,
						 	showRecordComponentsByCell:true
						 });
						 isc.MatrixDataSource.create({
						 	ID:'MDataGrid001_custom_filter_ds',
						 	fields:[
						 		{title:"门户标题",name:"title",type:'text',editorType:'Text'},
						 		{title:"布局模式",name:"model",type:'text',editorType:'Text',valueMap:{'0':'列布局','1':'行布局'}},
						 		{title:"列数",name:"layout",type:'text',editorType:'Text'},
						 		{title:"布局模式",name:"partSize",type:'text',editorType:'Text'},
						 		{title:"状态",name:"status",type:'text',editorType:'RadioGroup'}
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
						 isc.Page.setEvent(isc.EH.LOAD,function(){
						 	MDataGrid001.isMLoaded=true;
						 	MDataGrid001.draw();
						 	MDataGrid001.setData(MDataGrid001_DS);
						 	MDataGrid001.resizeTo('100%','100%');
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
					<img id="brpageDataGrid001_fI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/first_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:previous" class="paginator_previous">
					<img id="brpageDataGrid001_pI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/pre_gray.gif" border="0" line-height="30px"/>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
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
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:next" class="paginator_next">
					<img id="brpageDataGrid001_nI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/next_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:last" class="paginator_last" line-height="30px">
					<img id="brpageDataGrid001_lI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/last_gray.gif"	border="0" line-height="30px"/>
				</span>
				<span class="paginator_clean" line-height="30px">
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:refresh" class="paginator_refresh" line-height="30px">
					<a href="javascript:#"></a>
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
		height: "65%",
		width: "60%",
		title: "新增门户信息",
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
		<script>
	function getParamsForDialog1(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog1",
		id:"Dialog1",
		name:"Dialog1",
		autoCenter: true,
		position:"absolute",
		height: "65%",
		width: "60%",
		title: "更新门户信息",
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
		<script>MDialog1.hide();
		</script>
		<script>
	function getParamsForDialog2(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog2",
		id:"Dialog2",
		name:"Dialog2",
		autoCenter: true,
		position:"absolute",
		height: "70%",
		width: "70%",
		title: "门户授权",
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
		<script>MDialog2.hide();
		</script>
		<script>
	function getParamsForDialog1(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog3",
		id:"Dialog3",
		name:"Dialog3",
		autoCenter: true,
		position:"absolute",
		height: "95%",
		width: "90%",
		title: "选择管理员",
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
		<script>MDialog3.hide();
		</script>
		<script>null;</script>	
</form>
<script>
	Mform0.initComplete=true;Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);
</script>
<script>
	document.getElementById('BorderPanel001Panel1_div').appendChild(document.getElementById('BorderPanel001Panel1_div2'));
</script>
<script>
						isc.Window.create({
								ID:"MMainDialog",
								id:"MainDialog",
								name:"MainDialog",
								position:"absolute",
								title: "部门选择",
								autoCenter: true,
								animateMinimize: false,
								canDragReposition: false,
								showHeaderIcon:false,
								showTitle:true,
								showMinimizeButton:false,
								showMaximizeButton:false,
								howCloseButton:true,
								showModalMask: false,
								isModal:true,
								getParamsFun:getParamsForDialog0,
								autoDraw: false,
								initSrc:'<%=request.getContextPath()%>/common/deptSelect.jsp',
								src:'<%=request.getContextPath()%>/common/deptSelect.jsp'
							});
				</script>
</div>

</body>
</html>