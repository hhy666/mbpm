<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<title>添加协同流程</title>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	//根据阶段设置关联表单选项 产品模式下不验证
	function initPage(){
		var phase = <%=currentPhase %>;
		var reFormTr = document.getElementById("reFormTr");
		if(phase==4){//zr bo 
			MsubItems.setDisabled(false);
			MsubItems.setCanEdit(false);
			reFormTr.style.display="table-row";
		}else{
			MsubItems.setDisabled(true);
		}
	
	}


	//选表单 回调  
	function onDialog0Close(data, oType){
		if(data!=null){
		 var reFormObj = isc.JSON.decode(data);
		 MsubItems.setValue(reFormObj.id);
		 return true;
		}
		
		return true;
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
		action:"<%=request.getContextPath()%>/catalog_addComponent.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="<%=request.getContextPath()%>/catalog_addComponent.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="processType" value="${param.processType }"  />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
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
	 	selectedTab: 1,
	 	tabBarControls : [
	 		isc.MatrixHTMLFlow.create({
	 			ID:"MtabContainer0Bar0",
	 			width:"300px",
	 			contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
	 		})
	    ],
	    tabs: [ {
	    	title: "流程信息",
	    	pane:isc.MatrixHTMLFlow.create({
	    	     ID:"MtabContainer0Panel0",
	    	     width: "100%",
	    	     height: "100%",
	    	     overflow: "hidden",
	    	     contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"})
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
<div id="tabContainer0Panel0_div2" style="width: 100%; height: 100%; overflow: hidden;" class="matrixInline">
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 编码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="mid_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script>
			 var mid=isc.TextItem.create({
			  	ID:"Mmid",
			  	name:"mid",
			  	editorType:"TextItem",
			  	displayId:"mid_div",
			  	position:"relative",
			  	width:290,
			  	value:"${catalogNode.mid}",
			  	validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		        return  componentIdValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"编码不能为空!"
		      		 }]
			 });
		 MForm0.addField(mid);
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="idEchoMessage"
			style="color: #FF0000">${idEchoMessage}</span>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
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
				width:290,
				value:"${catalogNode.name}",
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
		<td id="j_id121" jsId="j_id121" class="maintain_form_input"  colspan="1" rowspan="1">
		<div id="subItems_div" eventProxy="MForm0" style="float:left;"></div>
		
		<script> 
			var subItems=isc.TextItem.create({
				ID:"MsubItems",
				name:"subItems",
				editorType:"TextItem",
				displayId:"subItems_div",
				position:"relative",
				disabled:true,
				width:290,
				value:"${catalogNode.subItems}",
				validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		    	 var currentPhase = <%=currentPhase%>;
		      		    		if(currentPhase!=4){//非zr bo不验证
		      		    			return true;
		      		    		}
		      		    		if(value!=null&&value.length>0){
				      		         return true;
		      		    		
		      		    		}else{
		      		    			validator.errorMessage="请选择关联表单!"
		      		    			return false;
		      		    		}
		      		    		
		      		         },
		      		         errorMessage:"请选择关联表单!"
		      		 	}]
			});
			MForm0.addField(subItems);
		</script>
		
		 <script>
			  isc.ImgButton.create({
					  ID:"MImageButton2",
					  name:"ImageButton2",
					  showDisabled:false,
					  showDisabledIcon:false,
					  showDown:false,
					  showDownIcon:false,
					  showRollOver:false,
					  showRollOverIcon:false,
					  position:"relative",
					 
					  width:18,
					  height:18,
					  
					  src:Matrix.getActionIcon("query"),
					  prompt:"关联表单"
			  });
			  MImageButton2.click=function(){
				  Matrix.showMask();
				  Matrix.showWindow('Dialog0');
				  Matrix.hideMask();
			  }
			  </script>
			 <span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		
		</td>
	</tr>
	
	-->
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style=" width: '20%'"><label
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
				showRollOverIcon:false
				});
				MdataFormSubmitButton.click=function(){
					Matrix.showMask();
				    if(!MForm0.validate()){Matrix.hideMask();
				    	return false;
				    }
				
				Matrix.convertFormItemValue('Form0');
				document.getElementById('Form0').submit();
				Matrix.hideMask();
			};
			</script></div>
		</td>
	</tr>
</table>
</div>
	
	<input id="tenantId" type="hidden" name="tenantId" value="${catalogNode.tenantId}" />
    <input id="phase" type="hidden" name="phase" value="${catalogNode.phase}" />
	<input id="parentId" type="hidden" name="parentId" value="${catalogNode.parentUuid}" />
	<input id="isPublic" type="hidden" name="isPublic" value="1"/>
	<input id="createdUser" type="hidden" name="createdUser" value="Jerry"/>
	<input id="type" type="hidden" name="type" value="${catalogNode.type}"/>
	
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
	
	</div>
<script>
document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));
</script>
<script>document.getElementById('tabContainer0_div').style.display='';</script>
</form>
<script>
MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
<script type="text/javascript">
	isc.Window.create({
				 ID:"MDialog0",
				 id:"Dialog0",
				 name:"Dialog0",
				 autoCenter: true,
				 position:"absolute",
				 height: "400px",
				 width: "320px",
				 title: "关联表单",
				 canDragReposition: true,
				 showMinimizeButton:false,
				 showMaximizeButton:false,
				 showCloseButton:true,
				 showModalMask: false,
				 modalMaskOpacity:0,
				 isModal:true,
				 autoDraw: false,
				 headerControls:[
					 "headerIcon","headerLabel","minimizeButton",
					 "maximizeButton","closeButton"
				 ],
				
				 initSrc:"<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=14",
				 src:"<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=14" 
			});
			
			MDialog0.hide();

</script>
</div>

</body>
</html>