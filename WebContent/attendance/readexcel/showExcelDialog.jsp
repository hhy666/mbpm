<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
	
	<%--弹出读取Excel窗口--%>
	function showExcelDialog(){
		Matrix.showWindow('Dialog0');
	}
	
	function onDialog0Close(data){
		if(data!=null){
			var result = data.message;
			if(result!=null && result!=''){
				if(result=='1'){//success
					Matrix.say("读取EXCEL数据成功!");
				}else if(result=='2'){//fail
					Matrix.warn("由于EXCEL数据问题，未成功导入数据");
				}else if(result=='3'){//type error
					Matrix.warn("EXCEL的保存类型不正确，请另存为正确的类型后再次读取!");
				}
			}
		}
	}
</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var Mform0=isc.MatrixForm.create({
 				ID:"Mform0",
 				name:"Mform0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
  </script>

<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>
	 <div id="button001_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;height:22px;">
                                       <script>
                                       	isc.Button.create({
                                       		ID:"Mbutton001",
                                       		name:"button001",
                                       		title:"打开导入EXCEL窗口",
                                       		displayId:"button001_div",
                                       		position:"absolute",
                                       		top:0,left:0,
                                       		width:"100%",
                                       		height:"100%",
                                       		icon:"[skin]/images/matrix/actions/save.png",
                                       		showDisabledIcon:false,
                                       		showDownIcon:false,
                                       		showRollOverIcon:false
                                       	});
                                       	Mbutton001.click=function(){
                                       		Mbutton001.setDisabled(true);
                                       		Matrix.showMask();
                                       		showExcelDialog();
                                       		Matrix.hideMask();
                                        };</script>
                                    </div>
	
	
	
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
		height: "300px",
		width: "400px",
		title: "弹出读取Excel窗口",
		canDragReposition: true,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		initSrc:"<%=request.getContextPath()%>/attendance/readexcel/readExcel.jsp",
		src:"<%=request.getContextPath()%>/attendance/readexcel/readExcel.jsp"
		});
		</script>
		<script>MDialog0.hide();
		</script>
	
</form>
<script>
	Mform0.initComplete=true;Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);
</script>

</div>

</body>
</html>