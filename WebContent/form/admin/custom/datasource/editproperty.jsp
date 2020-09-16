<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>表单设计属性页面</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link href='<%=path %>/resource/html5/css/jquery-editable-select.min.css' rel="stylesheet"></link>
<SCRIPT SRC='<%=path %>/resource/html5/js/jquery-editable-select.min.js'></SCRIPT>
<script type="text/javascript">

		function addProp(){
			var newComponent = parent.isc.MFH.getNewComponent();
		 	//newComponent.mtitle = "测试组件";
		 	//newComponent.sid = "testcom001";
		
			var dataName = $('#dataName').val();
			var mid = "${property.mid}";
			parent.isc.MFH.setNewComponent(newComponent);
			parent.isc.MFH.setNewTitle(dataName);
			parent.isc.MFH.setNewSid(mid);
			var parentNodeId = Matrix.getFormItemValue("parentNodeId");
			parent.isc.MFH.setFormVar(parentNodeId);
			parent.isc.MFH.createComponent(newComponent);
		}
  
		window.onload = function(){
			initForm();
		}
		
		//下拉框初始
		function initSelect(){
			//默认值可编辑下拉初始事件
	 		$('#defaultValue').val("");
	 	    $("#defaultValue_select").editableSelect({
	 	        filter: false,
	 	        effects: 'fade',
	 	        duration: 200
	 	    }).on('select.editable-select',
	 	    function(e, li) {//选择监控
	 	    	var modelType = $('#modelType').val();
	 			hideSelect(modelType);
				$('#defaultValue').val($('li.selected').attr('value'));
	 	    });
	 	    //输入监控
	 	    $('#defaultValue_select').on('input propertychange',
	 	    function(e) {
	 	    	var modelType = $('#modelType').val();
	 			hideSelect(modelType);
	 	        $('#defaultValue').val($(this).val());
	 	    });
	 	   //鼠标单击监控
	 		$("#defaultValue_select").click(function(){
	 	    	var modelType = $('#modelType').val();
	 			hideSelect(modelType);
			});
	 	    //按键监控
	 	    $('#defaultValue_select').on('input keydown',
	 	    function(e) {
	 	    	var modelType = $('#modelType').val();
	 			hideSelect(modelType);
	 	    });
	 	    $("#defaultValue_select").val(null)
	 	    
	 	    $('.es-list').css('text-align','left');
	 	    
	 	    
	 		var editType = Matrix.getFormItemValue("editType");
	 		if(editType=="add"){
	 			//$("#modelType").val("1");
	 			//$("#dataType").val("1");
	 		}else{
	 			//初始默认值显示
	 			$("#defaultValue").val('${defaultValue==null?"":defaultValue}');
	 			$("li.es-visible").each(function(){ //遍历全部option
					if($(this).attr('value')=='${defaultValue==null?"":defaultValue}'){
						$("#defaultValue_select").val($(this).text());
					}
				});
	 			if($("#defaultValue_select").val()==""||$("#defaultValue_select").val()==null){
	 				$("#defaultValue_select").val('${defaultValue==null?"":defaultValue}');
	 			}
	 			
	 			$("#modelType").val('${property.uiType}');
	 			$("#dataType").val('${property.type==""?"1":property.type}');
	 			$("#formatPatternDate").val('${property.displayFormat}');
	 			$("#formatPatternNumber").val('${property.displayFormat}');
	 			//$("#isRequired").val('${property.isRequired=="false"?"":"1"}');
	 		}
	 		
	 		//初始设置默认值下拉框
			var modelType = $('#modelType').val();
			hideSelect(modelType);
		}
			
		//默认值下拉框禁止
		function hideSelect(modelType){
			if(modelType=='4'||modelType=='7'||modelType=='8'||modelType=='9'||modelType=='27'||modelType=='28'||modelType=='29'){//数字类型/附件类型/流程意见/单选/复选
	        	$("li.es-visible").each(function(){ //遍历全部option
					$(this).css('display','none');
				});
	        }else if(modelType=='3'){//时间框
	        	$("li.es-visible").each(function(){ //遍历全部option
	        		var value = $(this).attr('value');
	        		if(value!="_7"){
						$(this).css('display','none');
	        		}
				});
	        }else if(modelType=='2'){//日期框
	        	$("li.es-visible").each(function(){ //遍历全部option
	        		var value = $(this).attr('value');
	        		if(value!="_6"&&value!="_8"){
						$(this).css('display','none');
	        		}
				});
	        }else if(modelType=='7'){//复选框
	        	$("li.es-visible").each(function(){ //遍历全部option
	        		var value = $(this).attr('value');
	        		if(value!="true"&&value!="false"){
						$(this).css('display','none');
	        		}
				});
	        }else{//其他
	        	$("li.es-visible").each(function(){ //遍历全部option
	        		var value = $(this).attr('value');
					$(this).css('display','');
				});
	        }
		}
		
		//按钮初始
		function initButtons(){
			var editType = $('#editType').val();
			if(editType!=null && editType.length>0){
				if(editType=='update'){
					$('#button2').css('display','none');
				}else if(editType=='add'){
					$('#button2').css('display','');
				}
			}
		}
		
		//初始设置
		function initForm(){
			//初始的时候  设置无默认值  根据不同情况，后面的时候设置默认值
			var phase = Matrix.getFormItemValue("phase");//当前阶段
			var parentNodeId = Matrix.getFormItemValue('parentNodeId');
			var canChangeEditType = Matrix.getFormItemValue("canChangeEditType");
			var num = 0;
			var editType = Matrix.getFormItemValue("editType");
			var mainFormVarType = Matrix.getFormItemValue("mainFormVarType");
			if(editType!=null && editType!='' && editType!='null'){
				Matrix.setFormItemValue('editType',editType);
			}
			//显示格式，数据字典，精度 默认不显示
			document.getElementById('tr006').style.display='none';
			document.getElementById('tr007').style.display='none';
			document.getElementById('tr008').style.display='none';
			
			//加载按钮初始
			initButtons();
			
			if(phase=='4'){
				if(editType=='add'){
					document.getElementById('tr001').style.display='none';
			 		var tree = parent.MTree0_DS.$27m;//树
			 		var formId = "";//表单编码
			 		if(tree!=null && tree.length>0){
			 			num = getCurFormVarPropertyMaxNum(tree,parentNodeId,mainFormVarType);
			 			formId = tree[0].entityId;//树的根节点编码  就是表单编码
			 		}
			 		if(formId==null || formId==''){
			 			//如果表单编码还拿不到  就用parentNodeId来获取
			 			if(parentNodeId.endWith("EntityVar")){
			 				formId = parentNodeId.replace("EntityVar","");
			 			}else if(parentNodeId.endWith("RAllListVar")){
			 				formId = parentNodeId.replace("RAllListVar","");
			 			}else if(parentNodeId.endWith("AllListVar") && !parentNodeId.endWith("RAllListVar")){
			 				formId = parentNodeId.replace("AllListVar","");
			 			}
			 		}
			 		var mid = formId+"field"+num;//属性的编码
			 		if(mainFormVarType=='DataObject'){
			 			mid = "m"+mid;//区分主表单变量属性和子表单变量属性
			 		}else if(mainFormVarType=='List' || mainFormVarType=='RList'){
			 			mid = "s"+mid;
			 		}
				}
			}
			
			//默认值
			var defaultValue = $('#defaultValue').val();
			//字段类型
			var proType = $('#dataType').val();
			if(proType=='9'){
				//小数时显示精度
				document.getElementById('tr008').style.display=''; 
				//是数值类型的
				if(defaultValue !=null && defaultValue.length>0 && defaultValue!='null'){
					$('#defaultValue').val(defaultValue);
					$("#defaultValue_select").val(defaultValue);
				}else{
					$('#defaultValue').val('');
					$("#defaultValue_select").val('');
				}
			}else if(proType=='7'){
				if(editType=='add'){
		 			$("#modelType").val("2");
		 		}
			}
			if(proType == '7' || proType == '3' || proType == '9'){
				document.getElementById('tr006').style.display='';
				if(proType == '7'){
					document.getElementById('formatPatternDate').style.display='';
					document.getElementById('formatPatternNumber').style.display='none';
					Matrix.setFormItemValue("formatPatternNumber", '');
				}else if(proType == '3' || proType == '9'){
					document.getElementById('formatPatternNumber').style.display='';
					document.getElementById('formatPatternDate').style.display='none';
					Matrix.setFormItemValue("formatPatternDate", '');
				}
			}
			var proTypeValue = '${property.type}';
			var length = '${property.length}';
			
			
	 		//根据拖拽控件给编辑类型加初始值
	 		var type = $('#type').val();
	 		$('#modelType').val(type);
 		
			
			//UI编辑类型
			var uiType = $('#modelType').val();
			if(uiType=='29'||uiType=='12'|| uiType=='28'||uiType=='27'){
				//附件和流程意见 不显示 类型 长度  精度  默认值 
				document.getElementById('tr004').style.display='none';
				document.getElementById('tr005').style.display='none';
				document.getElementById('tr008').style.display='none';
				document.getElementById('tr009').style.display='none';
				
				if(editType!='add'){
					$('#dataType').val(proTypeValue);
		 			$('#length').val(length);
				}else{
					$('#dataType').val('1');
					document.getElementById('tr008').style.display='none';
		 			$('#length').val('255');
				}
			}else if(uiType=='23'||uiType=='24'||uiType=='25'||uiType=='26'||uiType=='9'){
				//初始加载   如果是 选部门  选人员
				document.getElementById('tr004').style.display='';
				document.getElementById('tr005').style.display='';
				document.getElementById('tr009').style.display='';
				if(uiType=='23'||uiType=='25'){
	 				$('#tr005').css('display','none');
	 			}
				$('#length').val('255');
				$('#dataType').val('1');
			}else if(uiType=='10'){
				//文本域  属性类型默认是字符型不可修改
				$('#dataType').val('1');
				if(editType=='add'){
		 			$('#length').val('2000');
				}else{
		 			$('#length').val(length);
				}
				document.getElementById('tr004').style.display='';
				document.getElementById('tr005').style.display='';
				document.getElementById('tr009').style.display='';
			}else if(uiType=='30'){
				//长度  默认值 不显示
				document.getElementById('tr004').style.display='';
				document.getElementById('tr005').style.display='none';
				document.getElementById('tr009').style.display='none';
				$('#dataType').val('8');
				if(editType=='add'){
		 			$('#length').val('255');
				}else{
		 			$('#length').val(length);
				}
			}else if(uiType=='2'||uiType=='3'){
				//日期  时间
				document.getElementById('tr005').style.display='none';
				document.getElementById('tr004').style.display='';
				document.getElementById('tr009').style.display='';
	 			$('#length').val('255');
				if(uiType == '2'){
					$('#dataType').val('7');//日期
					document.getElementById('formatPatternDate').style.display='';
					document.getElementById('formatPatternNumber').style.display='none';
					Matrix.setFormItemValue("formatPatternNumber", '');
		 			document.getElementById('tr006').style.display='';
				}else{
					$('#dataType').val('1');
					
				}
				
			}else if(uiType=='5'||uiType=='11'||uiType=='22'){
				//列表框 下拉框 多选下拉框
				$('#dataType').val('1');
				document.getElementById('tr008').style.display='none';
				document.getElementById('tr007').style.display='';
				if(editType=='add'){
		 			$('#length').val('255');
				}else{
		 			$('#length').val(length);
				}
				document.getElementById('tr004').style.display='';
				document.getElementById('tr005').style.display='';
				document.getElementById('tr009').style.display='';
				
			}else if(uiType=='1'||uiType=='4'||uiType=='6'||uiType=='7'||uiType=='8'){
				//其他情况
				document.getElementById('tr004').style.display='';
				document.getElementById('tr005').style.display='';
				document.getElementById('tr009').style.display='';
		 			if(editType=='add'){
		 				if(uiType!='4'){
		 					if(uiType=='1'||uiType=='8'){
		 						$('#dataType').val('1');
		 					}
		 	 	 			$('#length').val('255');
							$('#dataType').val('1');
			 				document.getElementById('tr008').style.display='none';
							$('#dataType').attr('readonly','readonly');
							$('#dataType').attr('disabled','disabled');
		 				}else{
		 	 	 			$('#length').val('12');
							$('#dataType').val('3');
		 					document.getElementById('tr008').style.display='none';
		 					document.getElementById('tr006').style.display='';
							$('#dataType').attr('readonly',false);
							$('#dataType').attr('disabled',false);
							$("#dataType option[value='1']").css('display','none');
							$("#dataType option[value='6']").css('display','none');
							$("#dataType option[value='7']").css('display','none');
							$("#dataType option[value='8']").css('display','none');
							document.getElementById('formatPatternDate').style.display='none';
							document.getElementById('formatPatternNumber').style.display='';
							Matrix.setFormItemValue("formatPatternDate", '');
		 				}
		 			}else{
		 				if(uiType=='4'){
		 	 				if('${property.type}'!='3'&&'${property.type}'!='9'){
		 	 					var type = 3;
		 	 				}else{
		 	 					var type = ${property.type};
		 	 				}
							$('#dataType').val(type);
			 	 			$('#length').val(length);
							$('#dataType').attr('readonly',false);
							$('#dataType').attr('disabled',false);
							$("#dataType option[value='1']").css('display','none');
							$("#dataType option[value='6']").css('display','none');
							$("#dataType option[value='7']").css('display','none');
							$("#dataType option[value='8']").css('display','none');
		 				}else if(uiType=='1'||uiType=='8'){
							if('${property.type}'!='1'){
		 	 					var type = 1;
		 	 				}else{
		 	 					var type = ${property.type};
		 	 				}
							$('#dataType').val(type);
							$('#dataType').attr('readonly','readonly');
							$('#dataType').attr('disabled','disabled');
		 				}else{
			 	 			$('#length').val(length);
							$('#dataType').val(proTypeValue);
							$('#dataType').attr('readonly','readonly');
							$('#dataType').attr('disabled','disabled');
		 				}
		 			}
				if(uiType=='7'){
					//复选按钮  数据类型  是 布尔类型
					//长度不显示  
					document.getElementById('tr005').style.display='none';
					document.getElementById('tr007').style.display='none';
					$('#dataType').val('6');
				}
			}else if(uiType=='31'){
				//关联文档
				document.getElementById("tr008").style.display="none";
				document.getElementById("tr009").style.display="none";
				document.getElementById('tr004').style.display='';
				document.getElementById('tr005').style.display='';
				if(editType=='add'){
		 			$('#length').val('255');
					$('#dataType').val('1');
					document.getElementById('tr008').style.display='none';
				}else{
					$('#dataType').val('1');
		 	 			$('#length').val(length);
				}
			}
			if(uiType == '5' || uiType == '11' || uiType == '22' || uiType == '8' || uiType == '9'){
				document.getElementById('tr007').style.display='';
			}else{
				document.getElementById('tr007').style.display='none';
			}
			//修改时根据 canChangeEditType 改变编辑状态
			if(editType == 'update'){
				if(canChangeEditType=='false'){
		 			//McomboBox001.setDisabled(true);
		 		}else{
		 			//McomboBox002.setDisabled(false);
		 		}
			}
			
			//下拉框初始
			initSelect();
			
		}
		
		//字段类型改变
		function setStyle(){
			//获取字段类型的值
			var value = $('#dataType').val();
			var proType = $('#modelType').val();
			var editType = $('#editType').val();
			if(editType!='add'){
				$('#modelType').val(proType)
			}else{
				//McomboBox002.setValue("1");
			}
			//McomboBox002.setDisabled(false);
			if(value!=null&&value!=""){
				//字段类型为小数 精度显示
				if(value=='9'){
					document.getElementById('tr005').style.display='';
					document.getElementById('tr008').style.display='';
					Matrix.setFormItemValue("length","11");//长度
					Matrix.setFormItemValue("precision","2");//精度
					$('#defaultValue').val('');
				}else{
					document.getElementById('tr008').style.display="none";
				}
				//字段类型为布尔/日期/二进制 隐藏长度
				if(value=='6'||value=='7'||value=='8'){
					document.getElementById('tr005').style.display="none";
					if(value=='7'){
						//日期时间 设置编辑类型
						$('#modelType').val('2');
					}
				}else{
					document.getElementById('tr005').style.display="";
				}
				//字段类型为字符
				if(value == '1'){
					/*********************长度 精度***********************/
					document.getElementById('tr005').style.display='';//显示长度tr
					document.getElementById('tr008').style.display='none';//隐藏精度tr
					
					Matrix.setFormItemValue("length","255");//长度
					Matrix.setFormItemValue("precision","");//精度
				}
				//字段类型为整数/小数/日期类型
				if(value == '3' || value == '9' || value == '7'){//控制显示格式
					if(value == '3' || value == '9'){
						document.getElementById('formatPatternDate').style.display='none';
						document.getElementById('formatPatternNumber').style.display='';
						Matrix.setFormItemValue("formatPatternDate", '');
					}else{
						document.getElementById('formatPatternDate').style.display='';
						document.getElementById('formatPatternNumber').style.display='none';
						Matrix.setFormItemValue("formatPatternNumber", '');
					}
				}else{
					document.getElementById('formatPatternDate').style.display='none';
					document.getElementById('formatPatternNumber').style.display='none';
					Matrix.setFormItemValue("formatPatternNumber", '');
					Matrix.setFormItemValue("formatPatternDate", '');
				}
				//字段类型日期时间
				if(value=='7'){//
					/*********************隐藏精度***********************/
					document.getElementById('tr005').style.display='none';//隐藏长度tr
					document.getElementById('tr008').style.display='none';//隐藏精度tr
					Matrix.setFormItemValue("length","");//
					Matrix.setFormItemValue("precision","");//
		
					/***************************************************/
		 			$("#modelType").val("2");
		 			//McomboBox002.setDisabled(true);
		 		}
		 		/* if(value=='2'){
					document.getElementById('tr005').style.display='';//显示长度tr
					document.getElementById('tr008').style.display='none';//隐藏精度tr
					Matrix.setFormItemValue("length","20");//
					Matrix.setFormItemValue("precision","");//
					$('#modelType').val('0');
		 			McomboBox002.setDisabled(false);
		 		} */
		 		//字段类型整数
		 		if(value =='3'){
					Matrix.setFormItemValue("length","12");//
		 			document.getElementById("tr009").style.display="";
		 		}
		 		//字段类型小数
		 		if(value == '9'){
		 			document.getElementById("tr008").style.display="";
		 		}else{
		 			document.getElementById("tr008").style.display="none";
		 			document.getElementById("tr009").style.display="";
		 		}
		 		
			}
		}
		
		
		//数据字典非空校验
		function selectItemsValidate(){
			var type = $('#modelType').val();
			if(type=="8"||type=="9"||type=="5"||type=="22"||type=="11"){
				var select = $('#selectItemsStr').val();
				if(select!=null&&select.length>0){
					return true;
				}else{
					Matrix.warn('数据字典不能为空！');
					return false;
				}
			}else{
				return true;
			}
		}
		
		
		//验证
		function formValidate(){
			if(formVarNameValidate()){
				if(lengthValidate()){
					if(precisionValidate()){
						if(selectItemsValidate()){
							return true;
						}else{
							return false;
						}
					}else{
						return false;
					}
				}else{
					return false;
				}
			}else{
				return false;
			}
		}
		
		//保存
		function saveData(){
			$('#button1').attr('disabled','disabled');
			if(!formValidate()){//表单验证
				$('#button1').attr('disabled',false);
				return false;
			}else{
				var mid = "${property.mid}";
				var name = $('#dataName').val();
				var type = $('#dataType').val();
				var length = $('#length').val();
				var selectItems = Matrix.getFormItemValue("selectItems");
				var precision = $('#precision').val();
				var uiType =  $('#modelType').val();
				var editType = Matrix.getFormItemValue("editType");
				var parentNodeId = Matrix.getFormItemValue("parentNodeId");
				var json = "{'name':'"+name+"','mid':'"+mid+"','formVarId':'"+parentNodeId+"','editType':'"+editType+"'}";
				var newJsonData = isc.JSON.decode(json);
				var src = "<%=path%>/datasource/formVarPro_hasContainsThisPropertyInCurForm.action"
				Matrix.sendRequest(src,newJsonData,function(data){
					if(data!=null && data.data!=''){
						var result = isc.JSON.decode(data.data);
						if(!result.result){
							var editType = Matrix.getFormItemValue("editType");
							var displayFormat = Matrix.getFormItemValue("displayFormat");
							//var entity = Matrix.getFormItemValue("entity");
							var isRequired = Matrix.getFormItemValue("isRequired");
							var defaultValue = $('#defaultValue').val();
							var objMid = Matrix.getFormItemValue("objMid");
							var tree = parent.MTree0_DS.$27m;
							var index = getNextIndex(tree);
							var str = "";
							str += "{\"mid\":\""+mid+"\",";
							str += "\"name\":\""+name+"\",";
							str += "\"type\":\""+type+"\",";
							str += "\"length\":\""+length+"\",";
							str += "\"precision\":\""+precision+"\",";
							str += "\"displayFormat\":\""+displayFormat+"\",";
							str += "\"options\":\""+selectItems+"\",";
							str += "\"uiType\":\""+uiType+"\",";
							str += "\"parentNodeId\":\""+parentNodeId+"\",";
							str += "\"editType\":\""+editType+"\",";
							str += "\"index\":\""+index+"\",";
							str += "\"isRequired\":\""+isRequired+"\",";
							if(defaultValue==null||defaultValue==""||defaultValue=="null"){
								str += "\"defaultValue\":\"\"}";
							}else{
								str += "\"defaultValue\":\""+defaultValue+"\"}";
							}
							var synJson = {'data':"{'data':"+str+"}"}; 
							var validataUrl = "<%=path%>/datasource/formVarPro_validataUpdate.action"; 
							Matrix.sendRequest(validataUrl,synJson,function(data){
								if(data.data!="error"){
									var url ="<%=path%>/datasource/formVarPro_saveOrUpdatePropertyInfo.action"; 
									Matrix.sendRequest(url,synJson,function(data){
										if(data!=null &&data.data!=''){
											var json = isc.JSON.decode(data.data);
											if(json.result){
							       				$('#button1').attr('disabled','');
							       				//设计器里添加控件
							       				addProp();
							       				//刷新父页面树节点
							       				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
							       				parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
							       				var formVarType = "${mainFormVarType}";
							       				if(formVarType=='DataObject' ){
							       					parent.redrawComponent(mid);
							       				}else if(formVarType=='List'){
								       				parent.redrawEditList(parentNodeId);//刷新父表单
								       				parent.isc.MH.reloadComponent();
							       				}else if(formVarType=='RList'){
								       				parent.isc.MH.reloadComponent();
							       				}
							       				Matrix.closeWindow();
							       				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
							       				parent.layer.close(index);
											}
										}
									});
								}else{
				       				$('#button1').attr('disabled',false);
									Matrix.warn("表里有数据不能修改字段类型！");
								}
							});
						}else{
		       				$('#button1').attr('disabled',false);
							Matrix.warn("名称不能重复!");
						}
					}
				});
			}
		}
		
		
		//显示格式改变给隐藏域赋值
		function setDisplayFormatValueFromDate(){
			var value = Matrix.getFormItemValue('formatPatternDate');
			document.getElementById('displayFormat').value=value;
		}
		function setDisplayFormatValueFromNum(){
			var value = Matrix.getFormItemValue('formatPatternNumber');
			document.getElementById('displayFormat').value=value;
		}
		
		//验证名称输入
		function formVarNameValidate(){
			var value = $('#dataName').val();
			if(value==null||value.length==0){
			   Matrix.warn('名称不能为空！');
			   return false;
			}
			if(value.length<255&&value.length>0){
				/*
				var editType = Matrix.getFormItemValue("editType");
				if(editType=='add'){
					var allTreeData = parent.MTree0_DS.$27m;
					if(allTreeData!=null && allTreeData.length>0){
						var parentNodeId = Matrix.getFormItemValue("parentNodeId");
						for(var i = 0;i<allTreeData.length-1;i++){
							var data = allTreeData[i];
							if(data.parentId == parentNodeId){
								if(data.name==value){
									 validator.errorMessage="名称重复!";
									 return false;
								}
							}
						}
					}
				}*/
				var isMatch = value.match(/^[\w\u4e00-\u9fa5]+$/);
				if(isMatch!=null){//非空
					return true;
				}
				Matrix.warn("不能使用字母汉字下划线以外的非法字符！");
				return false;
			}else{
				Matrix.warn('名称长度不符合标准！');
				return false;
			}
		}
		
		//长度校验
		function lengthValidate(){
			var value = $('#length').val();
			var comb = ['6','7','8','13','14'];
			var uiType = $('#modelType').val();
			if(uiType=='29'||uiType=='12'|| uiType=='27'|| uiType=='28'|| uiType=='31'){//流程意见 or 附件
				return true;
			}
			if(comb.indexOf($('#dataType').val())==-1){
		 		if(value==null || value.length==0){//
					Matrix.warn("长度不能为空!");
		 			return false;
		 		}
				if(value.length<255&&value.length>0){
		 			var isNum = value.match(/^\d+$/);
		 			if(!isNum){
		 				Matrix.warn("不能含有非数字的字符!");
		 				return false;
		 			}
		 			var isMatch = value.match(/^[1-9]\d*$/);
		 			if(!isMatch){
		 				Matrix.warn("数字格式不正确!");
		 				return false;
		 			}
		 		}else{
		 			Matrix.warn('长度位数不符合标准！');
					return false;
		 		}
			}
			return true;
		}	
		
		//精度校验
		function precisionValidate(){
			var value = $('#precision').val();
			var comb = ['4','5','9'];
			var uiType = $('#modelType').val();
			if(uiType=='29'||uiType=='12'|| uiType=='28'){//流程意见 or 附件
				return true;
			}
			if(comb.indexOf($('#dataType').val())!=-1){
		 		if(value==null || value.length==0){//
		 			Matrix.warn("精度不能为空!");
		 			return false;
		 		}
				if(value.length<255||value.length>0){
		 			var isNum = value.match(/^\d+$/);
		 			if(!isNum){
		 				Matrix.warn("不能含有非数字的字符!");
		 				return false;
		 			}
		 			var isMatch = value.match(/^[1-9]\d*$/);
		 			if(!isMatch){
		 				Matrix.warn("数字格式不正确!");
		 				return false;
		 			}
		 		}else{
					Matrix.warn("精度位数不符合标准!");
					return false;
		 				
		 		}
			}
			return true;
		}
		
		
		 //获得子列表的个数
		 function getCurFormVarPropertyMaxNum(data,parentNodeId,mainFormVarType){
		 	var maxNum = 0;
		 	var numArr = [];
		 	if(data!=null && data.length>0){
		 		for(var i = 0;i<data.length;i++){
		 			var node = data[i];
		 			if(mainFormVarType=='List' || mainFormVarType=='RList'){
		     			if(node.parentId==parentNodeId){
		     				var fdid = data[0].id;
		     				var entityId = node.entityId;
		     				if(entityId.indexOf(fdid+"field")!=-1){
		     					var num = entityId.replace(fdid+"field","");
			     				//var num = entityId.substr(entityId.indexOf("_")+1);
			     				numArr.push(num);
			     			}
		     			}
		 			}else if(mainFormVarType=='DataObject'){
		 				if(node.parentId==parentNodeId){
		     				var entityId = node.entityId;
		     				var fdid = node.parentNodeId.replace("EntityVar","");
		     				if(entityId.indexOf("m"+fdid+"field")!=-1){
		     					var num = entityId.replace("m"+fdid+"field","");
			     				//var num = entityId.substr(entityId.indexOf("_")+1);
			     				numArr.push(num);
			     			}
		     			}
		 			}
		 		}
		 		maxNum = getMaxNum(numArr);
		 	}
		 	return maxNum;
		 }
		 
		 //获得最大值
		 function getMaxNum(numArr){
		 	var max = 0;
		 	if(numArr!=null && numArr.length>0){
		 		max = parseInt(numArr[0]);
		 		for(var i = 0;i<numArr.length-1;i++){
		 			var n = parseInt(numArr[i+1]);
		 			if(max<n){
		 				max = n;
		 			}
		 		}
		 		max = max+1;
		 	}
		 	return max;
		 }
		 
		 //获得序号
		 function getNextIndex(data){
		 	var index = 0;
		 	if(data!=null && data.length>0){
		 		for(var i = 0;i<data.length;i++){
		 			var node = data[i];
		 			if(node.parentId==parentNodeId){
		 				index=index+1;
		 			}
		 		}
		 	}
		 	return index;
		 }
