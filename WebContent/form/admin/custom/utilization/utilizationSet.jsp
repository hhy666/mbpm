<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>应用设置!</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />

		<script type="text/javascript">
		window.onload=function(){ 
			
			parent.parent.authUser = {};
			parent.parent.showListName=[];
			parent.parent.showMobileListName=[];
			parent.parent.sortName=[];
			parent.parent.userInputCondition=[];
			parent.parent.hignCondition=[];
			
			var oType = "${param.oType}";
			var formId = "${param.formId}";
			var catalogId = "${param.catalogId}";
			var addTitle = "${utilization.addTitle}";
			if(addTitle == ""){
				MaddTitle.setValue("新建");
			}
			var editTitle = "${utilization.editTitle}";
			if(editTitle == ""){
				MeditTitle.setValue("修改");
			}
			//${utilization.addTitle}
			if(oType=='add'){
				var url = "<%=request.getContextPath()%>/utilization/utili_addBefore.action?catalogId="+catalogId+"&formId="+formId;
				Matrix.sendRequest(url,null,function(data){
					 if(data!=null){
						 var str = data.data;
						 if(str != null && str != ""){
							 var obj = JSON.parse(str);
							 var formshuid= obj.formshuid;
							 var formjson= obj.formjson;
							 var returnshuzu= obj.returnshuzu;
							 var returnjson= obj.returnjson;
							
							 MaddTitle.setValue("新建");
							 MeditTitle.setValue("修改");
							 MaddForm.setValue(formId);  //设置默认
							 MaddForm.displayValueMap=formjson;
							 MaddForm.setValueMap(formshuid);
							 MeditForm.setValue(formId);  //设置默认
							 MeditForm.displayValueMap=formjson;
							 MeditForm.setValueMap(formshuid);
							 Mauthorization.displayValueMap=returnjson;																					
							 Mauthorization.setValueMap(returnshuzu);
							 Mauthorizationtwo.displayValueMap=returnjson;																					
							 Mauthorizationtwo.setValueMap(returnshuzu)
							 
						 }
						 Matrix.hideMask();
					 }
			  });
	    	} 
		}
		//保存到子表
	/**		
	function saveFormItem(){
		var mBizId="${param.mBizId}";
	Matrix.saveDataGridData("DataGrid005");
			      	 var json= Matrix.getAllDataGridData("DataGrid005");
			      	  //var items=Matrix.getDataGridSelection("DataGrid001");
			      	 var newData="{\'data\':\"{data:[";
			      	 for(var i=0;i<json.length;i++){
			      	 	newData+="{";
			      	 	newData+="\'name\':\'"+json[i].name;
			      	 	newData+="\',";
			      	 	newData+="\'formId\':\'"+json[i].formId;
			      	 	newData+="\',";
			      	 	newData+="\'enType\':\'"+json[i].enType;
			      	 	newData+="\',";
			      	 	newData+="\'edType\':\'"+json[i].edType;
			      	 	newData+="\',";
			      	 	newData+="\'style\':\'"
			      	 	if(json[i].style!='undefined'){
			      	 	newData+=json[i].style;
			      	 	}
			      	 	newData+="\',";
			      	 	newData+="\'width\':\'"+json[i].width;
			      	 	newData+="\',";
			      	 	newData+="\'options\':\'"
			      	 	if(json[i].options!='undefined'){
			      	 	newData+=json[i].options;
			      	 	}
			      	 	newData+="\',";
			      	 	newData+="\'codeId\':\'"
			      	 	if(json[i].codeId!='undefined'){
			      	 	newData+=json[i].codeId;
			      	 	}
			      	 	newData+="\',";
			      	 	newData+="\'dataType\':\'"
			      	 	if(json[i].dataType!=undefined&&json[i].dataType='undefined'){
			      	 	newData+=json[i].dataType;
			      	 	}
			      	 	newData+="\',";
			      	 	newData+="\'mBizId\':\'"+mBizId;
			      	 	if(i!=json.length-1){
			      	 	newData+="\'},"
			      	 	}else{
			      	 	newData+="\'}"
			      	 	}
			      	 }
			      	 newData+="]}\"}"
			      	 var synJson = isc.JSON.decode(newData);
					var url='<%=request.getContextPath()%>/utilization/utili_saveOption.action';		     	
			     	//convertEditDataGridData('MDataGrid001',true);
			     Matrix.sendRequest(url,synJson,function(data){
						    var callbackStr = data.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.result==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
							   	 	
						      	  
						    }else{
						    	parent.isc.say('保存失败');
						    }
						    
							},null);
	}***/
	//添加或保存操作 提交
	function addOrUpdateQuerySubmit() {
		//处理 id 
		var name = Matrix.getMatrixComponentById("name").getValue();
		document.getElementById("id").value = name;
		//操作类型
		var oType = "${param.oType}";
		var form0 = document.getElementById('Form0');
		if (oType != null && "add" == oType) {//添加
			form0.submit();
		} else if (oType != null && "update" == oType) {//更新
			form0.action = "<%=request.getContextPath()%>/utilization/utili_updateUtilization.action"
			form0.submit();
		}

	}
		//系统查询条件
		function showSelectCondition(){ 
		var flag =Matrix.getFormItemValue('flag');
		var firstCondition =Matrix.getFormItemValue('sysQueryCondition');
		//MselectCondition.initSrc="<%=request.getContextPath()%>/utilization/form_condition.action?formFlag=${param.formFlag}&flag="+flag+"&formId=${param.formId}&firstCondition="+encodeURI(firstCondition);
		//MselectCondition.src="<%=request.getContextPath()%>/utilization/form_condition.action?formFlag=${param.formFlag}&flag="+flag+"&formId=${param.formId}&firstCondition="+encodeURI(firstCondition);
		//Matrix.showWindow('selectCondition');
		var formFlag="${param.formFlag}";
		var formId="${param.formId}";
		parent.openUtilSysCondiation(formFlag,flag,formId,firstCondition);
		}
	
		//电脑端输出数据项
		function showOutData(){
		    var flag =Matrix.getFormItemValue('flag');
			var string=Matrix.getFormItemValue('displayItems');
			var value=Matrix.getFormItemValue('displayItemsVal');
    		var result=string.split(",");
    		var list=[];
    		if(value!=null&&value!=""&&value.length>0){
	    		list=eval('(' + value + ')');
	    		parent.parent.showListName=list;
    		}
    		/*
	    	if(string!=null&&string!=""){
				for(var i=0;i<result.length;i++){
				var newdata={};
	  			newdata.name=result[i];
	  			newdata.formId=showListValue[i].formId;
	  			newdata.enType=showListValue[i].enType;
	  			newdata.edType=showListValue[i].edType;
	  			newdata.style=showListValue[i].style;
	  			newdata.options=showListValue[i].options;
	  			newdata.width=showListValue[i].width;
	  			newdata.codeId=showListValue[i].codeId;
	  			newdata.dataType=showListValue[i].dataType;
	  			list.add(newdata);
				}
	    	 parent.parent.parent.showListName=list;
	    	}*/
	    	var formFlag = "${param.formFlag}";
	    	var mBizId = "${param.uuid}";
	    	var formId = "${param.formId}";
			parent.openOutData(formFlag,mBizId,formId,flag);
		}
		
		//移动端输出数据项
		function showMobileOutData(){
			 var flag =Matrix.getFormItemValue('flag');
			 var string=Matrix.getFormItemValue('mobileDisplayItems');
			 var value=Matrix.getFormItemValue('mobileDisplayItemsVal');
	    	 var result=string.split(",");
	    	 var list=[];
	    	 if(value!=null&&value!=""&&value.length>0){
		    	list=eval('(' + value + ')');
		    	parent.parent.showMobileListName=list;
	    	 }	
	    	 var formFlag = "${param.formFlag}";
		     var mBizId = "${param.uuid}";
		     var formId = "${param.formId}";
			 parent.openMobileOutData(formFlag,mBizId,formId,flag);
		}
		
		//自定义查询
		function showCustomQuery(){
		var flag =Matrix.getFormItemValue('flag');
			var string="${utilization.customQueryItem}";
			var value="${utilization.customQueryItemVal}";
    		var result=string.split(",");
    		var customQueryValue=value.split(",");
    		if(string!=null&&string!=""){
    	var list=[];
		for(var i=0;i<result.length;i++){
			var newdata={};
  			newdata.name=result[i];
  			newdata.formId=customQueryValue[i];
  			list.add(newdata);
		}
    	parent.parent.customCondition=list;}
			McustomQuery.initSrc="<%=request.getContextPath()%>/form/admin/custom/utilization/customCondition.jsp?formFlag=${param.formFlag}&flag="+flag+"&formId=${param.formId}";
			McustomQuery.src="<%=request.getContextPath()%>/form/admin/custom/utilization/customCondition.jsp?formFlag=${param.formFlag}&flag="+flag+"&formId=${param.formId}";
		Matrix.showWindow('customQuery');
		}
		//排序
		function showSetSort(){
		//数据回掉
			var string=Matrix.getFormItemValue("sortSet");
				var value=Matrix.getFormItemValue("sortSetVal");
    		var sortName=string.split(",");
    		var sortContent=value.split(",");
    		if(string!=null&&string!=""){
    		    	var list=[];
				for(var i=0;i<sortName.length;i++){
					var newdata={};
					if(sortContent[i]!=""&&typeof(sortContent[i])!="undefined"&&typeof(sortName[i])!="undefined"&&sortName[i]!=""){
							var reslult=sortContent[i].split(" ");
  							newdata.name=sortName[i];
  							newdata.formId=reslult[0]
  							newdata.type=reslult[1];
  							list.add(newdata);
  					}
  				}
  			parent.parent.sortName=list;
  		}
  			var displayItemsVal =Matrix.getFormItemValue('displayItemsVal');
//		if(displayItemsVal==""||displayItemsVal==null||displayItemsVal=='undefined'){
//			warn("请先选择输出数据项!");
//		}else{
			var displayItems=Matrix.getFormItemValue('displayItems');
    		var result=displayItems.split(",");
    		var showListValue;
    		var sortdata=[];
    	if(displayItemsVal!=null&&displayItemsVal!=""&&displayItemsVal.length>0){
    		sortdata=eval('(' + displayItemsVal + ')');
    		parent.parent.showListName=sortdata;
    		}
    	
	    	var formFlag = "${param.formFlag}";
	    	var mBizId = "${param.uuid}";
	    	var formId = "${param.formId}";
			parent.openSetSort(formFlag,mBizId,formId)
//		}
	}
		
		function showAddAuthority(){
		if(document.getElementById("authId").value!=null&&document.getElementById("authId").value!=""){
			 parent.parent.authUser.areaIds = document.getElementById("authId").value;
			 parent.parent.authUser.areaName = Matrix.getFormItemValue("authority");
		}else{
			parent.parent.authUser=null;
		}
		 parent.openAddAuthority();
		}
		
		//授权
		  function onaddAuthorityClose(data){
 		if(data!=null){
     		var userNames = data.allNames;
            var adminId = data.allIds;
          	Matrix.setFormItemValue('authId',adminId);
 			Matrix.setFormItemValue('authority',userNames);
 			parent.parent.authUser = {};
		}else{
			//Matrix.setFormItemValue('authId',"");
 			//Matrix.setFormItemValue('authority',"");
 			//parent.parent.authUser = {};
		}
    }
		//系统查询条件
		function onselectConditionClose(data){
      if(data!=null && data!=""){
		var data=eval("("+data+")")
      	Matrix.setFormItemValue('sysQueryCondition',data.conditionText);
		Matrix.setFormItemValue('sysQueryConditionVal',data.conditionVal);
      }else if(typeof(data) == "undefined"){
	
	  }else{
		Matrix.setFormItemValue('sysQueryCondition',"");
		Matrix.setFormItemValue("sysQueryConditionVal","");
	 }
	}
		//输出数据项
		function onoutDataClose(selectedItems){
      if(selectedItems!=null && selectedItems!=""){
			if(selectedItems!=true){
			var data="";
			var value="["
			var sign=Matrix.getFormItemValue('flag');
			for(var i=0;i<selectedItems.length;i++){
				var resl=selectedItems[i].formId.split(".");
				if(sign==""||sign==null||sign=='undefined'){
				if(resl[0]!='${param.formFlag}'){
					Matrix.setFormItemValue('flag',resl[0]);
				}
			}
				if(i==selectedItems.length-1){
					data+=selectedItems[i].name;
				value+="{\'name\':\'"
				value+=selectedItems[i].name;
				value+="\',\'formId\':\'"	
				value+=selectedItems[i].formId;
				value+="\',\'enType\':\'"
				value+=selectedItems[i].enType;
				value+="\',\'edType\':\'"
				value+=selectedItems[i].edType;
				value+="\',\'style\':\'"
				if(selectedItems[i].style!=""&&selectedItems[i].style!=null&&selectedItems[i].style!='undefined'){
				value+=selectedItems[i].style;
				}
				value+="\',\'options\':\'"
				if(selectedItems[i].options!=""&&selectedItems[i].options!=null&&selectedItems[i].options!='undefined'){
				value+=selectedItems[i].options;
				}
				value+="\',\'width\':\'"
				if(selectedItems[i].width!=""&&selectedItems[i].width!=null&&selectedItems[i].width!='undefined'){
				value+=selectedItems[i].width;
				}
				value+="\',\'codeId\':\'"
				if(selectedItems[i].codeId!=""&&selectedItems[i].codeId!=null&&selectedItems[i].codeId!='undefined'){
				value+=selectedItems[i].codeId;
				}
				value+="\',\'dataType\':\'"
				if(selectedItems[i].dataType!=""&&selectedItems[i].dataType!=null&&selectedItems[i].dataType!='undefined'){
				value+=selectedItems[i].dataType;
				}
				value+="\'}";
				}else{
				data+=selectedItems[i].name;
				data+=',';
				value+="{\'name\':\'"
				value+=selectedItems[i].name;
				value+="\',\'formId\':\'"
				value+=selectedItems[i].formId;
				value+="\',\'enType\':\'"
				value+=selectedItems[i].enType;
				value+="\',\'edType\':\'"
				value+=selectedItems[i].edType;
				value+="\',\'style\':\'"
				if(selectedItems[i].style!=""&&selectedItems[i].style!=null&&selectedItems[i].style!='undefined'){
				value+=selectedItems[i].style;
				}
				value+="\',\'options\':\'"
				if(selectedItems[i].options!=""&&selectedItems[i].options!=null&&selectedItems[i].options!='undefined'){
				value+=selectedItems[i].options;
				}
				value+="\',\'width\':\'"
				if(selectedItems[i].width!=""&&selectedItems[i].width!=null&&selectedItems[i].width!='undefined'){
				value+=selectedItems[i].width;
				}
				value+="\',\'codeId\':\'"
				if(selectedItems[i].codeId!=""&&selectedItems[i].codeId!=null&&selectedItems[i].codeId!='undefined'){
				value+=selectedItems[i].codeId;
				}
				value+="\',\'dataType\':\'"
				if(selectedItems[i].dataType!=""&&selectedItems[i].dataType!=null&&selectedItems[i].dataType!='undefined'){
				value+=selectedItems[i].dataType;
				}
				value+="\'},";
				}
			}
			value+="]"
      	Matrix.setFormItemValue('displayItems',data);
		Matrix.setFormItemValue('displayItemsVal',value);
		parent.parent.showListName=[];
		}else{
		Matrix.setFormItemValue('displayItems',"");
		Matrix.setFormItemValue('displayItemsVal',"");
		}  
      }
	}
	//自定义查询项
	function oncustomQueryClose(selectedItems){
      if(selectedItems!=null && selectedItems!=""){
			var data="";
			var value="";
			var sign=Matrix.getFormItemValue('flag');
			for(var i=0;i<selectedItems.length;i++){
			if(sign==""||sign==null||sign=='undefined'){
				var arr=selectedItems[i].formId.split(".");
				if(arr[0]!='${param.formFlag}'){
					Matrix.setFormItemValue('flag',arr[0]);
				}
			}
				if(i==selectedItems.length-1){
					data+=selectedItems[i].name;
					value+=selectedItems[i].formId;
				}else{
				data+=selectedItems[i].name;
				data+=',';
				value+=selectedItems[i].formId;
				value+=',';
				}
			}
      	Matrix.setFormItemValue('customQueryItem',data);
		Matrix.setFormItemValue('customQueryItemVal',value);
		
      }else{
		Matrix.setFormItemValue('customQueryItem',"");
		Matrix.setFormItemValue('customQueryItemVal',"");
		} 
		parent.parent.customCondition=[]; 
	}
	//排序设置
	function onsetSortClose(selectedItems){
      if(selectedItems!=null && selectedItems!=""){
		if(selectedItems!=true){
			var data="";
			var value="";
			for(var i=0;i<selectedItems.length;i++){
			var resl="";
			if(selectedItems[i].formId.indexOf(".") != -1){
				resl=selectedItems[i].formId.split(".");
				data+=selectedItems[i].name;
				if(i!=selectedItems.length-1){
				data+=',';
				}
				value+=resl[1];
				value+=' ';
				value+=selectedItems[i].type;
				value+=',';
			}else{
				resl=selectedItems[i].formId;
				data+=selectedItems[i].name;
				if(i!=selectedItems.length-1){
				data+=',';
				}
				value+=resl;
				value+=' ';
				value+=selectedItems[i].type;
				value+=',';
			}
			}
      	Matrix.setFormItemValue('sortSet',data);
		Matrix.setFormItemValue('sortSetVal',value);
		}else{
		Matrix.setFormItemValue('sortSet',"");
		Matrix.setFormItemValue('sortSetVal',"");
		} 
      } 
	parent.parent.sortName=[];
	}
	//用户条件
		function oninputConditionClose(selectedItems){
      if(selectedItems!=null && selectedItems!=""){
			var data="";
			var value="";
			var sign=Matrix.getFormItemValue('flag');
			for(var i=0;i<selectedItems.length;i++){
			if(sign==""||sign==null||sign=='undefined'){
				var arr=selectedItems[i].formId.split(".");
				if(arr[0]!='${param.formFlag}'){
					Matrix.setFormItemValue('flag',arr[0]);
				}
			}
				if(i==selectedItems.length-1){
					data+=selectedItems[i].name;
				value+=selectedItems[i].formId;
				value+=':';
				value+=selectedItems[i].operator;
				}else{
				data+=selectedItems[i].name;
				data+=',';
				value+=selectedItems[i].formId;
				value+=':';
				value+=selectedItems[i].operator;
				value+=',';
				}
			}
      	Matrix.setFormItemValue('userInputCondition',data);
		Matrix.setFormItemValue('userInputConditionVal',value);
      }else{
		Matrix.setFormItemValue('userInputCondition',"");
		Matrix.setFormItemValue('userInputConditionVal',"");
		}  
		parent.parent.parent.userInputCondition=[];
    }

	function onaddformClose(record){
	 if(record!=null && record!=""){
			var value=eval('('+record+')');  
			var data;
			var value;
			data=value.text;
			value=value.id;
      	Matrix.setFormItemValue('addForm',data);
		Matrix.setFormItemValue('add',value);
      }else{
	  Matrix.setFormItemValue('addForm',"");
		Matrix.setFormItemValue('add',"");
	  }  
	}
	function oneditformClose(record){
	 if(record!=null && record!=""){
			var value=eval('('+record+')');  
			var data;
			var value;
			data=value.text;
			value=value.id;
      	Matrix.setFormItemValue('editForm',data);
		Matrix.setFormItemValue('edit',value);
      }else{
			Matrix.setFormItemValue('editForm',"");
			Matrix.setFormItemValue('edit',"");
		}  
	}
	
	//弹出高级查询条件窗口
    function showSeniorCondition(){ 
    	var string=Matrix.getFormItemValue('sysSeniorCondition');
		var value=Matrix.getFormItemValue('sysSeniorConditionVal');
    	
		
		var sortName=string.split(",");;
		var sysSeniorConditionVal=value.split(",");
    	if(string!=null&&string!=""){
    	var list=[];
		for(var i=0;i<sortName.length;i++){
		var newdata={};
			if(sortName[i]!=""&&typeof(sortName[i])!="undefined"&&sysSeniorConditionVal[i]!=""&&typeof(sysSeniorConditionVal[i])!="undefined"){
			var resl=sysSeniorConditionVal[i].split(":");
  			newdata.name=sortName[i];
  			newdata.formId=resl[0];
 
  			list.add(newdata);
  			}
  			}
  			parent.parent.hignCondition=list;
  			}
    	
    	var flag =Matrix.getFormItemValue('flag');
    	var formFlag="${param.formFlag}";
		var formId="${param.formId}";
    	parent.openhignCondition(formFlag,flag,formId);
    
	}

	//高级查询条件回调
   function onhignConditionClose(selectedItems){
      if(selectedItems!=null && selectedItems!=""){
			if(selectedItems!=true){
			var data="";
			var value="";
			for(var i=0;i<selectedItems.length;i++){
				var arr=selectedItems[i].formId;
				if(i==selectedItems.length-1){
					data+=selectedItems[i].name;
					value+=selectedItems[i].formId;
							
			    }else{
					data+=selectedItems[i].name;
				    data+=',';
					value+=selectedItems[i].formId;
				    value+=',';
				}
		    }
	      	Matrix.setFormItemValue('sysSeniorCondition',data);
			Matrix.setFormItemValue('sysSeniorConditionVal',value);
			
		}else{
			Matrix.setFormItemValue('sysSeniorCondition',"");
			Matrix.setFormItemValue('sysSeniorConditionVal',"");
	  	}  
	  	
      }
		parent.parent.hignCondition=[];
    }
