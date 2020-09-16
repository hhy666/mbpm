<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>授权信息</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
			function comfirmSelect(){
				var select  = MDataGrid001.getSelection();
				if(select != null && select.length > 0){
					Matrix.closeWindow(select[0]);
				}
			}
		
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
	<input name="version" id="version" type="hidden"/>
	<input name="dataGridId" id="dataGridId" type="hidden" value="DataGrid001"/>
		<table id="table001" class="tableLayout" style="width:100%;height:100%"><tr id="tr001">
		<td id="td001" class="tdLayout" colspan="2" rowspan="1" style="width:100%;height:94%;">
		<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;"><tr><td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;"><div id="DataGrid001_div" class="matrixComponentDiv" style="width:100%;height:100%;">
		<script> var MDataGrid001_DS=<%=request.getAttribute("list")%>;
				isc.MatrixListGrid.create({
						ID:"MDataGrid001",
						name:"DataGrid001",
						displayId:"DataGrid001_div",
						position:"relative",
						width:"100%",
						height:"100%",
						showAllRecords:true,
						fields:[
						//{title:"编码",matrixCellId:"uuid",name:"uuid",canEdit:false,editorType:'InputHidden',type:'text'},
						{title:"名称",matrixCellId:"groupName",name:"groupName",canEdit:false,editorType:'Text',type:'text'}],
						autoSaveEdits:false,
						isMLoaded:false,autoDraw:false,
						cellDoubleClick:function(record, rowNum, colNum){comfirmSelect();(record, rowNum, colNum);},
						autoFetchData:true,selectionType:"single",
						selectionAppearance:"rowStyle",
						alternateRecordStyles:true,showRollOver:true,
						canSort:true,autoFitFieldWidths:false,editEvent:"doubleClick",
						canCustomFilter:true,exportCells:[{id:'uuid',title:'编码'},{id:'groupName',title:'名称'}],
						showRecordComponents:true,showRecordComponentsByCell:true});
						isc.MatrixDataSource.create({ID:'MDataGrid001_custom_filter_ds',fields:[{title:"编码",name:"uuid",type:'text',editorType:'InputHidden'},{title:"名称",name:"groupName",type:'text',editorType:'Text'}]});isc.FilterBuilder.create({ID:'MDataGrid001_custom_filter',dataSource:MDataGrid001_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid001.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid001_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid001_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid001_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid001_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid001_custom_filter.resizeTo('100%','100%');MDataGrid001_custom_filter_window.hide();isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}</script></div><input id="DataGrid001_data_entity" name="DataGrid001_data_entity" value="office.document.support.ProcessAuthorizationGroup" type="hidden" /></td>
</tr>
</table>

</td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" colspan="2" rowspan="1" style="width:100%;height:34px;text-align:center;">
	<div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
					<script>
						isc.Button.create({
							ID:"Mbutton001",
							name:"button001",
							title:"确认",
							displayId:"button001_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton001.click=function(){
							Matrix.showMask();
							comfirmSelect();
							Matrix.hideMask();
							};
						</script>
					</div>
					<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
						<script>
							isc.Button.create({
								ID:"Mbutton002",
								name:"button002",
								title:"关闭",
								displayId:"button002_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								icon:"[skin]/images/matrix/actions/delete.png",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton002.click=function(){
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