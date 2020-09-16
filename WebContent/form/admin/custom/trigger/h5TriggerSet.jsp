<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.admin.custom.trigger.model.FormTrigger"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>触发事件详细信息页面</title>
<link href='<%=request.getContextPath() %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
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
#container{
    position: absolute;
    height: 100%;
    width: 100%;
    overflow: hidden;
}
</style>
<script type="text/javascript">
	//页面初始事件    根据不同的动作类型加载不同界面
	$(function(){ 
		debugger;
		if(parent.parent.parent.parent.parent.document.getElementById('templateType')){
			var templateType = parent.parent.parent.parent.parent.document.getElementById('templateType').value;   //1公文  2协同  3 基础数据 
			if(templateType == 3){
				$("#startPoint_div").css('display','none');
				$("#endPoint_div").css('display','none');
				
				$('#comboBox001 option[value="0"]').hide();
			}
		}
		
//		var dataCopyStr = document.getElementById('dataCopyStr').value;
//		alert(dataCopyStr);
		var type = '${formTrigger.eventType}';    //当前触发事件动作类型
		if(type == "" || type == '0'){  //触发流程
			type1();
		}
		if(type == '1'){ //发送消息
			type2();
		}
		if(type == '2'){  //数据复制
			type3();
		}
		
		//监听触发事件类型下拉框改变事件
		$("#comboBox001").change(function(){ 
			debugger;
			var value = $(this).val();           
      	   	if(value == "0"){
				type1();
			}
			if(value == "1"){
				type2();
			}
			if(value == "2"){
				type3();
			}
        });
		
		//监听操作类型下拉框改变事件
		$("#comboBox002").change(function(){ 
			debugger;
			var value = $(this).val();   
			changeDataSet();        
        });
		
		//监听流程发起人单选框组改变事件
		$("input:radio[name='radiogroup002']").on('ifChecked', function(event){
			debugger;
			var value = $(this).val();   
			chageStarterType();        
        });
		
		//监听触发点单选框组改变事件
		$("input:radio[name='triggerPoint']").on('ifChecked', function(event){
			debugger;
			var value = $(this).val();   
			changeTriggerPoint();        
        });
		
		
		
	})
	function type1() {
		//当前流程发起人
		document.getElementById('tr010').style.display = '';
		//指定人员
		document.getElementById('tr017').style.display = '';
		//选定节点
		document.getElementById('tr018').style.display = '';
		document.getElementById('tr019').style.display = '';
		//流程模板
		document.getElementById('tr011').style.display = '';
		//消息接收人
		document.getElementById('tr012').style.display = 'none';
		//消息模板
		document.getElementById('tr013').style.display = 'none';
		//目标表单
		document.getElementById('tr014').style.display = 'none';
		//操作类型
        document.getElementById('tr015').style.display = '';
		//数据拷贝设置
		document.getElementById('tr016').style.display = '';
		//预提控制
		document.getElementById('tr022').style.display = 'none';
		
		Matrix.setFormItemValue('input003', '');   //消息接收人
		Matrix.setFormItemValue('receiverId', '');  //消息接收人编码
		Matrix.setFormItemValue('inputTextArea004', '');  //消息模板
		Matrix.setFormItemValue('msgContentVal', '');			
		Matrix.setFormItemValue('input097', '');		//目标表单
		
		$('#comboBox002').attr('readOnly',false);  //操作类型下拉框
	}
	
	function type2() {
		//当前流程发起人
		document.getElementById('tr010').style.display = 'none';
		//指定人员
		document.getElementById('tr017').style.display = 'none';
		//选定节点
		document.getElementById('tr018').style.display = 'none';
		document.getElementById('tr019').style.display = 'none';
		//流程模板
		document.getElementById('tr011').style.display = 'none';
		//消息接收人
		document.getElementById('tr012').style.display = '';
		//消息模板
		document.getElementById('tr013').style.display = '';
		//目标表单
		document.getElementById('tr014').style.display = 'none';
		//操作类型
		document.getElementById('tr015').style.display = 'none';
		//数据拷贝设置
		document.getElementById('tr016').style.display = 'none';
		//预提控制
		document.getElementById('tr022').style.display = 'none';

		$('#radio006').iCheck('check');  //选中当前流程发起人

		Matrix.setFormItemValue('eventUserName', '');
		Matrix.setFormItemValue('input098', '');   //选择流程
		Matrix.setFormItemValue('input005', '');	//选择节点
		Matrix.setFormItemValue('eventUserId', '');
		Matrix.setFormItemValue('eventFlowId', '');
		Matrix.setFormItemValue('eventAdid', '');
	    Matrix.setFormItemValue('inputTextArea003', '');  //选择流程模板
		Matrix.setFormItemValue('eventPdid', '');
		Matrix.setFormItemValue('input097', '');   //目标表单
		Matrix.setFormItemValue('targetFormId', '');
	}
	
	function type3(){
		//当前流程发起人
		document.getElementById('tr010').style.display = 'none';
		//指定人员
		document.getElementById('tr017').style.display = 'none';
		//选定节点
		document.getElementById('tr018').style.display = 'none';
		document.getElementById('tr019').style.display = 'none';
		//流程模板
		document.getElementById('tr011').style.display = 'none';
		//消息接收人
		document.getElementById('tr012').style.display = 'none';
		//消息模板
		document.getElementById('tr013').style.display = 'none';
		//目标表单
		document.getElementById('tr014').style.display = '';
		//操作类型
		document.getElementById('tr015').style.display = '';
		document.getElementById('tr016').style.display = '';
		//预提控制
		document.getElementById('tr022').style.display = 'none';
		
		$('#radio006').iCheck('check');  //选中当前流程发起人
		
		Matrix.setFormItemValue('eventUserName', '');
		Matrix.setFormItemValue('eventUserId', '');
		Matrix.setFormItemValue('input098', '');
		Matrix.setFormItemValue('eventFlowId', '');
		Matrix.setFormItemValue('input005', '');
		Matrix.setFormItemValue('eventAdid', '');
		Matrix.setFormItemValue('inputTextArea003', '');
		Matrix.setFormItemValue('eventPdid', '');
		Matrix.setFormItemValue('input003', '');      //选择消息接收人
		Matrix.setFormItemValue('receiverId', '');	 //消息接收人编码
		Matrix.setFormItemValue('inputTextArea004', '');
		Matrix.setFormItemValue('msgContentVal', '');
		
		$('#comboBox002').attr('readOnly',false);  //操作类型
		
		var operateType = Matrix.getFormItemValue('comboBox002');   //操作类型 ：0增加  1修改后  2添加重复表
		var triggerPoint = document.getElementsByName('triggerPoint');  //触发点
		if(('update'==operateType && triggerPoint[2].checked==true) || ('update'==operateType && triggerPoint[1].checked==true)){
			document.getElementById('tr022').style.display = '';      //显示预提控制
		}
	}
	
	//操作类型下拉框改变事件
	function changeDataSet(){
		var operateType = Matrix.getFormItemValue('comboBox002');
		var actionType = Matrix.getFormItemValue('comboBox001');
		var triggerPoint = document.getElementsByName('triggerPoint');
		if('add' == operateType){
			document.getElementById('tr022').style.display = 'none';  //隐藏预提控制行
			var dataCopyStr = Matrix.getFormItemValue("dataCopyStr");
			if(dataCopyStr != '' && dataCopyStr != null){
				var jsonArray = eval(dataCopyStr);  //转换为 JSON 数组
				if(jsonArray.length == 2){
					jsonArray.shift();
					var jsonArrayStr = JSON.stringify(jsonArray);
					Matrix.setFormItemValue('dataCopyStr',jsonArrayStr);
				} 
			}
		}
		if(('add'!=operateType && "2"==actionType && triggerPoint[2].checked==true) || ('add'!=operateType&&"2" == actionType && triggerPoint[1].checked==true)){
			document.getElementById('tr022').style.display = '';
		}else{
			$('#checkBox001').iCheck('uncheck');  //取消选中预提控制复选框
		}
	}
	
	//流程发起人单选框组改变事件
	function chageStarterType(){ 
		var starterType = document.getElementsByName('radiogroup002'); //获取单选按钮组
		if(starterType[0].checked == true){
			Matrix.setFormItemValue('eventUserName', '');  //选定人员
			Matrix.setFormItemValue('eventUserId', '');
			Matrix.setFormItemValue('input098', '');  //流程
			Matrix.setFormItemValue('eventFlowId', '');
			Matrix.setFormItemValue('eventAdid', ''); //节点
			Matrix.setFormItemValue('input005','');
			return;
		}
		if(starterType[1].checked == true){
			Matrix.setFormItemValue('input098', '');  //流程
			Matrix.setFormItemValue('eventFlowId', '');
			Matrix.setFormItemValue('eventAdid', ''); //节点
			Matrix.setFormItemValue('input005','');
			return;
		}
		if(starterType[2].checked == true){
			Matrix.setFormItemValue('eventUserName','');
			Matrix.setFormItemValue('eventUserId','');
			return;
		}
	}
	
	//触发点单选框组改变事件
	function changeTriggerPoint(){  
		var triggerPoint = document.getElementsByName('triggerPoint');
		if(triggerPoint[0].checked == true){
			document.getElementById('tr022').style.display = 'none';
			$('#checkBox001').iCheck('uncheck');  //取消选中预提控制复选框
		}
		if(triggerPoint[1].checked == true){
			document.getElementById('tr022').style.display = 'none';
			changeDataSet();
		}
		if(triggerPoint[2].checked == true){
			document.getElementById('tr022').style.display = 'none';
			changeDataSet();
		}
		if(triggerPoint[3].checked == true){
			document.getElementById('tr022').style.display = 'none';
			$('#checkBox001').iCheck('uncheck');  //取消选中预提控制复选框
		}
		if(triggerPoint[4].checked == true){
			document.getElementById('tr022').style.display = 'none';
			$('#checkBox001').iCheck('uncheck');  //取消选中预提控制复选框
		}
		
	}
		
	//点击保存之前校验
	function validation() {
		var name = Matrix.getFormItemValue('input001'); //验证名称是否为空
		if(name == ''){
			Matrix.warn('名称不能为空');
			return false;
		}
		var radiogroup = document.getElementsByName('triggerPoint');//获取触发点按钮组
		if(radiogroup[3].checked == true){
			var firstCondition = Matrix.getFormItemValue('inputTextArea002');
			if(firstCondition == ''){
				Matrix.warn('请选择满足条件');
				return false;
			}
		}
		if(radiogroup[4].checked == true){
			var firstCondition = Matrix.getFormItemValue('inputTextArea002');
			if(firstCondition == ''){
				Matrix.warn('请选择满足条件');
				return false;
			}
		}
		var actionType = Matrix.getFormItemValue('comboBox001');
		if ("0" == actionType) {   //触发流程
			var targetFormName = Matrix.getFormItemValue('inputTextArea003');		
			var starters = document.getElementsByName('radiogroup002');
			if (starters[1].checked == true) {
				var input = Matrix.getFormItemValue('eventUserName');
				if (input == null || input == '') {
					Matrix.warn('请选择指定人员');
					return false;
				}
			}	
		}
		if ('1' == actionType) {   //发送消息
			var input1 = Matrix.getFormItemValue('input003');
			if (input1 == null || input1 == '') {
				Matrix.warn('请选择消息接收人');
				return false;
			}
			var input2 = Matrix.getFormItemValue('inputTextArea004');
			if (input1 == null || input1 == '') {
				Matrix.warn('请选择消息模板');
				return false;
			}
		}
		if('2' == actionType){  //数据设置
			var targetFormName = Matrix.getFormItemValue('input097');
			if(targetFormName == ''){
				Matrix.warn('请选择目标表单');
				return false;
			}
		}
		return true;
	}
	
	//打开选择首次满足条件窗口
	function showFirstCondition(){
		var radiogroup = document.getElementsByName("triggerPoint");
		
		document.getElementById('tr022').style.display = 'none';
		$('#checkBox001').iCheck('uncheck');  //取消选中预提控制复选框
		var condition = Matrix.getFormItemValue('inputTextArea002');
		
		parent.parent.parent.isc.MFH.winObj = this;   //fromdesigner.js
		parent.parent.parent.layer.open({ 
	    	id:'m_firstCondition',
			type : 2,
			
			title : ['设置条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '80%' ],
			content : "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=m_firstCondition&entrance=FirstSatisfaction&firstCondition="+encodeURI(condition)+""
		});			
	}
	
	//首次满足条件窗口回调
	function onfirstConditionClose(result){
		if(result!=null && result!=''){
			Matrix.setFormItemValue('inputTextArea002',result.conditionText);
			Matrix.setFormItemValue('conditionVal',result.conditionVal);
		}
	}
	
	
	//打开选择指定人员或消息接收人窗口
	function showSelectPersons() {  
		var eventType = Matrix.getFormItemValue('comboBox001');
		if(eventType == '0'){
			var radiogroup = document.getElementsByName('radiogroup002');
			if(!radiogroup[1].checked){
				return;
			}
			parent.iframeJs = this;
			parent.layer.open({
		    	id:'persons',
				type : 2,
				
				title : ['指定人员'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '60%', '80%' ],
				content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=persons'
			});
			Matrix.setFormItemValue('isPerson','1'); //是选单人
			
		}else{
			parent.authUser.areaIds = document.getElementById("receiverId").value;      //消息接收人编码
			parent.authUser.areaName = Matrix.getFormItemValue("input003");  //消息接收人名称
			parent.iframeJs = this;
			parent.layer.open({
		    	id:'persons',
				type : 2,
				
				title : ['消息接收人'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '80%', '80%' ],
				content : '<%=request.getContextPath()%>/office/html5/select/MixSelect.jsp?iframewindowid=persons'
			});
		}
	}

	//指定人员或消息接收人窗口回调
	function onpersonsClose(data) {
		if (data != null) {
			var userNames;
			var userId;
			var isPerson = Matrix.getFormItemValue('isPerson');
			if(isPerson == '1'){ //选择单个人
				userNames = data.names;
				userId = data.ids;
			}else{
				userNames = data.allNames;
				userId = data.allIds;
			}
				var eventType = Matrix.getFormItemValue('comboBox001');
			if (eventType == '0') {
				Matrix.setFormItemValue('eventUserId', userId);
				Matrix.setFormItemValue('eventUserName', userNames);
			}else{
				Matrix.setFormItemValue('receiverId', userId);
				Matrix.setFormItemValue('input003', userNames);
			}
		}
	}
	
	 //打开选择流程窗口
	function selectFlow() {
		var radiogroup = document.getElementsByName("radiogroup002");
		if(!radiogroup[2].checked){
			return;
		}
		Matrix.setFormItemValue('eventUserName','');
		Matrix.setFormItemValue('eventUserId','');
		Matrix.setFormItemValue('input005','');
		Matrix.setFormItemValue('eventAdid','');
		
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'flow',
			type : 2,//iframe 层
			
			title : ['选择流程'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectProcessTree.jsp?rootMid=flowdesign&rootEntityId=flowRoot&iframewindowid=flow',
		});
	}
	 
	//选择流程窗口回调
	function onflowClose(result) {
		if (result != null) {
			var startCoTmplName = result.name; // 流程名称
			var flowId = result.pdid; // 流程编码
			Matrix.setFormItemValue('input098', startCoTmplName); //显示流程名称
			Matrix.setFormItemValue('eventFlowId', flowId);
		}
	}
	
	//打开选择流程模板窗口
	function selectFlowTemplate() { 
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'flowTemplate',
			type : 2,//iframe 层
			
			title : ['选择流程模板'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : '<%=request.getContextPath()%>/form/html5/admin/flow/html5FlowTemplateTree.jsp?templateType=2&iframewindowid=flowTemplate',
		});
	}
	
	//选择流程模板窗口回调
	function onflowTemplateClose(result){
		if (result != null) {
			//var data = eval("("+result+")");
			var data = result;
			var startCoTmplName = data.name; // 模板名称
			//var startCoTmplId = data.uuid;
			var flowId = data.uuid; // 模板编码
			var formId = data.formId;//目标表单编码
			Matrix.setFormItemValue('targetFormId',formId);
			var targetFormId = formId;
			var oldTargetFormId = Matrix.getFormItemValue('oldTargetFormId');//获取原先选择的目标表单 Id
			if(oldTargetFormId == null || oldTargetFormId == ''){ //说明是第一次选择表单
				Matrix.setFormItemValue('oldTargetFormId',targetFormId);
			}else{
				if(oldTargetFormId != targetFormId){ //若新选的目标表单跟原先选择的不一样，把设置的条件清空,同时把新选的表单ID变为原先的表单ID
					Matrix.setFormItemValue('dataCopyStr','');
					Matrix.setFormItemValue('oldTargetFormId',targetFormId);
				}
			}
			Matrix.setFormItemValue('inputTextArea003', startCoTmplName); //显示流程模板名
			Matrix.setFormItemValue('eventPdid', flowId);	
		}
	}
	
	//打开选择节点窗口
	function showPoint(){
		var radiogroup = document.getElementsByName("radiogroup002");
		if(!radiogroup[2].checked){
			return;
		}
		Matrix.setFormItemValue('evnetUserNames','');
		if(Matrix.getFormItemValue('input098') == ''){
			Matrix.warn('请先选择流程！');
			return;
		}
		var flowId = Matrix.getFormItemValue('eventFlowId');
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'checkPoint',
			type : 2,//iframe 层
			
			title : ['选择流程节点'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '90%' ],
			content : "<%=request.getContextPath()%>/editor/common/selectActivityNode.jsp?flowId="+flowId+"&iframewindowid=checkPoint"
		});
	}
	
	//选择节点窗口回调
	function oncheckPointClose(data){
		if(data!=null&&data!=""){	
			Matrix.setFormItemValue('eventAdid',data.id);
			Matrix.setFormItemValue('input005',data.name);
		 }
	}
	
	//选择目标表单窗口
	function showFormTree(){ 
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'formTree',
			type : 2,//iframe 层
			
			title : ['选择目标表单'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '60%', '80%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFormTree.jsp?rootMid=flowdesign&rootEntityId=flowRoot&iframewindowid=formTree',
		});
	}
	
	//目标表单窗口回调
	function onformTreeClose(data){
		if (data != null) {
			var targetFormName = data.name;
			var targetFormId = data.id;
			Matrix.setFormItemValue('input097',targetFormName);
			Matrix.setFormItemValue('targetFormId',targetFormId);
			var oldTargetFormId = Matrix.getFormItemValue('oldTargetFormId');//获取原先选择的目标表单 Id
			if(oldTargetFormId == null || oldTargetFormId == ''){ //说明是第一次选择表单
				Matrix.setFormItemValue('oldTargetFormId',targetFormId);
			}else{
				if(oldTargetFormId != targetFormId){ //若新选的目标表单跟原先选择的不一样，把设置的条件清空,同时把新选的表单ID变为原先的表单ID
					Matrix.setFormItemValue('dataCopyStr','');
					Matrix.setFormItemValue('oldTargetFormId',targetFormId);
				}
			}
		}
	}
	
	//点击设置按钮打开数据拷贝设置窗口
	function showDataCopySet(){
		var type = Matrix.getFormItemValue('comboBox001');
		if (type == "" || type == '0') { //触发流程类型
			var targetFormName = Matrix.getFormItemValue('inputTextArea003');
			if(targetFormName==''){
				Matrix.warn('请选择流程模板');
				return;
			}
		}else{
			var targetFormName = Matrix.getFormItemValue('input097');
			if(targetFormName==''){
				Matrix.warn('请选择目标表单');
				return;
			}
		}
		var operateType = Matrix.getFormItemValue('comboBox002');
		var targetFormId = Matrix.getFormItemValue('targetFormId');
		var optString = <%=request.getParameter("optString")%>;
		var params = '&';
		var value;
		value = null;
		try {
			value = operateType;
		} catch (error) {
			value = operateType;
		}
		if (value != null) {
			value = "operateType=" + value;
			params += value;
		}
		params += "&";
		try {
			value = eval(optString);
		} catch (error) {
			value = optString;
		}
		if (value != null) {
			value = "optString=" + value;
			params += value;
		}
		params += "&";
		try {
			value = eval(targetFormId);
		} catch (error) {
			value = targetFormId;
		}
		if (value != null) {
			value = "targetFormId=" + value;
			params += value;
		}
		var dataCopyStr = document.getElementById("dataCopyStr").value
	
		parent.parent.parent.isc.MFH.winObj = this;       //formdesigner.js
		parent.parent.parent.layer.open({
	    	id:'m_dataCopySet',
			type : 2,
			
			title : ['数据拷贝设置'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '80%' ],
			content : "<%=request.getContextPath()%>/trigger/dataCopy_loadDataCopySet.action?iframewindowid=m_dataCopySet"+params+"&dataCopyStr="+encodeURIComponent(dataCopyStr)
		});			
	}
	
	//数据拷贝设置窗口回调
	function ondataCopySetClose(data){
		if(data!=null&&data!=""){
			Matrix.setFormItemValue('dataCopyStr',data.dataCopyStr);
		}
	}

	//打开消息模板窗口
	function showMsgContent(){
		var msgContent = Matrix.getFormItemValue('inputTextArea004');
		parent.parent.parent.isc.MFH.winObj = this;
		parent.parent.parent.layer.open({
	    	id:'m_msgContent',
			type : 2,
			
			title : ['消息模板设置'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '80%' ],
			content : "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=m_msgContent&entrance=MessageTemplate&firstCondition="+encodeURI(msgContent)+""
		});		
	}
	
	//消息模板窗口回调
	function onmsgContentClose(result){
		if(result!=null && result!=''){
			Matrix.setFormItemValue('inputTextArea004',result.conditionText);
			Matrix.setFormItemValue('msgContentVal',result.conditionVal);
		}
	}
	
	//保存
	function submitByButton(){
		debugger;
		var synJson = Matrix.formToObject('form0');
		synJson.comboBox001 = Matrix.getFormItemValue('comboBox001');
		synJson.comboBox002 = Matrix.getFormItemValue('comboBox002');
		var optString = Matrix.getFormItemValue('optString');
		var url = null;
		var index = Matrix.getFormItemValue('index');
		if(optString == '0'){     //添加
			url = "<%=request.getContextPath()%>/trigger/formProcessor_addTrigger.action";
		}else{   //修改
			url = "<%=request.getContextPath()%>/trigger/formProcessor_editTrigger.action?index="+index;
		}
		Matrix.sendRequest(url,synJson,function(data){
			if(data != null && data.data != null){
				var json = isc.JSON.decode(data.data);
				if(json.result){
					Matrix.setFormItemValue('optString','1');
					Matrix.setFormItemValue('index',json.index);
					if(optString == '0'){     //添加
						Matrix.say('保存成功');
						parent.parent.Matrix.refreshDataGridData('DataGrid001');
					}else{   //修改
						Matrix.say("更新成功");
						var triggerName = Matrix.getFormItemValue("input001");
		    			var status;
		    			var statusRadios = document.getElementsByName('radioGroup001'); //状态
		    			if(statusRadios[0].checked == true){
		    				status = 0;
		    			}else if(statusRadios[1].checked == true){
		    				status = 1;
		    			}
		    			var index = Matrix.getFormItemValue("index");
		    			parent.parent.updateNameAndStatus(triggerName,status,index);
					}
					
				}else{
					Matrix.warn("该触发器已存在，请更换名称");
				}
			}
		});
	}