</script>

	</head>
	<body>
		<jsp:include page="/form/admin/common/loading.jsp" />
		<div id="j_id1" jsId="j_id1"
			style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
			<script>
	var MForm0 = isc.MatrixForm.create( {
		ID : "MForm0",
		name : "MForm0",
		position : "absolute",
		action : "",
		fields : [ {
			name : 'Form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'Form0_hidden_text_div'
		} ]
	});
</script>
			<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
				action="<%=request.getContextPath()%>/utilization/utili_addUtilization.action"
				style="margin: 0px; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="Form0" value="Form0" />
				<input type="hidden" id="parentNodeId" name="parentNodeId" value="" />
				<!-- add or update -->
				<input type="hidden" id="oType" name="oType" value="${param.oType}" />

				<input type="hidden" id="parentUUID" name="parentUUID" value="" />
				<!-- id 需要和显示值mid处理好 -->
				<input type="hidden" id="id" name="id" value="" />
				<input type="hidden" id="uuid" name="uuid" value="${param.uuid}" />
				<input type="hidden" id="type" name="type" value="" />
				<input type="hidden" id="order" name="order" value="" />
				<input type="hidden" id="tenantId" name="tenantId" value="" />
				<input name="outDataValue" id="outDataValue" type="hidden" value="" />
				<input name="displayItemsVal" id="displayItemsVal" type="hidden"
					value="${utilization.displayItemsVal}" />
				<input name="mobileDisplayItemsVal" id="mobileDisplayItemsVal" type="hidden"
					value="${utilization.mobileDisplayItemsVal}" />
				<input name="sortSetVal" id="sortSetVal" type="hidden"
					value="${utilization.sortSetVal}" />
				<input name="authId" id="authId" type="hidden"
					value="${utilization.authId}" />
				<input name="catalogId" id="catalogId" type="hidden"
					value="${param.catalogId}" />
				<input name="formId" id="formId" type="hidden"
					value="${param.formId}" />
				<input name="add" id="add" type="hidden"
					value="${utilization.add}" />
				<input name="edit" id="edit" type="hidden"
					value="${utilization.edit}" />
				<input name="customQueryItemVal" id="customQueryItemVal"
					type="hidden" value="${utilization.customQueryItemVal}" />
				<input name="sysQueryConditionVal" id="sysQueryConditionVal"
					type="hidden" value="${utilization.sysQueryConditionVal}" />
				<input name="sysSeniorConditionVal" id="sysSeniorConditionVal"
					type="hidden" value="${utilization.sysSeniorConditionVal }" />
					<input name="flag" id="flag" type="hidden" />
				<div type="hidden" id="Form0_hidden_text_div"
					name="Form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
				<div id="tabContainer0_div" class="matrixComponentDiv"
					style="width: 100%; height: 100%; position: relative;">
					<script>
	var MtabContainer0 = isc.TabSet
			.create( {
				ID : "MtabContainer0",
				displayId : "tabContainer0_div",
				height : "100%",
				width : "100%",
				position : "relative",
				align : "center",
				tabBarPosition : "top",
				tabBarAlign : "left",
				showPaneContainerEdges : false,
				showTabPicker : true,
				showTabScroller : true,
				selectedTab : 1,
				tabBarControls : [ isc.MatrixHTMLFlow.create( {
					ID : "MtabContainer0Bar0",
					width : "300px",
					contents : "<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
				}) ],
				tabs : [ {
					title : ("add" == "${param.oType}") ? "添加应用设置" : "更新应用设置",
					pane : isc.MatrixHTMLFlow
							.create( {
								ID : "MtabContainer0Panel0",
								width : "100%",
								height : "100%",
								overflow : "hidden",
								contents : "<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"
							})
				} ]
			});
	document.getElementById('tabContainer0_div').style.display = 'none';
	MtabContainer0.selectTab(0);
	isc.Page.setEvent("load", "MtabContainer0.selectTab(0);");
