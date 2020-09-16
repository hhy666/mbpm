<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script type="text/javascript">
	function onCatalogIdDialogClose(data){
		if (data == null){
			return true;
		}
		data = isc.JSON.decode(data);
		if (data['id'] != null) {
			document.getElementById('catalogName').value = data.text;
			document.getElementById('catalogId').value = data.id;
		}
	}
	
	function saveSelectItems(){
		var data=[];
		var catalogId=document.getElementById("catalogId").value;
		var catalogName=document.getElementById("catalogName").value;
		var dataType=document.getElementById("dataType").value;
		var dataTypeVal=$("#dataType option:selected").text();
		if(catalogId!=null&&catalogId!=""&&catalogId.length>0){
			data.dataType=dataType;
			data.codeId=catalogId;
			data.info=dataTypeVal+'('+catalogId+')';
			data.infoStr=dataTypeVal+'('+catalogName+')';
			Matrix.closeWindow(data);
		}else{
			Matrix.warn("请选择代码!");
		}
	}
</script>
</head>
<body>
	<form id="form0" name="form0" method="post"	action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="catalogId" name="catalogId" />
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	类型
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="title_div" class="matrixInline" style="width: 100%">
						<select class="form-control select2-accessible" id="dataType" name="dataType"  style="width:90%">
							<option value="code" selected>基本代码</option>
							<option value="custom">自定义代码</option>
						</select>	
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id2" name="j_id2">
						基本代码
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="name_div" class="matrixInline" style="width:100%">
						<input class="form-control" type="text" name="catalogName" id="catalogName" style="display:inline;WIDTH:90%;HEIGHT:30px;" readonly="readonly" >
						<img id="catalogIdDialog" style="VERTICAL-ALIGN: middle;display:inline" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
					</div>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="2" style="background: #f2f2f2">
					<div id="button003_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存" onclick="saveSelectItems()">
					</div>
					<div id="button004_div" class="matrixInline">
						<input type="button" class="x-btn cancel-btn " value="关闭" onclick="Matrix.closeWindow()">
					</div>
					<script type="text/javascript">
						$("#catalogIdDialog").click(function(){
							layer.open({
								type:2,
								title:['选择代码类别'],
								area:['85%','100%'],
								content:'<%=request.getContextPath()%>/common/commonCode_loadSelectCodeTreePage.action?iframewindowid=CatalogIdDialog'
							});		
						});
					</script>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>