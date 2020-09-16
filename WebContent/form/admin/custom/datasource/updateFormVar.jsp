<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改表单变量</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<SCRIPT>var webContextPath="<%=request.getContextPath()%>";</SCRIPT>
<script type="text/javascript">
  	function isEcho(){
			//选择新增
			var entity = Matrix.getFormItemValue("entity");//实体路径
			var allData = parent.MTree0_DS.$27m;
			if(entity!=null && entity!='' && allData!=null && allData.length>0){
				for(var i = 0;i<allData.length-1;i++){
					var data = allData[i];
					var parentNodeId = Matrix.getFormItemValue('parentNodeId');
					var curName = Mname.getValue();
					if(parentNodeId==data.parentNodeId){
						if(data.name==curName){
							return true;
						}
					}
				}
			}
		
		return false;
  	}
	//验证名称输入
	function formVarNameValidate(item, validator, value, record){
		var oType = '${param.oType}';
		
		var selectIsEcho = isEcho();
		if(selectIsEcho){
			//validator.errorMessage="该数据源已经存在该实体，请选择其他实体";
			validator.errorMessage="该数据源已经存在该实体名称，请修改为其他名称";
			return false;
		}
		
		if(value==null||value.length==0){
		   validator.errorMessage="名称不能为空!";
		   return false;
		}
		var hasInput = Matrix.validateLength(1,255, value);
		if(hasInput){
		 	var allTreeData = parent.MTree0_DS.$27m;
		 	//value = "[列表对象]"+value;
		 	if(allTreeData!=null && allTreeData.length>0){
		 		for(var i = 0;i<allTreeData.length;i++){
		 			var treeData = allTreeData[i];
		 			var text = treeData.text;
		 			text = text.substr(text.indexOf("]")+1);
		 			if((treeData.type=='DataObject' || treeData.type=='List')&&value==text){
		 				 validator.errorMessage="名称重复!";
		 				 return false;
		 			}
		 		}
		 	}
		 	 var isMatch = value.match(/^[\w\u4e00-\u9fa5]+$/);
		 	 if(isMatch!=null){//非空
				 return true;
		 	 }
			 validator.errorMessage="不能使用字母汉字下划线以外的非法字符!";
	   		 return false;
	 	}
		return hasInput;
	}


	 //初始方法
    function initEditForm(){
    	var oType = '${param.oType}';
    	var mid = '${param.mid}';
    	var entity = '${param.entity}';
    	var formvar= '${param.formvar}';
    	var parentNodeId = '${param.parentNodeId}';
    	Matrix.setFormItemValue('oType',oType);
    	Matrix.setFormItemValue('mid',mid);
    	Matrix.setFormItemValue('entity',entity);
    	Matrix.setFormItemValue('formvar',formvar);
    	Matrix.setFormItemValue('parentNodeId',parentNodeId);
    }
    
    //更新修改后的记录并返回
    function convertEditData(){
       // var record = parent.MDialog0.record;
        var oType = Matrix.getFormItemValue('oType');
    	var mid = Matrix.getFormItemValue('mid');
		var name=Matrix.getFormItemValue('name');
		var parentNodeId = Matrix.getFormItemValue('parentNodeId');
        //给记录更新值
       var record = {};
       record.id = mid;
       record.name = name;
       var formvar = Matrix.getFormItemValue('formvar');
       var entity = Matrix.getFormItemValue('entity');
       var data = "{'data':'{data:{\"mid\":\""+mid+"\",\"name\":\""+name+"\",\"oType\":\""+oType+"\",\"entity\":\""+entity+"\",\"formvar\":\""+formvar+"\"}}'}";
       var synJson = isc.JSON.decode(data);
       var url = "<%=request.getContextPath()%>/datasource/formVar_saveOrUpdateFormVar.action";
       Matrix.sendRequest(url,synJson,function(data){
       		if(data!=null && data.data!=''){
       			var json = isc.JSON.decode(data.data);
       			if(json.result){
       				//1、刷新父页面树节点
       				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
       				parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
       				//2、关闭窗口
       				Matrix.closeWindow();
       				
       			}
       		}
       });
    
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
	<!-- lpz add start-->
	<input type="hidden" name="mid" id="mid" value="${param.mid }"/>
	<input type="hidden" name="oType" id="oType" value="${param.oType }"/>
	<input type="hidden" name="entity" id="entity" value="${param.entity }"/>
	<input type="hidden" name="formvar" id="formvar" value="${param.formvar }"/>
	<input type="hidden" name="formVarType" id="formVarType" value="${param.formVarType }"/>
	<input type="hidden" name="parentNodeId" id="parentNodeId" value="${param.parentNodeId }"/>
	<input type="hidden" name="phase" id="phase" value="${phase }"/>
	<input type="hidden" name="listType" id="listType"/>
	<!-- lpz add end-->
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content"
	style="border: 1px;height:100%;">
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
				width:300,
				value:'${name}',
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
	
	
	<!-- <tr id="j_id14" jsId="j_id14">
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
	<tr></tr> -->
	<tr id="j_id49" jsId="j_id49">
		<td class="cmdLayout" colspan="2">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="width: 80px; position: relative; height: 22px;">
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
			//icon:Matrix.getActionIcon("save"),
			showDisabledIcon:false,
			showDownIcon:false,
			showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					MdataFormSubmitButton.disable();
					if(!MForm0.validate()){//表单验证
						Matrix.hideMask(); 
						MdataFormSubmitButton.enable();
						return false;
					}
					convertEditData();
					//添加时返回的data数据
					//var data;
					//var recordNum = parent.MDialog0.rowNum;
					//if(recordNum!=null){//修改
					//   data = convertEditData();
					//}else{//添加
					//	data = convertAddData();
					//}
				  // parent.MDialog0.allData = null;
					//Matrix.closeWindow(data,1);
					
					Matrix.hideMask();
		};</script></div>
		<div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE"
			style="width: 80px; position: relative;; height: 22px;">
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
					//icon:Matrix.getActionIcon("exit"),
					showDisabledIcon:false,
					showDownIcon:false,
					showRollOverIcon:false
			});
			MdataFormCancelButton.click=function(){
				Matrix.showMask();
			    //parent.MDialog0.allData = null;
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
		var parentNodeId = Matrix.getFormItemValue("parentNodeId");
		params+="&parentNodeId="+parentNodeId;
		var value;
		return params;
	}
	
	isc.Window.create({
			ID:"MDialog0",
			autoCenter: true,
			position:"absolute",
			height: "400px",
			width: "300px",
			title: "选择实体对象",
			canDragReposition: true,
			showMinimizeButton:true,
			showMaximizeButton:true,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			getParamsFun:getParamsForDialog0,
			headerControls:["headerIcon","headerLabel","closeButton"],
			initSrc:"<%=request.getContextPath()%>/datasource/formVar_loadCommonTreePage.action?componentType=16&formVarType=DataObject",//type:DataObject 存储实体 只加载存储实体
		    src:"<%=request.getContextPath()%>/datasource/formVar_loadCommonTreePage.action?componentType=16&formVarType=DataObject"
		 });
		 MDialog0.hide();
	</script>
</div>

</body>
</html>