<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>编辑参数对象成员</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="/moffice/matrix.rform"
			style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
			enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="name" id="name" value="${param.name }" />
			<input type="hidden" name="tddid" id="tddid" value="${param.tddid }" />
			<input type="hidden" name="editFlag" id="editFlag" value="${param.editFlag }"/>
			<table id="table001" class="tableLayout" style="width: 100%;">
				<tr id="tr001">
					<td id="td001" class="tdLabelCls" style="width: 25%;">
						<label id="label001" name="label001" id="label001">
							名称：
						</label>
					</td>
					<td id="td002" class="tdValueCls" style="width: 75%;">
						<div id="input001_div" style="vertical-align: middle;">
							<input id="input001" name="input001" type="text" value="${schemaElement.name}" class="form-control" style="height:100%;width:100%;"/>
						</div>
					</td>
				</tr>
				<tr id="tr002">
					<td id="td003" class="tdLabelCls" style="width: 25%;">
						<label id="label002" name="label002" id="label002" >
							类型：
						</label>
					</td>
					<td id="td004" class="tdValueCls" style="width: 75%;">
						<div id="comboBox001_div" style="vertical-align: middle;">
							<select id="comboBox001" name="comboBox001" value="${schemaElement.type==''||schemaElement.type==null?'STRING':schemaElement.type}" class="form-control" style="height:100%;width:100%;">
		                       <option value="STRING" ${schemaElement.type == 'STRING' ? "selected" : ""}>String</option>
		                       <option value="FLOAT" ${schemaElement.type == 'FLOAT' ? "selected" : ""}>Float</option>
		                       <option value="INTEGER" ${schemaElement.type == 'INTEGER' ? "selected" : ""}>Integer</option>
		                       <option value="LONG" ${schemaElement.type == 'LONG' ? "selected" : ""}>Long</option>
		                       <option value="DATETIME" ${schemaElement.type == 'DATETIME' ? "selected" : ""}>DateTime</option>
		                       <option value="BOOLEAN" ${schemaElement.type == 'BOOLEAN' ? "selected" : ""}>Boolean</option>
		                    </select>
						</div>
					</td>
				</tr>
				<tr id="tr003">
					<td id="td005" class="tdLabelCls" style="width: 25%;text-align:center;">
						<label id="label003" name="label003" id="label003">
							描述：
						</label>
					</td>
					<td id="td006" class="tdValueCls" style="width: 75%;">
						<div id="inputTextArea001_div">
							<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;">${schemaElement.description}</textarea>
						</div>
					</td>
				</tr>
				<tr id="tr004">
					<td id="td007" colspan="2" rowspan="1" class="cmdLayout">
						<input type="button" class="x-btn ok-btn" name="确认" value="确认" id="submit" >
						<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
						<script type="text/javascript">
					        $(".ok-btn").on("click",function(){
					        	var name = Matrix.getFormItemValue('input001');
					    		var flag = true;
					    		if(name==""||name==null){
					    			Matrix.warn('参数对象成员不能为空！');
					    			flag = false;
					    			return flag;
					    		}else{
					    			var editFlag = Matrix.getFormItemValue('editFlag');
					    			if(editFlag=='add'){
					    				var data = parent.Matrix.getGridData('DataGrid001');   //所有数据
					    				if(data!=null&&data.length>0){
					    				   for(var i=0;i<data.length;i++){
					    					 if(name == data[i].name){
					    						Matrix.warn('参数对象成员名称已经存在！');
					    						flag = false;
					    						return flag;
					    					 }
					    					}
					    				}
					    			}
					    		}
					    		if(flag){
					    			var synJson = Matrix.formToObject('form0'); 
					    			if(synJson!=null){
					    				var url = "<%=request.getContextPath()%>"+"/editor/process_saveDelarationChild.action";
					    				Matrix.sendRequest(url,synJson,function(){
					    					parent.Matrix.refreshDataGridData('DataGrid001');//刷新参数对象成员数据表格
					    				    Matrix.closeWindow();
					    				});
					    			}
					    		}
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
