<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'EditIssuedCount.jsp' starting page</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<script type="text/javascript">
		window.onload = function(){
		 var flag= Matrix.getFormItemValue('comboBox002');
		 if(flag!='3'){
		 	document.getElementById("label002").style.display="none";
		 	document.getElementById("startTime_div").style.display="none";
		 	document.getElementById("endTime_div").style.display="none";
		 }
		} 
		function setStyle(){
		var flag= Matrix.getFormItemValue('comboBox002');
		 if(flag!='3'){
		 	document.getElementById("label002").style.display="none";
		 	document.getElementById("startTime_div").style.display="none";
		 	document.getElementById("endTime_div").style.display="none";
		 }else{
		 	document.getElementById("label002").style.display="";
		 	document.getElementById("startTime_div").style.display="";
		 	document.getElementById("endTime_div").style.display="";
		 }
		}
		 function onselectTempletClose(data){
 	if(data!=null){
     var userName = data.userName;
            var userId = data.userId;
          Matrix.setFormItemValue('userId',userId);
 	Matrix.setFormItemValue('userName',userName);
	 // Matrix.setFormItemValue('flowUuid',flowUuid);
 	//Matrix.setFormItemValue('formUuid',formUuid);
	}
    }
		
        function forwardPage(){
        var startTime='';
        var endTime='';
        var userId=Matrix.getFormItemValue("userId");
         var userName=Matrix.getFormItemValue("userName");
          var type=Matrix.getFormItemValue("comboBox002");
          var flag= Matrix.getFormItemValue('comboBox002');
		 if(flag=='3'){
         startTime=Matrix.getFormItemValue("startTime").toLocaleDateString();
        endTime=Matrix.getFormItemValue("endTime").toLocaleDateString();
        }
		var src = "<%=request.getContextPath()%>/office/performance/tabonline.jsp?userId="+userId+"&userName="+userName+"&type="+type+"&startTime="+startTime+"&endTime="+endTime;
		Matrix.getMatrixComponentById("BorderPanel001Panel2").setContentsURL(src);
	}
    </script>

	</head>

	<body>
		<jsp:include page="/form/admin/common/loading.jsp" />
		<script>
	var Mform0 = isc.MatrixForm.create( {
		ID : "Mform0",
		name : "Mform0",
		position : "absolute",
		action : "<%=request.getContextPath()%>/matrix.rform",
		canSelectText : true,
		fields : [ {
			name : 'form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'form0_hidden_text_div'
		} ]
	});
</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>/matrix.rform"
				style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="userId" id="userId" value="<%=MFormContext.getUser().getUserId()%>" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="85d0ded1-1bb2-41c9-aafe-b1c7348c81fb" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<div id="VerticalContainer001_div" class="matrixInline"
					style="width: 100%; height: 100%;; overflow: hidden;">
					<script>
	isc.VLayout.create( {
		ID : "MVerticalContainer001",
		displayId : "VerticalContainer001_div",
		position : "relative",
		height : "100%",
		width : "100%",
		align : "center",
		overflow : "hidden",
		defaultLayoutAlign : "center",
		members : [ isc.MatrixHTMLFlow.create( {
			ID : "MBorderPanel001Panel1",
			width : "100%",
			height : '25%',
			overflow : "hidden",
			showResizeBar : true,
			contents : "<div id='BorderPanel001Panel1_div' class='matrixComponentDiv'></div>"
		}), isc.MatrixHTMLFlow.create( {
			ID : "MBorderPanel001Panel2",
			width : "100%",
			overflow : "hidden",
			contents : "<div id='BorderPanel001Panel2_div' class='matrixComponentDiv'></div>",
			contentsType : "page",
				contentsURL : "<%=request.getContextPath()%>/office/performance/tabonline.jsp?userId=&userName=&type=&startTime=&endTime="
		}) ],
		canSelectText : true
	});
</script>
				</div>
				<div id="BorderPanel001Panel1_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">
					<table id="table001" class="tableLayout" style="width: 100%;">
						<tr id="tr001">
							<td id="td001" class="tdLayout"
								style="width: 20%; text-align: right;">
								<label id="label001" name="label001" id="label001">
									选择人员
								</label>
							</td>
							<td id="td006" class="tdLayout" rowspan="1" style="width: 20%;">
								<div id="templet_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script>
	var userName = isc.TextItem.create( {
		ID : "MuserName",
		name : "userName",
		editorType : "TextItem",
		displayId : "templet_div",
		position : "relative",
		autoDraw : false,
		value : "<%=MFormContext.getUser().getUserName()%>",
		click : "Matrix.showWindow(\'selectTemplet\');",
		canEdit : false
	});
	Mform0.addField(userName);
