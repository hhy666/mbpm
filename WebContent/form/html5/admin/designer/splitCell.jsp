<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>拆分表格</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">

	window.onload = function(){
		var colSpan = "${param.colSpan}";
		var rowSpan = "${param.rowSpan}";
		var isMergeBeforeSplit = "${param.isMergeBeforeSplit}";
		$('#mSplitColumnNum').val(colSpan);
		$('#mSplitRowNum').val(rowSpan);
		if(isMergeBeforeSplit=='true'){
			$('#MatirxMergeBeforeSplit').val('是');
		}else if(isMergeBeforeSplit=='false'){
			$('#MatirxMergeBeforeSplit').val('否');
		}
	}
	
	//确定
	function splitCell(){
		var mSplitColumnNum = $('#mSplitColumnNum').val();
		var mSplitRowNum = $('#mSplitRowNum').val();
		var isMergeBeforeSplit = $('#MatirxMergeBeforeSplit').val();
		var mcell = parent.isc.MH.mcell;
		mcell.newColumnNum = mSplitColumnNum;
		mcell.newRowNum = mSplitRowNum;
		parent.isc.MH.splitCellSubmit(mcell);
		Matrix.closeWindow();
	}

</script>
</head>
<body style="padding:5px">
	<table id="table001" style="width:100%;" name="table001" class="tableLayout">
		<tr id="tr001" name="tr001">
			<td id="td001" style="width:30%;" name="td001" class="tdLabelCls">
				<label class="label" id="label001" name="label001">
					列数
				</label>
			</td>
			<td id="td002" style="width:70%;text-align: left;" name="td002" class="tdValueCls">
				<input type="number" class="form-control" required="false" id="mSplitColumnNum" style="width:100%" name="mSplitColumnNum" value=""/>
			</td>
		</tr>
		<tr id="tr002" name="tr002">
			<td id="td003" style="width:30%;" name="td003" class="tdLabelCls">
				<label class="label" id="label002" name="label002">
					行数
				</label>
			</td>
			<td id="td004" style="width:70%;" name="td004" class="tdValueCls">
				<input type="number" class="form-control" required="false" id="mSplitRowNum" style="width:100%" name="mSplitRowNum" value=""/>
			</td>
		</tr>
		<tr id="tr004" name="tr004">
			<td id="td005" style="width:30%;" name="td005" class="tdLabelCls">
				<label class="label" id="label003" name="label003">
					拆分前合并单元格
				</label>
			</td>
			<td id="td006" style="width:70%;" name="td006" class="tdValueCls">
				<input readonly="readonly" class="form-control" id="MatirxMergeBeforeSplit" name="MatirxMergeBeforeSplit" type="text" />
			</td>
		</tr>
		<tr id="tr003" name="tr003">
			<td style="width:100%;"  class="cmdLayout" colspan="2">
				<button class="x-btn ok-btn" onclick="splitCell();">
					     <span>确定</span>
				</button>
				<button class="x-btn ok-btn" onclick="Matrix.closeWindow();">
					     <span>取消</span>
				</button>
			</td>
		</tr>
	</table>
</body>
</html>