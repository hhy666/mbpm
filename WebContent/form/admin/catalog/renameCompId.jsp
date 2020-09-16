<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>组件编码重构</title>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>

<script type="text/javascript">
	function idIsChange(){
		var srcCompId = document.getElementById('srcCompId').value;
		var newCompId = Matrix.getMatrixComponentById('newCompId').getValue();
		
		if(srcCompId ==newCompId){
			return false;
		}
		return true;
	}


</script>

</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"./",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  
	action="<%=request.getContextPath() %>/refactor/refactorAction_reNameComponentId.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="cType" id="cType" value="${catalogNode.type}" />
	<input type="hidden" name="srcEntityPath" id="srcEntityPath" value="${catalogNode.subItems}" />
	<input type="hidden" name="srcCompId" id="srcCompId" value="${catalogNode.mid}" />
	<input type="hidden" name="uuid" id="uuid" value="${catalogNode.uuid}" />
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>

<table id="j_id3" jsId="j_id3" class="maintain_form_content">

		<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px">原编码：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="name_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
			var name2=isc.TextItem.create({
				ID:"Mname",
				name:"name",
				editorType:"TextItem",
				displayId:"name_div",
				position:"relative",
				width:200,
				value:"${catalogNode.mid}",
				canEdit:false
			});
			MForm0.addField(name2);
		</script>
		<span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="nameEchoMessage"
			style="color: #FF0000">${nameEchoMessage}</span>
		</td>
	</tr>
	

	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 新编码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="newCompId_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script>
			 var newCompId=isc.TextItem.create({
			  	ID:"MnewCompId",
			  	name:"newCompId",
			  	editorType:"TextItem",
			  	displayId:"newCompId_div",
			  	position:"relative",
			  	value:"${requestScope.newCompId}",
			  	width:200,
			  	validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		        return  componentIdValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"编码不能为空!"
		      		 }]
			 });
		 MForm0.addField(newCompId);
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="idEchoMessage"
			style="color: #FF0000">${idEchoMessage}</span>
		</td>
	</tr>

	
	
	<tr id="j_id24" jsId="j_id24"></tr>
	<tr id="j_id25" jsId="j_id25"></tr>
	<tr id="j_id26" jsId="j_id26"></tr>
	<tr id="j_id27" jsId="j_id27">
		<td id="j_id28" jsId="j_id28" class="maintain_form_command"
			colspan="2" rowspan="1">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
				ID:"MdataFormSubmitButton",
				name:"dataFormSubmitButton",
				title:"保存",
				displayId:"dataFormSubmitButton_div",
				position:"absolute",
				top:0,left:0,
				width:"100%",height:"100%",
				icon:Matrix.getActionIcon("save"),
				showDisabledIcon:false,
				showDownIcon:false,
				showRollOverIcon:false
				});
				MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					//变化再提交
					if(!idIsChange()){
						 isc.say("编码未变化!",{width:200,height:70});
						 Matrix.hideMask();
					     return false;
					}
					
				    if(!MForm0.validate()){
					    Matrix.hideMask();
					    return false;
					}
					
					
					
		
				Matrix.convertFormItemValue('Form0');
				document.getElementById('Form0').submit();
				Matrix.hideMask();
			};
			</script>
			</div>
			
			<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,left:0,width:"100%",height:"100%",
					icon:Matrix.getActionIcon("exit"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
					});
					MdataFormCancelButton.click=function(){
						Matrix.showMask();
					    Matrix.closeWindow();
						Matrix.hideMask();
					};
					</script>
				</div>
				
		</td>
	</tr>
</table>

</form>
<script>
MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>