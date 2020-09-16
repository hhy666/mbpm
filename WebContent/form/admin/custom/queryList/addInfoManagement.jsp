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

		<title>My JSP 'addInfoManagement.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
		<script type="text/javascript">
		debugger;
		var formName='<%=request.getAttribute("formName")%>';
		var desc='<%=request.getAttribute("desc")%>';
		var personal='<%=request.getAttribute("personal")%>';
		var status='<%=request.getAttribute("status")%>';
		var makingTime='<%=request.getAttribute("makingTime")%>';
		var editTime='<%=request.getAttribute("editTime")%>';
		</script>
	</head>

	<body >
		<div id='loading' name='loading' class='loading'>
			<script>
	Matrix.showLoading();
</script>
		</div>

		<script>
	var Mform0 = isc.MatrixForm.create( {
		ID : "Mform0",
		name : "Mform0",
		position : "absolute",
		action : "/mofficeV2/matrix.rform",
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
				action="/mofficeV2/matrix.rform"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" id="mode" name="mode" value="debug" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<table id="table001" class="maintain_form_content"
					style="width: 100%;">
					<tr id="tr001">
						<td id="td001" class="maintain_form_label">
							<label id="label001" name="label001" id="label001">
								表单名称
							</label>
						</td>
						<td id="td002" class="maintain_form_input">
							<div id="formName_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var formName = isc.TextItem.create( {
		ID : "MformName",
		name : "formName",
		editorType : "TextItem",
		value : "${formName}",
		displayId : "formName_div",
		position : "relative",
		autoDraw : false
	});
	Mform0.addField(formName);
</script>
						</td>
					</tr>
					<tr id="tr002">
						<td id="td003" class="maintain_form_label">
							<label id="label002" name="label002" id="label002">
								所属人
							</label>
						</td>
						<td id="td004" class="maintain_form_input">
							<div id="personal_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var personal = isc.TextItem.create( {
		ID : "Mpersonal",
		name : "personal",
		editorType : "TextItem",
		value : "${personal}",
		displayId : "personal_div",
		position : "relative",
		autoDraw : false
	});
	Mform0.addField(personal);
</script>
						</td>
					</tr>
					<tr id="tr003">
						<td id="td005" class="maintain_form_label">
							<label id="label003" name="label003" id="label003">
								状态
							</label>
						</td>
						<td id="td006" class="maintain_form_input">
							<span id="check_div" style="width: 200px;"><table
									border="0"
									style="margin: 0px; padding: 0px; display: inline; width: 200px; height: 100%;"
									cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td
												style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 50px;">
												<div id="status_0_div" eventProxy="Mform0"></div>
												<script>
	var status_0 = isc.RadioItem.create( {
		ID : "Mstatus_0",
		name : "status",
		editorType : "RadioItem",
		displayId : "status_0_div",
		value : "0",
		title : "启用",

		position : "relative",
		groupId : "status"
	});
	Mform0.addField(status_0);
</script>
											</td>
											<td></td>
											<td
												style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 50px;">
												<div id="status_1_div" eventProxy="Mform0"></div>
												<script>
	var status_1 = isc.RadioItem.create( {
		ID : "Mstatus_1",
		name : "status",
		editorType : "RadioItem",
		displayId : "status_1_div",
		value : "1",
		title : "禁用",

		position : "relative",
		groupId : "status"
	});
	Mform0.addField(status_1);
	Mform0.setValue("status", "${status}");
