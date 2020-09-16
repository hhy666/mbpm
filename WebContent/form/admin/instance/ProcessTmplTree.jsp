<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      	<title>
    		Matrix Form 控制台
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
		function forwardPage(node,url){
			var src = handTreeNodeHref(node,url);
			src = "<%=request.getContextPath()%>"+"/"+src;
			Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
		}
	
	
//点击节点时链接到对应的页面  右键单击
 function forwardPageByNodeType(node){
	     		
	var nodeType =parseInt(node.type);
    switch(nodeType){
    	case 0:
    	   // modifyCatalog(node);
    		break;
    	case 1:
    	    modifyCatalog(node);
    		break;
    	case 2:
    		 modifyModule(node);
    		break;
    	case 14://表单
    	    var comType = node.comType;//获取组件类型
    	    forwardPage(node,"form/formInfo_loadFormMainPage.action?nodeUuid=treeNode.entityId&type="+comType+"&parentNodeId="+node.parentId);
    	    
    		break;
    	case 15://逻辑服务
    	    var comType = node.comType;
    	    
    	    //isCommon="+node.virtualSid 传递服务模块名称
    	    //参数为mid 与EntityInfo字段对应 comType/parentNodeId 同步刷新节点使用
    	    forwardPage(node,"logic/logicInfo_loadLogicMainPage.action?mid=treeNode.id&comType=treeNode.comType&parentNodeId="+node.parentId+"&isCommon="+node.virtualSid);  
    		break;
    	case 16:
    	    var comType = node.comType;
    	    if(comType==1){//实体对象
    	      forwardPage(node,"entity/entityInfo_loadMainPage.action?mid=treeNode.id&parentNodeId="+node.parentId);  //参数为id 与EntityInfo字段对应
    	    }else if(comType==2){//查询对象
    	      forwardPage(node,"entity/entityInfo_loadMainPage.action?mid=treeNode.id&parentNodeId="+node.parentId);  //参数为id 与EntityInfo字段对应
    	    }
    		break;
    	case 17:
    	    modifyComponent(node);
    		break;
    	case 18:
    		modifyComponent(node);
    		break;
    }
}
	
	
	//添加子目录
	function addSubCatalog(target){	
		forwardPage(target,"<%=request.getContextPath()%>/catalog_addCatalogEntrance.action?parentId="+target.entityId+"&parentNodeId=treeNode.id&type=1");
	}
	
	//添加模块
	function addModule(target){     
		forwardPage(target,"<%=request.getContextPath()%>/catalog_addCatalogEntrance.action?parentId="+target.entityId+"&parentNodeId=treeNode.id&type=2");
			
	}
	
	
	//删除节点 根节点暂未添加该事件
	function deleteCatalog(target){
	    var nodeType = target.type;//节点类型
	    var confirmMsg = "节点";
	    var comType = target.comType;
	    switch(nodeType){
	    	case 1:
	    	  confirmMsg ="子目录"+target.text;
	    	break;
	    	case 2:
	    	confirmMsg ="模块"+target.text;
	    	break;
	    	case 14:
	    	confirmMsg ="表单"+target.text;
	    	break;
	    	case 15:
	    		if(comType==1){
		    		confirmMsg ="服务逻辑"+target.text;
		    	}else if(comType==2){
		    		confirmMsg ="脚本逻辑"+target.text;
		    	}else{
			    	confirmMsg ="逻辑服务"+target.text;
		    	}
	    	break;
	    	case 16:
		    	if(comType==1){
		    		confirmMsg ="实体对象"+target.text;
		    	}else if(comType==2){
		    		confirmMsg ="查询对象"+target.text;
		    	}else{
		    	confirmMsg ="业务对象"+target.text;
		    	
		    	}
	    		break;
	    	case 17:
	    	confirmMsg ="流程"+target.text;
	    	break;
	    	case 18:
	    	confirmMsg ="场景"+target.text;
	    	break;
	    	
	    }
	    
	    
	    isc.confirm('确定要删除'+confirmMsg+'吗?',function(data){//true or null
		      if(data){
				forwardPage(target,"<%=request.getContextPath()%>/catalog_deleteCatalog.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type+"&mid="+target.id);
		                                    		
		      }
                                    		 
        });
		
	}
	
	//删除组件
    function deleteComponent(target){
		forwardPage(target,"<%=request.getContextPath()%>/catalog_deleteCatalog.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type+"&mid="+target.id);
    }	
    
	//修改模块
	function modifyModule(target){
	    //先根据实体id查询，在Action中获取type
		forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id");
	}
	
	//修改目录
	function modifyCatalog(target){
		forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id");
	}
	
	//添加表单
	function addForm(target){
           //添加时 需要将组件全路径传递
           forwardPage(target,"<%=request.getContextPath()%>/catalog_addComponentEntrance.action?entityId="+target.entityId+"&parentId="+target.parentId+"&parentNodeId=treeNode.id&entity="+target.entity+"&type=14");
	
	}
	
	//添加逻辑服务
	function addLogicService(target){
           forwardPage(target,"<%=request.getContextPath()%>/catalog_addComponentEntrance.action?entityId="+target.entityId+"&parentId="+target.parentId+"&parentNodeId=treeNode.id&type=15");
	}
	
	//添加实体对象
	function addEntityObject(target){
           forwardPage(target,"<%=request.getContextPath()%>/catalog_addComponentEntrance.action?entityId="+target.entityId+"&parentId="+target.parentId+"&parentNodeId=treeNode.id&type=16&comType=1");
	}
	//添加查询对象
	function addQueryObject(target){
           forwardPage(target,"<%=request.getContextPath()%>/catalog_addComponentEntrance.action?entityId="+target.entityId+"&parentId="+target.parentId+"&parentNodeId=treeNode.id&type=16&comType=2");
	}
	
	//添加协同流程
	function addSynFlow(target){
           forwardPage(target,"<%=request.getContextPath()%>/catalog_addComponentEntrance.action?entityId="+target.entityId+"&parentId="+target.parentId+"&parentNodeId=treeNode.id&type=17");
	}
	//添加场景
	
	function addScene(target){
           forwardPage(target,"<%=request.getContextPath()%>/catalog_addComponentEntrance.action?entityId="+target.entityId+"&parentId="+target.parentId+"&parentNodeId=treeNode.id&type=18");
	}


	
	//修改组件[表单,页面流，逻辑服务，业务对象，协同流程]
	function modifyComponent(target){
	   var type = parseInt(target.type);
	   
	   if(type==17){//流程
	 	  forwardPage(target,"form/admin/process/mainProcess.jsp?processId=treeNode.id&entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type); 
	   }else{
	   	  forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type);
	   } 
	   /*
	   switch(type){
	   	case 14:
	   	   forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type); 
	   	   break;
	    case 15:
	   	   forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type); 
	   	   break;
	   	case 16:
	   	   forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type); 
	   	   break;   
	   	case 17:
	   	   forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type); 
	   	   break;
	   	case 18:
	   	   forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type); 
	   	   break;
	   }
	   */

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
			
			}else if(nodeType==2){//模块
				var nodeMenu = MTreeMenu_Module;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==4){//表单目录
				var nodeMenu = MTreeMenu_FormFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==5){//逻辑目录
				var nodeMenu = MTreeMenu_LogicFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==6){//业务对象目录
				var nodeMenu = MTreeMenu_ServiceObjFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==7){//流程目录
				var nodeMenu = MTreeMenu_SynFlowFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==8){//场景目录
				var nodeMenu = MTreeMenu_SceneFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==14){//表单页
				var nodeMenu = MTreeMenu_FormPage;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==15){//逻辑页 除表单页面外，其余四个是相同的右键菜单
				var nodeMenu = MTreeMenu_Common;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==16){//实体页(业务对象页)
				var nodeMenu = MTreeMenu_Common;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==17){//流程页
				var nodeMenu = MTreeMenu_Common;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==18){//场景页
				var nodeMenu = MTreeMenu_Common;
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
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
         <script>
							var MForm0=isc.MatrixForm.create({
								ID:"MForm0",name:"MForm0",position:"absolute",
								action:"<%=request.getContextPath()%>/catalog_manageTree.action",
								fields:[{
										name:'Form0_hidden_text',
										width:0,
										height:0,
										displayId:'Form0_hidden_text_div'
								}]
							});
				</script>
        <form id="Form0" name="Form0" eventProxy="MForm0" method="post"
					action="<%=request.getContextPath()%>/catalog_manageTree.action"
					style="margin: 0px; height: 100%;"
					enctype="application/x-www-form-urlencoded">
					<input type="hidden" name="Form0" value="Form0" />
				<div type="hidden" id="Form0_hidden_text_div"
					name="Form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
               
           
            
           
				<div id="horizontalContainer0Panel0_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">
                <script>
                        isc.HLayout.create({
							ID:"MhorizontalContainer0",
	                            height:"100%",
								width: "100%",
								align: "center",
								overflow: "auto",
								defaultLayoutAlign: "center",
								members: [
									isc.MatrixHTMLFlow.create({
										 ID:"MhorizontalContainer0Panel0",
										 width: '16%',
										 height: "100%",
										 overflow: "hidden",
										 showResizeBar: "true",
										 contents:"<div id='horizontalContainer0Panel0_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
								}),
										 
								isc.HTMLPane.create({
									ID:"MhorizontalContainer0Panel1",
									height: "100%",
									overflow: "hidden",
									showEdges:false,
									contentsType:"page",
									contentsURL:""
									})
								] 
							});
                       
                </script>

				
				
				<div id="Tree0_div" class="matrixComponentDiv"
					style="width: 100%; height:100%; position: relative;">
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
									type:0
									}
						});
				isc.Page.setEvent('load','MTree0_DS.openFolder(MTree0_DS.root)',isc.Page.FIRE_ONCE);
				
				isc.MatrixTreeGrid.create({
						ID:"MTree0",
						name:"Tree0",
						height:"100%",
						width:"100%",
						displayId:"Tree0_div",
						position:"relative",
						showHeader:false,
						showHover:false,
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
						border:0,
						onMoveUpAction:"true",
						onMoveDownAction:"true", 
						nodeContextClick:function(viewer, node, recordNum){
						               assignNodeMenu(viewer, node, recordNum);
						 
						},
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
				</script>
			</div>
				<script>
				//根的右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_Root",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [ {
							title:"新建子目录",click:"addSubCatalog(target)",icon:Matrix.getActionIcon("add")},
							{title:"刷新子节点",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
							//{title:"删除",icon:Matrix.getActionIcon("delete")},
						//	{title:"属性修改",click:"modifyCatalog(target)",icon:Matrix.getActionIcon("edit")}
						 ] 
				});
				</script>
				<script>
				//子目录右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SubCatalog",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [ 
							{title:"新建子目录",click:"addSubCatalog(target)",icon:Matrix.getActionIcon("add")},
						    {title:"新建模块",click:"addModule(target)",icon:Matrix.getActionIcon("add")},
						    {title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")},
						    {title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						    {title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						    {title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")}//,
						  ]
				}); 
				</script>  <script>
				//模块右键菜单
					isc.Menu.create({
						ID:"MTreeMenu_Module",
						autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
							{title:"删除",click:"deleteCatalog(target)", icon:Matrix.getActionIcon("delete")},
							{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
							{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
							{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}//,
						] 
					});
				</script> <script>
				   //表单页右键菜单
				   isc.Menu.create({
					   ID:"MTreeMenu_FormFolder",
					   autoDraw:false,
					   showShadow:true,
					   shadowDepth:10,
					   data: [ 
						     {title:"新建表单",click:"addForm(target)",icon:Matrix.getActionIcon("add")},
						     {title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					   ] 
					});
				</script> <script>
				//业务对象右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_ServiceObjFolder",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [
						{title:"新建实体对象",click:"addEntityObject(target)",icon:Matrix.getActionIcon("add")},
						{title:"新建查询对象",click:"addQueryObject(target)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					] 
				});
				</script> <script>
				//协同流程右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SynFlowFolder",
				    autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [
						{title:"新建协同流程",click:"addSynFlow(target)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					]
				});
				</script> 
				<script>
				//逻辑服务右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_LogicFolder",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [
						{title:"新建逻辑服务",click:"addLogicService(target)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)", icon:Matrix.getActionIcon("refresh")}
					] 
				});
				</script>
				
				
				<script>
				//场景右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SceneFolder",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [
						{title:"新建场景",click:"addScene(target)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					] 
				});
				</script> <script>
				//业务对象页面
				isc.Menu.create({
					    ID:"MTreeMenu_Common",
					    autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}//,
					] 
				});
				</script> <script>
				//表单页面右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_FormPage",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						
						{title:"刷新",click:"Matrix.refreshTreeNode(target)", icon:Matrix.getActionIcon("refresh")}
					   ] 
				});
				</script> 
				<script>
					
					isc.Window.create({
							ID:"MCatalogTarget",
							id:"CatalogTarget",
							name:"CatalogTarget",
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
					MCatalogTarget.hide();
					</script>
				
       </div>
				</form>

<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
               
            <script>
               document.getElementById('horizontalContainer0Panel0_div').appendChild(document.getElementById('horizontalContainer0Panel0_div2'));
            </script>
        </div>
    </body>

</html>