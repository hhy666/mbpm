<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix= "c"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改工程</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>

<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 		ID:"MForm0",
 		name:"MForm0",
 		position:"absolute",
 		action:"./catalog_updateCatalogNode.action",
 		
 		fields:[{
 		  name:'Form0_hidden_text',
 		  width:0,
 		  height:0,
 		  displayId:'Form0_hidden_text_div'
 		  }]
 	   });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="./catalog_updateCatalogNode.action" style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<input type="hidden" name="javax.faces.ViewState"
	id="javax.faces.ViewState" value="j_id1:j_id2" />
	 <input type="hidden" id="matrix_current_page_id" name="matrix_current_page_id"
	value="/console/catalog/AddSubCatalog" />
<div id="tabContainer0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;"><script> 
	var MtabContainer0 = isc.TabSet.create({
			ID:"MtabContainer0",
			displayId:"tabContainer0_div",
			height: "100%",width: "100%",
			position: "relative",
			align: "center",
			tabBarPosition: "top",
			tabBarAlign: "left",
			showPaneContainerEdges: false,
			showTabPicker: true,
			showTabScroller: true,
			selectedTab: 1,
			tabBarControls : [
				isc.MatrixHTMLFlow.create({
						ID:"MtabContainer0Bar0",
						width:"300px",
						contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
			            })
		    ],
		    
		    tabs: [ {
		             title: "修改工程",
		             pane:isc.MatrixHTMLFlow.create({
		             		ID:"MtabContainer0Panel0",
		             		width: "100%",height: "100%",
		             		overflow: "hidden",
		             		contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"
		             })
		    } ]
      });
      
      document.getElementById('tabContainer0_div').style.display='none';
      MtabContainer0.selectTab(0);
      isc.Page.setEvent("load","MtabContainer0.selectTab(0);");
      </script></div>

<div id="tabContainer0Bar0_div2" style="text-align: right"
	class="matrixInline"></div>
<script>

document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
</script>
<div id="tabContainer0Panel0_div2"
	style="width: 100%; height: 100%; overflow: hidden;"
	class="matrixInline">
<div id="j_id2_div2" style="width: 100%; height: 100%; overflow: auto;"
	class="matrixInline">

<table id="j_id3" jsId="j_id3" class="maintain_form_content">
    <tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id11" name="j_id11"
			style="margin-left: 10px">编码：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="definedId_div" eventProxy="MForm0" class="matrixInline matrixInlineIE"
			style=""></div>
		<script>
		      var definedId=isc.TextItem.create({
		      		ID:"MdefinedId",
		      		name:"definedId",
		      		editorType:"TextItem",
		      		displayId:"definedId_div",
		      		position:"relative",
		      		value:"${catalogNode.mid}",
		      		disabled:true,
		      		width:290,
		      		required:true,
		      		validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		         if(value==null||value.length==0){
								  validator.errorMessage="编码不能为空!";
								  return false;
							 }
		      		         return Matrix.validateLength(1,255, value);},
		      		         errorMessage:"编码不能为空"
		      		 }]
		       });
		       MForm0.addField(definedId);
		      </script> <span id="MultiLabel1"
			style="width: 18px; height: 20px; color: #FF0000">*</span></td>
	</tr>
	
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id6" name="j_id6"
			style="margin-left: 10px">名称：</label></td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="name_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
       		    var name2=isc.TextItem.create({
       		    		ID:"Mname",
       		    		name:"name",
       		    		editorType:"TextItem",
       		    		displayId:"name_div",
       		    		value:"${catalogNode.name}",
       		    		position:"relative",
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
       	    </script> <span id="MultiLabel0"
			style="width: 17px; height: 20px; color: #FF0000">*</span></td>
	</tr>
	
	
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id22" name="j_id22"
			style="margin-left: 10px"> 描述：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="InputTextArea0_div" eventProxy="MForm0" class="matrixInline"
			style=""></div>
		<script>
			 var desc=isc.TextAreaItem.create({
			 		ID:"Mdesc",
			 		name:"desc",
			 		editorType:"TextAreaItem",
			 		displayId:"InputTextArea0_div",
			 		position:"relative",
			 		value:"${catalogNode.desc}",
			 		width:290,height:100
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
					width:"100%",
					height:"100%",
					icon:Matrix.getActionIcon("save"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
				});
				MdataFormSubmitButton.click=function(){
				Matrix.showMask();
				if(!true){
					Matrix.hideMask();
					return false;
				}
				
				if(!MForm0.validate()){
					Matrix.hideMask(); 
					return false;
				}
				
				var vituralbuttonHidden = document.getElementById('matrix_current_action_source_id');
				if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
				var currentForm = document.getElementById('Form0');
				var buttonHidden = document.createElement('input');
				buttonHidden.type='hidden';
				buttonHidden.name='matrix_current_action_source_id';
				buttonHidden.id='matrix_current_action_source_id';
				buttonHidden.value='dataFormSubmitButton';
				currentForm.appendChild(buttonHidden);
				var buttonIdHidden = document.createElement('input');
				buttonIdHidden.type='hidden';
				buttonIdHidden.name='dataFormSubmitButton';
				buttonIdHidden.value='提交';
				document.getElementById('Form0').appendChild(buttonIdHidden);
				Matrix.convertFormItemValue('Form0');
				document.getElementById('Form0').submit();
				Matrix.hideMask();
				};
		</script></div>
		</td>
	</tr>
</table>
</div>
<script>Matrix.appendChild('j_id2_div','j_id2_div2');</script>
   
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
	<input id="comType" type="hidden" name="comType" value="${catalogNode.comType}" />
	<input id="subItems" type="hidden" name="subItems" value="${catalogNode.subItems}" />
	<!-- 在更新过程中传递节点信息 -->
	<input id="parentId" type="hidden" name="parentId" value="${param.entityId}" />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
   
</div>
<script>document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));</script>
<script>document.getElementById('tabContainer0_div').style.display='';</script>
</form>
<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>

</body>
</html>