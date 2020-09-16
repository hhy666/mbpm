<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>表单设计属性页面</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">
  function addProp(){
	  var cols = $('#cols').val();
	  var rows = $('#rows').val();
	  if(cols==null||cols.trim()==""||rows==null||rows.trim()==""){
		  Matrix.warn('行数列数不能为空！');
		  return false;
	  }
	  if(rows<=0||cols<=0){
		  Matrix.warn('行数列数必须大于0！');
		  return false;
	  }
	  debugger;
	  var newComponent = parent.isc.MFH.getNewComponent();
	  //newComponent.mtitle = "测试组件";
	  //newComponent.sid = "testcom001";

	  
	//添加表格
	  var data = {};
	  data.command = "create";
	  data.componentIndex = newComponent.mindex;
	  data.componentType = "table";
	  data.mtitle = "表格布局";
	  
	  data.parentId = newComponent.mparent.id;
	  //data.sid = "table001";
	  data.tdNum = $('#cols').val();
	  data.trNum = $('#rows').val();
	  data.maxColSpan = $('#maxColSpan').val();

	  var callbackFun = parent.isc.MH.getCreateCallback(newComponent);
	  parent.isc.MH.sendRequest(data,callbackFun);
	  
	  Matrix.closeWindow();
	  
  }
</script>
</head>
<body style="padding: 10px">
	<!-- 当前显示组件编码 -->
	<input type="hidden" id="componentId" name="componentId"/>
	<!-- 当前显示组件类型编码 -->
	<input type="hidden" id="componentTypeId" name="componentTypeId"/>
	<!-- 自定义组件类别编码 -->
	<input type="hidden" id="customTypeId" name="customTypeId"/>
	<table id="table001" style="width:100%;" name="table001" class="tableLayout">
		<tr id="tr001" name="tr001">
			<td id="td001" style="width:30%;" name="td001" class="tdLabelCls">
				<label class="label" id="label001" name="label001">
					表格行数
				</label>
			</td>
			<td id="td002" style="width:70%;text-align: left;" name="td002" class="tdValueCls">
				<input type="number" class="form-control" required="false" id="rows" style="width:100%" name="rows" value="6"/>
			</td>
		</tr>
		<tr id="tr002" name="tr002">
			<td id="td003" style="width:30%;" name="td003" class="tdLabelCls">
				<label class="label" id="label002" name="label002">
					表格列数
				</label>
			</td>
			<td id="td004" style="width:70%;" name="td004" class="tdValueCls">
				<input type="number" class="form-control" required="false" id="cols" style="width:100%" name="cols" value="4"/>
			</td>
		</tr>
		<tr id="tr004" name="tr004">
			<td id="td005" style="width:30%;" name="td005" class="tdLabelCls">
				<label class="label" id="label003" name="label003">
					网格最大列数
				</label>
			</td>
			<td id="td006" style="width:70%;" name="td006" class="tdValueCls">
				<select id="maxColSpan" name="maxColSpan" class="form-control select2-accessible">
					<option value="10">8</option>
					<option value="10">10</option>
					<option value="12" selected>12</option>
					<option value="14">14</option>
					<option value="16">15</option>
					<option value="16">16</option>
					<option value="24">24</option>
				</select>
			</td>
		</tr>
		<tr id="tr003" name="tr003">
			<td style="width:100%;"  class="cmdLayout" colspan="2">
				<button class="x-btn ok-btn" onclick="addProp();">
					     <span>确定</span>
				</button>
				<button class="x-btn ok-btn" onclick="Matrix.closeWindow();">
					     <span>取消</span>
				</button>
			</td>
		</tr>
	</table>
	
	 
 </body>				