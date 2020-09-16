<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<title>选择流水号</title>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
	function confirmSelect(){
		var select = MDataGrid001.getSelection();
		if(select!=null && select.length==1){
			var data = {};
			data.id = select[0].id;
			Matrix.closeWindow(data);
		}else{
			Matrix.warn('请选择一条数据!');
		}
	}
	function doubleClickSelect(record){
		if(record!=null){
			var data = {};
			data.id = record.id;
			Matrix.closeWindow(data);
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

<div type="hidden" id="form0_hidden_text_div"
	name="form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>

<input type="hidden" name="javax.matrix.faces.ViewState"
	id="javax.matrix.faces.ViewState" value="" />
<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>
<div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;" >
				
<table  class="query_form_content"
	style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
	
	<tr>
		<td colspan="2" class="tdLayout"
			style="border-style: none; width: 100%;height:94%; margin: 0px; padding: 0px;">
		<div id="DataGrid001_div" class="matrixComponentDiv"
			style="width: 100%;">
			<script> 
			var MDataGrid001_DS=<%=request.getAttribute("data")%>;
			isc.MatrixListGrid.create({
			ID:"MDataGrid001",name:"DataGrid001",displayId:"DataGrid001_div",position:"relative",width:"100%",height:"100%",
			<%-- 双击事件 --%>
			recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                        doubleClickSelect(record);
            },
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
			{title:"编码",matrixCellId:"id",name:"id",canEdit:false,editorType:'Text',type:'text'},
			{title:"名称",matrixCellId:"name",name:"name",canEdit:false,editorType:'Text',type:'text'},
			{title:"位数",matrixCellId:"length",name:"length",canEdit:false,editorType:'Text',type:'hidden'},
			//{title:"后缀",matrixCellId:"postfix",name:"postfix",canEdit:false,editorType:'Text',type:'hidden'},
			//{title:"前缀",matrixCellId:"prefix",name:"prefix",canEdit:false,editorType:'Text',type:'hidden'},
			//{title:"步长",matrixCellId:"step",name:"step",canEdit:false,editorType:'Text',type:'hidden'},
			{title:"状态",matrixCellId:"status",name:"status",canEdit:false,editorType:'Text',type:'hidden',valueMap:{'1':'启用','0':'禁用'}}
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
			canCustomFilter:false,
			exportCells:[
				{id:'id',title:'编码'},
				{id:'name',title:'名称'},
				{id:'length',title:'位数'},
				{id:'postfix',title:'后缀'},
				{id:'prefix',title:'前缀'},
				{id:'step',title:'步长'},
				{id:'status',title:'状态'}
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
			</div>
					<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
					</td>
	</tr>
	<tr>
		<td class="cmdLayout" colspan="2" style="z-index:999999;">
		<div id="button003_div" class="matrixInline"
			style="position: relative;; width: 100px;; height: 32px;">
			<script>
			isc.Button.create({
			ID:"Mbutton003",
			name:"button003",
			title:"保存",
			displayId:"button003_div",
			position:"absolute",
			top:0,left:0,
			width:"100%",height:"100%",
			icon:"<%=request.getContextPath()%>/resource/images/submit.png",
			showDisabledIcon:false,
			showDownIcon:false,
			showRollOverIcon:false
			});
			Mbutton003.click=function(){
				Matrix.showMask();
				confirmSelect();
				Matrix.hideMask();
           
				
			};
			</script></div>
		<div id="button004_div" class="matrixInline"
			style="position: relative;; width: 100px;; height: 32px;">
			<script>
				isc.Button.create({
						ID:"Mbutton004",
						name:"button004",
						title:"取消",
						displayId:"button004_div",
						position:"absolute",
						top:0,left:0,width:"100%",
						height:"100%",icon:"<%=request.getContextPath()%>/resource/images/return.png",
						showDisabledIcon:false,
						showDownIcon:false,
						showRollOverIcon:false
						});
					Mbutton004.click=function(){
						Matrix.showMask();
						Matrix.closeWindow();
						Matrix.hideMask();
					}
					
						</script></div>
		</td>
	</tr>
</table>
</div>

</form>
</div>

<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
</body>
</html>
