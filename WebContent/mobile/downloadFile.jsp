<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.matrix.form.api.MFormContext"%>
<%@ page import="com.matrix.commonservice.data.DataService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="commonj.sdo.DataObject"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.matrix.api.MFExecutionService"%>
<%@ page import="com.matrix.extention.SessionContextHolder"%>
<%@ page import="com.matrix.client.ClientConstants"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Map"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath = path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=2.5,user-scalable=yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.min.js'></SCRIPT>
<link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<SCRIPT SRC='<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
<style type="text/css">
img {
	height: 100px;
}

.positionDiv {
	text-align: center;
}

.docFile {
	/* position: absolute;
	top: 50%;
	left: 0; */
}
</style>
<style>
.ico16 {
	display: inline-block;
	vertical-align: middle;
	height: 16px;
	width: 16px;
	line-height: 16px;
	background: url(<%=path%>/image/icon16.png) no-repeat;
	cursor: pointer;
}

.align_center {
	text-align: center;
}

.align_left {
	text-align: left;
}

.w30b {
	width: 30%;
}

.padding_l_5 {
	padding-left: 5px;
}

.w20b {
	width: 20%;
}

.font_size12 {
	font-size: 12px;
}

.bg_color_white {
	background: #FFF;
}

td {
	/*   margin: 0;
  padding: 0;
  font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif; */
	
}


.stadic_footer_height {
	top: 50px;
	height: 20px;
}

.stadic_layout_footer {
	height: 30px;
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
}

.over_auto {
	overflow: auto;
}

.align_right {
	text-align: right;
}

.stadic_layout_head {
	height: 30px;
	width: 100%;
}

#table001 {
	width: 100%;
}

.stadic_layout_head {
	height: 25px;
	width: 100%;
}

.stadic_layout {
	font-size: 12px;
	height: 100%;
	position: relative;
}

body, html {
	background: none;
	margin: 0px;
	height:100%;
}

.ico17 {
	display: inline-block;
	vertical-align: middle;
	height: 20px;
	width: 20px;
	line-height: 20px;
	cursor: pointer;
	_overflow: hidden;
}

.margin_r_5 {
	margin-right: 5px;
}
/*文档*/
.km_16 {
	background-position: -96px -688px;
}
/*协同*/
.collaboration_16 {
	background-position: -192px -656px;
}
/*公文*/
.edoc_16 {
	background-position: -208px -656px;
}

.txt_16 {
	background-position: -96px -656px;
}

.xml_16 {
	background-position: -240px -672px;
}

.images_16, .jpg_16, .gif_16, .png_16 {
	background-position: -112px -656px;
}

.rar_16, .zip_16 {
	background-position: -256px -656px;
}

.file_16 {
	background-position: -128px -880px;
}

.exe_16 {
	background-position: -240px -656px;
}

.xls_16, .xlsx_16 {
	background-position: -48px -656px;
}

.pdf_16 {
	background-position: -64px -656px;
}

.doc_16, .docx_16 {
	background-position: 0 -656px;
}

.cursor-hand {
	cursor: pointer;
}

.close_16 {
	background-position: -16px -624px;
}
</style>
<title>文件下载</title>
</head>
<body>
<div style="height:100%;">
	<%
		String mFlowBizId = (String) request.getParameter("mFlowBizId");
		String getNameHql = "select title from office.flow.MoFlowBizInfo where uuid='" + mFlowBizId + "'";
		DataService dataService = MFormContext.getService("DataService");
		String name = (String) dataService.queryValue(getNameHql, null);
	%>
	<%
		String isDocFile = (String) request.getParameter("isDocFile");
		if("1".equals(isDocFile)){
			%>
			<div style="text-align: center; margin: 2px 5% 0px;">
				<h2><%=name%></h2>
			</div>
			<br>
			<hr>
			<div style='margin-bottom: 20px;'>
				<!-- <div class="positionDiv" style="">
					<img alt="文件下载" src="../image/wordicon.png">
				</div> -->
				<div class="positionDiv" style="">
					<a class="docFile btn btn-lg btn-primary "
						href="<%=path%>/DownLoadFileServlet?mFlowBizId=<%=mFlowBizId%>&isDispatchDoc=true">
						<!-- <i class="fa fa-download fa-2x pull-left"></i> -->查看正文</a>
				</div>
			</div>
			<%
		}
	%>

	<script>
function hideFileList(){
parent.document.getElementById('attachFrame').style.display="none";
}
function download(uuid){
	     window.location.href = "<%=basePath%>uploadFileHelperServlet?entity=office.common.attach.FileBO&name=fileName&mappingType=fileType&contents=fileContent&id=uuid&idValue="+uuid+"&type=downLoad&storeType=file";
	 } 
	 function lookRelatedDoc(elementId,subType){
		   if(subType==7){
			    var url = webContextPath+"/LookMeeting.rform?modelType=1&mBizId="+elementId+"&matrix_view_flag=true";
			    var title="查看会议信息";
			    var data = {};
			    data["url"]=url;
			    data["title"]=title;
			    openCtpWindow(data);
		   }else{
			var newData2 = "{'piid':'"+elementId;
			newData2 += "','subType':'"+subType;
			newData2+="','matrix_user_command':'lookRelatedDoc'";
			newData2+="}";
			var forwardUrl ="";
			var synJson = isc.JSON.decode(newData2);
			var url = webContextPath+'/matrix.rform?matrix_send_request=true&matrix_form_tid='+document.getElementById("matrix_form_tid").value;
			Matrix.sendRequest(url,synJson,function(data){
			forwardUrl = data.data;

			openCtpWindow({'url':forwardUrl});

			});
		    }
		}
  </script>

	<%
		//查询附件列表
		List<DataObject> list = dataService
				.queryList("from office.common.attach.FileBO where mFlowBizId='" + mFlowBizId + "'", null);
		int height = (1 + list.size()) * 22 + 25 + 30;
		List creatorIds = new ArrayList();
		for (int j = 0; j < list.size(); j++) {
			DataObject obj = (DataObject) list.get(j);
			String creator = obj.getString("creator");//上传人编码
			creatorIds.add(creator);
		}
		MFExecutionService service = (MFExecutionService) SessionContextHolder.getSession()
				.getAttribute(ClientConstants.EXECUTION_SERVICE);
		Map mapping = service.getIdentityService().getUserIdAndNameMap(creatorIds);
	%>

	<div id="attach_div" style="margin: 0 10%;" border="0">
		<script type="text/javascript">
