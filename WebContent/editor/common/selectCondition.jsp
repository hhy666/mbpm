<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8"/>
<title>选择条件</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style>
.content-td{
	 width:75%;
}
.label-td{
	 width:25%;
	 text-align:center;
	 background-color:#efefef;
}
.form-control-feedback{
  pointer-events: auto;
  cursor: pointer;
}
.form-control-feedback:hover{
		color:black;
}
</style>
<script type="text/javascript">
 var depConditionValueMap={'curDepId':'当前人部门编码','startDepId':'发起人部门编码','lastActDepId':'上一环节执行人部门编码'};
 var roleConditionValueMap={'curRoleId':'当前人角色编码','startRoleId':'发起人角色编码','lastActRoleId':'上一环节执行人角色编码'};
 var userConditionValueMap={'curUserId':'当前人编码','startUserId':'发起人编码','lastActUserId':'上一环节执行人编码'};
 $(document).ready(function(){
 		///初始
 		var condition = $("#condition").val();
 		
 		if(parent.getDepVariable){
 			var depVariable = eval("("+parent.getDepVariable()+")");
 			var old = document.getElementById("depKey");
 	 		var niw ="";
 	 		for(var i=0;i<depVariable.length;i++){
 	 			var niw = new Option(depVariable[i], depVariable[i]);   
 	 			old.options.add(niw);
 	 		}
 		}
 		
	 	if(condition!=null){
	 	
	 		if(condition=='depCondition'){
	 			//部门条件
	 			$("#depCondition")[0].style.display="";
	 		}else if(condition == 'roleCondition'){
	 			//角色条件
	 			$("#roleCondition")[0].style.display="";
	 			$("#cont")[0].style.display="none";
	 		}else if(condition == 'userCondition'){
	 			//用户条件
	 			$("#userCondition")[0].style.display="";
	 		}else{
	 			$("#depCondition")[0].style.display="";
	 		}
	 	}else{
	 		$("#depCondition")[0].style.display="";
	 	}
	 	//弹出选择  部门、角色或者用户
 	 	$("#query").on("click",function(){
 	 	   var condition = $("#condition").val();
 	 	   if(condition == 'depCondition'){
           				layer.open({
						    id:'layer01',
							type : 2,
							
							title : ['请选择'],
							//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '96%', '96%' ],
							content : "<%=request.getContextPath()%>/office/html5/select/MultiSelectDep.jsp?iframewindowid=layer01"
						});
		   }else if(condition == 'roleCondition'){
		   				layer.open({
						    id:'layer02',
							type : 2,
							
							title : ['请选择'],
							//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '96%', '96%' ],
							content : "<%=request.getContextPath()%>/office/html5/select/MultiSelectRole.jsp?iframewindowid=layer02"
						});
		   
		   }else if(condition == 'userCondition'){
		   				layer.open({
						    id:'layer03',
							type : 2,
							
							title : ['请选择'],
							//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '95%', '95%' ],
							content : "<%=request.getContextPath()%>/office/html5/select/MultiSelectPerson.jsp?iframewindowid=layer03"
						});
		   }
        });
        $(".cancel-btn").on("click",function(){
        	Matrix.closeLayerWindow();
        });
        $(".ok-btn").on("click",function(){
        	var operation = $("#operation").val();//操作符
        	var contain = $("#contain").val();   //子部门
        	//key
        	var condition = $("#condition").val();
        	var key = null;
        	var id = null;
        	var prefixName = "";
        	var prefixId = "";
        	if(condition == 'depCondition'){
        		id = $("#depKey").val();//获得编码
        		if(id=="curDepId" || id=="startDepId" || id=="lastActDepId"){
        			key = depConditionValueMap[id];//获得编码对应的名称
        		}else{
        			key = id;
        		}
        		prefixName = "部门";
        		prefixId = "dep";
        	}else if(condition == 'roleCondition'){
        		id = $("#roleKey").val();
        		key = roleConditionValueMap[id];
        		prefixName = "角色";
        		prefixId = "role";
        	}
        	var opera = getOperationKey(operation);//操作符
        	var conta = getContainKey(contain);   //子部门
        	
        	prefixName += getOperationName(operation);
        	prefixName = getContainName(contain) + prefixName;
        	prefixId += opera;
        	
        	var conditionValue = $("#conditionValue").val();
        	var conditionValueId = $("#conditionValueId").val();
//        	if(conditionValue==null || conditionValue==""){
//       		layer.msg("请选择值!");
//       	}else{
        		var nameStr = "{"+prefixName+"('"+key+"','"+conditionValue+"')"+"}";
        		//"【"+key+"】 【"+getOperationName(operation)+"】 【"+conditionValue+"】";
        		var idStr = prefixId + "('"+id+"','"+conditionValueId+"')";
        		//"\#{"+id+getOperationKey(operation)+"'"+conditionValueId+"'}";
        		var data = {};
        		data.name=nameStr;
        		data.id = idStr;
        		if(parent.MultiDepClose){
        			parent.MultiDepClose(data);
        		}else{
        			Matrix.closeLayerWindow(data);
        		}
        		
        		//Matrix.closeLayerWindow();
        		//var index=parent.layer.getFrameIndex(window.name);
        		//parent.layer.close(index);
//        	}
        });
 });
 function getOperationKey(value){
 	if(value=='1'){
 		return "Include";
 	}else if(value=='2'){
 		return "Uninclude";
 	}
 }
 function getOperationName(value){
 	if(value=='1'){
 		return "包含";
 	}else if(value=='2'){
 		return "不包含";
 	}
 }
 
 function getContainKey(value){
	 if(value=='1'){
		 return  "Contain";
	 }else if(value='2'){
		 return "Uncontain";
	 }
 }
 function getContainName(value){
	 if(value=="1"){
		 return "";
	 }else if(value=='2'){
		 return "当前";
	 }
 }
 
 //选择部门回调
 function onlayer01Close(data){
 	if(data!=null){
 		$("#conditionValue").attr("value",data.names);
 		$("#conditionValueId").attr("value",data.ids);
 	}
 }
 //选择角色回调
 function onlayer02Close(data){
 	if(data!=null){
 		$("#conditionValue").attr("value",data.names);
 		$("#conditionValueId").attr("value",data.ids);
 	}
 }
 //选择用户回调
 function onlayer03Close(data){
 	if(data!=null){
 		$("#conditionValue").attr("value",data.names);
 		$("#conditionValueId").attr("value",data.ids);
 	}
 }
