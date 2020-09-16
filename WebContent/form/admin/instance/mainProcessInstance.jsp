<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程实例</title>
	<!-- instance/mainprocessInstance -->
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">
	function forwardPage(node,url){
		var src = handTreeNodeHref(node,url);
		src = "<%=request.getContextPath()%>"+"/"+src;
		Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
	}
	
	
	
//点击节点时链接到对应的页面  
 function forwardPageByNodeType(node){
	var nodeType =parseInt(node.type);
	
 	if(nodeType==17){
 		
 		forwardPage(node,"instance/processInstance_loadTabsPage.action?processDID="+node.id);
 	}else{
 		return false;
 	}
	
    
}


	

</script>

</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
var MForm0=isc.MatrixForm.create({
			ID:"MForm0",name:"MForm0",position:"absolute",
			action:"<%=request.getContextPath()%>/common/common_getCommonTree.action",
			fields:[{
					name:'Form0_hidden_text',
					width:0,height:0,
					displayId:'Form0_hidden_text_div'
					}]
			});
</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/common/common_getCommonTree.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="componentType" id="componentType" value="17" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
  
 
  
  
  
  
<div id="horizontalContainer0_div" class="matrixInline"
	style="width: 100%; height: 100%;; overflow: hidden;">
	<script>
	isc.HLayout.create({
		ID:"MhorizontalContainer0",
		displayId:"horizontalContainer0_div",
			position: "relative",
			height: "100%",width: "100%",
			align: "center",overflow: "auto",
			defaultLayoutAlign: "center",
			members: [
				isc.MatrixHTMLFlow.create({
					 ID:"MhorizontalContainer0Panel0",
					 width: '16%',height: "100%",
					 overflow: "hidden",
					 showResizeBar: "true",
					 contents:"<div id='horizontalContainer0Panel0_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
			}),
					 
			isc.HTMLPane.create({
				ID:"MhorizontalContainer0Panel1",
				height: "100%",overflow: "hidden",
				showEdges:false,contentsType:"page",
				contentsURL:""
				})
			] 
	});
</script></div>
<div id="horizontalContainer0Panel0_div2"
	style="width: 100%; height: 100%; overflow: hidden;"
	class="matrixInline">
	 	<table style="width:100%;height:100%;margin:0px;">
	  
	    	<tr>
				<td height="20px" style="margin:0px;">当前位置>>实例监控</td>
		    </tr>
			<tr>
				<td >
					<div id="Tree0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;"><script> 
isc.MatrixTree.create({	
	ID:"MTree0_DS",
    modelType:"children",
		ownerType:"tree",
		
		formId:"Form0",
		autoOpenRoot:false,
		ownerId:"Tree0",
		childrenProperty:"children",
		nameProperty:"text",
		root:{
			id:"RootTreeNode",
			entityId:"RootTreeNode",
			text:"RootTreeNode",
			type:0
			}
});
isc.Page.setEvent('load','MTree0_DS.openFolder(MTree0_DS.root)',isc.Page.FIRE_ONCE);

isc.MatrixTreeGrid.create({
		ID:"MTree0",
		name:"Tree0",
		height:"100%",
		displayId:"Tree0_div",
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
		data:MTree0_DS,
		cellHeight:25,
		autoFetchData:true,
		showOpenIcons:false,
		closedIconSuffix:'',
		showPartialSelection:false,
		cascadeSelection:false,
		border:0,
		onMoveUpAction:"true",
		onMoveDownAction:"true", 
		
		nodeClick:function(viewer, node, recordNum){
				forwardPageByNodeType(node);
		},
		getIcon:function(node){//根据节点类型返回不同类型的icon
		 return getNodeIconByType(node);
		}
	});
	
	
	if(MhorizontalContainer0Panel0)
			if(!MhorizontalContainer0Panel0.customMembers)MhorizontalContainer0Panel0.customMembers=[];
			
	MhorizontalContainer0Panel0.customMembers.add(MTree0);
	isc.Page.setEvent(isc.EH.LOAD,"MTree0.resizeTo('100%','100%');");
	isc.Page.setEvent(isc.EH.RESIZE,"MTree0.resizeTo(0,0);MTree0.resizeTo('100%','100%');",null);
</script></div>
				
				</td>
			</tr>
		
		
	</table>
 </div>
<script>
					
					isc.Window.create({
							ID:"MProcInsTarget",
							id:"ProcInsTarget",
							name:"ProcInsTarget",
							autoCenter: true,
							position:"absolute",
							height: "500px",
							width: "900px",
							title: "test",
							canDragReposition: false,
							showMinimizeButton:false,
							showMaximizeButton:false,
							showCloseButton:true,
							showModalMask: false,
							modalMaskOpacity:0,
							isModal:true,
							autoDraw: false,
							headerControls:[
								"headerIcon","headerLabel",
								"closeButton"
							]
							
							//initSrc:
							//src:
					});
					MProcInsTarget.hide();

</script>

<script>
document.getElementById('horizontalContainer0Panel0_div').appendChild(document.getElementById('horizontalContainer0Panel0_div2'));
</script></form>

<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script></div>

</body>
</html>