document.getElementById('attach_div').style.height="<%=height%>px";
  </script>
		<div class="static_layout">
		<%
						if (!list.isEmpty()) {//文件为空不显示
					%>
					<!-- 
			<div class="stadic_layout_head stadic_head_height"
				style="text-align: center;">

				<table id="table001" class="bg_color_white font_size12" width="100%"
					border="0" bordercolor="#dadada" style="border-collapse: collapse;">
					<tr style="height: 25px; background-color: #EDEDED">
						<td class="padding_l_5" border="0" colspan="3"><span
							style="font-weight: bold">查看所有附件</span></td>
					</tr>

				</table>

			</div>
			 -->
			<%
						}
		%>
			<div class="over_auto" style="height: 200px;margin-top: 10px;">
				<table id="attachTable" width="100%" border="0" style=""
					class="bg_color_white font_size12">
					<%
						if (list.isEmpty()) {
					%>
					<tr style="height: 30px;">
						<td style="height: 30px;"></td>
					</tr>
					<tr style="height: 22px;" class="align_center">
						<td style="color: black;">无附件显示</td>
					</tr>
					<%
						}

						else {
							for (int i = 0; i < list.size(); i++) {
								DataObject fileObj = list.get(i);
								int mainType = fileObj.getInt("mainType");
								String uuid = fileObj.getString("uuid");//唯一编码
								String fileType = fileObj.getString("fileType");//文件类型--用于文件类型图片的设置
								int subType = fileObj.getInt("subType");//子类型--用于文件类型图片的设置
								String fileName = fileObj.getString("fileName");//文件名称
								long fileSize = fileObj.getLong("fileSize");//文件大小
								Date createdDate = fileObj.getDate("createdDate");//上传时间
								String creator = fileObj.getString("creator");//上传人编码
								String creatorName = (String) mapping.get(creator);
								if (mainType == 1) {

									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
									String dateStr = sdf.format(createdDate);
					%>

					<tr class="align_center">
						<td class="align_left" class="w30b">
							<div
								style="word-break: keep-all; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: center;">
								<a style="text-decoration: none;"
									href="javascript:download('<%=uuid%>')" title="点击下载"> <%
 	if ("xml".equals(fileType) || "doc".equals(fileType) || "pdf".equals(fileType)
 						|| "docx".equals(fileType) || "exe".equals(fileType) || "png".equals(fileType)
 						|| "jpg".equals(fileType) || "gif".equals(fileType) || "rar".equals(fileType)
 						|| "zip".equals(fileType) || "xls".equals(fileType) || "xlsx".equals(fileType)
 						|| "txt".equals(fileType)) {
 %> <span id="list_span<%=i%>" class="ico16 <%=fileType%>_16 "></span>
									<%
										} else {
									%> <span id="list_span<%=i%>" class="ico16 file_16 "></span> <%
 	}
 %>
								</a><a
									style="font-size: 12px; color: #757575; text-decoration: none;"
									href="javascript:download('<%=uuid%>')" title="点击下载"><%=fileName%></a></span>
							</div>
						</td>

					</tr>
					<%
						}
								if (mainType == 2) {

									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
									String dateStr = sdf.format(createdDate);
					%>

					<%-- <tr class="align_center">
						<td class="align_left" class="w30b">
							<div
								style="word-break: keep-all; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: center;">
								<a style="text-decoration: none;"
									href="javascript:lookRelatedDoc('<%=uuid%>','<%=subType %>')" title="点击查看"><img
									id="list_doc_span<%=i%>" class="ico16" /> <script>
   <%if (subType == 2) {%>
   document.getElementById("list_doc_span<%=i%>") .style.backgroundPosition="-96px -688px";
   <%}
						if (subType == 3) {%>
   document.getElementById("list_doc_span<%=i%>").style.backgroundPosition="-192px -656px";
   <%}
						if (subType == 1) {%>
   document.getElementById("list_doc_span<%=i%>
										").style.backgroundPosition = "-208px -656px";
									<%}%>
										
									</script> </img></a><a style="font-size: 12px; color: #757575; text-decoration: none;"
									href="javascript:lookRelatedDoc('<%=uuid%>','<%=subType %>')" title="点击查看"><%=fileName%></a></span>
							</div>
						</td>
					</tr> --%>
					<%
						}
							}
						}
					%>
				</table>
			</div>

		</div>
	</div>
	</div>
</body>
</html>