<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>单选部门</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<script type="text/javascript">
		//双击选择
		function doubleClick2SelectDept(node){
			var select = MTree001.getSelection();
			if(select!=null && select.length>0){
				var record = {};
				record.sequenceId = select[0].entityId;
				record.depName = select[0].text;
				record.type = select[0].type;
				record.depId = select[0].sid;
				record.clientId = document.getElementById('clientId').value;
				record.id = document.getElementById('id2').value;
				Matrix.closeWindow(record);
			}else{
				Matrix.warn("您选择的数据不存在!");
			}
		}
		//点击确认
		function saveUser(){
			var select = MTree001.getSelection();
			if(select!=null && select.length>0){
				var record = {};
				record.sequenceId = select[0].entityId;
				record.depName = select[0].text;
				record.type = select[0].type;
				record.depId = select[0].sid;
				record.clientId = document.getElementById('clientId').value;
				record.id = document.getElementById('id2').value;
				Matrix.closeWindow(record);
			}else{
				Matrix.warn("请先选择部门!");
			}
		}
		/*
		//---------------键盘监听事件-----开始-----------------
		isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
        	var _key = isc.Event.getKey();
        	if(_key=="Enter" && MQueryField002==MQueryField002.form.getFocusItem()){
         	   MtoolBarItem002.click();
       		}
    	});
		//---------------键盘监听事件-----结束-----------------
		*/
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
 				action:"<%=request.getContextPath()%>/select/dept_loadOrgTreeNodeByCondition.action",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="get"
	action="<%=request.getContextPath()%>/select/dept_loadOrgTreeNodeByCondition.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden"/>
	<input type="hidden"  name="clientId" id="clientId" value="${param.clientId}"/>
	<input type="hidden" name="id2" id="id2" value="${param.id}"/>
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid }"/> 
	<input type="hidden" id="X-Requested-With" name="X-Requested-With" value="XMLHttpRequest"/>
	<!-- dataGridId必须有 -->
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid004"/>
	<!-- 子页面的隐藏字段 -->
	
	
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
	<tr>
		<td id="td001" class="tdLayout" style="width:100%;height:94%;">
	
	<div id="Tree001_div" class="matrixComponentDiv">
	<script> isc.MatrixTree.create({	
								ID:"MTree001_DS",
						   		modelType:"children",
								ownerType:"tree",
								formId:"Form0",
								autoOpenRoot:true,
								ownerId:"Tree001",
								childrenProperty:"children",
								nameProperty:"text",
								root:{
									id:"RootTreeNode",
									entityId:"RootTreeNode",
									text:"RootTreeNode",
									type:0
								}
						});
		
		isc.MatrixTreeGrid.create({
						ID:"MTree001",
						name:"MTree001",
						height:"100%",
						width:"100%",
						displayId:"Tree001_div",
						position:"relative",
						showHeader:false,
						showHover:false,
						showCellContextMenus:true,
						cellHeight:25,
						leaveScrollbarGap:false,
						canAutoFitFields:true,
						wrapCells:false,
						fixedRecordHeights:true,
						selectionType:"single",
						selectionAppearance:"rowStyle",
						folderIcon:Matrix.getActionIcon("node"),
						data:MTree001_DS,
						autoFetchData:true,
						showOpenIcons:false,
						closedIconSuffix:'',
						showPartialSelection:false,
						cascadeSelection:false,
						border:0,
						onMoveUpAction:"true",
						onMoveDownAction:"true", 
						nodeContextClick:function(viewer, node, recordNum){
						               assignNodeMenu(viewer, node, recordNum);
						 
						},
						nodeClick:function(viewer, node, recordNum){
									//getSelection(node);
								//refreshDataGrid(node);
								//forwardPageByNodeType(node);
						},
						doubleClick:function(viewer, node, recordNum){
								doubleClick2SelectDept(node);//双击选择部门
								//refreshDataGrid(node);
								//forwardPageByNodeType(node);
						},
						getIcon:function(node){//根据节点类型返回不同类型的icon
						  return getNodeIconByType(node);
						}
						
					});
					
					
					
					isc.Page.setEvent(isc.EH.LOAD,"MTree001.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MTree001.resizeTo(0,0);MTree001.resizeTo('100%','100%');",null);</script></div></td>
	
	<tr>
	<td id="td004" class="cmdLayout" style="width:100%;height:30px;text-align:center;" colspan="2">
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