<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>更新逻辑信息</title>
	<jsp:include page="/form/admin/common/taglib.jsp"/>
	<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
	
	 //失去焦点时 将服务名写入父页面的隐藏域
	 function serviceNameBlur(form, item){
	 	var sLocation = item.getValue();
	 	parent.document.getElementById("selectedServiceName").value = sLocation;
	 
	 }
	 
	function initPage(){
		var logicType = "${logicInfo.type}";
		//页面初始
		 var sLocation = "${logicInfo.location}";
		 if("3"!=logicType){//非脚本
			 if(sLocation!=null&&sLocation.length>0){
				//将实现类路径写入父页面
				parent.document.getElementById("selectedServiceName").value = sLocation;
			 }
		 
		 }
		//控制组件显示
		
		var serviceNameTr = document.getElementById("serviceNameTr");
		var locationTr = document.getElementById("locationTr");
		
	    if("2"==logicType){//Java服务
	    	serviceNameTr.style.display="none";
	    }else if("3"==logicType){//脚本逻辑
	    	serviceNameTr.style.display="none";
	        locationTr.style.display="none";
	    }
	
	
	   var isCommon = "${param.isCommon}";
	   if(isCommon.length>0){
	   		//通用服务下 模块名集合
		    var commonModuleNames = ['info','process','tool'];
		   	var _index = isCommon.indexOf("_");
		   	isCommon = isCommon.substring(0,_index);
		   	if(commonModuleNames.contains(isCommon)){//通用服务下仅可查看
		   		MdataFormSubmitButton.setDisabled(true);
		   		Mname.canEdit=false;
		   		MtypeShow.canEdit=false;
		   		MbeanValue.canEdit=false;
		   		Mdesc.canEdit=false;
		   	}
	   }
	  
		
	}
	
	</script>
</head>
<body onload="initPage()" >
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"<%=request.getContextPath() %>/logic/logicInfo_updateLogicInfo.action",
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
        <input id="resourceType" type="hidden" name="resourceType" value="${logicInfo.resourceType}" />
		<input id="mid" type="hidden" name="mid" value="${logicInfo.mid}" />
		<input id="tenantId" type="hidden" name="tenantId" value="${logicInfo.tenantId}" />
		<input id="uuid" type="hidden" name="uuid"  value="${logicInfo.uuid}"/>
		<input id="createdDate" type="hidden" name="createdDate"  value="${logicInfo.createdDate}"/>
		<input id="lastModifiedDate" type="hidden" name="lastModifiedDate" value="${logicInfo.lastModifiedDate}" />
		<input id="lastModifiedUser" type="hidden" name="lastModifiedUser"  value="${logicInfo.lastModifiedUser}"/>
		<input id="createdUser" type="hidden" name="createdUser"  value="${logicInfo.createdUser}"/>
		<input id="phase" type="hidden" name="phase"  value="${logicInfo.phase}"/>
		<input type="hidden" name="type" id="type" value="${logicInfo.type}" />
		
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
					style="color: #FF0000">${requestScope.nameEchoMessage}</span>
			</td>
		</tr>
		
		
	    <tr id="j_id114" jsId="j_id114">
		<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1" >
		<label id="j_id116" name="j_id116" style="margin-left: 10px"> 服务类型：</label>
		</td>
		<td id="j_id117" jsId="j_id117" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="typeShow_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MtypeShow_VM=[];
		    var typeShow=isc.SelectItem.create({
		    		ID:"MtypeShow",
		    		name:"typeShow",
		    		editorType:"SelectItem",
		    		displayId:"typeShow_div",
		    		valueMap:[],
		    		value:"${logicInfo.type}",
		    		position:"relative",
		    		width:290,
		    		disabled:true
		    });
		    MForm0.addField(typeShow);
		    MtypeShow_VM =['1','2','3'];
		    MtypeShow.displayValueMap = {'1':'Spring服务','2':'Java服务','3':'脚本逻辑'};
		    MtypeShow.setValueMap(MtypeShow_VM);
		    
		   
		    
		</script></td>
	</tr>
	
	<!-- 服务标识和实现类 -->
	
	<tr id="serviceNameTr" jsId="serviceNameTr">
		<td id="j_id10eN" jsId="j_id10eN" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11eN" name="j_id11eN" style="margin-left: 10px"> 服务标识：</label></td>
		<td id="j_id12eN" jsId="j_id12eN" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="serviceName_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var serviceName=isc.TextItem.create({
				ID:"MserviceName",
				name:"serviceName",
				editorType:"TextItem",
				displayId:"serviceName_div",
				position:"relative",
				width:290,
				value:"${logicInfo.serviceName}",
				canEdit:false
			});
			MForm0.addField(serviceName);
		</script>
		</td>
	</tr>
	
	<tr id="locationTr" jsId="locationTr">
		<td id="j_id10eL" jsId="j_id10eL" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11eL" name="j_id11eL" style="margin-left: 10px"> 实现类：</label></td>
		<td id="j_id12eL" jsId="j_id12eL" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="location_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var slocation=isc.TextItem.create({
				ID:"Mlocation",
				name:"location",
				editorType:"TextItem",
				displayId:"location_div",
				position:"relative",
				width:290,
				value:"${logicInfo.location}",
				required:true,
				blur:function(form, item){
					serviceNameBlur(form, item);
				}
			});
			MForm0.addField(slocation);
			
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
		  					showRollOverIcon:false
		  					
		  					
		  					});
		  					
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
		  				 	//更新回调函数
		  				 	function callbackFun(data){
		  				 	    var dataValue = parseInt(data.data);
		  				 	    
		  				 		//返回成功时刷新树节点parentNodeId
		  				 		if(dataValue!=null&&dataValue==1){//更新成功
		  				 			 var nameEchoMsg = document.getElementById("nameEchoMessage");
		  				 			 setDivValue(nameEchoMsg,"");
		  				 	   		  isc.say("服务逻辑更新成功!");
		  				 			parent.parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
		  				 		}else if(dataValue!=null&&dataValue==0){
		  				 		  //isc.say("名称重复,请修改后保存!");
		  				 			var nameEchoMsg = document.getElementById("nameEchoMessage");
		  				 			setDivValue(nameEchoMsg,"名称重复");
		  				 		}else{
		  				 		    isc.warn("更新异常!");
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
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
</body>
</html>