<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>selectRole</title>
<!-- 需要给该通用树传递参数commonType[form 14，entity16] -->

<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>

<script type="text/javascript">
     
     //单击组件自定义函数
     function nodeClickCustomFun(node){
     	if(node.type==0){//仅根节点不可选
		  
		   document.getElementById("nodeData").value = null;
		}else{
		   document.getElementById("nodeData").value = isc.JSON.encode(node);
		}
     }
     
     function submitByButton(){
     	//1.首先判断是否选中节点
	    var nodeDataValue = document.getElementById("nodeData").value;
	    if(nodeDataValue!=null&&nodeDataValue.length>0){
	    	Matrix.closeWindow(nodeDataValue);
	    	
	    }else{
	      isc.say("请选择部门!",{width:150,height:70});
	    }
     
     }
     //双击节点选择变量 自定义函数
     function nodeDoubleClickCustomFun(record){
     	if(record.type == 0){//不能选根节点
     	    isc.say('请选择部门!',{ width:150,height:70});
     	}else{
     		Matrix.closeWindow(isc.JSON.encode(record));//encode为了和单击时数据保持一致
     	}
     	
     }
</script>
</head>
<body >
<jsp:include page="/foundation/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%;overflow:auto;">
<script> 
	var MForm0=isc.MatrixForm.create({
				ID:"MForm0",
				name:"MForm0",
				position:"absolute",
				action:"<%=request.getContextPath()%>/common/depSelected_getDepsForTree.action",
				fields:[{
					name:'Form0_hidden_text',
					width:0,height:0,
					displayId:'Form0_hidden_text_div'}]
		});
		</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
		action="<%=request.getContextPath()%>/common/depSelected_getDepsForTree.action" 
		style="margin:0px;height:100%;" 
		enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<!-- 传递要查询的组件类型 -->
	<!-- <input type="hidden" name="componentType" id="componentType" value="${param.componentType}"/> -->
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}">
	<input type="hidden" name="nodeData" id="nodeData">
	
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>
<table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px" cellspacing="0px"
								 style="width:100%;height:100%">
	 <tr id="j_id2" jsId="j_id2">
		  	<td id="j_id3" jsId="j_id3" >
						<!-- 此处添加页面代码 -->
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
			type:0//根节点类型默认为0
			}
});
isc.Page.setEvent('load','MTree0_DS.openFolder(MTree0_DS.root)',isc.Page.FIRE_ONCE);

isc.MatrixTreeGrid.create({
		ID:"MTree0",
		name:"Tree0",
		displayId:"Tree0_div",
		position:"relative",
		width:"100%",
		height:"100%",
		cellHeight:25,
		showHover:false,
		showHeader:false,
		showCellContextMenus:true,
		leaveScrollbarGap:false,
		canAutoFitFields:true,
		wrapCells:false,
		fixedRecordHeights:true,
		selectionType:"single",
		selectionAppearance:"rowStyle",
		folderIcon:Matrix.getActionIcon("node"),
		data:MTree0_DS,
		autoFetchData:true,
		showOpenIcons:false,
		closedIconSuffix:'',
		showPartialSelection:false,
		cascadeSelection:false,
		border:0,
		onMoveUpAction:"true",
		onMoveDownAction:"true",
		nodeClick:function(viewer, node, recordNum){
		    nodeClickCustomFun(node);
		       
		}, 
		cellDoubleClick:function(record, rowNum, colNum){//双击事件
			nodeDoubleClickCustomFun(record);
			
		},
		getIcon:function(node){//根据节点类型[type dataType]返回不同类型的icon
		  if(node.type==0){ //根节点，表单模型
		     // return Matrix.getTreeNodeIcon("root");
		      return isc.Page.getImgURL("http://localhost:9090/demo/resource/isomorphic/skins/Enterprise/images/matrix/tree/folder.png");
		  }else if(node.isFolder ==true){//角色目录
		  	 // return Matrix.getTreeNodeIcon("root");
		  	  return isc.Page.getImgURL("http://localhost:9090/demo/resource/isomorphic/skins/Enterprise/images/matrix/tree/folder.png");
		  }else if(node.isFolder ==false){//角色
		  	//return Matrix.getTreeNodeIcon("note");
		  	return isc.Page.getImgURL("http://http://localhost:9090/demo/resource/images/matrix/dept.png");
		  }
		}
	});
	
	isc.Page.setEvent(isc.EH.LOAD,"MTree0.resizeTo('100%','100%');");
	isc.Page.setEvent(isc.EH.RESIZE,"MTree0.resizeTo(0,0);MTree0.resizeTo('100%','100%');",null);
</script>
						

		   	</td>
		</tr>
<tr id="j_id12" jsId="j_id12">
		<td id="j_id13" jsId="j_id13" class="maintain_form_command" >
			
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormSubmitButton",
					name:"dataFormSubmitButton",
					title:"确认",
					displayId:"dataFormSubmitButton_div",
					position:"absolute",
					top:0,left:0,width:"100%",height:"100%",
			icon:Matrix.getActionIcon("save"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					submitByButton();
					
		            Matrix.hideMask();
            };</script></div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,left:0,width:"100%",height:"100%",
					icon:Matrix.getActionIcon("exit"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
					});
					MdataFormCancelButton.click=function(){
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
</script></div>

</body>
</html>