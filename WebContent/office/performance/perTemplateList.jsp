<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>模板列表</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
		//双击选择
		function doubleClick2Select(record){
			if(record!=null){
				//var userNode = parent.document.getElementById('userId');
				//if(userNode!=null){
					//userNode.value = record.userId;
				//}
				Matrix.closeWindow(record);
				
			}else{
				Matrix.warn("您选择的数据不存在!");
			}
			
		}
		//点击确认
		function saveUser(){
			var select = MDataGrid004.getSelection();
			if(select!=null && select.length>0){
				var record = select[0];
				//var userNode = parent.document.getElementById('userId');
				//if(userNode!=null){
					//userNode.value = record.userId;
				//}
				Matrix.closeWindow(record);
				
			}else{
				Matrix.warn("请先选择人员!");
			}
		}
		
		//---------------键盘监听事件-----开始-----------------
		isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
        	var _key = isc.Event.getKey();
        	if(_key=="Enter" && MQueryField002==MQueryField002.form.getFocusItem()){
         	   MtoolBarItem002.click();
       		}
    	});
		//---------------键盘监听事件-----结束-----------------
		</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 				ID:"MForm0",
 				name:"MForm0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="X-Requested-With" name="X-Requested-With" value="XMLHttpRequest">
	<!-- dataGridId必须有 -->
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid004"/>
	<!-- 子页面的隐藏字段 -->
	
	
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
	<!-- <tr>
		<td class="query_form_toolbar" colspan="2">
				<script> var McomboBox001_VM=[]; 
						 var comboBox001=isc.SelectItem.create({
						 		ID:"McomboBox001",
						 		name:"comboBox001",
						 		editorType:"SelectItem",
						 		displayId:"comboBox001_div",
						 		autoDraw:false,
						 		value:'1',
						 		changed:'checkIsSelectedUser()',
						 		position:"relative",
						 		width:"100%"
						 		});
						 		MForm0.addField(comboBox001);
						 		McomboBox001_VM=['0','1'];
						 		McomboBox001.displayValueMap={'0':'工号','1':'姓名'};
						 		McomboBox001.setValueMap(McomboBox001_VM);
				</script>
			<script> var QueryField002=isc.TextItem.create({
							ID:"MQueryField002",
							name:"QueryField002",
							editorType:"TextItem",
							displayId:"QueryField002_div",
							position:"relative",
							width:'80px',
							autoDraw:false
						});
						MForm0.addField(QueryField002);
			</script>
			<script>isc.ToolStripButton.create({
							ID:"MtoolBarItem002",
							icon:"<%=request.getContextPath()%>/resource/images/query.png",
							title: "",
							showDisabledIcon:false,
							width:'40px',
							showDownIcon:false 
					});
					MtoolBarItem002.click=function(){
						Matrix.showMask();
						Matrix.refreshDataGridData('DataGrid004');
						//根据条件查询
						//queryByCondition();
						Matrix.hideMask();
					}
			</script>
			
					
		<div id="QueryForm001_tb_div"
			style="width: 100%; height: 30px;; overflow: hidden;">
				<script>isc.ToolStrip.create({
							ID:"MQueryForm001_tb",
							displayId:"QueryForm001_tb_div",
							width: "100%",height: "100%",
							position: "relative",
							members: [ 
							
							    isc.MatrixHTMLFlow.create({
									ID:"comboBox001",
									contents:"<div id='comboBox001_div' eventProxy='MForm0' style='width:55px;' class='toolBarItemComboBox' ></div>"
								}),
								
								isc.MatrixHTMLFlow.create({
									ID:"QueryField002",
									contents:"<div id='QueryField002_div' eventProxy='MForm0' style='width:80px;' class='toolBarItemInputText' ></div>"
								}),
								MtoolBarItem002
									
							] 
						});
						isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm001_tb.resizeTo(0,0);MQueryForm001_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div>
						
						
						
		</td>
	</tr> -->
	<tr id="tr001">
	<td id="td001" class="tdLayout" style="width:100%;height:100%;" colspan="2">
	
