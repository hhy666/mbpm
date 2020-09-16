<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>添加流水号定义</title>

<script type="text/javascript">
	window.onload = function(){
		var selectSerid = document.getElementById('serId'); 
		var serId = "${var.id}";
		if(serId!=null&&serId!=""){
			selectSerid.readOnly = true;
		}
		
		//类型初始化
		var selectType = document.getElementById('type');
		var type = "${var.type}";
		if(type=="0"){
			selectType.options[0].selected = true;
		}else if(type=="1"){
			selectType.options[1].selected = true;
		}else if(type=="2"){
			selectType.options[2].selected = true;
		}else if(type=="3"){
			selectType.options[3].selected = true;
		}else{
			selectType.options[0].selected = true;
		}
		
		//周期规则初始化
		var selectRule = document.getElementById('rule');
		var rule = "${var.rule}";
		if(rule=="N"){
			selectRule.options[0].selected = true;
		}else if(rule=="Y"){
			selectRule.options[1].selected = true;
		}else if(rule=="SY"){
			selectRule.options[2].selected = true;
		}else if(rule=="YM"){
			selectRule.options[3].selected = true;
		}else if(rule=="YMD"){
			selectRule.options[4].selected = true;
		}else{
			selectRule.options[0].selected = true;
		}
		
		//固定长度初始化
		var selectIsStaticLength = document.getElementById('isStaticLength');
		var isStaticLength = "${var.isStaticLength}";
		if(isStaticLength=='true'){
			selectIsStaticLength.options[0].selected = true;
		}else if(isStaticLength=='false'){
			selectIsStaticLength.options[1].selected = true;
		}else{
			selectIsStaticLength.options[0].selected = true;
		}

		//状态初始化
		var selectState = document.getElementById('state');
		var state = "${var.state}";
		if(state=='1'){
			selectState.options[0].selected = true;
		}else if(state=='0'){
			selectState.options[1].selected = true;
		}else{
			selectState.options[0].selected = true;
		}
		
		//起始类型初始化
		var selectResetRule = document.getElementById('resetRule');
		var resetRule = "${var.resetRule}";
		if(resetRule==0){
			selectResetRule.options[0].selected = true;
		}else if(resetRule==1){
			selectResetRule.options[1].selected = true;
		}else{
			selectResetRule.options[0].selected = true;
		}
		
		
	}
		
	
	
	
	//保存
	function save(){
		
		var opType = document.getElementById('opType').value;
		$('#type').attr('disabled',false);
		if(opType=='add'){
			var url = '<%=path%>/number/serialNumber_addSerialNum.action';
			document.getElementById('form0').action = url;
		}else if(opType=='update'){
			var url = '<%=path%>/number/serialNumber_updateSerialNum.action';
			document.getElementById('form0').action = url;
		}
		Matrix.send('form0',null,function(data){
			if(data.data=="true"){
				Matrix.closeWindow(data);
			}else if(data.data=="false"){
				Matrix.warn('编码重复！');
				return false;
			}
		});
	}
	
	//校验非空
	function validateEmpty(){
		var result = true;
		result = Matrix.validateForm("form0");
		if(result){
		/* 	if(validateId()&&validateName()&&validatePrefix()&&validatePostfix()&&validateRule()&&validateSep()&&validatorLength()){
				save();
			}else{
				return false;
			} */
				save();
		}else{
			return false;
		}
	}
	
	/* //id校验
	function validateId(){
		var id = document.getElementById('serId').value;
		if(id==null || id.length==0){
			Matrix.warn('编码不能为空!');
			return false;
		}
		var idRegex =/^[A-Za-z][\w]*$/;
		return validateCommon(id,idRegex);
	}
	
	//name校验
	function validateName(){
		var name = document.getElementById('name2').value;
		if(name==null || name.length==0){
			Matrix.warn('名称不能为空!');
			return false;
		}
		var nameRegex =/^[\w\u4e00-\u9fa5]+$/;
		return validateCommon(name,nameRegex);
	}
	
	//前缀校验
	function validatePrefix(){
		var prefix = document.getElementById('prefix').value;
		if(prefix==null || prefix.length==0){
			return true;
		}
		var prefixRegex =/^[\$\{\}\[\]\(\)\.<>\-\w\u4e00-\u9fa5\s]+$/;
		return validateCommon(prefix,prefixRegex);
	}
	
	//后缀校验
	function validatePostfix(){
		var postfix = document.getElementById('postfix').value;
		if(postfix==null || postfix.length==0){
			return true;
		}
		var postfixRegex =/^[\$\{\}\[\]\(\)\.<>\-\w\u4e00-\u9fa5\s]+$/;
		return validateCommon(postfix,postfixRegex);
	}

	//规则校验
	function validateRule(){
		var rule = document.getElementById('rule').value;
		var ruleRegex =/^[A-Z]+$/;
		return validateCommon(rule,ruleRegex);
	}
	
	//间隔符校验
	function validateSep(){
		var seperator = document.getElementById('seperator').value;
		if(seperator==null || seperator.length==0){
			return true;
		}
		var seperatorRegex =/^[\-\w_\.,;\:\s\u4e00-\u9fa5]+$/;
		return validateCommon(seperator,seperatorRegex);
	}
	
	
	//位数校验
	function validatorLength(){
		var length = document.getElementById('length').value;
		if(length==null || length.length==0){
			Matrix.warn('位数不能为空!');
			return false;
		}
		var lengthRegex =/^[1-9][0-9]*$/;
		return validateCommon(length,lengthRegex);
	}
	
	
	
	//通用正则校验
	function validateCommon(value,regex){
		if(value.match(regex)!=null){
			return true;
		}else{
			Matrix.warn('请按照标准的数据格式填写！');
			return false;
		}
	} */
