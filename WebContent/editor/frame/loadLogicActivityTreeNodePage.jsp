<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<title>编辑逻辑活动属性</title>
<meta charset="UTF-8">
<head>
<%@ include file="/form/html5/admin/html5Head.jsp"%>

<style type="text/css">
	#td102{
		background:#F8F8F8;
		text-align:center;
	}
	#table101{
		/**border:3px #dedede solid;*/
	}
	#td103{
		width:25%;
		height:100%;
		border:1px #dedede solid;
	}
	#td104{
		width:75%;
		height:100%;
		border:1px #dedede solid;
	}
	#td105{/** 属性结构标题td*/
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
	#td106{/** 属性结构内容td*/
		width:100%;
		height:94%;
		border:1px #dedede solid;
	}
	#font1{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
	#font2{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
	#td107{
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
	#td108{
		width:100%;
		height:94%;
		border:1px #dedede solid;
	}
</style>
<script>
	var data = {};
	var iframeJs;     //调用一级弹出窗口的window对象
	var iframeJs2;     //调用二级弹出窗口的window对象
	
	window.onbeforeunload = function(){
	    var url = "<%=request.getContextPath()%>/editor/editor_clearSession.action";
	 	Matrix.sendRequest(url,null,function(){});
	}
	
	//高级属性开始条件弹出条件编辑窗口
	function openSatrtCondition(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer01',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer01'
		});
	}
	
	//选择条件编辑窗口回调
	function onlayer01Close(data){
		if(data!=null){
			var express = data.express;
			iframeJs.Matrix.setFormItemValue("inputTextArea001",data.expressName);
			iframeJs.parent.Matrix.setFormItemValue('conditionValue','');
			iframeJs.Matrix.setFormItemValue('editFlag','');//回调时设置为非编辑状态
			iframeJs.setTimeout('setFocus()',300);
		}
	}
	
	//高级属性完成条件弹出条件编辑窗口
	function openFinishCondition(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer02',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer02'
		});
	}
	
	//选择条件编辑窗口回调
	function onlayer02Close(data){
		if(data!=null){
			var express = data.express;
			iframeJs.Matrix.setFormItemValue("inputTextArea002",data.expressName);
			iframeJs.parent.Matrix.setFormItemValue('conditionValue','');
			iframeJs.Matrix.setFormItemValue('editFlag','');//回调时设置为非编辑状态
			iframeJs.setTimeout('setFocus()',300);
		}
	}
	
	//辅助事件详细信息页面弹出条件编辑窗口
	function openCondiation(conditionValue,iframe){
		iframeJs = iframe;
		Matrix.setFormItemValue('conditionValue',conditionValue);
		layer.open({
			id:'layer03',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer03'	
		});  	
	}
	
	//条件编辑窗口回调
	function onlayer03Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('popupSelectDialog2',data.expressName);
			iframeJs.Matrix.setFormItemValue('express',data.express);
			Matrix.setFormItemValue("conditionValue","");
		}
		iframeJs.window.focus();
	}
	
	//辅助事件详细信息页面选择组件弹出非交互式组件窗口
	function openNoComponent(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer04',
			type : 2,
			
			title : ['集成组件选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectnoComponentPage.jsp?iframewindowid=layer04'
		});
	}
	
	//非交互式组件窗口回调
	function onlayer04Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var authId = data.id;
			var groupName = data.name;
			iframeJs.Matrix.setFormItemValue('authId',authId);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog1',groupName);
		}
		iframeJs.window.focus();
	}
</script>
</head>	
<body>
<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
	<!-- 记录当前活动的id -->
	<input type="hidden" id="processdid" name="processdid" value="${param.processdid }"/>
	<input type="hidden" id="activityId" name="activityId" value="${param.activityId }"/>
	<input type="hidden" id="optType" name="optType" value="${param.optType }"/>
	<input type="hidden" id="type" name="type" value="${param.type}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType }"/>
	<input name="conditionValue" id="conditionValue" type="hidden" />
	<div id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	
	<table id="table101" name="table101" style="width:100%;height:100%;">
		<tr id="j_id2" jsId="j_id2">
			<td id="j_id3" jsId="j_id3" height="60px" style="height: 50px;width:100%;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);background-size:100% 100%">
				<br>
				&nbsp;&nbsp;&nbsp;编辑流程活动节点属性，完成后点击保存或保存并关闭按钮.
			</td>
		</tr>
		<tr id="tr101" name="tr101">
			<td id="td101" name="td101" style="width:100%;height:94%;">
				<table id="table102" name="table102" style="width:100%;height:100%;">
					<tr>
						<!-- 属性结构树 -->
					    <td id="td103" name="td103">				
							<div class="main" style="width:100%;height:100%;">
    							<iframe id="main_iframe" src="<%=request.getContextPath()%>/editor/logicactivity/logicActivityPropertyConstructionPage.jsp?activityId=${param.activityId }&type=${param.type }&processdid=${param.processdid }&containerType=${param.containerType }&containerId=${param.containerId }" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>					
						</td>
						<!-- 属性详细信息 -->
						<td id="td104" name="td104">								
							<div class="main" style="width:100%;height:100%;">
								<iframe id="main_iframe1" src="<%=request.getContextPath()%>/editor/editor_autoLoadLogicActBasicInfo.action?activityId=${param.activityId }&type=${param.type }&processdid=${param.processdid }&containerType=${param.containerType }&containerId=${param.containerId }" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="tr102" name="tr102">
			<td id="td102" name="td102" style="width:100%;height:40px;">
				<button type="button" id="button001" class="x-btn ok-btn ">保存</button>
				<button type="button" id="button002" class="x-btn ok-btn ">保存并关闭</button>
				<button type="button" id="button003" class="x-btn cancel-btn ">关闭</button>
				<script>
					//保存
					$('#button001').click(function() {
						Matrix.showMask2();
						var containerId = Matrix.getFormItemValue("containerId");
						var url = "<%=request.getContextPath()%>/editor/editor_saveActivity.action?containerId="+containerId;
						Matrix.sendRequest(url,null,function(data){
							if(data!=null&& data.data!=""){
								Matrix.hideMask2();
								var json = isc.JSON.decode(data.data);
								if(json.result){
									var activityId = Matrix.getFormItemValue('activityId');
									var type = Matrix.getFormItemValue('type');
									window.parent.initProperties(type,activityId);   //初始右侧逻辑活动属性
									Matrix.say("保存成功！");
								}
							}				
						});
					});	
					//保存并关闭
					$('#button002').click(function() {
						Matrix.showMask2();
						var containerId = Matrix.getFormItemValue("containerId");
						var url = "<%=request.getContextPath()%>/editor/editor_updateActivityProperty.action?containerId="+containerId;
						Matrix.sendRequest(url,null,function(data){
							if(data!=null&& data.data!=""){
								Matrix.hideMask2();
								var json = isc.JSON.decode(data.data);
								if(json.result){
									var activityId = Matrix.getFormItemValue('activityId');
									var type = Matrix.getFormItemValue('type');
									window.parent.initProperties(type,activityId);   //初始右侧逻辑活动属性
									var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
									parent.layer.close(index);
									
								}
							}
						});
					});	
					//关闭
					$('#button003').click(function() {
						Matrix.showMask2();
						var url = "<%=request.getContextPath()%>/editor/editor_clearSession.action";
						Matrix.sendRequest(url,null,function(){
							Matrix.hideMask2();
							var index = parent.layer.getFrameIndex(window.name);
							parent.layer.close(index);
						});
					});
				</script>
			</td>	
		</tr>
	</table>	
 </form>
</div>											
</body>
</html>