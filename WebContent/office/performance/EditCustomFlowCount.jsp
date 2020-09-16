<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
		 var flag= document.getElementsByName('radioGroup001');
		 if(flag[0].checked == true){
		 	document.getElementById("templet_div").style.display="none";
		 }
		 var group= document.getElementsByName('radioGroup002');
		 if(group[0].checked == true){
//		 	document.getElementById("user_div").style.display="none";
		 }else{
		 	document.getElementById("dep_div").style.display="none";
		 }
		} 
		//控制模板选择 隐藏 显示
		function setStyle(){
		var flag= document.getElementsByName('radioGroup001');
		 if(flag[0].checked == true){
		 	document.getElementById("templet_div").style.display="none";
		 }else{
		 	document.getElementById("templet_div").style.display="";
		 }
		}
		//控制部门人员选择 隐藏 显示
		function setStyle_2(){
		var flag= document.getElementsByName('radioGroup002');
		 if(flag[0].checked == true){
//		 	document.getElementById("user_div").style.display="none";
		 	document.getElementById("dep_div").style.display="";
		 }else{
		 	document.getElementById("dep_div").style.display="none";
//		 	document.getElementById("user_div").style.display="";
		 }
		}
		
		var formatDateTime = function (date) {  
		    var y = date.getFullYear();  
		    var m = date.getMonth() + 1;  
		    m = m < 10 ? ('0' + m) : m;  
		    var d = date.getDate();  
		    d = d < 10 ? ('0' + d) : d;  
		    var h = date.getHours();  
		    var minute = date.getMinutes();  
		    minute = minute < 10 ? ('0' + minute) : minute;  
		    return y + '-' + m + '-' + d+' '+h+':'+minute;  
		};  
		
        function forwardPage(){
        var flowType=Matrix.getFormItemValue("comboBox001");
        var type;
        var statisType;

        debugger;
//        var startTime=Matrix.getFormItemValue("startTime").toLocaleDateString();
        var startTime=Matrix.getFormItemValue("startTime");
    	startTime = formatDateTime(startTime);       	
//        var endTime=Matrix.getFormItemValue("endTime").toLocaleDateString();
        var endTime=Matrix.getFormItemValue("endTime");
        endTime = formatDateTime(endTime);       	
        
        debugger;
        var depId=Matrix.getFormItemValue("depId");
         var userId=Matrix.getFormItemValue("userId");
         var templetId=document.getElementById('templetId').value;
        var flag= document.getElementsByName("radioGroup001");
		 if(flag[0].checked == true){
		 	type='0';
		 }else{
		 	type='1';
		 }
		  var group= document.getElementsByName("radioGroup002");
		 if(group[0].checked == true){
		 	statisType='0';
		 }else{
		 	statisType='1';
		 }
		var src = "<%=request.getContextPath()%>/office/performance/tabCustomFlow.jsp?flowType="+flowType+"&type="+type+"&statisType="+statisType+"&startTime="+startTime+"&endTime="+endTime+"&templetId="+templetId+"&userId="+userId+"&depId="+depId;
		src = encodeURI(src);
		Matrix.getMatrixComponentById("BorderPanel001Panel2").setContentsURL(src);
	}
	 function onselectTempletClose(data){
		 debugger;
 	if(data!=null){
     var userNames = data.templateNames;
            var adminId = data.mBizIds;
var flowUuid = data.flowUuids;
            var formUuid = data.formUuids;
            document.getElementById('templetId').value = flowUuid;
 	Matrix.setFormItemValue('templet',userNames);
	 // Matrix.setFormItemValue('flowUuid',flowUuid);
 	//Matrix.setFormItemValue('formUuid',formUuid);
	}
    }
 function onselectDepClose(data){
 	if(data!=null){
     var userNames = data.text;
            var adminId = data.entityId;
          Matrix.setFormItemValue('depId',adminId);
 	Matrix.setFormItemValue('dep',userNames);
	 // Matrix.setFormItemValue('flowUuid',flowUuid);
 	//Matrix.setFormItemValue('formUuid',formUuid);
	}
    }
 function onselectUserClose(data){
 	if(data!=null){
     var userNames = data.userName;
            var adminId = data.userId;
          Matrix.setFormItemValue('userId',adminId);
 	Matrix.setFormItemValue('user',userNames);
	 // Matrix.setFormItemValue('flowUuid',flowUuid);
 	//Matrix.setFormItemValue('formUuid',formUuid);
	}
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
			style="width: 100%; height: 100%; overflow: hideen; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>/matrix.rform"
				style="margin: 0px; position: relative; overflow: hideeen; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="85d0ded1-1bb2-41c9-aafe-b1c7348c81fb" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
					<input type="hidden" name="templetId" id="templetId" value="" />
				<input type="hidden" name="userId" id="userId" value="" />
				<input type="hidden" name="depId" id="depId" value="root" />
				<input type="hidden" name="is_mobile_request" />
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
			contentsURL : "<%=request.getContextPath()%>/office/performance/tabCustomFlow.jsp?flowType=&status=&startTime=&endTime="
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
								style="width: 10%; text-align: right;">
								<label id="label001" name="label001" id="label001">
									流程类型
								</label>
							</td>
							<td id="td006" class="tdLayout" rowspan="1" style="width: 30%;">
								<div id="comboBox001_div" eventProxy="Mform0"
									class="matrixInline" style=""></div>
								<script>
	var McomboBox001_VM = [];
	var comboBox001 = isc.SelectItem.create( {
		ID : "McomboBox001",
		name : "comboBox001",
		editorType : "SelectItem",
		displayId : "comboBox001_div",
		autoDraw : false,
		valueMap : [],
		value : "0",
		position : "relative"
	});
	Mform0.addField(comboBox001);
	McomboBox001_VM = [ '0', '1' ];
	McomboBox001.displayValueMap = {
		'0' : '协同',
		'1' : '公文'
	};
	McomboBox001.setValueMap(McomboBox001_VM);
	//McomboBox001.setValue(null);
</script>
							</td>
							<td id="td002" class="tdLayout"
								style="width: 10%; text-align: right;">
								<label id="label003" name="label003" id="label003">
									流程模板
								</label>
							</td>
							<td id="td008" class="tdLayout" rowspan="1"
								style="width: 50%; align: left;">
								<div id="radioGroup001_0_div" eventProxy="Mform0"
									class="matrixInline" style="font-weight: normal;"></div>
								<div id="radioGroup001_1_div" eventProxy="Mform0"
									class="matrixInline" style="font-weight: normal;"></div>
								<script>
	var radioGroup001_0 = isc.RadioItem.create( {
		ID : "MradioGroup001_0",
		name : "radioGroup001", //status 字段
		editorType : "RadioItem",
		displayId : "radioGroup001_0_div",
		value : "0",
		title : "自建流程",
		position : "relative",
		groupId : "radioGroup001",
		disabled : false,
		autoDraw : false,
		changed : "setStyle()"
	});
	Mform0.addField(radioGroup001_0);
</script>
								<script>
	var radioGroup001_1 = isc.RadioItem.create( {
		ID : "MradioGroup001_1",
		name : "radioGroup001",
		editorType : "RadioItem",
		displayId : "radioGroup001_1_div",
		value : "1",
		title : "指定模板",
		position : "relative",
		groupId : "radioGroup001",
		disabled : false,
		autoDraw : false,
		changed : "setStyle()"
	});
	Mform0.addField(radioGroup001_1);
	Mform0.setValue("radioGroup001", '0');
</script>
								<div id="templet_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script>
	var templet = isc.TextItem.create( {
		ID : "Mtemplet",
		name : "templet",
		editorType : "TextItem",
		displayId : "templet_div",
		position : "relative",
		autoDraw : false,
		click : "Matrix.showWindow('selectTemplet');",
		canEdit : false
	});
	Mform0.addField(templet);
</script>

							</td>
						</tr>
						<tr id="tr002">
							<td id="td003" class="tdLayout" colspan="1"
								style="width: 10%; text-align: right;">
								<label id="label002" name="label002" id="label002">
									时间
								</label>
							</td>
							<td id="td007" class="tdLayout" rowspan="1" style="width: 30%;">
								<div id="startTime_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script>
	var MstartTime_value =new Date(new Date().setMonth((new Date().getMonth()-1)));
	var startTime = isc.DateItem.create( {
		ID : "MstartTime",
		name : "startTime",
		value : MstartTime_value,
		type : "date",
		displayId : "startTime_div",
		paseDateFun : function(value, formatPattern) {
			return Matrix.parseDate(value, formatPattern);
		},
		dateFormatter : function(_1) {
			return Matrix.formatDate(this, MstartTime.formatPattern);
		},
		formatPattern : "yyyy-MM-dd",
		autoDraw : false,
		useTextField : true,
		enforceDate : true,
		position : "relative",
		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return item.validateDateValue(value);
			},
			errorMessage : isc.DateItem.getPrototype().invalidDateStringMessage
		} ]
	});
	Mform0.addField(startTime);
