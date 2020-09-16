<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script> 
		if (window != top) {
			top.location.href = location.href;
		}
	   function login()
	   {
	      if(document.all.logonName.value=="")
	      {
	        isc.warn("请输入用户名");
	        return false;
	      }
	     
	   }
	</script>
	
	<style>
		
	</style>
</head>
	<body scroll="no">
<FORM action="<%=request.getContextPath()%>/logon/logon_logon.action" method=post onsubmit="return login()">
			<div align="center" valing="middle">
				<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="center" valign="center">
							<table width="1024"  class="logonbg" height="637" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td height="100px">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td valign="middle"  align="right" >
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td style="width:400px"></td>
												<td >
													<%
														Object InvalidUser = request.getAttribute("InvalidUser");
														if (InvalidUser != null) {
													%>
													<font class="logonDIV" style="color:red;">无效用户!</font>
													<%}else{%>
														&nbsp;
													<%} %>
												</td>
											</tr>
											<tr>
												<td style="width:400px"></td>
												<td >
													<div class="logonDIV" style="margin-top:5px;">
														用&nbsp;户&nbsp;名&nbsp;&nbsp;
														<input name="logonName" type="text" size="12" style="width:180"/>
													</div>
												</td>
											</tr>
											<tr>
												<td style="height:10px" colspan="2" >&nbsp;</td>
											</tr>
											<tr>
												<td style="width:390px"></td>
												<td >
													<div class="logonDIV" style="margin-top:5px;">
														密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码&nbsp;&nbsp;
														<input name="password" type=password size="12" style="width:180"/>
													</div>
													
												</td>
											</tr>
											<tr>
												<td style="height:20px" colspan="2" >&nbsp;</td>
											</tr>
											<tr>
												<td style="width:390px"></td>
												<td>
													<table>
														<tr>
															<td width="64px">
																&nbsp;
															</td>
															<td>
																<input type="submit" name="Submit" class="logonSubmitBnt" value=""/>
															</td>
															<td width="1px">
																&nbsp;
															</td>
															<td>
																<input type="button" name="Submit" class="logonCancelBnt" value=""/>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											 <tr>
												<td height="40" align="center" colspan="2">
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
		
		
	</body>
</html>
