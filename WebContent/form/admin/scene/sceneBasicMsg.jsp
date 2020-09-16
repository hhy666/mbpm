<%@ page language="java" import="java.util.*,com.matrix.form.util.CommonUtil" pageEncoding="UTF-8"%>
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>场景基本信息</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<%  
		boolean isZR = CommonUtil.isZR();
%>
<script type="text/javascript">
		//初始页面
		function initPage(){
			var soType = "${param.soType}";
			
			var sceneId = "${catalogNode.mid}";
			var definedId = Matrix.getMatrixComponentById("definedId");
			if(soType=="update"){
				definedId.setDisabled(true);
			}
			if((definedId.getValue()!=null && definedId.getValue().trim().length>0) || soType=="update"){
				//更新时显示编码
				document.getElementById("Form0").action = "<%=request.getContextPath()%>/catalog_updateCatalogNode.action";
				//更新时设置导航超链接
				
				var basicLinkUrl = "#";
				var objLinkUrl = "<%=request.getContextPath() %>/scene/scene_preLoadSceneEntity.action?sceneId="+sceneId+"&soType="+soType;
				var formLinkUrl= "<%=request.getContextPath() %>/scene/scene_loadSceneFormDesigner.action?sceneId="+sceneId+"&soType="+soType;
				var processLinkUrl = "<%=request.getContextPath() %>/scene/scene_loadSceneFlow.action?sceneId="+sceneId+"&soType="+soType;
				var authLinkUrl = "<%=request.getContextPath() %>/scene/scene_loadSceneAuthorize.action?sceneId="+sceneId+"&soType="+soType;
				
				
				document.getElementById("sceneBasicLink").href = basicLinkUrl;
				document.getElementById("sceneObjLink").href = objLinkUrl;
				document.getElementById("sceneFormLink").href = formLinkUrl;
				document.getElementById("sceneProcessLink").href = processLinkUrl;
				document.getElementById("sceneAuthLink").href = authLinkUrl;
				
				
			}
		}


</script>

<style type="text/css">



.scene_undo{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/undo-middle.png);
	background-repeat: repeat-x;
	width:150px;
	height:25px;
	text-align:center;
	vertical-align:middle;
	text-decoration: none;
	cursor:hand;
	
}

.scene_undo_right{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/undo-right.png);
	background-repeat: no-repeat;
	width:30px;
	height:25px;
	text-align:center;
	vertical-align:middle;
	text-decoration: none;
	cursor:hand;
	
}
.scene_doing{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/doing.png);
	background-repeat: no-repeat;
	width:148px;
	height:25px;
	text-align:center;
	vertical-align:middle;
	cursor:hand;
	
}

.scene_doed{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/doed-middle.png);
	width:150px;
	height:17px;
	text-align:center;
	vertical-align:middle;
	text-decoration: none;
	cursor:hand;
}

.scene_doed_left{
	background: url(<%= request.getContextPath()%>/matrix/resource/images/scene/doed-left.png);
	background-repeat: no-repeat;
	width:30px;
	height:17px;
	text-align:right;
	vertical-align:middle;
	text-decoration: none;
	
}
.scene_undo a,.scene_doed a{
	text-decoration: none;
}
.scene_doing a{
	text-decoration: none;
	color:#FFFFFF;
}


</style>
</head>

<body onload="initPage()">
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%;">
<script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "<%=request.getContextPath() %>/catalog_addComponent.action",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath() %>/catalog_addComponent.action?soType=${param.soType}"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" /> <input id="tenantId" type="hidden"
	name="tenantId" value="${catalogNode.tenantId}" /> <input id="phase"
	type="hidden" name="phase" value="${catalogNode.phase}" /> <input
	id="createdUser" type="hidden" name="createdUser"
	value="${catalogNode.createdUser}" /> <input id="createdDate"
	type="hidden" name="createdDate" value="${catalogNode.createdDate}" />

<input id="parentId" type="hidden" name="parentId"
	value="${catalogNode.parentUuid}" /> <input id="parentUuid"
	type="hidden" name="parentUuid" value="${catalogNode.parentUuid}" /> <input
	id="isPublic" type="hidden" name="isPublic"
	value="${catalogNode.isPublic}" /> <input id="type" type="hidden"
	name="type" value="${catalogNode.type}" /> <input id="mid"
	type="hidden" name="mid" value="${catalogNode.mid}" /> <input id="uuid"
	type="hidden" name="uuid" value="${catalogNode.uuid}" /> <input
	id="parentNodeId" type="hidden" name="parentNodeId"
	value="${requestScope.parentNodeId}" /> <input id="actionType"
	type="hidden" name="actionType" value="${requestScope.actionType}" /> <input
	id="soType" type="hidden" name="soType" value="${param.soType}" />


<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
</div>

