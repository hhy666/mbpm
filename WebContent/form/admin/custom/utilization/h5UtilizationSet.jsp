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
	<title>应用设置详细信息页面<</title>
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
	#top{
		height: calc(100% - 54px); 
		width: 100%;
		overflow: auto;
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
			if(oType=='add'){   //添加应用设置
				$('#cancel').css('display','');
				var url = "<%=request.getContextPath()%>/utilization/utili_initOption.action?catalogId="+catalogId+"&formId="+formId;
				Matrix.sendRequest(url,null,function(data){
					 if(data!=null){
						 var str = data.data;
						 if(str != null && str != ""){
							 var obj = JSON.parse(str);
							 var formjson = obj.formjson;   //表单编码+名称
							 var authjson = obj.authjson;   //授权编码+名称
							 
							 for(var i in formjson){
								 $("#addForm").append("<option value="+i+">"+formjson[i]+"</option>");
								 $("#editForm").append("<option value="+i+">"+formjson[i]+"</option>");
							 }
							 for(var j in authjson){
								 $("#addPower").append("<option value="+j+">"+authjson[j]+"</option>");
								 $("#editPower").append("<option value="+j+">"+authjson[j]+"</option>");
							 }
							
							 $('#addTitle').val("新建");
							 $('#editTitle').val("修改");	 
							 
							 $('.selectpicker').selectpicker('refresh');//动态刷新
						 }
					 }
			  });
	    	}else if(oType=='update'){   //更新应用设置
	    		$('#cancel').css('display','none');
	    		var formstr = '${formvalue}'; 
	    		var formjson = JSON.parse(formstr);   //表单编码+名称
	    		
	    		var addForm = "${utilization.add}";      //保存的新建表单编码
	    		var editForm = "${utilization.edit}";   //保存的修改表单编码
	    		for(var i in formjson){
	    			$("#addForm").append("<option value="+i+">"+formjson[i]+"</option>");
					$("#editForm").append("<option value="+i+">"+formjson[i]+"</option>");
	    		}
	    		//设置选中
	    		$("#addForm option[value='"+addForm+"']").attr("selected", true);
	    		$("#editForm option[value='"+editForm+"']").attr("selected", true);
	    		
	    		var addAuthstr = '${addAuthjson}';
	    		var addAuthjson = JSON.parse(addAuthstr);   //保存的新建授权编码+名称
	    		var editAuthstr = '${editAuthjson}'; 
	    		var editAuthjson = JSON.parse(editAuthstr);  //保存的修改授权编码+名称
	    		var addPower = "${utilization.addPower}";  //保存的新建授权编码
	    		var editPower = "${utilization.editPower}"; //保存的修改授权编码
	    		
	    		for(var j in addAuthjson){
					 $("#addPower").append("<option value="+j+">"+addAuthjson[j]+"</option>");	
			    }
	    		for(var k in editAuthjson){			
					 $("#editPower").append("<option value="+k+">"+editAuthjson[k]+"</option>");
			    }
	    		//设置选中
	    		$("#addPower option[value='"+addPower+"']").attr("selected", true);
	    		$("#editPower option[value='"+editPower+"']").attr("selected", true);
	    		
	    		$('.selectpicker').selectpicker('refresh');//动态刷新
	    	}
			
			//新建表单名称下拉框改变事件
			$("#addForm").change(function(){ 
				var value = $(this).val(); 
				var url = "<%=request.getContextPath()%>/utilization/utili_getAuthByFormId.action?formId="+value;
				Matrix.sendRequest(url,null,function(data){
					 if(data!=null){
						 $("#addPower").empty();     //清空下拉框选项
						 var str = data.data;
						 if(str != null && str != ""){
							 var obj = JSON.parse(str);
							 var authjson= obj.authjson;
							 for(var i in authjson){
								 $("#addPower").append("<option value="+i+">"+authjson[i]+"</option>");
							 }
						 }else{
							 
						 }	
						 $('.selectpicker').selectpicker('refresh');//动态刷新
					 }
				 });
	         });
			
			//修改表单名称下拉框改变事件
			$("#editForm").change(function(){ 
				var value = $(this).val(); 
				var url = "<%=request.getContextPath()%>/utilization/utili_getAuthByFormId.action?formId="+value;
				Matrix.sendRequest(url,null,function(data){
					 if(data!=null){
						 $("#editPower").empty();  //清空下拉框选项
						 var str = data.data; 
						 if(str != null && str != ""){
							 var obj = JSON.parse(str);
							 var authjson= obj.authjson;
							 for(var i in authjson){
								 $("#editPower").append("<option value="+i+">"+authjson[i]+"</option>");
							 }
						 }
						 $('.selectpicker').selectpicker('refresh');//动态刷新
					 }
				});
			}); 
			
			$('.selectpicker').selectpicker({
				 maxheight:150,
				 minheight:80,
			});
			$('.selectpicker').selectpicker('refresh');//动态刷新
			
			
			//操作授权复选框选中
			$("input:checkbox[class='box']").on('ifChecked', function(event){	
				$(this).val(1);
			});
			
			//操作授权复选框取消选中
			$("input:checkbox[class='box']").on('ifUnchecked', function(event){
				$(this).val('');
			});
			
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
	    			saveUtilization();
	    		}else{
	    			Matrix.hideMask2();
	    		}
	        });
			
			var uuid = $('#uuid').val();
			var formId = $('#formId').val();
			if(uuid != null && uuid != ''){
				document.getElementById('preview').src = "<%=request.getContextPath()%>/matrix.rform?configUUID="+uuid+"&formId="+formId+"&mIsQueryMode=false&isDesignTime=true&mHtml5Flag=true";
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
			var string = Matrix.getFormItemValue('displayItems');
			var value = Matrix.getFormItemValue('displayItemsVal');
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
				 content : "<%=request.getContextPath()%>/form/admin/custom/utilization/outData.jsp?formFlag="+formFlag+"&flag="+flag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer01"
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
			}else{
				Matrix.setFormItemValue('displayItems',"");
				Matrix.setFormItemValue('displayItemsVal',"");
			}  
	     }
	   }
		
		//移动端输出数据项弹出窗口
		function showMobileOutData(){
			 var flag = Matrix.getFormItemValue('flag');
			 var string=Matrix.getFormItemValue('mobileDisplayItems');
			 var value=Matrix.getFormItemValue('mobileDisplayItemsVal');
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
					content : "<%=request.getContextPath()%>/form/admin/custom/utilization/mobileOutData.jsp?formFlag="+formFlag+"&flag="+flag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer02"
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
		       Matrix.setFormItemValue('mobileDisplayItems',data);
			   Matrix.setFormItemValue('mobileDisplayItemsVal',value);
			
			}else{
			   Matrix.setFormItemValue('mobileDisplayItems',"");
			   Matrix.setFormItemValue('mobileDisplayItemsVal',"");
			}  
	      }
	   }
		
	  //弹出排序设置窗口
	  function showSetSort(){
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
  						list.push(newdata);
  				    }
  			    }
				parent.parent.sortName=list;
  		    }
  			var displayItemsVal =Matrix.getFormItemValue('displayItemsVal');
			var displayItems=Matrix.getFormItemValue('displayItems');
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
				content : "<%=request.getContextPath()%>/form/admin/custom/utilization/sortSet.jsp?formFlag="+formFlag+"&mBizId="+mBizId+"&formId="+formId+"&iframewindowid=layer03"
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
      		Matrix.setFormItemValue('sortSet',data);
			Matrix.setFormItemValue('sortSetVal',value);
			
		}else{
			Matrix.setFormItemValue('sortSet',"");
			Matrix.setFormItemValue('sortSetVal',"");
		} 
      } 
	}
	
	//弹出系统查询条件窗口
	function showSelectCondition(){ 
		var flag =Matrix.getFormItemValue('flag');
		var firstCondition =Matrix.getFormItemValue('sysQueryCondition');
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
			content : "<%=path%>/condition/condition_loadConditionSet.action?iframewindowid=layer04&entrance=ManageSysCondition&formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&firstCondition="+encodeURI(firstCondition)
		});			
	}
	
	//弹出系统查询条件回调
    function onlayer04Close(data){
		if(data!=null && data!=""){
	      	Matrix.setFormItemValue('sysQueryCondition',data.conditionText);
			Matrix.setFormItemValue('sysQueryConditionVal',data.conditionVal);
	    }
    }
	
	//弹出高级查询条件窗口
    function showSeniorCondition(){ 
		debugger;
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
			content : "<%=request.getContextPath()%>/form/admin/custom/utilization/seniorSelectCondition.jsp?formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&iframewindowid=layer05"
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
	
   //弹出应用授权窗口
   function showAddAuthority(){
	    parent.authUser.areaIds = document.getElementById("authId").value;      //编码
		parent.authUser.areaName = Matrix.getFormItemValue("authority");  //名称
	    parent.iframeJs = this;
	    parent.layer.open({
		    id:'layer06',
			type : 2,
			
			title : ['设置应用授权'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : '<%=request.getContextPath()%>/office/html5/select/MixSelect.jsp?iframewindowid=layer06'
	   });
	}
   
 	//弹出应用授权窗口回调
	function onlayer06Close(data){
		if(data!=null && data!=''){
			var userNames = data.allNames;
	        var adminId = data.allIds;
	        Matrix.setFormItemValue('authId',adminId);
	        Matrix.setFormItemValue('authority',userNames);
		}
	}
	
	//保存
	function saveUtilization() {
		//操作类型
		var oType = $('#oType').val();
		var url;
		if(oType == "add") { //添加
			url = "<%=request.getContextPath()%>/utilization/utili_h5AddUtilization.action"
		}else if(oType == "update"){ //更新
			url = "<%=request.getContextPath()%>/utilization/utili_h5UpdateUtilization.action"
		}
		var synJson = Matrix.formToObject("form0");
		Matrix.sendRequest(url,synJson,function(data){
			if(data != null && data.data != null){
				var json = isc.JSON.decode(data.data);
				if(json.result){
					//刷新下拉框 并设置选中
					parent.parent.$("#module_div").remove();
					var uuid = $('#uuid').val();  //应用设置主键 即下拉框的value
					parent.parent.getData(uuid,oType);
					
					//刷新预览区域
					var formId = $('#formId').val();
					if(uuid != null && uuid != ''){
						document.getElementById('preview').src = "<%=request.getContextPath()%>/matrix.rform?configUUID="+uuid+"&formId="+formId+"&mIsQueryMode=false&mHtml5Flag=true";
					}
				}else{
					Matrix.warn("该应用设置已存在，请更换名称");
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
 <body style="background: rgb(236, 234, 234);">
	<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="form0" name="form0" value="form0" /> 
		<!-- 校验 -->
		<input type="hidden" id="validateType" name="validateType" value="jquery" />  
		<!-- 记录的应用名称 -->
		<input type="hidden" id="oldName" name="oldName" value="${utilization.name}" />  
		<!-- 操作类型  add添加  update修改 -->
		<input type="hidden" id="oType" name="oType" value="${param.oType }"/>   
		<!-- 表单编码 -->
		<input type="hidden" id="formId" name="formId" value="${param.formId}">
		<!-- 表单变量编码 -->
		<input type="hidden" id="formFlag" name="formFlag" value="${param.formFlag }"/>   
		<!-- 表单模板主键mo_doc_template表  根据此关联外键查询应用设置列表-->
		<input type="hidden" id="catalogId" name=catalogId value="${param.catalogId }"/> 
		<!-- 应用设置主键 -->
		<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>  
		<!-- 标志-->
		<input name="flag" id="flag" type="hidden" />
		<!-- 电脑端输出数据项编码 -->
		<input name="displayItemsVal" id="displayItemsVal" type="hidden" value="${utilization.displayItemsVal}" />
		<!-- 移动端端输出数据项编码 -->
		<input name="mobileDisplayItemsVal" id="mobileDisplayItemsVal" type="hidden" value="${utilization.mobileDisplayItemsVal}" />
		<input name="sortSetVal" id="sortSetVal" type="hidden" value="${utilization.sortSetVal}" />
		<input name="authId" id="authId" type="hidden" value="${utilization.authId}" />
		<input name="add" id="add" type="hidden" value="${utilization.add}" />
		<input name="edit" id="edit" type="hidden" value="${utilization.edit}" />
		<input name="customQueryItemVal" id="customQueryItemVal" type="hidden" value="${utilization.customQueryItemVal}" />
		<input name="sysQueryConditionVal" id="sysQueryConditionVal" type="hidden" value="${utilization.sysQueryConditionVal}" />
		<input name="sysSeniorConditionVal" id="sysSeniorConditionVal" type="hidden" value="${utilization.sysSeniorConditionVal }" />
		<input name="flag" id="flag" type="hidden" />
		
		<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"></div>
		<div id="container">
			<div style="width:25%;height:100%;display: inline;float: left;background: white;border-top: 8px solid #eee;border-bottom: 8px solid #eee;padding: 10px;overflow: auto;">
				<div><label>模板名称:</label></div>
				<div id="name_div" style="vertical-align: middle;">
					<input id="name" name="name" type="text" value="${utilization.name}" class="form-control" style="height:100%;width:100%;" required="required" placeholder="请输入名称"/>
				</div>	
				<div><label>电脑端显示数据项：</label></div>
				<div id="displayItems_div" class="input-group" style="width:100%;">
					 <textarea id="displayItems" name="displayItems" class="form-control" rows="3"  style="resize: none;" required="required" readonly="readonly">${utilization.displayItems}</textarea>
					 <span class="input-group-addon addon-udSelect udSelect" onclick="showOutData()"><i class="fa fa-search"></i></span>
				</div>	
				<div><label>移动端显示数据项：</label></div>
				<div id="mobileDisplayItems_div" class="input-group" style="width:100%;">
					<textarea id="mobileDisplayItems" name="mobileDisplayItems" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${utilization.mobileDisplayItems}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showMobileOutData()"><i class="fa fa-search"></i></span>
				</div>
				<div><label>排序设置：</label></div>
				<div id="sortSet_div" class="input-group" style="width:100%;">
					<textarea id="sortSet" name="sortSet" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${utilization.sortSet}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showSetSort()"><i class="fa fa-search"></i></span>
				</div>
				<!-- --------------------------------------新建表单----------------------------------------------------- -->
				<div style="display: none;"><label>新建表单:</label></div>
				<div id="addForm_div" style="display: none;">
					<select id="addForm" name="addForm" value="${utilization.add}" class="selectpicker show-tick form-control">
					</select>
				</div>
				<div><label>新建名称:</label></div>
				<div id="addTitle_div" style="vertical-align: middle;">
					<input id="addTitle" name="addTitle" type="text" value="${utilization.addTitle}" class="form-control" style="height:100%;width:100%;"/>
				</div>
				<div><label>新建授权:</label></div>
				<div id="addPower_div">
					<select id="addPower" name="addPower" value="${utilization.addPower}" style="width:100%;" class="selectpicker show-tick form-control" title="">
					</select>
				</div>
				<!-- --------------------------------------修改表单----------------------------------------------------- -->
				<div style="display: none;"><label>修改表单:</label></div>
				<div id="editForm_div" style="display: none;">
					<select id="editForm" name="editForm" value="${utilization.edit}" class="selectpicker show-tick form-control">
					</select>
				</div>
				<div><label>修改名称:</label></div>
				<div id="editTitle_div" style="vertical-align: middle;">
					<input id="editTitle" name="editTitle" type="text" value="${utilization.editTitle}" class="form-control" style="height:100%;width:100%;"/>
				</div>
				<div><label>修改授权:</label></div>
				<div id="editPower_div">
					<select id="editPower" name="editPower" value="${utilization.editPower}" style="width:100%;" class="selectpicker show-tick form-control" title="">
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
				<div><label>操作:</label></div>
				<div>
					<div id="isAdd_div" style="display: inline-block;">
						<input id="isAdd" name="isAdd" type="checkbox" class="box" value="${utilization.isAdd=='false'?'':'1'}" ${utilization.isAdd=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						 添加
					</label>
					<div id="isEdit_div" style="padding-left: 10px;display: inline-block;">
						<input id="isEdit" name="isEdit" type="checkbox" class="box" value="${utilization.isEdit=='false'?'':'1'}" ${utilization.isEdit=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						修改
					</label>	
					<div id="del_div" style="padding-left: 10px;display: inline-block;">
						<input id="del" name="del" type="checkbox" class="box" value="${utilization.del=='false'?'':'1'}" ${utilization.del=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						删除
					</label>	
					<div id="lock_div" style="padding-left: 10px;display: inline-block;">
						<input id="lock" name="lock" type="checkbox" class="box" value="${utilization.lock=='false'?'':'1'}" ${utilization.lock=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						加锁/解锁
					</label>					
				</div>
				<div>
					<div id="leading_div" style="display: inline-block;">
						<input id="leading" name="leading" type="checkbox" class="box" value="${utilization.importFunc=='false'?'':'1'}" ${utilization.importFunc=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						导入
					</label>	
					<div id="derive_div" style="padding-left: 10px;display: inline-block;">
						<input id="derive" name="derive" type="checkbox" class="box" value="${utilization.export=='false'?'':'1'}" ${utilization.export=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						导出
					</label>
					<div id="select_div" style="padding-left: 10px;display: inline-block;">
						<input id="select" name="select" type="checkbox" class="box" value="${utilization.select=='false'?'':'1'}" ${utilization.select=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						查询
					</label>	
					<div id="print_div" style="padding-left: 10px;display: inline-block;">
						<input id="print" name="print" type="checkbox" class="box" value="${utilization.print=='false'?'':'1'}" ${utilization.print=='false'?'':'checked'}/>
					</div>
					<label class="control-label" style="vertical-align: middle;">
						打印
					</label>			
				</div>
				<div><label>系统查询条件:</label></div>
				<div id="sysQueryCondition_div" class="input-group" style="width: 100%;">
					<textarea id="sysQueryCondition" name="sysQueryCondition" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${utilization.sysQueryCondition}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showSelectCondition()"><i class="fa fa-search"></i></span>
				</div>
				<div><label>高级查询条件:</label></div>	
				<div id="sysSeniorCondition_div" class="input-group" style="width: 100%;">
					<textarea id="sysSeniorCondition" name="sysSeniorCondition" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${utilization.sysSeniorCondition}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showSeniorCondition()"><i class="fa fa-search"></i></span>
				</div>	
				<div><label>授权范围:</label></div>	
				<div id="authority_div" class="input-group" style="width: 100%;">
					<textarea id="authority" name="authority" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${utilization.authority}</textarea>
					<span class="input-group-addon addon-udSelect udSelect" onclick="showAddAuthority()"><i class="fa fa-search"></i></span>
				</div>
				<div><label>描述:</label></div>	
				<div id="desc_div" style="width: 100%;">
					<textarea id="desc" name="desc" class="form-control" rows="3"  style="resize: none;">${utilization.description}</textarea>
				</div>
				<div><label>状态:</label></div>	
				<div id="isEnable_div" style="width: 100%;">
					<select id="isEnable" name="isEnable" value="${utilization.isEnable}" style="width:100%;" class="selectpicker show-tick form-control" title="">										
						<option value="0" ${utilization.isEnable == 0 ? "selected" : ""}>禁用</option>
						<option value="1" ${utilization.isEnable == 1 ? "selected" : ""}>启用</option>
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