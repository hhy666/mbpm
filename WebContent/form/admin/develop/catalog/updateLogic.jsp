<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix= "c"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改逻辑服务</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action=""
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>

<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
<script>
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
	 	selectedTab: 0,
	 	
	 	tabBarControls : [
	 		isc.MatrixHTMLFlow.create({
	 			ID:"MtabContainer0Bar0",
	 			width:"300px",
	 			contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
	 		})
	    ],
	    tabs: [ {
	    	title: "逻辑服务",
	    	pane:isc.MatrixHTMLFlow.create({
	    	     ID:"MtabContainer0Panel0",
	    	     width: "100%",height: "100%",
	    	     overflow: "hidden",
	    	     contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"})
	    	     },{
				 	title: "服务描述",pane:isc.HTMLPane.create({
				 		ID:"MtabContainer0Panel1",
				 		height: "100%",
				 		overflow: "hidden",
				 		autoDraw: false,
				 		showEdges:false,
				 		contentsType:"page",
				 		contentsURL:""})
				 	}
				  ] 
	 });
	 document.getElementById('tabContainer0_div').style.display='none';
	 MtabContainer0.selectTab(0);
  </script>
 </div>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
</script>
<div id="tabContainer0Panel0_div2" style="width: 100%; height: 100%; overflow: hidden;" class="matrixInline">
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
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
			  	value:"${logicInfo.mid}",
			  	width:290,
			  	disabled:true,
			  	required:true
			 });
		 MForm0.addField(definedId);
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">*</span>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'">
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
				value:"${logicInfo.name}",
				width:290,
				canEdit:false,
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
	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="text-align: left; width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 类型：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="comType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var McomType_VM=[];
		    var comType=isc.ComboBoxItem.create({
		    		ID:"McomType",
		    		name:"comType",
		    		editorType:"ComboBoxItem",
		    		displayId:"comType_div",
		    		valueMap:[],
		    		canEdit:false,
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(comType);
		    McomType_VM=['1','2','3'];
		    McomType.displayValueMap={'1':'Spring服务','2':'Java服务','3':'脚本逻辑'};
		    McomType.setValueMap(McomType_VM);
		     var comTypeValue = "${logicInfo.type}";
		    McomType.setValue(comTypeValue);
		</script></td>
	</tr>
	<tr id="j_id9w" jsId="j_id9w">
		<td id="j_id10w" jsId="j_id10w" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'">
			<label id="j_id11w" name="j_id11w" style="margin-left: 10px"> 实现类：</label></td>
		<td id="j_id12w" jsId="j_id12w" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="location_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var mlocation = isc.TextItem.create({
				ID:"Mlocation",
				name:"location",
				editorType:"TextItem",
				displayId:"location_div",
				position:"relative",
				value:"${logicInfo.location}",
				width:290,
				canEdit:false
			});
			MForm0.addField(mlocation);
		</script>
		</td>
	</tr>
	
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="text-align: left; width: '20%'"><label
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
				value:"${logicInfo.desc}",
				canEdit:false,
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
				disabled:true
				});
				MdataFormSubmitButton.click=function(){
					
			};
			</script></div>
		</td>
	</tr>
</table>
</div>
	
	
	<!-- 在更新过程中传递节点信息 -->
	<input id="parentId" type="hidden" name="parentId" value="${param.entityId}" />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
	
	
	
	</div>
<script>
    MtabContainer0Panel1.setContentsURL('<%=request.getContextPath()%>/logic/logicInfo_loadServiceLogicDesc.action?serviceLocation=${logicInfo.location}');
    
	document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));
	document.getElementById('tabContainer0_div').style.display='';
</script>
</form>
<script>
MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>