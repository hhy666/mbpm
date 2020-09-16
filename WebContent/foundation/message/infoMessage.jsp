<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.util.*"%>
<%@page import="javax.matrix.faces.component.MUIComponent"%>
<%@page import="javax.matrix.faces.context.MFacesContext"%>
<%@page
	import="com.matrix.client.foundation.message.service.MessageFilePathHelper"%>
<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<head>
	    <link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
        <link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
		<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.min.js'></SCRIPT>
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
	</head>
	<style>
		#tr001,#tr002,#tr003,#tr004{
		  border:1px solid lightgray;
		}
	</style>
	<body>
		<div id='loading' name='loading' class='loading'>
			<script>Matrix.showLoading();</script>
		</div>
<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",name:"Mform0",position:"absolute",action:"<%=request.getContextPath()%>/matrix.rform",fields:[{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}]});</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>##"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="c143cdc1-03ce-4384-bd6b-7e68858dc855" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<table class="maintain_form_content" style="width: 100%; height: 100%;">
					<tr id="tr001">
						<td class="tdLayout2" style="width:30%;height:10%;text-align:right;padding-right:20px;text-align:center;border:1px solid lightgray;background-color:rgb(250, 250, 250);">
							<label class="control-label">主题</label>
						</td>
						<td class="tdLayout2" style="border:1px solid lightgray;padding-left:12px;">
						    ${subjectValue}
						</td>
					</tr>
					<tr id="tr002">
						<td class="tdLayout2" style="width:30%;height:60%;text-align:right;padding-right:20px;text-align:center;background-color:rgb(250, 250, 250);">
							<label class="control-label">内容</label>
						</td>
						<td class="tdLayout2" style="height:250px;overflow:hidden;">
						    <textarea style="border-left:1px solid lightgray;width:100%;height:102%;margin:0px;padding-left:12px;padding-top:15px" readonly="readonly">${contentValue}</textarea>
						</td>
					</tr>
					<tr id="tr003">
						<td class="tdLayout2" style="width:30%;height:10%;text-align:right;padding-right:20px;text-align:center;;border:1px solid lightgray;background-color:rgb(250, 250, 250);">
							<label class="control-label">接收时间</label>
						</td>
						<td class="tdLayout2" style="border:1px solid lightgray;padding-left:12px;">
						   ${createdDate}
						</td>
					</tr>
					<%
						DataService dataService = MFormContext.getService("DataService");
						String mBizId = request.getParameter("fileId");
						String sql = "select * from MF_FILE_INFO where C_MBIZ_ID = '"
								+ mBizId + "'";
						List fileList = dataService.querySqlList(sql, null, null);
						if (fileList != null && fileList.size() > 0) {
					%>
					<tr id="tr004">
						<td class="tdLayout2" style="width:30%;text-align:right;padding-right:20px;text-align:center;border:1px solid lightgray;background-color:rgb(250, 250, 250);">
							<label class="control-label">
								附件
							</label>
						</td>
						<td style="border:1px solid lightgray">
							<table id='viewTab' border='0' align='left' cellpadding='0'
								cellspacing='0'>
								<tbody>
									<%
										for (Iterator iter = fileList.iterator(); iter.hasNext();) {
												Object[] file = (Object[]) iter.next();
												String fileId = (String) file[0];
												String fileName = (String) file[2];
									%>
									<tr id='view'>
										<td style='border-width: 0px;padding-left:12px;' align='left'>
											<%
												MessageFilePathHelper messhp = new MessageFilePathHelper();
														String downloadUrl = request.getContextPath()
																+ "/uploadFileHelperServlet?";
														downloadUrl = downloadUrl
																+ "entity=office.common.filemanage.FileManageBo";
														downloadUrl = downloadUrl + "&name=fileName";
														downloadUrl = downloadUrl + "&mappingType=fileType";
														downloadUrl = downloadUrl + "&contents=fileContent";
														downloadUrl = downloadUrl + "&id=uuid";
														downloadUrl = downloadUrl + "&idValue=" + fileId;
														downloadUrl = downloadUrl + "&type=downLoad";
														downloadUrl = downloadUrl + "&storeType=file";
														downloadUrl = downloadUrl + "&filePath="
																+ java.net.URLEncoder.encode(messhp.getFilePath());//获取路径
											%>
											<a href="<%=downloadUrl%>"> <%=fileName%> </a>
	
										</td>
									</tr>
	
									<%
										}
									%>
								</tbody>
							</table>
						</td>
					</tr>
					<%
						}
					%>
					<tr style="wdith:100%;height:50px">
						<td colspan="2" style="text-align:center;padding-right:30px;width:100%;position:absolute;bottom:5px;">
						    <input type="button" class="x-btn cancel-btn" name="关闭" value="关闭" id="btn" >
						    <input type="hidden" id ="flag" value="${flag }"/>
						</td>
						
					</tr>
	
					<script type="text/javascript">
					   $("#btn").on("click",function(){
						 	var flag = document.getElementById("flag").value;
						 	if(flag != 1){
						 		Matrix.showMask();
							    Matrix.closeWindow();
						        Matrix.hideMask();
						 	}else{
						        window.close();
						 	}
				        })      
					</script>
				</table>
			</form>

		</div>
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>
