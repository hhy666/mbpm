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

	window.onload = function(){
		//根据字段类型初始运算方式
		var entityProType = $('#entityProType').val();
		if(entityProType==1||entityProType==7){//字符和时间类型
			$('#computeWay option[value="0"]').css('display','none')
			$('#computeWay option[value="1"]').css('display','')
			$('#computeWay option[value="2"]').css('display','none')
			$('#computeWay option[value="3"]').css('display','none')
			$('#computeWay option[value="4"]').css('display','none')
		}else if(entityProType==2||entityProType==3||entityProType==4||entityProType==5||entityProType==9){//数字类型
			$('#computeWay option[value="0"]').css('display','')
			$('#computeWay option[value="1"]').css('display','')
			$('#computeWay option[value="2"]').css('display','')
			$('#computeWay option[value="3"]').css('display','')
			$('#computeWay option[value="4"]').css('display','')
		}
		
		var computeWay = "${measure.computeWay}";
		if(computeWay!=null&&computeWay.trim().length>0)
			$("#computeWay option[value='"+computeWay+"']").attr("selected","selected"); 
		
	}
	
	//保存测量值
	function saveData(){
		var id = $('#id').val();
		var name = $('#name').val();
		var templateId = $('#templateId').val();
		nameData = {};
		nameData.name = name;
		nameData.id = id;
		nameData.templateId = templateId;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_validataMeasureName.action',
			data:nameData,
			dataType:'text',
			success:function(data){
				if(data=="true"){
					var type = $('#type').val();
					var entityProId = $('#entityProId').val();
					var entityProType = $('#entityProType').val();
					var computeWay = $('#computeWay').val();
					var resultComputeFormula = $('#resultComputeFormula').val();
					var resultFormat = $('#resultFormat').val();
					var resultUnit = $('#resultUnit').val();
					var formId = $('#formId').val();
					var tableName = $('#tableName').val();
					if(name!=null&&name.trim()!=""&&entityProId!=null&&entityProId.trim()!=""){
						var json = {};
						json.type = type;
						json.id = id;
						json.name = name;
						json.entityProId = entityProId;
						json.entityProType = entityProType;
						json.computeWay = computeWay;
						json.resultComputeFormula = resultComputeFormula;
						json.resultFormat = resultFormat;
						json.resultUnit = resultUnit;
						json.formId = formId;
						json.templateId = templateId;
						json.tableName = tableName;
						$.ajax({
							type:'post',
							url:'<%=path %>/statistic/statisticAction_createOrUpdateMeasure.action',
							data:json,
							dataType:'text',
							success:function(data){
								if(data!=null)
									Matrix.closeWindow(json);
							}
						});
					}else{
						Matrix.warn('名称和变量不能为空！');
						return false;
					}
				}else if(data=="false"){
					Matrix.warn('名称不能重复！');		
					return false;
				}
			}
		});
	}

	//选择测量值绑定变量
	function chooseEntityProId(){
		var formId = $('#formId').val();
		parent.parent.setWindow(this);
		parent.parent.layer.open({
	    	id:'ChooseEntityPro',
			type : 2,
			
			title : ['选择字段'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '75%' ],
			content : "<%=path%>/statistic/chooseEntityPro.jsp?iframewindowid=ChooseEntityPro&formId="+formId
		});
	}
</script>
</head>
<body style="padding:5px">
	<input type="hidden" id="templateId" name="templateId" value="${param.templateId}">
	<input type="hidden" id="id" name="id" value="${id}">
	<input type="hidden" id="type" name="type" value="${param.type}">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<input type="hidden" id="entityProId" name="entityProId" value="${measure.entityProId}">
	<input type="hidden" id="tableName" name="tableName" value="${measure.tableName}">
	<input type="hidden" id="entityProType" name="entityProId" value="${measure.entityProType}">
	<table id="table001" class="tableLayout" style="width:100%;">
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:30%;">
				<label>名称</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:70%;">
				<input id="name" name="name" value="${measure.name}" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:30%;">
				<label>字段</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:70%;">
				<div class="input-group" style="width:100%;">
					<input id="entityProName" name="entityProName" readonly="readonly" value="${entityProName}" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off" >
					<span class="input-group-addon addon-udSelect udSelect" onclick="chooseEntityProId()""><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:30%;">
				<label>计算方式</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:70%;">
				<select id="computeWay" name="computeWay" class="form-control select2-accessible">
					<option value="0">无</option>
					<option value="1">求数量</option>
					<option value="2">求和</option>
					<option value="3">求百分比</option>
					<option value="4">求平均值</option>
				</select>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="tdLabelCls" style="width:30%;">
				<label>计算公式</label>
			</td>
			<td id="td008" class="tdValueCls" style="width:70%;">
				<input id="resultComputeFormula" name="resultComputeFormula" value="${measure.resultComputeFormula}" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr005">
			<td id="td009" class="tdLabelCls" style="width:30%;">
				<label>格式</label>
			</td>
			<td id="td010" class="tdValueCls" style="width:70%;">
				<input id="resultFormat" name="resultFormat" value="${measure.resultFormat}" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr006">
			<td id="td011" class="tdLabelCls" style="width:30%;">
				<label>单位</label>	
			</td>
			<td id="td012" class="tdValueCls" style="width:70%;">
				<input id="resultUnit" name="resultUnit" value="${measure.resultUnit}" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr008" >
			<td colspan='2' style="padding: 5px">
				<span style="color:black">填写说明：</span></br>
				<span style="color:black">&nbsp;&nbsp;(1) 计算方式：统计图Y轴显示变量数量的运算方式，包括：求数量、求和、求平均值、求百分比，系统会根据变量类型自动提供可选项;</span></br>
				<span style="color:black">&nbsp;&nbsp;(2) 计算公式：设置运算结果的计算表达式，&lt;result&gt;代表默认运算结果，如显示运算结果除以100后的值，表达式为：&lt;result&gt;/100;</span></br>
				<span style="color:black">&nbsp;&nbsp;(3) 格式：运算结果的显示格式，如保留两位小数显示格式设置为：#.00;</span>
			</td>
		</tr>
		<tr id="tr007">	
			<td id="td013" class="cmdLayout">
				<button style="width:85px" class="x-btn ok-btn" type="button" onclick="saveData()">保存</button>
				<button style="width:85px" class="x-btn cancel-btn" type="button" onclick="Matrix.closeWindow()">取消</button>
			</td>
		</tr>
	</table>
</body>
</html>