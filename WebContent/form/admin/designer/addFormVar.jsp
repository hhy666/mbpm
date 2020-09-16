<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加表单变量</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT>var webContextPath="<%=request.getContextPath()%>";</SCRIPT>
<script type="text/javascript">
    
    //验证编码输入
	function formVarIdValidate(item, validator, value, record){
		if(value==null||value.length==0){
		  validator.errorMessage="编码不能为空!";
		  return false;
		}
		var hasInput = Matrix.validateLength(1,255, value);
		if(hasInput){
//		 var isMatch = value.match(/^[a-z][\w]*$/);
		 var isMatch = value.match(/[\w]*$/);
		 if(isMatch!=null){//非空
		   var rowNum = parent.MDialog0.rowNum;
		 	var allData = parent.MDialog0.allData;		
		 
		    if(allData!=null&&allData.length>0){//数据非空
		    	for(var i=0;i<allData.length;i++){
		    		var id = allData[i].id;
		    		if(rowNum!=null){//修改时验证
		    			if(rowNum!=i&&value==id){
			    			validator.errorMessage="编码重复，请重新输入";
			    			return false;
			    		}
		    		
		    		}else{//添加时验证
			    		if(value==id){
			    			validator.errorMessage="编码重复，请重新输入";
			    			return false;
			    		}
		    		}
		    	}
		    }
			 return true;
		 }
	   
	   //分类返回错误消息
		   var exceptMsg = value.match(/^[a-zA-Z\d_]+$/);//
		 	if(exceptMsg==null){//含有非法字符
			 	validator.errorMessage="只能使用字母数字下划线命名";
		   		return false;
		 	}
		  //2.以下划线 数字开头[第一位]
/*		  var validateMsg1 = value.match(/^[^a-z][a-zA-Z\d_]+$/);
		  if(validateMsg1!=null){
		  	validator.errorMessage="首字母小写";
	   		return false;
		  } 
*/
		 
	//   validator.errorMessage="只能使用字母、数字和下划线命名，且以小写字母开头";
	   return false;
	 }
	    validator.errorMessage="编码不能为空!";
		return hasInput;
 }
	
	
	//验证编码输入
	function formVarNameValidate(item, validator, value, record){
	
		if(value==null||value.length==0){
		  validator.errorMessage="名称不能为空!";
		  return false;
		}
		var hasInput = Matrix.validateLength(1,255, value);
		if(hasInput){
		 var isMatch = value.match(/^[\w\u4e00-\u9fa5]+$/);
		 if(isMatch!=null){//非空
		   var rowNum = parent.MDialog0.rowNum;
		 	var allData = parent.MDialog0.allData;		
		 
		    if(allData!=null&&allData.length>0){//数据非空
		    	for(var i=0;i<allData.length;i++){
		    		var name = allData[i].name;
		    		if(rowNum!=null){//修改时验证
		    			if(rowNum!=i&&value==name){
			    			validator.errorMessage="名称重复，请重新输入";
			    			return false;
			    		}
		    		
		    		}else{//添加时验证
			    		if(value==name){
			    			validator.errorMessage="名称重复，请重新输入";
			    			return false;
			    		}
		    		}
		    	}
		    }
			 return true;
		  }
		validator.errorMessage="不能使用字母汉字下划线以外的非法字符!";
	   return false;
	 }
		return hasInput;
	}


	 //当为修改时,需要回显记录数据
    function initEditForm(){
    	var oType = '${param.oType}';
    	var recordNum = parent.MDialog0.rowNum;
    	
    	if(oType=='update'&&recordNum!=null){//更新
    	     
    	     var record = parent.MDialog0.record;
    	     
    	     var type = record.type;
    	     var entityShowDiv = document.getElementById("entityTypeDiv");//对象类型div
    	     var initType = record.initType;
    	     if(type=='List'||type=='DataObject'){//对象或列表 对entity回显和显示组件
    	     	//重新渲染下拉框选项
	    	    MinitType_VM[2]= 'autoLoad';
	            MinitType.setValueMap(MinitType_VM);MinitType.setValue('');
    	      
    	       var initValueLabel = document.getElementById("initValueLabel");//输入值 标签
    	       Matrix.getMatrixComponentById("entity").setValue(record.entity);//对象类型
    	       entityShowDiv.style.display ="table-row";
    	       var initComponent = Matrix.getMatrixComponentById("initType");//初始方式组件
    	       //initComponent.setDisabled(false);
    	      	//initComponent.setCanEdit(true);
    	       if(initType=='autoLoad'){
    	        	if(type=='List'){//列表
   		       		    setDivValue(initValueLabel,"查询条件：");
   		    		}else if(type=='DataObject'){
   		    			setDivValue(initValueLabel,"主键值：");
   		     	    }
    	       }
    	     }
	    	 Matrix.getMatrixComponentById("mid").setValue(record.id);
			 Matrix.getMatrixComponentById("name").setValue(record.name);
			 var desc = record.desc;
			 if(desc!="undefined"&&desc!=null){
			    Matrix.getMatrixComponentById("desc").setValue(record.desc);
			 }
			 Matrix.getMatrixComponentById("type").setValue(type);//类型[需特殊处理]
			 //convertDataType(dataType);
			 Matrix.getMatrixComponentById("initType").setValue(record.initType);//初始方式
			 var initValue = record.initValue;
			 if(initValue!="undefined"&&initValue!=null){
				 Matrix.getMatrixComponentById("initValue").setValue(record.initValue);//变量默认值
			 }
    	   
    	}
    	//添加时 不初始数据 
    
    }
    
    //更新修改后的记录并返回
    function convertEditData(){
        var record = parent.MDialog0.record;
     	var mid = Matrix.getMatrixComponentById("mid").getValue();
     	var name = Matrix.getMatrixComponentById("name").getValue();
		var desc = Matrix.getMatrixComponentById("desc").getValue();
		var type = Matrix.getMatrixComponentById("type").getValue();//类型[需特殊处理]
		var entity = Matrix.getMatrixComponentById("entity").getValue();//关联对象属性
		var initType = Matrix.getMatrixComponentById("initType").getValue();//初始方式
		var initValue = Matrix.getMatrixComponentById("initValue").getValue();//变量默认值
        //给记录更新值
       record.id = mid;
       record.name = name;
       record.desc = desc;
       record.type = type;
       record.initType = initType;
       record.initValue = initValue;
       if(type=='List'||type=='DataObject'){
      	 record.entity = entity;
       }else{//不设置对象，将其置空
        record.entity = null;
       }
       return record;
    
    }

     
 		//parent.MDialog0.rowNum =null;//用完就归0
	//将提交的数据转换为json格式
	function convertAddData(){
		 var mid = Matrix.getMatrixComponentById("mid").getValue();
		 var name = Matrix.getMatrixComponentById("name").getValue();
		 var desc = Matrix.getMatrixComponentById("desc").getValue();
		 var type = Matrix.getMatrixComponentById("type").getValue();//类型[需特殊处理]
		 var entity = Matrix.getMatrixComponentById("entity").getValue();//关联对象属性
		 var initType = Matrix.getMatrixComponentById("initType").getValue();//初始方式
		 var initValue = Matrix.getMatrixComponentById("initValue").getValue();//变量默认值
	 	
	 	// var data ="{'id':'"+mid+"','name':'"+name+"','type':'"+type+"','entity':'"+entity+"','initType':'"+initType+"','initValue':'"+initValue+"','desc':'"+desc+"'}";
	 	 var data ={'id':mid,'name':name,'type':type,'entity':entity,'initType':initType,'initValue':initValue,'desc':desc};
	 	
	     return data;
	}

	
    //初始方式改变时触发该方法
	function initWayChanges(){
		var initWayValue = Matrix.getMatrixComponentById("initType").getValue();//初始组件值
   		var initValueLabel = document.getElementById("initValueLabel");//初始值 标签
   		var entity = Matrix.getMatrixComponentById("entity");//关联对象属性
   		  setDivValue(initValueLabel,"默认值:");
   		  entity.setRequired (false); 
   		
   		if(initWayValue=="autoLoad"){//关联对象属性
   		    entity.setRequired (true);
   		    //当为自动加载时，需判断是列表还是对象
   		     var dataType = Matrix.getMatrixComponentById("type").getValue();
   		     if(dataType=='List'){//列表
   		         setDivValue(initValueLabel,"查询条件：");
   		     }else if(dataType=='DataObject'){
   		    	 setDivValue(initValueLabel,"主键值：");
   		     }
   		 }
	}
	
	//选择类型时为列表或实体对象时，选择实体类型(业务对象)
    function typeChanged(){
    	var typeValue = Matrix.getMatrixComponentById("type").getValue();//类型值
        var entityShowDiv = document.getElementById("entityTypeDiv");//对象类型div
        var initComponent = Matrix.getMatrixComponentById("initType");//初始方式组件
        var initValueLabel = document.getElementById("initValueLabel");//输入值 标签
       	var initType = initComponent.getValue();//初始方式组件值
        var entity = Matrix.getMatrixComponentById("entity");
         entity.setRequired (false);
        if(typeValue=='List'||typeValue=='DataObject'){//如果为列表或者任意实体对象
           // initComponent.setDisabled(false);
             //initComponent.setCanEdit(true);
              MinitType_VM[2]= 'autoLoad';
            entity.setRequired (true);//对象类型为必填项
             if(initType == 'defaultValue'){//自定义类型设置
                   setDivValue(initValueLabel,"默认值:");
   		 	 }else if(initType=='autoLoad'&&typeValue=='List'){//如果在初始方式为自动加载时选择列表
        		   setDivValue(initValueLabel,"查询条件：");
        	 }else if(initType=='autoLoad'&&typeValue=='DataObject'){
        	   setDivValue(initValueLabel,"主键值：");
        	 }
        	entityShowDiv.style.display="table-row";
        }else{//基本数据类型
              setDivValue(initValueLabel,"默认值:");
             // initComponent.setValue('defaultValue');
        	//  initComponent.setDisabled(true);//将初始方式下拉框设置为不可用
        	  if(MinitType_VM.length==3){
		        	  MinitType_VM.pop();
        	  
        	  }
        	  //initComponent.setCanEdit(false);
      	      entityShowDiv.style.display="none";
        }
        //重新渲染下拉框选项
        MinitType.setValueMap(MinitType_VM);MinitType.setValue('');
        
    }
	
	
	 //当窗口执行关闭时执行此操作
	 function onDialog0Close(data,oType){
	  if(data!=null){
	   var data = isc.JSON.decode(data);
	   var inputText =  Matrix.getMatrixComponentById("entity");
	  	 inputText.setValue(data.proEntityType);//此属性和action中组织的json数据对应
	   }
		return true;
	}
