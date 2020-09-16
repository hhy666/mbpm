<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.matrix.engine.foundation.config.MFSystemProperties"%>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="
		java.text.SimpleDateFormat,
		com.matrix.api.MFExecutionService,
   		com.matrix.api.identity.*,
		com.matrix.client.ClientConstants,
		java.util.*"%>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在此处插入标题</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />

<script>

	function infoMsg(message){
		
		 layer.msg(message, {icon: 1});
	}
	
	function warnMsg(message){
		
		 layer.msg(message, {icon: 0});
	}
	
	function confirmMsg(message,callback,properties){
		// callback param is result
		// properties eg: { buttons : [Dialog.OK, Dialog.CANCEL] }
		//isc.confirm(message,callback,properties);
		if(properties!=null&&properties!=""){
			//layer.confirm( message,{  time: 0,properties,yes:function (index) {layer.close(index);callback()},no:function (index){Matrix.hideMask();return false;}});
		}else{
			layer.confirm( message,{  time: 0,btn: ['确定', '取消'],yes:function (index) {layer.close(index);callback()},no:function (index){Matrix.hideMask2();return false;}});
		}
	}
	
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>
<% 
MFExecutionService mfes = (MFExecutionService)session.getAttribute(ClientConstants.EXECUTION_SERVICE);

MFUser user = mfes.getMFUser();
String userId = user.getUserId();
String sessionId = mfes.getSessionId();

String contextPath = request.getContextPath().substring(1);
	//String serverIp = request.getLocalAddr();