</script>
								<label id="label002" name="label002" id="label002">
									至
								</label>
								<div id="endTime_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script>
	var MendTime_value  =new Date();
	var endTime = isc.DateItem.create( {
		ID : "MendTime",
		name : "endTime",
		value : MendTime_value,
		type : "date",
		displayId : "endTime_div",
		paseDateFun : function(value, formatPattern) {
			return Matrix.parseDate(value, formatPattern);
		},
		dateFormatter : function(_1) {
			return Matrix.formatDate(this, MendTime.formatPattern);
		},
		formatPattern : "yyyy-MM-dd",
		autoDraw : false,
		useTextField : true,
		enforceDate : true,
		position : "relative",
		validators : [ {
			type : "custom",
			condition : function(item, validator, value, record) {
				return item.validateDateValue(value);
			},
			errorMessage : isc.DateItem.getPrototype().invalidDateStringMessage
		} ]
	});
	Mform0.addField(endTime);
</script>

							</td>
							<td id="td012" class="tdLayout"
								style="width: 10%; text-align: right;">
								<label id="label003" name="label003" id="label003">
									统计到
								</label>
							</td>
							<td id="td004" class="tdLayout" rowspan="1"
								style="width: 50%; align: left;">
								<div id="radioGroup003_0_div" eventProxy="Mform0"
									class="matrixInline" style="font-weight: normal;"></div>
								<div id="radioGroup004_1_div" eventProxy="Mform0"
									class="matrixInline" style="font-weight: normal;"></div>
								<script>
	var radioGroup002_0 = isc.RadioItem.create( {
		ID : "MradioGroup002_0",
		name : "radioGroup002", //status 字段
		editorType : "RadioItem",
		displayId : "radioGroup003_0_div",
		value : "0",
		title : "部门",
		position : "relative",
		groupId : "radioGroup002",
		disabled : false,
		autoDraw : false,
		changed : "setStyle_2()"
	});
	Mform0.addField(radioGroup002_0);