<table id="table0css" jsId="table0css" class="maintain_form_content"
	style="width: 100%; height: 100%">
	<tr id="j_id2" jsId="j_id2">
		<td style="height: 30px;padding-left:5px;padding-top:2px;" >
			<table style="border-collapse:collapse;">
				<tr>
				<td class="scene_doing"><a id="sceneBasicLink">基本信息</a></td>
				<td class="scene_undo"><a id="sceneObjLink">对象设计</a></td>
				<td class="scene_undo"><a id="sceneFormLink" >表单设计</a></td>
				<td class="scene_undo"><a id="sceneProcessLink" >流程设计</a></td>
				<td class="scene_undo"><a id="sceneAuthLink" >表单授权</a></td>
				<td class="scene_undo_right"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr id="j_id5" jsId="j_id5" height="100%">
		<td id="j_id6" jsId="j_id6">
		<table id="table0css" jsId="table0css" class="maintain_form_content"
			cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
			<tr id="j_id2" jsId="j_id2">
				 <td style="width: 160px;">
					<table style="border-collapse:collapse;border-spacing:0px;border:0;height: 100%; width: 100%;">
						<tr><td style="height:50px;background-image: url(<%= request . getContextPath() %>/matrix/resource/images/scene/title.jpg);"></td></tr>
						<tr><td style="background-image: url(<%= request . getContextPath() %>/matrix/resource/images/scene/bg.jpg);"></td></tr>
						<tr><td style="height:200px;background-image: url(<%= request . getContextPath() %>/matrix/resource/images/scene/logo.jpg);"></td></tr>
					</table>
				</td>

				<td colspan="1" style="vertical-align: top">

				<table id="basicContent" jsId="basicContent"
					class="maintain_form_content">
					<tr id="j_id4" jsId="j_id4">
						<td id="j_id5" jsId="j_id5" class="maintain_form_label"
							colspan="1" rowspan="1" style="width: '20%'"><label
							id="j_id6" name="j_id6" style="margin-left: 10px"> 编码：</label></td>
						<td id="j_id7" jsId="j_id7" class="maintain_form_input"
							colspan="1" rowspan="1">
						<div id="definedId_div" eventProxy="MForm0" class="matrixInline"
							style="float: left;"></div>
						<script>
						 var definedId=isc.TextItem.create({
						  	ID:"MdefinedId",
						  	name:"definedId",
						  	editorType:"TextItem",
						  	displayId:"definedId_div",
						  	position:"relative",
						  	value:"${catalogNode.mid}",
						  	width:290,
						  	validators:[{
					      		    type:"custom",
					      		    condition:function(item, validator, value, record){
					      		        return  componentIdValidate(item, validator, value, record);
					      		     },
					      		     errorMessage:"编码不能为空!"
					      		 }]
						 });
					 MForm0.addField(definedId);
					</script> <span id="MultiLabel0"
							style="width: 19px; height: 20px; color: #FF0000">*</span> <span
							id="idEchoMessage" style="color: #FF0000">${idEchoMessage}</span>
						</td>
					</tr>
					<tr id="j_id9" jsId="j_id9">
						<td id="j_id10" jsId="j_id10" class="maintain_form_label"
							colspan="1" rowspan="1" style="width: '20%'"><label
							id="j_id11" name="j_id11" style="margin-left: 10px"> 名称：</label></td>
						<td id="j_id12" jsId="j_id12" class="maintain_form_input"
							colspan="1" rowspan="1">
						<div id="name_div" eventProxy="MForm0" class="matrixInline"
							style="float: left;"></div>
						<script> 
						var name2=isc.TextItem.create({
							ID:"Mname",
							name:"name",
							editorType:"TextItem",
							displayId:"name_div",
							position:"relative",
							width:290,
							value:"${catalogNode.name}",
							validators:[{
					      		    	type:"custom",
					      		    	condition:function(item, validator, value, record){
					      		         	return inputNameValidate(item, validator, value, record);
					      		         },
					      		         errorMessage:"名称不能为空!"
					      		 	}]
						});
						MForm0.addField(name2);
					</script> <span id="MultiLabel1"
							style="width: 19px; height: 20px; color: #FF0000">*</span> <span
							id="nameEchoMessage" style="color: #FF0000">${nameEchoMessage}</span>
						</td>
					</tr>
					
					<tr id="tmplScenTr">
					<td class="maintain_form_label"
							colspan="1" rowspan="1" style="width: '20%'"><label
							style="margin-left: 10px"> 场景模板：</label></td>
					 <td class="maintain_form_input" colspan="1" rowspan="1">
                            <div id="tmplSceneName_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                            </div>
                            <input type="hidden" name="tmplSceneUuid" id="tmplSceneUuid" value="${catalogNode.tmplSceneUuid}">
                            <script>
                            	function selectTmplScene(){
									//选场景
					        		MDialog3.initSrc="<%=request.getContextPath()%>/form/admin/foundation/selectCatalogNode.jsp?componentType=18";
					        		Matrix.showWindow("Dialog3");
					        	}
                                var tmplSceneName = isc.TextItem.create({
                                    ID: "MtmplSceneName",
                                    name: "tmplSceneName",
                                    editorType: "TextItem",
                                    displayId: "tmplSceneName_div",
                                    position: "relative",
                                    canEdit:false,
                                    width:290
                                });
                                MForm0.addField(tmplSceneName);
                            	//选场景
                                isc.ImgButton.create({
                                    ID: "MCommandButtonFlow",
                                    name: "CommandButtonFlow",
                                    showDisabled: false,
                                    showDisabledIcon: false,
                                    showDown: false,
                                    showDownIcon: false,
                                    showRollOver: false,
                                    showRollOverIcon: false,
                                    position: "relative",
                                    width: 18,
                                    height: 18,
                                    autoDraw:${param.soType!='update'},
                                    src:Matrix.getActionIcon("query")
                                });
                                MCommandButtonFlow.click = function() {
                                    Matrix.showMask();
                                    selectTmplScene();
                                    Matrix.hideMask();
                                }
                                function getParamsForDialog3() {
                                    var params = 'iframewindowid=Dialog3&';
                                    var value;
                                    return params;
                                };
                                isc.Window.create({
                                    ID: "MDialog3",
                                    id:"Dialog3",
                                    name:"Dialog3",
                                    autoCenter: true,
                                    position: "absolute",
                                    height: 400,
                                    width: 300,
                                    title: "选择场景",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"]
                                });
                                MDialog3.hide();
                                
					        	function onDialog3Close(data, oType){
					        		if(data!=null){
					        			var pdJson = isc.JSON.decode(data);
					        			var tmplSceneName = Matrix.getMatrixComponentById("tmplSceneName");
					        			tmplSceneName.setValue(pdJson.text);
					        			document.getElementById("tmplSceneUuid").value=pdJson.entityId;
					        			return true;
					        		}
					        	}
                            </script>
                        </td>
                        </tr>

					<tr id="j_id20" jsId="j_id20">
						<td id="j_id21" jsId="j_id21" class="maintain_form_label"
							colspan="1" rowspan="1" style="width: '20%'"><label
							id="j_id22" name="j_id22" style="margin-left: 10px"> 描述：</label></td>
						<td id="j_id23" jsId="j_id23" class="maintain_form_input"
							colspan="1" rowspan="1">
						<div id="desc_div" eventProxy="MForm0" class="matrixInline"
							style="float: left;"></div>
						<script> 
						var desc=isc.TextAreaItem.create({
							ID:"Mdesc",
							name:"desc",
							editorType:"TextAreaItem",
							displayId:"desc_div",
							position:"relative",
							value:"${catalogNode.desc}",
							width:290
						});
						MForm0.addField(desc);
					</script></td>
					</tr>
					<script>
						var isZR = "<%=isZR%>";
						if(isZR=="true" || "update"=="${actionType}"){
								document.getElementById('tmplScenTr').style.display="none";
						}
						</script>


				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>

	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" style="height: 28px;" rowspan="1"><script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem3",
                                    icon:Matrix.getActionIcon("left"),
                                    title: "上一步",
                                    disabled:true,
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem3.click = function() {
                                    Matrix.showMask();
                                   
                                    Matrix.hideMask();
                                }
                            </script> <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem4",
                                    icon:Matrix.getActionIcon("right"),
                                    title: "下一步",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem4.click = function() {//同时保存
                                    Matrix.showMask();
                                    
                                   	//处理mid显示值
                                   	var definedId = Matrix.getMatrixComponentById("definedId");
                                   	
                                    if(!definedId.isDisabled()){//可用时(添加)
                                    	document.getElementById("mid").value = definedId.getValue();
                                    }
                                   
                                    if (!MForm0.validate()) {
                                        Matrix.hideMask();
                                        return false;
                                    }
                                   
                                    Matrix.convertFormItemValue('Form0');
                                    document.getElementById('Form0').submit();
                                    Matrix.hideMask();
                                }
                            </script>

		<div id="ToolBar0_div"
			style="width: 100%; overflow: hidden; height: 28px;"><script>
                                    isc.ToolStrip.create({
                                        ID: "MToolBar0",
                                        displayId: "ToolBar0_div",
                                        width: "100%",
                                        height: "*",
                                        position: "relative",
                                        align: "right",
                                         members: [MToolBarItem3, "separator", MToolBarItem4]
                                    });
                                    isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                </script></div>
		</td>
	</tr>
</table>


</form>
<script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script></div>
</body>

</html>