<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>selectCatalog</title>
<!-- 需要给该通用树传递参数commonType[form 14，entity16] -->


<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>

<script type="text/javascript">
     function getComponentType(){
     	document.getElementById("componentType").value= "${requestScope.componentType}";
     	
     }
     
     //双击组件节点自定义函数
     function nodeDoubleClickCustomFun(record){
     		var type = record.type;
     		var refactor = document.getElementById("refactor").value;
     		if("true"==refactor){
     			if(type==2){//模块
     				Matrix.closeWindow(isc.JSON.encode(record));
     			}else{
     				 isc.say("请选择模块!",{ width:150,height:70});
     			}
     			return;
     		}
     		
     		if(type>10){
				Matrix.closeWindow(isc.JSON.encode(record));//encode为了和单击时数据保持一致
			}else{
			  var  componentType = document.getElementById("componentType").value;
			  var  message = null;
			  if(componentType=='14'){
			  		message = "请选择表单!";
			  }else if(componentType=='15'){
			  	message = "请选择服务!";
			  }else if(componentType=='16'){
			    	message = "请选择实体!";
			  }
			
			  isc.say(message,{ width:150,height:70});
			}
     }
     //单击组件节点自定义函数
     function nodeClickCustomFun(node){
     	 var type = node.type;
     	 var refactor = document.getElementById("refactor").value;
     	 //迁移操作下选模块
     	 if(type==2&&refactor=="true"){
     	 	document.getElementById("nodeData").value = isc.JSON.encode(node);
     	 }else if(type>10||(type==2&&refactor)){//选组件
		     document.getElementById("nodeData").value = isc.JSON.encode(node);
					
		 }else{
		     document.getElementById("nodeData").value = null;
		 }
     }
     
     //通过按钮提交选中数据
     function submitBybutton(){
     		//1.首先判断是否选中节点
	    	var nodeDataValue = document.getElementById("nodeData").value;
	    	
	    	//迁移操作下 只可选模块
	    	
	    	if(nodeDataValue!=null&&nodeDataValue.length>0){
	    	
		    		Matrix.closeWindow(nodeDataValue);
	    	   
	    	}else{
	    		var refactor = document.getElementById("refactor").value;
	     		if("true"==refactor){
	     			isc.say("请选择模块!",{ width:150,height:70});
	     			 Matrix.hideMask();
	     			return ;
	     		}
	    	
	    	
	    	  var  componentType = document.getElementById("componentType").value;
			  var  message = null;
			  if(componentType=='14'){
			  		message = "请选择表单!";
			  }else if(componentType=='15'){
			  	message = "请选择服务!";
			  }else if(componentType=='16'){
			    	message = "请选择实体!";
			  }
			  
	    	  isc.say(message,{ width:150,height:70});
	    	   Matrix.hideMask();
	    	   return false;
	    	}
	    	
     }
     
</script>
</head>
<body onload="getComponentType()">
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%;overflow:auto;">
<script> 
	var MForm0=isc.MatrixForm.create({
				ID:"MForm0",
				name:"MForm0",
				position:"absolute",
				action:"<%=request.getContextPath()%>/datasource/formVar_getCurModuleEntityTree.action",
				fields:[{
					name:'Form0_hidden_text',
					width:0,height:0,
					displayId:'Form0_hidden_text_div'}]
		});
		</script>
	<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
		action="<%=request.getContextPath()%>/datasource/formVar_getCurModuleEntityTree.action" 
		style="margin:0px;height:100%;" 
		enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<!-- 传递要查询的组件类型 -->
	<input type="hidden" name="parentNodeId" id="parentNodeId" value="${param.parentNodeId}"/>
	<input type="hidden" name="componentType" id="componentType" value="${param.componentType}"/>
	<input type="hidden" name="refactor" id="refactor" value="${param.refactor}"/>
	<input type="hidden" name="entityType" id="entityType" value="${entityType}"/>
	<input type="hidden" name="processType" id="processType" value="${param.processType}">
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}">
	<input type="hidden" name="nodeData" id="nodeData">
	
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px" cellspacing="0px" style="width:100%;height:100%;table-layout:fixed;">
	 <tr id="j_id2" jsId="j_id2">
		  	<td id="j_id3" jsId="j_id3" style="height:90%;" >
				<!-- 此处添加页面代码 -->
                <div id="Tree0_div" class="matrixComponentDiv"
									style="width: 100%;height:100%; position: relative;">
	<script> 
isc.MatrixTree.create({	
	ID:"MTree0_DS",
    modelType:"children",
		ownerType:"tree",
		formId:"Form0",
		autoOpenRoot:false,
		ownerId:"Tree0",
		width:"100%",
		height:"100%",
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
		width:"100%",
		height:"100%",
		showHeader:false,
		cellHeight:25,
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
		showHover:false,
		border:0,
		onMoveUpAction:"true",
		onMoveDownAction:"true",
		nodeClick:function(viewer, node, recordNum){//单击事件
		
			 nodeClickCustomFun(node);
		      
		}, 
		cellDoubleClick:function(record, rowNum, colNum){//双击事件
			nodeDoubleClickCustomFun(record);
			
		},
		getIcon:function(node){//根据节点类型返回不同类型的icon
			return getNodeIconByType(node);
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
					submitBybutton();
					
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