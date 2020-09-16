<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix= "c"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		int currentPhase = CommonUtil.getCurPhase();

	%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改协同流程</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
//根据阶段设置关联表单选项
	function initPage(){
		var phase = <%=currentPhase %>;
		var reFormTr = document.getElementById("reFormTr");
		if(phase==4){//zr bo 
			MsubItems.setCanEdit(false);
			MsubItems.setDisabled(false);
			reFormTr.style.display="table-row";
		}else{
			MsubItems.setDisabled(true);
		}
	
	}


</script>
</head>
<body onload="initPage()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"./catalog_updateCatalogNode.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="./catalog_updateCatalogNode.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1:j_id2" /> 
 <input type="hidden" id="matrix_current_page_id" name="matrix_current_page_id" value="/console/catalog/AddForm" />
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-valign: center; width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 编码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="definedId_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script>
			 var definedId=isc.TextItem.create({
			  	ID:"MdefinedId",
			  	name:"definedId",
			  	editorType:"TextItem",
			  	displayId:"definedId_div",
			  	position:"relative",
			  	value:"${catalogNode.mid}",
			  	width:290,
			  	canEdit:false,
			  	required:true
			 });
		 MForm0.addField(definedId);
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">*</span>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-valign: center; width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 名称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="name_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
			var name2=isc.TextItem.create({
				ID:"Mname",
				name:"name",
				editorType:"TextItem",
				displayId:"name_div",
				position:"relative",
				value:"${catalogNode.name}",
				width:290,
				validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		         	return inputNameValidate(item, validator, value, record);
		      		         },
		      		         errorMessage:"名称不能为空!"
		      		 	}]
			});
			MForm0.addField(name2);
		</script>
		<span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="nameEchoMessage"
			style="color: #FF0000">${nameEchoMessage}</span></td>
	</tr>
<!-- 
	<tr id="reFormTr" jsId="j_id91" style="display:none;">
		<td id="j_id101" jsId="j_id101" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id111" name="j_id111" style="margin-left: 10px"> 关联表单：</label></td>
		<td id="j_id121" jsId="j_id121" style="display:inline;" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="subItems_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var subItems=isc.TextItem.create({
				ID:"MsubItems",
				name:"subItems",
				editorType:"TextItem",
				displayId:"subItems_div",
				position:"relative",
				disabled:true,
				width:290,
				value:"${catalogNode.subItems}"
			});
			MForm0.addField(subItems);
		</script>
		 <span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">
                                                *
         </span>
		</td>
	</tr>
	 -->	
	
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="text-valign: center; width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 描述：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="desc_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var desc=isc.TextAreaItem.create({
				ID:"Mdesc",
				name:"desc",
				editorType:"TextAreaItem",
				displayId:"desc_div",
				position:"relative",
				value:"${catalogNode.desc}",
				width:290
			});
			MForm0.addField(desc);
		</script>
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
				showRollOverIcon:false,
				click:function(){
					Matrix.showMask();
				    if(!MForm0.validate()){
				    	Matrix.hideMask();
				   	 	return false;
					}
					Matrix.convertFormItemValue('Form0');
					Matrix.send("Form0",null,
						function(response){
							if("true"==response.data){
								isc.say("保存成功！");
								parent.refreshProcessCatalogTreeNode();
							}else{
								isc.warn("保存失败！");
							}
						},
						function(){
							isc.warn("保存失败！");
						}
					);
					Matrix.hideMask();
					return false;
				}
			});
			</script></div>
		</td>
	</tr>
</table>
	
	<input id="mid" type="hidden" name="mid" value="${catalogNode.mid}" />
    <input id="tenantId" type="hidden" name="tenantId" value="${catalogNode.tenantId}" />
    <input id="phase" type="hidden" name="phase" value="${catalogNode.phase}" />
	<input id="isPublic" type="hidden" name="isPublic" value="${catalogNode.isPublic}"/>
	<input id="createdUser" type="hidden" name="createdUser" value="${catalogNode.createdUser}"/>
	<input id="uuid" type="hidden" name="uuid" value="${catalogNode.uuid}" />
	
	<input id="parentUuid" type="hidden" name="parentUuid" value="${catalogNode.parentUuid}" />
	<input id="type" type="hidden" name="type" value="${catalogNode.type}" />
	<input id="index" type="hidden" name="index" value="${catalogNode.index}" />
	<input id="createdDate" type="hidden" name="createdDate" value="${catalogNode.createdDate}" />
	<!-- 在更新过程中传递节点信息 -->
	<input id="parentId" type="hidden" name="parentId" value="${param.entityId}" />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
	
</form>
<script>
MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>