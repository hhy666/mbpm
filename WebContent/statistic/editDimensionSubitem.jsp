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
		var id = $('#id').val();
		var type = $('#type').val();
		var name = $('#name').val();
		var description = $('#description').val();
		var dimensionItemId = $('#dimensionItemId').val();
		if(name!=null&&name.trim()!=""){
			var json = {};
			json.id = id;
			json.type = type;
			json.name = name;
			json.description = description;
			json.dimensionItemId = dimensionItemId;
			$.ajax({
				type:'post',
				url:'<%=path %>/statistic/statisticAction_validataDimensionSubitemName.action',
				data:json,
				dataType:'text',
				success:function(data){
					if(data=='true'){
						$.ajax({
							type:'post',
							url:'<%=path %>/statistic/statisticAction_saveOrUpdateDimensionSubitem.action',
							data:json,
							dataType:'text',
							success:function(data){
								if(data!=null){
									Matrix.closeWindow(data);
								}
							}
						});
					}else if(data=="false"){
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
	<input type="hidden" id="type" name="type" value="${param.type}">
	<input type="hidden" id="dimensionItemId" name="dimensionItemId" value="${param.dimensionItemId}">
	<input type="hidden" id="id" name="id" value="${id}">
	<table id="table001" class="tableLayout" style="width:100%;">
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:30%;">
				<label>名称:</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:70%;">
				<input value="${dimensionSubitem.name}" id="name" name="name" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:30%;height:90px">
				<label>描述:</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:70%;">
				<textarea id="description" name="description" class="form-control" style="resize: none;height:100%;width:100%;" autocomplete="off" onblur="parent.save();">${dimensionSubitem.description}</textarea>	
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="cmdLayout">
				<button style="width:85px" class="x-btn ok-btn" type="button" onclick="saveData()">保存</button>
				<button style="width:85px" class="x-btn ok-btn" type="button" onclick="Matrix.closeWindow()">取消</button>
			</td>
		</tr>
	</table>
</body>
</body>
</html>