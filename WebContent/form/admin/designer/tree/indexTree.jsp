<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                目录管理
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <script type="text/javascript">
                function forwardPage(node, url) {
                    var src = handTreeNodeHref(node, url);
                    src = "<%=request.getContextPath()%>" + "/" + src;
                    Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
                }

                //选中节点连接到修改页面
                function forwardPageByNodeType(viewer, node, recordNum) {
                     //var record = MTree0.getRecord(recordNum-1);
                    // MTree0.selectRecord(record);
                    // MTree0.deselectRecord (node);
                    // MTree0.refreshRow(recordNum-1);
                    // MTree0.refreshRow(recordNum);
                     var nodeType = parseInt(node.type);
                    
                     var  nodes = MTree0.getTotalRows();
                    switch (nodeType) {
                    case 0:
                        var url = webContextPath+'/formdesigner.daction?componentType=TreeNode&command=edit';
				 		MhorizontalContainer0Panel1.setContentsURL(url);
                    
                        break;
                    case 1:
                        var url = webContextPath+'/formdesigner.daction?componentType=StaticTreeNode&command=edit&componentId='+node.id;
				 		MhorizontalContainer0Panel1.setContentsURL(url);
                        break;
                    case 2:
                        var url = webContextPath+'/formdesigner.daction?componentType=DynamicTreeNode&command=edit&componentId='+node.id;
				 		MhorizontalContainer0Panel1.setContentsURL(url);
                        break;
                    }
                }
                
				//-------------------------------begin---------------------------
				
				//添加静态节点
				function addStaticTreeNode(target){
					forwardPage(target, "designer/treeCompDesign_addTreeNode.action?id=treeNode.id&curNodeType="+target.type+"&addNodeType=1&parentNodeId=treeNode.id");
				}
				
				//添加动态节点
				function addDynamicTreeNode(target){
					forwardPage(target, "designer/treeCompDesign_addTreeNode.action?id=treeNode.id&curNodeType="+target.type+"&addNodeType=2&parentNodeId=treeNode.id");
				}
				
				//删除节点
				function deleteTreeNode(target){
					forwardPage(target, "designer/treeCompDesign_deleteTreeNode.action?id=treeNode.id&curNodeType="+target.type+"&addNodeType=2&parentNodeId=treeNode.parentNodeId");
				}
				
				//更新节点信息( by type) 
				function updateTreeNode(target){
				
				}
				
				//-------------------------------end---------------------------	

                //指定右键菜单
                function assignNodeMenu(viewer, node, recordNum) {
                    //根据节点类型设置右键菜单
                    var nodeType = node.type;
                    if (nodeType == 0) { //根节点
                        var nodeMenu = MTreeMenu_Root;
                        if (nodeMenu) {
                            nodeMenu.target = node; //将右键菜单指向该节点
                            nodeMenu.showContextMenu(); //弹出显示该菜单
                        }
                    } else if (nodeType == 1||nodeType == 2) { //1静态 2动态
                        var nodeMenu = MTreeMenu_SubCatalog;
                        if (nodeMenu) {
                            nodeMenu.target = node;
                            nodeMenu.showContextMenu();
                        }

                    }
                }
            </script>
        </head>
        
        <body>
            <jsp:include page="/form/admin/common/loading.jsp"/>
            <div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
                <script>
                    var MForm0 = isc.MatrixForm.create({
                        ID: "MForm0",
                        name: "MForm0",
                        position: "absolute",
                        action: "<%=request.getContextPath()%>/designer/treeCompDesign_loadTreeModel.action",
                        fields: [{
                            name: 'Form0_hidden_text',
                            width: 0,
                            height: 0,
                            displayId: 'Form0_hidden_text_div'
                        }]
                    });
                </script>
                <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="<%=request.getContextPath()%>/designer/treeCompDesign_loadTreeModel.action"
                style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="Form0" value="Form0" />
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;">
                    </div>
                    <div id="horizontalContainer0_div" class="matrixInline" style="width: 100%; height: 100%;; overflow: hidden;">
                        <script>
                            isc.HLayout.create({
                                ID: "MhorizontalContainer0",
                                displayId: "horizontalContainer0_div",
                                position: "relative",
                                height: "100%",
                                width: "100%",
                                align: "center",
                                overflow: "auto",
                                defaultLayoutAlign: "center",
                                members: [isc.MatrixHTMLFlow.create({
                                    ID: "MhorizontalContainer0Panel0",
                                    width: '25%',
                                    height: "100%",
                                    overflow: "hidden",
                                    showResizeBar: "true",
                                    contents: "<div id='horizontalContainer0Panel0_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
                                }),

                                isc.HTMLPane.create({
                                    ID: "MhorizontalContainer0Panel1",
                                    height: "100%",
                                    overflow: "hidden",
                                    showEdges: false,
                                    contentsType: "page",
                                    contentsURL: ""
                                })]
                            });
                        </script>
                    </div>
                    <div id="horizontalContainer0Panel0_div2" style="width: 100%; height: 100%; overflow: hidden;"
                    class="matrixInline">
                        <div id="Tree0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
                            <script>
                                isc.MatrixTree.create({
                                    ID: "MTree0_DS",
                                    modelType: "children",
                                    ownerType: "tree",
                                    formId: "Form0",
                                    autoOpenRoot: false,
                                    ownerId: "Tree0",
                                    childrenProperty: "children",
                                    nameProperty: "text",
                                    root: {
                                        id: "RootTreeNode",
                                        entityId: "RootTreeNode",
                                        text: "RootTreeNode",
                                        type: 0
                                    }
                                });
                                isc.Page.setEvent('load', 'MTree0_DS.openFolder(MTree0_DS.root)', isc.Page.FIRE_ONCE);

                                isc.MatrixTreeGrid.create({
                                    ID: "MTree0",
                                    name: "Tree0",
                                    displayId: "Tree0_div",
                                    position: "relative",
                                    showHeader: false,
                                    showHover:false,
                                    showCellContextMenus: true,
                                    leaveScrollbarGap: false,
                                    canAutoFitFields: true,
                                    wrapCells: false,
                                    fixedRecordHeights: true,
                                    selectionType: "single",
                                    selectionAppearance: "rowStyle",
                                    folderIcon:  Matrix.getActionIcon("node"),
                                    data: MTree0_DS,
                                    autoFetchData: true,
                                    showOpenIcons: false,
                                    closedIconSuffix: '',
                                    showPartialSelection: false,
                                    cascadeSelection: false,
                                    border: 0,
                                    onMoveUpAction: "true",
                                    onMoveDownAction: "true",
                                    nodeContextClick: function(viewer, node, recordNum) {//右键
                                        assignNodeMenu(viewer, node, recordNum);

                                    },
                                    nodeClick: function(viewer, node, recordNum) {//选中
                                        forwardPageByNodeType(viewer, node, recordNum);
                                    },
                                    getIcon: function(node) { //根据节点类型返回不同类型的icon
                                        return getNodeIconByType(node);
                                    },
                                    loadChildrenCallback:function(data){
                                    	if(this.isFresh){
                                    		var node = MTree0_DS.findById(this.addNodeId);//获取点击节点同级节点集合
									   		var recordNum = this.getRecordIndex (node); 
									   		
									     	this.deselectAllRecords();
											this.selectRecord (node);
									   		//触发单击节点事件
									   		this.nodeClick(MTree0,node,recordNum);
									   		//this.body.$29y(recordNum,0);//行 列
									   
											delete this.isFresh;
											delete this.addNodeId;
                                    	}
                                    }
                                });

                                if (MhorizontalContainer0Panel0) if (!MhorizontalContainer0Panel0.customMembers) MhorizontalContainer0Panel0.customMembers = [];

                                MhorizontalContainer0Panel0.customMembers.add(MTree0);
                                isc.Page.setEvent(isc.EH.LOAD, "MTree0.resizeTo('100%','100%');");
                                isc.Page.setEvent(isc.EH.RESIZE, "MTree0.resizeTo(0,0);MTree0.resizeTo('100%','100%');", null);
                            </script>
                        </div>
                        <script>
                            //根的右键菜单
                            isc.Menu.create({
                                ID: "MTreeMenu_Root",
                                autoDraw: false,
                                showShadow: true,
                                shadowDepth: 10,
                                autoFitFieldWidths:true,
                                fixedFieldWidths:true,
                                data: [{
                                    title: "添加动态节点",
                                    click: "addDynamicTreeNode(target)",
                                    icon:Matrix.getActionIcon("add")
                                },
                                {
                                    title: "添加静态节点",
                                    click: "addStaticTreeNode(target)",
                                     icon:Matrix.getActionIcon("add")
                                },
                                {
                                    title: "刷新",
                                    click: "Matrix.refreshTreeNode(target)",
                                     icon:Matrix.getActionIcon("refresh")
                                }
                                /*,
                                
                                {
                                    title: "属性修改",
                                    click: "modifyCatalog(target)",
                                     icon:Matrix.getActionIcon("edit")
                                }*/
                                
                                ]
                            });
                        </script>
                        <script>
                            //子目录右键菜单
                            isc.Menu.create({
                                ID: "MTreeMenu_SubCatalog",
                                autoDraw: false,
                                showShadow: true,
                                shadowDepth: 10,
                                autoFitFieldWidths:true,
                                fixedFieldWidths:true,
                                data: [{
                                    title: "添加动态节点",
                                    click: "addDynamicTreeNode(target)",
                                    icon:Matrix.getActionIcon("add")
                                },
                                {
                                    title: "添加静态节点",
                                    click: "addStaticTreeNode(target)",
                                     icon:Matrix.getActionIcon("add")
                                },
                                {
                                    title: "刷新",
                                    click: "Matrix.refreshTreeNode(target)",
                                     icon:Matrix.getActionIcon("refresh")
                                },
                                {
                                    title: "上移",
                                    click: "Matrix.moveUpTreeNode(target);",
                                    icon:Matrix.getActionIcon("move_up")
                                },
                                {
                                    title: "下移",
                                    click: "Matrix.moveDownTreeNode(target)",
                                    icon:Matrix.getActionIcon("move_down")
                                },
                                {
                                    title: "删除",
                                    click: "deleteTreeNode(target)",
                                    icon:Matrix.getActionIcon("delete")
                                }
                               /* 
                                ,
                                {
                                    title: "属性修改",
                                    click: "updateTreeNode(target)",//根据type来判断
                                     icon:Matrix.getActionIcon("edit")
                                }
                                */
                                ]
                            });
                        </script>
                        <script>
                            //模块右键菜单
                            isc.Menu.create({
                                ID: "MTreeMenu_Module",
                                autoDraw: false,
                                showShadow: true,
                                shadowDepth: 10,
                                data: [{
                                    title: "删除",
                                    click: "deleteCatalog(target)",
                                    icon:Matrix.getActionIcon("delete")
                                },
                                {
                                    title: "上移",
                                    click: "Matrix.moveUpTreeNode(target)",
                                    icon:Matrix.getActionIcon("move_up")
                                },
                                {
                                    title: "下移",
                                    click: "Matrix.moveDownTreeNode(target)",
                                    icon:Matrix.getActionIcon("move_down")
                                },
                                {
                                    title: "刷新",
                                    click: "Matrix.refreshTreeNode(target)",
                                     icon:Matrix.getActionIcon("refresh")
                                }
                                /*,
                                {
                                    title: "属性修改",
                                    click: "modifyModule(target)",
                                    icon:Matrix.getActionIcon("edit")
                                }*/]
                            });
                        </script>
                        
                       
                    </div>
                    <script>
                        document.getElementById('horizontalContainer0Panel0_div').appendChild(document.getElementById('horizontalContainer0Panel0_div2'));
                    </script>
                </form>
                <script>
                    MForm0.initComplete = true;
                    MForm0.redraw();
                    isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
                </script>
            </div>
        </body>
    
    </html>