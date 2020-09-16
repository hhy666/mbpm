<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择规则</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />


		<script type="text/javascript">
			function comfirmSelect(){
				var select = MDataGrid001.getSelection();
				if(select!=null&&select.length==1){
					Matrix.closeWindow(select[0]);//select[0].name;select[0].desc
				}else{s
					Matrix.closeWindow();
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
 				action:"<%=request.getContextPath()%>/mobile/flowEdit_dealHumanActivity.action",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/mobile/flowEdit_dealHumanActivity.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="form0" value="form0" /> <input name="version" id="version"
	type="hidden" />
<table id="table001" class="tableLayout"
	style="width: 100%; height: 100%">
	<tr id="tr003">
		<td id="td003" class="tdLayout" colspan="2"
			style="width: 100%; height: 85%">
		<table class="query_form_content"
			style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
			<tr>
				<td colspan="2"
					style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
				<div id="DataGrid001_div" class="matrixComponentDiv"
					style="width: 100%; height: 100%;">
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
											{title:"名称",matrixCellId:"name",name:"name",canEdit:false,editorType:'Text',type:'text'},
											{title:"描述",matrixCellId:"desc",name:"desc",canEdit:false,editorType:'Text',type:'text'}
										],
										autoSaveEdits:false,
										isMLoaded:false,
										autoDraw:false,
										autoFetchData:true,
										selectionType:"single",
										selectionAppearance:"rowStyle",
										alternateRecordStyles:true,
										showRollOver:true,
										canSort:true,
										autoFitFieldWidths:false,
										startLineNumber:1,
										editEvent:"doubleClick",
										canCustomFilter:true,
										exportCells:[
											{id:'name',title:'名称'},
											{id:'desc',title:'描述'}
										],
										showRecordComponents:true,
										showRecordComponentsByCell:true
										});
										isc.MatrixDataSource.create({ID:'MDataGrid001_custom_filter_ds',
										fields:[
											{title:"名称",name:"name",type:'text',editorType:'Text'},
											{title:"描述",name:"desc",type:'text',editorType:'Text'}
											]
										});
										isc.FilterBuilder.create({ID:'MDataGrid001_custom_filter',
												dataSource:MDataGrid001_custom_filter_ds,
												overflow:'auto',topOperatorAppearance:"none"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid001.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid001_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid001_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid001_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid001_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid001_custom_filter.resizeTo('100%','100%');MDataGrid001_custom_filter_window.hide();isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}</script></div>
				</td>
			</tr>
			<tr id="tr007">
	<td id="td061" class="tdLayout"  style="width:100%;height:24px;border:0px;text-align:center;background-color:#F8F8F8;">
		<div id="button103_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
					<script>
						isc.Button.create({
							ID:"Mbutton103",
							name:"button103",
							title:"确认",
							displayId:"button103_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false
						});
						Mbutton103.click=function(){
							Matrix.showMask();
							comfirmSelect();
							Matrix.hideMask();
							};
						</script>
					</div>
					<div id="button102_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;margin:left:10px;">
						<script>
							isc.Button.create({
								ID:"Mbutton102",
								name:"button102",
								title:"关闭",
								displayId:"button102_div",
								position:"absolute",
								top:0,left:0,
								width:"100%",
								height:"100%",
								icon:"[skin]/images/matrix/actions/delete.png",
								showDisabledIcon:false,
								showDownIcon:false,
								showRollOverIcon:false
							});
							Mbutton102.click=function(){
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
	Mform0.initComplete=true;Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);
</script></div>

</body>
</html>