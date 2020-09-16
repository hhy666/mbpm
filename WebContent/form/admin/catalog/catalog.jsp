<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		int curPhase = CommonUtil.getCurPhase();
	    String curUser = CommonUtil.getFormUser();
		String locationLabel = "";
		String processType = request.getParameter("processType");
		if(CommonUtil.USER_ZR.equals(curUser)){
			if(curPhase==2){
				locationLabel= "研发";
			}else if(curPhase==3){
				locationLabel= "实施";
			}else if(curPhase==4){
				locationLabel= "运行";
			}
			
		}else{//matrix
			if(curPhase==1){
				locationLabel= "需求建模";
			}else if(curPhase==3){
				locationLabel= "设计开发";
			}else if(curPhase==4){
				//locationLabel= "调整优化";
				if("2".equals(processType)){
					locationLabel= "协同流程定制";
				}else{
					locationLabel= "公文管理定制";
				}
			}
		}

	%>
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
	//-----lpz*****************************************************************
		//导出模块
	function showExportDialog(target){
		var uuid = target.entityId;
		var mid = target.mid;
		var treeId = target.$42c;
		var url = "form/admin/catalog/emptyPage.jsp?uuid="+uuid+"&mid="+mid+"&flag=export&&treeId="+treeId;
		forwardPage(target,url);
	}
	function exportModule(target){
		var uuid=target.entityId;
		var url = "OperatorModuleHelper?flag=export&uuid="+uuid;
		window.location.href="<%=request.getContextPath()%>"+"/"+url;
		//forwardPage(target,url);
	}
	function showImportDialog(target){
		var uuid = target.entityId;
		var mid = target.mid;
		var flag = "import";
		var treeId = target.$42c;
		
		var rootCode = Matrix.getFormItemValue('rootCode');
		var url = "form/admin/catalog/emptyPage.jsp?uuid="+uuid+"&mid="+mid+"&flag=import&treeId="+treeId+"&rootCode="+rootCode+"&parentNodeId=treeNode.id";
		forwardPage(target,url);
	}
	function exportContents(target){
		var uuid = target.entityId;
		var url = "form/admin/catalog/emptyPage.jsp?uuid="+uuid+"&flag=export&contentFlag=contents";
		forwardPage(target,url);
	}
	function importContents(target){
		var uuid = target.entityId;
		var mid = target.sid;
		//var parentNodeId=parentNodeId=treeNode.id;
		
		var url = "form/admin/catalog/emptyPage.jsp?uuid="+uuid+"&mid="+mid+"&flag=import&rootCode="+rootCode+"&contentFlag=contents&parentNodeId=treeNode.id";
		forwardPage(target,url);
	}
	//-----lpz*****************************************************************
		//复制表单路径到粘贴板
		function copyFormId(target){
			var mid = target.id;
		    var formId = mid.trim()+".rform";
		    var isIE = isc.Browser.isIE;
		    
		    if(isIE){
			    window.clipboardData.setData("Text",formId);
		    
		    }else{
		    	isc.say('该功能仅支持IE浏览器,其他浏览器请选择复制以下内容：<br/>'+formId);
		    }
		
		}
		//复制实体的全路径到粘贴板
		function copyObjectPath(target){
			var ePath = target.entityPath;
			var isIE = isc.Browser.isIE;
			if(isIE){
				if(ePath==null){
					return;
				}
			    window.clipboardData.setData("Text",ePath);
		    
		    }else{		    	
		    	isc.say('该功能仅支持IE浏览器,其他浏览器请选择复制以下内容：<br/>'+ePath);
		    }
		}
		
	//组件编码重命名
	function compRenameId(target){
		
		if(target==null)return;
		var mid = target.id;
		var entityId = target.entityId;
		var type = target.type;
		
		
		MRenameIdDialog.cType = type;
		MRenameIdDialog.srcCompId = mid;
		MRenameIdDialog.refreshNodeId = target.parentId;
		
		var url ="<%=request.getContextPath()%>/refactor/refactorAction_loadRenamePage.action?srcCompId="+mid+"&uuid="+entityId+"&cType="+type;
		
		if(14==type){
			MRenameIdDialog.setTitle("表单编码修改");
		}else if(16==type){
			MRenameIdDialog.setTitle("实体编码修改");
			url = url+"&srcEntityPath="+target.entityPath;
		}
	    MRenameIdDialog.initSrc = url;
		Matrix.showWindow('RenameIdDialog');
	
	
	}
	
	//组件编码重命名	
	function onRenameIdDialogClose(data, oType){
		if(data!=null){
		
			var parentNodeId = MRenameIdDialog.refreshNodeId;
			if("true"==data){
				//修改成功刷新工作台页面
				//parentNodeId
				var src = "<%=request.getContextPath()%>/refactor/refactorAction_loadCallbackPage.action?parentNodeId="+parentNodeId+"&isUpdated=true";
				Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
			
			}else{
				isc.warn("编码修改失败!");
				MRenameIdDialog.refreshNodeId = null;
				MRenameIdDialog.cType = null;
				MRenameIdDialog.srcCompId = null;
				
				return false;
			}
		
		}
		MRenameIdDialog.refreshNodeId = null;
		MRenameIdDialog.cType = null;
		MRenameIdDialog.srcCompId = null;
		return true;
	}
	
	//表单迁移关闭
	function onMigrateDialogClose(data, oType){
		if(data!=null){
		
			var targetModule =isc.JSON.decode(data);
			var targetModuleUuid = targetModule.entityId;
			var srcCompId = MMigrateDialog.srcCompId;
			var cType = MMigrateDialog.cType;
			var srcEntityPath = "";
			var url ="<%=request.getContextPath()%>/refactor/refactorAction_migrateComponent.action";
			var data ={'srcCompId':srcCompId,'cType':cType,'targetModuleUuid':targetModuleUuid};
			
			if(16==cType){
				srcEntityPath = MMigrateDialog.srcEntityPath;
				data.srcEntityPath = srcEntityPath;
				MMigrateDialog.srcEntityPath = null;
			}
			dataSend(data,url,"POST",migrateCompCallback);
			
		}
		 MMigrateDialog.srcCompId = null;
		 MMigrateDialog.cType = null;
		return true;
	}
	
	//迁移回调
	function migrateCompCallback(data){
		var backData = data.data;
		if(backData!=null){
		   var miObject = isc.JSON.decode(backData);
		   var miType = miObject.isMigrate;
		    if("true" ==miType){//迁移成功 刷新目标节点和
		    	var srcNodeId = miObject.srcModule;
		    	var targetNodeId = miObject.targetModule;
		    	if(srcNodeId!=null&&targetNodeId!=null){
		    		var cType = miObject.cType;
		    		if(14==cType){//表单
			    		srcNodeId = srcNodeId+"_form";
			    		targetNodeId = targetNodeId+"_form";
		    		
		    		}else if(16==cType){//实体
			    		srcNodeId = srcNodeId+"_serviceObj";
			    		targetNodeId = targetNodeId+"_serviceObj";
		    		
		    		}else if(17==cType){//流程
			    		srcNodeId = srcNodeId+"_synflow";
			    		targetNodeId = targetNodeId+"_synflow";
		    		
		    		}
		    		//mmm
		    		Matrix.forceFreshTreeNode("Tree0", srcNodeId);
		    		Matrix.forceFreshTreeNode("Tree0", targetNodeId);
		    		//刷新页面
		    		var url ="<%=request.getContextPath()%>/refactor/refactorAction_migrateSuccess.action?type="+cType;
		    		
		    		Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(url);
		    		
		    	}else{
		    		isc.warn('迁移刷新节点异常!');
		    	}
		    
		    }else if("same" ==miType){
				isc.warn('不可以迁移到当前模块!');
			}else{//exception
				isc.warn('迁移时异常!');
			}
		
		
		}
	
	}
	
	//表单迁移
	function migrateComponent(target){
		var type = target.type;
		if(14==type){
			MMigrateDialog.setTitle("表单迁移");
		}else if(16==type){
			MMigrateDialog.srcEntityPath = target.entityPath;
			MMigrateDialog.setTitle("实体迁移");
		}else if(17==type){
			MMigrateDialog.setTitle("流程迁移");
		}
	
		MMigrateDialog.cType = type;
		MMigrateDialog.srcCompId = target.id;
	  	var formUrl ="<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType="+type+"&refactor=true";
	    MMigrateDialog.initSrc = formUrl;
		Matrix.showWindow('MigrateDialog');
	}
	
	
	
	
	
	
