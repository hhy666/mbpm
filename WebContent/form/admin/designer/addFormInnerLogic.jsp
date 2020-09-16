<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>添加内置逻辑2!</title>
	<jsp:include page="/form/admin/common/taglib.jsp"/>
	<jsp:include page="/form/admin/common/resource.jsp"/>
	<jsp:include page="/form/admin/common/loading.jsp"/>
<script type="text/javascript">
    //编辑时初始表单数据
	function initPage(){
		var opType = "${param.opType}"// parent.MDialog0.opType;
		if(opType!=null && opType=="update"){//编辑
	   		document.getElementById("type").value='${operation.type}';//
		 	var type = '${operation.type}';//修改为字符串
		  	if(type=='script'){//脚本逻辑 禁用选方法键
		  		var addMethodButton = Matrix.getMatrixComponentById("addMethodButton");
		  		addMethodButton.setDisabled(true);
		    }
		}
	}

    //提交添加的数据
    function convertJsonData(){
	    var data = null;
	    //获取需要提交的数据
	    var type = document.getElementById("type").value;//服务类型 service javabean script
	    var eventType = document.getElementById("eventType").value;//
	    var ajaxEventType = document.getElementById("ajaxEventType").value;//
	    var serviceValue =  Matrix.getMatrixComponentById("service").getValue();
	    var serviceNameValue = document.getElementById("serviceName").value;//服务节点路径
	    var condition = Matrix.getMatrixComponentById("condition").getValue();//条件
	    var nameValue = Matrix.getMatrixComponentById("name").getValue();
	    if(type=='service'||type=='javabean'){//服务逻辑
		      var serviceLocation = document.getElementById("serviceLocation").value;
		      var methodName = document.getElementById("methodName").value;
			  var methodTitle = document.getElementById("methodTitle").value;
			  if(methodName==null||methodName.length==0){
			  	isc.warn('请选择方法!');
			  	return false;
			  }
			  
			  if(methodTitle==null||methodTitle.length==0){
			  		isc.warn('请选择方法!');
			  		return false;
			  }
		      var inputs = MDataGrid2.getData();
			  var returnPO = MDataGrid4.getData();
			    // inputs = isc.JSON.encode(inputs);
				// returnPO = isc.JSON.encode(returnPO);
		      data={'name':nameValue,'service':serviceValue,'serviceName':serviceNameValue,'location':serviceLocation,'inputs':inputs,'returnPO':returnPO,'methodName':methodName,'methodTitle':methodTitle,'condition':condition,'eventType':eventType,'ajaxEventType':ajaxEventType,'type':type};
	    }else if(type=='script'){//脚本逻辑
	          data={'name':nameValue,'service':serviceValue,'serviceName':serviceNameValue,'condition':condition,'eventType':eventType,'ajaxEventType':ajaxEventType,'type':type};
	    
	    }
        return data;
    }
    
	//选择方法
    function selectedMethod(){
	    var serviceLocation = document.getElementById("serviceLocation").value;
	    var type = document.getElementById("type").value;//服务类型
	    var dialog1 = Matrix.getMatrixComponentById("Dialog1");
	    
	    var url = "<%=request.getContextPath()%>/designer/formDesign_getServiceMethods.action?serviceLocation="+serviceLocation+"&type="+type;
	    MDialog1.initSrc = url;
	    
	    Matrix.showWindow("Dialog1");
    
    }
    
    
     //关闭方法弹出框触发该方法
     function onDialog1Close(data,oType){//方法为 method json obj
        var result = false;
       
        if(data!=null){
        
	         //将方法信息写入
	          var methodId = Matrix.getMatrixComponentById("methodId");
	          var methodFullNameMsg = document.getElementById("methodFullNameMsg");
	          methodId.setValue(data.methodTitle);
	          var naValue = Mname.getValue();
	          if(naValue==null||naValue.length==0){
				      Mname.setValue(data.methodTitle);//
			  }
	           setDivValue(methodFullNameMsg,"信息:"+data.fullName);//显示服务信息
	          var inputs = data.inputJsonList;
	          
	          var inputsJson = isc.JSON.decode(inputs);
	          var inputObj;
	          var inLen = inputsJson.length;
	          //添加时toType默认值为type
	          for(var i=0;i<inLen;i++){
	                inputObj = inputsJson[i];
	          		inputObj.toType = inputObj.type;
	          }
	          var output = data.outputJsonObj;
	          var outputJson;
	          if(output==null){
	          		outputJson =isc.JSON.decode("[]");
	          }else{
	         		outputJson = isc.JSON.decode("["+output+"]");
	          }
	          //方法名和标题
	          var methodName = document.getElementById("methodName");
	          var methodTitle = document.getElementById("methodTitle");
	          methodName.value = data.methodName;
	          methodTitle.value = data.methodTitle;
	          MDataGrid2.setData(inputsJson);//输入参数列表
		      MDataGrid4.setData(outputJson);//输出参数列表 
		      
		      return true;
	      }
         return true;
     }
	
   
     //选择服务[同时拿到id和 逻辑服务全路径]
	 function onDialog0Close(dataStr,oType){
	  
       if(dataStr!=null){
	   		var data = isc.JSON.decode(dataStr);
	   		var comType = data.comType;
	   		
	   		var addMethodButton = Matrix.getMatrixComponentById("addMethodButton");
	   		if(comType!=null&&(comType==1||comType==2)){//如果为服务逻辑
	   			//根据服务节点 获取服务信息
	   			var jsonData = {'data':data};
	   			var url = "<%=request.getContextPath()%>/designer/formDesign_getInnerLogic.action";
	            dataSend(jsonData,url,"POST",callbackInnerService,null);
	   			
	   		}else if(comType!=null&&comType==3){//脚本逻辑
	   		    //对应的服务逻辑类型为3
	   		     document.getElementById("type").value="script";//脚本逻辑为script
	   			 var service = Matrix.getMatrixComponentById("service");
	   			 var serviceNodeMsg = document.getElementById("serviceNodeMsg");
	   			 var serviceName = document.getElementById("serviceName");
		             serviceName.value = data.proEntityType;
	   			 service.setValue(data.id);
	   			 setDivValue(serviceNodeMsg,"信息:"+data.proEntityType);//显示服务信息
	   			 //将选方法按钮禁用
	   			 addMethodButton.setDisabled(true);
	   		}
	   }
    
	  return true; 
	 }
	 
	//内置服务 回调
	 function callbackInnerService(data){
	 	var callDataStr = data.data;
	 	if(callDataStr=="false"){
	 		isc.warn('添加内置服务异常!');
	 		return;
	 	}else if(callDataStr=="setError"){
	 		isc.warn('未正确设置服务的实现类!');
	 		return;
	 	}else if(callDataStr=="classNoFound"){
	 		isc.warn('未找到该服务的实现类!');
	 		return;
	 	}
	    var jsonObj = isc.JSON.decode(callDataStr);
	    var type = jsonObj.type;//service javabean script custom
	    document.getElementById("type").value=type;//保存类型
	    
	    var service = Matrix.getMatrixComponentById("service");//获取服务组件
	    var addMethodButton = Matrix.getMatrixComponentById("addMethodButton");
		service.setValue(jsonObj.serviceId);//设置服务标识mid
		
	    var serviceNodeMsg = document.getElementById("serviceNodeMsg");
	   	var serviceName = document.getElementById("serviceName");//服务节点全路径
		serviceName.value = jsonObj.proEntityType;
		setDivValue(serviceNodeMsg,"信息:"+jsonObj.proEntityType);//显示服务信息
		
	    if(type=='service'||type=='javabean'){//服务逻辑
		    var methodCount = jsonObj.methodCount;
		    var serviceLocation = document.getElementById("serviceLocation");//全路径
		    var methodFullNameMsg = document.getElementById("methodFullNameMsg");
		    
		    serviceLocation.value = jsonObj.serviceName;//保存服务标识
		   // serviceLocation.value = jsonObj.serviceLocation;//将服务bean路径保存
		    //DataGrid2
			var methodId = Matrix.getMatrixComponentById("methodId");//获取方法显示组件
		    if(methodCount!=null&&methodCount==1){//服务中只有一个方法
			      var method = jsonObj.method;
			    
			      addMethodButton.setDisabled (true);//添加按钮不可用
			      //写入方法名，禁用选方法按钮
			      methodId.setValue(method.methodTitle);//设置方法显示值methodInfo全值
			      var naValue = Mname.getValue();
			      if(naValue==null||naValue.length==0){
				      Mname.setValue(method.methodTitle);//
			      }
			      setDivValue(methodFullNameMsg,"信息:"+method.fullName);//显示服务信息
			    
			      document.getElementById("methodName").value = method.methodName;
			      document.getElementById("methodTitle").value = method.methodTitle;
			      
			      //将输入输出参数写入 列表
			      MDataGrid2.setData(method.inputs);
			      MDataGrid4.setData([method.returnPO]);
		      
		    }else if(methodCount!=null&&methodCount>1){//服务中有多个方法
		        addMethodButton.setDisabled (false);//方法按钮可用
		        document.getElementById("methodName").value = null;
		        document.getElementById("methodTitle").value = null;
		        //清空方法信息
		        setDivValue(methodFullNameMsg,"");//显示服务信息
		        serviceLocation.value = jsonObj.serviceName;
		        
	           	MDataGrid2.setData([]);
		       	MDataGrid4.setData([]);
		        MmethodId.clearValue();
		    }
	    }else if(type=='script'){//脚本逻辑
	      addMethodButton.setDisabled (true);//添加按钮不可用
	    }
	 }
	 
	//hover信息
	function testHoverHtml(record, rowNum, colNum){
            // return "<div style='width:200px;height:20px'>"+record.service+"</div>";
    }   
   
   //自定义输入参数类型[下拉选择]
   function customInputValueType(listGrid,record,colNum){
   		var rowNumber = listGrid.getRecordIndex(record);
   		var recordCanvas = isc.HLayout.create({
                height: 22,
                width:180,
                align: "left",
                members:[
                	isc.MatrixHTMLFlow.create({
                		contents:"<div eventProxy='MForm0' id='combobox_"+listGrid.name+"_"+rowNumber+"_display' style='width:180;height:20'></div>"
                	})
                ]
            });
            
           var Mtype_VM=[];
           Mtype_VM=['String','Integer','Long','Float','Double','Boolean','Date','BigDecimal','Timestamp','Byte','List','Object','DataObject'];
           var Mtype;
            MForm0.addField(
             isc.SelectItem.create({
                ID:"M"+listGrid.name+"_"+rowNumber+"_type",
                name:listGrid.name+"_"+rowNumber+"_type",
                width:180,
            	valueMap:Mtype_VM,
                editorType:"SelectItem",
            	displayId:"combobox_"+listGrid.name+"_"+rowNumber+"_display",
            	position:"relative",
            	value:record.type,
            	changed:function(form, item, value){
            	//选择类型改变时将新类型赋值给toType
            		record.toType=value;
            		
            	} 
            	
            }));
            Mtype =eval("M"+listGrid.name+"_"+rowNumber+"_type");
	    	Mtype.displayValueMap={'String':'字符型','Integer':'整型','Long':'长整型','Float':'单精度小数','Double':'双精度小数','Boolean':'布尔型','Date':'日期时间','BigDecimal':'数值','Timestamp':'时间戳','Byte':'二进制','List':'列表','Object':'任意对象','DataObject':'实体类型'};
           // Mtype.setValueMap(Mtype_VM);
            Mtype.setValue(record.toType);
             return recordCanvas;  
   		
   }
    // 定义修改输入参数值组件
	function paramValueCustomFunc(listGrid,record,colNum){
	     var  rowNumber = listGrid.getRecordIndex(record);
		 var recordCanvas = isc.HLayout.create({
                height: 22,
                width:180,
                align: "left",
                members:[
                	isc.MatrixHTMLFlow.create({
                		contents:"<div id='testInput"+listGrid.name+rowNumber+"' style='width:180;height:20'></div>"
                	}),
		           isc.ImgButton.create({
		                showDown: false,
		                showRollOver: false,
		                layoutAlign: "right",
		                src:Matrix.getActionIcon("query"),
		                prompt: "添加表单变量",
		                height: 16,
		                width: 16,
		                autoDraw:false,
		                grid: this,
		                click:function(){
		                    //获取当前的表单变量
		                    MDialog2.dataGrid = listGrid;
		                    MDialog2.rowNum = rowNumber;
		                    Matrix.showWindow('Dialog2'); 
		                }
		            })
                ]
            });
            
              MForm0.addField(
             isc.TextItem.create({
                ID:"M"+listGrid.name+"_"+rowNumber+"_InputText",
                width:180,
            	displayId:'testInput'+listGrid.name+rowNumber,
            	position:"relative",
            	editorExit: function(form, item){
	            	var value = item.getValue();//输入框值
	            	if(value==null)value="";
	            	record.value = value;//给当前记录赋值
            	}
            }));
           var MInputTextID = eval("M"+listGrid.name+"_"+rowNumber+"_InputText");
           MInputTextID.setValue(record.value);
            return recordCanvas;  
     }
     
       //选表单变量值 保存时触发
      function onDialog2Close(dataStr,oType){
   		if(dataStr!=null){
   		   var data = isc.JSON.decode(dataStr);//get var full path
   		   var varFullPath =data.parentNodeId; 
   		   var varValue = varFullPath;
   		   var listGrid =  MDialog2.dataGrid;
   		   var rowNum = MDialog2.rowNum;
   		   var record = listGrid.getRecord(rowNum);
   		   //拼接json写入输入框 和record数据
   		   record.value = varValue;
   		   var MInputTextID = eval("M"+listGrid.name+"_"+rowNum+"_InputText");
   		   MInputTextID.setValue(varValue);
   		  //处理完毕 将弹出框信息置空
   		}
   		 MDialog2.dataGrid = null;
		 MDialog2.rowNum = null;
         return true;
     }
 
