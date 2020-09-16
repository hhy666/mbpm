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
	<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">
  <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <link href="js/datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css" />
    <script src="js/datetimepicker/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
    <script src="js/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
		<script type="text/javascript">
		window.onload=function(){
		var start=new Date(new Date().setMonth((new Date().getMonth()-1))).format('yyyyMM');
		 var end=new Date().format('yyyyMM');
		 document.getElementById("endTime").value=end;
		 document.getElementById("startTime").value=start;
		 var startTime=Matrix.getFormItemValue("startTime");
        var endTime=Matrix.getFormItemValue("endTime");
		var src = "<%=request.getContextPath()%>/office/performance/tabinscrease.jsp?startTime="+startTime+"&endTime="+endTime;
		Matrix.getMatrixComponentById("BorderPanel001Panel2").setContentsURL(src);
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
        var startTime=Matrix.getFormItemValue("startTime");
        var endTime=Matrix.getFormItemValue("endTime");
		var src = "<%=request.getContextPath()%>/office/performance/tabinscrease.jsp?startTime="+startTime+"&endTime="+endTime;
		Matrix.getMatrixComponentById("BorderPanel001Panel2").setContentsURL(src);
	}
    </script>
	<style type="text/css">
    element.style{height:30px;}
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
			contentsURL : ""
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
							<td id="td002" class="tdLayout"
								style="width: 40%; text-align: right;">
								<label id="label003" name="label003" id="label003" style="font-weight:normal;">
									时间
								</label>
							</td>
							<td id="td008" class="tdLayout" rowspan="1" style="width: 60%;align: left;">
							<div class="input-group date form_datetime col-md-2"  style="float:left;width:150px;">
        <input id="startTime" name="startTime" class="form-control" type="text" />
        <span class="input-group-addon">
            <span class="glyphicon glyphicon-th"></span>
        </span>
    </div><div style="float:left;vertical-align: middle;"><label id="label009" name="label009" style="font-weight:normal; padding-top:8px;">
									至
								</label></div><div class="input-group date form_datetime col-md-2" style="float:left;width:150px;">
        <input id="endTime" name="endTime" class="form-control" type="text" />
        <span class="input-group-addon">
            <span class="glyphicon glyphicon-th"></span>
        </span>
    </div>
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
					class="matrixInline"></div>
				<script>
	//document.getElementById('BorderPanel001Panel2_div').appendChild(
		//	document.getElementById('BorderPanel001Panel2_div2'));
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