</script>
							<!-- 	<script>
	var radioGroup002_1 = isc.RadioItem.create( {
		ID : "MradioGroup002_1",
		name : "radioGroup002",
		editorType : "RadioItem",
		displayId : "radioGroup004_1_div",
		value : "1",
		title : "人员",
		position : "relative",
		groupId : "radioGroup002",
		disabled : false,
		autoDraw : false,
		changed : "setStyle_2()"
	});
	Mform0.addField(radioGroup002_1);
	Mform0.setValue("radioGroup002", '0');
</script>
								<div id="dep_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script>
	var dep = isc.TextItem.create( {
		ID : "Mdep",
		name : "dep",
		editorType : "TextItem",
		displayId : "dep_div",
		position : "relative",
		autoDraw : false,
		value:'北京华创动力科技有限公司',
		click : "Matrix.showWindow(\'selectDep\');",
		canEdit : false
	});
	Mform0.addField(dep);
</script>
								<div id="user_div" eventProxy="Mform0" class="matrixInline"
									style=""></div>
								<script>
	var user = isc.TextItem.create( {
		ID : "Muser",
		name : "user",
		editorType : "TextItem",
		displayId : "user_div",
		position : "relative",
		autoDraw : false,
		click : "Matrix.showWindow(\'selectUser\');",
		canEdit : false
	});
	Mform0.addField(user);
</script> -->

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
	function getParamsForselectTemplet() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MselectTemplet",
		id : "selectTemplet",
		name : "selectTemplet",
		autoCenter : true,
		position : "absolute",
		height : "80%",
		width : "80%",
		title : "选择模板",
		canDragReposition : false,
		showMinimizeButton : true,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
		getParamsFun : getParamsForselectTemplet,
		initSrc : "<%=request.getContextPath()%>/performance/tem_loadData.action?uuid=${param.uuid}",
		src : "<%=request.getContextPath()%>/performance/tem_loadData.action?uuid=${param.uuid}",
		showFooter : false
	});
</script>
				<script>
	MselectTemplet.hide();
</script>
		<script>
	function getParamsForselectUser() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MselectUser",
		id : "selectUser",
		name : "selectUser",
		autoCenter : true,
		position : "absolute",
		height : "80%",
		width : "80%",
		title : "选择人员",
		canDragReposition : false,
		showMinimizeButton : true,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
		getParamsFun : getParamsForselectTemplet,
		initSrc : "<%=request.getContextPath()%>/TabUserSelect.rform",
		src : "<%=request.getContextPath()%>/TabUserSelect.rform",
		showFooter : false
	});
</script>
				<script>
	MselectUser.hide();
</script>
			
					<script>
	function getParamsForselectDep() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MselectDep",
		id : "selectDep",
		name : "selectDep",
		autoCenter : true,
		position : "absolute",
		height : "80%",
		width : "80%",
		title : "选择部门",
		canDragReposition : false,
		showMinimizeButton : true,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
		getParamsFun : getParamsForselectTemplet,
		initSrc : "<%=request.getContextPath() %>/DepSelectPage.rform",
		src : "<%=request.getContextPath() %>/DepSelectPage.rform",
		showFooter : false
	});
</script>
				<script>
	MselectDep.hide();
</script>
			
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
