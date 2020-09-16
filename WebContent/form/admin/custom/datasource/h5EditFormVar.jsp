<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">

	window.onload = function(){
		initEditForm();
	}

	function isEcho(){
		var formVarType = Matrix.getFormItemValue('formVarType');
		var addWay = $('#type').val();
		if(addWay=='1' && formVarType=='List'){
			//选择新增
			var entity = $('#entity').val();
			var allData = parent.MTree0_DS.$27m;
			if(entity!=null && entity!='' && allData!=null && allData.length>0){
				for(var i = 0;i<allData.length-1;i++){
					var data = allData[i];
					if(data.type=='DataObject' || data.type=='List'){
						if(entity==data.entity){
							return true;
						}
					}
				}
			}
		}
		return false;
	}
	
	//保存前验证
	function formValidata(){
		if(!formVarNameValidate()){
			return false;
		}else{
			var phase = Matrix.getFormItemValue("phase");//当前阶段
	    	if(phase!=4){
				if(!formVarIdValidate()){
					return false;
				}
	    	}
			return true;
		}
	}
	
	//验证编码输入
	function formVarIdValidate(){
		var oType = '${param.oType}';
		var value = $('#mid').val();
		var selectIsEcho = isEcho();
		if(selectIsEcho){
			Matrix.warn("该数据源已经存在该实体，请选择其他实体！");
			return false;
		}
		if(value==null||value.length==0){
			Matrix.warn("编码不能为空!");
			return false;
		}
		if(value.length<255||value.length>0){
		 	var allTreeData = parent.MTree0_DS.$27m;
		 	if(allTreeData!=null && allTreeData.length>0){
		 		for(var i = 0;i<allTreeData.length;i++){
		 			var treeData = allTreeData[i];
		 			if((treeData.type=='DataObject' || treeData.type=='List')&&value==treeData.entityId){
		 				Matrix.warn("编码重复!");
						return false;
		 			}
		 		}
		 	}
		 	var isMatch = value.match(/^[A-Z][\w]*$/);
		 	if(isMatch!=null){
				 return true;
		 	}
	   		//分类返回错误消息
		 	var exceptMsg = value.match(/^[a-zA-Z\d_]+$/);//
		 	if(exceptMsg==null){//含有非法字符
		 		Matrix.warn("只能使用字母数字下划线命名");
		   		return false;
		 	}
		  	//2.以下划线 数字开头[第一位]
		 	var validateMsg1 = value.match(/^[^A-Z][a-zA-Z\d_]+$/);
		 	if(validateMsg1!=null){
		 		Matrix.warn("首字母大写");
	   			return false;
		  	} 
		 	Matrix.warn("只能使用字母、数字和下划线命名，且以小写字母开头");
	   		return false;
	 	}else{
	 		Matrix.warn("编码不能为空!");
			return false;
	 	}
	}
	
	//验证名称输入
	function formVarNameValidate(){
		var oType = '${param.oType}';
		var value = $('#name').val();
		var selectIsEcho = isEcho();
		if(selectIsEcho){
			Matrix.warn("该数据源已经存在该实体，请选择其他实体");
			return false;
		}
		
		if(value==null||value.length==0){
		   Matrix.warn("名称不能为空!");
		   return false;
		}
		if(value.length<255||value.length>0){
		 	var allTreeData = parent.MTree0_DS.$27m;
		 	//value = "[列表对象]"+value;
		 	if(allTreeData!=null && allTreeData.length>0){
		 		for(var i = 0;i<allTreeData.length;i++){
		 			var treeData = allTreeData[i];
		 			var text = treeData.text;
		 			text = text.substr(text.indexOf("]")+1);
		 			if((treeData.type=='DataObject' || treeData.type=='List')&&value==text){
		 				Matrix.warn("系统已有该名称，不能重复!");
						return false;
					}
				}
		 	}
			var isMatch = value.match(/^[\w\u4e00-\u9fa5]+$/);
			if(isMatch!=null){//非空
				return true;
			}
			Matrix.warn("不能使用字母汉字下划线以外的非法字符!");
			return false;
	 	}else{
	 		Matrix.warn("名称不能为空!");
			return false;
	 	}
	}
	
	//初始方法
    function initEditForm(){
    	var oType = '${param.oType}';
    	var phase = Matrix.getFormItemValue("phase");//当前阶段
    	if(oType=='add'){//新增
    		if(phase=='4'){//定制阶段自动生成编码
    			document.getElementById("tr003").style.display="none";
    			var mid = '${param.Mid}';
    			if(mid!=null &&mid.length>0){
    				Matrix.setFormItemValue('mid',mid);
    			}
    			if(mid.indexOf("RAllListVar")!=-1){
    				Matrix.setFormItemValue("listType","RAllListVar");
    			}else if(mid.indexOf("AllListVar")!=-1 && mid.indexOf("RAllListVar")==-1){
    				Matrix.setFormItemValue("listType","AllListVar");
    			}
    		}else{//非定制阶段输入编码
    			document.getElementById("tr003").style.display="";
    		}
    	}
    }
	
  	//改变新增方式
	function changeAddWay(){
		var addWay = $('#type').val();
		if(addWay!=null && addWay=='1'){
			document.getElementById("tr002").style.display="";
			$('#mid').attr('readonly','readonly');
			//Mname.setCanEdit(false);
		}else{
			document.getElementById("tr002").style.display="none";
			$('#mid').attr('readonly','');
			//Mname.setCanEdit(true);
		}
	}
  	
  	//保存
  	function saveData(){
  		$('#button1').attr('disabled','disabled');
		if(!formValidata()){//表单验证
	  		$('#button1').attr('disabled',false);
			return false;
		}
		var formVarType = '${param.formVarType}';
		var oType = '${param.oType}';
		if(oType=='add'){
			convertAddData(formVarType);
		
		}else if(oType=='update'){
			convertEditData(formVarType);
		}
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
  		$('#button1').attr('disabled',false);
  	}
  	

  	
  //将提交的数据转换为json格式
	function convertAddData(type){
		var oType = "${param.oType}";
        //var parentId = '${param.parentId}';
    	var mid = Matrix.getFormItemValue('mid');
		var name=Matrix.getFormItemValue('name');
		var valiUrl = "<%=request.getContextPath()%>/datasource/formVar_validataNameRepeat.action";
		var validata = {};
		validata.name = name;
		Matrix.sendRequest(valiUrl,validata,function(data){
			if(data.data=="true"){
				var entity = Matrix.getFormItemValue("entity"); //实体路径
				var isRefer = $('#type').val();// 0：新增  1：引用  
				var listType = Matrix.getFormItemValue("listType");
				var referEntity = '';
				var referMid = '';
				if("1"==isRefer){//是引用实体
					if(mid.indexOf("RAllListVar")!=-1){
						//重复节
						mid = mid.replace("RAllListVar","REFRAllListVar");
					
		    		}else if(mid.indexOf("AllListVar")!=-1 && mid.indexOf("RAllListVar")==-1){
		    			//重复表
		    			mid = mid.replace("RAllListVar","REFAllListVar");
		    		
		    		}else if(mid.indexOf("EntityVar")!=-1){
		    			//主表
		    			mid = mid.replace("RAllListVar","REFEntityVar");
		    		}
		    		referEntity = Matrix.getFormItemValue('referEntity');
		    		referMid = Matrix.getFormItemValue('referMid');
				}
				
				if(entity==null ||entity.length==0||entity=='null'){
					entity="";
				}
				var listType = Matrix.getFormItemValue('listType');
				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
				var ftid = '${param.ftid}';
		        var str = "";
				str += "{\"mid\":\""+mid+"\",";
				str += "\"name\":\""+name+"\",";
				str += "\"type\":\""+type+"\",";
				str += "\"oType\":\""+oType+"\",";
				str += "\"ftid\":\""+ftid+"\",";
				str += "\"parentNodeId\":\""+parentNodeId+"\",";
				str += "\"entity\":\""+entity+"\",";
				str += "\"isRefer\":\""+isRefer+"\",";
				str += "\"listType\":\""+listType+"\"";
		        if(isRefer=="1"){
					str += ",\"referEntity\":\""+referEntity+"\",";
					str += "\"referMid\":\""+referMid+"\"}";
				}else{
					str += "}";
				}
				var synJson = {'data':"{'data':"+str+"}"}; 
		        /*var data = "{'data':'{data:{\"mid\":\""+mid+"\",\"name\":\""+name+"\",\"type\":\""+type+"\",\"oType\":\""+oType+"\",\"ftid\":\""+ftid+"\",\"parentNodeId\":\""+parentNodeId+"\",\"entity\":\""+entity+"\",\"isRefer\":\""+isRefer+"\",\"listType\":\""+listType+"\"";
		       	data+=",\"referEntity\":\""+referEntity+"\",\"referMid\":\""+referMid+"\"";
		        data+="}}'}";
		        var synJson = isc.JSON.decode(data); */
		        var url = "<%=path%>/datasource/formVar_saveOrUpdateFormVar.action";
		        Matrix.sendRequest(url,synJson,function(data){
		       		if(data!=null && data.data!=''){
		       			var json = isc.JSON.decode(data.data);
		       			if(json.result){
		       				//1、刷新父页面树节点
		       				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
		       				parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
		       				//2、关闭窗口
		       				//Matrix.closeWindow();
							var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
						    parent.layer.close(index);
		       			}
		       		}
		        });
			}else{
				Matrix.warn('系统已有该名称，不能重复！');
				return false;
			}
		});
	}
  
	//更新修改后的记录并返回
    function convertEditData(type){
       // var record = parent.MDialog0.record;
        var oType = "${param.oType}";
        var parentId = '${param.parentId}';
    	var mid = Matrix.getFormItemValue('mid');
		var name=Matrix.getFormItemValue('name');
		var parentNodeId = Matrix.getFormItemValue('parentNodeId');
		//var type = Matrix.getMatrixComponentById("type").getValue();//类型[需特殊处理]
		//var entity = Matrix.getMatrixComponentById("entity").getValue();//关联对象属性
		//var initType = Matrix.getMatrixComponentById("initType").getValue();//初始方式
		//var initValue = Matrix.getMatrixComponentById("initValue").getValue();//变量默认值
        //给记录更新值
		var record = {};
		record.id = mid;
		record.name = name;
		record.type = type;
      /*  var data = "{'data':'{\'mid\':\'"+mid+"\',\'name\':\'"+name+"\',\'type\':\'"+type+"\',\'oType\':\'"+oType+"\',\'parentId\':\'"+parentId+"\'}'}";
       var synJson = isc.JSON.decode(data); */
		var str = "";
		str += "{\"mid\":\""+mid+"\",";
		str += "\"name\":\""+name+"\",";
		str += "\"type\":\""+type+"\",";
		str += "\"oType\":\""+oType+"\",";
		str += "\"parentId\":\""+parentId+"\"}";
		var synJson = {'data':str}; 
		var url = "<%=request.getContextPath()%>/datasource/formVar_saveOrUpdateFormVar.action";
		Matrix.sendRequest(url,data,function(data){
			if(data!=null && data.data!=''){
       			var json = isc.JSON.decode(data.data);
       			if(json.result){
       				//1、刷新父页面树节点
       				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
       				Matrix.forceFreshTreeNode("Tree0", parentNodeId);
       				//2、关闭窗口
       				Matrix.closeWindow();
       			}
       		}
       });
    }
  	
