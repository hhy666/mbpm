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
		<link rel="stylesheet"
			href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
		<!--<link rel="stylesheet"
			href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css"> -->
		<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
		<script
			src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

		<link href="js/datetimepicker/css/bootstrap-datetimepicker.css"
			rel="stylesheet" type="text/css" />
		<script src="js/datetimepicker/js/bootstrap-datetimepicker.js"
			type="text/javascript"></script>
		<script
			src="js/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
			type="text/javascript"></script>
		<script type="text/javascript">
		window.onload = function(){
		var start=new Date(new Date().setMonth((new Date().getMonth()-1))).format('yyyyMM');
		 var end=new Date().format('yyyyMM');
		 document.getElementById("endTime").value=end;
		 document.getElementById("startTime").value=start;
		 var flag= document.getElementsByName('radioGroup001');
		 if(flag[0].checked == true){
		 	document.getElementById("templet_div").style.display="none";
		 }
		} 
		Date.prototype.format =function(format)
		{
			var o = {
				"M+" : this.getMonth()+1, //month
				"d+" : this.getDate(), //day
				"h+" : this.getHours(), //hour
				"m+" : this.getMinutes(), //minute
				"s+" : this.getSeconds(), //second
				"q+" : Math.floor((this.getMonth()+3)/3), //quarter
				"S" : this.getMilliseconds() //millisecond
			}
			if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
			(this.getFullYear()+"").substr(4- RegExp.$1.length));
				for(var k in o)if(new RegExp("("+ k +")").test(format))
					format = format.replace(RegExp.$1,
					RegExp.$1.length==1? o[k] :
		("00"+ o[k]).substr((""+ o[k]).length));
		return format;
	}
		function setStyle(){
		var flag= document.getElementsByName('radioGroup001');
		 if(flag[0].checked == true){
		 	document.getElementById("templet_div").style.display="none";
		 }else{
		 	document.getElementById("templet_div").style.display="";
		 }
		}
		 $(function () {

            $('.form_datetime').datetimepicker({
               format: 'yyyymm',  
         weekStart: 1,  
         autoclose: true,  
         startView: 3,  
         minView: 3, 
         forceParse: false,  
         language: 'zh-CN'  
            });

        })//end document.ready
        function forwardPage(){
        var flowType=Matrix.getFormItemValue("comboBox001");
        var type;
        var startTime=Matrix.getFormItemValue("startTime");
        var endTime=Matrix.getFormItemValue("endTime");
        var templetId=Matrix.getFormItemValue("templetId");
        var flag= document.getElementsByName("radioGroup001");
		 if(flag[0].checked == true){
		 	type='0';
		 }else{
		 	type='1';
		 }
		var src = "<%=request.getContextPath()%>/office/performance/tabcompre.jsp?flowType="+flowType+"&type="+type+"&startTime="+startTime+"&endTime="+endTime+"&templetId="+templetId;
		Matrix.getMatrixComponentById("BorderPanel001Panel2").setContentsURL(src);
	}
			 function onselectTempletClose(data){
 	if(data!=null){
     var userNames = data.templateNames;
            var adminId = data.mBizIds;
var flowUuid = data.flowUuids;
            var formUuid = data.formUuids;
          Matrix.setFormItemValue('templetId',adminId);
 	Matrix.setFormItemValue('templet',userNames);
	 // Matrix.setFormItemValue('flowUuid',flowUuid);
 	//Matrix.setFormItemValue('formUuid',formUuid);
	}
    }
    </script>
    <style type="text/css">
		label {
    font-weight: normal;
	}
	</style>
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
				<input type="hidden" name="templetId" value="templetId" />
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
					<input type="hidden" name="templetId"
					id="templetId" value="" />
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
			contentsURL : "<%=request.getContextPath()%>/office/performance/tabcompre.jsp?flowType=&status=&startTime=&endTime="
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
									流程类型
								</label>
							</td>
							<td id="td006" class="tdLayout" rowspan="1" style="width: 20%;">
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
									时间
								</label>
							</td>
							<td id="td008" class="tdLayout" rowspan="1"
								style="width: 50%; align: left;">
								<div class="input-group date form_datetime col-md-2"
									style="float: left;width:150px;">
									<input id="startTime" name="startTime" class="form-control"
										type="text" />
									<span class="input-group-addon"> <span
										class="glyphicon glyphicon-th"></span> </span>
								</div>
								<div style="float: left; vertical-align: middle;">
									<label id="label009" name="label009"
										style="font-weight: normal; padding-top: 8px;">
										至
									</label>
								</div>
								<div class="input-group date form_datetime col-md-2"
									style="float: left;width:150px;">
									<input id="endTime" name="endTime" class="form-control"
										type="text" />
									<span class="input-group-addon"> <span
										class="glyphicon glyphicon-th"></span> </span>
								</div>
							</td>
						</tr>
						<tr id="tr002">
							<td id="td003" class="tdLayout" colspan="1"
								style="width: 20%; text-align: right;">
								<label id="label002" name="label002" id="label002"
									style="font-weight: normal;">
									模板流程
								</label>
							</td>
							<td id="td007" class="tdLayout" rowspan="1" colspan="3"
								style="width: 20%; font-weight: normal;">
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
		title : "全部模板",
		position : "relative",
		groupId : "radioGroup001",
		disabled : false,
		autoDraw : false,
		changed:"setStyle()"
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
		changed:"setStyle()"
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
		click : "Matrix.showWindow(\'selectTemplet\');",
		canEdit : false
	});
	Mform0.addField(templet);
</script>
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
				function getParamsForselectTemplet(){var params='&';var value;return
				params;}isc.Window.create({ID:"MselectTemplet",id:"selectTemplet",name:"selectTemplet",autoCenter:
				true,position:"absolute",height: "80%",width: "80%",title:
				"选择模板",canDragReposition:
				false,showMinimizeButton:true,showMaximizeButton:false,showCloseButton:true,showModalMask:
				false,modalMaskOpacity:0,isModal:true,autoDraw:
				false,headerControls:["headerIcon","headerLabel","closeButton"],getParamsFun:getParamsForselectTemplet,initSrc:"<%=request.getContextPath()%>/performance/tem_loadData.action?uuid=${param.uuid}",src:"<%=request.getContextPath()%>/performance/tem_loadData.action?uuid=${param.uuid}",showFooter:
				false });
				</script>
				<script>MselectTemplet.hide();</script>
				<script>
				function getParamsForpenTarget(){
				var params='&';
				var value;
				return params;
				}
				isc.Window.create({
				ID:"MpenTarget",
				id:"penTarget",
				name:"penTarget",
				autoCenter:true,
				position:"absolute",
				height: "80%",
				width: "80%",
				title:"穿透查询",
				canDragReposition : true,
				showMinimizeButton : false,
				showMaximizeButton : true,
				showCloseButton : true,
				showModalMask : false,
				modalMaskOpacity : 0,
				isModal : true,
				autoDraw : false,
				headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
						"maximizeButton", "closeButton" ],
				showFooter : false
				 });
				</script>
				<script>MpenTarget.hide();</script>
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
