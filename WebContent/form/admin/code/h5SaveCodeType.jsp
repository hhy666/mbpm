<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>添加基本或自定义类型</title>
<script type="text/javascript">
	function addCodeSubmit(){
		var form0 = document.getElementById("Form0");
		var name = document.getElementById("name").value;
		var desc = document.getElementById("desc").value;
		var id = document.getElementById("id").value;
		var isEnable = document.getElementById("isEnable").value;
		var type = document.getElementById("type").value;
		var parentNodeId = document.getElementById("parentNodeId").value;
		var url = "<%=path%>/code/code_validataForm.action?id="+id+"&name="+name;
		Matrix.sendRequest(url,null,function(data){
			if(data!=null){
				var json = isc.JSON.decode(data.data);
				if(json.idRepeat==false&&json.nameRepeat==false){
					Matrix.warn("编码与名称重复!");
					return false;
				}else if(json.idRepeat==true&&json.nameRepeat==false){
					Matrix.warn("名称重复!");
					return false;
				}else if(json.idRepeat==false&&json.nameRepeat==true){
					Matrix.warn("编码重复!");
					return false;
				}else if(json.idRepeat==true&&json.nameRepeat==true){
					var src = "<%=path%>/code/code_addCode.action";
					form0.action = src;
					form0.submit();
				}
			}
		});
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="padding:10px;margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="validateType" name="validateType" value="jquery">
		<input type="hidden" id="type" name="type" value="${param.type}">
		<input type="hidden" id="parentNodeId"  name="parentNodeId" value="${param.parentNodeId}"/>
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	编码
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="title_div" class="matrixInline" style="width: 100%">
						<input class="form-control" required type="text" name="id" id="id" style="WIDTH:90%;HEIGHT:30px;" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id2" name="j_id2">
						名称
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="name_div" class="matrixInline" style="width:100%">
						<input class="form-control" required type="text" name="name" id="name" style="WIDTH:90%;HEIGHT:30px;" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id2" name="j_id2">
						状态
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="urlValue_div" class="matrixInline" style="width:100%">
						<select class="form-control select2-accessible" id="isEnable" name="isEnable"  style="width:100px">
							<option value="1">启用</option>
							<option value="2">禁用</option>
						</select>					
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;height: 72px">
					<label id="j_id3" name="j_id3">
						描述
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;height: 72px">
					<div  class="col-md-12 input-group " style="width: 100%;height: 100%">
						<textarea class="form-control" id="desc" name="desc" rows="1" cols="1" style="resize:none;outline:none;width:90%;height: 100%"></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="2" style="text-align: center;padding-top: 10px">
					<div id="button003_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存" onclick="addCodeSubmit()">
					</div>
				</td>
			</tr>
		</table>
</body>
</html>