<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>添加查询!</title>
		<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
	
		<script type="text/javascript">
		window.onload=function(){
			parent.parent.showListName=[];
			parent.parent.showMobileListName=[];
			parent.parent.customCondition=[];
			parent.parent.sortName=[];
			parent.parent.userInputCondition=[]; 
			parent.parent.hignCondition = {};
			parent.parent.authUser = {};
			
			var oType = "${param.oType}";
			var formId = "${param.formId}";
			if(oType=='add'){
				var url = "<%=request.getContextPath()%>/query/query_addBefore.action?formId="+formId;
				Matrix.sendRequest(url,null,function(data){
					 if(data!=null){
						 var str = data.data;
						 if(str != null && str != ""){
							 var obj = JSON.parse(str);
							 var returnshuzu= obj.returnshuzu;
							 var returnjson= obj.returnjson;

							 Mauthorization.displayValueMap=returnjson;																					
							 Mauthorization.setValueMap(returnshuzu);
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
					var url='<%=request.getContextPath()%>/query/query_saveOption.action';		     	
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
			form0.action = "query/query_updateQuery.action"
			form0.submit();
		}

	}
		//弹出系统查询条件
		function showSelectCondition(){
			var flag =Matrix.getFormItemValue('flag');
			var firstCondition =Matrix.getFormItemValue('sysQuerCondition');
			var formFlag="${param.formFlag}";
			var formId="${param.formId}";
			parent.openQuerySysCondiation(formFlag,flag,formId,firstCondition);
		}
		
		//弹出用户输入条件
		function showInputCondition(){ 
			var string=Matrix.getFormItemValue('userInputCondition');
			var value=Matrix.getFormItemValue('userInputConditionVal');
	    	var sortName=string.split(",");
	    	var flag =Matrix.getFormItemValue('flag');
	    	var userInputConditionVal=value.split(",");
	    	if(string!=null&&string!=""){
	    		var list=[];
				for(var i=0;i<sortName.length;i++){
					var newdata={};
					if(sortName[i]!=""&&typeof(sortName[i])!="undefined"&&userInputConditionVal[i]!=""&&typeof(userInputConditionVal[i])!="undefined"){
						var resl=userInputConditionVal[i].split(":");
			  			newdata.name=sortName[i];
			  			newdata.formId=resl[0];
			  			newdata.operator=resl[1];
			  			list.add(newdata);
		  			}
		  		}
		  		parent.parent.userInputCondition=list;
	  		}
	    	var formFlag="${param.formFlag}";
			var formId="${param.formId}";
	    	parent.openInputCondition(formFlag,flag,formId);
		}
		
		
		//电脑端弹出输出数据项窗口
		function showOutData(){
			var flag =Matrix.getFormItemValue('flag');
			var string=Matrix.getFormItemValue('showListName');
			var value=Matrix.getFormItemValue('showListVal');
    		var result=string.split(",");
    		var list=[];
    		if(value!=null&&value!=""&&value.length>0){
	    		list=eval('(' + value + ')');
	    		parent.parent.showListName=list;
    		}
    		var formFlag = "${param.formFlag}";
	    	var mBizId = "${param.uuid}";
	    	var formId = "${param.formId}";
    		parent.openOutData(formFlag,mBizId,formId,flag);
		}
		
		//移动端输出数据项
		function showMobileOutData(){
			var flag =Matrix.getFormItemValue('flag');
			var string=Matrix.getFormItemValue('showMobileListName');
			var value=Matrix.getFormItemValue('showMobileListVal');
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
			var string=Matrix.getFormItemValue('customCondition');
			var value=Matrix.getFormItemValue('customQueryValue');
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
			McustomQuery.initSrc="<%=request.getContextPath()%>/form/admin/custom/queryList/customCondition.jsp?formFlag=${param.formFlag}&flag="+flag+"&formId=${param.formId}";
			McustomQuery.src="<%=request.getContextPath()%>/form/admin/custom/queryList/customCondition.jsp?formFlag=${param.formFlag}&flag="+flag+"&formId=${param.formId}";
		Matrix.showWindow('customQuery');
		}
		
		
		//弹出排序设置窗口
		function showSetSort(){
			//数据回掉
			var string=Matrix.getFormItemValue('sortName');
			var value=Matrix.getFormItemValue('sortContent');
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
	  		var displayItemsVal = Matrix.getFormItemValue('showListVal');
//			if(displayItemsVal==""||displayItemsVal==null||displayItemsVal=='undefined'){
//				warn("请先选择输出数据项!");
//			}else{
				var displayItems=Matrix.getFormItemValue('showListName');
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
				parent.openSetSort(formFlag,mBizId,formId);
		    }
//		}
		
		//弹出查询授权窗口
			function showAddAuthority(){
			if(document.getElementById("authId").value!=null&&document.getElementById("authId").value!=""){
				parent.parent.authUser.areaIds = document.getElementById("authId").value;
				parent.parent.authUser.areaName = Matrix.getFormItemValue("authValue");
			}else{
				parent.authUser=null;
			}	
			 parent.openAddAuthority();
			}
			
			
		//授权
		function onaddAuthorityClose(data){
	 		if(data!=null){
	     		var userNames = data.allNames;
	            var adminId = data.allIds;
	          	Matrix.setFormItemValue('authId',adminId);
	 			Matrix.setFormItemValue('authValue',userNames);
	 			parent.parent.authUser = {};
			}else{
				//Matrix.setFormItemValue('authId',"");
	 			//Matrix.setFormItemValue('authValue',"");
	 			//parent.parent.authUser = {};
			}
   	 	}
			
		//系统查询条件
		function onselectConditionClose(data){
      if(data!=null && data!=""){
		var data=eval("("+data+")")
      	Matrix.setFormItemValue('sysQuerCondition',data.conditionText);
		Matrix.setFormItemValue('sysQuerConditionVal',data.conditionVal);
      }else if(typeof(data) == "undefined"){
	
	  }else{
		Matrix.setFormItemValue('sysQuerCondition',"");
		Matrix.setFormItemValue("sysQuerConditionVal","");
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
				if(resl[0]!='{param.formFlag}'){
					Matrix.setFormItemValue('flag',resl[0]);
				}
			}
				if(i==selectedItems.length-1){
					data+=selectedItems[i].name;
					//data+=',';
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
      		Matrix.setFormItemValue('showListName',data);
			Matrix.setFormItemValue('showListVal',value);
			parent.parent.showListName=[];
			}else{
				Matrix.setFormItemValue('showListName',"");
			Matrix.setFormItemValue('showListVal',"");
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
					//data+=',';
					value+=selectedItems[i].formId;
					value+=',';
				}else{
					data+=selectedItems[i].name;
					data+=',';
					value+=selectedItems[i].formId;
					value+=',';
				}
			}
      	Matrix.setFormItemValue('customCondition',data);
		Matrix.setFormItemValue('customQueryValue',value);
		
      }else{
		Matrix.setFormItemValue('customCondition',"");
		Matrix.setFormItemValue('customQueryValue',"");
		} 
		parent.parent.customCondition=[]; 
	}
	//排序设置
	function onSetSortClose(selectedItems){
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
      	Matrix.setFormItemValue('sortName',data);
		Matrix.setFormItemValue('sortContent',value);
		}else{
		Matrix.setFormItemValue('sortName',"");
		Matrix.setFormItemValue('sortContent',"");
	  } 
		
      } 
	parent.parent.sortName=[];
	}
	//用户条件
		function oninputConditionClose(selectedItems){
      if(selectedItems!=null && selectedItems!=""){
			if(selectedItems!=true){
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
						if(selectedItems[i].operator!="undefined"){
							value+=selectedItems[i].operator;
						}else{
							value+="";
						}
						value+=',';
				}else{
						data+=selectedItems[i].name;
						data+=',';
						value+=selectedItems[i].formId;
						value+=':';
						if(selectedItems[i].operator!="undefined"){
							value+=selectedItems[i].operator;
						}else{
							value+="";
						}
						value+=',';
				}
			}
      	Matrix.setFormItemValue('userInputCondition',data);
		Matrix.setFormItemValue('userInputConditionVal',value);
		}else{
		Matrix.setFormItemValue('userInputCondition',"");
		Matrix.setFormItemValue('userInputConditionVal',"");
	  	}  
      }
		parent.parent.userInputCondition=[];
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
				action="<%=request.getContextPath()%>/query/query_addQuery.action"
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
				<input type="hidden" id="order" name="order" value="" />
				<input name="showListVal" id="showListVal" type="hidden" value="${queryList.showListVal}" />
				<input name="showMobileListVal" id="showMobileListVal" type="hidden" value="${queryList.showMobileListVal}" />
				<input name="customQueryValue" id="customQueryValue" type="hidden"
					value="${queryList.customQueryValue}" />
				<input name="sortContent" id="sortContent" type="hidden"
					value="${queryList.sortContent}" />
				<input name="authId" id="authId" type="hidden"
					value="${queryList.authId}" />
				<input name="catalogId" id="catalogId" type="hidden"
					value="${param.catalogId}" />
				<input name="formId" id="formId" type="hidden"
					value="${param.formId}" />
				<input name="userInputConditionVal" id="userInputConditionVal"
					type="hidden" value="${queryList.userInputConditionVal}" />
				<input name="sysSeniorConditionVal" id="sysSeniorConditionVal"
					type="hidden" value="${queryList.sysSeniorConditionVal }" />
				<input name="sysQuerConditionVal" id="sysQuerConditionVal"
					type="hidden" value="${queryList.sysQuerConditionVal}" />
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
					title : ("add" == "${param.oType}") ? "添加查询" : "更新查询",
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
					style="width: 100%; height: 100%; overflow: hidden;"
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
										查询模板名称:
									</label>
								</td>
								<td id="td002" class="tdLayout" colspan="2" style="width: 70%;">
									<div id="input001_div" eventProxy="MForm0" class="matrixInline"
										style="width: 70%;"></div>
									<script>
										var name2 = isc.TextItem.create( {
											ID : "Mname",
											name : "name",
											editorType : "TextItem",
											displayId : "input001_div",
											position : "relative",
											autoDraw : false,
											width : "100%",
											value: "${queryList.queryName}",
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
										电脑端输出数据项:
									</label>
								</td>
								<td id="td004" style="">
									<div id="inputTextArea001_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
										var showListName = isc.TextAreaItem.create( {
											ID : "MshowListName",
											name : "showListName",
											editorType : "TextAreaItem",
											displayId : "inputTextArea001_div",
											position : "relative",
											autoDraw : false,
											canEdit:false,
											width : '100%',
											height : 50,
											value: "${queryList.showListName}",
											required:true
										});
										MForm0.addField(showListName);
									</script>
								</td>
								<td id="td014" class="tdLayout" rowspan="1"
									style="width: 20%; border-left: 0;">
									<div id="button003_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
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
										移动端输出数据项:
									</label>
								</td>
								<td id="td041" style="">
									<div id="inputTextArea008_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
										var showMobileListName = isc.TextAreaItem.create( {
											ID : "MshowMobileListName",
											name : "showMobileListName",
											editorType : "TextAreaItem",
											displayId : "inputTextArea008_div",
											position : "relative",
											autoDraw : false,
											canEdit:false,
											width : '100%',
											height : 50,
											value: "${queryList.showMobileListName}",
											required:false
										});
										MForm0.addField(showMobileListName);
									</script>
								</td>
								<td id="td014" class="tdLayout" rowspan="1"
									style="width: 20%; border-left: 0;">
									<div id="button010_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
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
								<td id="td006" class="tdLayout" colspan="1"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea002_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
										var sortName = isc.TextAreaItem.create( {
											ID : "MsortName",
											name : "sortName",
											editorType : "TextAreaItem",
											displayId : "inputTextArea002_div",
											position : "relative",
											autoDraw : false,
											canEdit:false,
											width : '100%',
											height : 50,
											value: "${queryList.sortName}"
										});
										MForm0.addField(sortName);
									</script>
								</td>
								<td id="td019" class="tdLayout" rowspan="1"
									style="width: 20%; border-left: 0;">
									<div id="button004_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
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
							<tr id="tr010">
								<td id="td027" class="maintain_form_label"
									style="width: 30%;">
									<label id="label004" name="label004" id="label004" style="white-space: nowrap;">
										授权:
									</label>
								</td>
								<td id="tdtd028" class="tdLayout" colspan="2" style="">
									<div id="authorization_div" eventProxy="MForm0"
											class="matrixInline" style="width: 20%;"></div>
									<script>
									var Mauthorization_VM=[];
									var authorization=isc.SelectItem.create({
											  ID:"Mauthorization",
											  name:"authorization",
											  editorType:"SelectItem",
											  displayId:"authorization_div",
											  valueMap:[],
											  value:"${queryList.power}",
											  position:"relative",
								     });
									  MForm0.addField(authorization);
									  Mauthorization_VM=<%=request.getAttribute("authorizationvm")%>;
									  Mauthorization.displayValueMap=<%=request.getAttribute("authorizationvalue")%>;
									  Mauthorization.setValueMap(Mauthorization_VM);
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
								<td id="td008" class="tdLayout" colspan="1"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea003_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
										var sysQuerCondition = isc.TextAreaItem.create( {
											ID : "MsysQuerCondition",
											name : "sysQuerCondition",
											editorType : "TextAreaItem",
											displayId : "inputTextArea003_div",
											position : "relative",
											canEdit:false,
											autoDraw : false,
											width : '100%',
											height : 50,
											value: "${queryList.sysQuerCondition}"
										});
										MForm0.addField(sysQuerCondition);
									</script>
								</td>
								<td id="td020" class="tdLayout" rowspan="1"
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
							<tr id="tr005">
								<td id="td009" class="maintain_form_label"
									style="width: 30%;">
									<label id="label006" name="label006" id="label006" style="white-space: nowrap;">
										用户输入条件:
									</label>
								</td>
								<td id="td010" class="tdLayout" colspan="1"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea004_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
										var userInputCondition = isc.TextAreaItem.create( {
											ID : "MuserInputCondition",
											name : "userInputCondition",
											editorType : "TextAreaItem",
											displayId : "inputTextArea004_div",
											position : "relative",
											canEdit:false,
											autoDraw : false,
											width : '100%',
											height : 50,
											value: "${queryList.userInputCondition}"
										});
										MForm0.addField(userInputCondition);
									</script>
								</td>
								<td id="td021" class="tdLayout" rowspan="1"
									style="width: 20%; border-left: 0;">
									<div id="button006_div" class="matrixInline"
										style="position: relative;; width: 100px;; height: 22px;">
										<script>
											isc.Button.create( {
												ID : "Mbutton006",
												name : "button006",
												title : "设置",
												displayId : "button006_div",
												position : "absolute",
												top : 0,
												left : 0,
												width : "100%",
												height : "100%",
												showDisabledIcon : false,
												showDownIcon : false,
												showRollOverIcon : false
											});
											Mbutton006.click = function() {
												Matrix.showMask();
												var x = eval("showInputCondition();");
												if (x != null && x == false) {
													Matrix.hideMask();
													Mbutton006.enable();
													return false;
												}
												Matrix.hideMask();
											};
										</script>
									</div>
								</td>
							</tr>
							<tr id="tr029">
							    <td id="td009" class="maintain_form_label"
									style="width: 30%;">
									<label id="label029" name="label029" id="label029" style="white-space: nowrap;">
										高级查询条件:
									</label>
								</td>
								<td id="td030" class="tdLayout" colspan="1"
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
											value: "${queryList.sysSeniorCondition}"
										});
										MForm0.addField(sysSeniorCondition);
									</script>
								</td>
								<td id="td031" class="tdLayout" rowspan="1"
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
							<!--  
							<tr id="tr006">
								<td id="td011" class="maintain_form_label"
									style="width: 30%; text-align: left;">
									<label id="label007" name="label007" id="label007">
										自定义查询项:
									</label>
								</td>
								<td id="td012" class="tdLayout" colspan="1"
									style="width: 50%; border-right: 0;">
									<div id="inputTextArea005_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var customCondition = isc.TextAreaItem.create( {
		ID : "McustomCondition",
		name : "customCondition",
		editorType : "TextAreaItem",
		displayId : "inputTextArea005_div",
		position : "relative",
		canEdit:false,
		autoDraw : false,
		width : '100%',
		value: "${queryList.customCondition}",
		height : 50
	});
	MForm0.addField(customCondition);
