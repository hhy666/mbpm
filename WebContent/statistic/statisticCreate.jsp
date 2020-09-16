<%@page pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">

	//保存模型
	function saveData(){
		//var alias = $('#alias').val();
		var formId = $('#formId').val();
		var name = $('#name').val();
		var type = "1";
		var templateId = $('#templateId').val();
		var description = $('#description').val();
		if(name!=null&&name.trim()!=""){
			var json = {};
			//json.alias = alias;
			json.name = name;
			json.type = type;
			json.templateId = templateId;
			json.description = description;
			json.formId = formId;
			$.ajax({
				type:'post',
				url:'<%=path %>/statistic/statisticAction_createStatisticModel.action',
				data:json,
				dataType:'text',
				success:function(data){
					if(data=='true')
						Matrix.closeWindow(data);
					else if(data=='false'){
						Matrix.warn('名称不能重复！');
						return false;
					}
				}
			});
		}else{
			Matrix.warn('名称不能为空！');
			return false;
		}
	}
</script>
</head>
<body style="padding:5px">
	<input type="hidden" id="templateId" name="templateId" value="${param.templateId}">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<table id="table001" class="tableLayout" style="width:100%;">
		<!-- <tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:30%;">
				<label>编码:</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:70%;">
				<input id="alias" name="alias" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">	
			</td>
		</tr> -->
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:30%;">
				<label>名称:</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:70%;">
				<input placeholder="请输入名称" id="name" name="name" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:30%;">
				<!-- <label>模型类型:</label> -->
				<label>描述:</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:70%;">
				<!-- <select id="type" class="form-control select2-accessible">
					<option value="1" selected>统计模型</option>
					<option value="2">仪表盘</option>
				</select> -->
				<textarea id="description" name="description" class="form-control" style="resize: none;height:99px;width:100%;" autocomplete="off" "></textarea>	
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="cmdLayout">
				<button style="width:85px" class="x-btn ok-btn" type="button" onclick="saveData()">保存</button>
				<button style="width:85px" class="x-btn cancel-btn" type="button" onclick="Matrix.closeWindow()">取消</button>
			</td>
		</tr>
	</table>
</body>
</html>