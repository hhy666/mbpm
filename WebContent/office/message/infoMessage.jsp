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
</head>
<body >
<div id='loading' name='loading' class='loading'>
<script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",name:"Mform0",position:"absolute",action:"<%=request.getContextPath()%>/matrix.rform",fields:[{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}]});</script>
<div
	style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action="<%=request.getContextPath()%>##"
	style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="form0" value="form0" /> <input type="hidden"
	id="matrix_form_tid" name="matrix_form_tid"
	value="c143cdc1-03ce-4384-bd6b-7e68858dc855" /> <input type="hidden"
	id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0"
	value="" />
<div type="hidden" id="form0_hidden_text_div"
	name="form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState"
	id="javax.matrix.faces.ViewState" value="" />
<table class="maintain_form_content" style="width:100%;height:98%">
<!-- 
	<tr>
		<td class="maintain_form_label2" style="width:10%">
			<label id="j_id0" name="j_id0">
				主题
			</label>
		</td>
		<td class="maintain_form_input2" style="90%">
			<div id="subjectValue_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> var subjectValue=isc.TextItem.create({
							ID:"MsubjectValue",
							name:"subjectValue",
							value:"${subjectValue}",
							editorType:"TextItem",
							displayId:"subjectValue_div",
							position:"relative",
							required:true,
							canEdit:false,
							width:300,
							length:100
						});
						Mform0.addField(subjectValue);</script></td>
	</tr>
 	
	<tr>
		<td class="maintain_form_label2" style="width:10%">
			<label id="j_id1" name="j_id1">
				内容
			</label>
		</td>
		<td class="maintain_form_input2" style="90%">
			<div id="contentValue_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> 
					var Micontent_value=null;
					var contentValue=isc.TextAreaItem.create({
								ID:"McontentValue",
								name:"contentValue",
								value:'${contentValue}',
								editorType:"TextAreaItem",
								displayId:"contentValue_div",
								position:"relative",
								width:380,
								height:150,
								toText:true,
								canEdit:false
							});
							Mform0.addField(contentValue);
					</script>
					
				</td>
	</tr>
	
	<tr>
		<td class="maintain_form_label2" style="width:10%">
			<label id="j_id2" name="j_id2">
				接收时间
			</label>
		</td>
		<td class="maintain_form_input2" style="90%">
			<div id="createdDate_div" eventProxy="Mform0" class="matrixInline"  style=""></div>
	<script> var createdDate_value=null; 
				var createdDate=
				isc.DateItem.create({
				ID:"McreatedDate",
				name:"createdDate",
				value:'${createdDate}',
				type:"date",
				required:true,
				displayId:"createdDate_div",
				formatPattern:"yyyy年MM月dd",
				useTextField:true,
				enforceDate:true,
				position:"relative",
				canEdit:false
				});
				Mform0.addField(createdDate);
					</script>
			</td>
	</tr>
-->
	<tr>
		<td class="maintain_form_label2" style="width:100%;height:80%"><div style="width:100%;height:100%;"><p>${contentValue}</p></div></td>
	</tr>

	<tr>
		<td class="maintain_form_command" colspan="2">
		<div id="button004_div" class="matrixInline"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
				isc.Button.create({
						ID:"Mbutton004",
						name:"button004",
						title:"关闭",
						displayId:"button004_div",
						position:"absolute",
						top:0,left:0,width:"100%",
						height:"100%",icon:"[skin]/images/matrix/actions/exit.png",
						showDisabledIcon:false,
						showDownIcon:false,
						showRollOverIcon:false
						});
					Mbutton004.click=function(){
						Matrix.showMask();
						Matrix.closeWindow();
						Matrix.hideMask();
					}
			</script>
		</div>
		</td>
	</tr>
</table>


</form>

</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
</body>
</html>