</script>
</head>
<body style="overflow:hidden;">
	<form action="" style="overflow:hidden;height:100%;">
	<input type="hidden" name="condition" id="condition" value="${param.condition }"/>
	<input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid }"/>
	
	<div style="position: absolute;height: 100%;width: 100%;">
		<div style="height:calc(100% - 54px);overflow: auto;">
			<table class="table table-bordered">
				<tr>
					<td class="label-td">
						<label style="padding-top: 9px;">编 码：</label>
					</td>
					<td class="content-td">
						<div id="depCondition" style="width: 80%;display:none;">
						 	<select class="select2 form-control" tabindex="-1" id="depKey">
		                       <option value="startDepId">发起人部门编码</option>
		                       <option value="curDepId">当前人部门编码</option>
		                       <option value="lastActDepId">上一环节执行人部门编码</option>
		                    </select>
		                 </div>
		                 <div id="roleCondition" style="width: 80%;display:none;" >
						 	<select class="select2 form-control" tabindex="-1" id="roleKey">
		                       <option value="startRoleId">发起人角色编码</option>
		                       <option value="curRoleId">当前人角色编码</option>
		                       <option value="lastActRoleId">上一环节执行人角色编码</option>
		                    </select>
		                 </div>
		                 <div id="userCondition" style="width: 80%;display:none;" >
						 	<select class="select2 form-control" tabindex="-1" id="userKey">
		                       <option value="curUserId">当前人用户编码</option>
		                       <option value="startUserId">发起人用户编码</option>
		                       <option value="lastActUserId">上一环节执行人用户编码</option>
		                    </select>
		                 </div>
					</td>
				</tr>
				<tr>
					<td class="label-td">
						<label style="padding-top: 9px;">操作符：</label>
					</td>
					<td class="content-td">
						<div style="width: 80%;">
						 	<select class="form-control" tabindex="-1" id="operation">
		                       <option value="1">包含</option>
		                       <option value="2">不包含</option>
		                    </select>
		                 </div>
					</td>
				</tr>
				<tr id="cont" style="display:none;">
					<td class="label-td">
						<label style="padding-top: 9px;">包含子部门：</label>
					</td>
					<td class="content-td">
						<div style="width: 80%;">
						 	<select class="form-control" tabindex="-1" id="contain">                   
		                       <option value="1">是</option>
		                       <option value="2">否</option>
		                    </select>
		                 </div>
					
					</td>
				</tr>
				<tr>
					<td class="label-td">
						<label style="padding-top: 9px;">值：</label>
					</td>
					<td class="content-td">
						<div class="input-group" style="margin-bottom: 0px;width: 80%;">
							<input type="search" class="form-control has-feedback-right" id="conditionValue" readonly="readonly"/>
							<span class="input-group-addon addon-udSelect udSelect" id="query"><i class="fa fa-search"></i></span>
						</div>
						<input type="hidden" id="conditionValueId" name="conditionValueId" />
					</td>
				</tr>
			</table>
		</div>
		<div class="cmdLayout">
			<input type="button"class="x-btn ok-btn" name="确定" value="确定" id="submit" >
					<input type="button"class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
		</div>
	 </div>
	</form>
</body>
</html>