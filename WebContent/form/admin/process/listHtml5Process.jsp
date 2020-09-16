<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="com.matrix.engine.foundation.domain.PkgTemplateKeyInfoVO,
		java.text.SimpleDateFormat,
		com.matrix.api.MFExecutionService,
   		com.matrix.api.template.PublicationStatus,
   		com.matrix.api.identity.*,
		com.matrix.client.TextUtils,
		com.matrix.form.admin.common.utils.*,
		com.matrix.engine.foundation.config.OrganizationTable,
		com.matrix.engine.foundation.config.MFSystemProperties,
		com.matrix.api.config.RunModeType,
		com.matrix.client.ClientConstants,
		java.util.*,
		com.matrix.form.admin.common.utils.CommonUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href='<%=path %>/resource/html5/css/style.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>

<link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/flat/blue.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/select2.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/clockpicker.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/filecss.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.css'	rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/google-code-prettify/bin/prettify.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/custom.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link rel='stylesheet' href='<%=path %>/resource/html5/themes/default/style.min.css'/>
<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/filejs.js'></SCRIPT>
<link href='<%=path %>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>
<SCRIPT SRC='<%=path %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>

<style>
	#DataGrid001_table th{
		background-color:rgb(181, 219, 235);
	}
	div.e8_expandOrCollapseDiv_tree {
	    height: 39px;
	    width: 10px;
	    z-index: 3;
	}
	div.e8_expandOrCollapseDiv {
	    background-color: #fff;
	    border: medium none;
	    cursor: pointer;
	    height: 48px;
	    left: 450px;
	    line-height: 32px;
	    position: absolute;
	    text-align: center;
	    top: 300px;
	    width: 15px;
	    background-image: url(<%=path %>/form/admin/main/openTree_wev8.png);
	}
</style>
<%
	MFExecutionService mfes = (MFExecutionService)session.getAttribute(ClientConstants.EXECUTION_SERVICE);
	MFUser user = mfes.getMFUser();
	String userId = user.getUserId();
	int releasedType = PublicationStatus.RELEASED_TYPE;
	int underReleasedType = PublicationStatus.UNDER_REVISION_TYPE;
	boolean isAdmin = CommonUtil.isAdmin(mfes);
	
	String sessionId = mfes.getSessionId();
	String contextPath = "";
	if(request.getContextPath() != null && request.getContextPath().trim().length()>0)
		contextPath = 	request.getContextPath().substring(1);

	String url = request.getRequestURL().toString();
	String serverIp = request.getServerName();
	int serverPort = request.getServerPort();
	String params = "";
	params +="serverIp="+serverIp;
	params +="&contextPath="+contextPath;
	params +="&sessionId="+sessionId;
	params +="&userId="+userId;
	params +="&serverPort="+serverPort;
	params +="&simulationType=2&mode=design";
	
	
	// 获得产品模式
	RunModeType modeType = mfes.getMFConfig().getRunModeType();
	boolean isProductMode = false;
	if(modeType.getValue()==RunModeType.PRODUCT_TYPE){
		isProductMode = true;
	}