//单击节点 and 右键单击
 function forwardPageByNodeType(node){
 	
	//通用服务不可修改
    var isCommonService = commonServiceClickValidate(node.sid);
	     if(isCommonService) 
	     		return false;
	     		
	var nodeType =parseInt(node.type);
    switch(nodeType){
    	case 0://工程目录
    	   // modifyCatalog(node);
    		break;
    	case 1:
    	    modifyCatalog(node);
    		break;
    	case 2:
    		 modifyModule(node);
    		break;
    	case 14://表单
    		var processType = Matrix.getFormItemValue("processType");
    	    var comType = node.comType;//获取组件类型
    	    forwardPage(node,"form/formInfo_loadFormMainPage.action?nodeUuid=treeNode.entityId&type="+comType+"&parentNodeId="+node.parentId+"&processType="+processType);
    	    
    		break;
    	case 15://逻辑服务
    	    var comType = node.comType;//1spring bean,2 java bean,3 js脚本
    	    //isCommon="+node.virtualSid 传递服务模块名称
    	    //参数为mid 与EntityInfo字段对应 comType/parentNodeId 同步刷新节点使用
    	    forwardPage(node,"logic/logicInfo_loadLogicMainPage.action?mid=treeNode.id&comType=treeNode.comType&parentNodeId="+node.parentId+"&isCommon="+node.virtualSid);  
    		break;
    	case 16:
    	    forwardPage(node,"entity/entityInfo_loadMainPage.action?entityPath="+node.entityPath+"&parentNodeId="+node.parentId);  //参数为id 与EntityInfo字段对应
    	    
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
		    		confirmMsg ="Spring逻辑"+target.text;
		    	}else if(comType==2){
		    		confirmMsg ="Java逻辑"+target.text;
		    	}else if(comType==3){
		    		confirmMsg ="JS逻辑"+target.text;
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
	    var durl = "<%=request.getContextPath()%>/catalog_deleteCatalog.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type+"&mid="+target.id;
//	    if(nodeType==17){
//	    	forwardPage(target,durl);
//	    	return;
//	    }
	    
	    isc.confirm('确定要删除'+confirmMsg+'吗?',function(data){//true or null
		      if(data){
				forwardPage(target,durl);
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
	
	
	//添加组件 entityId作为新建节点父节点 parentId 父节点父节点
	function addComponent(target,type,comType){
		var url = "<%=request.getContextPath()%>/catalog_addComponentEntrance.action?entityId="+target.entityId+"&parentId="+target.parentId+"&parentNodeId=treeNode.id&type="+type;
		
		if(type==14){
			url=url+"&entity="+target.entity;
			//业务定制下
			var phase = '<%=curPhase%>';
			if(phase == '4'){
				//业务定制阶段
				var processType = Matrix.getFormItemValue("processType");
				url+="&processType="+processType;
			}
		}
		if(type == 17){//新建协同流程需要传递processType
			var processType = Matrix.getFormItemValue("processType");
			if(processType!=null && processType.length>0){
				url+="&processType="+processType;
			}
		}
		if(type==18){//场景
			url=url+"&soType=add";
		}
		
		
		if(comType!=null){
			url = url+"&comType="+comType;
		}
	   forwardPage(target,url);
		
	}
	
	
	
	
	//修改组件
	function modifyComponent(target){
	   var type = parseInt(target.type);
	  var processType = Matrix.getFormItemValue('processType');
	   if(type==17){//流程
	 	  forwardPage(target,"form/admin/process/mainProcess.jsp?processId=treeNode.id&processTmplId=treeNode.entityId&entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type+"&processType="+processType); 

	   }else if(type==18){//场景
	   	  forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type+"&soType=update");
	   }else{
	   	  forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type);
	   }  
	  

	}
	
	//导入业务对象(数据库表)
	//弹出框 导航 第一页 加载 数据源列表 schema列表
	function importBObject(target){
		var url ="<%=request.getContextPath()%>/entity/importEntity_loadDsList.action?parentUuid="+target.parentId+"&parentNodeId="+target.id;
		MImportBODialog.initSrc = url;
		Matrix.showWindow("ImportBODialog");
		
	}
	
	//导入实体弹出框关闭回调
	function onImportBODialogClose(data, oType){
		if(data!=null){
			var url = "<%=request.getContextPath()%>/entity/importEntity_saveSelectedtables.action";
			dataSend(data,url,"POST",importEntityTableCallback);
		
		}
		
		return true;
	
	}
	//回调函数中 刷新目录节点
	function importEntityTableCallback(data){
	
	}
	
	//验证通用服务,点击节点时 不连接到修改页面
	function commonServiceClickValidate(nodeId){
		var commonArray = ['commonservice','info','process','tool','info_logic','process_logic','tool_logic'];
	    return  commonArray.contains(nodeId);
	
	}
	
	
				
   //指定右键菜单
     function assignNodeMenu(viewer, node, recordNum){
     	 //通用服务不可修改
   		 var isCommonService = commonServiceClickValidate(node.sid);
	     if(isCommonService) 
	     		return false;
	     if(node.type>10){
	     	 isCommonService = commonServiceClickValidate(node.virtualSid);
	     	 if(isCommonService) 
		     	return false;
	     
	     }		
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
				var curPhase = '<%=curPhase%>';
				var nodeMenu = MTreeMenu_FormPage;
				if(curPhase=='4'){
					//业务定制下
					nodeMenu = MTreeMenu_FormPage_custom;
				}
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
				var nodeMenu = MTreeMenu_BOPage;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==17){//流程页
				var curPhase = '<%=curPhase%>';
				var nodeMenu = MTreeMenu_Flow;
				if(curPhase=='4'){
					//业务定制下
					nodeMenu = MTreeMenu_Flow_custom;
				}
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
	function checkRootCode(){
		var rootCode = '<%=request.getAttribute("rootCode")%>';
		var userId = '<%=request.getAttribute("userId")%>';
		Matrix.setFormItemValue('userId',userId);
		if(rootCode!=' '&&rootCode!='null'){
 			Matrix.setFormItemValue('rootCode',rootCode);
 		}
	}
	//授权
	function setSecurity(target){
		var catalogId = target.entityId;
		var url = webContextPath+"/security/formSecurity_loadSecurityIndex.action?catalogId="+catalogId;
		Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(url);
	}
	
	function refreshCurTreeNode(opType,parentNodeId){
			
			if(opType=="add"){
				Matrix.forceFreshTreeNode("Tree0",parentNodeId);
				
			}
	}
	//表单重命名
	function reNameForm(target){
		var nodeUuid = target.entityId; 
		var parentNodeId = target.parentId;
		var url = "<%=request.getContextPath()%>/form/formInfo_getFormBasicMsgPage.action?nodeUuid="+nodeUuid+"&parentNodeId="+parentNodeId+"&phase=4";
		Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(url);
	}
</script>
</head>

<body onload="checkRootCode();">
<jsp:include page="/form/admin/common/loading.jsp" />
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
				contentsURL:"<%=request.getContextPath()%>/form/admin/logon/matrix/welcome.jsp"
				})
			] 
		});
     </script>
