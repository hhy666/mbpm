<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix= "c"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
<%
	String productMode = CommonUtil.getFormUser();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改模块!</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">

	var curPhase = "${requestScope.curPhase}";
	function initPage(){
		var productMode = "<%=productMode%>";
		var subItems3div = document.getElementById("subItems_3_div");
		//逻辑服务1.4阶段显示在业务对象位置，需隐藏此位置
		if(curPhase==1){
			subItems3div.style.display="none";//逻辑占位隐藏
		}
		
		if("matrix"==productMode){//产品模式
			if(curPhase==1||curPhase==3){
				var sceneDiv = document.getElementById("subItems_5_div");
				MForm0.setValue("subItems_5","5");
				sceneDiv.style.display ="none";
				return true;
			}
		
		}
	
	
		//修改下不会对不显示项置空
		var flowAndSceneTr = document.getElementById("flowAndSceneTr");
		var subItemsDiv = document.getElementById("subItems_div");
		
		flowAndSceneTr.style.display ="none";
		subItemsDiv.style.height="25px";
		
		if(curPhase==4){
		 subItems3div.style.display="none";//逻辑占位隐藏
		  subItemsDiv.style.height="50px";
		  flowAndSceneTr.style.display ="table-row";
		  
		  document.getElementById("subItemTr").style.display = "none";
		}
	
	
	}
</script>
</head>
<body onload="initPage()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
	<script> 
		var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/catalog_updateCatalogNode.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,
			height:0,
			displayId:'Form0_hidden_text_div'
			}]
		});
		</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/catalog_updateCatalogNode.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<div id="tabContainer0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;">
	<script>
	 var MtabContainer0 = isc.TabSet.create({
		 ID:"MtabContainer0",
		 displayId:"tabContainer0_div",
		 height: "100%",
		 width: "100%",
		 position: "relative",
		 align: "center",
		 tabBarPosition: "top",
		 tabBarAlign: "left",
		 showPaneContainerEdges: false,
		 showTabPicker: true,
		 showTabScroller: true,selectedTab: 1,
		 tabBarControls : [
		 	isc.MatrixHTMLFlow.create({
		 		ID:"MtabContainer0Bar0",
		 		width:"300px",
		 		contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
		 		})
		  ],
		  tabs: [ {
		  	title: "修改模块",
		  	pane:isc.MatrixHTMLFlow.create({
		  		ID:"MtabContainer0Panel0",
		  		width: "100%",
		  		height: "100%",
		  		overflow: "hidden",
		  		contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"
		  	})
		  } ] 
	 });
	 document.getElementById('tabContainer0_div').style.display='none';
	 MtabContainer0.selectTab(0);
	 isc.Page.setEvent("load","MtabContainer0.selectTab(0);");
	 </script>
	</div>
	
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
	<script>
		document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
	</script>