</script>
</head>
<body>
   	<form id="form0" name="form0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;padding:10px" enctype="application/x-www-form-urlencoded">
   		<input id="opType" type="hidden" name="opType" value="${opType }" />
   		<input id="uuid" type="hidden" name="uuid" value="${uuid }" />
   		<input id="iframewindowid" type="hidden" name="iframewindowid" value="${iframewindowid}" />
   		<input type='hidden' id='validateType' name='validateType' value='jquery'/>
   		<table class="maintain_form_content" style="width:100%;height: 90%;">
        	<tr>	
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="serId_label" name="serId_label">
						编码
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="serId_div" class="matrixInline" style="width: 100%">
						<input pattern ="^[A-Za-z][\w]*$" data-errormessage="编码必须以英文开头,必须以数字或字母或下划线结尾" autocomplete="off" required class="form-control" type="text" name="serId" id="serId" style="WIDTH:90%;HEIGHT:30px;" value="${var.id}" >
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="name_label" name="name_label">
						名称
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="name_div" class="matrixInline" style="width: 100%">
						<input pattern ="^[\w\u4e00-\u9fa5]+$" data-errormessage="名称必须由中英文、数字或下划线组成" autocomplete="off"  required class="form-control" type="text" name="name2" id="name2" style="WIDTH:90%;HEIGHT:30px;" value="${var.name}" >
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="type_label" name="type_label">
						类型
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="type_div" class="matrixInline" style="width: 30%">
						<select readonly="readonly" class="form-control select2-accessible" disabled="disabled" id="type" name="type">
							<option value="0">协同</option>
							<option value="1">发文</option>
							<option value="2">收文</option>
							<option value="3">签报</option>
						</select>
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="prefix_label" name="prefix_label">
						前缀
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="prefix_div" class="matrixInline" style="width: 100%">
						<input data-errormessage="请输入有效字符" autocomplete="off" class="form-control" type="text" name="prefix" id="prefix" style="WIDTH:90%;HEIGHT:30px;" value="${var.prefix}">
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="postfix_label" name="postfix_label">
						后缀
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="postfix_div" class="matrixInline" style="width: 100%">
						<input data-errormessage="请输入有效字符" autocomplete="off"  class="form-control" type="text" name="postfix" id="postfix" style="WIDTH:90%;HEIGHT:30px;" value="${var.postfix}">
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="rule_label" name="rule_label">
						周期规则
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="rule_div" class="matrixInline" style="width: 30%">
						<select class="form-control select2-accessible" id="rule" name="rule">
							<option value="N">无</option>
							<option value="Y">年</option>
							<option value="SY">俩位年</option>
							<option value="YM">年月</option>
							<option value="YMD">年月日</option>
						</select>
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="seperator_label" name="seperator_label">
						间隔符号
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="seperator_div" class="matrixInline" style="width: 100%">
						<input data-errormessage="请输入有效字符" autocomplete="off"  class="form-control" type="text" name="seperator" id="seperator" style="WIDTH:90%;HEIGHT:30px;" value="${var.seperator}">
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="resetRule_label" name="resetRule_label">
						重置规则
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="resetRule_div" class="matrixInline" style="width: 30%">
						<select class="form-control select2-accessible" id="resetRule" name="resetRule">
							<option value="0">按周期</option>
							<option value="1">不重置</option>
						</select>
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="startNum_label" name="startNum_label">
						起始值
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="startNum_div" class="matrixInline" style="width: 100%">
						<input pattern ="^[0-9]*$" data-errormessage="起始值必须由数字组成" autocomplete="off" class="form-control" type="text" name="startNum" id="startNum" style="WIDTH:90%;HEIGHT:30px;" value="${var.startNum}">
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="step_label" name="step_label">
						步长
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="step_div" class="matrixInline" style="width: 100%">
						<input pattern ="^[1-9][0-9]*$" data-errormessage="步长必须由数字组成" autocomplete="off" class="form-control" type="text" name="step" id="step" style="WIDTH:90%;HEIGHT:30px;" value="${var.step}">
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="length_label" name="length_label">
						位数
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="length_div" class="matrixInline" style="width: 100%">
						<input pattern ="^[1-9][0-9]*$" data-errormessage="位数必须由数字组成" autocomplete="off"  required class="form-control" type="text" name="length" id="length" style="WIDTH:90%;HEIGHT:30px;" value="${var.length}">
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="isStaticLength_label" name="isStaticLength_label">
						固定长度
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="isStaticLength_div" class="matrixInline" style="width: 30%">
						<select class="form-control select2-accessible" id="isStaticLength" name="isStaticLength">
							<option value="true">是</option>
							<option value="false">否</option>
						</select>
					</div>
				</td>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;">
        			<label id="state_label" name="state_label">
						状态
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;">
					<div id="state_div" class="matrixInline" style="width: 30%">
						<select class="form-control select2-accessible" id="state" name="state">
							<option value="1">启用</option>
							<option value="0">禁用</option>
						</select>
					</div>
				</td>
        	</tr>
        	<tr>
        		<td class="maintain_form_label2" style="width: 30%;height: 72px">
        			<label id="desc_label" name="desc_label">
						描述
					</label>
        		</td>
        		<td class="tdLayout" style="width: 70%;height: 72px">
					<div id="desc_div" class="matrixInline" style="width: 100%;height: 100%">
						<textarea rows="1" cols="1" id="desc" name="desc" style="height:100%;width:90%;resize:none;outline: none;border: 1px solid #cccccc" >${var.desc}</textarea>
					</div>
				</td>
        	</tr>
        </table>
        <table class="maintain_form_content">
        	<tr>
        		<td class="cmdLayout" colspan="2">
					<div id="button003_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存"  onclick="validateEmpty()">
					</div>
					<div id="button004_div" class="matrixInline">
						<input type="button" class="x-btn cancel-btn " value="取消"  onclick="Matrix.closeWindow()">
					</div>
				</td>
        	</tr>
        </table>
	</form>
</body>
</html>