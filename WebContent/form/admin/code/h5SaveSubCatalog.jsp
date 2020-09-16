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
<title>添加或更新子目录</title>
<script type="text/javascript">
	function addOrUpdateCodeSubmit(){
		//处理 id 和 mid 
		var result = Matrix.validateForm('Form0');
		if(result){
			var form0 = document.getElementById("Form0");
			var id = document.getElementById("id").value;
			var name = document.getElementById("name").value;
			var desc = document.getElementById("desc").value;
			var uuid = document.getElementById("uuid").value;
			var parentNodeId = document.getElementById("parentNodeId").value;
			var isEnable = document.getElementById("isEnable").value;
			var type = document.getElementById("type").value;
			var url = "<%=path%>/code/code_validataForm.action?id="+id+"&name="+name+"&uuid="+uuid;
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
						var oType = document.getElementById("oType").value;
						var form0 = document.getElementById('Form0'); 
						if(oType!=null&&"add"==oType){//添加
							var url = "<%=path%>/code/code_addCode.action";
							form0.action = url;
						  	form0.submit();
						}else if(oType!=null&&"update"==oType){//更新
							var url = "<%=path%>/code/code_updateCode.action";
							var data = {'uuid':uuid,'id':id,'name':name,'desc':desc,'parentNodeId':parentNodeId,'type':type,'isEnable':isEnable};
							Matrix.sendRequest(url,data,function(data){
								var json = isc.JSON.decode(data.data);
								if(json.message){
									parent.parent.refreshTree();
									parent.parent.Matrix.info("修改成功！");
								}else{
									parent.parent.Matrix.warn("修改失败!");
								}
							});
						}
					}
				}
			});
		}else{
			return false;
		}
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="padding:10px;margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="validateType" name="validateType" value="jquery">
		<input type="hidden" id="isEnable" name="isEnable" value="${codeNode.isEnable}">
		<input type="hidden" id="type" name="type" value="${param.type}">
		<input type="hidden" id="tenantId" name="tenantId" value="${codeNode.tenantId}" />
		<input type="hidden" id="order" name="order" value="${codeNode.order}" />
		<input type="hidden" id="oType" name="oType" value="${param.oType}" />
		<input type="hidden" id="parentUUID"  name="parentUUID" value="${codeNode.parentUUID}" />
		<input type="hidden" id="uuid" name="uuid" value="${codeNode.uuid}" />
		<input type="hidden" id="parentNodeId"  name="parentNodeId" value="${param.parentNodeId}"/>
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	编码
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div class="matrixInline" style="width: 100%">
						<input class="form-control" required type="text" name="id" id="id" style="WIDTH:90%;HEIGHT:30px;" value="${codeNode.id}" >
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
					<div class="matrixInline" style="width:100%">
						<input class="form-control" required type="text" name="name" id="name" style="WIDTH:90%;HEIGHT:30px;" value="${codeNode.name}" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;height: 72px">
					<label id="j_id3" name="j_id3">
						描述
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;height: 30%;height: 72px">
					<div class="matrixInline" style="width:90%;height: 100%">
						<textarea class="form-control" id="desc" name="desc" rows="1" cols="1" style="width: 100%;height: 100%;resize:none;outline:none;">${codeNode.desc}</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="2" style="vertical-align: top;text-align: center">
					<div id="button003_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存" onclick="addOrUpdateCodeSubmit()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>