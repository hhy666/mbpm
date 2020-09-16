<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>自定义项编辑</title>
<script type="text/javascript">

	window.onload = function(){
		var isEnableSelect = document.getElementById('isEnable');
		var isEnable = "${customCode.isEnable}";
		if(isEnable==1){
			isEnableSelect.options[0].selected = true;
		}else if(isEnable==2){
			isEnableSelect.options[1].selected = true;
		}else{
			isEnableSelect.options[0].selected = true;
		}
	}
	
	//选择实体
	function selectEntity(){
		//选择实体成功后 显示值 和选项值都清空
		layer.open({
			type:2,
			title:['选项值选择'],
			area:['50%','50%'],
			content:'<%=path%>/common/common_loadCommonTreePage.action?componentType=16&iframewindowid=SelectEntity'
		});
	} 
	
	function onSelectEntityClose(data){
		if(data!=null){
          	var jsonObj = isc.JSON.decode(data);
      		document.getElementById("moduleId").value=jsonObj.parentId;
      		document.getElementById("entityType").value=jsonObj.comType;

      		document.getElementById("entity").value=jsonObj.proEntityType;
          	//将选项值 选项显示值 清空
      		document.getElementById("itemValue").value="";
      		document.getElementById("itemLable").value="";
          	return true;
		}
	}
	
    //选择选项值
	 function selectItemValue(){
         //var entityId =  getSelectedEntityId();
       	var entityId = document.getElementById("entity").value;
       	if(entityId!=null&&entityId.length>0){
       		var moduleId = document.getElementById("moduleId").value;
       		var entityType = document.getElementById("entityType").value;
       		layer.open({
    			type:2,
    			title:['选项值选择'],
    			area:['50%','50%'],
    			content:'<%=path%>/common/commonProperties_getEntityProperties.action?iframewindowid=SelectItemValue&entityId="+entityId+"&moduleId="+moduleId+"&entityType="+entityType'
    		});
       	}else{
       		Matrix.warn("请选择选项值!");
       	}
       }
    	
		//选项值
	     function onSelectItemValueClose(data, oType){
	     	if(data!=null){
	         	var entityId = document.getElementById("entity").value;
	         	var proId = data.mid;
	         	//itemValue.setValue(entityId+"."+proId);
	         	document.getElementById("itemValue").value = proId;
	     		return true;
	     	}
	     	return true;//关闭按钮
	     }
		
         //选择 选项显示值
		function selectItemLabel(){
		 	var entityId = document.getElementById("entity").value;
          	if(entityId!=null&&entityId.length>0){
          		var moduleId = document.getElementById("moduleId").value;
          		var entityType = document.getElementById("entityType").value;
          		layer.open({
        			type:2,
        			title:['选项显示值选择'],
        			area:['50%','50%'],
        			content:'<%=path%>/common/commonProperties_getEntityProperties.action?iframewindowid=SelectItemLabel&entityId="+entityId+"&moduleId="+moduleId+"&entityType="+entityType'
        		});
          	}else{
          		Matrix.warn("请选择实体!");
          	}
		}
         
         function onSelectItemLabelClose(data){
        	 if(data!=null){
 	         	var entityId = document.getElementById("entity").value;
 	         	var proId = data.mid;
 	         	//itemValue.setValue(entityId+"."+proId);
 	         	document.getElementById("itemLable").value = proId;
 	     		return true;
 	     	}
 	     	return true;//关闭按钮
         }
         
       //异步提交自定义选项信息
         function asynSubmitCusDetail(){
			var result = Matrix.validateForm('Form0');
			if(result){
         		var uuid = document.getElementById("UUID").value;
         		var entity = document.getElementById("entity").value;
         		var itemValue = document.getElementById("itemValue").value;
         		var itemLable = document.getElementById("itemLable").value;
         		var filter = document.getElementById("filter").value;
         		var isEnable = document.getElementById("isEnable").value;
         		var data = {'UUID':uuid,'entity':entity,'itemValue':itemValue,'itemLable':itemLable,'filter':filter,'isEnable':isEnable};
         		var url="code/customCode_asynSaveCustomDetail.action";
         		Matrix.sendRequest(url,data,function(data){
					    var callbackStr = data.data;
					    var callbackJson = isc.JSON.decode(callbackStr);
					    if(callbackJson!=null&&callbackJson.message==true){
					    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
						   	 	Matrix.info('更新自定义项成功！');
					    }else{
					    	Matrix.warn('更新失败！');
					    }
				});
        	 }
		}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="padding:10px;margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="validateType" name="validateType" value="jquery">
		<input type="hidden" name="moduleId" id="moduleId" />
        <input type="hidden" name="entityType" id="entityType" />
        <input type="hidden" name="UUID" id="UUID" value="${customCode.UUID}" />
        <input type="hidden" name="codeUUID" id="codeUUID" value="${customCode.codeUUID}" />
		<input type="hidden" id="type" name="type" value="${codeNode.type}">
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	实体类型
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="title_div"  class="matrixInline" style="width: 100%">
						<input class="form-control" required type="text" name="entity" id="entity" style="display:unset;WIDTH:90%;HEIGHT:30px;" readonly="readonly" value="${customCode.entity}" >
						<img id="entityImg" src="<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query.png" width="18" height="18" align="TEXTTOP">
						<script type="text/javascript">
							$('#entityImg').click(function(){
								layer.open({
									type:2,
									title:['选项值选择'],
									area:['50%','50%'],
									content:'<%=path%>/common/common_loadCommonTreePage.action?componentType=16&iframewindowid=SelectEntity'
								});
							})
						</script>
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id2" name="j_id2">
						选项值						
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="urlValue_div" class="matrixInline" style="width:100%">
						<input  class="form-control" readonly="readonly" required type="text" name="itemValue" id="itemValue" style="display:unset;WIDTH:90%;HEIGHT:30px;" value="${customCode.itemValue}" >
						<img id="itemValueImg" src="<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query.png" width="18" height="18" align="TEXTTOP">
						<script type="text/javascript">
							$('#itemValueImg').click(function(){
						       	var entityId = document.getElementById("entity").value;
						       	if(entityId!=null&&entityId.length>0){
						       		var moduleId = document.getElementById("moduleId").value;
						       		var entityType = document.getElementById("entityType").value;
						       		layer.open({
						    			type:2,
						    			title:['选项值选择'],
						    			area:['50%','50%'],
						    			content:'<%=path%>/common/commonProperties_getEntityProperties.action?iframewindowid=SelectItemValue&entityId='+entityId+'&moduleId='+moduleId+'&entityType='+entityType
						    		});
						       	}else{
						       		Matrix.warn("请选择选项值!");
						       	}
							});
						</script>
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id2" name="j_id2">
						选项显示值
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="urlValue_div" class="matrixInline" style="width:100%">
						<input class="form-control" readonly="readonly" required type="text" name="itemLable" id="itemLable" style="display:unset;WIDTH:90%;HEIGHT:30px;" value="${customCode.itemLable}" >
						<img id="itemLableImg" src="<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query.png" width="18" height="18" align="TEXTTOP">
						<script type="text/javascript">
							$('#itemLableImg').click(function(){
								var entityId = document.getElementById("entity").value;
					          	if(entityId!=null&&entityId.length>0){
					          		var moduleId = document.getElementById("moduleId").value;
					          		var entityType = document.getElementById("entityType").value;
					          		layer.open({
					        			type:2,
					        			title:['选项显示值选择'],
					        			area:['50%','50%'],
					        			content:'<%=path%>/common/commonProperties_getEntityProperties.action?iframewindowid=SelectItemLabel&entityId='+entityId+'&moduleId='+moduleId+'&entityType='+entityType
					        		});
					          	}else{
					          		Matrix.warn("请选择实体!");
					          	}
							});
						</script>
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id3" name="j_id3">
						查询条件
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="width_div"class="matrixInline" style="width:100%">
						<input  class="form-control" type="text" name="filter" id="filter" style="WIDTH:90%;HEIGHT:30px;" value="${customCode.filter}" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id4" name="j_id4">
						启用查询缓存
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="query_div" class="matrixInline" style="width:100%">
						<select class="form-control select2-accessible" id="isEnable" name="isEnable"  style="width:100px">
							<option value="1">是</option>
							<option value="2">否</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="2" style="vertical-align: top;text-align: center;">
					<div id="button003_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存" onclick="asynSubmitCusDetail()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>