</script>
</head>
<body >

<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow:auto;">
<script> 
var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"",
		fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]
	});
</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="opType" id="opType" value="${param.opType}" />
	<input type="hidden" id="eventType" name="eventType" value="${param.eventType}" />
	<input type="hidden" id="ajaxEventType" name="ajaxEventType" value="${param.ajaxEventType}" />
	
	<input type="hidden" name="serviceName" id="serviceName" value="${operation.serviceName}"/><!--服务节点全路径-->
	<input type="hidden" name="serviceLocation" id="serviceLocation" value="${operation.location}"/><!--选方法时判断是否选服务  -->
	<!--用户存储方法名和标题  -->
	<input type="hidden" name="methodName" id="methodName" value="${operation.methodName}"/>
	<input type="hidden" name="methodTitle" id="methodTitle" value="${operation.methodTitle}"/>
	<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}"/>
	<input type="hidden" name="type" id="type"  value="${operation.type}"/><!-- 操作类型 字符串  -->
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
   

   
<!-- 数据列表 --> 

<table id="table1" jsId="table1" class="maintain_form_content" 
	cellpadding="0px" cellspacing="0px" margin-left: 1px;border: 1px;margin-right:2px;">
	
		<tr >
		<td  class="maintain_form_label" style="width: 20%;height:30px;">
			<label id="j_id5c" name="j_id5c"
				style="margin-left: 10px"> 名&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
		</td>
		
		<td id="j_id6c" jsId="j_id6c" class="maintain_form_input" colspan="2">
		<div id="name_div" eventProxy="MForm0" class="matrixInline" style="float:left"></div>
		<script> 
		var name2=isc.TextItem.create({
					ID:"Mname",
					name:"name",
					editorType:"TextItem",
					displayId:"name_div",
					position:"relative",
					width:260,
					required:true,
					value:"${operation.name}",
					 validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		  
		      		      return inputNameValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"非空字段!"
		      		 }]
				});
				MForm0.addField(name2);
				</script>
				<span id="MultiLabel0" style="width: 20px; height: 20px; color: #FF0000; font-weight:blod;">*</span>
		 </td>
	</tr>
	
	
	<tr id="j_id4" jsId="j_id4" >
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" >
			<label id="j_id6" name="j_id6" style="margin-left: 10px"> 服&nbsp;&nbsp;&nbsp;&nbsp;务：</label>
		</td>
			
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" style="width:230px;">
		      <div id="service_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
			
	<script>
		 var service=isc.TextItem.create({
			 ID:"Mservice",
			 name:"service",
			 editorType:"TextItem",
			 displayId:"service_div",
			 position:"relative",
			 canEdit:false,
			 width:260,
			 value:"${operation.service}",
			 validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		    if(value==null||value.length==0){
						  validator.errorMessage="请选择服务!";
						  return false;
						}
							
		      		      return true;
		      		     },
		      		     errorMessage:"请选择服务!"
		      		 }]
		 });
		 MForm0.addField(service);
		 </script>
		  <script>
			  isc.ImgButton.create({
					  ID:"MImageButton2",
					  name:"ImageButton2",
					  showDisabled:false,
					  showDisabledIcon:false,
					  showDown:false,
					  showDownIcon:false,
					  showRollOver:false,
					  showRollOverIcon:false,
					  position:"relative",
					  width:18,
					  height:18,
					  src:Matrix.getActionIcon("query"),
					  prompt:"添加"
			  });
			  MImageButton2.click=function(){
				  Matrix.showMask();
				  Matrix.showWindow('Dialog0');
				  Matrix.hideMask();
			  }
			  </script>
		 </td>
		 
		 <td id="j_id8" jsId="j_id8" align="left" style="overflow:auto;border: 1px solid #cccccc;text-align: left;">
			    <span id="serviceNodeMsg" >
				${empty operation.serviceName?'':'信息：'}${operation.serviceName}&nbsp;
			   
			   </span>
		   
		 </td> 
		 
	</tr> 
 
	<tr id="j_id45" jsId="j_id45">
		<td id="j_id46" jsId="j_id46" class="maintain_form_label" 
			rowspan="1"><label id="j_id47" name="j_id47" style="margin-left: 10px"> 方&nbsp;&nbsp;&nbsp;&nbsp;法：</label>
		</td>
		<td id="j_id48" jsId="j_id48"  class="maintain_form_input">
		<div id="methodId_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script>
			 //选方法
			 var methodId=isc.TextItem.create({
					 ID:"MmethodId",
					 name:"methodId",
					 editorType:"TextItem",
					 displayId:"methodId_div",
					 position:"relative",
					 width:260,
					 canEdit:false,
					 value:"${operation.methodTitle}",
					 validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		      //当选完服务[服务逻辑]时验证
		      		       var hasInput =true;
		      		       var serviceType =  document.getElementById("type").value;
		      		       var type =parseInt(serviceType);
		      		       if(type==1||type==2){//服务逻辑
		      		       		var service = Matrix.getMatrixComponentById("service").getValue();
		      		       		if(service!=null){
		      		       		    if(value==null||value.length==0){
									  validator.errorMessage="请选择方法!";
									  return false;
									}
		      		       			
		      		       			
		      		       		}
		      		       }
		      		    	
		      		      return hasInput;
		      		     },
		      		     errorMessage:"请选择方法!"
		      		 }]
					 
			 });
			 MForm0.addField(methodId);
			  
			</script>
			<script>
			 isc.ImgButton.create({
			 	ID:"MaddMethodButton",
			 	name:"addMethodButton",
			 	showDisabled:false,
			 	showDisabledIcon:false,
			 	showDown:false,
			 	showDownIcon:false,
			 	showRollOver:false,
			 	showRollOverIcon:false,
			 	position:"relative",
			 	width:18,
			 	height:18,
			 	src:Matrix.getActionIcon("query"),
			 	prompt:"添加"
			 	});
			 	MaddMethodButton.click=function(){
			 	   var serviceLocation = document.getElementById("serviceLocation").value;
				 	Matrix.showMask();
				 	//判断服务是否为空
				 	if(serviceLocation!=null&&serviceLocation.trim().length>0){
							 	selectedMethod();
				 	
				 	}else{
				 		isc.say("请先选择服务！");
				 	}
				    Matrix.hideMask();
			   }
			  </script>
			 
		
		</td>
		 <td id="j_id8" jsId="j_id8"  style="border: 1px solid #cccccc;text-align: left;">
		     <span id="methodFullNameMsg">    
		    ${empty requestScope.methodFullName?'':'信息：'}${requestScope.methodFullName}&nbsp;
		    
		    </span>
		  </td>
	</tr>
	
	<!-- 88888888888888888888888888888888888 -->
	 
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label">
		<label id="j_id11" name="j_id11" style="margin-left: 10px"> 条&nbsp;&nbsp;&nbsp;&nbsp;件：</label>
		</td>
		
		<td id="td13746607184840" jsId="td13746607184840" align="left" class="maintain_form_input" >
		<div id="condition_div" eventProxy = "MForm0" class="matrixInline" style=""></div>
		<script>
			 var condition=isc.TextItem.create({
			 		ID:"Mcondition",
			 		name:"condition",
			 		editorType:"TextItem",
			 		displayId:"condition_div",
			 		position:"relative",
			 		width:260,
			 		value:"${operation.condition}"
			 });
			 MForm0.addField(condition);
			 </script>
			
			</td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input">
			
			</td>
	</tr>
	
	
	<tr >
				<td align="left" style="background-color: #A9D6F3;height:32px;" colspan="3">
					<span id="MultiLabel8" style="width: 90px; height: 20px;"> 输入参数：</span>
				</td>
			</tr>
			<tr>
				<td  colspan="3">
				<input id="ioType" type="hidden" name="ioType" value="0" />
				<div id="DataGrid2_div" class="matrixComponentDiv" style="width: 100%; height: 135px">
				<script> 
				
					isc.MatrixListGrid.create({
							ID:"MDataGrid2",
							name:"DataGrid2",
							width:"100%",
						    height:"100%",
							showAllRecords:true,
						    canSort:false,
						    canExport:false,
							displayId:"DataGrid2_div",
							position:"relative",
							fields:[
								{
									title:"&nbsp;",
									name:"MRowNum",
									canSort:false,
									canExport:false,
									canDragResize:false,
									showDefaultContextMenu:false,
									autoFreeze:true,
									autoFitEvent:'none',
									width:45,
									canEdit:false,
									canFilter:false,
									autoFitWidth:false,
									formatCellValue:function(value, record, rowNum, colNum,grid){
										if(grid.startLineNumber==null)return '&nbsp;';
										return grid.startLineNumber+rowNum;
									}
								},{
									title:"编码",
									matrixCellId:"j_id42",
									name:"name",
									canEdit:false,
									canSort:false,
									width:'20%',
									editorType:'Text',
									type:'text',
									formatCellValue:function(value, record, rowNum, colNum,grid){
										return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
									}
								},{
									title:"名称",
									matrixCellId:"j_id43",
									name:"title",
									canEdit:false,
									canSort:false,
									width:'20%',
									editorType:'Text',
									type:'text',
									formatCellValue:function(value, record, rowNum, colNum,grid){
										return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
									}
								},{
									title:"类型",
									matrixCellId:"j_id44",
									name:"toType",
									canEdit:false,
									canSort:false,
									width:'26%',
									editorType:'Text',
									type:'text',
									customComponentFunction:"customInputValueType",
									formatCellValue:function(value, record, rowNum, colNum,grid){
										return '';
									}
								},{
									title:"值",
									matrixCellId:"j_id45",
									name:"value",
									canSort:false,
									canFilter:false,
									canEdit:false,
									canExport:false,
									width:'34%',
									customComponentFunction:"paramValueCustomFunc",
									formatCellValue:function(value, record, rowNum, colNum,grid){
										return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
									}
								}
							],
							autoSaveEdits:false,
							autoFetchData:true,
							selectionType:"single",
							selectionAppearance:"rowStyle",
							alternateRecordStyles:true,
							canSort:true,
							canAutoFitFields:false,
							cellDoubleClick:function(record, rowNum, colNum){
								//Matrix.showWindow('Dialog2');
								//(record, rowNum, colNum);
							},
							canHover:true,
							startLineNumber:1,
							canEdit:false,
							editEvent:"doubleClick",
							showHover:true,
							cellHoverHTML:"testHoverHtml",
					        showRecordComponents:true,
					        showRecordComponentsByCell:true
					    });
					        //修改时获取选取方法的输入参数值
					        var inputsData = null;
					        <%
					        	if(request.getAttribute("inputsJson")!=null){
					        		out.print("inputsData="+request.getAttribute("inputsJson")+";");
					        	}
					        %>
						    //var inputsData = ${inputsJson};
						    if(inputsData!=null&&inputsData.length>0){
						      
						       //var inputsJson = isc.JSON.decode(inputsData);
						       var inputsJson = inputsData;
						       MDataGrid2.setData(inputsJson);//初始值
						    }
	             isc.Page.setEvent(isc.EH.LOAD,"MDataGrid2.resizeTo('100%','100%');");
	             isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid2.resizeTo(0,0);MDataGrid2.resizeTo('100%','100%');",null);
	           </script>
	          </div>
			
					
			</td>
			</tr>
			
			
			<tr id="j_id47" jsId="j_id47" >
				<td id="j_id48" jsId="j_id48" align="left" colspan="3"
					style="background-color: #A9D6F3;height:32px;"><span id="MultiLabel6"
					style="width: 90px; height: 20px;"> 返回值：</span>
					</td>
			</tr>
			<tr>
				<td colspan="3">
				<input id="ioType1" type="hidden" name="ioType1" value="1" />
				<div id="DataGrid4_div" class="matrixComponentDiv"
					style="width: 100%; height: 80px">
					<script>
					   
						   isc.MatrixListGrid.create({
						   ID:"MDataGrid4",
						   name:"DataGrid4",
						   width:"100%",
						   height:"100%",
							showAllRecords:true,
						   displayId:"DataGrid4_div",
						   canSort:false,
						   canExport:false,
						   position:"relative",
						   fields:[
						   		{
						   			title:"&nbsp;",
						   			name:"MRowNum",
						   			canSort:false,
						   			canExport:false,
						   			canDragResize:false,
						   			showDefaultContextMenu:false,
						   			autoFreeze:true,
						   			autoFitEvent:'none',
						   			width:45,
						   			canEdit:false,
						   			canFilter:false,
						   			autoFitWidth:false,
						   			formatCellValue:function(value, record, rowNum, colNum,grid){
						   					if(grid.startLineNumber==null)return '&nbsp;';
						   					return grid.startLineNumber+rowNum;
						   					}
						   		},{
						   			title:"编码",
						   			matrixCellId:"j_id54",
						   			name:"name",
						   			canEdit:false,
						   			canSort:false,
						   			width:'40%',
						   			editorType:'Text',
						   			type:'text',
						   			formatCellValue:function(value, record, rowNum, colNum,grid){
						   				return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
						   			}
						   		},{
						   			title:"类型",
						   			matrixCellId:"j_id56",
						   			name:"type",
						   			canEdit:false,
						   			canSort:false,
						   			width:'25%',
						   			editorType:'select',
						   			type:'text',
						   			valueMap:{'String':'字符型','Integer':'整型','Long':'长整型','Float':'单精度小数','Double':'双精度小数','Boolean':'布尔型','Date':'日期时间','BigDecimal':'数值','Timestamp':'时间戳','Byte':'二进制','List':'列表','Object':'任意对象','DataObject':'实体类型'},
						   			
						   			formatCellValue:function(value, record, rowNum, colNum,grid){
						   					return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
						   			}
						   		},{
						   			title:"值",
						   			matrixCellId:"j_id57",
						   			name:"value",
						   			canSort:false,
						   			canFilter:false,
						   			canEdit:false,
						   			canExport:false,
						   			width:'35%',
						   			customComponentFunction:"paramValueCustomFunc",
						   			formatCellValue:function(value, record, rowNum, colNum,grid){
						   					return Matrix.formatter(value,'normal','null', record, rowNum, colNum,grid);
						   			}
						   		}
						   	],
						   autoSaveEdits:false,
						   autoFetchData:true,
						   selectionType:"single",
						   selectionAppearance:"rowStyle",
						   alternateRecordStyles:true,
						   canSort:true,
						   canAutoFitFields:false,
						   recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue){
						   			//Matrix.showWindow('Dialog3');
						   			//(viewer, record, recordNum, field, fieldNum, value, rawValue);
						   },
						   canHover:true,
						   startLineNumber:1,
						   canEdit:false,
						   editEvent:"doubleClick",
						   showHover:true,
						   cellHoverHTML:"testHoverHtml",
						   showRecordComponents:true,
						   showRecordComponentsByCell:true
						 });
						 var outputData = null;
					        <%
					        	if(request.getAttribute("outputJson")!=null){
					        		out.print("outputData="+request.getAttribute("outputJson")+";");
					        	}
					        %>
						 //var outputData = ${outputJson};
					    if(outputData!=null){
					       var outputJsonObj = [];
					       outputJsonObj.add(outputData);
					       MDataGrid4.setData(outputJsonObj);//初始值
					    }
						// MDataGrid4.setData(MDataGrid4_DS);
					isc.Page.setEvent(isc.EH.LOAD,"MDataGrid4.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid4.resizeTo(0,0);MDataGrid4.resizeTo('100%','100%');",null);
					</script>
				</div>
				   
					
					</td>
			</tr>
		
	
	
	<tr id="j_id49" jsId="j_id49">
		<td id="j_id50" jsId="j_id50" class="maintain_form_command" colspan="3">
		
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="width: 60px; position: relative;; height: 22px;">
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
			showDisabledIcon:false,
			showDownIcon:false,
			showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					if(!MForm0.validate()){//表单验证
						Matrix.hideMask(); 
						return false;
					}
					//添加或更新返回的data数据
					var data = convertJsonData();
					if(data==false){
						Matrix.hideMask(); 
						return false;
					}
					
					Matrix.closeWindow(data);
		            Matrix.hideMask();
		};</script></div>
		
		&nbsp&nbsp&nbsp
		
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="width: 60px; position: relative;; height: 22px;margin-top:2px;">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,
					left:0,
					width:"60",
					height:"100%",
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormCancelButton.click=function(){
				Matrix.showMask();
				Matrix.closeWindow();
		
			Matrix.hideMask();
		};
	</script></div>
		</td>
	</tr>
