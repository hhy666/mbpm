<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>选择组织机构下的人员</title>
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
		<style type="">
		
		</style>
		<script type="text/javascript">
		function comfirmSelect(){
			var select = MTree001.getSelection();
			var selectType = Matrix.getFormItemValue('selectType');
			if(selectType=='1'){
/*				if(select!=null&&select.length==1&&select[0].type=='Dep'){
					Matrix.closeWindow(select[0]);
				}else{
					Matrix.warn("请选择部门");
				}
*/				if(select!=null&&select.length==1){
						Matrix.closeWindow(select[0]);
				}else{
					Matrix.warn("请选择部门");
				}
			}else {
				if(select!=null&&select.length==1&&!select[0].isFolder){
					Matrix.closeWindow(select[0]);
				}else{
					Matrix.warn("请选择人员");
				}
			}
			
		}
		
		//返回目录的图片Icon
	/*
		function getCatalogIconByType(node){
			if(node!=null && node.type!='undefined' && node.type!='null'){
				var type = node.type;
				debugger;
				switch(type){
					case 0:
						return webContextPath+"/resource/images/matrix/org.png";
					case 1:
						return webContextPath+"/resource/images/matrix/org.png";
					case 2:
						return webContextPath+"/resource/images/matrix/dept.png";
					case 3:
						return webContextPath+"/resource/images/matrix/user.png";
					default:
						return webContextPath+"/resource/images/matrix/org.png";
				}	
			}	
		}
		*/
		function getCatalogIconByType(node){
	     	if(node.type=="0" || node.type=="Org" || node.type=="OrgAdmin"){
	   			return webContextPath+'/images/folder_Org.png';
	     	}else if(node.type=="Dep"){
	   			return webContextPath+'/images/folder_Dep.gif';
	     	}else if(node.type=="Admin" || node.type=="User"){
	     		return webContextPath+'/images/user.gif';
	     	}else if(node.type=="RoleCatalog"){
	   			return webContextPath+'/images/folder.gif';
	     	}else if(node.type=="Role"){
	   			return webContextPath+'/images/role.gif';
	     	}
	     }
		</script>
</head>
<body>
<jsp:include page="/foundation/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var Mform0=isc.MatrixForm.create({
 				ID:"Mform0",
 				name:"Mform0",
 				position:"absolute",
 				action:"<%=request.getContextPath()%>/processVersion_getdepsInDepOrOrg.action",
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				
  });
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>/processVersion_getdepsInDepOrOrg.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input type="hidden" name="selectType" id="selectType" value="${param.selectType }"/>
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
	<tr id="tr001">
	<td id="td001" class="tdLayout" style="width:100%;height:94%;">
		<div id="Tree001_div" class="matrixComponentDiv">
	<script> isc.MatrixTree.create({	
								ID:"MTree001_DS",
						   		modelType:"children",
								ownerType:"tree",
								formId:"form0",
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
						},
						doubleClick:function(viewer, node, recordNum){
							comfirmSelect();
						},
						getIcon:function(node){//根据节点类型返回不同类型的icon
						  return getCatalogIconByType(node);
						}
						
					});
					
					
					
					isc.Page.setEvent(isc.EH.LOAD,"MTree001.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MTree001.resizeTo(0,0);MTree001.resizeTo('100%','100%');",null);
				</script>
			</div>
		</td>
	</tr>
	<tr id="tr002">
	<td id="td002" class="cmdLayout" style="width:100%;height:32px;text-align:center;background-color:#F8F8F8;">
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
</table>
</form>
<script>
	Mform0.initComplete=true;Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);
</script>


</div>

</body>
</html>