</script>
</head>
<body onload="initEditForm()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"",
		fields:[{
			name:'Form0_hidden_text',
			width:0,
			height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content"
	style="border: 1px;height:100%;">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id6" name="j_id6"
			style="margin-left: 10px"> 编&nbsp;&nbsp;&nbsp;&nbsp;码：</label></td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input">
		<div id="mid_div" eventProxy="MForm0" class="matrixInline matrixInlineIE"
			></div>
			
	<script>
		 var mid=isc.TextItem.create({
			 ID:"Mmid",
			 name:"mid",
			 editorType:"TextItem",
			 displayId:"mid_div",
			 position:"relative",
			 width:400,
			 required:true,
			 validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		        return  formVarIdValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"编码不能为空!"
		      		 }]
		 });
		 MForm0.addField(mid);
		 </script>
		 <span id="MultiLabel0" style="width: 25px; height: 20px; color: #FF0000">*</span></td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id11" name="j_id11"
			style="margin-left: 10px"> 名&nbsp;&nbsp;&nbsp;&nbsp;称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" >
		<div id="name_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
	<script> 
		var name2=isc.TextItem.create({
				ID:"Mname",
				name:"name",
				editorType:"TextItem",
				displayId:"name_div",
				position:"relative",
				width:400,
				required:true,
				validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		        return  formVarNameValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"名称不能为空!"
		      		 }]
			});
			MForm0.addField(name2);
			
	</script>
	<span id="MultiLabel1" style="width: 25px; height: 20px; color: #FF0000">*</span></td>
	</tr>
	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label"><label id="j_id16" name="j_id16"
			style="margin-left: 10px"> 类&nbsp;&nbsp;&nbsp;&nbsp;型：</label></td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" style="width: 400px; padding-right: 0px">
		<div id="type_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
	<script> 
		var Mtype_VM=[];
	    var type=isc.SelectItem.create({
			    	ID:"Mtype",
			    	name:"type",
			    	editorType:"SelectItem",
			    	displayId:"type_div",
			    	valueMap:[],
			    	value:"String",
			    	position:"relative",
			    	width:400,
			    	changed:"typeChanged()"
	    	});
	    	MForm0.addField(type);
	    	Mtype_VM=['String','Integer','Long','Float','Double','Boolean','Date','BigDecimal','Timestamp','Byte','List','Object','DataObject'];
	    	Mtype.displayValueMap={'String':'字符型','Integer':'整型','Long':'长整型','Float':'单精度小数','Double':'双精度小数','Boolean':'布尔型','Date':'日期时间','BigDecimal':'数值','Timestamp':'时间戳','Byte':'二进制','List':'列表','Object':'任意对象','DataObject':'业务对象'};
	    	Mtype.setValueMap(Mtype_VM);Mtype.setValue('String');
	    	</script></td>
	</tr>
	<tr id="entityTypeDiv" jsId="entityTypeDiv" style="display: none">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id11" name="j_id11"
			style="margin-left: 10px"> 业务对象：</label></td>
		<td class="maintain_form_input">
		<div id="entity_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script>
			 var entity=isc.TextItem.create({
					 ID:"Mentity",
					 name:"entity",
					 editorType:"TextItem",
					 displayId:"entity_div",
					 position:"relative",
					 width:400,
					 canEdit:true
					 
			 });
			 MForm0.addField(entity);
			</script>
			<script>
			 isc.ImgButton.create({
			 	ID:"MImageButton1",
			 	name:"ImageButton1",
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
			 	MImageButton1.click=function(){
				 	Matrix.showMask();
				 	Matrix.showWindow('Dialog0');
				    Matrix.hideMask();
			   }
			  </script>
			
	
	
	</td>
	</tr>
	<tr id="j_id31" jsId="j_id31">
		<td id="j_id32" jsId="j_id32" class="maintain_form_label"  style="width: 20%"><label id="j_id33" name="j_id33"
			style="margin-left: 10px"> 初始方式：</label></td>
		<td id="j_id34" jsId="j_id34" class="maintain_form_input">
		<div id="initType_div" eventProxy="MForm0" class="matrixInline"
			style=""></div>
		<script> 
		var MinitType_VM=[]; 
				var initType=isc.SelectItem.create({
				ID:"MinitType",
				name:"initType",
				editorType:"SelectItem",
				displayId:"initType_div",
				valueMap:[],
				value:'defaultValue',
				position:"relative",
				width:400,
				changed:"initWayChanges()",
				//disabled:true
				canEdit:true
		});
		MForm0.addField(initType);
		MinitType_VM=['','defaultValue'];//原为 1 2 添加'无'选项
		MinitType.displayValueMap={'':'无','defaultValue':'默认值','autoLoad':'自动加载'};
		MinitType.setValueMap(MinitType_VM);MinitType.setValue('');
		</script></td>
		
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1"><label id="j_id11" name="j_id11"
			style="margin-left: 10px"><span id="initValueLabel" style="width: 60px">默认值:</span></label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input">
		<div id="initValue_div" eventProxy="MForm0" class="matrixInline"
					style=""></div>
				<script>
				 var initValue=isc.TextItem.create({
						 ID:"MinitValue",
						 name:"initValue",
						 editorType:"TextItem",
						 displayId:"initValue_div",
						 position:"relative",
						 width:400
				 });
				 MForm0.addField(initValue);
				 </script>
				 </td>
	</tr>
	<tr>
		<td class="maintain_form_label">
		<label style="margin-left: 10px"> 描&nbsp;&nbsp;&nbsp;&nbsp;述：</label></td>
		<td class="maintain_form_input" >
		<div id="desc_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
		var desc=isc.TextAreaItem.create({
				ID:"Mdesc",
				name:"desc",
				height:80,
				editorType:"TextAreaItem",
				displayId:"desc_div",
				position:"relative",
				width:400
		});
		MForm0.addField(desc);</script></td>
	</tr>
	<tr></tr>
	<tr id="j_id49" jsId="j_id49">
		<td class="maintain_form_command" colspan="2">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="width: 70px; position: relative; height: 22px;">
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
					if(!MForm0.validate()){//表单验证
						Matrix.hideMask(); 
						return false;
					}
					//添加时返回的data数据
					var data;
					var recordNum = parent.MDialog0.rowNum;
					if(recordNum!=null){//修改
					   data = convertEditData();
					}else{//添加
						data = convertAddData();
					}
				   parent.MDialog0.allData = null;
					Matrix.closeWindow(data,1);
					
					Matrix.hideMask();
		};</script></div>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="width: 70px; position: relative;; height: 22px">
			<script>
			isc.Button.create({
					ID:"MdataFormCancelButton",
					name:"dataFormCancelButton",
					title:"关闭",
					displayId:"dataFormCancelButton_div",
					position:"absolute",
					top:0,
					left:0,
					width:"100%",
					height:"100%",
					icon:Matrix.getActionIcon("exit"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormCancelButton.click=function(){
				Matrix.showMask();
			    parent.MDialog0.allData = null;
				Matrix.closeWindow();
			
			Matrix.hideMask();
		};
	</script></div>
		</td>
	</tr>
</table>
</div>

<input id="iframewindowid" type="hidden" name="iframewindowid" value="{param.iframewindowid}" />
</form>
<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script>
<script>

	function getParamsForDialog0(){
		var params='iframewindowid=Dialog0&';
		var value;
		return params;
	}
	
	isc.Window.create({
			ID:"MDialog0",
			autoCenter: true,
			position:"absolute",
			height: "100%",
			width: "400px",
			title: "选择实体对象",
			canDragReposition: false,
			showMinimizeButton:true,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			getParamsFun:getParamsForDialog0,
			headerControls:["headerIcon","headerLabel","minimizeButton","maximizeButton","closeButton"],
			initSrc:"<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=16",
		    src:"<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=16"
		 });
		 MDialog0.hide();
	</script>
</div>

</body>
</html>