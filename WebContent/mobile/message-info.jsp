<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息内容页面</title>
<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
 <script src='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></script>

<link href="<%=path %>/monitor/css/templateCss/default.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/monitor/css/templateCss/default1.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/monitor/css/templateCss/skin.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/monitor/css/templateCss/fck_editorarea4Show.css" rel="stylesheet" type="text/css">
<style type="text/css">
.browse_class span {
	color: blue;
}
.xdTableHeader TD {
	min-height: 10px;
}
.radio_com {
	margin-right: 0px;
}
.xdTextBox {
	BORDER-BOTTOM: #dcdcdc 1pt solid;
	min-height: 20px;
	TEXT-ALIGN: left;
	BORDER-LEFT: #dcdcdc 1pt solid;
	BACKGROUND-COLOR: window;
	DISPLAY: inline-block;
	WHITE-SPACE: nowrap;
	COLOR: windowtext;
	OVERFLOW: hidden;
	BORDER-TOP: #dcdcdc 1pt solid;
	BORDER-RIGHT: #dcdcdc 1pt solid;
}
.xdRichTextBox {
	font-size: 12px;
	BORDER-BOTTOM: #dcdcdc 1pt solid;
	TEXT-ALIGN: left;
	BORDER-LEFT: #dcdcdc 1pt solid;
	BACKGROUND-COLOR: window;
	FONT-STYLE: normal;
	min-height: 20px;
	display: inline-block;
	VERTICAL-ALIGN: bottom !important;
	WORD-WRAP: break-word;
	COLOR: windowtext;
	BORDER-TOP: #dcdcdc 1pt solid;
	BORDER-RIGHT: #dcdcdc 1pt solid;
	TEXT-DECORATION: none;
}
#mainbodyDiv div,#mainbodyDiv input,#mainbodyDiv textarea,#mainbodyDiv p,#mainbodyDiv th,#mainbodyDiv td,#mainbodyDiv ul,#mainbodyDiv li{
	font-family: inherit;
}

#contentText > p :not(span){
	text-aglin:center;
}
.view-bulletin-title {
	padding: 20px 0px 10px 0px;
	font-size: 16px;
	line-height: 24px;
	font-family: 黑体, Arial, Helvetica;
}

</style>
</head>
<body scroll="no" style="height:96%;">
<div class="scrollList" id="mainbodyDiv" style="display: block; visibility: visible;">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">		
	<tbody><tr>
		<td width="100%" height="100%" align="center" class="body-bgcolor" valign="top">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tbody><tr height="100%">
					<td>
						<table width="100%" height="100%" align="center" class="body-detail margin-auto" border="0" cellspacing="0" cellpadding="0">
							<tbody>		
							<tr>
								<td valign="top">
									<div id="printThis">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										    <tbody>
										     <tr>
												 <td height="30" >
													 <table width="100%" border="0" cellspacing="0" cellpadding="0">
														 <tbody>
															<tr>
															  <td width="35">&nbsp;</td>
															  <td width="90%" align="center" style="color:#007aff;" class="view-bulletin-title">${subjectValue}</td>
															  <td width="35">&nbsp;</td>
															 </tr>
													     </tbody>
													 </table>
												 </td>
											</tr>
							
											<tr>
												<td class="padding35" id="paddId" >
												<table width="100%" height="100%" cellspacing="0" cellpadding="0">
													  		<tbody>																							
																<tr>
																	<td id='show1' width="30%" align="left" style="font-weight: bold;" class="font-12px" nowrap="nowrap">接收时间：&nbsp;&nbsp;</td>
																	<td id='show2' width="70%" class="font-12px">${createdDate}</td>
																</tr>
																<tr>
																	<td>&nbsp;</td>
																</tr>
															</tbody>
													 </table>															
												</td>
											</tr>
		
											<tr>
												<td width="100%" height="100%" id="contentTD" valign="top" style="padding-bottom: 6px;" >
										          	<div style="height: 100%;">
										            	<div style="display: none;"><input name="bodyType" id="bodyType" type="hidden" value="HTML"></div>
														<div id="htmlContentDiv">
															<table align="center" class="body-detail-HTML" id="col-contentTable" border="0" cellspacing="0" cellpadding="0">
															  <tbody><tr>
															     <td class="padding355">
															     	<div id="inputPosition" style="width: 0px; height: 0px;"></div>
																	<div class="contentText" id="content" style="text-aglin:center;">
																 	   ${contentValue}
																    </div>
																  </td>
															  <tr>
															  </tr></tbody>
															 </table>
															</div
										            </div>
										            <style>   
										            .padding355 {
													    padding: 0px 35px 35px 35px;
													}                                         
                                                    .contentText p, td, UL, LI, div, a, ol, pre{
														font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
														font-size: 12px;
														line-height: 1.5;
														#line-height: 1.5;
														_line-height: 1.5;
														word-break:break-all;
													}
													.contentText {
													    padding: 0px;
													    margin: 0px;
													    background-color: #FFFFFF;
													    height: 100%;
													    font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
													    font-size: 12px;
													    min-height: 300px;
													    height: auto !important;
													    height: 500px;
													}
													.body-detail, .body-detail-HTML, .body-detail-form {
													    background: #FFFFFF;
													    border: solid 0px #A0BEC8;
													    width: 100%;
													    margin-bottom: 0px;
													    margin-left: auto;
													    margin-right: auto;
													}
                                                    </style>                                            
												</td>
											</tr>
							
												
						
											<tr id="attachmentTr">
											  <td height="30" class="paddingLR" style="display:none;">
											   <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tbody>
													<tr>
													    <label style="width:100%;height:100%;" width="100%" height="100%" ><b>附件：</b></label>
														<td height="10" valign=""  >
															<hr size="1" class="newsBorder" >	
														</td>		
													</tr>
												    </tbody>
											  </table>
											  </td>
											</tr>
											<tr>
												<td height="30" class="paddingLR" valign="top" >
													${file}
												</td>
											</tr>
											<tr id="attachment2Tr">
											  <td height="30" class="paddingLR" style="display:none;">
											   <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tbody><tr>
														<td height="10" valign="" >
															<hr size="1" class="newsBorder">
														</td>
													</tr>
												</tbody></table>
											  </td>
											</tr>
										</tbody></table>
										
									</div>
								</td>
							</tr>
						</tbody></table> 
					</td>
				</tr>
			</tbody></table>
		</td>
	</tr>
</tbody></table>
</body>
</html>