</script>
											</td>

										</tr>
									</tbody>
								</table> </span>
						</td>
					</tr>
					<tr id="tr006">
						<td id="td010" class="maintain_form_label" colspan="1"
							style="width: 271px;">
							<label id="label005" name="label005" id="label005">
								制作时间
							</label>
						</td>
						<td id="td011" class="tdLayout" colspan="1" style="width: 634px;">
							<div id="makingTime_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var MinputDate001_value=null;
	if(makingTime!=null && makingTime!='' && makingTime!='null' && makingTime!='undefined'){
		MinputDate001_value=Matrix.parseDate(makingTime,"yyyy年MM月dd日");
	}
	var makingTime = isc.DateItem.create( {
		ID : "MmakingTime",
		name : "makingTime",
		value : MinputDate001_value,
		type : "date",
		displayId : "makingTime_div",
		paseDateFun : function(value, formatPattern) {
			return Matrix.parseDate(value, formatPattern);
		},
		dateFormatter : function(_1) {
			return Matrix.formatDate(this, MmakingTime.formatPattern);
		},
		formatPattern : "yyyy年MM月dd日",
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
	Mform0.addField(makingTime);
</script>
						</td>
					</tr>
					<tr id="tr007">
						<td id="td012" class="maintain_form_label" colspan="1"
							style="width: 271px;">
							<label id="label006" name="label006" id="label006">
								修改时间
							</label>
						</td>
						<td id="td013" class="tdLayout" colspan="1" style="width: 634px;">
							<div id="editTime_div" eventProxy="Mform0" class="matrixInline"
								style=""></div>
							<script>
	var MinputDate002_value=null;
	if(editTime!=null && editTime!='' && editTime!='null' && editTime!='undefined'){
		MinputDate002_value=Matrix.parseDate(editTime,"yyyy年MM月dd日");
	}			
	var editTime = isc.DateItem.create( {
		ID : "MeditTime",
		name : "editTime",
		value : MinputDate002_value,
		type : "date",
		displayId : "editTime_div",
		paseDateFun : function(value, formatPattern) {
			return Matrix.parseDate(value, formatPattern);
		},
		dateFormatter : function(_1) {
			return Matrix.formatDate(this, MeditTime.formatPattern);
		},
		formatPattern : "yyyy年MM月dd日",
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
	Mform0.addField(editTime);
</script>
						</td>
					</tr>
					<tr id="tr004">
						<td id="td007" class="maintain_form_label">
							<label id="label004" name="label004" id="label004">
								描述
							</label>
						</td>
						<td id="td008" class="maintain_form_input">
							<div id="description_div" eventProxy="Mform0"
								class="matrixInline" style="width: 95%;"></div>
							<script>
	var description = isc.TextAreaItem.create( {
		ID : "Mdescription",
		name : "description",
		editorType : "TextAreaItem",
		value:"${desc}",
		displayId : "description_div",
		position : "relative",
		autoDraw : false,
		width : '95%'
	});
	Mform0.addField(description);
</script>
						</td>
					</tr>
					<tr id="tr005">
						<input type="hidden" id="uuid" name="uuid" value="${param.uuid }">
						<td id="td009" class="cmdLayout" colspan="2">
							<div id="button001_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>
	isc.Button.create( {
		ID : "Mbutton001",
		name : "button001",
		title : "保存",
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
	Mbutton001.click=function(){
			Matrix.showMask();
			if(!true){
				Matrix.hideMask();
				return false;
			}
			if(!Mform0.validate()){
				Matrix.hideMask(); 
				return false;
			}
			var vituralbuttonHidden = document.getElementById('matrix_command_id');
			if(vituralbuttonHidden)
				vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
				var currentForm = document.getElementById('form0');
				var buttonHidden = document.createElement('input');
				buttonHidden.type='hidden';
				buttonHidden.name='matrix_command_id';
				buttonHidden.id='matrix_command_id';
				buttonHidden.value='button001';
				currentForm.appendChild(buttonHidden);
				var _mgr=Matrix.convertDataGridDataOfForm('form0');
				if(_mgr!=null&&_mgr==false){
					Matrix.hideMask();
					return false;
				}
				document.getElementById('form0').action="<%=request.getContextPath()%>/query/infor_saveOrUpdate.action";

		var data = Matrix.getFormItemValue('uuid');
		var newData = null;
		var synJson = null;
		if (data != null) {
			newData = "{'uuid':'" + data + "'}";
			synJson = isc.JSON.decode(newData);
		}
		Matrix.send('form0', synJson, function() {
			Matrix.closeWindow();
		});
		Matrix.hideMask();
	};
</script>
							</div>
							<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;"><script>isc.Button.create({ID:"Mbutton002",name:"button002",title:"取消",displayId:"button002_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",icon:"<%=request.getContextPath()%>/resource/images/return.png",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton002.click=function(){Matrix.showMask();Matrix.closeWindow();Matrix.hideMask();};</script>
							</div>
						</td>
					</tr>
				</table>

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