</script>
							</td>
							<td id="td002" class="tdLayout"
								style="width: 10%; text-align: right;">
								<label id="label003" name="label003" id="label003">
									时间
								</label>
							</td>
							<td id="td008" class="tdLayout" rowspan="1"
								style="width: 50%; align: left;">
								<div id="comboBox002_div" eventProxy="Mform0"
									class="matrixInline" style=""></div>
								<script>
	var McomboBox002_VM = [];
	var comboBox002 = isc.SelectItem.create( {
		ID : "McomboBox002",
		name : "comboBox002",
		editorType : "SelectItem",
		displayId : "comboBox002_div",
		autoDraw : false,
		valueMap : [],
		value:"1",
		position : "relative",
		changed:"setStyle()"
	});
	Mform0.addField(comboBox002);
	McomboBox002_VM = ['0','1','2','3'];
	McomboBox002.displayValueMap = {'0':'本日','1':'本周','2':'本月','3':'任意'};
	McomboBox002.setValueMap(McomboBox002_VM);
	</script>
								<div id="startTime_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script> var MstartTime_value=null; var startTime=isc.DateItem.create({ID:"MstartTime",name:"startTime",value:MstartTime_value,type:"date",displayId:"startTime_div",paseDateFun:function(value,formatPattern){return Matrix.parseDate(value,formatPattern);},dateFormatter:function(_1){return Matrix.formatDate(this,MstartTime.formatPattern);},formatPattern:"yyyy-MM-dd",autoDraw:false,useTextField:true,enforceDate:true,position:"relative",validators:[{type:"custom",condition:function(item, validator, value, record){return item.validateDateValue(value);},errorMessage:isc.DateItem.getPrototype().invalidDateStringMessage}]});Mform0.addField(startTime);</script>
								<label id="label002" name="label002" id="label002">
									至
								</label>
								<div id="endTime_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script> var MendTime_value=null; 
								var endTime=isc.DateItem.create({
								ID:"MendTime",
								name:"endTime",
								value:MendTime_value,
								type:"date",
								displayId:"endTime_div",
								paseDateFun:
								function(value,formatPattern){return Matrix.parseDate(value,formatPattern);},dateFormatter:function(_1){return Matrix.formatDate(this,MendTime.formatPattern);},formatPattern:"yyyy-MM-dd",autoDraw:false,useTextField:true,enforceDate:true,position:"relative",validators:[{type:"custom",condition:function(item, validator, value, record){return item.validateDateValue(value);},errorMessage:isc.DateItem.getPrototype().invalidDateStringMessage}]});Mform0.addField(endTime);</script>

							</td>
						</tr>

						<tr id="tr003">
							<td id="td005" colspan="4" rowspan="1"
								style="width: 100%; text-align: center;">
								<div id="button001_div" class="matrixInline"
									style="position: relative;; width: 100px;; height: 22px;">
									<script>
	isc.Button.create( {
		ID : "Mbutton001",
		name : "button001",
		title : "统计",
		displayId : "button001_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton001.click = function() {
		Matrix.showMask();
		//表单验证
		if (!Mform0.validate()) {
			Matrix.hideMask();
			return false;
		}
		forwardPage();
		Matrix.hideMask();
	};
</script>
								</div>
								<div id="button002_div" class="matrixInline"
									style="position: relative;; width: 100px;; height: 22px;">
									<script>
	isc.Button.create( {
		ID : "Mbutton002",
		name : "button002",
		title : "重置",
		displayId : "button002_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton002.click = function() {
		Matrix.showMask();
		Matrix.resetForm("form0");
		Matrix.hideMask();
	};
</script>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<script>
	document.getElementById('BorderPanel001Panel1_div').appendChild(
			document.getElementById('BorderPanel001Panel1_div2'));
</script>
				<div id="BorderPanel001Panel2_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">

				</div>
				<script>
	//document.getElementById('BorderPanel001Panel2_div').appendChild(
	//	document.getElementById('BorderPanel001Panel2_div2'));
</script>
				<script>
				function getParamsForselectTemplet(){
				var params='&';
				var value;
				return
				params;
				}isc.Window.create({
				ID:"MselectTemplet",
				id:"selectTemplet",
				name:"selectTemplet",
				autoCenter:
				true,position:"absolute",
				height: "80%",
				width: "80%",title:
				"选择模板",canDragReposition:
				false,
				showMinimizeButton:true,
				showMaximizeButton:false,
				showCloseButton:true,
				showModalMask:false,
				modalMaskOpacity:0,
				isModal:true,
				autoDraw:false,
				headerControls:["headerIcon","headerLabel","closeButton"],
				getParamsFun:getParamsForselectTemplet,
				initSrc:"<%=request.getContextPath()%>/TabUserSelect.rform",
				src:"<%=request.getContextPath()%>/TabUserSelect.rform",
				showFooter:false 
				});
				</script>
				<script>MselectTemplet.hide();</script>
			</form>
		</div>
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>
