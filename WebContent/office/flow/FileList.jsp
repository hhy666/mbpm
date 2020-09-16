<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.commonservice.data.DataService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="commonj.sdo.DataObject" %>
<%@ page import="com.matrix.form.api.MFormContext" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.matrix.api.MFExecutionService" %>
<%@ page import="com.matrix.extention.SessionContextHolder" %>
<%@ page import="com.matrix.client.ClientConstants" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  
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
td{
  margin: 0;
  padding: 0;
  font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
}
table {
  display: table;
  border-collapse: separate;
  border-spacing: 2px;
  border-color: grey;
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
#attachTable {
  width: 100%;
  border-top-width: 2px;
  border-right-width: 2px;
  border-bottom-width: 2px;
  border-left-width: 2px;
  border-top-color: rgb(218, 218, 218);
  border-right-color: rgb(218, 218, 218);
  border-bottom-color: rgb(218, 218, 218);
  border-left-color: rgb(218, 218, 218);
}
.stadic_layout_head {
  height: 30px;
  width: 100%;
}
#table001{
  width: 100%;
  border-top-width: 0px;
  border-right-width: 0px;
  border-bottom-width: 0px;
  border-left-width: 0px;
  border-top-color: rgb(218, 218, 218);
  border-right-color: rgb(218, 218, 218);
  border-bottom-color: rgb(218, 218, 218);
  border-left-color: rgb(218, 218, 218);
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
  margin:0px;
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
.exe_16{
  background-position: -240px -656px;
}
.xls_16, .xlsx_16{
  background-position: -48px -656px;
}
.pdf_16{
  background-position: -64px -656px;
}
.doc_16, .docx_16{
  background-position: 0 -656px;
}
 .cursor-hand{ cursor: pointer;
 }
 .close_16 {
  background-position: -16px -624px;
}
  </style>
  <script>
function hideFileList(){
	parent.document.getElementById('attachFrame').style.display="none";
}
function download(uuid){
	window.location.href = "<%=basePath%>uploadFileHelperServlet?entity=office.common.attach.FileBO&name=fileName&mappingType=fileType&contents=fileContent&id=uuid&idValue="+uuid+"&type=downLoad&storeType=file";
} 
function lookRelatedDoc(elementId,subType){
	parent.lookRelatedDoc(elementId,subType);
}
 </script> 

 <% 
  DataService dataService = MFormContext.getService("DataService");
  //查询附件列表
  String mFlowBizId = MFormContext.getParameter("mFlowBizId");//关联编码
  List<DataObject> list = dataService.queryList("from office.common.attach.FileBO where mFlowBizId='"+mFlowBizId+"'",null);
  int height=(1+list.size())*22+25;
  List creatorIds = new ArrayList();
  for(int j=0;j<list.size();j++){
  	DataObject obj = (DataObject)list.get(j);
  	String creator = obj.getString("creator");//上传人编码
  	creatorIds.add(creator);
  }
  MFExecutionService service =  (MFExecutionService)SessionContextHolder.getSession().getAttribute(ClientConstants.EXECUTION_SERVICE);
  Map mapping = service.getIdentityService().getUserIdAndNameMap(creatorIds);
  %>
 
  <div id="attach_div" style="background-color:rgb(237, 237, 237);width:100%;"  border="0">
  <div class="static_layout">
 <div class="over_auto" >
 <table id="attachTable" width="100%"  border="2"  bordercolor="grey" style="border-collapse: collapse;" class="bg_color_white font_size12">
  <%

  
  
  if(list.isEmpty()){
  %>
  <tr style="height: 22px;" class="align_center"><td style="color: #888888;">无附件显示</td></tr>
  <%
  }
  
  else{
  %>
  
  <tr style="height: 22px;border: 0;" class="align_center padding_l_5"><td class="align_left w30b padding_l_5">名称</td><td class="w10b">大小</td><td class="w10b">创建人</td><td>上传时间</td></tr>
  <%
 for(int i =0;i<list.size();i++){
  DataObject fileObj=list.get(i);
  int mainType= fileObj.getInt("mainType");
  String uuid = fileObj.getString("uuid");//唯一编码
  String mBizId = fileObj.getString("mBizId");
  System.out.println(mBizId);
  String fileType = fileObj.getString("fileType");//文件类型--用于文件类型图片的设置
  int subType = fileObj.getInt("subType");//子类型--用于文件类型图片的设置
  String fileName = fileObj.getString("fileName");//文件名称
  long fileSize = fileObj.getLong("fileSize");//文件大小
  Date createdDate = fileObj.getDate("createdDate");//上传时间
  String creator = fileObj.getString("creator");//上传人编码
  String creatorName = (String)mapping.get(creator);
  if(mainType==1){
  
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  String dateStr = sdf.format(createdDate);
  %>

   <tr class="align_center">
   <td class="align_left" class="w30b" >
   <div style="word-break:keep-all; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
    <a style="text-decoration:none;" href="javascript:download('<%=uuid%>')" title="点击下载">
  

   <%
  if("xml".equals(fileType)||"doc".equals(fileType)||"pdf".equals(fileType)||"docx".equals(fileType)||"exe".equals(fileType)||"png".equals(fileType)||"jpg".equals(fileType)||"gif".equals(fileType)||"rar".equals(fileType)||"zip".equals(fileType)||"xls".equals(fileType)||"xlsx".equals(fileType)||"txt".equals(fileType)){

  %>
    <span id="list_span<%=i %>" class="ico16 <%=fileType%>_16 "></span>
   <%}
   else{
   %>
   
   <span id="list_span<%=i %>" class="ico16 file_16 "></span>
   <%
   }
   %>
</a><a style="font-size:12px;color:#757575;text-decoration:none;" href="javascript:download('<%=uuid%>')" title="点击下载"><%=fileName %></a></span>
  </div>
  </td>
  
  <td class="w20b"><%=fileSize %>B</td>
  <td  class="w20b"><%=creatorName %></td>
  <td class="w30b"><%=dateStr %></td>
   
  </tr>
   <%
 
   }
if(mainType==2){
  
  
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  String dateStr = sdf.format(createdDate);
  %>

   <tr class="align_center">
   <td class="align_left" class="w30b" >
   <div style="word-break:keep-all; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
    <a style="text-decoration:none;" href="javascript:lookRelatedDoc('<%=mBizId%>','<%=subType %>')" title="点击查看"><img id="list_doc_span<%=i %>" class="ico16"/>
   <script>
   <%
   if(subType==2){

  %>
   document.getElementById("list_doc_span<%=i%>") .style.backgroundPosition="-96px -688px";
   <%}
   if(subType==3){
   %>
   document.getElementById("list_doc_span<%=i%>").style.backgroundPosition="-192px -656px";
   <%
   }
     if(subType==1){
   %>
   document.getElementById("list_doc_span<%=i%>").style.backgroundPosition="-208px -656px";
   <%
   }
   %>
   </script>
  </img></a><a style="font-size:12px;color:#757575;text-decoration:none;" href="javascript:lookRelatedDoc('<%=mBizId%>','<%=subType %>')" title="点击查看"><%=fileName %></a></span>
  </div>
  </td>
  
  <td class="w20b"><%=fileSize %>B</td>
  <td  class="w20b"><%=creatorName %></td>
  <td class="w30b"><%=dateStr %></td>
   
  </tr>
   <%
 
   }
   }
   } %>
   </table>
   </div>
 
 </div>
</div>

</html>
