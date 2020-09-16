<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>查看查询&基本对象</title>
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
	 		action:"",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	 });
	</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
	  action="./dentity/" style="margin:0px;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" 
			style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
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
						  	value:"${entityInfo.mid}",
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
						value:"${entityInfo.name}",
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
				<span id="MultiLabel1" style="width: 29px;height:20px; color: #FF0000">*</span>
				<span id="nameEchoMessage"
									style="color: #FF0000">${nameEchoMessage}</span>
			</td>
		</tr>
		
		
		<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" >
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 启用状态：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="state_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var Mstate_VM=[];
		    var state=isc.SelectItem.create({
		    		ID:"Mstate",
		    		name:"state",
		    		editorType:"SelectItem",
		    		displayId:"state_div",
		    		valueMap:[],
		    		value:"${entityInfo.state}",
		    		position:"relative",
		    		width:290,
		    		canEdit:false
		    });
		    MForm0.addField(state);
		    Mstate_VM=['1','0'];
		    Mstate.displayValueMap={'1':'启用','0':'未启用'};
		    Mstate.setValueMap(Mstate_VM);
		    
		   
		</script>
			
			
		</td>
	</tr>
	
	<tr id="j_id114" jsId="j_id114">
			<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id116" name="j_id116" style="margin-left:10px">路径：</label>
			</td>
			<td id="j_id117" jsId="j_id117" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="entityLabel_div" eventProxy="MForm0" class="matrixInline" style=""></div>
				<script> var entityLabel=isc.TextItem.create({
								ID:"MentityLabel",
								name:"entityLabel",
								editorType:"TextItem",
								displayId:"entityLabel_div",
								position:"relative",
								width:290,
								value:"${entityInfo.entity}",
								canEdit:false
					    });
					    MForm0.addField(entityLabel);
			    </script>
			   
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
	        		 		value:"${entityInfo.desc}",
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
		  					disabled:true,
		  					showDownIcon:false,
		  					showRollOverIcon:false});
		  					MdataFormSubmitButton.click=function(){
				  					
		  				 	};
		  				 	
		  				 	
		  				 	 	
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