<div id="horizontalContainer0Panel0_div2"
	style="width: 100%; height: 100%; overflow: hidden;"
	class="matrixInline">
	<script>

		var MForm0 = isc.MatrixForm.create({
		    ID: "MForm0",
		    name: "MForm0",
		    position: "absolute",
		    action: "<%=request.getContextPath()%>/catalog_manageTree.action?rootCode=<%=request.getAttribute("rootCode")%>",
		    fields: [{
		        name: 'Form0_hidden_text',
		        width: 0,
		        height: 0,
		        displayId: 'Form0_hidden_text_div'
		    }]
		});
	</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/catalog_manageTree.action?rootCode=<%=request.getAttribute("rootCode")%>"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="refreshNode" id="refreshNode" />
	<input type="hidden" name='rootCode' id="rootCode" value="${param.rooCode }" />
	<input type="hidden" name="userId" id="userId" value="${FormValue.userId }"/>
	<input type="hidden" name="processType" id="processType" value="${param.processType}"/>
	<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top :   0; left: 0; display: none;"></div>


<table style="width:100%;height:100%;margin:0px;">
	  
	    	<tr>
				<td height="20px" style="margin:0px;">当前位置>><%=locationLabel%></td>
		    </tr>
		    
			<tr>
				<td>
					<div id="Tree0_div"   class="matrixComponentDiv"
					style="width: 100%; height: 100%; position: relative;">
	
	        		 <script> 
						isc.MatrixTree.create({	
								ID:"MTree0_DS",
						   		modelType:"children",
								ownerType:"tree",
								formId:"Form0",
								autoOpenRoot:true,
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
				//isc.Page.setEvent('load','MTree0_DS.openFolder(MTree0_DS.root)',isc.Page.FIRE_ONCE);
				
				isc.MatrixTreeGrid.create({
						ID:"MTree0",
						name:"Tree0",
						height:"100%",
						width:"100%",
						displayId:"Tree0_div",
						position:"relative",
						cellHeight:25,
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
				
				</td>
			</tr>
		
		
	</table>


		<script>
				//Menu hideContextMenu();手动隐藏该菜单
				//根的右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_Root",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [ 
						{title:"新建子目录",click:"addSubCatalog(target)",icon:Matrix.getActionIcon("add")},
					    {title:"新建模块",click:"addModule(target)",icon:Matrix.getActionIcon("add")},
						//{title:"导出目录",click:"exportContents(target)",icon:Matrix.getActionIcon("save_hd")},
						//{title:"导入目录",click:"importContents(target)",icon:Matrix.getActionIcon("import_hd")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
							//{title:"删除",icon:Matrix.getActionIcon("delete")},
						//	{title:"属性修改",click:"modifyCatalog(target)",icon:Matrix.getActionIcon("edit")}
						 ] 
				});
				
				//lpz------------------------------------------------------------
				
				//根的右键菜单  非admin
				isc.Menu.create({
					ID:"MTreeMenu_Root1",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [ 
						//{title:"新建子目录",click:"addSubCatalog(target)",icon:Matrix.getActionIcon("add")},
						//{title:"导出目录",click:"exportContents(target)",icon:Matrix.getActionIcon("save_hd")},
						//{title:"导入目录",click:"importContents(target)",icon:Matrix.getActionIcon("import_hd")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
							//{title:"删除",icon:Matrix.getActionIcon("delete")},
						//	{title:"属性修改",click:"modifyCatalog(target)",icon:Matrix.getActionIcon("edit")}
						 ] 
				});
				
				//子目录右键菜单  非工程目录作为根节点
				isc.Menu.create({
					ID:"MTreeMenu_SubCatalog1",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [ 
							{title:"新建子目录",click:"addSubCatalog(target)",icon:Matrix.getActionIcon("add")},
						    {title:"新建模块",click:"addModule(target)",icon:Matrix.getActionIcon("add")},
						    {title:"导入模块",click:"showImportDialog(target)",icon:Matrix.getActionIcon("import_hd")},
						    {title:"导出目录",click:"exportContents(target)",icon:Matrix.getActionIcon("save_hd")},
						    {title:"导入目录",click:"importContents(target)",icon:Matrix.getActionIcon("import_hd")},
						    {title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
						    
						  ]
				}); 
				//lpz------------------------------------------------------------
				//子目录右键菜单 工程目录作为根节点
				isc.Menu.create({
					ID:"MTreeMenu_SubCatalog",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [ 
							{title:"新建子目录",click:"addSubCatalog(target)",icon:Matrix.getActionIcon("add")},
						    {title:"新建模块",click:"addModule(target)",icon:Matrix.getActionIcon("add")},
						    //{title:"导入模块",click:"showImportDialog(target)",icon:Matrix.getActionIcon("import_hd")},
						    //{title:"导出目录",click:"exportContents(target)",icon:Matrix.getActionIcon("save_hd")},
						    //{title:"导入目录",click:"importContents(target)",icon:Matrix.getActionIcon("import_hd")},
						    {title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")},
						    {title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						    {title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						    {title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")}
						  ]
				}); 
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
							{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")},
							//{title:"导出模块",click:"showExportDialog(target)",icon:Matrix.getActionIcon("save_hd")}
							//{title:"导入模块",click:"importModule(target)",icon:Matrix.getActionIcon("import")}
							
						] 
					});
				   //表单页右键菜单
				   isc.Menu.create({
					   ID:"MTreeMenu_FormFolder",
					   autoDraw:false,
					   showShadow:true,
					   shadowDepth:10,
					   data: [ 
						     {title:"新建表单",click:"addComponent(target,14)",icon:Matrix.getActionIcon("add")},
						     {title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					   ] 
					});
				//业务对象右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_ServiceObjFolder",
					autoDraw:false,
					showShadow:true,
                    width:165,
					shadowDepth:10
					
					
				});
				
				var dataCommon= [
						{title:"新建基本对象",click:"addComponent(target,16,3)",icon:Matrix.getActionIcon("add")},
						{title:"新建存储对象",click:"addComponent(target,16,1)",icon:Matrix.getActionIcon("add")},
						{title:"新建查询对象",click:"addComponent(target,16,2)",icon:Matrix.getActionIcon("add")},
						{title:"导入存储对象",click:"importBObject(target)",icon:Matrix.getActionIcon("import_hd")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					];
					
				var data4 = [
						{title:"新建存储对象",click:"addComponent(target,16,1)",icon:Matrix.getActionIcon("add")},
						{title:"新建查询对象",click:"addComponent(target,16,2)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					];
					
				var data1 = [
					{title:"新建存储对象",click:"addComponent(target,16,1)",icon:Matrix.getActionIcon("add")},
					{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					];
				
				var curPhase = "<%=curPhase%>";
				if(curPhase=="1"){//需求分析
					MTreeMenu_ServiceObjFolder.setData(data1);
				}else if(curPhase=="4"){//业务定制
					MTreeMenu_ServiceObjFolder.setData(data4);
				}else{
					MTreeMenu_ServiceObjFolder.setData(dataCommon);
				
				}
				
				
				//协同流程右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SynFlowFolder",
				    autoDraw:false,
					showShadow:true,
					autoFitFieldWidths:true,
                    fixedFieldWidths:true,
                    width:165,
					shadowDepth:10,
					data: [
						{title:"新建协同流程",click:"addComponent(target,17)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					]
				});
				//逻辑服务右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_LogicFolder",
					autoDraw:false,
					showShadow:true,
					autoFitFieldWidths:true,
                    fixedFieldWidths:true,
                    width:165,
					shadowDepth:10,
					data: [
						{title:"新建逻辑服务",click:"addComponent(target,15)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)", icon:Matrix.getActionIcon("refresh")}
					] 
				});
				//场景右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SceneFolder",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [
						{title:"新建场景",click:"addComponent(target,18)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					] 
				});
				//组件通用页面
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
				//表单页面右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_FormPage",
						autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"复制路径",click:"copyFormId(target)",icon:Matrix.getActionIcon("copy")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						{title:"重构",click:"",icon:Matrix.getActionIcon("refactor"), submenu: [
					    {title: "迁移",click:"migrateComponent(target)",icon:Matrix.getActionIcon("migrate")},
					    {title: "编码修改",click:"compRenameId(target)",icon:Matrix.getActionIcon("refactor_id")}
					           
					            
					     ]},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)", icon:Matrix.getActionIcon("refresh")}
					   ] 
				});
				//业务定制下的表单右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_FormPage_custom",
						autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"重命名",click:"reNameForm(target)",icon:Matrix.getActionIcon("edit")},
						{title:"复制路径",click:"copyFormId(target)",icon:Matrix.getActionIcon("copy")},
						{title:"授权",click:"setSecurity(target)",icon:Matrix.getActionIcon("auth")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						//{title:"重构",click:"",icon:Matrix.getActionIcon("refactor"), submenu: [
					    //{title: "迁移",click:"migrateComponent(target)",icon:Matrix.getActionIcon("migrate")},
					    //{title: "编码修改",click:"compRenameId(target)",icon:Matrix.getActionIcon("refactor_id")}
					           
					            
					     //]},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)", icon:Matrix.getActionIcon("refresh")}
					   ] 
				});
				//业务对象页面右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_BOPage",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"复制路径",click:"copyObjectPath(target)",icon:Matrix.getActionIcon("copy")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						{title:"重构",click:"",icon:Matrix.getActionIcon("refactor"), submenu: [
					            {title: "迁移",click:"migrateComponent(target)",icon:Matrix.getActionIcon("migrate")},
					            {title: "编码修改",click:"compRenameId(target)",icon:Matrix.getActionIcon("refactor_id")}
					            
					     ]},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)", icon:Matrix.getActionIcon("refresh")}
					   ] 
				});
				
				//流程右键页面
				isc.Menu.create({
					    ID:"MTreeMenu_Flow",
					    autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						{title:"迁移",click:"migrateComponent(target)",icon:Matrix.getActionIcon("migrate")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					] 
				});
				//业务定制下的流程右键页面
				isc.Menu.create({
					    ID:"MTreeMenu_Flow_custom",
					    autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
	//					{title:"迁移",click:"migrateComponent(target)",icon:Matrix.getActionIcon("migrate")},
						{title:"刷新",click:"Matrix.refreshTreeNode(target)",icon:Matrix.getActionIcon("refresh")}
					] 
				});
				
					isc.Window.create({
							ID:"MCatalogTarget",
							id:"CatalogTarget",
							name:"CatalogTarget",
							autoCenter: true,
							position:"absolute",
							height: "500px",
							width: "900px",
							title: "test",
							canDragReposition: true,
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
					
					//表单操作目标弹出框
					isc.Window.create({
							ID:"MFormOperationTarget",
							id:"FormOperationTarget",
							name:"FormOperationTarget",
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
					MFormOperationTarget.hide();
					
					
					
					//导入业务对象
					isc.Window.create({
							ID:"MImportBODialog",
							id:"ImportBODialog",
							name:"ImportBODialog",
							autoCenter: true,
							position:"absolute",
							height: "500px",
							width: "900px",
							title: "导入业务对象",
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
					
					});
					MImportBODialog.hide();
					
					//表单迁移
					isc.Window.create({
							ID:"MMigrateDialog",
							id:"MigrateDialog",
							name:"MigrateDialog",
							autoCenter: true,
							position:"absolute",
							height: "400px",
							width: "300px",
							title: "表单迁移",
							canDragReposition: true,
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
					
					});
					MMigrateDialog.hide();
					
					//组件重命名
					isc.Window.create({
							ID:"MRenameIdDialog",
							id:"RenameIdDialog",
							name:"RenameIdDialog",
							autoCenter: true,
							position:"absolute",
							height: "260px",
							width: "400px",
							title: "编码重构",
							canDragReposition: true,
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
					
					});
					MRenameIdDialog.hide();
					
					
			</script>
			<script>
					isc.Window.create({
						ID:"MDialog0",
						id:"Dialog0",
						name:"Dialog0",
						targetDialog:"CatalogTarget",
						autoCenter: true,
						position:"absolute",
						height: "500",
						width: "900",
						title: "表单授权",
						canDragReposition: false,
						showMinimizeButton:false,
						showMaximizeButton:false,
						showCloseButton:true,
						showModalMask: false,
						modalMaskOpacity:0,
						isModal:true,
						autoDraw: false,
						headerControls:[
							"headerIcon","headerLabel","closeButton"
						]
						
						
					 });
					MDialog0.hide();
					
					//isc.Page.setEvent(isc.EH.LOAD,"initGridList();");
			
	</script>
	</form>
	<script>
	MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
	</script>
</div>
<script>
	document.getElementById('horizontalContainer0Panel0_div').appendChild(document.getElementById('horizontalContainer0Panel0_div2'));
</script>
</body>

</html>