</script>
								</td>
								<td id="td022" class="tdLayout" rowspan="1"
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
							</tr>-->
							<tr id="tr007">
								<td id="td013" class="maintain_form_label" colspan="1"
									rowspan="1" style="width: 30%; ">
									<label id="label010" name="label010" id="label010" style="white-space: nowrap;">
										查询授权:
									</label>
								</td>
								<td id="td018" colspan="1" rowspan="1" style="width: 50%;">
									<div id="inputTextArea006_div" eventProxy="MForm0"
										class="matrixInline" style="width: 100%;"></div>
									<script>
	var authValue = isc.TextAreaItem.create( {
		ID : "MauthValue",
		name : "authValue",
		editorType : "TextAreaItem",
		displayId : "inputTextArea006_div",
		position : "relative",
		autoDraw : false,
		canEdit:false,
		width : '100%',
		height : 50,
		value: "${queryList.authValue}"
	});
	MForm0.addField(authValue);
</script>
								</td>
								<td id="td023" class="tdLayout" rowspan="1"
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
									style="width: 30%; ">
									<label id="label008" name="label008" id="label008" style="white-space: nowrap;">
										描述:
									</label>
								</td>
								<td id="td016" class="tdLayout" colspan="2" style="width: 70%;">
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
		value: "${queryList.description}",
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
							<tr id="tr009">
								<td id="td017" class="cmdLayout" colspan="3"
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
												};
										</script>
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
							MselectCondition.hide();
							--%>
						</script>
						<script>
							function getParamsForinputCondition() {
								var params = '&';
								var value;
								return params;
							}
							isc.Window.create( {
								ID : "MinputCondition",
								id : "inputCondition",
								name : "inputCondition",
								autoCenter : true,
								position : "absolute",
								height : "90%",
								width : "70%",
								title : "用户输入条件",
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
							MinputCondition.hide();
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