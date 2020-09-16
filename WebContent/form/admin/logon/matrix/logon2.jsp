<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆22</title>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script> 
		if (window != top) {
			top.location.href = location.href;
		}
	   function login()
	   {
	   	  if(!MForm0.validate()){
	   	  	return false;
	   	  }
	   	  Matrix.convertFormItemValue('Form0');
	      document.getElementById('Form0').submit();
	   }
	</script>
	
	<style>
		
	</style>
</head>
<body scroll="no" style="background-color:#E8E8E8">
	<script> var MForm0=isc.MatrixForm.create({ID:"MForm0",name:"MForm0",position:"absolute",action:"<%=request.getContextPath()%>/logon/logon_logon.action",fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]});</script>
<Form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/logon/logon_logon.action"
	style="margin: 0px; width: 100%; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
	
			<div align="center" valing="middle">
				<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="center" valign="center">
							<table width="649"  class="logonbg_matrix" height="246" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td height="80px" style="height:80px">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td valign="middle"  align="right" >
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td style="width:150px"></td>
												<td colspan="2" style="height:20px">
													<%
														Object InvalidUser = request.getAttribute("InvalidUser");
														if (InvalidUser != null) {
													%>
													<div class="logonDIV_matrix" style="color:red;">无效用户!</div>
													<%}else{%>
													<%} %>
												</td>
											</tr>
											<tr>
												<td style="width:150px"></td>
												<td >
													<div class="logonDIV_matrix" style="margin-top:5px;color:#A3A1A2;padding-left:40px;">
														<img src="<%=request.getContextPath()%>/form/admin/logon/matrix/img/person.png">
														<!-- 用&nbsp;户&nbsp;名&nbsp;&nbsp; -->
														<div id="logonNameDiv" class="matrixInline" style="width:240px;height:32px;margin-left:10px;">
														</div>
														<script> 
															var logonName=isc.TextItem.create({
																ID:"MlogonName",
																name:"logonName",editorType:"TextItem",
																hint:"请您输入用户名",
																showHintInField: true,
																requiredMessage:"请您输入用户名",
																displayId:"logonNameDiv",position:"relative",width:"100%",
																required:true
															});
															MForm0.addField(logonName);
														</script>
													</div>
												</td>
												<td rowspan="2" style="width:150px">
													<div id="submitDiv" style="height:99px;width:99px;">
														<script>
															isc.ImgButton.create({
																ID:"submitBnt",
																position:"relative",
																displayId:"submitDiv",
															    width:99,				
																height:99,
																src:"[SKIN]/matrix/user/matrix/logon.jpg",
																click:"Matrix.showMask();login();Matrix.hideMask();"
															});
															isc.Page.setEvent(isc.EH.RESIZE,"submitBnt.redraw();",null);
															isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
																var _key = isc.Event.getKey();
																if(_key=="Enter"){
																	submitBnt.click();
																}
															});
														</script>
													</div>
												</td>
											</tr>
											<tr>
												<td style="width:150px"></td>
												<td >
													<div class="logonDIV_matrix" style="margin-top:5px;color:#A3A1A2;padding-left:40px;">
													<!-- 密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码&nbsp;&nbsp; -->	
														<img src="<%=request.getContextPath()%>/form/admin/logon/matrix/img/lock.png">
														<div id="passwordDiv" class="matrixInline"  style="width:240px;height:32px;margin-left:10px;">
														</div>
														<script> 
															var password=isc.PasswordItem.create({
																ID:"Mpassword",
																hint:"请您输入密码",
																requiredMessage:"请您输入密码",
																showHintInField: true,
																name:"password",editorType:"PasswordItem",
																displayId:"passwordDiv",position:"relative",width:"100%",
																required:true
															});
															
															MForm0.addField(password);
														</script>
													</div>
												</td>
											</tr>
											<tr>
												<td style="height:50px;" colspan="3" >&nbsp;</td>
											</tr>
											<tr>
												<td style="width:150px" colspan="3" ></td>
											</tr>
											 <tr>
												<td height="40" align="center" colspan="3">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</FORM>
		<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script>
	</body>
</html>
