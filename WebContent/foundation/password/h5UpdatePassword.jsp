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
<title>修改密码</title>
<script type="text/javascript">
	//去除字符串中间的空格
	function splitString(str){
		var strArr = str.split('');
		var string = '';
		for(var i=0;i<str.length;i++){
			if(strArr[i]!=' '){
				string+=strArr[i];
			}
		}
		return string;
	}

	function save(){
		if(!Matrix.validateForm('Form0')){
			return;
		}
		var oldPwd = document.getElementById("oldPassword").value;
		var newPwd = document.getElementById("newPassword").value;
		var reNewPwd = document.getElementById("repeatNewPassword").value;
		var oldStr = splitString(oldPwd);
		var newStr = splitString(newPwd);
		var reNewStr = splitString(reNewPwd);
		if(oldStr.length<oldPwd.length){
			Matrix.warn("原密码中不能包含空格!");
			return;
	    }
		if(newStr.length<newPwd.length){
			Matrix.warn("新密码中不能包含空格!");
			return;
		}
		if(reNewStr.length<reNewPwd.length){
			Matrix.warn("重复密码中不能包含空格!");
			return;
		}
		if(oldPwd==newPwd){
			Matrix.warn("原密码与新密码相同!");
		    return;
		}else{
			if(newStr!=reNewStr){
				Matrix.warn("重复密码与新密码不一致!");
				return;
			}else{
				var newData = "{'oldPassword':'"+oldStr;
				newData+="','newPassword':'"+newStr; 
				newData+="'}";
				var url = '<%=request.getContextPath()%>/password/passwordAction_savePassword.action';
				var synJson = isc.JSON.decode(newData);
				Matrix.sendRequest(url,synJson, function(data){
	          		var json = data.data;
	          		if(json){
	          			var result = isc.JSON.decode(json);
	          			if(result.result==true){
	          				Matrix.success(result.message);
	          			}else{
	          				Matrix.warn(result.message);
	          			}
	          		}
        		});
			}
		}
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"  action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="validateType" name="validateType" value="jquery">
		<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
			<script>
			    $(document).ready(function () {
			        var ifm = $(".J_iframe");
			        ifm.height(document.documentElement.clientHeight);
				    $('#TabContainer001 a[href="#TabPanel001"]').tab('show');
			    });
			    window.onresize = function () {
			        var ifm = $(".J_iframe");
			        ifm.height(document.documentElement.clientHeight);
			    }
			</script>
			<ul id="TabContainer001" class="nav nav-tabs disable" style="position: relative;height: 30px"/>
				<li>
					<a id="panel001" href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()">修改密码</a>
				</li>
			</ul>
			<div style="padding: 5px">
				<table class="maintain_form_content" style="width:100%;height:100%">
					<tr>
						<td class="maintain_form_label2" style="width: 30%;">
							<label id="j_id0" name="j_id0">
							 	原密码
							</label>
						</td>
						<td class="tdLayout" style="width: 70%;">
							<div id="title_div" class="matrixInline" style="width: 100%">
								<input required class="form-control" required type="password" name="oldPassword" id="oldPassword" style="display:inline;WIDTH:70%;HEIGHT:30px;">
								<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000;display:inline">
		                    		*
		               			</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="maintain_form_label2" style="width: 30%;">
							<label id="j_id2" name="j_id2">
								新密码
							</label>
						</td>
						<td class="tdLayout" style="width: 70%;">
							<div id="urlValue_div" class="matrixInline" style="width:100%">
								<input required class="form-control" required type="password" name="newPassword" id="newPassword" style="display:inline;WIDTH:70%;HEIGHT:30px;">
								<span id="validateIdMsg" style="display:inline;width: 20px; height: 20px; color: #FF0000">
		                    		*
		               			</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="maintain_form_label2" style="width: 30%;height: 36px">
							<label id="j_id3" name="j_id3">
								重复新密码
							</label>
						</td>
						<td class="tdLayout" style="width: 70%;height: 36px">
							<div class="matrixInline" style="width:100%;">
								<input required class="form-control" required type="password" name="repeatNewPassword" id="repeatNewPassword" style="display:inline;WIDTH:70%;HEIGHT:30px;">
								<span id="validateIdMsg" style="display:inline;width: 20px; height: 20px; color: #FF0000;" >
		                    		*
		               			</span>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;padding-top: 10px;">
							<div id="button003_div" class="matrixInline">
								<input type="button" class="x-btn ok-btn " value="提交" onclick="save()">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="content-main" class="tab-content" style="display:none; border-color: #e7eaec;   -webkit-border-image: none;    -o-border-image: none;    border-image: none;    border-style: solid;    border-width: 1px;    border-top: 0px;width:100%;height:100%">
			<div class="tab-pane fade in active" id="TabPanel001" style='padding: 3px 3px 0px 3px;'></div>
		</div>
	</form>
</body>
</html>