</script>
</head>
<body style="padding: 10px">
	<!-- 当前显示组件编码 -->
	<input type="hidden" id="componentId" name="componentId"/>
	<!-- 当前显示组件类型编码 -->
	<input type="hidden" id="componentTypeId" name="componentTypeId"/>
	<!-- 自定义组件类别编码 -->
	<input type="hidden" id="customTypeId" name="customTypeId"/>
	
	<input type="hidden" name="type" id="type" value="${type }"/>
	<input type="hidden" name="mainFormVarType" id="mainFormVarType" value="${mainFormVarType }"/>
	<input type="hidden" name="canChangeEditType" id="canChangeEditType" value="${param.canChangeEditType}"/>
	<input type="hidden" name="parentNodeId" id="parentNodeId" value="${parentNodeId}"/>
	<input type="hidden" name="phase" id="phase" value="${phase}"/>	
	<input type="hidden" name="editType" id="editType" value="${param.editType}"/>
	<input type="hidden" name="selectItems" id="selectItems" value="${property.options}"/>
	<input type="hidden" id="displayFormat"  name="displayFormat" value="${property.displayFormat}"/>
	<table id="table001" style="width:100%;" name="table001" class="tableLayout">
		<tr id="tr001" name="tr001">
			<td id="td001" style="width:30%;" name="td001" class="tdLabelCls">
				<label class="label" id="label001" name="label001">
					编码
				</label>
			</td>
			<td id="td002" style="width:70%;text-align: left;padding-left: 10px;" name="td002" class="tdValueCls">
				<span id="mid" style="width:100%" name="mid"/>${property.mid}
			</td>
		</tr>
		<tr id="tr002" name="tr002">
			<td id="td003" style="width:30%;" name="td003" class="tdLabelCls">
				<label class="label" id="label002" name="label002">
					名称
				</label>
			</td>
			<td id="td004" style="width:70%;" name="td004" class="tdValueCls">
				<input placeholder="请输入名称" autocomplete="off" class="form-control" value="${property.name}" required="false" id="dataName" style="width:100%" name="dataName"/>
			</td>
		</tr>
		<tr id="tr003" name="tr003">
		 	<td id="td005" style="width:30%;" name="td005" class="tdLabelCls">
				<label class="label" id="label003" name="label003">
					编辑类型
				</label>
		 	</td>
			<td id="td006" style="width:70%;" name="td006" class="tdValueCls">
				<select readonly="readonly" disabled="disabled" class="form-control select2-accessible" id="modelType" onchange="modelTypeChange();">
					<option value="1">文本框</option>
					<option value="2">日期框</option>
					<option value="3">时间框</option>
					<option value="4">数字框</option>
					<option value="5">下拉框</option>
					<option value="22">多选下拉框</option>
					<!-- <option value="21">弹出选择</option> -->
					<option value="8">单选框组</option>
					<option value="7">复选框</option>
					<option value="9">复选框组</option>
					<option value="10">文本域</option>
					<!-- <option value="30">大文本域</option> -->
					<option value="11">列表框</option>
					<option value="23">单选用户</option>
					<option value="24">多选用户</option>
					<option value="25">单选部门</option>
					<option value="26">多选部门</option>
					<option value="27">单文件上传</option>
					<option value="28">多文件上传</option>
					<option value="29">流程意见</option>
					<!-- <option value="31">关联文档</option> -->
				</select>
			</td>
		</tr>
		<tr id="tr004" name="tr004">
		  	<td id="td007" style="width:30%;" name="td007" class="tdLabelCls">
				<label class="label" id="label004" name="label004" >
					字段类型
				</label>
		  	</td>
			<td id="td008" style="width:70%;" name="td008" class="tdValueCls">
				<select class="form-control select2-accessible" id="dataType" readonly="readonly" disabled="disabled" onchange="setStyle();">
					<option value="1">字符</option>
					<option value="3">整数</option>
					<option value="9">小数</option>
					<option value="6">布尔</option>
					<option value="7">日期时间</option>
					<option value="8">二进制</option>
				</select>
		  	</td>
		</tr>
		<tr id="tr005" name="tr005">
		  	<td id="td009" style="width:30%;" name="td009" class="tdLabelCls">
				<label class="label" id="label005" name="label005">
					长度
				</label>
		  	</td>
			<td id="td010" style="width:70%;" name="td010" class="tdValueCls">
				<input type="number" class="form-control" value="${property.length}" required="false" id="length" style="width:100%" name="length"/>
		  	</td>
		</tr>
		<tr id="tr008" name="tr008">
		  	<td id="td015" style="width:30%;" name="td015" class="tdLabelCls">
				<label class="label" id="label008" name="label008">
					精度
				</label>
		  	</td>
			<td id="td016" style="width:70%;" name="td016" class="tdValueCls">
				<input class="form-control" value="${property.precision}" required="false" id="precision" style="width:100%" name="precision"/>
		  	</td>
		</tr>
		<tr id="tr006" name="tr006">
		  	<td id="td011" style="width:30%;" name="td011" class="tdLabelCls">
				<label class="label" id="label006" name="label006">
					显示格式
				</label>
		  	</td>
			<td id="td012" style="width:70%;" name="td012" class="tdValueCls">
				<select class="form-control select2-accessible" id="formatPatternDate" onchange="setDisplayFormatValueFromDate();">
					<option value=""></option>
					<option value="yyyy-MM-dd">yyyy-MM-dd</option>
					<option value="yyyy年MM月dd日">yyyy年MM月dd日</option>
					<option value="yyyy-MM-dd HH:mm">yyyy-MM-dd HH:mm</option>
					<option value="yyyy年MM月dd日 HH:mm">yyyy年MM月dd日 HH:mm</option>
				</select>
				<!-- <select class="form-control select2-accessible" id="formatPatternNumber" onchange="setDisplayFormatValueFromNum();"">
					<option value=""></option>
					<option value="#.##%">百分号</option>
					<option value="#,##0.00">千分位</option>
					<option value="DHM">天*时*分</option>
					<option value="DAY">天</option>
					<option value="#.00">#.00</option>
				</select> -->
				<input class="form-control" id="formatPatternNumber"  style="width:100%" name="formatPatternNumber" onchange="setDisplayFormatValueFromNum();"/>
		  	</td>
		</tr>
		<tr id="tr007" name="tr007">
		  	<td id="td013" style="width:30%;" name="td013" class="tdLabelCls">
				<label class="label" id="label007" name="label007">
					数据字典
				</label>
		  	</td>
			<td id="td014" style="width:70%;" name="td014" class="tdValueCls">
				<div class="col-md-12 input-group " style="display: inline-table;  vertical-align: middle; width:100%">
					<input placeholder="单击选择数据字典" readonly="readonly" class="form-control" value="${property.optionsStr}" required="false" id="selectItemsStr" style="width:100%" name="selectItemsStr" onclick="onselectItemsClick();"/>
					<span class="input-group-addon addon-udSelect udSelect " onclick="onselectItemsClick()"><i class="fa fa-th-large"></i></span>
				</div>
		  	</td>
		</tr>
		<script>
			/*
			function onselectItemsClick() {
				layer.open({
					type:2,
					title:['设置下拉选项'],
					area:['85%','100%'],
					content:'<%=request.getContextPath()%>/form/admin/custom/queryList/h5Options.jsp?command=edit&mode=propertyedit&parentType=DataCell&iframewindowid=selectItemsDialog'
				});						
			};
			
			function onselectItemsDialogClose(data) {
				if (data == null) return true;
				if (data['info'] != null) {
		 			document.getElementById('selectItems').value = data['info'];
		 			document.getElementById('selectItemsStr').value = data['infoStr'];
				}
			}
			*/
			//formdesigner.js弹出回调
			function onselectItemsClick() {
				//记录弹出窗口对象
				parent.isc.MFH.winObj = this;
				//弹出窗口
				parent.layer.open({
					id:'m_selectItems',
					type:2,
					title:['设置下拉选项'],
					shade: [0.1, '#000'],
					shadeClose: false, //开启遮罩关闭
					area : [ '55%', '70%' ],
					content:'<%=request.getContextPath()%>/form/admin/code/h5CodeManager.jsp?iframewindowid=m_selectItems'
				});						
			};
			//选择数据字典回调
			function onm_selectItemsClose(data) {
				if(data){
					var info = data.info;
					var infoStr = data.infoStr;
					
					document.getElementById('selectItems').value = info;
		 			document.getElementById('selectItemsStr').value = infoStr;
				}
			}
		</script>
		<tr id="tr009" name="tr009">
		  	<td id="td016" style="width:30%;" name="td016" class="tdLabelCls">
				<label class="label" id="label009" name="label009">
					默认值
				</label>
		  	</td>
			<td id="td017" style="width:70%;" name="td017" class="tdValueCls">
				<input id="defaultValue" type="hidden" name="defaultValue" value=""/>
				<select class="form-control select2-accessible" id="defaultValue_select">
					<!-- <option value="_0">当前用户编码</option> -->
					<option value="_1">当前用户名称</option>
					<!-- <option value="_2">当前用户部门编码</option> -->
					<option value="_3">当前用户部门名称</option>
					<!-- <option value="_12">当前用户上级部门编码</option> -->
					<option value="_13">当前用户上级部门名称</option>
					<!-- <option value="_10">当前用户一级部门编码</option> -->
					<option value="_11">当前用户一级部门名称</option>
					<!-- <option value="_20">当前用户二级部门编码</option> -->
					<option value="_21">当前用户二级部门名称</option>
					<!-- <option value="_4">当前用户机构编码</option> -->
					<option value="_5">当前用户机构名称</option>
					<option value="_6">当前日期</option>
					<option value="_7">当前时间</option>
					<option value="_8">当前日期时间</option>
					<option value="true">true</option>
					<option value="false">false</option>
				</select>
		  	</td>
		</tr>
		<%-- <tr id="tr010" name="tr010">
		  	<td id="td018" style="width:30%;" name="td018" class="tdLabelCls">
				<label class="label" id="label010" name="label010">
					必填
				</label>
		  	</td>
			<td id="td019" style="width:70%;" name="td019" class="tdValueCls">
				<input type="checkbox" class="form-control" value="${property.isRequired}" required="false" id="input010" style="width:100%" name="input010"/>
				<select class="form-control select2-accessible" id="isRequired">
					<option value="">否</option>
					<option value="1">是</option>
				</select>
		  	</td>
		</tr> --%>
		<tr id="tr011" name="tr011">
		  	<td id="td020" style="width:100%;" colspan="2" name="td020" class="cmdLayout">
		  		<div id="button001_div" class="matrixInline">
					<button class="x-btn ok-btn " onclick="saveData();">
						<span>保存</span>
					</button>
					<input id="button3" type="button" class="x-btn cancel-btn " value="取消" onclick="Matrix.closeWindow()">
				</div>
		  	</td>
		</tr>
	</table>
	 
 </body>				