<div id="tabContainer0Panel0_div2"
	style="width: 100%; height: 100%; overflow: hidden;"
	class="matrixInline">
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 编码：</label></td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="definedId_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
			var definedId=isc.TextItem.create({
				ID:"MdefinedId",
				name:"definedId",
				editorType:"TextItem",
				displayId:"definedId_div",
				position:"relative",
				width:290,
				value:"${catalogNode.mid}",
				disabled:true,
				required:true
			});
			MForm0.addField(definedId);
		</script>
		<span id="MultiLabel1" style="width: 46px; height: 20px; color: #FF0000">*</span></td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
			id="j_id11" name="j_id11" style="margin-left: 10px"> 名称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
			rowspan="1">
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
		<span id="MultiLabel0" style="width: 50px; height: 20px; color: #FF0000"> *</span>
		<span id="nameEchoMessage"
			style="color: #FF0000">${nameEchoMessage}</span>
		</td>
	</tr>

	<tr id="subItemTr" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'">
			<label id="j_id16" name="j_id16" style="margin-left: 10px"> 子组件：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1"
			rowspan="1">
			<span id="subItems_div" style="height: 56px; width: 329px">
		<table border="0" style="width: 100%; height: 100%; margin: 0px; padding: 0px; display: inline;"
			cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td
						style="padding-left: 2px; padding-top: 0px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_1_div" eventProxy="MForm0"></div>
					<script> 
						var subItems_1=isc.CheckboxItem.create({
							   ID:"MsubItems_1",
							   name:"subItems_1",
							   editorType:"CheckboxItem",
							   displayId:"subItems_1_div",
							  
							   valueMap:{"M_NULL":false,"1":true},
							   title:"表单",
							   position:"relative",
							   groupId:"subItems"
						   });
						   MForm0.addField(subItems_1);
						   
					</script></td>
					

					<td
						style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_2_div" eventProxy="MForm0"></div>
					<script>
					   var subItems_2=isc.CheckboxItem.create({
						   	ID:"MsubItems_2",
						   	name:"subItems_2",
						   	editorType:"CheckboxItem",
						   	displayId:(curPhase=="1"||curPhase=="4")?"subItems_3_div":"subItems_2_div",
						   
						   	valueMap:{"M_NULL":false,"2":true},
						   	title:"逻辑服务",
						   	position:"relative",
						   	groupId:"subItems"
					   	});
					   	MForm0.addField(subItems_2);
					   	
					  </script>
					 </td>


					<td
						style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_3_div" eventProxy="MForm0"></div>
					<script> 
						var subItems_3=isc.CheckboxItem.create({
								ID:"MsubItems_3",
								name:"subItems_3",
								editorType:"CheckboxItem",
								displayId:(curPhase=="1"||curPhase=="4")?"subItems_2_div":"subItems_3_div",
								
								valueMap:{"M_NULL":false,"3":true},
								title:"业务对象",
								position:"relative",
								groupId:"subItems"
							});
							MForm0.addField(subItems_3);
							
						</script></td>
					<td></td>

				</tr>
				<tr id="flowAndSceneTr">

					<td style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_4_div" eventProxy="MForm0"></div>
					<script>
						 var subItems_4=isc.CheckboxItem.create({
							 	ID:"MsubItems_4",
							 	name:"subItems_4",
							 	editorType:"CheckboxItem",
							 	displayId:"subItems_4_div",
							 	
							 	valueMap:{"M_NULL":false,"4":true},
							 	title:"协同流程",
							 	position:"relative",
							 	groupId:"subItems"
						 	});
						 	MForm0.addField(subItems_4);
						 	
						 	</script></td>
					
					<td style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_5_div" eventProxy="MForm0"></div>
					<script> 
						var subItems_5=isc.CheckboxItem.create({
								ID:"MsubItems_5",
								name:"subItems_5",
								editorType:"CheckboxItem",
								displayId:"subItems_5_div",
								
								valueMap:{"M_NULL":false,"5":true},
								title:"场景",
								position:"relative",
								groupId:"subItems"
							});
							MForm0.addField(subItems_5);
							
					</script>
					</td>
				</tr>
			</tbody>
		</table>
		</span></td>
	</tr>

	<tr id="j_id32" jsId="j_id32">
		<td id="j_id33" jsId="j_id33" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
			id="j_id34" name="j_id34" style="margin-left: 10px"> 描述：</label></td>
		<td id="j_id35" jsId="j_id35" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="InputTextArea0_div" eventProxy="MForm0" class="matrixInline"
			style=""></div>
		<script>
			 var desc=isc.TextAreaItem.create({
				 	ID:"MInputTextArea0",
				 	name:"desc",
				 	editorType:"TextAreaItem",
				 	displayId:"InputTextArea0_div",
				 	position:"relative",
				 	value:"${catalogNode.desc}",
				 	width:290,
				 	height:100
			 	});
			 	MForm0.addField(desc);
			 	</script>
			 	</td>
	</tr>
	<tr id="j_id36" jsId="j_id36">
		<td id="j_id37" jsId="j_id37" class="maintain_form_command"
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
					Matrix.hideMask();return false;
				}
				if(!MForm0.validate()){
					Matrix.hideMask(); 
				    return false;
			   }
			
			Matrix.convertFormItemValue('Form0');
			document.getElementById('Form0').submit();Matrix.hideMask();
			};
			</script></div>
		</td>
	</tr>
</table>
</div>

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
	
	<input id="comType" type="hidden" name="comType" value="${catalogNode.comType}" />
	<input id="parentId" type="hidden" name="parentId" value="${param.entityId}" />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>

</div>
<script>
	document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));
</script>
<script>
	document.getElementById('tabContainer0_div').style.display='';
</script>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
<script type="text/javascript">
	//需要对subitems进行处理
	var  subItems = "${catalogNode.subItems}";
	
    var itemValues = new Array();
    itemValues = subItems.split(","); 
    for(var i=0; i<itemValues.length;i++){
      MForm0.setValue("subItems_"+itemValues[i],itemValues[i]);
    }
       
</script>
</body>
</html>