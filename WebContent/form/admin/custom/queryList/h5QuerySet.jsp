<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>查询设置详细信息页面<</title>
	<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath() %>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath() %>/resource/html5/css/custom.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>
	<!-- bootstrap select和layer资源 -->
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
	<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
	<!-- iCheck资源 -->
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/icheck.min.js'></SCRIPT>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/autosize.min.js'></SCRIPT>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
	
	<style type="text/css">
	*{
		-webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
	body, ul{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	}
	div, ul{
		box-sizing: border-box;
	}
	label {
	    height: 30px;
	    line-height: 30px;
	    font-size: 14px;
	    font-weight: 700;
	}
	#container{
	    position: absolute;
	    height: 100%;
	    width: 100%;
	    overflow: hidden;
	}
	.tdLabelCls {
	    text-align: center;
	    height: 36px;
	    color: rgb(74, 77, 74);
	    background-color: white;
	    font-weight: normal;
	    font-family: 微软雅黑;
	    font-size: 12px;
	    margin: 0px;
	    border-width: 0px;
	    border-style: solid;
	    border-color: rgb(204, 204, 204);
	    border-image: initial;
	    padding: 5px 0px; 
	}
	.tdValueCls {
	    //text-align: left;
	    text-align: center;
	    //border: 1px solid #000000;
	    -moz-height: auto;
	    margin: 0;
	    height: 36px;
	    //padding: 2px 2px 2px 2px;
	    border: 0px solid #cccccc;
	    margin: 0;
	    FONT-WEIGHT: normal;
	    FONT-FAMILY: 微软雅黑;
	    FONT-SIZE: 12px;
	    padding: 5px 0px; 
	}
	.mask{
		position:absolute;
		width:100%;
		height:100%;
		z-index:1;
		filter:alpha(opacity=0);
		opacity:0;
		background:#ffffff
	}
	</style>
	<script type="text/javascript">
		$(function(){
			debugger;
			var oType = $('#oType').val();
			var formId = $('#formId').val();
			var catalogId = $('#catalogId').val();
			if(oType=='add'){   //添加查询设置
				$('#cancel').css('display','');
				var url = "<%=request.getContextPath()%>/query/query_initOption.action?catalogId="+catalogId+"&formId="+formId;
				Matrix.sendRequest(url,null,function(data){
					 if(data!=null){
						 var str = data.data;
						 if(str != null && str != ""){
							 var obj = JSON.parse(str);
							 var authjson = obj.authjson;   //授权编码+名称
						
							 for(var i in authjson){
								 $("#authorization").append("<option value="+i+">"+authjson[i]+"</option>");
							 }
							 $('.selectpicker').selectpicker('refresh');//动态刷新
						 }
					 }
			  });
	    	}else if(oType=='update'){   //更新查询设置
	    		$('#cancel').css('display','none');
	    		var power = "${query.power}";
	    		var authjsonstr = '${authjson}';
	    		var authjson = JSON.parse(authjsonstr);   //保存的授权编码+名称
	    		
	    		for(var i in authjson){
					 $("#authorization").append("<option value="+i+">"+authjson[i]+"</option>");	
			    }
	    		//设置选中
	    		$("#authorization option[value='"+power+"']").attr("selected", true);
	    		
	    		$('.selectpicker').selectpicker('refresh');//动态刷新
	    	}
			
			 
			$("#save").on("click",function(){
	     		Matrix.showMask2();
	    		//表单验证
	    		if (!Matrix.validateForm('form0')) {
	    			Matrix.hideMask2();
	    			return false;
	    		}
	    		//名称验证
	    		if(validation()){
	    			//保存
	    			saveQuery();
	    		}else{
	    			Matrix.hideMask2();
	    		}
	        });
			var uuid = $('#uuid').val();
			var formId = $('#formId').val();
			if(uuid != null && uuid != ''){
				document.getElementById('preview').src = "<%=request.getContextPath()%>/matrix.rform?configUUID="+uuid+"&formId="+formId+"&mIsQueryMode=true&isDesignTime=true&mHtml5Flag=true";
			}
		})
		
		//校验
		function validation(){
			var value = $('#name').val();
			var pattern = new RegExp("[`~!@#$^&*=|{}':'\\[\\]<>/~！@#￥……&*（）——|{}【】‘：”“？]");
			if(pattern.test(value)){
				Matrix.warn("名称不能输入非法字符！");
				return false;
			}else if(value.length>100){
				Matrix.warn("名称长度不能大于100！");
				return false;
			}else{
				return true;
			}
		}
		
		//电脑端输出数据项弹出窗口
		function showOutData(){
			var flag = Matrix.getFormItemValue('flag');
			var string=Matrix.getFormItemValue('showListName');
			var value=Matrix.getFormItemValue('showListVal');
    		var result = string.split(",");
    		var list=[];
    		if(value!=null&&value!=""&&value.length>0){
	    		list=eval('(' + value + ')');
	    		parent.parent.showListName=list;
    		}
	    	var formFlag = $('#formFlag').val();
	    	var mBizId = $('#uuid').val();
	    	var formId = $('#formId').val();
	    	parent.iframeJs = this;
			parent.layer.open({
				 id:'layer01',
				 type : 2,
				 
				 title : ['电脑端设置输出数据项'],
				 shade: [0.1, '#000'],
				 shadeClose: false, //开启遮罩关闭
				 area : [ '60%', '80%' ],
				 content : "<%=request.getContextPath()%>/form/admin/custom/queryList/outData.jsp?formFlag="+formFlag+"&flag="+flag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer01"
			 });
		}
		
		//电脑端输出数据项弹出窗口回调
		function onlayer01Close(selectedItems){
	       if(selectedItems!=null && selectedItems!=""){
				if(selectedItems!=true){
				var data="";
				var value="["
				var sign=Matrix.getFormItemValue('flag');
				for(var i=0;i<selectedItems.length;i++){
					var resl=selectedItems[i].formId.split(".");
					if(sign==""||sign==null||sign=='undefined'){
					var formFlag = $('#formFlag').val();
					if(resl[0]!=formFlag){
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
				}else{
					Matrix.setFormItemValue('showListName',"");
					Matrix.setFormItemValue('showListVal',"");
			 }  
	      }
	   }
		
		//移动端输出数据项弹出窗口
		function showMobileOutData(){
			 var flag = Matrix.getFormItemValue('flag');
			 var string=Matrix.getFormItemValue('showMobileListName');
			 var value=Matrix.getFormItemValue('showMobileListVal');
	    	 var result=string.split(",");
	    	 var list=[];
	    	 if(value!=null&&value!=""&&value.length>0){
		    	list=eval('(' + value + ')');
		    	parent.parent.showMobileListName=list;
	    	 }	
	    	 var formFlag = $('#formFlag').val();
		     var mBizId = $('#uuid').val();
		     var formId = $('#formId').val();
		     parent.iframeJs = this;
		     parent.layer.open({
				    id:'layer02',
					type : 2,
					
					title : ['设置移动端输出数据项'],
					shade: [0.1, '#000'],
					shadeClose: false, //开启遮罩关闭
					area : [ '60%', '80%' ],
					content : "<%=request.getContextPath()%>/form/admin/custom/queryList/mobileOutData.jsp?formFlag="+formFlag+"&flag="+flag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer02"
			 });
		}
		
		//移动端弹出输出数据项窗口回调
		function onlayer02Close(selectedItems){
	      if(selectedItems!=null && selectedItems!=""){
				if(selectedItems!=true){
				var data="";
				var value="["
				var sign=Matrix.getFormItemValue('flag');
				for(var i=0;i<selectedItems.length;i++){
					var resl=selectedItems[i].formId.split(".");
					if(sign==""||sign==null||sign=='undefined'){
					var formFlag = $('#formFlag').val();
					if(resl[0]!=formFlag){
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
		      		Matrix.setFormItemValue('showMobileListName',data);
					Matrix.setFormItemValue('showMobileListVal',value);
				}else{
					Matrix.setFormItemValue('showMobileListName',"");
					Matrix.setFormItemValue('showMobileListVal',"");
			 }  
	      }
	   }
		
	  //弹出排序设置窗口
	  function showSetSort(){
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
  						list.push(newdata);
  				    }
  			    }
				parent.parent.sortName=list;
  		    }
    		var displayItemsVal = Matrix.getFormItemValue('showListVal');
    		var displayItems=Matrix.getFormItemValue('showListName');
    		var result=displayItems.split(",");
    		var showListValue;
	    	var sortdata=[];
    		if(displayItemsVal!=null&&displayItemsVal!=""&&displayItemsVal.length>0){
    			sortdata=eval('(' + displayItemsVal + ')');
    			parent.parent.showListName=sortdata;
    		}
    	
    		var formFlag = $('#formFlag').val();
		    var mBizId = $('#uuid').val();
		    var formId = $('#formId').val();
		    parent.iframeJs = this;
		    parent.layer.open({
				id:'layer03',
				type : 2,
				
				title : ['设置输出数据项排序'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '60%', '80%' ],
				content : "<%=request.getContextPath()%>/form/admin/custom/queryList/sortSet.jsp?formFlag="+formFlag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer03"
			});
	} 
	  
	//弹出排序设置窗口回调
	function onlayer03Close(selectedItems){
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
	}
	
	//弹出系统查询条件窗口
	function showSelectCondition(){ 
		var flag =Matrix.getFormItemValue('flag');
		var firstCondition =Matrix.getFormItemValue('sysQuerCondition');
		var formFlag = $('#formFlag').val();
	    var formId = $('#formId').val();
	    parent.iframeJs = this;
	    parent.layer.open({
	    	id:'layer04',
			type : 2,
			
			title : ['设置系统查询条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : "<%=path%>/condition/condition_loadConditionSet.action?iframewindowid=layer04&entrance=QuerySysCondition&formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&firstCondition="+encodeURI(firstCondition)
		});			
	}
	
	//弹出系统查询条件回调
    function onlayer04Close(data){
		if(data!=null && data!=""){
	      	Matrix.setFormItemValue('sysQuerCondition',data.conditionText);
			Matrix.setFormItemValue('sysQuerConditionVal',data.conditionVal);
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
		 
		  			list.push(newdata);
	  			}
	  		}
	  		parent.parent.hignCondition=list;
  		}
    	
    	var flag =Matrix.getFormItemValue('flag');
    	var formFlag = $('#formFlag').val();
	    var formId = $('#formId').val();
	    parent.iframeJs = this;
	    parent.layer.open({
		    id:'layer05',
			type : 2,
			
			title : ['设置高级查询条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : "<%=request.getContextPath()%>/form/admin/custom/queryList/seniorSelectCondition.jsp?formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&iframewindowid=layer05"
	 });
    
	}

	//高级查询条件回调
   function onlayer05Close(selectedItems){
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
    }
	
   //弹出查询授权窗口
   function showAddAuthority(){
	    parent.authUser.areaIds = document.getElementById("authId").value;      //编码
		parent.authUser.areaName = Matrix.getFormItemValue("authValue");  //名称
	    parent.iframeJs = this;
	    parent.layer.open({
		    id:'layer06',
			type : 2,
			
			title : ['设置查询授权'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : '<%=request.getContextPath()%>/office/html5/select/MixSelect.jsp?iframewindowid=layer06'
	   });
	}
   
 	//弹出查询授权窗口回调
	function onlayer06Close(data){
		if(data!=null && data!=''){
			var userNames = data.allNames;
	        var adminId = data.allIds;
	        Matrix.setFormItemValue('authId',adminId);
	        Matrix.setFormItemValue('authValue',userNames);
		}
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
		  			list.push(newdata);
	  			}
	  		}
	  		parent.parent.userInputCondition=list;
  		}
		var flag = Matrix.getFormItemValue('flag');
    	var formFlag = $('#formFlag').val();
	    var formId = $('#formId').val();
	    parent.iframeJs = this;
	    parent.layer.open({
		    id:'layer07',
			type : 2,
			
			title : ['设置用户输入条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : "<%=request.getContextPath()%>/form/admin/custom/queryList/term.jsp?formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&iframewindowid=layer07"
	 });
	}
	
	//用户输入条件窗口回调
	function onlayer07Close(selectedItems){
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
	}
	
	//保存
	function saveQuery() {
		//操作类型
		var oType = $('#oType').val();
		var url;
		if(oType == "add") { //添加
			url = "<%=request.getContextPath()%>/query/query_h5AddQuery.action"
		}else if(oType == "update"){ //更新
			url = "<%=request.getContextPath()%>/query/query_h5UpdateQuery.action"
		}
		var synJson = Matrix.formToObject("form0");
		Matrix.sendRequest(url,synJson,function(data){
			if(data != null && data.data != null){
				var json = isc.JSON.decode(data.data);
				if(json.result){
					//刷新下拉框 并设置选中
					parent.parent.$("#module_div").remove();
					var uuid = $('#uuid').val();  //查询设置主键 即下拉框的value
					parent.parent.getData(uuid,oType);
					
					//刷新预览区域
					var formId = $('#formId').val();
					if(uuid != null && uuid != ''){
						document.getElementById('preview').src = "<%=request.getContextPath()%>/matrix.rform?configUUID="+uuid+"&formId="+formId+"&mIsQueryMode=true&isDesignTime=true&mHtml5Flag=true";
					}
				}else{
					Matrix.warn("该查询设置已存在，请更换名称");
				}
			}
			Matrix.hideMask2();
		});
	}
	
	//取消
	function cancel(){
		parent.parent.$("#module_div").remove();
		parent.parent.$('#toolbar').css('display','');  //显示操作下拉菜单
		parent.parent.getData('selectOne','init');
	}
</script>
</head>
 <body>
	<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="form0" name="form0" value="form0" /> 
		<!-- 校验 -->
		<input type="hidden" id="validateType" name="validateType" value="jquery" />  
		<!-- 记录的查询名称 -->
		<input type="hidden" id="oldName" name="oldName" value="${query.queryName}" />  
		<!-- 操作类型  add添加  update修改 -->
		<input type="hidden" id="oType" name="oType" value="${param.oType }"/>   
		<!-- 表单编码 -->
		<input type="hidden" id="formId" name="formId" value="${param.formId}">
		<!-- 表单变量编码 -->
		<input type="hidden" id="formFlag" name="formFlag" value="${param.formFlag }"/>   
		<!-- 表单模板主键mo_doc_template表  根据此关联外键查询查询设置列表-->
		<input type="hidden" id="catalogId" name=catalogId value="${param.catalogId }"/> 
		<!-- 查询设置主键 -->
		<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>  
		<!-- 标志-->
		<input name="flag" id="flag" type="hidden" />
		<!-- 电脑端输出数据项编码 -->
		<input name="showListVal" id="showListVal" type="hidden" value="${query.showListVal}" />
		<!-- 移动端端输出数据项编码 -->
		<input name="showMobileListVal" id="showMobileListVal" type="hidden" value="${query.showMobileListVal}" />
		<!-- 排序设置编码 -->
		<input name="sortContent" id="sortContent" type="hidden" value="${query.sortContent}" />
		<!-- 查询授权编码 -->
		<input name="authId" id="authId" type="hidden" value="${query.authId}" />
		<!-- 系统查询条件编码 -->
		<input name="sysQuerConditionVal" id="sysQuerConditionVal" type="hidden" value="${query.sysQuerConditionVal}" />
		<!-- 用户输入条件编码 -->
		<input name="userInputConditionVal" id="userInputConditionVal" type="hidden" value="${query.userInputConditionVal}" />
		<!-- 高级查询条件编码 -->
		<input name="sysSeniorConditionVal" id="sysSeniorConditionVal" type="hidden" value="${query.sysSeniorConditionVal}" />
		
		<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"></div>	
		<div id="container">
			<div style="width:25%;height:100%;display: inline;float: left;background: white;border-top: 8px solid #eee;border-bottom: 8px solid #eee;;padding: 10px;overflow: auto;">
				<div><label>模板名称:</label></div>
				<div id="name_div" style="vertical-align: middle;">
					<input id="name" name="name" type="text" value="${query.queryName}" class="form-control" style="height:100%;width:100%;" required="required" placeholder="请输入名称"/>
				</div>
				<div><label>电脑端显示数据项：</label></div>
				<div id="showListName_div" class="input-group" style="width:100%;">
					<textarea id="showListName" name="showListName" class="form-control" rows="3"  style="resize: none;" required="required" readonly="readonly">${query.showListName}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showOutData()"><i class="fa fa-search"></i></span>
				</div>	
				<div><label>移动端显示数据项：</label></div>
				<div id="showMobileListName_div" class="input-group" style="width:100%;">
					<textarea id="showMobileListName" name="showMobileListName" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${query.showMobileListName}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showMobileOutData()"><i class="fa fa-search"></i></span>
				</div>	
				<div><label>排序设置：</label></div>
				<div id="sortName_div" class="input-group" style="width:100%;">
					<textarea id="sortName" name="sortName" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${query.sortName}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showSetSort()"><i class="fa fa-search"></i></span>
				</div>
				<div><label>查看权限:</label></div>
				<div id="authorization_div">
					<select id="authorization" name="authorization" value="${query.power}" style="width:100%;" class="selectpicker show-tick form-control" title="">
					</select>
				</div>
			</div>
			<div style="width:55%;height:100%;display: inline;float: left;background: white;border: 8px solid #eee;">	
				<!--  		
				<div style="padding-left:20px;width: 100%;height: 40px;line-height:40px;border-bottom: 1px solid #cccccc;background-color: white;">
					<label style="font-weight: bold;font-size: 16px;color: rgb(22, 105, 171);">
						预览效果
					</label>
				</div>
				-->	
				<div style="height: 100%;position:relative">
					<div class="mask"></div>
					<iframe id="preview" style="border:1px solid rgb(231, 234, 236);width:100%;height:100%;" frameborder="0" src="">
					</iframe>
				</div>						
			</div>
			<div style="width:20%;height:100%;display: inline;float: left;background: white;border-top: 8px solid #eee;border-bottom: 8px solid #eee;padding: 10px;overflow: auto;">
				<div><label>系统查询条件:</label></div>
				<div id="sysQuerCondition_div" class="input-group" style="width: 100%;">
					<textarea id="sysQuerCondition" name="sysQuerCondition" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${query.sysQuerCondition}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showSelectCondition()"><i class="fa fa-search"></i></span>
				</div>	
				<div><label>用户输入条件：</label></div>
				<div id="userInputCondition_div" class="input-group" style="width: 100%;">
					<textarea id="userInputCondition" name="userInputCondition" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${query.userInputCondition}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showInputCondition()"><i class="fa fa-search"></i></span>
				</div>	
				<div><label>高级查询条件：</label></div>
				<div id="sysSeniorCondition_div" class="input-group" style="width: 100%;">
					<textarea id="sysSeniorCondition" name="sysSeniorCondition" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${query.sysSeniorCondition}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showSeniorCondition()"><i class="fa fa-search"></i></span>
				</div>
				<div><label>授权范围：</label></div>	
				<div id="authValue_div" class="input-group" style="width: 100%;">
					<textarea id="authValue" name="authValue" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${query.authValue}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showAddAuthority()"><i class="fa fa-search"></i></span>
				</div>	
				<div><label>描述：</label></div>	
				<div id="desc_div" style="width: 100%;">
					<textarea id="desc" name="desc" class="form-control" rows="3"  style="resize: none;">${query.description}</textarea>
				</div>
				<div><label>状态:</label></div>	
				<div id="isEnable_div" style="width: 100%;">
					<select id="isEnable" name="isEnable" value="${query.isEnable}" style="width:100%;" class="selectpicker show-tick form-control" title="">		
						<option value="0" ${query.isEnable == 0 ? "selected" : ""}>禁用</option>
						<option value="1" ${query.isEnable == 1 ? "selected" : ""}>启用</option>
					</select>
				</div>	
				<div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;margin-top:10px;" id="save">
			     	<span>保存并刷新</span>
			    </div>  
			</div>
		</div>
  </form>
</body>
</html>