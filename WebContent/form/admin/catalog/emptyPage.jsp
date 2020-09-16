<%@ page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="commonj.sdo.DataObject"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>	
<script type="text/javascript">
	function onDialog0Close(data){
		if(data!=null){
			if(data.statusMessage!=null && data.statusMessage.length>0){
				Matrix.warn(data.statusMessage);
				return;
			}	
			var importType = data.importType;
		
			var uuid = Matrix.getFormItemValue('uuid');
			var treeId = Matrix.getFormItemValue('treeId');
			var rootCode = Matrix.getFormItemValue('rootCode');
			var parentNodeId = Matrix.getFormItemValue('parentNodeId');
			//if(rootCode!='root'&&rootCode!=''&&rootCode!='null'){
			//	parent.Matrix.forceFreshTreeNode("Tree0", rootCode);
			//}else{
			//	if(importType!=null&&importType.length>0){
					//刷新树
					parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
					//Matrix.say("操作成功!");
			///	}
			//}
		
		}
	}
	function showWindow(){
		var contentFlag = Matrix.getFormItemValue('contentFlag');
		var flag = Matrix.getFormItemValue('flag');
		var uuid = Matrix.getFormItemValue('uuid');
		var mid = Matrix.getFormItemValue('mid');
		var parentNodeId = Matrix.getFormItemValue('parentNodeId');
		var treeId = Matrix.getFormItemValue('treeId');
		
		if(flag=='import'){//导入时选择导入模式  替换/覆盖
			MDialog0.initSrc = "<%=request.getContextPath()%>/form/admin/catalog/selectFile.jsp?uuid="+uuid+"&mid="+mid+"&iframewindowid=Dialog0&contentFlag="+contentFlag+"&parentNodeId="+parentNodeId;
			MDialog0.setTitle('选择文件');
			Matrix.showWindow('Dialog0');
		}else if(flag=='export'){//导出时选择导出的模式   所有版本/最新版本
			MDialog0.initSrc = "<%=request.getContextPath()%>/form/admin/catalog/selectType.jsp?uuid="+uuid+"&mid="+mid+"&iframewindowid=Dialog0&contentFlag="+contentFlag+"&parentNodeId="+parentNodeId;
			MDialog0.setTitle('选择导出模式');
			Matrix.showWindow('Dialog0');
		}
	}
</script>
</head>
<body onload="showWindow()">
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>


<div style="width:100%;height:100%;overflow:auto;position:relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" 
	action="" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="multipart/form-data">
<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<input type="hidden" name="contentFlag" id="contentFlag" value="${param.contentFlag }"/>
<input type="hidden" id="rootCode" name="rootCode" value="${param.rootCode }"/>
<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>
<input type="hidden" id="mid" name="mid" value="${param.mid }"/>
<input type="hidden" id="parentNodeId" name="parentNodeId" value="${param.parentNodeId }"/>
<input type="hidden" id="treeId" name="treeId" value="${param.treeId }"/>
<input type="hidden" id="exportType" name="exportType" value="${param.exportType }"/>
<input type="hidden" id="importType" name="importType" value="${param.importType }"/>
<input type="hidden" id="flag" name="flag" value="${param.flag }"/>
<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid}"/>
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
 <script>
	function getParamsForDialog0(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		autoCenter: true,
		position:"absolute",
		height: "270px",
		width: "500px",
		title: "选择文件",
		canDragReposition: true,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
		<script>MDialog0.hide();
		</script>
</form></div></body>
</html>