%>
<script>
	var userId = "<%=userId %>";
	var isAdmin = <%=isAdmin %>;
	var releasedType = <%=releasedType %>;
	var underReleasedType = <%=underReleasedType %>;
	var isProductMode = <%=isProductMode %>;
    
	$(function(){
		if(isProductMode){
			$('#MtoolBarItemCancel').attr('disabled','true');
		}
	});
	//迁移流程
	function upgradeProcess(){
		var selection = Matrix.getGridSelections('DataGrid001');
		if(selection!=null && selection.length>0){
			if(selection.length==1){
				var record = selection[0];
	 			var upgradePkgTmplId = record.pkgTid;
	 			var processId = document.getElementById("processId").value;
	 			document.getElementById("upgradePkgTmplId").value = upgradePkgTmplId;
				var src = "<%=path%>/process/processTmplAction_querySelectedPkgTemplates.action?iframewindowid=selectProcessTmplWindow&upgradePkgTmplId=" + upgradePkgTmplId + "&processId=" + processId +"&selection=" + selection;
			    layer.open({
			    	type:2,
			    	area:['90%','90%'],
			    	title:['选择流程模板'],
			    	content:src
			    });
			}else{
				Matrix.warn("只能选择一条数据迁移");
			}
		}else{
			Matrix.warn("请选择要迁移的流程模板！");
			return false;
		}
	}
	
	//创建流程
	function createProcess(){
		var processType = document.getElementById("processType").value;
	    var action = "<%=path%>/process/processTmplAction_createProcessTmpl.action?processType="+processType;
		document.getElementById("form0").action=action;
		document.getElementById("form0").submit();
	}
	
	//删除流程
	function deleteProcess(){
		var records = Matrix.getGridSelections('DataGrid001');
		if(records==null || records.length==0){
			Matrix.warn("请先选中要删除的流程模板！");
			return false;
		}
		if(records.length>1){
			Matrix.warn("一次只能删除一个流程模板！");
			return false;
		}
		
		var record = records[0];
		if(record.status == 3){
			Matrix.say("已发布流程不能直接删除，请先取消发布！");
			return;
		}	
		Matrix.confirm("确定要删除选择的流程模板吗？",function(value){value=true;if(value){deleteProcessSubmit(record)}});		
	}
	
	
	//删除流程模板
	function deleteProcessSubmit(record){
		if(record.status == 3){
			Matrix.say("已发布流程不能直接删除，请先取消发布！");
			return;
		}	
		var data = {};
		data["pkgTid"]=record.pkgTid;
		var url = "<%=path%>/process/processTmplAction_deleteProcessTmpl.action";
		Matrix.sendRequest(url,data,
			function(response){
				if("true"==response.data){
					Matrix.refreshDataGridData('DataGrid001');
					Matrix.say("删除成功！");
				}else{
					Matrix.warn("删除失败！");
				}
			},
			function(){
				Matrix.warn("删除失败！");
				return false;
			}
		);
	}
	
	//复制流程
	function copyProcess(){
		var records = Matrix.getGridSelections('DataGrid001');
		if(records==null || records.length==0){
			Matrix.warn("请先选中要复制的流程模板！");
			return false;
		}
		var record = records[0];
		document.getElementById("pkgTid").value=record.pkgTid;
		var action = "<%=path%>/process/processTmplAction_copyProcessTmpl.action";
		document.getElementById("form0").action=action;
		document.getElementById("form0").submit();
	}
	
	//编辑流程
	function editProcess(){
		var records = Matrix.getGridSelections('DataGrid001');
		if(records==null || records.length==0){
			Matrix.warn("请先选中要修改的流程模板！");
			return false;
		}
		var record = records[0];
		var processType = Matrix.getFormItemValue("processType");
		designProcess(record.pkgTid);
	}
	
    //设计流程
	function designProcess(pkgTid){
	 	var processType = document.getElementById("processType").value;
		var action = "<%=path%>/process/processTmplAction_designProcess.action?processType="+processType;
		document.getElementById("pkgTid").value=pkgTid;
		document.getElementById("form0").action=action;
		document.getElementById("form0").submit();
	}
    
	//取消发布流程之前
	function cancelPublishedStatus(){
		var selection = Matrix.getGridSelections('DataGrid001');
		if(selection==null || selection.length==0){
			Matrix.warn("请选择要取消发布的流程模板！");
			return false;
		}
		var record = selection[0];
			
		if(record.status!=releasedType){
			Matrix.warn("请选择已经发布的流程模板！");
			return false;
		}
			
		Matrix.confirm("取消发布流程模板将删除所有相关的流程实例数据，是否继续？",function(value){value=true;if(value){cancelPublishedStatusSubmit(record)}});
		return false;
	}
	
	//取消发布流程
	function cancelPublishedStatusSubmit(record){
		var selectedTmplTID = record.pkgTid;
	    var data = {};
		data["selectedTmplTID"] = selectedTmplTID;
		var url = "<%=path%>/process/processTmplAction_cancelPublishedStatus.action";
		Matrix.sendRequest(url,data,
			function(response){
				if("true"==response.data){
					Matrix.refreshDataGridData('DataGrid001');
					Matrix.say("取消发布流程模板成功！");
				}else{
					Matrix.warn("取消发布流程模板失败！");
				}
			},
			function(){
				Matrix.warn("取消发布流程模板失败！");
				return false;
			}
		);
	}
	
	// 仿真
	function simulationProcess(){
		var selection = Matrix.getGridSelections('DataGrid001');
		if(selection==null || selection.length==0){
			Matrix.warn("请选择要仿真的流程模板！");
			return false;
		}
		var record = selection[0];
		var params = "<%=params%>";
	    params = params + "&pkgTid="+record.pkgTid;
		var url = "<%=path%>/form/admin/process/flex/MatrixDesigner.jsp?"+params;
		var iHeight = 700;
		var iWidth = 950;
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  		var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
  		var property = "toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, status=no, width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop;
		window.open( url, "仿真流程", property);
	}

	
	//双击
	function a(row){
		var record = row;
		var processType = Matrix.getFormItemValue("processType");
		designProcess(record.pkgTid);
	}
