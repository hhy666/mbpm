<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<!-- 原脚本逻辑 -->
	<title>更新点击逻辑服务</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
  
</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"./logic/logicInfo_updateLogicInfo.action",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
	  action="<%=request.getContextPath() %>/logic/logicInfo_updateLogicInfo.action" style="margin:0px;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
		<input id="type" type="hidden" name="type" value="3" />
        <input id="resourceType" type="hidden" name="resourceType" value="${logicInfo.resourceType}" />
		<input id="mid" type="hidden" name="mid" value="${logicInfo.mid}" />
		<input id="tenantId" type="hidden" name="tenantId" value="${logicInfo.tenantId}" />
		<input id="uuid" type="hidden" name="uuid"  value="${logicInfo.uuid}"/>
		<input id="createdDate" type="hidden" name="createdDate"  value="${logicInfo.createdDate}"/>
		<input id="lastModifiedDate" type="hidden" name="lastModifiedDate" value="${logicInfo.lastModifiedDate}" />
		<input id="lastModifiedUser" type="hidden" name="lastModifiedUser"  value="${logicInfo.lastModifiedUser}"/>
		<input id="createdUser" type="hidden" name="createdUser"  value="${logicInfo.createdUser}"/>
		<input id="phase" type="hidden" name="phase"  value="${logicInfo.phase}"/>
		<input id="location" type="hidden" name="location"  value="${logicInfo.location}"/>
		
		<input type="hidden" name="parentNodeId" id="parentNodeId" value="${param.parentNodeId}" />
		<input type="hidden" name="logicType" id="logicType" value="${param.logicType}" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
			style="position:absolute;width:0;height:0;z-index:0;top:0;left:0;display:none;"></div>

<div style="text-valign:center;position:relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
		<tr id="j_id4" jsId="j_id4">
			<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id6" name="j_id6" style="margin-left:10px">编码：</label>
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
						  	width:290,
						  	value:"${logicInfo.mid}",
						  	disabled:true,
						  	required:true
					  });
					  MForm0.addField(definedId);
					</script>
				 <span id="MultiLabel0" style="width: 28px;height:20px; color: #FF0000">*</span>
			</td>
		</tr>
		<tr id="j_id9" jsId="j_id9">
			<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id11" name="j_id11" style="margin-left:10px">名称：</label>
		    </td>
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
						value:"${logicInfo.name}",
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
				<span id="MultiLabel1" style="width: 29px;height:20px; color: #FF0000">*</span>
				<span id="nameEchoMessage"
									style="color: #FF0000">${nameEchoMessage}</span>
			</td>
		</tr>
		
		<tr id="j_id27" jsId="j_id27">
	  		<td id="j_id28" jsId="j_id28" class="maintain_form_label" colspan="1" rowspan="1">
	  			<label id="j_id29" name="j_id29" style="margin-left:10px">描述：</label>
	  		</td>
	        <td id="j_id30" jsId="j_id30" class="maintain_form_input" colspan="1" rowspan="1">
	        	<div id="desc_div" eventProxy="MForm0" class="matrixInline" style=""></div>
	        	<script>
	        		 var desc=isc.TextAreaItem.create({
	        		 		ID:"Mdesc",
	        		 		name:"desc",
	        		 		editorType:"TextAreaItem",
	        		 		displayId:"desc_div",
	        		 		position:"relative",
	        		 		value:"${logicInfo.desc}",
	        		 		width:290,
	        		 		height:100
	        		 });
	        		 MForm0.addField(desc);
	            </script>
	       </td>
		  </tr>
		  <tr id="j_id31" jsId="j_id31">
		  		<td id="j_id32" jsId="j_id32" class="maintain_form_command" colspan="2" rowspan="1">
		 			 <div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
		  			<script>
		  				isc.Button.create({
		  					ID:"MdataFormSubmitButton",
		  					name:"dataFormSubmitButton",
		  					title:"保存",
		  					displayId:"dataFormSubmitButton_div",
		  					position:"absolute",
		  					top:0,
		  					left:0,
		  					width:"100%",
		  					height:"100%",
			icon:Matrix.getActionIcon("save"),
		  					showDisabledIcon:false,
		  					showDownIcon:false,
		  					showRollOverIcon:false});
		  					MdataFormSubmitButton.click=function(){
				  					Matrix.showMask();
				  					
				  					if(!MForm0.validate()){
				  						Matrix.hideMask();
				  						 return false;
				  				 	}
				  				 	Matrix.convertFormItemValue('Form0');
				  				 	Matrix.send("Form0",null,callbackFun);
				  				 	Matrix.hideMask();
		  				 	};
		  				 	
		  				 	function callbackFun(data){
		  				 	     var dataValue = parseInt(data.data);
		  				 	    
		  				 		//返回成功时刷新树节点parentNodeId
		  				 		if(dataValue!=null&&dataValue==1){//更新成功
		  				 	     isc.say("脚本逻辑更新成功!");
		  				 	     var nameEchoMsg = document.getElementById("nameEchoMessage");
		  				 			setDivValue(nameEchoMsg,"");
		  				 		parent.parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
		  				 		}else if(dataValue!=null&&dataValue==0){
		  				 		var nameEchoMsg = document.getElementById("nameEchoMessage");
		  				 			setDivValue(nameEchoMsg,"名称重复");
		  				 		
		  				 		}
		  				 	}
		  				 	 	
		  			</script>
		  		</div>
		     </td>
		</tr>
</table>

</div>
</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(
	isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>