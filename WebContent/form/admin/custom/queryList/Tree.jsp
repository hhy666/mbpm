<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询展示树</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>

<script type="text/javascript">
	var data = [];
	function forwardPage(node,url){
		var src = handTreeNodeHref(node,url);
		src = "<%=request.getContextPath()%>"+"/"+src;
		Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
	}
	
	
//单击节点操作
function forwardPageByNodeType(viewer, node, recordNum){
	var nodeType =parseInt(node.type);
    switch(nodeType){
    	case 0://根
    	    modifyCodeNode(node);
    		break;
    	case 1://目录
    	    modifyCodeNode(node);
    		break;
    	case 2://基本类型 - 链接到列表页面
    		data = [];
    		 //forwardPage(node,"query/query_loadUpdateCodePage.action?entityId="+node.entityId+"&parentNodeId=parentNode.id&oType=update&type=2");
    		 break;
    		 }
	}
	
	//添加节点
	function addCodeNode(target, type){	
		data = [];
		forwardPage(target,"query/query_loadAddCodePage.action?parentUUID="+target.entityId+"&parentNodeId=treeNode.id&oType=add&type="+type);
	}
	
	//修改代码[type 0 1 2 3]
	function modifyCodeNode(target){	
	    var type = target.type;
	    var pid = null;
	    if(type==0){//根节点 更新后刷新自身
			forwardPage(target,"query/query_loadUpdateCodePage.action?entityId="+target.entityId+"&parentNodeId=treeNode.id&oType=update&type="+type);
	    }else if(type==1){//子目录
	    	forwardPage(target,"query/query_loadUpdateCodePage.action?entityId="+target.entityId+"&parentNodeId=parentNode.id&oType=update&type="+type);
	    }else if(type==2){//基本类型
	    	forwardPage(target,"query/query_loadUpdateCodePage.action?entityId="+target.entityId+"&parentNodeId=parentNode.id&oType=update&type=2");
	    }
	    
	}
	

	//删除代码节点[type 1 2 3]
	function deleteCodeNode(target){
		forwardPage(target,"query/query_deleteCode.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type);
	}

				
     //指定右键菜单
     function assignNodeMenu(viewer, node, recordNum){
     	 //根据节点类型设置右键菜单
			var nodeType = node.type;
			if(nodeType==0){ //根目录
				var nodeMenu = MTreeMenu_Root;
				if(nodeMenu){
					nodeMenu.target=node;//将右键菜单指向该节点
					nodeMenu.showContextMenu();//弹出显示该菜单
				}
			}else if(nodeType==1){//子目录
				var nodeMenu = MTreeMenu_SubCatalog;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==2){//基本类型
				var nodeMenu = MTreeMenu_Module;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
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
			action:"<%=request.getContextPath()%>/query/test_loadDataGridData.action",
			fields:[{
					name:'Form0_hidden_text',
					width:0,height:0,
					displayId:'Form0_hidden_text_div'
					}]
			});
</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/query/test_loadDataGridData.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>

<div id="horizontalContainer0_div" class="matrixInline"
	style="width: 100%; height: 100%; overflow: hidden;">
	<script>
	isc.HLayout.create({
		ID:"MhorizontalContainer0",
		displayId:"horizontalContainer0_div",
			position: "relative",
			height: "100%",
			width: "100%",
			align: "center",
			overflow: "auto",
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
<div id="Tree0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%; position: relative;"><script> 
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
		displayId:"Tree0_div",
		position:"relative",
		showHeader:false,
		showHover:false,
		height:"100%",
		width:"100%",
		showCellContextMenus:true,
		leaveScrollbarGap:false,
		canAutoFitFields:true,
		wrapCells:false,
		fixedRecordHeights:true,
		selectionType:"single",
		selectionAppearance:"rowStyle",
		folderIcon:Matrix.getActionIcon("node"),//默认节点图标
		data:MTree0_DS,
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
				forwardPageByNodeType(viewer, node, recordNum);
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
 </div>

<script>
document.getElementById('horizontalContainer0Panel0_div').appendChild(document.getElementById('horizontalContainer0Panel0_div2'));
</script>
</form>

<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
//节点图标
function getNodeIconByType(node){
     var type = node.type;
	 if(type==0){ 
		      return Matrix.getTreeNodeIcon("subcatalog");
		  }else if(type==1){
		  	  return Matrix.getTreeNodeIcon("subcatalog");
		  }else if(type==2){
		  	return Matrix.getTreeNodeIcon("node");
		  }else if(type==3){
		  	return Matrix.getTreeNodeIcon("node");
		  }


}
</script></div>

<script>
	
	isc.Window.create({
			ID:"MCodeMain",
			id:"CodeMain",
			name:"CodeMain",
			autoCenter: true,
			position:"absolute",
			height: "500px",
			width: "900px",
			title: "test",
			canDragReposition: true,
			showMinimizeButton:false,
			showMaximizeButton:true,
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
	MCodeMain.hide();
	</script>

</body>
</html>