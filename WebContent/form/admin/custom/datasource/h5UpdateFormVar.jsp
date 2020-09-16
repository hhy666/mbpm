<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">

	function isEcho(){
		//选择新增
		var entity = Matrix.getFormItemValue("entity");//实体路径
		var allData = parent.MTree0_DS.$27m;
		if(entity!=null && entity!='' && allData!=null && allData.length>0){
			for(var i = 0;i<allData.length-1;i++){
				var data = allData[i];
				var parentNodeId = Matrix.getFormItemValue('parentNodeId');
				var curName = $('#name').val();
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
		 				Matrix.warn("名称重复!");
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
		//校验非空
		if(formVarNameValidate()){
			// var record = parent.MDialog0.record;
			var oType = Matrix.getFormItemValue('oType');
			var mid = Matrix.getFormItemValue('mid');
			var name=Matrix.getFormItemValue('name');
			var valiUrl = "<%=request.getContextPath()%>/datasource/formVar_validataNameRepeat.action";
			var validata = {};
			validata.name = name;
			Matrix.sendRequest(valiUrl,validata,function(data){
				if(data.data=="true"){
					var parentNodeId = Matrix.getFormItemValue('parentNodeId');
					//给记录更新值
					var record = {};
					record.id = mid;
					record.name = name;
					var formvar = Matrix.getFormItemValue('formvar');
					var entity = Matrix.getFormItemValue('entity');
					/* var data = "{'data':'{data:{\"mid\":\""+mid+"\",\"name\":\""+name+"\",\"oType\":\""+oType+"\",\"entity\":\""+entity+"\",\"formvar\":\""+formvar+"\"}}'}";
					var synJson = isc.JSON.decode(data); */
					var str = "";
					str += "{\"mid\":\""+mid+"\",";
					str += "\"name\":\""+name+"\",";
					str += "\"oType\":\""+oType+"\",";
					str += "\"entity\":\""+entity+"\",";
					str += "\"formvar\":\""+formvar+"\"}";
					var synJson = {'data':"{'data':"+str+"}"}; 
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
				}else{
					Matrix.warn('名称不能重复！');
					return false;
				}
			});
		}
	}

</script>
</head>
<body style="padding: 10px">
	<input type="hidden" name="mid" id="mid" value="${mid }"/>
	<input type="hidden" name="oType" id="oType" value="${oType }"/>
	<input type="hidden" name="entity" id="entity" value="${entity }"/>
	<input type="hidden" name="formvar" id="formvar" value="${formvar }"/>
	<input type="hidden" name="formVarType" id="formVarType" value="${formVarType }"/>
	<input type="hidden" name="parentNodeId" id="parentNodeId" value="${parentNodeId }"/>
	<input type="hidden" name="phase" id="phase" value="${phase }"/>
	<input type="hidden" name="listType" id="listType"/>
	<table id="table001" style="width:100%;" name="table001" class="tableLayout">
		<tr id="tr004" name="tr004">
		  	<td id="td007" style="width:30%;" name="td007" class="tdLabelCls">
				<label class="label" id="label004" name="label004">
					名称
				</label>
		  	</td>
			<td id="td008" style="width:70%;" name=""td008"" class="tdValueCls">
				<input autocomplete="off" class="form-control" value="${name}" required="false" id="name" style="width:100%" name="name"/>
		  	</td>
		</tr>
		
		<tr id="tr011" name="tr011">
		  	<td id="td020" style="width:100%;" colspan="2" name="td020" class="cmdLayout">
		  		<div id="button001_div" class="matrixInline" >
					<input id="button1" type="button" class="x-btn ok-btn" value="保存" onclick="convertEditData()">
					<input id="button2" type="button" class="x-btn cancel-btn" value="关闭" onclick="Matrix.closeWindow()">
				</div>
		  	</td>
		</tr>
	</table>
</body>
</html>