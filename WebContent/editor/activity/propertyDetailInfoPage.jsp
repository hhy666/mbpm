<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<title>属性详细页面</title>
<style type="text/css">

	#font2{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
	#td107{
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
	#td108{
		width:100%;
		height:94%;
		border:1px #dedede solid;
	}
	
	
	
</style>

<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
	//页面初始加载
	window.onload=function(){
		
	}
	//授权信息列表需要把Field改成授权信息的Field  这里先临时用userId  userName
	function onpopupSelectDialog001DialogClose(data){
		var secId = data.userId;
		Matrix.setFormItemValue('securityId',secId);
		var secName = data.userName; 
		Matrix.setFormItemValue('popupSelectDialog001',secName);
	}
</script>
</head>
<body >
	
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>
<script> var Mform0=isc.MatrixForm.create({
	ID:"Mform0",
	name:"Mform0",
	position:"absolute",
	action:"",
	fields:[{name:'form0_hidden_text',
			 width:0,
			 height:0,
			 displayId:'form0_hidden_text_div'
	}]});
</script>
<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
	<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	<input type="hidden" name="securityId" id="securityId" /> 
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/><input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	
	
	<!-- -->	 
	<table id="table103" name="table103" style="width:100%;height:100%;">
		
		<tr id="tr108" name="tr108">
			<td id="td108" name="td108">
				 <!--基本信息页面basicInfoPage.jsp -->
				<div id="TabPanel001_div" style="width:100%;height:100%;position:relative;overflow:hidden;" class="matrixInline" eventProxy="Mform0">
					<iframe id="main_iframe1" src="<%=request.getContextPath()%>/editor/editor_getCurActivityEditProperty.action" style="width:100%;height:100%;" frameborder="0"></iframe>
				</div>
				 <!--任务分派页面 
				<div id="TabPanel002_div" style="width:100%;height:100%;position:relative;overflow:hidden;display:none" class="matrixInline" eventProxy="Mform0">
					<iframe id="main_iframe1" src="taskAssignmentPage.jsp" style="width:100%;height:100%;" frameborder="0"></iframe>
				</div>-->
				 <!--活动时限页面
				<div id="TabPanel003_div" style="width:100%;height:100%;position:relative;overflow:hidden;display:none" class="matrixInline" eventProxy="Mform0">
					<iframe id="main_iframe1" src="activityDurationPage.jsp" style="width:100%;height:100%;" frameborder="0"></iframe>
				</div> -->
				 <!--执行人员页面 
				<div id="TabPanel004_div" style="width:100%;height:100%;position:relative;overflow:hidden;display:none" class="matrixInline" eventProxy="Mform0">
				
				</div>-->						
			</td>
		</tr>
	</table>		
		
</form>
</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>