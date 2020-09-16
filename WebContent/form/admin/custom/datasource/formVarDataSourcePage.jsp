<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
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
     //---------------------------------------------
     //单击组件自定义函数
     function nodeClickCustomFun(node){
    	 var nodeType = node.type;
    	
     	if(nodeType!=null&&nodeType!='0'){//点击非根节点时处理
		   //点击组件节点时 将节点数据暂时存到隐藏域中
		   document.getElementById("nodeData").value = isc.JSON.encode(node);
		}else{
		   document.getElementById("nodeData").value = null;
		}
     }
     //if phase==4 get mid
     function getMid(data){
     	var phase = Matrix.getFormItemValue("phase");
     	var mid = data[0].entityId;
     	return mid;
     }
     //获得序号
     function getNextIndex(data){
     	var index = 0;
     	if(data!=null && data.length>0){
     		for(var i = 0;i<data.length;i++){
     			var node = data[i];
     			if(node.type=="List"||node.type=="DataObject"){
     			
     				index=index+1;
     			}
     		}
     	}
     	Matrix.say(index+"");
     	return index;
     }
     //获得子列表的个数
     function getSubVarNum(data,mid){
     	var maxNum = 0;
     	var numArr = [];
     	if(data!=null && data.length>0){
     		for(var i = 0;i<data.length;i++){
     			var node = data[i];
     			if(node.type=="List"){
     				var entityId = node.entityId;
     				if(entityId.contains(mid)){
     					var num = entityId.replace(mid,"");
	     				//var num = entityId.substr(entityId.indexOf(mid)+1);
	     				numArr.add(num);
     				}
     			}
     		}
     		maxNum = getMaxNum(numArr);
     	}
     	return maxNum;
     }
     //获得最大值
     function getMaxNum(numArr){
     	var max = 0;
     	if(numArr!=null && numArr.length>0){
     		max = parseInt(numArr[0]);
     		for(var i = 0;i<numArr.length-1;i++){
     			var n = parseInt(numArr[i+1]);
     			if(max<n){
     				max = n;
     			}
     		}
     		max = max+1;
     	}
     	return max;
     }
     //根节点 新增表单变量  DataObject  主表单变量  List 列表变量
     function addFormVar(target,type){
     	var data = MTree0_DS.$27m;
     	var parentNodeId = data[0].id;
     	var mid = getMid(data);
     	var index  = getNextIndex(data);//序号
     	if(type=='DataObject'){
     		//MTree0
     		var isExistMainFormVar = false;
     		if(data!=null && data.length>0){
     			for(var i = 0;i<data.length;i++){
     				if(data[i].type=='DataObject'){
     					isExistMainFormVar = true;
     					Matrix.warn("已经存在主表单变量，请不要重复添加！");
     					return;
     				}
     			}
     			if(!isExistMainFormVar){
     				//不存在主表单变量  弹出窗口添加
     				MaddFormVarDialog.setTitle("新建主表单变量");
     				var url = "<%=request.getContextPath()%>/datasource/formVar_loadFormVarPage.action?oType=add&formVarType=DataObject&&parentNodeId="+parentNodeId+"&formVarType="+type;
     				if(mid!=null && mid.length>0){
     					url +="&Mid="+mid+"MainEntityVar";
     				}
     				url+="&index="+index;
     				MaddFormVarDialog.initSrc = url; 
     				Matrix.showWindow('addFormVarDialog');
     			}
     		}	
     	}else if(type=='List'){
     		var parentNodeId = data[0].id;
     		//不存在主表单变量  弹出窗口添加
     		MaddFormVarDialog.setTitle("新建列表变量");
     		var url = "<%=request.getContextPath()%>/datasource/formVar_loadFormVarPage.action?oType=add&formVarType=List&&parentNodeId="+parentNodeId+"&formVarType="+type;
     		if(mid!=null && mid.length>0){
     			var num = getSubVarNum(data,mid);
     			url +="&Mid="+mid+num;//子列表  表单ID+n
     		}
     		url+="&index="+index;
     		MaddFormVarDialog.initSrc = url; 
     		MaddFormVarDialog.initSrc = 
     		Matrix.showWindow('addFormVarDialog');
     	}
     }
     
     //添加属性
     function addProperty(target,editType){
     	var data = MTree0_DS.$27m;
     	var id = target.id;//主对象编码
		var mainFormVarType = target.type;//主表单变量类型
     	//var mid = target.entityId;
     	var url = "<%=request.getContextPath()%>/datasource/formVarPro_loadPropertyInfo.action?parentNodeId="+id+"&editType="+editType+"&mainFormVarType="+mainFormVarType;
     	MaddFormVarDialog.setTitle("新增表单变量属性");
     	MaddFormVarDialog.setWidth('600px');
     	MaddFormVarDialog.setHeight('350px');
     	MformVarProDialog.initSrc=url;
     	Matrix.showWindow('formVarProDialog');
     	
     }
     //修改属性
     function editProperty(target,editType){
     	var data = MTree0_DS.$27m;
     	var id = target.parentId;//父节点编码(主对象编码)
     	var type = target.type;
     	var mid = target.entityId;//entityPropertyUuid
     	var url = "<%=request.getContextPath()%>/datasource/formVarPro_loadPropertyInfo.action?mid="+mid+"&parentNodeId="+id+"&editType="+editType;
     	MaddFormVarDialog.setWidth('600px');
     	MaddFormVarDialog.setHeight('350px');
     	MaddFormVarDialog.setTitle("修改表单变量属性");
     	MformVarProDialog.initSrc=url;
     	Matrix.showWindow('formVarProDialog');
     }
     
     function submitByButton(){
     	//1.首先判断是否选中节点
	    var nodeDataValue = document.getElementById("nodeData").value;
	    if(nodeDataValue!=null&&nodeDataValue.length>0){
	    	Matrix.closeWindow(nodeDataValue);
	    	
	    }else{
	      isc.say("请选择表单变量!",{width:150,height:70});
	    }
     
     }
     //双击节点选择变量 自定义函数
     function nodeDoubleClickCustomFun(record){
     	var nodeType = record.type;
     	if(nodeType!=null&&nodeType!='0'){
     		Matrix.closeWindow(isc.JSON.encode(record));//encode为了和单击时数据保持一致
     	}else{
     	    isc.say('请选择表单变量!',{ width:150,height:70});
     	}
     }
     //判断数组中是否包含该元素
     function contains(arr, obj) {  
   	 	var i = arr.length;  
    	while (i--) {  
        	if (arr[i] === obj) {  
          	  return true;  
       	    }  
     	}  
    	return false;  
	 }  
     //指定右键菜单
     function assignNodeMenu(viewer, node, recordNum){
     		//属性的数据类型集合
     	 	var propertyTypeArr = [1,2,3,4,5,6,7,8,9,13];
     	 //根据节点类型设置右键菜单
			var nodeType = node.type;
			if(nodeType==0){ //根目录
				var nodeMenu = MTreeMenu_root;
				if(nodeMenu){
					nodeMenu.target=node;//将右键菜单指向该节点
					nodeMenu.showContextMenu();//弹出显示该菜单
				}
			}else if(contains(propertyTypeArr,nodeType)){//子目录
				var nodeMenu = MTreeMenu1;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			}else if(nodeType==16){//实体页(业务对象页)
				var nodeMenu = MTreeMenu0;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			}else if(nodeType=='DataObject'||nodeType=='List'){
				var nodeMenu = MTreeMenu0;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			}
     }
     
     function deleteObject(target){
     	Matrix.confirm("确认删除"+target.text+"?",function(value){
     		if(value){
     			var entity = target.entity;
		     	var entityId = target.entityId;
		     	var type = target.type;//DataObject or List
		     	if(entity!=null && entity.length>0 && entity!='undefined'){
		     		var url = webContextPath+"/datasource/formVar_deleteFormVar.action";
		     		var json = "{'entity':'"+entity+"','entityId':'"+entityId+"','type':'"+type+"'}";
		     		var synJson = isc.JSON.decode(json);
		     		Matrix.sendRequest(url,synJson,function(data){
		     			if(data!=null && data.data!=''){
		     				var result = isc.JSON.decode(data.data);
		     				if(result.result){
		     					var parentNodeId = target.parentId;
		     					Matrix.forceFreshTreeNode("Tree0", parentNodeId);
		     					Matrix.say("删除成功!");
		     				}
		     			}
		     		});
		     	}
		     }
     	
     	});
     	
     }
     
     function moveUp(target){
     	var entityId = target.entityId;
     	if(entityId!=null && entityId.length>0 && entityId!='undefined'){
     		var url = "<%=request.getContextPath()%>/datasource/formVar_moveUpFormVar.action";
     		var json = "{'entityId':'"+entityId+"'}";
     		var synJson = isc.JSON.decode(json);
     		Matrix.sendRequest(url,synJson,function(){
     					var parentNodeId = target.parentId;
     					Matrix.forceFreshTreeNode("Tree0", parentNodeId);
     		});
     	}
     }
     function moveDown(target){
     	var entityId = target.entityId;
     	if(entityId!=null && entityId.length>0 && entityId!='undefined'){
     		var url = "<%=request.getContextPath()%>/datasource/formVar_moveDownFormVar.action";
     		var json = "{'entityId':'"+entityId+"'}";
     		var synJson = isc.JSON.decode(json);
     		Matrix.sendRequest(url,synJson,function(){
     			var parentNodeId = target.parentId;
     			Matrix.forceFreshTreeNode("Tree0", parentNodeId);
     		});
     	}
     }
     
     function moveUpProperty(target){
     	var entityId = target.entityId;
     	var parentNodeId = target.parentId;
     	if(entityId!=null && entityId.length>0 && entityId!='undefined'){
     		var url = "<%=request.getContextPath()%>/datasource/formVarPro_moveUpEntityProperty.action";
     		var json = "{'entityId':'"+entityId+"','parentNodeId':'"+parentNodeId+"'}";
     		var synJson = isc.JSON.decode(json);
     		Matrix.sendRequest(url,synJson,function(){
     					var parentNodeId = target.parentId;
     					Matrix.forceFreshTreeNode("Tree0", parentNodeId);
     		});
     	}
     }
     function moveDownProperty(target){
      	var entityId = target.entityId;
      	var parentNodeId = target.parentId;
     	if(entityId!=null && entityId.length>0 && entityId!='undefined'){
     		var url = "<%=request.getContextPath()%>/datasource/formVarPro_moveDownEntityProperty.action";
     		var json = "{'entityId':'"+entityId+"','parentNodeId':'"+parentNodeId+"'}";
     		var synJson = isc.JSON.decode(json);
     		Matrix.sendRequest(url,synJson,function(){
     			var parentNodeId = target.parentId;
     			Matrix.forceFreshTreeNode("Tree0", parentNodeId);
     		});
     	}
     }
     function deleteProperty(target){
	     Matrix.confirm("确认删除"+target.text+"?",function(value){
	     	if(value){
		        var entityId = target.entityId;
		        var parentNodeId = target.parentId;
		     	if(entityId!=null && entityId.length>0 && entityId!='undefined'){
		     		var url = "<%=request.getContextPath()%>/datasource/formVarPro_deleteEntityProperty.action";
		     		var json = "{'entityId':'"+entityId+"','parentNodeId':'"+parentNodeId+"'}";
		     		var synJson = isc.JSON.decode(json);
		     		Matrix.sendRequest(url,synJson,function(){
		     			var parentNodeId = target.parentId;
		     			Matrix.forceFreshTreeNode("Tree0", parentNodeId);
		     			Matrix.say("删除成功!");	
		     		});
		     	}
	     	}
	     });
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
				action:"<%=request.getContextPath()%>/datasource/formVar_loadFormVarDataTree.action?varFormat=${param.varFormat}",
				fields:[{
					name:'Form0_hidden_text',
					width:0,height:0,
					displayId:'Form0_hidden_text_div'}]
		});
		</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
		action="<%=request.getContextPath()%>/datasource/formVar_loadFormVarDataTree.action?varFormat=${param.varFormat}" 
		style="margin:0px;height:100%;" 
		enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<!-- 传递要查询的组件类型 -->
	<input type="hidden" name="custom" id="custom" value="${param.custom }"/>
	<input type="hidden" name="phase" id="phase" value="${phase }"/>
	
	<input type="hidden" name="componentType" id="componentType" value="${param.componentType}"/> 
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="<%=request.getParameter("iframewindowid") %>">
	<input type="hidden" name="nodeData" id="nodeData">
	
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>
<table id="table0css" jsId="table0css" class="maintain_form_content" cellpadding="0px" cellspacing="0px"
								 style="width:100%;height:100%">
	 <tr id="j_id2" jsId="j_id2">
		  	<td id="j_id3" jsId="j_id3"  style="height:100%;">
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
						canDrag: false,
						type:0,//根节点类型默认为0
						
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
		showHover:false,
		showCellContextMenus:true,
		leaveScrollbarGap:false,
		canAutoFitFields:true,
		wrapCells:false,
		fixedRecordHeights:true,
		selectionType:"single",
		selectionAppearance:"rowStyle",
		folderIcon:Matrix.getTreeNodeIcon("folder"),
		data:MTree0_DS,
		autoFetchData:true,
		showOpenIcons:false,
		closedIconSuffix:'',
		showPartialSelection:false,
		cascadeSelection:false,
		border:0,
		onMoveUpAction:"true",
		onMoveDownAction:"true",
		showConnectors: true,//显示链接纹路
		canAcceptDroppedRecords: false,//不允许拖入
        canDragRecordsOut: true,//允许拖出
        dragDataAction: "copy",//复制
		nodeContextClick:function(viewer, node, recordNum){
			assignNodeMenu(viewer, node, recordNum);
		},
		dragMove:function(){
			var dragNode = MTree0.getSelectedRecord();
			if(dragNode!=null){
				var name = dragNode.text;
				var id=dragNode.entityId;
				var entity = dragNode.entity;
				alert("dragMove属性：name："+name+" id:"+id+" entity:"+entity);
			}
		},
		nodeClick:function(viewer, node, recordNum){
		    nodeClickCustomFun(node);
		       
		}, 
		
		cellDoubleClick:function(record, rowNum, colNum){//双击事件
			nodeDoubleClickCustomFun(record);
			
		},
		getIcon:function(node){//根据节点类型[type dataType]返回不同类型的icon
			var nodeType =node.type;
		
		  if(nodeType==0){ //根节点，表单模型
		     return	Matrix.getTreeNodeIcon("form");
		  }
		 
		  else if(nodeType=='13'||nodeType=='DataObject'||nodeType=='List'){//实体类型
		  //DataObject 和 List 图标都一样
		         return	Matrix.getTreeNodeIcon("bo_entity");
		  }else if(nodeType=='14'||nodeType=='Object'){//任意对象
		       return	Matrix.getTreeNodeIcon("bo_entity");
		  }else{
		  	 return	Matrix.getTreeNodeIcon("node");
		  }
		  
		}
	});
	
	isc.Page.setEvent(isc.EH.LOAD,"MTree0.resizeTo('100%','100%');");
	isc.Page.setEvent(isc.EH.RESIZE,"MTree0.resizeTo(0,0);MTree0.resizeTo('100%','100%');",null);
