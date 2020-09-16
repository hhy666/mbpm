<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>高级属性页面</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="">
		font{
			font-size:14px;
			margin-left:10px;
			font-weight:bold;
		}
		#td001{
			width:100%;
			height:30px;
			background:#F8F8F8;
		}
	</style>
	<script type="text/javascript">
	//页面失去焦点事件
  	window.onblur = function(){
		var synJson = Matrix.formToObject('form0');
		if(synJson!=null){
			var url = "<%=request.getContextPath()%>"+"/editor/process_updateAdvancePropertyInfo.action";
			Matrix.sendRequest(url,synJson,function(){
				return true;
			});
		}
	}

	//页面初始事件
	window.onload=function(){
		//复选框选中
		$("input:checkbox[name='checkBoxGroup001_0']").on('ifChecked', function(event){		
			$('#checkBoxGroup001_0').val(1);
			window.focus();
		});
		
		//复选框取消选中
		$("input:checkbox[name='checkBoxGroup001_0']").on('ifUnchecked', function(event){
			$('#checkBoxGroup001_0').val(0);
			window.focus();
		});
	}
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
	<form id="form0" name="form0" eventProxy="Mform0" method="post"action=""
		style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="entityId" id="entityId" value="${param.entityId }"/>
		
		<table id="table001" class="tableLayout" style="width: 100%;">
			<tr id="tr001">
				<td id="td001" class="tdLabelCls" style="width: 100%;text-align:left;"><font>高级属性</font></td>
			</tr>
			<tr id="tr002">
				<td id="td002" style="padding-left: 5px;padding-top: 10px;border-style:none;">
					<div style="display: inline-table;" name="checkBoxGroup001_0_div" id="checkBoxGroup001_0_div" >
						<input type="checkbox" class="box" name="checkBoxGroup001_0" id="checkBoxGroup001_0" value="${process.includeStartNode=='false'?'0':'1'}" ${process.includeStartNode=='false'?'':'checked'}/>
					</div>
					<label name="label0032" id="label0032" class="control-label ">
						当前流程是否包含启动节点
					</label>	
				</td>
			</tr>
		</table>	
	</form>
</div>
</body>
</html>