</script>
</head>
<body>
   <form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;padding-left:6px;padding-right:6px;">
      <div style="display: block">
		  <table class="query_form_content" style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;background-color:rgb(241, 241, 241);margin-top: 2px;">
			    <tr>
			        <td class="query_form_toolbar" colspan="5" style="height: 40px;">
			        	<div style="padding-left: 15px;padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/add.png">
							<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="createProcess();">
						</div>	
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/copy.png">
							<input type="button" value="复制" class="btn  btn-default toolBarItem" id="MtoolBarItemCopy" style="padding:0px;margin:0px;border:0;background: transparent" onclick="copyProcess();" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/edit.png">
							<input type="button" value="编辑" class="btn  btn-default toolBarItem" id="MtoolBarItemEdit" style="padding:0px;margin:0px;border:0;background: transparent" onclick="editProcess();" / >
						</div>
					    <div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/delete.png">
							<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteProcess();" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/exit.png">
							<input type="button" value="撤销发布" class="btn  btn-default toolBarItem" id="MtoolBarItemCancel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="cancelPublishedStatus();" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/preview.png">
							<input type="button" value="迁移" class="btn  btn-default toolBarItem" id="MtoolBarItemCopy" style="padding:0px;margin:0px;border:0;background: transparent" onclick="upgradeProcess();" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/preview.png">
							<input type="button" value="仿真" class="btn  btn-default toolBarItem" id="MtoolBarItemPreview" style="padding:0px;margin:0px;border:0;background: transparent" onclick="simulationProcess();" / >
						</div>
			       </td>
			       <td colspan="1" style="height: 40px;">
			       		<div id="topMenuContr" style="display: inline-block;width: 40px;height: 35px;float: right;position: relative;text-align: center;background-color: #b5dbeb;">
							<div style="padding-top:8px;position:absolute;width:100%;">
							<img src="<%=request.getContextPath()%>/form/admin/main/menu_14.png" width="16px" height="16px" style="vertical-align:middle;" id="closeTop">
						   </div>
						</div>
						<script>
						//点击右侧展开收缩按钮
						$('#topMenuContr').click(function(){
							var width = parent.document.getElementById('HorizontalContainer001Panel1').style.width;
							if(width == '25%'){
								parent.document.getElementById('HorizontalContainer001Panel1').style.display = 'none';
								parent.document.getElementById('HorizontalContainer001Panel1').style.width = '0px';
								parent.document.getElementById('HorizontalContainer001Panel1').nextElementSibling.style.width = '100%';
								parent.document.getElementById('HorizontalContainer001Panel1').nextElementSibling.style.marginLeft = '0px';
							}else{	
								parent.document.getElementById('HorizontalContainer001Panel1').nextElementSibling.style.width = 'calc(100% - 25%)';
								parent.document.getElementById('HorizontalContainer001Panel1').nextElementSibling.style.marginLeft = '25%'						
								parent.document.getElementById('HorizontalContainer001Panel1').style.width = '25%';
								parent.document.getElementById('HorizontalContainer001Panel1').style.display = '';
							}
						});
						</script>
			       </td>
			     </tr>
		 </table>
	</div>
	<div style="display: block;padding-top:1px;">
		<table id="DataGrid001_table" style="width:100%;height:100%;">
		</table>
			
		<script>
			$(document).ready(function() { 
				var processId = document.getElementById('processId').value;
				var processType = document.getElementById('processType').value;
				
				$("#DataGrid001_table").bootstrapTable({           
					classes: 'table table-hover',
					method: "post", 
					url: "<%=path%>/process/processTmplAction_queryProcessList.action?processId="+processId+"&processType="+processType, 
					search: false, 
					sidePagination: "server", clickToSelect: true, sortable: false,   
					onDblClickRow:function(row){
						a(row);
					},
					formatLoadingMessage: function() {
			            return '请稍等，正在加载中...';
				    },
					formatNoMatches: function() {
			            return '无符合条件的记录';
			        },
				    columns: [{checkbox:true},
				        {title:"名称",field:"PACKAGE_NAME",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"版本",field:"RH_VERSION",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"最后更新时间",field:"PKG_SUBMIT_TIME",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"状态",field:"RH_PUB_STATUS",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"当前操作人",field:"PACKAGE_OWNER",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"最后更新人",field:"PKG_SUBMIT_ID",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    ],
				    singleSelect:true });
				  });
		</script>
	</div>
	 <input type="hidden" id="processId" name="processId" value="${param.processId}">
	 <input type="hidden" id="pdid" name="pdid" value="${param.processId}">
	 <input type="hidden" id="processType" name="processType" value="${param.processType}">
	 <input type="hidden" id="pkgTid" name="pkgTid" value="">
	 <input type="hidden" id="upgradePkgTmplId" name="upgradePkgTmplId">
  </form>
  <SCRIPT SRC='<%=path %>/resource/html5/js/jquery.inputmask.bundle.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/icheck.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/select2.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/content.min.js'></SCRIPT>
<script src='<%=path %>/resource/html5/js/layer.min.js'></script>
<SCRIPT SRC='<%=path %>/resource/html5/js/autosize.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/clockpicker.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.hotkeys/jquery.hotkeys.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/css/google-code-prettify/src/prettify.js'></SCRIPT>
<SCRIPT SRC='<%=path %>/resource/html5/js/validator.js'></SCRIPT>
<script src='<%=path %>/resource/html5/js/jstree.min.js'></script>
<script src='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>
</body>
</html>