<div id="DataGrid004_div" class="matrixComponentDiv" style="width:100%;height:100%;">
<script> var MDataGrid004_DS=<%=request.getAttribute("str")%>;
	
	isc.MatrixListGrid.create({
		ID:"MDataGrid004",
		name:"DataGrid004",
		displayId:"DataGrid004_div",
		position:"relative",
		width:"100%",
		height:"100%",
		fields:[
			{title:"模板名称",matrixCellId:"templateNames",name:"templateNames",canEdit:false,editorType:'Text',type:'text'}
		],
		autoSaveEdits:false,
		isMLoaded:false,
		autoDraw:false,
		autoFetchData:true,
		selectionType:"single",
		selectionAppearance:"rowStyle",
		canDragSelect:true,
		alternateRecordStyles:true,
		showRollOver:true,
		canSort:true,
		autoFitFieldWidths:false,
		cellDoubleClick:function(record, rowNum, colNum){doubleClick2Select(record);(record, rowNum, colNum);},
		editEvent:"doubleClick",
		canCustomFilter:true,
		exportCells:[{id:'templateNames',title:'模板名称'}],
		showRecordComponents:true,
		showRecordComponentsByCell:true});
		isc.MatrixDataSource.create({
			ID:'MDataGrid004_custom_filter_ds',
			fields:[{title:"模板名称 ",name:"templateNames",type:'text',editorType:'InputHidden'}
				   ]});
	    isc.FilterBuilder.create({ID:'MDataGrid004_custom_filter',dataSource:MDataGrid004_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
	    isc.Button.create({ID:'MDataGrid004_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid004.hideCustomFilter()"});
	    isc.Button.create({ID:'MDataGrid004_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid004_custom_filter.clearCriteria()"});
	    isc.Button.create({ID:'MDataGrid004_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid004_custom_filter_window.hide()"});
	    isc.Window.create({ID:'MDataGrid004_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid004_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid004_custom_filter.resizeTo('100%','100%');MDataGrid004_custom_filter_window.hide();isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid004.isMLoaded=true;MDataGrid004.draw();MDataGrid004.setData(MDataGrid004_DS);MDataGrid004.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid004.resizeTo(0,0);MDataGrid004.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid004'}</script>
	    
	    <script>
				var	curPageNum = <%=request.getAttribute("curPageNum")%>;
				var totalPageNum = <%=request.getAttribute("totalPageNum")%>;
				var totalSize = <%=request.getAttribute("totalSize")%>;
			isc.Page.setEvent("load","Matrix.fillDataPaginator('blpageDataGrid004',"+curPageNum+","+totalPageNum+",5,'DataGrid004',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			<script>
			isc.Page.setEvent("load","Matrix.fillDataPaginator('brpageDataGrid004',"+curPageNum+","+totalPageNum+",5,'DataGrid004',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			
	    
	    
	    </div>
	    </td>
	    </tr>
	<!-- 	<tr style="width: 100%;height:35px;">
		<td class="toolStrip"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;">
			<span id="blpageDataGrid004" class="paginator">
				<span id="blpageDataGrid004:status" class="paginator_status">
				</span>
			</span>
		</td>
		<td class="toolStrip" 
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align:right; margin: 0px; padding: 0px;">
			<span id="brpageDataGrid004" class="paginator" style="float:right;">
				<span id="brpageDataGrid004:first" class="paginator_first">
					<img id="brpageDataGrid004_fI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/first_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid004:previous" class="paginator_previous">
					<img id="brpageDataGrid004_pI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/pre_gray.gif" border="0" line-height="30px"/>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid004:go" class="paginator_go" >
					<span class="go_prefix" line-height="30px">
						第
					</span>
					<span id="brpageDataGrid004:goText" class="paginator_go_text" line-height="30px">
					</span>
					<span class="go_suffix" line-height="30px">
						页
					</span>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid004:next" class="paginator_next">
					<img id="brpageDataGrid004_nI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/next_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid004:last" class="paginator_last" line-height="30px">
					<img id="brpageDataGrid004_lI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/last_gray.gif"	border="0" line-height="30px"/>
				</span>
				<span class="paginator_clean" line-height="30px">
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid004:refresh" class="paginator_refresh" line-height="30px">
					<a href="javascript:#"></a>
				</span>
				<span>
					&nbsp;&nbsp;
				</span>
				<span id="DataGrid004_brpageDataGrid004_dynamic_perpage_count_div" eventProxy="MForm0" class="matrixInline" line-height="30px">
				</span>
			<script>var DataGrid004_brpageDataGrid004_dynamic_perpage_count=
				isc.SelectItem.create({ID:"MDataGrid004_brpageDataGrid004_dynamic_perpage_count",
									   name:"DataGrid004_brpageDataGrid004_dynamic_perpage_count",
									   paginator:"brpageDataGrid004",
									   editorType:"SelectItem",
									   width:80,
									   displayId:"DataGrid004_brpageDataGrid004_dynamic_perpage_count_div",
									   value:"0",
									   valueMap:{'0':'每页记录','10':'每页10条','20':'每页20条','30':'每页30条','40':'每页40条','50':'每页50条','-1':'全部数据'}});
									   MForm0.addField(DataGrid004_brpageDataGrid004_dynamic_perpage_count);
									   MDataGrid004_brpageDataGrid004_dynamic_perpage_count.observe(MDataGrid004_brpageDataGrid004_dynamic_perpage_count,
									   "changed",
									   "Matrix.dynamicPagingDataGridData('DataGrid004','brpageDataGrid004',MDataGrid004_brpageDataGrid004_dynamic_perpage_count.getValue())");
			 </script>
		</span>
		</td>
	
	<tr> -->
	<td id="td004" class="tdLayout" style="width:100%;height:30px;text-align:center;" colspan="2">
		<div id="button003_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
				<script>isc.Button.create({
								ID:"Mbutton003",
								name:"button003",
								title:"确认",
								displayId:"button003_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton003.click=function(){
									Matrix.showMask();
									var x = eval("saveUser();");
									if(x!=null && x==false){
										Matrix.hideMask();
										Mbutton003.enable();
										return false;
									}
									Matrix.hideMask();
								};
				</script>
		</div>
		<div id="button004_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
			<script>isc.Button.create({
						ID:"Mbutton004",
						name:"button004",
						title:"关闭",
						displayId:"button004_div",
						position:"absolute",
						top:0,left:0,
						width:"100%",
						height:"100%",
						showDisabledIcon:false,
						showDownIcon:false,
						showRollOverIcon:false
					});
					Mbutton004.click=function(){
						Matrix.showMask();
						Matrix.closeWindow();
						Matrix.hideMask();	
					};
			</script>
		</div>
	</td>
</tr>
</table>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>


</div>

</body>
</html>