</script>
				</div>
				<div id="tabContainer0Bar0_div2" style="text-align: right"
					class="matrixInline"></div>
				<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(
			document.getElementById('tabContainer0Bar0_div2'));
</script>
				<div id="tabContainer0Panel0_div2"
					style="width: 100%; height: 100%; overflow: auto;"
					class="matrixInline">
					<div style="text-valign: center; position: relative">
						<table id="table001" class="tableLayout" style="width: 100%;">
							<tr id="tr001">
								<td id="td001" class="maintain_form_label"
									style="width: 30%;">
									<label id="label005" name="label005" id="label005"
										style="color: red;">
										*
									</label>
									<label id="label001" name="label001" id="label001" style="white-space: nowrap;">
										应用模板名称:
									</label>
								</td>
								<td id="td002" class="tdLayout" colspan="8" style="width: 70%;">
									<div id="input001_div" eventProxy="MForm0" class="matrixInline"
										style="width: 100%;"></div>
									<script>
	var name2 = isc.TextItem.create( {
		ID : "Mname",
		name : "name",
		editorType : "TextItem",
		displayId : "input001_div",
		position : "relative",
		autoDraw : false,
		width : "100%",
		value: "${utilization.name}",
		required:true,
		validators: [{
                         type: "custom",
            condition: function(item, validator, value, record) {
                if(value!=null||value.length>0){
                	var pattern = new RegExp("[`~!@#$^&*=|{}':'\\[\\]<>/~！@#￥……&*（）——|{}【】‘：”“？]");
					if(pattern.test(value))
					{
						validator.errorMessage="不能输入非法字符!";
						return false;
					}else if(value.length>100){
						validator.errorMessage="名称长度不能大于100";
					} else 
					return true;
			  		}
            },
           errorMessage: "不能输入非法字符!"
         }]
	});
	MForm0.addField(name2);