String url = request.getRequestURL().toString();
//String serverIp = url.substring(url.indexOf("//")+2,url.indexOf(":",url.indexOf("//"))); 
String serverIp = request.getServerName();
int serverPort = request.getServerPort();
String params = "";
params +="serverIp="+serverIp;
params +="&contextPath="+contextPath;
params +="&sessionId="+sessionId;
params +="&userId="+userId;
params +="&serverPort="+serverPort;
params +="&simulationType=2&mode=design";
%>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/process/processTmplAction_queryPkgTemplates.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
	<input type="hidden" name="Form0" value="Form0" /> 
	<input type="hidden" id="processId" name="processId" value="${param.processId}">
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid0">
	<input type="hidden" id="upgradePkgTmplId" name="upgradePkgTmplId">
	<input type="hidden" id="processType" name="processType" value="${param.processType}">
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${iframewindowid}">
<table id="dataTable" jsId="dataTable" cellpadding="0px"
	cellspacing="0px" style="width: 100%; height: 100%;">
	<tr id="j_id2" jsId="j_id2">
		<td id="j_id4" jsId="j_id4" class="query_form_toolbar" rowspan="1" style="border-style: none;">
				<script>
					isc.ToolStripButton.create({
							ID:"MToolBarItem1",
							icon:Matrix.getActionIcon("add"),
							title: "创建",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	createProcess();
							}
					 });
					 
					 isc.ToolStripButton.create({
							ID:"MToolBarItem11",
							icon:Matrix.getActionIcon("copy"),
							title: "复制",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	copyProcess();
							}
					 });
					 
					 isc.ToolStripButton.create({
							ID:"MToolBarItem_edit",
							icon:Matrix.getActionIcon("edit"),
							title: "编辑",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	editProcess();
							}
					 });
					 
					isc.ToolStripButton.create({
							ID:"MToolBarItem2",
							icon:Matrix.getActionIcon("delete"),
							title: "删除",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
							 	deleteProcess();
							}
					 });
					 isc.ToolStripButton.create({
				    	ID:"MToolBarItem3",
				    	icon:Matrix.getActionIcon("exit"),
				    	title: "撤销发布",
				    	showDisabledIcon:false,
				    	showDownIcon:false,
							click:function(){
								cancelPublishedStatus();
							}
				     });
				     isc.ToolStripButton.create({
							ID:"MToolBarItem4",
							icon:Matrix.getActionIcon("copy"),
							title: "迁移",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
								upgradeProcess();
							}
					 });
			         isc.ToolStripButton.create({
			        		ID:"MToolBarItem5",
			        		icon:Matrix.getActionIcon("preview"),
			        		title: "仿真",
			        		showDisabledIcon:false,
			        		showDownIcon:false,
							click:function(){
								simulationProcess();
							}
			         });
			         isc.ToolStripButton.create({
							ID:"MToolBarItem6",
							icon:Matrix.getActionIcon("add"),
							title: "置为最新版",
							showDisabledIcon:false,
							showDownIcon:false,
							click:function(){
								Matrix.showWindow("NewProcessTmplWindow")
							}
					 });
			         /*
			         isc.ToolStripButton.create({
			        		ID:"MToolBarItem6",
			        		icon:Matrix.getActionIcon("import_hd"),
			        		title: "导入",
			        		showDisabledIcon:false,
			        		showDownIcon:false,
							click:function(){
								importBPMN();
							}
			         });
			         */
			     	</script> 
			<div id="j_id5_div" style="width: 100%; height: 30px; overflow: hidden;">
				<script>
		    		   	isc.ToolStrip.create({
		    		   		ID:"Mj_id5",
		    		   		displayId:"j_id5_div",
		    		   		width: "100%",
		    		   		height: "*",
		    		   		position: "relative",members: [ 
		    		   				MToolBarItem1,
		    		   				"separator",
		    		   				MToolBarItem11,
		    		   				"separator",
		    		   				MToolBarItem_edit,
		    		   				"separator",
		    		   				MToolBarItem2,
		    		   				"separator",
		    		   				MToolBarItem3,
		    		   				"separator",
		    		   				MToolBarItem4,
		    		   				"separator",
		    		   				MToolBarItem5,
		    		   				"separator",
		    		   				MToolBarItem6
		    		   				
		    		   		 ] });
		    		   		 isc.Page.setEvent(isc.EH.RESIZE,"Mj_id5.resizeTo(0,0);Mj_id5.resizeTo('100%','100%');",null);
    		  	 </script>
		 	</div>
		</td>

	</tr>

	<tr id="j_id7" jsId="j_id7">
		<td id="j_id9" jsId="j_id9" rowspan="1"
			style="border-style: none; width: 100%;">
			<div id="DataGrid0_div" class="matrixComponentDiv"
				style="width: 100%; height: 100%;">
				<script>
					var gridData = eval(${pkgTmpls}); 
					isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:true,
						displayId:"DataGrid0_div",
						position:"relative",
						width:"100%",
						height:"100%",
						fields:[
						  {title:"名称",	name:"PACKAGE_NAME"},
						  {title:"版本",name:"RH_VERSION"},
						  {title:"最后更新时间",name:"PKG_SUBMIT_TIME"},
						  {title:"状态",name:"RH_PUB_STATUS" },
						  {title:"当前操作人", name:"PACKAGE_OWNER"},
						  {title:"最后更新人",name:"PKG_SUBMIT_ID"}
						],
						data:gridData,
						autoFetchData:true,
						alternateRecordStyles:true,
						canAutoFitFields:false,
						canEdit:false,
						selectionType: "single",
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
		                     //设计流程
		                     designProcess(record.pkgTid);
		                }
					});
					//isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			 		
			 		//设计流程
			 		function designProcess(pkgTid){
			 			parent.designProcess(pkgTid);
			 			
			 		}
			 		
			 		//创建流程
			 		function createProcess(){
			 			parent.createProcess();
			 		}
			 		
			 		//复制流程 
			 		function copyProcess(){
			 			var records = MDataGrid0.getSelection();
			 			if(records==null || records.length==0){
			 				warnMsg("请先选中要复制的流程模板！");
			 				return false;
			 			}
			 			var record = records[0];
			 			parent.copyProcess(record.pkgTid);
			 		
			 		}
			 		
			 		//导入BPMN 
			 		function importBPMN(){
			 			parent.importBPMN();
			 		}
			 		
			 		function editProcess(){
			 			var records = MDataGrid0.getSelection();
			 			if(records==null || records.length==0){
			 				warnMsg("请先选中要修改的流程模板！");
			 				return false;
			 			}
			 			var record = records[0];
			 			var processType = Matrix.getFormItemValue("processType");
			 			parent.designProcess(record.pkgTid);
			 		}
			 		
			 		//删除流程
			 		function deleteProcess(){
			 			var records = MDataGrid0.getSelection();
			 			if(records==null || records.length==0){
			 				warnMsg("请先选中要删除的流程模板！");
			 				return false;
			 			}
			 			if(records.length>1){
			 				warnMsg("一次只能删除一个流程模板！");
			 				return false;
			 			}
			 			var record = records[0];
			 			
			 			if(record.status == 3){
			 				infoMsg("已发布流程不能直接删除，请先取消发布！");
			 				return;
			 			}	
			 			
			 			if(parent.validateDeleteProcess(record)){
			 				isc.confirm("确定要删除选择的流程模板吗？",function(value){if(value){deleteProcessSubmit(record)}});
			 			}else{
  							warnMsg("您无权删除的流程模板！");
  							return false;
			 			}
			 		}
			 		
			 		//删除流程模板
			 		function deleteProcessSubmit(record){
			 			if(record.status == 3){
			 				infoMsg("已发布流程不能直接删除，请先取消发布！");
			 				return;
			 			}	
			 			var data = {};
			 			data["pkgTid"]=record.pkgTid;
			 			var url = webContextPath+"/process/processTmplAction_deleteProcessTmpl.action";
						Matrix.sendRequest(url,data,
							function(response){
								if("true"==response.data){
									MDataGrid0.removeSelectedData();
	  								infoMsg("删除成功！");
								}else{
	  								warnMsg("删除失败！");
								}
							},
							function(){
	  							warnMsg("删除失败！");
	  							return false;
							}
						);
			 		}
			 		
			 		//迁移流程模板实例
			 		function upgradeProcess(){
			 			var selection = MDataGrid0.getSelection();
			 			if(selection==null || selection.length==0){
			 				warnMsg("请选择要迁移的流程模板！");
			 				return false;
			 			}
			 			var record = selection[0];
			 			var upgradePkgTmplId = record.pkgTid;
			 			var processId = document.getElementById("processId").value;
			 			document.getElementById("upgradePkgTmplId").value = upgradePkgTmplId;
						/* var src = webContextPath+"/process/processTmplAction_querySelectedPkgTemplates.action?upgradePkgTmplId=" + upgradePkgTmplId + "&processId=" + processId +"&selection=" + selection;
					    MselectProcessTmplWindow.initSrc = src;
					    Matrix.showWindow("selectProcessTmplWindow"); */
					    layer.open({
					    	type:2,
							title:["选择流程模板"],
							area:['60%','60%'],
							content:webContextPath+"/process/processTmplAction_querySelectedPkgTemplates.action?upgradePkgTmplId=" + upgradePkgTmplId + "&processId=" + processId +"&selection=" + selection
					    });
			 		}
			 		/* function onselectProcessTmplWindowClose(data){
			 			if(data!=null){
			 				var targetPkgTmplId = data.pkgTid;
				 			var data = {};
				 			data["upgradeTargetPkgTmplId"] = targetPkgTmplId;
				 			data["upgradePkgTmplId"] = document.getElementById("upgradePkgTmplId").value;
				 			document.getElementById("upgradePkgTmplId").value = "";
				 			var url = webContextPath+"/process/processTmplAction_upgradePkgTmpl.action";
							Matrix.sendRequest(url,data,
								function(response){
									if("true"==response.data){
		  								infoMsg("迁移流程模板成功！");
									}else{
		  								warnMsg("迁移流程模板失败！");
									}
								},
								function(){
		  							warnMsg("迁移流程模板失败！");
		  							return false;
								}
							);
			 			}
			 			return true;
			 		} */
			 		
			 		// 取消发布流程
					function cancelPublishedStatus(){
						var userId = parent.userId;;
						var releasedType = parent.releasedType;
						var isAdmin = parent.isAdmin;
						var selection = MDataGrid0.getSelection();
			 			if(selection==null || selection.length==0){
			 				warnMsg("请选择要取消发布的流程模板！");
			 				return false;
			 			}
			 			var record = selection[0];
			 			
			 			if(record.status!=releasedType){
			 				warnMsg("请选择已经发布的流程模板！");
			 				return false;
			 			}
			 			
			 			isc.confirm("取消发布流程模板将删除所有相关的流程实例数据，是否继续？",function(value){if(value){cancelPublishedStatusSubmit(record)}});
						return false;
					}
					
					function cancelPublishedStatusSubmit(record){
						var selectedTmplTID = record.pkgTid;
					    var data = {};
			 			data["selectedTmplTID"] = selectedTmplTID;
			 			var url = webContextPath+"/process/processTmplAction_cancelPublishedStatus.action";
						Matrix.sendRequest(url,data,
							function(response){
								if("true"==response.data){
									//更改状态
									var selection = MDataGrid0.getSelection();
									if(selection!=null&&selection.length>0){
										var record = selection[0];
										record.RH_PUB_STATUS = "未发布";
										record.status = parent.underReleasedType;
										MDataGrid0.refreshFields();
										
									}
	  								infoMsg("取消发布流程模板成功！");
								}else{
	  								warnMsg("取消发布流程模板失败！");
								}
							},
							function(){
	  							warnMsg("取消发布流程模板失败！");
	  							return false;
							}
						);
					}
			 		
			 		// 仿真
					function simulationProcess(){
						var selection = MDataGrid0.getSelection();
			 			if(selection==null || selection.length==0){
			 				warnMsg("请选择要仿真的流程模板！");
			 				return false;
			 			}
			 			var record = selection[0];
		var params = "<%=params%>";
						//var params = parent.simulationParams;
					    params = params + "&pkgTid="+record.pkgTid;
						var url = webContextPath+"/form/admin/process/flex/MatrixDesigner.jsp?"+params;
						var iHeight = 700;
						var iWidth = 950;
						var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
				  		var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
				  		var property = "toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, status=no, width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop;
						window.open( url, "仿真流程", property);
					}
			 		
<%
//如果当前为产品模式，不能取消发布
int runModeType = MFSystemProperties.getInstance().getRunModeType().getValue();
if(runModeType == 2)
{
%>			 		
MToolBarItem3.disable();
<%
}
%>
			 	
				</script>
			</div>
		</td>
	</tr>
</table>
</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
	
	//选择流程模板窗口
	isc.MatrixWindow.create({
	    ID: "MselectProcessTmplWindow",
	    id:"selectProcessTmplWindow",
	    name:"selectProcessTmplWindow",
	    title: "选择流程模板",
	    autoCenter: true,
	    width:860,
	    height:550,
	    isModal: true,
	    showModalMask: true,
	    autoDraw: false,
	    showMinimizeButton:false,
	    src:""
	});
	
	isc.MatrixWindow.create({
	    ID: "MNewProcessTmplWindow",
	    id:"NewProcessTmplWindow",
	    name:"NewProcessTmplWindow",
	    title: "置为最新版",
	    autoCenter: true,
	    width:660,
	    height:250,
	    isModal: true,
	    showModalMask: true,
	    autoDraw: false,
	    showMinimizeButton:false,
	    src:webContextPath+"/process/processTmplAction_processNewVersion.action"
	});
	
	
</script>
</body>
</html>