</script>

		<script>
		isc.Menu.create({
					ID:"MTreeMenu1",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [
						{title:"编辑属性",click:"editProperty(target,'update')",icon:"/mofficeV2/resource/images/matrix/edit.png"},
						{title:"上移",click:"moveUpProperty(target)",icon:"/mofficeV2/resource/images/matrix/upsmall.png"},
						{title:"下移",click:"moveDownProperty(target)",icon:"/mofficeV2/resource/images/matrix/downsmall.png"},
						{title:"删除",click:"deleteProperty(target)",icon:"/mofficeV2/resource/images/matrix/Remove.png"} 
					] 					
				});
		isc.Menu.create({
					ID:"MTreeMenu0",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")},
						{title:"添加属性",click:"addProperty(target,'add')",icon:Matrix.getActionIcon("add")},
						//{title:"编辑属性",click:"editProperty(target,'update')",icon:"/mofficeV2/resource/images/matrix/Edit.png"},
						{title:"上移",click:"moveUp(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"moveDown(target)",icon:Matrix.getActionIcon("move_down")},
						{title:"删除",click:"deleteObject(target)",icon:Matrix.getActionIcon("delete")} 
					] 					
				});
				
				isc.Menu.create({
					ID:"MTreeMenu_root",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")},
						{title:"主表单变量",click:"addFormVar(target,'DataObject')",icon:Matrix.getActionIcon("add")},
						{title:"子列表变量",click:"addFormVar(target,'List')",icon:Matrix.getActionIcon("add")},
					] 					
				});
		</script>				

		   	</td>
		</tr>
		
