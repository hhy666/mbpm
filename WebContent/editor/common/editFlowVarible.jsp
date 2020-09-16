<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta charset="UTF-8">
<head>
	<title>编辑流程变量</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script type="text/javascript">
	</script>
</head>

<body>
<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/process_saveOrUpdateFlowVarible.action"
	style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="idx" id="idx" value="${param.index }" /> 

	<table id="table001" class="tableLayout" style="width:100%;height:100%" >
	 	<tr>
			<td class="tdLabelCls" style="width:20%">
				<label id="j_id12" name="j_id12">
					编码：
				</label>
			</td>
			<td class="tdLabelCls" style="width:80%">
				<div id="processVarId_div">
					 <input type="text" id="processVarId" name="processVarId" value="${varible.name}"  class="form-control">
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabelCls" style="width:20%">
				<label id="j_id1" name="j_id1">
					名称：
				</label>
			</td>
			<td class="tdLabelCls" style="width:80%">
				<div id="processVarName_div">
					 <input type="text" id="processVarName" name="processVarName" value="${varible.description}"  class="form-control">
				</div>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="maintain_form_label2" colspan="1" style="width:20%;">
				<label id="j_id4" name="j_id4" >
					类型：
				</label>
			</td>
			<td id="td006" class="tdLabelCls"  style="width:80%;">
				<div id="type_div" style="vertical-align: middle;">
					<select id="type" name="type" value="${varible.dataType.type=='STRING'?'1':varible.dataType.type=='FLOAT'?'2':varible.dataType.type=='INTEGER'?'3':varible.dataType.type=='LONG'?'4':varible.dataType.type=='DATATIME'?'5':varible.dataType.type=='BOOLEAN'?'6':'1'}" 
					class="form-control" style="height:100%;width:100%;">
					   <option value="1" ${varible.dataType.type=='STRING' ? "selected" : ""}>String</option>
                       <option value="2" ${varible.dataType.type=='FLOAT' ? "selected" : ""}>Float</option>
                       <option value="3" ${varible.dataType.type=='INTEGER' ? "selected" : ""}>Integer</option>
                       <option value="4" ${varible.dataType.type=='LONG' ? "selected" : ""}>Long</option>
                       <option value="5" ${varible.dataType.type=='DATATIME' ? "selected" : ""}>DateTime</option>
                       <option value="6" ${varible.dataType.type=='BOOLEAN' ? "selected" : ""}>Boolean</option>
                    </select>
				</div>
			</td>
		</tr>
		<tr>
			<td class="cmdLayout" colspan="2" style="width:100%;text-align:center;">
				<input type="button" class="x-btn ok-btn" name="保存" value="保存" id="submit" >
				<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
				<script type="text/javascript">
			        $(".ok-btn").on("click",function(){
			        	var jsonObj = Matrix.formToObject('form0');
						Matrix.send('form0',jsonObj,function(data){
							if(data!=null && data.data!=''){
								var json = isc.JSON.decode(data.data);
								if(json.result=='true'){
									//保存或者修改成功   关闭窗口
									var jsonData = {};
									jsonData.data = "refresh";
									Matrix.closeWindow(jsonData);
								}else if(json.result=='echo'){
									parent.Matrix.warn('流程变量名称重复!');
								}
							}
						});
			        });
			        
			        $(".cancel-btn").on("click",function(){
			        	Matrix.closeWindow();
			        })
				</script>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