</table>

</form>
<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
//isc.Page.setEvent(isc.EH.LOAD,"initPage()",null);</script>
<script>
			 function getParamsForDialog0(){
			 	var params='&iframewindowid=Dialog0&';
			 	var value;
			 	value=null;
			 	return params;
			 }
			 isc.Window.create({
				 ID:"MDialog0",
				 autoCenter: true,
				 position:"absolute",
				 height: "95%",
				 width: "50%",
				 title: "添加服务",
				 canDragReposition: false,
				 showMinimizeButton:false,
				 showMaximizeButton:false,
				 showCloseButton:true,
				 showModalMask: false,
				 modalMaskOpacity:0,
				 isModal:true,
				 autoDraw: false,
				 headerControls:[
					 "headerIcon","headerLabel","minimizeButton",
					 "maximizeButton","closeButton"
				 ],
				 getParamsFun:getParamsForDialog0,
				 initSrc:"<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=15",
				 src:"<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=15" 
			});
			
			MDialog0.hide();
			</script>
			
			<script>
			 function getParamsForDialog1(){
			 	var params='iframewindowid=Dialog1&';
			 	var value;
			 	value=null;
			 	return params;
			 }
			 isc.Window.create({
				 ID:"MDialog1",
				 autoCenter: true,
				 position:"absolute",
				 height: "95%",
				 width: "90%",
				 title: "选择方法",
				 canDragReposition: false,
				 showMinimizeButton:true,
				 showMaximizeButton:true,
				 showCloseButton:true,
				 showModalMask: false,
				 modalMaskOpacity:0,
				 isModal:true,
				 autoDraw: false,
				 headerControls:[
					 "headerIcon","headerLabel","minimizeButton",
					 "maximizeButton","closeButton"
				 ],
				 getParamsFun:getParamsForDialog1,
				 initSrc:"",
				 src:"" 
			});
			
			MDialog1.hide();
			</script>
			<script>
			 function getParamsForDialog2(){
			 	var params='&iframewindowid=Dialog2&';
			 	var value;
			 	value=null;
			 	return params;
			 }
			 
			 isc.Window.create({
				 ID:"MDialog2",
				 autoCenter: true,
				 position:"absolute",
				 height: "95%",
				 width: "50%",
				 title: "选择参数值",
				 canDragReposition: false,
				 showMinimizeButton:true,
				 showMaximizeButton:true,
				 showCloseButton:true,
				 showModalMask: false,
				 modalMaskOpacity:0,
				 isModal:true,
				 autoDraw: false,
				 headerControls:[
					 "headerIcon","headerLabel","minimizeButton",
					 "maximizeButton","closeButton"
				 ],
				 getParamsFun:getParamsForDialog2,
				 initSrc:"<%=request.getContextPath()%>/common/formVarTree_loadFormVarPage.action",
				 src:"<%=request.getContextPath()%>/common/formVarTree_loadFormVarPage.action" 
			});
			
			MDialog2.hide();
			</script>
					 <script>
			 function getParamsForDialog3(){
			 	var params='iframewindowid=Dialog3&';
			 	var value;
			 	value=null;
			 	return params;
			 }
			 isc.Window.create({
				 ID:"MDialog3",
				 autoCenter: true,
				 position:"absolute",
				 height: "90%",
				 width: "50%",
				 title: "输出参数选值",
				 canDragReposition: false,
				 showMinimizeButton:true,
				 showMaximizeButton:true,
				 showCloseButton:true,
				 showModalMask: false,
				 modalMaskOpacity:0,
				 isModal:true,
				 autoDraw: false,
				 headerControls:[
					 "headerIcon","headerLabel","minimizeButton",
					 "maximizeButton","closeButton"
				 ],
				 getParamsFun:getParamsForDialog3,
				 initSrc:"",
				 src:"" 
			});
			
			MDialog3.hide();
			</script>
</div>

</body>
</html>






