<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		String userMode = CommonUtil.getFormUser();

	%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>selectProcess</title>
<!-- 需要给该通用树传递参数commonType[form 14，entity16] -->

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>

<script type="text/javascript">
     
     //单击组件自定义函数
     function nodeClickCustomFun(node){
     	if(node.isFolder==false){//仅节点不可展开时可用
		  
		   document.getElementById("nodeData").value = isc.JSON.encode(node);
		}else{
		   document.getElementById("nodeData").value = null;
		}
     }
     
     function submitByButton(){
	    var nodeDataValue = document.getElementById("nodeData").value;
	    var treeNode = MTree0.getSelection();
	    var formId  = treeNode[0].id;//表单编码
	    var url = webContextPath+"/query/form_hasPublishForm.action";
	    Matrix.sendRequest(url,{'formId':formId},function(data){
	    	if(data!=null && data.data!=''){
	    		var result = isc.JSON.decode(data.data);
	    		if(result.result){
				    if(nodeDataValue!=null&&nodeDataValue.length>0){
				    	Matrix.closeWindow(nodeDataValue);
				    	
				    }else{
				      isc.say("请选择表单!",{width:150,height:70});
				    }
	    		}else{
	    			Matrix.warn("该表单没有发布，请联系管理员发布表单！");
	    			return false;
	    		}
	    	}
	    },null);
     
     }
     //双击节点选择变量
     function nodeDoubleClickCustomFun(record){
     	if(record.isFolder == false){
     		var node = isc.JSON.encode(record);
     		var formId  = record.id;//表单编码
		    var url = webContextPath+"/query/form_hasPublishForm.action";
		    Matrix.sendRequest(url,{'formId':formId},function(data){
		    	if(data!=null && data.data!=''){
		    		var result = isc.JSON.decode(data.data);
		    		if(result.result){
					    if(node!=null&&node.length>0){
					    	Matrix.closeWindow(node);
					    }else{
					      isc.say("请选择表单!",{width:150,height:70});
					    }
		    		}else{
		    			Matrix.warn("该表单没有发布，请联系管理员发布表单！");
		    			return false;
		    		}
		    	}
		    },null);
     	}else{
     	    isc.say('请选择表单!',{ width:150,height:70});
     	}
     	
     }
</script>
</head>
<body >
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%;overflow:auto;">
<script> 
	var MForm0=isc.MatrixForm.create({
				ID:"MForm0",
				name:"MForm0",
				position:"absolute",
				action:"<%=request.getContextPath()%>/common/processTmpl_getFormForTree.action",
				fields:[{
					name:'Form0_hidden_text',
					width:0,height:0,
					displayId:'Form0_hidden_text_div'}]
		});
		</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
		action="<%=request.getContextPath()%>/common/processTmpl_getFormForTree.action" 
		style="margin:0px;height:100%;overflow: hidden;" 
		enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<!-- 传递要查询的组件类型 -->
	<!-- <input type="hidden" name="componentType" id="componentType" value="17"/> -->
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}">
	<input type="hidden" name="nodeData" id="nodeData">
	<input type="hidden" name="rootMid" id="rootMid" value="${param.rootMid }"/>
	<input type="hidden" name="rootEntityId" id="rootEntityId" value="${param.rootEntityId }"/>
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>


<table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px" cellspacing="0px"
								 style="width:100%;height:100%">
								 
	 <tr id="j_id2" jsId="j_id2">
		  	<td id="j_id3" jsId="j_id3" style="height:100%;" >
						<!-- 此处添加页面代码 -->
                 <div id="Tree0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
		<script> 
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
					folderIcon:Matrix.getActionIcon("add"),
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
					
						return getCustTreeIcon(node);
					  
					}
				});
				
				isc.Page.setEvent(isc.EH.LOAD,"MTree0.resizeTo('100%','100%');");
				isc.Page.setEvent(isc.EH.RESIZE,"MTree0.resizeTo(0,0);MTree0.resizeTo('100%','100%');",null);
</script>
						

		   	</td>
		</tr>
<tr id="j_id12" jsId="j_id12">
		<td id="j_id13" jsId="j_id13" class="maintain_form_command">
			
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 35px;">
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
			style="position: relative;; width: 100px;; height: 35px;">
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
	
	
	function  getCustTreeIcon(node){
		if("<%=userMode%>"=="zr"){
			if(node.type==0){ //根节点，表单模型
			    return Matrix.getTreeNodeIcon("root");
			}else if(node.isFolder ==true){//流程目录
			  	return Matrix.getTreeNodeIcon("flow");
			}else if(node.isFolder ==false){//流程
			  	return Matrix.getTreeNodeIcon("flow_item");
			}
		
		}else{
		
		    return getNodeIconByType(node);
		
		}

	}
</script></div>

</body>
</html>