<%@page pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">

	window.onload = function(){
		debugger;
		//移动表单赋值
		var mobileform = ${mobileform};
		if(mobileform==1){
			$('#mobileform').text('原表单');
		}else if(mobileform==2){
			$('#mobileform').text('自定义');
		}else if(mobileform==3){
			$('#mobileform').text('不支持');
		}else{
			$('#mobileform').text('原表单');
		}
		
		parent.document.getElementById('mobileform').value = mobileform;
		parent.document.getElementById('formUuid').value = "${formInfoUuid}";
		parent.document.getElementById('nodeId').value = "${formMid}";
		parent.$("#content").css('display','');
		parent.$("#main").css('display','');
		//parent.$('#loading').css('display','none');
		parent.Matrix.hideMask2();
		parent.layer.close(parent.layer.load());//关闭加载层
	}

	function editTemplate(){
		layer.open({
			type : 2,//iframe 层
			shade: [0.1, '#000'],
			title : ['修改基本信息'],
			area : [ '90%', '60%' ],
			content : '<%=path%>/CompositeModel.rform?iframewindowid=Edit&mBizId=${uuid}&mHtml5Flag=true'
		});
	}
	
	function onEditClose(){
		location.reload();
	}
</script>
</head>
<body style="background:rgba(245,245,247,.9);overflow:auto">
	<input type="hidden" id="utilSize" name="utilSize" value="${utilSize}">
	<input type="hidden" id="querySize" name="querySize" value="${querySize}">
	<input type="hidden" id="flowSize" name="flowSize" value="${flowSize}">
	<div style="padding-left:20px;width: 100%;height: 40px;line-height:40px;margin: auto;border-bottom: 1px solid #cccccc;background:white">
		<label style="font-size: 16px">
			基本信息
		</label>
	</div>
	<div style="width: 100%;height: 220px;margin: auto;padding:20px;padding-top:10px;background:white">
		<table id="table001" class="tableLayout" style="width: 100%;">
			<tbody>
				<tr id="tr001">
					<td id="td001" class="maintain_form_label" colspan="1"  style="width: 40%;padding:10px;text-align:center">
						<label	id="label001" name="label001" class="control-label "> 名称</label>
					</td>
					<td id="td002" class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
						<label id="templateName" name="templateName" style="white-space: nowrap;" class="control-label">${templateName}</label>
					</td>
				</tr>
				<tr id="tr005">
					<td id="td009" class="maintain_form_label" colspan="1" style="width: 40%;padding:10px;text-align:center">
						<label id="label005" name="label005"	class="control-label "> 编码</label>
					</td>
					<td id="td010" class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
						<label id="formMid" name="formMid" style="white-space: nowrap;" class="control-label">${formMid }</label>
					</td>
				</tr>
				<tr style="display: none" id="tr004">
					<td id="td011" class="maintain_form_label" colspan="1" style="width: 40%;padding:10px;text-align:center">
						<label id="label004" name="label004" class="control-label "> 关联表单</label>
					</td>
					<td id="td012" class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
						<label id="formName" name="formName" style="white-space: nowrap;" class="control-label">${formName }</label>
					</td>
				</tr>
				<tr id="tr013">
					<td id="td030" class="maintain_form_label" colspan="1" style="width: 40%;padding:10px;text-align:center">
						<label id="label009" name="label009" class="control-label "> 描述</label>
					</td>
					<td id="td031" class="tdLayout" colspan="1" style="width: 60%;padding:10px;height:100px;text-align:left">
						<label id="templateDesc" name="templateDesc" style="width: 100%;">${templateDesc}</label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div style="width: 100%;height:20px;margin: auto;background: rgba(245,245,247,.9)">
	</div>
	<div style="padding-left:20px;width: 100%;height: 40px;line-height:40px;margin: auto;border-bottom: 1px solid #cccccc;background:white">
		<label style="font-size: 16px">
			更多信息
		</label>
	</div>
	<div style="width: 100%;height:420px;margin: auto;padding:20px;padding-top:10px;background:white">
		<table id="table002" class="tableLayout" style="width: 100%;">
			<tr id="tr006">
				<td id="td013" class="maintain_form_label" colspan="1" style="width: 40%;padding:10px;text-align:center">
					<label id="label014" name="label014" class="control-label "> 移动表单</label>
				</td>		
				<td id="td029" class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
					<label id="mobileform" name="mobileform" style="white-space: nowrap;" class="control-label""></label>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label" colspan="1"  style="width: 40%;padding:10px;text-align:center">
					<label	id="label001" name="label001" class="control-label "> 流程模板</label>
				</td>
				<td class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
					<label id="flowTemplate" name="flowTemplate" style="white-space: nowrap;" class="control-label">${flowSize!=0?flowSize:'无'}${flowSize!=0?'项':''}</label>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label" colspan="1"  style="width: 40%;padding:10px;text-align:center">
					<label	id="label001" name="label001" class="control-label "> 数据管理</label>
				</td>
				<td class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
					<label id="dataUtil" name="dataUtil" style="white-space: nowrap;" class="control-label">${utilSize!=0?utilSize:'无'}${utilSize!=0?'项':''}</label>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label" colspan="1"  style="width: 40%;padding:10px;text-align:center">
					<label	id="label001" name="label001" class="control-label "> 数据查询</label>
				</td>
				<td class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
					<label id="dataQuery" name="dataQuery" style="white-space: nowrap;" class="control-label">${querySize!=0?querySize:'无'}${querySize!=0?'项':''}</label>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label" colspan="1"  style="width: 40%;padding:10px;text-align:center">
					<label	id="label001" name="label001" class="control-label "> 统计分析</label>
				</td>
				<td class="tdLayout" colspan="1" style="width: 60%;padding:10px;text-align:left">
					<label id="statistic" name="statistic" style="white-space: nowrap;" class="control-label">${statisticSize!=0?statisticSize:'无'}${statisticSize!=0?'项':''}</label>
				</td>
			</tr>
			<tr id="tr012">
					<!-- <td id="td026" style="text-align: center;padding-top: 30px" colspan="2">
						<div id="button001" class="x-btn" style="width:100px;font-size: 14px;color: #333;border-color: #ccc;margin:auto" onclick="editTemplate();">
							<span style="line-height:35px">修改</span>
						</div>
					</td> -->
					<td id="td026" style="text-align: center;padding-top: 30px" colspan="2">
						<button type="button" id="button001" class="x-btn ok-btn " style="width:100px;" onclick="editTemplate();">修改</button>
					</td>
				</tr>
		</table>
	</div>
</body>
</html>