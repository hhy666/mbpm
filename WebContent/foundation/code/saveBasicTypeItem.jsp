<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>保存或更新代码项</title>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<script type="text/javascript">
	function submitByButton(){
	 	
		var oType = "${param.oType}";
		var addData = null;
		var name = Matrix.getMatrixComponentById("name").getValue();
		var id = Matrix.getMatrixComponentById("mid").getValue();
		var isEnable = Matrix.getMatrixComponentById("IisEnable").getValue();
		MIisEnable
		var uuid = document.getElementById("uuid").value;
		
		if(oType=="add"){//添加
			addData = {'id':id,'name':name,'isEnable':isEnable};	
		}else if(oType=="update"){//更新
			addData = {'id':id,'name':name,'isEnable':isEnable,'uuid':uuid};
		}
		
		var url = "<%=request.getContextPath()%>/code/code_validateCodeId.action";
		
		var parentUUID = document.getElementById('parentUUID').value;
		var type = document.getElementById('type').value;
		var validateJson = {'id':id,'uuid':uuid,'parentUUID':parentUUID,'type':type};
		//parentUUID,type
		Matrix.sendRequest( url,validateJson,function(data){
			var dataStr = data.data;
			if(dataStr!=null){
				var dataJson = isc.JSON.decode(dataStr);
				var message = dataJson.message;
				if(message){
		         Matrix.closeWindow(addData, oType);	
					
				}else{
					var reMsg = document.getElementById("idRepeatMsg");
				    setDivValue(reMsg,"编码重复");
				
				}
			}
		},null);
	}

</script>
</head>
<body>
<jsp:include page="/foundation/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="<%=request.getContextPath()%>/code/"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	
	<input type="hidden" name="Form0" value="Form0"/>
	<input type="hidden" name="uuid" id="uuid" value="${codeNode.uuid}"/>
	<input type="hidden" name="type" id="type" value="${codeNode.type}"/>
	<input type="hidden" name="oType" id="oType" value="${param.oType}"/>
	<input type="hidden" name="parentUUID" id="parentUUID" value="${param.parentUUID}"/>
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>

<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>


<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 选&nbsp;项&nbsp;值：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="mid_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script>
			 var mid=isc.TextItem.create({
			  	ID:"Mmid",
			  	name:"mid",
			  	editorType:"TextItem",
			  	displayId:"mid_div",
			  	position:"relative",
			  	value:"${codeNode.id}",
			  	width:290, 
			  	validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		         return codeBTypeIdValidate(item, validator, value, record);
		      		        },
		      		        errorMessage:"选项值不能为空!"
		      	}]
			 });
		 MForm0.addField(mid);
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="idRepeatMsg"
			style="color: #FF0000"></span>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 选项显示值：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="name_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script> 
			var name2=isc.TextItem.create({
				ID:"Mname",
				name:"name",
				editorType:"TextItem",
				displayId:"name_div",
				position:"relative",
				value:"${codeNode.name}",
				width:290,
				validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		    		if(value==null || value.trim().length==0){
		      		    	    	return false;
		      		    	    }
		      		    	    return true;
		      		         	//return inputNameValidate(item, validator, value, record);
		      		         },
		      		         errorMessage:"显示值不能为空!"
		      		 	}]
			});
			MForm0.addField(name2);
		</script>
		<span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="nameEchoMessage"
			style="color: #FF0000">${nameEchoMessage}<div id="repeatMsg"></div></span>
		</td>
	</tr>
	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" >
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 状&nbsp;&nbsp;态：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="IisEnable_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MIisEnable_VM=[];
		    var IisEnable=isc.SelectItem.create({
		    		ID:"MIisEnable",
		    		name:"IisEnable",
		    		editorType:"SelectItem",
		    		displayId:"IisEnable_div",
		    		valueMap:[],
		    		value:("add"=="${param.oType}")?1:"${codeNode.isEnable}",
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(IisEnable);
		    MIisEnable_VM=['1','2'];
		    MIisEnable.displayValueMap={'1':'启用','2':'禁用'};
		    MIisEnable.setValueMap(MIisEnable_VM);
		    
		    
		   
		</script></td>
	</tr>
	
	
	

		<tr id="j_id121" jsId="j_id121">
		<td id="j_id131" jsId="j_id131" class="maintain_form_command"
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
					top:0,left:0,width:"100%",height:"100%",
					icon:Matrix.getActionIcon("save"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					if(!MForm0.validate()){
					    Matrix.hideMask();
					    return false;
					}
					submitByButton();
					
					
		            Matrix.hideMask();
            };</script></div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,left:0,
					width:"100%",
					height:"100%",
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


	</div>
<script>
	 function codeBTypeIdValidate(item, validator, value, record){
	//空的话返回false
	if(value==null||value.length==0){
	  validator.errorMessage="编码不能为空!";
	  return false;
	}
	return true;
	 
	/*
	 var hasInput =  Matrix.validateLength(1,255, value); 
	 
	validator.errorMessage="编码不能为空";   
	if(hasInput){
		 var isMatch = value.match(/^[\w]+$/);
		 if(isMatch!=null){//合法输入
		 		return true;
		  }
		  
	   validator.errorMessage="只能使用字母、数字和下划线命名";
	   return false;
	 }
	
	 
	return hasInput;
	*/
 }



	MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</form>
</div>

</body>
</html>