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
      		function saveSelections(){
      			var portalId = Matrix.getFormItemValue('uuid');
      			var selects = MDataGrid001.getSelection();
      			var data = selects;
      			if(data.length>0&&data!=null){
      				for(var i =0;i<data.length;i++){
      					delete data[MDataGrid001.selection.selectionProperty];
      				}
      				data = isc.JSON.decode(isc.JSON.encode(data));
      				Matrix.closeWindow(data);
      				
	    		}else{
	      			isc.say("请选择部件!",{width:150,height:70});
	   		 	}	
      		}
</script>
</head>
<body >
	
<div id='loading' name='loading' class='loading'>
<script>Matrix.showLoading();</script></div>

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
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/portal/partsAction_findAllParts.action"
	style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="form0" value="form0" /> 
	<input type="hidden"
	id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0"
	value="" />
	<input type="hidden" name="uuid" id="uuid" value="${param.uuid }"/>
<div type="hidden" id="form0_hidden_text_div"
	name="form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>

<input type="hidden" name="javax.matrix.faces.ViewState"
	id="javax.matrix.faces.ViewState" value="" />
<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>

<table  class="query_form_content"
	style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
	<tr>
		
		<td class="query_form_toolbar" colspan="2"><script> 
				var QueryField001=isc.TextItem.create({
					ID:"MQueryField001",
					name:"QueryField001",
					editorType:"TextItem",
					displayId:"QueryField001_div",
					position:"relative"});
					Mform0.addField(QueryField001);
					</script>
					<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem086a485a05344794be9751286cbbe694",
						icon:"<%=request.getContextPath()%>/resource/images/query.png",
						title: "查询",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem086a485a05344794be9751286cbbe694.click=function(){
						Matrix.showMask();
						Matrix.refreshDataGridData('DataGrid001');
						Matrix.hideMask();}</script>
						
					
					<script>
                        isc.ToolStripButton.create({
						ID:"MtoolBarItem",
						icon:"<%=request.getContextPath()%>/resource/images/submit.png",
						title: "确定",
						showDisabledIcon:false,
						showDownIcon:false 
					});
                          MtoolBarItem.click = function() {
                               Matrix.showMask();
                               saveSelections();
                               Matrix.hideMask();
                      };
                  </script>
		<div id="QueryForm22ebd2f6234d499cb105c9482a7a6c41_tb_div"
			style="width: 100%; height: 30px;; overflow: hidden;position:absolute;top:0px;">
			<script>
			isc.ToolStrip.create({
				ID:"MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb",
				displayId:"QueryForm22ebd2f6234d499cb105c9482a7a6c41_tb_div",
				width: "100%",height: "100%",position: "relative",
				members: [ 
				isc.MatrixHTMLFlow.create({
					ID:"MQueryField001_Label",
					contents:"<div  id='MQueryField001_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >标题</div>"}),
					isc.MatrixHTMLFlow.create({ID:"QueryField001",
					contents:"<div id='QueryField001_div' eventProxy='Mform0' class='toolBarItemInputText' ></div>"}),
					MtoolBarItem086a485a05344794be9751286cbbe694,
					
					] });isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb.resizeTo(0,0);MQueryForm22ebd2f6234d499cb105c9482a7a6c41_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div>
		</td>
	</tr>
	<tr>
		<td colspan="2"
			style="border-style: none; width: 100%; height:77%;margin: 0px; padding: 0px;position:absolute;top:31px;bottom:31px;">
		<div id="DataGrid001_div" class="matrixComponentDiv"
			style="width: 100%; height: 100%;">
			<script> 
			var MDataGrid001_DS=<%=request.getAttribute("lists")%>;
			isc.MatrixListGrid.create({
			ID:"MDataGrid001",name:"DataGrid001",displayId:"DataGrid001_div",position:"relative",width:"100%",height:"100%",
			fields:[
			
			{title:"序号",
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
				//计算行数
				formatCellValue:function(value, record, rowNum, colNum,grid){
					if(grid.startLineNumber==null)
						return '&nbsp;';
					return grid.startLineNumber+rowNum;
				}},
			{title:"标题",matrixCellId:"title",name:"title",canEdit:false,editorType:'Text',type:'text'},
			{title:"宽度",matrixCellId:"width",name:"width",canEdit:false,editorType:'Text',type:'text'},
			{title:"高度",matrixCellId:"height",name:"height",canEdit:false,editorType:'Text',type:'text'},
			{title:"行数",matrixCellId:"rows",name:"rows",canEdit:false,editorType:'Text',type:'text'},
			{title:"列数",matrixCellId:"cols",name:"cols",canEdit:false,editorType:'Text',type:'text'}
			],
			canDragSelect: true,//支持拖选
			autoSaveEdits:false,
			isMLoaded:false,
			autoDraw:false,
			autoFetchData:true,
			selectionType:"simple",
			selectionAppearance:"checkbox",
			alternateRecordStyles:true,
			canSort:true,
			autoFitFieldWidths:false,
			startLineNumber:1,
			canCustomFilter:false,
			exportCells:[
				{id:'title',title:'标题'},
				{id:'width',title:'宽度'},
				{id:'height',title:'高度'},
				{id:'rows',title:'行数'},
				{id:'cols',title:'列数'}
				
			],
			showRecordComponents:true,
			showRecordComponentsByCell:true
			});
			isc.Page.setEvent(
			isc.EH.LOAD,
			function(){
			MDataGrid001.isMLoaded=true;
			MDataGrid001.draw();
			MDataGrid001.setData(MDataGrid001_DS);
			MDataGrid001.resizeTo('100%','100%');
			isc.Page.setEvent(
			isc.EH.RESIZE,
			function(){
			isc.Page.setEvent(
			isc.EH.RESIZE,
			"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},
			isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
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
					<input id="DataGrid001_data_entity" name="DataGrid001_data_entity"
						value="foundation.portal.Parts" type="hidden" /></td>
	</tr>
	<tr style="width: 100%;height:33px;margin:0 auto;padding:0;">
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
	
	<tr>
		<td class="maintain_form_command" colspan="2"
                        rowspan="1">
                            <div id="MtoolBarItem_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:32px;">
                                <script>
                                    isc.Button.create({
                                        ID: "MtoolBarItem",
                                        name: "mtoolBarItem",
                                        title: "确定",
                                        displayId: "MtoolBarItem_div",
                                        position: "absolute",
                                        top: 0,
                                        left: 0,
                                        width: "100%",
                                        height: "100%",
										icon:Matrix.getActionIcon("save"),
                                        showDisabledIcon: false,
                                        showDownIcon: false,
                                        showRollOverIcon: false
                                    });
									MtoolBarItem.click = function() {
										Matrix.showMask();
										saveSelections();
										Matrix.hideMask();
									};
                                </script>
                            </div>
                        </td>
	</tr>
	
</table>


</form>
</div>

<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
</body>
</html>
