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
	<script type="text/javascript">
	
		window.onload = function(){
			var isEnableSelect = document.getElementById('isEnable');
			var isEnable = "${codeNode.isEnable}";
			if(isEnable==1){
				isEnableSelect.options[0].selected = true;
			}else if(isEnable==2){
				isEnableSelect.options[1].selected = true;
			}else{
				isEnableSelect.options[0].selected = true;
			}
		}
	
		function save(){
			var mId = $('#mId').val();
			var name = $('#name').val();
			var desc = $('#desc').val();
			var isEnable = $('#isEnable').val();
			var type = $('#type').val();
			var uuid = "${uuid}";
			var data = {'id':mId,'name':name,'desc':desc,'isEnable':isEnable,'type':type,'uuid':uuid};
			var json = isc.JSON.encode(data);
			var url = "<%=path%>/code/code_asynUpdateCodeItem.action";
			Matrix.sendRequest(url,data,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
			    var message = callbackJson.message;
				    if(message==true){
				    	 parent.parent.refreshTree();
				   		 var uType = callbackJson.type;
				      	  if(uType==2){
				      		parent.parent.Matrix.info('更新基本类型成功！');
				      	  }else if(uType==3){
				      		parent.parent.Matrix.info('更新自定义类型成功！');
				     	  }
				    }else if(message=='repeat'){
				    	parent.parent.Matrix.warn('编码重复，请重新修改!');
				    }else{
				    	parent.parent.Matrix.warn('更新失败!');
				    }
			});
		}
	</script>
<title>更新基本类型信息</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="padding:10px;margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="validataForm" name="validataForm" value="jquery">
		<input type="hidden" id="type" name="type" value="${codeNode.type}">
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	编码
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div id="title_div" eventProxy="Mform0" class="matrixInline" style="width: 100%">
						<input class="form-control" required type="text" name="mId" id="mId" style="WIDTH:90%;HEIGHT:30px;" value="${codeNode.id}" >
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
					<div id="urlValue_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" required type="text" name="name" id="name" style="WIDTH:90%;HEIGHT:30px;" value="${codeNode.name}" >
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
					<div class="matrixInline" style="width:100%">
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
					<div  class="matrixInline" style="width:90%;height: 100%">
						<textarea class="form-control" id="desc" name="desc" rows="1" cols="1" style="width: 100%;height: 100%;resize:none;outline:none;">${codeNode.desc}</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td class="cmdLayout" colspan="2" style="vertical-align: top;text-align: center;">
					<div id="button003_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存" onclick="save()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>