</script>
</head>
<body>	  
	   <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<!-- Matrix平台校验 -->
			<input type="hidden" id="validateType" name="validateType" value="jquery" />  
			<!-- 记录的触发事件名称 -->
			<input type="hidden" id="triggerName" name="triggerName" value="${formTrigger.name==null?'':formTrigger.name}" />  
			<!-- 判断是添加还是修改操作   1添加  1修改-->
			<input id="optString" type="hidden" name="optString" value="<%=request.getParameter("optString")%>"/>
			<!-- 是指定人员的单选人 -->
			<input id="isPerson" type="hidden" name="isPerson" /> 
			<!--触发事件主键即顺序号 -->
			<input id="index" type="hidden" name="index" value="${param.index }"/>
			<!-- 首次满足条件编码 -->
			<input id="conditionVal" name="conditionVal" type="hidden" value="${formTrigger.firstCondition}" />
			
			<!-- 动作：触发流程 -->
			<!-- 指定人员用户编码  -->
			<input id="eventUserId" type="hidden" name="eventUserId" value='${formTrigger.eventUserId}' />   
			<!-- 选择的流程编码 -->  
			<input id="eventFlowId" type="hidden" name="eventFlowId" value='${formTrigger.eventFlowId}' />
			<!-- 选择的活动节点编码 -->
			<input id="eventAdid" type="hidden" name="eventAdid" value='${formTrigger.eventAdid}' />
			<!-- 选择的流程模板编码 -->
			<input id="eventPdid" type="hidden" name="eventPdid" value='${formTrigger.eventPdid}' />

			<!-- 动作：发送消息  -->
			<!-- 消息接收人编码 -->
			<input id="receiverId" type="hidden" name="receiverId" value='${formTrigger.receiverId}' />
			<!-- 消息模板编码  -->
			<input id="msgContentVal" name="msgContentVal" type="hidden" value='${formTrigger.msgContent}' />
			
			<!-- 动作：数据设置-->
			<!-- 当前选中的目标表单编码 -->
			<input id="targetFormId" type="hidden" name="targetFormId" value='${formTrigger.targetFormId}'/>
			<!-- 保存原先选择的目标表单编码 -->
			<input id="oldTargetFormId" type="hidden" name="oldTargetFormId" value='${formTrigger.targetFormId}'/>
			<!-- 数据拷贝设置条件编码 
			<input id="dataCopyStr" type="hidden" name="dataCopyStr" value='${requestScope.dataCopyStr==null?"":requestScope.dataCopyStr}'/>
			 -->  
			
			<div id="container">
			    <div id="top" style="height:calc(100% - 54px); width:100%;overflow: auto;">
					<table id="table001" class="tableLayout" style="width: 100%;">
						<tr id="tr001">
							<td id="td001" class="tdValueCls" colspan="3" rowspan="1" style="width: 100%;text-align: left;">
								<label id="label001" name="label001" id="label001" style="font-size: 14px; margin-left: 5px;">
									触发定义
								</label>
							</td>
						</tr>
						<tr id="tr002">
							<td id="td003" class="tdLabelCls" colspan="1" style="width: 25%">
								<label id="label003" name="label003" id="label003">
									名称：
								</label>
							</td>
							<td id="td004" class="tdValueCls" colspan="2" style="width: 75%;">
								<div id="input001_div" style="vertical-align: middle;">
									<input id="input001" name="input001" type="text" value="${formTrigger.name==null?'':formTrigger.name}" class="form-control" style="height:100%;width:100%;" required="required"/>
								</div>
							</td>
						</tr>
						<tr id="tr003">
							<td id="td005" class="tdLabelCls" colspan="1" style="width: 25%">
								<label id="label004" name="label004" id="label004">
									状态：
								</label>
							</td>
							<td id="td006" class="tdValueCls" colspan="2" style="width: 75%;text-align: left;padding-left: 5px;">
								<div id="radioGroup001_div" style="display: inline-block;">
									<input id="radioGroup001_0" name="radioGroup001" type="radio" class="box" value="0" ${formTrigger.status == '0' ? 'checked' : ''}/>
								</div>
								<label name="label005" id="label005" class="control-label" style="vertical-align: middle;">
									启动
								</label>	
								<div id="radioGroup001_1_div" style="display: inline-block;" >
									<input id="radioGroup001_1" name="radioGroup001" type="radio" class="box" value="1" ${formTrigger.status == '1' ? 'checked' : ''}/>
								</div>
								<label name="label006" id="label006" class="control-label" style="vertical-align: middle;">
									停用
								</label>
							</td>	
						</tr>
						<tr id="tr004">
							<td id="td007" class="tdValueCls" colspan="3" rowspan="1" style="width: 100%;text-align: left;">
								<label id="label007" name="label007" style="font-size: 14px; margin-left: 5px;">
									条件
								</label>
							</td>
						</tr>
						<%
							FormTrigger formTrigger = (FormTrigger)request.getAttribute("formTrigger");
							int eventPoint = formTrigger.getEventPoint();
							String str = (String)request.getAttribute("checkPointFlowName");
							if(str == null){
								str = "";
							}
							String flowBeginName = "";
							String flowEndName = "";
							String checkPointFlowName = "";
							if(eventPoint == 0){
								flowBeginName = str;
							}else if(eventPoint == 3){
								flowEndName = str;
							}else{
								checkPointFlowName = str;
							}
						 %>
						<tr id="tr007">
							<td id="td009" class="tdLabelCls" colspan="1" rowspan="1" style="width: 25%">
								<label id="label009" name="label009">
									触发点：
								</label>
							</td>
							<td id="td014" class="tdValueCls" colspan="1" rowspan="1" style="width: 20%;text-align: left;padding-left: 5px;">
								<div id="startPoint_div">
									<div id="radio001_div" style="display: inline-block;">
										<input id="radio001" name="triggerPoint" type="radio" class="box" value="0" ${formTrigger.eventPoint == '0' ? 'checked' : ''}/>
									</div>
									<label name="label010" id="label010" class="control-label" style="vertical-align: middle;">
										流程开始
									</label>	
								</div>
								<div id="endPoint_div">
									<div id="radio002_div" style="display: inline-block;" >
										<input id="radio002" name="triggerPoint" type="radio" class="box" value="3" ${formTrigger.eventPoint == '3' ? 'checked' : ''}/>
									</div>
									<label name="label011" id="label011" class="control-label" style="vertical-align: middle;">
										流程结束
									</label>
								</div>
								<div style="display:none;">
									<div id="radio003_div" style="display: inline-block;" >
										<input id="radio003" name="triggerPoint" type="radio" class="box" value="1" ${formTrigger.eventPoint == '1' ? 'checked' : ''}/>
									</div>
									<label name="label012" id="label012" class="control-label" style="vertical-align: middle;">
										核定节点通过
									</label>
								</div>
								<div>
									<div id="radio004_div" style="display: inline-block;" >
										<input id="radio004" name="triggerPoint" type="radio" class="box" value="2" ${formTrigger.eventPoint == '2' ? 'checked' : ''}/>
									</div>
									<label name="label013" id="label013" class="control-label" style="vertical-align: middle;">
										首次条件满足时
									</label>
								</div>
								<div>
									<div id="radio005_div" style="display: inline-block;" >
										<input id="radio005" name="triggerPoint" type="radio" class="box" value="4" ${formTrigger.eventPoint == '4' ? 'checked' : ''}/>
									</div>
									<label name="label014" id="label014" class="control-label" style="vertical-align: middle;">
										每次条件满足时
									</label>
								</div>	
							</td>
							<td id="td037" colspan="1" rowspan="1" class="tdValueCls" style="width: 55%;">
								<div id="inputTextArea002_div" style="height: 100%;">							
									<textarea id="inputTextArea002" name="inputTextArea002" class="form-control" placeholder="请选择首次满足条件" style="height: 100%;resize: none;" onclick="showFirstCondition();">${requestScope.firstCondition == null?"":requestScope.firstCondition}</textarea>						
								</div>
							</td>
						</tr>
						<tr id="tr008">
							<td id="td015" class="tdValueCls" colspan="3" rowspan="1" style="width: 100%;text-align: left;">
								<label id="label015" name="label015"style="font-size: 14px; margin-left: 5px;">
									动作
								</label>
							</td>
						</tr>
						<tr id="tr009">
							<td id="td017" class="tdLabelCls" colspan="1" rowspan="1" style="width: 25%;">
								<label id="label016" name="label016">
									类型：
								</label>
							</td>
							<td id="td018" class="tdValueCls" colspan="2" style="width: 75%;">
								<div id="comboBox001_div" style="vertical-align: middle;">
									<select id="comboBox001" name="comboBox001" value="${formTrigger.eventType==null?'2':formTrigger.eventType}" class="selectpicker show-tick form-control" style="height:100%;width:100%;">
				                        <option value="0" ${formTrigger.eventType == 0 ? "selected" : ""}>发起流程</option>
				                        <option value="1" ${formTrigger.eventType == 1 ? "selected" : ""}>发送消息</option>
				                        <option value="2" ${formTrigger.eventType == 2 ? "selected" : ""}>数据设置</option>
				                    </select>
								</div>
							</td>
						</tr>
						<tr id="tr010">
							<td id="td019" class="tdLabelCls" colspan="1" rowspan="4" style="width: 25%;">
								<label id="label018" name="label018">
									流程发起人：
								</label>
							</td>
							<td id="td020" class="tdValueCls" colspan="2" style="width: 75%;text-align: left;padding-left: 5px;">
								<div id="radio006_div" style="display: inline-block;">
									<input id="radio006" name="radiogroup002" type="radio" class="box" value="0" ${formTrigger.startType == '0' ? 'checked' : ''}/>
								</div>
								<label name="label019" id="label019" class="control-label" style="vertical-align: middle;">
									当前流程发起人
								</label>	
							</td>
						</tr>
						<tr id="tr017">
							<td id="td017" class="tdValueCls" colspan="1" style="width: 20%;text-align: left;padding-left: 5px;">
								<div style="float:left;margin-right: 3px;line-height: 35px;">
									<div id="radio007_div" style="display: inline-block;">
										<input id="radio007" name="radiogroup002" type="radio" class="box" value="1" ${formTrigger.startType == '1' ? 'checked' : ''}/>
									</div>
									<%
										String eventUserNames = (String) request.getAttribute("eventUserNames");
										if (eventUserNames == null) {
											eventUserNames = "";
										}
									%>
									<label name="label020" id="label020" class="control-label" style="vertical-align: middle;">
										指定人员
									</label>	
								</div>							
							</td>
							<td id="td035" class="tdValueCls" colspan="1" style="width: 55%;text-align: left;">				
								<div id="eventUserName_div" class="input-group" style="width: 100%;">
									 <input id="eventUserName" name="eventUserName" type="text" value="<%=eventUserNames %>"  placeholder="请选择指定人员" class="form-control" readonly="readonly" >
				            		 <span class="input-group-addon addon-udSelect udSelect" onclick="showSelectPersons();"><i class="fa fa-search"></i></span>
								</div>	
							</td>
						</tr>		
						<tr id="tr018">
							<td id="td033" class="tdValueCls" colspan="1" rowspan="2" style="width: 20%;text-align: left;padding-left: 5px;">
								<div id="radio008_div" style="display: inline-block;">
									<input id="radio008" name="radiogroup002" type="radio" class="box" value="2" ${formTrigger.startType == '2' ? 'checked' : ''}/>
								</div>
								<label name="label020" id="label020" class="control-label ">
									选定节点
								</label>
							</td>
							
							<td id="td037" class="tdValueCls" colspan="1" style="width: 45%;text-align: left;">										
								<div id="input098_div" class="input-group">
									 <input id="input098" name="input098" type="text" value="<%=request.getAttribute("eventFlowName") == null? "":(String) request.getAttribute("eventFlowName")%>"  placeholder="请选择流程" class="form-control" readonly="readonly" >
				            		 <span class="input-group-addon addon-udSelect udSelect" onclick="selectFlow();"><i class="fa fa-search"></i></span> 
				            	</div>				
							</td>
						</tr>
						<tr id="tr019">				
							<td id="td038" class="tdValueCls" colspan="1" style="width: 45%;text-align: left;">										
			            		 <%
									String actName = (String) request.getAttribute("actName");
									if (actName == null) {
										actName = "";
									}
								 %>
								<div id="input005_div" class="input-group">
									<input id="input005" name="input005" type="text" value="<%=actName %>" placeholder="请选择节点" class="form-control" readonly="readonly" >
				            		<span class="input-group-addon addon-udSelect udSelect" onclick="showPoint();"><i class="fa fa-search"></i></span>
								</div>						
							</td>
						</tr>
						<tr id="tr011">
							<td id="td034" class="tdLabelCls" colspan="1" style="width: 25%;">					
								<label id="label024" name="label024">
									流程模板：
								</label>
							</td>
							<td id="td022" colspan="3" style="width: 75%;">
								<div id="inputTextArea003_div" class="input-group" style="width: 100%;">
									 <input id="inputTextArea003" name="inputTextArea003" type="text" value="<%=request.getAttribute("lcmb") == null? "":(String) request.getAttribute("lcmb")%>" placeholder="请选择流程模板" class="form-control" readonly="readonly" >
				            		 <span class="input-group-addon addon-udSelect udSelect" onclick="selectFlowTemplate();"><i class="fa fa-search"></i></span>
								</div>						
							</td>
						</tr>
						<tr id="tr012">
							<td id="td023" class="tdLabelCls" colspan="1" style="width: 25%">					
								<label id="label026" name="label026">
									消息接收人：
								</label>
							</td>
							<td id="td024" class="tdValueCls" colspan="2" style="width: 75%;">
								<%
									String receiverNames = (String) request.getAttribute("receiverNames");
									if (receiverNames == null) {
										receiverNames = "";
									}
								%>
								<div id="input003_div" class="input-group" style="width: 100%;">
									 <input id="input003" name="input003" type="text" value="${formTrigger.receiverName}"  placeholder="请选择消息接收人" class="form-control" readonly="readonly" >
				            		 <span class="input-group-addon addon-udSelect udSelect" onclick="showSelectPersons();"><i class="fa fa-search"></i></span>
								</div>
							</td>
						</tr>
						<tr id="tr013">
							<td id="td025" class="tdLabelCls" colspan="1" style="width: 25%;">						
								<label id="label028" name=""label028"" id="label017">
									消息模板：
								</label>
							</td>
							<td id="td026" colspan="2" style="width: 75%;">
								<div id="inputTextArea004_div" class="input-group" style="width: 100%;">
									 <input id="inputTextArea004" name="inputTextArea004" type="text" value="${requestScope.msgContent == null?'':requestScope.msgContent}" placeholder="请选择消息模板" class="form-control" readonly="readonly" >
				            		 <span class="input-group-addon addon-udSelect udSelect" onclick="showMsgContent();"><i class="fa fa-search"></i></span>
								</div>		
							</td>
						</tr>
						<tr id="tr014">
							<td id="td027" class="tdLabelCls" colspan="1" style="width: 25%;">						
								<label id="label030" name="label030">
									目标表单：
								</label>
							</td>
							<td id="td028" class="tdValueCls" colspan="2" style="width: 75%">
								<div id="input097_div" class="input-group" style="width: 100%;">
									 <input id="input097" name="input097" type="text" value="<%=request.getAttribute("targetFormName")==null?"":request.getAttribute("targetFormName")%>"  placeholder="请选择目标表单" class="form-control" readonly="readonly" >
				            		 <span class="input-group-addon addon-udSelect udSelect" onclick="showFormTree();"><i class="fa fa-search"></i></span>
								</div>
							</td>
						</tr>
						<tr id="tr015">
							<td id="td029" class="tdLabelCls" colspan="1" style="width: 25%">						
								<label id="label032" name="label032">
									操作类型：
								</label>
							</td>
							<td id="td030" class="tdValueCls" colspan="2" style="width: 75%">
								<div id="comboBox002_div" style="width: 100%;vertical-align: middle;">
									<select id="comboBox002" name="comboBox002" value="${formTrigger.operateType==null?'add':formTrigger.operateType}" class="selectpicker show-tick form-control" style="height:100%;width:100%;">
				                        <option value="add" ${formTrigger.operateType == 'add' ? "selected" : ""}>增加</option>
				                        <option value="update" ${formTrigger.operateType == 'update' ? "selected" : ""}>修改</option>
				                        <option value="addRepeat" ${formTrigger.operateType == 'addRepeat' ? "selected" : ""}>添加重复表</option>
				                    </select>
								</div>
							</td>
						</tr>
						<tr id="tr016">
							<td id="td031" class="tdLabelCls" colspan="1" style="width: 25%;">
								<label id="label033" name="label033">
									数据拷贝设置：
								</label>
							</td>
							<td id="td032" class="tdValueCls" colspan="2" style="width: 75%;text-align: left;padding-left: 10px;">
								<textarea id="dataCopyStr" name="dataCopyStr" cols="20" style="display: none;" >${requestScope.dataCopyStr==null?'':requestScope.dataCopyStr}</textarea>
								<div class="x-btn ok-btn" onclick="showDataCopySet();">
									<span>设置</span>
								</div>			
							</td>
						</tr>
						<tr id="tr022" style="display:none">
							<td id="td02_22" class="tdLabelCls" colspan="1" style="width: 25%">						
								<label id="label021" name="label021" id="label021">
									预提控制：
								</label>
							</td>
							<td id="td01_22" class="tdValueCls" colspan="2" rowspan="2" style="width: 75%;text-align: left;">
								<div id="checkBox001_div" name="correlation_div" style="padding-left: 10px;display: inline-block;">
									<input id="checkBox001" name="checkBox001" type="checkbox" class="box"  value="${formTrigger.beforeControl}"/>
								</div>
								<label name="label020" id="label020" class="control-label" style="vertical-align: middle;">
									启用
								</label>
							</td>
						</tr>
					</table>
				</div>
				<div id="buttom" class="cmdLayout">	
					<input type="button" class="x-btn ok-btn" name="保存" value="保存" id="save" >
					<!--  
					<input type="button" class="x-btn ok-btn" name="保存" value="保存并关闭" id="saveAndClose" >
					<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="cancel" >
					-->
					<input type="button" class="x-btn cancel-btn" name="关闭" value="关闭" id="shut" >
					<script type="text/javascript">
						//保存
				        $("#save").on("click",function(){
				     		Matrix.showMask2();
				    		//表单验证
				    		if (!Matrix.validateForm('form0')) {
				    			Matrix.hideMask2();
				    			return false;
				    		}
				    		//触发项验证
				    		if(validation()){
				    			//保存
				    			submitByButton();
				    			Matrix.hideMask2();
				    		}else{
				    			Matrix.hideMask2();
				    		}
				        });
						/*
				        //保存并关闭
				        $("#saveAndClose").on("click",function(){
				     		Matrix.showMask2();
				    		//表单验证
				    		if (!Matrix.validateForm('form0')) {
				    			Matrix.hideMask2();
				    			return false;
				    		}
				    		//校验
				    		if(validation()){
				    			//保存
				    			submitByButton();
				    			Matrix.hideMask2();
				    			parent.parent.Matrix.closeWindow();
				    		}else{
				    			Matrix.hideMask2();
				    		}
				        });
				        
				      	//取消
				        $("#cancel").on("click",function(){
				        	parent.parent.$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
				        	parent.parent.document.getElementById('iframeContent').src = "<%=request.getContextPath()%>/editor/common/empty.html";
				        })
				        */
				       //关闭
				        $("#shut").on("click",function(){
				        	parent.parent.Matrix.closeWindow();
				        })
					</script>	
				</div>
			</div>
		</form>
	</body>
</html>
