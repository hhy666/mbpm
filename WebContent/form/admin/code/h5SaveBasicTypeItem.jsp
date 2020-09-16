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
<title>基本类型添加或更改部件信息</title>

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
			
			//如果为修改则看不见保存并继续
			if("${update}"){
				document.getElementById('button002_div').style.display = 'none';
			}
		}
		
		function submitByButton(temp){
			var result = Matrix.validateForm('Form0');
			if(result){
				var flag = false;
				var addData = null;
				var oType = "${param.oType}";
				var id = document.getElementById('mId').value;
				var name = document.getElementById('name').value;
				var isEnable = document.getElementById('isEnable').value;
				var uuid = document.getElementById('uuid').value;
				if(oType=="add"){//添加
					addData = {'id':id,'name':name,'isEnable':isEnable,'flag':flag,'uuid':uuid};
				}else if(oType=="update"){//更新
					addData = {'id':id,'name':name,'isEnable':isEnable,'uuid':uuid,'flag':flag,'uuid':uuid};
				}
				var url = "<%=path%>/code/code_validateCodeId.action";
				var parentUUID = document.getElementById('parentUUID').value;
				var type = document.getElementById('type').value;
				var validateJson = {'id':id,'name':name,'uuid':uuid,'parentUUID':parentUUID,'type':type};
				Matrix.sendRequest(url,validateJson,function(data){
					var dataStr = data.data;
					if(dataStr!=null){
						var dataJson = isc.JSON.decode(dataStr);
						var message = dataJson.message;
						var sign = dataJson.sign;
						if(message==true && sign==true){   //验证通过
							if(temp=='1'){
								Matrix.closeWindow(addData, oType);	
							}else if(temp=='2'){
								if(oType=='update'){
									parent.onUpdateClose(addData,oType);
								}else if(oType=='add'){
									parent.onAddClose(addData,oType);
								}
								document.getElementById('mId').value ='';
								document.getElementById('name').value = '';
							}
						}else if(message==false && sign==false){   //选项值和选项显示值都重复
							Matrix.warn("选项值和选项显示值重复！");
						}else if(message==true && sign==false){        //选项显示值重复
							Matrix.warn("选择显示值重复！");
						}else if(message==false && sign==true){       //选择值重复
							Matrix.warn("选择值重复！");
						}
					}
				});
				
			}
		}
		
	</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="validateType" id="validateType" value="jquery"/>
		<input type="hidden" name="uuid" id="uuid" value="${codeNode.uuid}"/>
		<input type="hidden" name="type" id="type" value="${codeNode.type}"/>
		<input type="hidden" name="oType" id="oType" value="${param.oType}"/>
		<input type="hidden" name="parentUUID" id="parentUUID" value="${codeNode.parentUUID}"/>
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	选项值
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div class="matrixInline" style="width: 100%">
						<input class="form-control" required type="text" name="mId" id="mId" style="WIDTH:90%;HEIGHT:30px;" value="${codeNode.id}" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="maintain_form_label2" style="width: 30%;">
					<label id="j_id2" name="j_id2">
						选项显示值
					</label>
				</td>
				<td class="tdLayout" style="width: 70%;">
					<div class="matrixInline" style="width:100%">
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
				<td class="cmdLayout" colspan="2" style="background: #f2f2f2">
					<div id="button001_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存" onclick="submitByButton('1')">
					</div>
					<div id="button002_div" class="matrixInline">
						<input type="button" class="x-btn ok-btn " value="保存并继续" onclick="submitByButton('2')">
					</div>
					<div id="button003_div" class="matrixInline">
						<input type="button" class="x-btn cancel-btn " value="关闭" onclick="Matrix.closeWindow()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>