</script>
								</td>
							</tr>
							<tr id="tr002">
								<td id="td003" class="maintain_form_label"
									style="width: 30%;">
									<label id="label009" name="label009" id="label009"
										style="color: red;">
										*
									</label>
									<label id="label002" name="label002" id="label002" style="white-space: nowrap;">
										电脑端显示数据项:
									</label>
								</td>
								<td id="td004" style="" colspan="6">
									<div id="inputTextArea001_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var displayItems = isc.TextAreaItem.create( {
		ID : "MdisplayItems",
		name : "displayItems",
		editorType : "TextAreaItem",
		displayId : "inputTextArea001_div",
		position : "relative",
		autoDraw : false,
		canEdit:false,
		width : '100%',
		height : 50,
		value: "${utilization.displayItems}",
		required:true
	});
	MForm0.addField(displayItems);
</script>
								</td>
								<td id="td014" class="tdLayout" rowspan="1" colspan="2"
									style="width: 20%; border-left: 0;">
									<div id="button003_div" class="matrixInline"
										style="position: relative;; width: 60px;; height: 22px;">
										<script>
	isc.Button.create( {
		ID : "Mbutton003",
		name : "button003",
		title : "设置",
		displayId : "button003_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton003.click = function() {
		Matrix.showMask();
		var x = eval("showOutData();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton003.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
									</div>
								</td>
							</tr>
							<tr id="tr020">
								<td id="td040" class="maintain_form_label"
									style="width: 30%;">
									<!-- 
									<label id="label020" name="label020" id="label020"
										style="color: red;">
										*
									</label>
									-->
									<label id="label021" name="label021" id="label021" style="white-space: nowrap;">
										移动端显示数据项:
									</label>
								</td>
								<td id="td041" style="" colspan="6">
									<div id="inputTextArea004_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var mobileDisplayItems = isc.TextAreaItem.create( {
		ID : "MmobileDisplayItems",
		name : "mobileDisplayItems",
		editorType : "TextAreaItem",
		displayId : "inputTextArea004_div",
		position : "relative",
		autoDraw : false,
		canEdit:false,
		width : '100%',
		height : 50,
		value: "${utilization.mobileDisplayItems}",
		required:false
	});
	MForm0.addField(mobileDisplayItems);
</script>
								</td>
								<td id="td042" class="tdLayout" rowspan="1" colspan="2"
									style="width: 20%; border-left: 0;">
									<div id="button010_div" class="matrixInline"
										style="position: relative;; width: 60px;; height: 22px;">
										<script>
	isc.Button.create( {
		ID : "Mbutton010",
		name : "button010",
		title : "设置",
		displayId : "button010_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton010.click = function() {
		Matrix.showMask();
		var x = eval("showMobileOutData();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton010.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
									</div>
								</td>
							</tr>
							<tr id="tr003">
								<td id="td005" class="maintain_form_label"
									style="width: 30%;">
									<label id="label003" name="label003" id="label003" style="white-space: nowrap;">
										排序设置:
									</label>
								</td>
								<td id="td006" class="tdLayout" colspan="6"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea002_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var sortSet = isc.TextAreaItem.create( {
		ID : "MsortSet",
		name : "sortSet",
		editorType : "TextAreaItem",
		displayId : "inputTextArea002_div",
		position : "relative",
		autoDraw : false,
		canEdit:false,
		width : '100%',
		height : 50,
		value: "${utilization.sortSet}"
	});
	MForm0.addField(sortSet);
</script>
								</td>
								<td id="td019" class="tdLayout" rowspan="1" colspan="2"
									style="width: 20%; border-left: 0;">
									<div id="button004_div" class="matrixInline"
										style="position: relative;; width: 60px;; height: 22px;">
										<script>
	isc.Button.create( {
		ID : "Mbutton004",
		name : "button004",
		title : "设置",
		displayId : "button004_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton004.click = function() {
		Matrix.showMask();
		var x = eval("showSetSort();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton004.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
									</div>
								</td>
							</tr>
							<!-- 
							<tr id="tr006">
								<td id="td011" class="maintain_form_label"
									style="width: 30%; text-align: left;">
									<label id="label007" name="label007" id="label007">
										自定义查询项:
									</label>
								</td>
								<td id="td012" class="tdLayout" colspan="5"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea005_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var customQueryItem = isc.TextAreaItem.create( {
		ID : "McustomQueryItem",
		name : "customQueryItem",
		editorType : "TextAreaItem",
		displayId : "inputTextArea005_div",
		position : "relative",
		canEdit:false,
		autoDraw : false,
		width : '100%',
		value: "${utilization.customQueryItem}",
		height : 50
	});
	MForm0.addField(customQueryItem);
</script>
								</td>
								<td id="td022" class="tdLayout" rowspan="1" colspan="2"
									style="width: 20%; border-left: 0;">
									<div id="button007_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
										<script>
	isc.Button.create( {
		ID : "Mbutton007",
		name : "button007",
		title : "设置",
		displayId : "button007_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton007.click = function() {
		Matrix.showMask();
		var x = eval("showCustomQuery();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton007.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
									</div>
								</td>
							</tr> -->
							<!-- -------------------------------------新建表单------------------------------------------------------ -->
							<tr id="tr005">
								<td id="td017" class="maintain_form_label"
									style="width: 30%;">
									<label id="label004" name="label004" id="label004" style="white-space: nowrap;">
										新建表单:
									</label>
								</td>
								<td id="td018" class="tdLayout" colspan="2" style="">
									<div id="inputTextArea013_div" eventProxy="MForm0"
											class="matrixInline" style="width: 100%;"></div>
									<script>
									var MaddForm_VM=[];
									var addForm=isc.SelectItem.create({
											  ID:"MaddForm",
											  name:"addForm",
											  editorType:"SelectItem",
											  displayId:"inputTextArea013_div",
											  valueMap:[],
											  value:"${utilization.add}",
											  position:"relative",
											  width:"100%",
											  validators : [ {
													type : "custom",
													condition : function(item, validator, value, record) {
														return inputNameValidate(item, validator, value, record);
													},
													errorMessage : "表单不能为空!"
											 } ],
											  changed:"changeSelect();"
								     });
									  MForm0.addField(addForm);
									  MaddForm_VM=<%=request.getAttribute("formvm")%>;
									  MaddForm.displayValueMap=<%=request.getAttribute("formvalue")%>;
									  MaddForm.setValueMap(MaddForm_VM);
									  
									  //下拉框改变时
									  function changeSelect(){
										  Matrix.showMask();
										  var addForm=Matrix.getFormItemValue("addForm");
										  var url = "<%=request.getContextPath()%>/utilization/utili_cascadeOption.action?addForm="+addForm;
										  Matrix.sendRequest(url,null,function(data){
											 if(data!=null){
												 var str = data.data;
												 if(str != null && str != ""){
													 var obj = JSON.parse(str);
													 var returnshuzu= obj.returnshuzu;
													 var returnjson= obj.returnjson;
													 Mauthorization.displayValueMap=returnjson;																					
													 Mauthorization.setValueMap(returnshuzu);
												 }else{
													 Mauthorization.displayValueMap="";																					
													 Mauthorization.setValueMap([]);
												 }	
												 Matrix.hideMask();
											 }
										  });
									  }
									</script>
							    </td>
							    
							    <td id="td029" class="" colspan="1" style="background-color:rgb(250, 250, 250);border: 1px solid #cccccc;text-align:center;">
									<label id="label007" name="label007" id="label007" style="white-space: nowrap;">
										授权:
									</label>
								</td>
							    <td id="td029" class="tdLayout" colspan="2" style="">
									<div id="authorization_div" eventProxy="MForm0"
											class="matrixInline" style="width: 100%;"></div>
									<script>
									var Mauthorization_VM=[];
									var authorization=isc.SelectItem.create({
											  ID:"Mauthorization",
											  name:"authorization",
											  editorType:"SelectItem",
											  displayId:"authorization_div",
											  valueMap:[],
											  value:"${utilization.addPower}",
											  position:"relative",
											  width:"100%",
								     });
									  MForm0.addField(authorization);
									  Mauthorization_VM=<%=request.getAttribute("authorizationvm")%>;
									  Mauthorization.displayValueMap=<%=request.getAttribute("authorizationvalue")%>;
									  Mauthorization.setValueMap(Mauthorization_VM);
									</script>
							    </td>
									
									
								<!--  <td id="td018" class="tdLayout" colspan="3" style="width: 50%;">
									<div id="inputTextArea013_div" eventProxy="MForm0"
										class="matrixInline" style="width: 70%;"></div>
									<script>
										var addForm = isc.TextItem.create( {
											ID : "MaddForm",
											name : "addForm",
											editorType : "TextItem",
											displayId : "inputTextArea013_div",
											position : "relative",
											canEdit:false,
											autoDraw : false,
											click:" Matrix.showWindow('addform');",
											width : '100%',
											hint:"<点击选择表单>",
											showHintInField:true,
											value: "${utilization.addForm}"
										});
										MForm0.addField(addForm);
									</script>
								</td>-->
								<td id="td027" class="" colspan="1" style="background-color:rgb(250, 250, 250);border: 1px solid #cccccc;text-align:center;">
									<label id="label027" id="label027" style="white-space: nowrap;">
										新建名称
									</label>
								</td>
								<td id="td125" class="tdLayout" colspan="2" style="width: 50%;">
									<div id="addTitle_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
										<script>
											var addTitle = isc.TextItem.create({
												ID : "MaddTitle",
												name : "addTitle",
												editorType : "TextItem",
												displayId : "addTitle_div",
												position : "relative",
												value : "${utilization.addTitle}",
												width : "100%",
											});
											MForm0.addField(addTitle);
										</script>
								</td>
							</tr>
					
					
							<!-- --------------------------------------修改表单----------------------------------------------------- -->
							<tr id="tr015">
								<td id="td117" class="maintain_form_label" rowspan="1"
									style="width: 30%;">
									<label id="label006" name="label006" id="label006" style="white-space: nowrap;">
										修改表单:
									</label>
								</td>
								<td id="td018" class="tdLayout" colspan="2" style="">
									<div id="editForm_div" eventProxy="MForm0"
											class="matrixInline" style="width: 100%;"></div>
									<script>
									var MeditForm_VM=[];
									var editForm=isc.SelectItem.create({
											  ID:"MeditForm",
											  name:"editForm",
											  editorType:"SelectItem",
											  displayId:"editForm_div",
											  valueMap:[],
											  value:"${utilization.edit}",
											  position:"relative",
											  width:"100%",
											  changed:"onchangeSelect();"
								     });
									  MForm0.addField(editForm);
									  MeditForm_VM=<%=request.getAttribute("formvm")%>;
									  MeditForm.displayValueMap=<%=request.getAttribute("formvalue")%>;
									  MeditForm.setValueMap(MeditForm_VM);
									  
									  //下拉框改变时
									  function onchangeSelect(){
										  Matrix.showMask();
										  var editForm=Matrix.getFormItemValue("editForm");
										  var url = "<%=request.getContextPath()%>/utilization/utili_cascadeOptionTwo.action?editForm="+editForm;
										  Matrix.sendRequest(url,null,function(data){
											 if(data!=null){
												 var str = data.data;
												 if(str != null && str != ""){
													 var obj = JSON.parse(str);
													 var returnshuzu= obj.returnshuzu;
													 var returnjson= obj.returnjson;
													 Mauthorizationtwo.displayValueMap=returnjson;																					
													 Mauthorizationtwo.setValueMap(returnshuzu);
												 }else{
													 Mauthorizationtwo.displayValueMap="";																					
													 Mauthorizationtwo.setValueMap([]);
												 }	
												 Matrix.hideMask();
											 }
										  });
									  }
									</script>
							    </td>
								<!--<td id="td12" class="tdLayout" colspan="3" style="width: 50%;">
									<div id="inputText113_div" eventProxy="MForm0"
										class="matrixInline" style="width: 70%;"></div>
									<script>
										var editForm = isc.TextItem.create( {
											ID : "MeditForm",
											name : "editForm",
											editorType : "TextItem",
											displayId : "inputText113_div",
											position : "relative",
											canEdit:false,
											autoDraw : false,
											click:" Matrix.showWindow('editform');",
											width : '100%',
											hint:"<点击选择表单>",
											showHintInField:true,
											value: "${utilization.editForm}"
										});
										MForm0.addField(editForm);
									</script>
								</td> -->
								
								<td id="td021" class="" colspan="1" style="background-color:rgb(250, 250, 250);border: 1px solid #cccccc;text-align:center;">
									<label id="label012" name="label012" id="label012" style="white-space: nowrap;">
										授权:
									</label>
								</td>
							    <td id="td031" class="tdLayout" colspan="2" style="width: 50%;">
									<div id="authorizationtwo_div" eventProxy="MForm0"
											class="matrixInline" style="width: 100%;"></div>
									<script>
									var Mauthorizationtwo_VM=[];
									var authorizationtwo=isc.SelectItem.create({
											  ID:"Mauthorizationtwo",
											  name:"authorizationtwo",
											  editorType:"SelectItem",
											  displayId:"authorizationtwo_div",
											  valueMap:[],
											  value:"${utilization.editPower}",
											  position:"relative",
											  width:"100%",
											  changed:""
								     });
									  MForm0.addField(authorizationtwo);
									  Mauthorizationtwo_VM=<%=request.getAttribute("authorizationvmtwo")%>;
									  Mauthorizationtwo.displayValueMap=<%=request.getAttribute("authorizationvaluetwo")%>;
									  Mauthorizationtwo.setValueMap(Mauthorizationtwo_VM);
									</script>
							    </td>
								
								<td id="td025" class="" style="background-color:rgb(250, 250, 250);border: 1px solid #cccccc;text-align:center;">
									<label id="label025" id="label025" style="white-space: nowrap;">
										修改名称
									</label>
								</td>
								<td id="td125" class="tdLayout" colspan="2" style="width: 50%;">
									<div id="editTitle_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
										<script>
											var editTitle = isc.TextItem.create({
												ID : "MeditTitle",
												name : "editTitle",
												editorType : "TextItem",
												displayId : "editTitle_div",
												position : "relative",
												value : "${utilization.editTitle}",
												width : "100%",
											});
											MForm0.addField(editTitle);
										</script>
								</td>
							</tr>
				
				
							<tr id="tr017">
								<td id="td023" class="maintain_form_label" cowspan="1"
									style="width: 30%;">
									<label id="label010" name="label010" id="label010" style="white-space: nowrap;">
										操作:
									</label>
								</td>
								<td id="td100" class="tdLayout"
									style="padding-left: 2px; padding-top: 2px; border-style: none;; height: 27px; width: 10%;"
									colspan="1"> 
									<div id="checkBoxGroup001_6_div" eventProxy="MForm0"></div>
									<script> var log=isc.CheckboxItem.create({
															ID:"MisAdd",
															name:"isAdd",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_6_div",
															valueMap:{"":false,"1":true},
															title:"添加",
															width : '100%',
															position:"relative",
															//groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(log);
														MForm0.setValue("isAdd","${utilization.isAdd=='false'?'':'1'}");
													</script>
								</td>
								<td id="td102" class="tdLayout"
									style="padding-left: 2px; padding-top: 2px; border-left: 0;border-right: 0; height: 27px; width: 10%;"
									colspan="1">  
									<div id="checkBoxGroup001_7_div" eventProxy="MForm0"></div>
									<script> var log=isc.CheckboxItem.create({
															ID:"MisEdit",
															name:"isEdit",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_7_div",
															valueMap:{"":false,"1":true},
															title:"修改",
															width : '100%',
															position:"relative",
															//groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(log);
														MForm0.setValue("isEdit","${utilization.isEdit=='false'?'':'1'}");
													</script>
								</td>
								<td id="td205" class="tdLayout"
									style="padding-left: 2px; padding-top: 2px; border-style: none;; height: 27px; width: 10%;"
									colspan="1">
									<div id="checkBoxGroup001_1_div" eventProxy="MForm0"></div>
									<script> var del=isc.CheckboxItem.create({
															ID:"Mdel",
															name:"del",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_1_div",
															valueMap:{"":false,"1":true},
															title:"删除",
															width : '100%',
															position:"relative",
															//groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(del);
														MForm0.setValue("del","${utilization.del=='false'?'':'1'}");
													</script>
								</td>
								<td id="td206" class="tdLayout"
									style="padding-left: 2px; padding-top: 2px; border-style: none;; height: 27px; width: 10%;"
									colspan="1">
									<div id="checkBoxGroup001_0_div" eventProxy="MForm0"></div>
									<script> var lock=isc.CheckboxItem.create({
															ID:"Mlock",
															name:"lock",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_0_div",
															valueMap:{"":false,"1":true},
															title:"加锁/解锁",
															width : '100%',
															position:"relative",
															groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(lock);
														MForm0.setValue("lock","${utilization.lock=='false'?'':'1'}");
												</script>
								</td>
								<td id="td207" class="tdlayout"
									style="padding-left: 2px; padding-top: 2px; border-style: none;; height: 27px; width: 10%;"
									colspan="1">
									<div id="checkBoxGroup001_8_div" eventProxy="MForm0"></div>
									<script> var leading=isc.CheckboxItem.create({
															ID:"Mleading",
															name:"leading",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_8_div",
															valueMap:{"":false,"1":true},
															title:"导入",
															width : '100%',
															position:"relative",
															//groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(leading);
														MForm0.setValue("leading","${utilization.importFunc=='false'?'':'1'}");
													</script>
								</td>
								<td id="td204" class="tdLayout"
									style="padding-left: 2px; padding-top: 2px; border-style: none;; height: 27px; width: 10%;"
									colspan="1">
									<div id="checkBoxGroup001_4_div" eventProxy="MForm0"></div>
									<script> var derive=isc.CheckboxItem.create({
															ID:"Mderive",
															name:"derive",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_4_div",
															valueMap:{"":false,"1":true},
															title:"导出",
															width : '100%',
															position:"relative",
															//groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(derive);
														MForm0.setValue("derive","${utilization.export=='false'?'':'1'}");
													</script>
								</td>
								<td id="td203" class="tdLayout"
									style="padding-left: 2px; padding-top: 2px; border-style: none;; height: 27px; width: 10%;"
									colspan="1">
									<div id="checkBoxGroup001_2_div" eventProxy="MForm0"></div>
									<script> var select=isc.CheckboxItem.create({
															ID:"Mselect",
															name:"select",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_2_div",
															valueMap:{"":false,"1":true},
															title:"查询",
															width : '100%',
															position:"relative",
															//groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(select);
														MForm0.setValue("select","${utilization.select=='false'?'':'1'}");
													</script>
								</td>
								
								<td id="td201" class="tdLayout"
									style="padding-left: 2px; padding-top: 2px; border-left-style: none; height: 27px; width: 10%;"
									colspan="1">
									<div id="checkBoxGroup001_5_div" eventProxy="MForm0"></div>
									<script> var print=isc.CheckboxItem.create({
															ID:"Mprint",
															name:"print",
															editorType:"CheckboxItem",
															displayId:"checkBoxGroup001_5_div",
															valueMap:{"":false,"1":true},
															title:"打印",
															width : '100%',
															position:"relative",
															///groupId:"checkBoxGroup001",
															autoDraw:false
														});
														MForm0.addField(print);
														MForm0.setValue("print","${utilization.print=='false'?'':'1'}");
													</script>
								</td>
							</tr>
							<tr id="tr004">
								<td id="td007" class="maintain_form_label"
									style="width: 30%;">
									<label id="label004" name="label004" id="label004" style="white-space: nowrap;">
										系统查询条件:
									</label>
								</td>
								<td id="td008" class="tdLayout" colspan="6"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea003_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var sysQueryCondition = isc.TextAreaItem.create( {
		ID : "MsysQueryCondition",
		name : "sysQueryCondition",
		editorType : "TextAreaItem",
		displayId : "inputTextArea003_div",
		position : "relative",
		canEdit:false,
		autoDraw : false,
		width : '100%',
		height : 50,
		value: "${utilization.sysQueryCondition}"
	});
	MForm0.addField(sysQueryCondition);
</script>
								</td>
								<td id="td020" class="tdLayout" rowspan="1" colspan="2"
									style="width: 20%; border-left: 0;">
									<div id="button005_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
										<script>
	isc.Button.create( {
		ID : "Mbutton005",
		name : "button005",
		title : "设置",
		displayId : "button005_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton005.click = function() {
		Matrix.showMask();
		var x = eval("showSelectCondition();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton005.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
									</div>
								</td>
							</tr>
							
							<!-- 高级查询条件 -->
							<tr id="tr029">
								<td id="td009" class="maintain_form_label"
									style="width: 30%;">
									<label id="label029" name="label029" id="label029" style="white-space: nowrap;">
										高级查询条件:
									</label>
								</td>
								<td id="td030" class="tdLayout" colspan="6"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea029_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
										var sysSeniorCondition = isc.TextAreaItem.create( {
											ID : "MsysSeniorCondition",
											name : "sysSeniorCondition",
											editorType : "TextAreaItem",
											displayId : "inputTextArea029_div",
											position : "relative",
											canEdit:false,
											autoDraw : false,
											width : '100%',
											height : 50,
											value: "${utilization.sysSeniorCondition }"
										});
										MForm0.addField(sysSeniorCondition);
									</script>
								</td>
								<td id="td031" class="tdLayout" rowspan="1" colspan="2"
									style="width: 20%; border-left: 0;">
									<div id="button009_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
										<script>
											isc.Button.create( {
												ID : "Mbutton009",
												name : "button009",
												title : "设置",
												displayId : "button009_div",
												position : "absolute",
												top : 0,
												left : 0,
												width : "100%",
												height : "100%",
												showDisabledIcon : false,
												showDownIcon : false,
												showRollOverIcon : false
											});
											Mbutton009.click = function() {
												Matrix.showMask();
												var x = eval("showSeniorCondition();");
												if (x != null && x == false) {
													Matrix.hideMask();
													Mbutton009.enable();
													return false;
												}
												Matrix.hideMask();
											};
										</script>
									</div>
								</td>
							</tr>

							<tr id="tr007">
								<td id="td013" class="maintain_form_label" colspan="1"
									rowspan="1" style="width: 30%;">
									<label id="label010" name="label010" id="label010" style="white-space: nowrap;">
										应用授权:
									</label>
								</td>
								<td id="td018" colspan="6" rowspan="1" style="width: 50%;">
									<div id="inputTextArea006_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var authority = isc.TextAreaItem.create( {
		ID : "Mauthority",
		name : "authority",
		editorType : "TextAreaItem",
		displayId : "inputTextArea006_div",
		position : "relative",
		autoDraw : false,
		canEdit:false,
		width : '100%',
		height : 50,
		value: "${utilization.authority}"
	});
	MForm0.addField(authority);
</script>
								</td>
								<td id="td023" class="tdLayout" rowspan="1" colspan="2"
									style="width: 20%; border-left: 0;">
									<div id="button008_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
										<script>
	isc.Button.create( {
		ID : "Mbutton008",
		name : "button008",
		title : "设置",
		displayId : "button008_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	Mbutton008.click = function() {
		Matrix.showMask();
		var x = eval("showAddAuthority();");
		if (x != null && x == false) {
			Matrix.hideMask();
			Mbutton008.enable();
			return false;
		}
		Matrix.hideMask();
	};
</script>
									</div>
								</td>
							</tr>
							<tr id="tr008">
								<td id="td015" class="maintain_form_label"
									style="width: 30%;">
									<label id="label008" name="label008" id="label008" style="white-space: nowrap;">
										描述:
									</label>
								</td>
								<td id="td016" class="tdLayout" colspan="8" style="width: 70%;">
									<div id="inputTextArea007_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var desc = isc.TextAreaItem.create( {
		ID : "Mdesc",
		name : "desc",
		editorType : "TextAreaItem",
		displayId : "inputTextArea007_div",
		position : "relative",
		autoDraw : false,
		width : '100%',
		value: "${utilization.description}",
		validators: [{
                         type: "custom",
            condition: function(item, validator, value, record) {
                if(value!=null||value.length>0){
                	var pattern = new RegExp("[`~!@#$^&*()=|{}':'\\[\\]<>/~！@#￥……&*（）——|{}【】‘：”“？]");
					if(pattern.test(value))
					{
						validator.errorMessage="不能输入非法字符!";
						return false;
					} else 
					return true;
			  		}
            },
           errorMessage: "不能输入非法字符!"
         }]
	});
	MForm0.addField(desc);
</script>
								</td>
							</tr>
							<tr>
							    <td style="height:30px;"></td>
							</tr>
							<tr id="tr009">
								<td id="td017" class="cmdLayout" colspan="8"
									style="width: 100%;">
									<div id="button001_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
										<script>isc.Button.create({
							ID:"Mbutton001",
							name:"button001",
							title:"保存",
							displayId:"button001_div",
							position:"absolute",
							top:0,left:0,
							width:"100%",
							height:"100%",
							//icon:"[skin]/images/matrix/actions/save.png",
							showDisabledIcon:false,
							showDownIcon:false,
							showRollOverIcon:false});
							Mbutton001.click = function() {
							debugger;
		Matrix.showMask();
		//表单验证
		if (!MForm0.validate()) {
			Matrix.hideMask();
			return false;
		}

		//异步重复验证

		addOrUpdateQuerySubmit();

		Matrix.hideMask();
	};</script>
									</div>
								</td>
							</tr>
						</table>
						<script>
	function getParamsForaddAuthority() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MaddAuthority",
		id : "addAuthority",
		name : "addAuthority",
		autoCenter : true,
		position : "absolute",
		height : "90%",
		width : "80%",
		title : "查询授权",
		canDragReposition : true,
		targetDialog : "CodeMain",
		showMinimizeButton : true,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
		showFooter : false
	});
</script>
						<script>
	MaddAuthority.hide();
</script>
						<script>
	function getParamsForoutData() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MoutData",
		id : "outData",
		name : "outData",
		autoCenter : true,
		position : "absolute",
		height : "80%",
		width : "75%",
		title : "输出数据项",
		canDragReposition : true,
		targetDialog : "CodeMain",
		showMinimizeButton : true,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
		showFooter : false
	});
</script>
						<script>
	MoutData.hide();
</script>
						<script>
	function getParamsForsetSort() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MsetSort",
		id : "setSort",
		name : "setSort",
		autoCenter : true,
		position : "absolute",
		height : "90%",
		width : "70%",
		title : "排序设置",
		canDragReposition : true,
		targetDialog : "CodeMain",
		showMinimizeButton : true,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
		showFooter : false
	});
</script>
						<script>
	MsetSort.hide();
</script>
						<script>
	<%-- 
	function getParamsForselectCondition() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MselectCondition",
		id : "selectCondition",
		name : "selectCondition",
		autoCenter : true,
		position : "absolute",
		height : "90%",
		width : "70%",
		title : "系统查询条件",
		canDragReposition : true,
		targetDialog : "CodeMain",
		showMinimizeButton : true,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
		showFooter : false
	});
</script>
						<script>
	MselectCondition.hide();
	--%>
</script>
<script>
							function getParamsForselectCondition() {
								var params = '&';
								var value;
								return params;
							}
							isc.Window.create( {
								ID : "MhignCondition",
								id : "hignCondition",
								name : "hignCondition",
								autoCenter : true,
								position : "absolute",
								height : "90%",
								width : "70%",
								title : "高级查询条件",
								canDragReposition : false,
								targetDialog : "CodeMain",
								showMinimizeButton : true,
								showMaximizeButton : true,
								showCloseButton : true,
								showModalMask : false,
								modalMaskOpacity : 0,
								isModal : true,
								autoDraw : false,
								headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
										"maximizeButton", "closeButton" ],
								showFooter : false
							});
						</script>
						<script>
						     MhignCondition.hide();
						</script>
						<script>
	function getParamsForaddform() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "Maddform",
		id : "addform",
		name : "addform",
		autoCenter : true,
		position : "absolute",
		height : "90%",
		width : "50%",
		title : "选择新建表单",
		canDragReposition : true,
		targetDialog : "CodeMain",
		showMinimizeButton : true,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
				initSrc : "<%=request.getContextPath()%>/form/admin/custom/queryList/formId.jsp?rootMid=flowdesign&rootEntityId=402881e84efc96f1014efc9912e20002",
		src : "<%=request.getContextPath()%>/form/admin/custom/queryList/formId.jsp?rootMid=flowdesign&rootEntityId=402881e84efc96f1014efc9912e20002",
		showFooter : false
	});
</script>
						<script>
	Maddform.hide();
</script>
						<script>
	function getParamsForeditform() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "Meditform",
		id : "editform",
		name : "editform",
		autoCenter : true,
		position : "absolute",
		height : "90%",
		width : "50%",
		title : "选择修改表单",
		canDragReposition : true,
		targetDialog : "CodeMain",
		showMinimizeButton : true,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
		initSrc : "<%=request.getContextPath()%>/form/admin/custom/queryList/formId.jsp?rootMid=flowdesign&rootEntityId=402881e84efc96f1014efc9912e20002",
		src : "<%=request.getContextPath()%>/form/admin/custom/queryList/formId.jsp?rootMid=flowdesign&rootEntityId=402881e84efc96f1014efc9912e20002",
		showFooter : false
	});
</script>
						<script>
	Meditform.hide();
</script>
						<script>
	function getParamsForcustomQuery() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "McustomQuery",
		id : "customQuery",
		name : "customQuery",
		autoCenter : true,
		position : "absolute",
		height : "90%",
		width : "50%",
		title : "自定义查询项",
		canDragReposition : true,
		targetDialog : "CodeMain",
		showMinimizeButton : true,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
		showFooter : false
	});
</script>
						<script>
	McustomQuery.hide();
</script>
					</div>


				</div>
				<script>
	document.getElementById('tabContainer0Panel0_div').appendChild(
			document.getElementById('tabContainer0Panel0_div2'));
	document.getElementById('tabContainer0_div').style.display = '';
</script>
			</form>
			<script>
	MForm0.initComplete = true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
</script>
		</div>

	</body>
</html>