</script>
</head>
<body style="padding: 10px">
	<input type="hidden" name="listType" id="listType"/>
	<input type="hidden" name="formVarType" id="formVarType" value="${param.formVarType }"/>
	<input type="hidden" name="parentNodeId" id="parentNodeId" value="${param.parentNodeId }"/>
	<input type="hidden" name="phase" id="phase" value="${phase }"/>
 	<input type="hidden" name="referMid" id="referMid" />
	<input type="hidden" name="referEntity" id="referEntity" />
	<table id="table001" style="width:100%;" name="table001" class="tableLayout">
		<tr style="display: none;" id="tr001" name="tr001">
		 	<td id="td005" style="width:30%;" name="td001" class="tdLabelCls">
				<label class="label" id="label001" name="label001">
					类型
				</label>
		 	</td>
			<td id="td002" style="width:70%;" name="td002" class="tdValueCls">
				<select class="form-control select2-accessible" id="type" onchange="changeAddWay()">
					<option value="0" selected='selected'>添加新表</option>
					<!-- <option value="1">关联现有表</option> -->
				</select>
			</td>
		</tr>
		<tr id="tr002" name="tr002" style="display:none ">
		  	<td id="td003" style="width:30%;" name="td003" class="tdLabelCls">
				<label class="label" id="label002" name="label002">
					业务对象
				</label>
		  	</td>
			<td id="td004" style="width:70%;" name="td004" class="tdValueCls">
				<div class="col-md-12 input-group " style="display: inline-table;  vertical-align: middle; width:100%">
					<input readonly="readonly" placeholder="单击选择业务对象" onclick="onselectItemsClick()" class="form-control" value="${property.length}" required="false" id="entity" style="width:100%" name="entity"/>
					<span class="input-group-addon addon-udSelect udSelect " onclick="onselectItemsClick()"><i class="fa fa-th-large"></i></span>
				</div>
		  	</td>
		</tr>
		<script>
			function onselectItemsClick() {
				var parentNodeId = Matrix.getFormItemValue("parentNodeId");
				parent.layer.open({
					type:2,
					title:['选择实体对象'],
					area:['500px','600px'],
					content:'<%=path%>/datasource/formVar_loadCommonTreePage.action?iframewindowid=M_SelectData&componentType=16&formVarType=DataObject&parentNodeId='+parentNodeId
				});						
			};
			//当窗口执行关闭时执行此操作
			function onM_SelectDataClose(data){
				if(data!=null){
					var data = isc.JSON.decode(data);
					var inputText =  Matrix.getMatrixComponentById("entity");
					$('#entity').val(data.entity);//此属性和action中组织的json数据对应
					//Mmid.setValue(data.sid);
					Matrix.setFormItemValue('referEntity',data.entity);
					Matrix.setFormItemValue('referMid',data.sid);
					$('#name').val(data.text);
				}
				return true;
			}
		</script>
		<tr id="tr003" name="tr003">
		  	<td id="td005" style="width:30%;" name="td005" class="tdLabelCls">
				<label class="label" id="label003" name="label003">
					编码
				</label>
		  	</td>
			<td id="td006" style="width:70%;" name="td006" class="tdValueCls">
				<input class="form-control" value="${param.mid}" required="false" id="mid" style="width:100%" name="mid"/>
		  	</td>
		</tr>
		<tr id="tr004" name=""td013"">
		  	<td id="td007" style="width:30%;" name="td007" class="tdLabelCls">
				<label class="label" id="label004" name="label004">
					名称
				</label>
		  	</td>
			<td id="td008" style="width:70%;" name=""td008"" class="tdValueCls">
				<input autocomplete="off" class="form-control" value="${property.optionsStr}" required="false" id="name" style="width:100%" name="name"/>
		  	</td>
		</tr>
		
		<tr id="tr011" name="tr011">
		  	<td  class="cmdLayout" id="td020" style="width:100%;" colspan="2" name="td020">
		  		<div id="button001_div" class="matrixInline">
					<input id="button1" type="button" class="x-btn ok-btn " value="保存" onclick="saveData()">
					<input id="button2" type="button" class="x-btn cancel-btn " value="关闭" onclick="Matrix.closeWindow()">
				</div>
		  	</td>
		</tr>
	</table>
</body>
</html>