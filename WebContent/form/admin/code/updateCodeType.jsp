<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加基本类型!</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>

<script type="text/javascript">
	//添加或保存操作 提交  ------异步保存------
	function asynUpdateCodeSubmit(){
	   //处理 id 和 mid   isEnable 和 IisEnable   
	   var mid = Matrix.getMatrixComponentById("mid").getValue();
	   var isEnable = Matrix.getMatrixComponentById("IisEnable").getValue();
	   var name = Matrix.getMatrixComponentById("name").getValue();
	   var desc = Matrix.getMatrixComponentById("desc").getValue();
	   var type = document.getElementById("type").value;
	   var uuid = document.getElementById("uuid").value;
	   var data ={data:{'uuid':uuid,'id':mid,'isEnable':isEnable,'name':name,'desc':desc,'type':type}};
	   var url ="code/code_asynUpdateCodeItem.action"
	    dataSend(data,url,"POST",function(data){
	    var callbackStr = data.data;
	    var callbackJson = isc.JSON.decode(callbackStr);
	    var message = callbackJson.message;
		    if(message==true){
		    	 parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
		   		 var uType = callbackJson.type;
		      	  if(uType==2){
			   	 	parent.isc.say('更新基本类型成功');
		      	  }else if(uType==3){
		      		  	parent.isc.say('更新自定义类型成功');
		     	  }
		    	
		    }else if(message=='repeat'){
		    	parent.isc.say('编码重复，请重新修改!');
		    }else{
		     	parent.isc.say('更新失败!');
		    }
	    
	    },null);
	
	}


</script>

</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"Form0",
		position:"absolute",
		action:"",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="code/code_addCode.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input  type="hidden" id="parentNodeId"  name="parentNodeId" value="${param.parentNodeId}"/>
	<!-- add or update -->
	<input  type="hidden" id="oType"  name="oType" value="${param.oType}"/>
	
	<input type="hidden" id="parentUUID"  name="parentUUID" value="${codeNode.parentUUID}" />
	<!-- id 需要和显示值mid处理好 -->
	<input type="hidden" id="id" name="id" value="${codeNode.id}"/>
	<input type="hidden" id="isEnable" name="isEnable" value="${codeNode.isEnable}"/>
	<input type="hidden" id="uuid" name="uuid" value="${codeNode.uuid}" />
	<input type="hidden" id="type" name="type" value="${codeNode.type}" />

	
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>



<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 编&nbsp;码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="mid_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script>
			 var mid=isc.TextItem.create({
			  	ID:"Mmid",
			  	name:"mid",
			  	id:"mid",
			  	editorType:"TextItem",
			  	displayId:"mid_div",
			  	position:"relative",
			  	value:"${codeNode.id}",
			  	width:290,
			  	validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		        return  codeIdValidate(item, validator, value, record);
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
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 名&nbsp;称：</label></td>
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
		      		         	return inputNameValidate(item, validator, value, record);
		      		        	 return true;
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
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style=" width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 状&nbsp;态：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="IisEnable_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MIisEnable_VM=[];
		    var IisEnable=isc.ComboBoxItem.create({
		    		ID:"MIisEnable",
		    		name:"IisEnable",
		    		editorType:"ComboBoxItem",
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
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 描&nbsp;述：</label></td>
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
				value:"${codeNode.desc}",
				width:290,
				height:100
			});
			MForm0.addField(desc);
		</script>
	</td>
	</tr>

	<tr id="j_id27" jsId="j_id27">
		<td id="j_id28" jsId="j_id28" class="maintain_form_command"
			colspan="2" rowspan="1">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative; width: 100px; height: 22px;">
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
					//表单验证
				    if(!MForm0.validate()){
				    Matrix.hideMask();
				    return false;
					}
					//异步重复验证
					asynUpdateCodeSubmit();
				
				Matrix.hideMask();
			};
			</script></div>
		</td>
	</tr>
</table>
</div>

</form>
<script>
MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>