</table>
</form>
<script>
					//新建表单变量
					isc.Window.create({
							ID:"MaddFormVarDialog",
							id:"addFormVarDialog",
							name:"addFormVarDialog",
							autoCenter: true,
							position:"absolute",
							height: "500px",
							width: "900px",
							title: "新建表单变量",
							canDragReposition: true,
							showMinimizeButton:false,
							showMaximizeButton:true,
							showCloseButton:true,
							showModalMask: false,
							modalMaskOpacity:0,
							isModal:true,
							//targetDialog:'MMainDialog',
							autoDraw: false,
							headerControls:[
								"headerIcon","headerLabel",
								"closeButton"
							]
					
					});
					MaddFormVarDialog.hide();
					</script>
					<script>
					//编辑表单变量属性
					isc.Window.create({
							ID:"MformVarProDialog",
							id:"formVarProDialog",
							name:"formVarProDialog",
							autoCenter: true,
							position:"absolute",
							height: "500px",
							width: "650px",
							title: "编辑表单变量属性",
							canDragReposition: false,
							showMinimizeButton:false,
							showMaximizeButton:false,
							showCloseButton:true,
							showModalMask: false,
							modalMaskOpacity:0,
							isModal:true,
							autoDraw: false,
							//targetDialog:'MMainDialog',
							headerControls:[
								"headerIcon","headerLabel",
								"closeButton"
							]
					
					});
					MformVarProDialog.hide();
					</script>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script></div>

</body>
</html>