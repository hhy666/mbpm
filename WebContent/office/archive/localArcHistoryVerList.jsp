<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.commonservice.data.DataService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="commonj.sdo.DataObject" %>
<%@ page import="com.matrix.form.api.MFormContext" %>
<%@ page  import="java.text.SimpleDateFormat" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
  background: url(image/icon16.png) no-repeat;
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
.over_auto {
  overflow: auto;
}
.align_right {
  text-align: right;
}
#hisTable {
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
.margin_r_5 {
	     margin-right: 5px;
	  }
a {
  color: #296fbe;
}
a {
  text-decoration: none;
  cursor: pointer;
}
 .cursor-hand{ 
 cursor: pointer;
 }
 .close_16 {
  background-position: -16px -624px;
}
  </style>
 
	<script>
function hideHisList(){
parent.document.getElementById('hisFrame').style.display="none";
}

	function look(uuid,mBizId) {
//	Matrix.setFormItemValue("uuid",uuid);
parent.look(uuid,mBizId);
	}
</script>
		<% 
  DataService dataService = MFormContext.getService("DataService");
  //查询历史版本列表
  String mBizId = MFormContext.getParameter("mBizId");//关联编码
  List<DataObject> list = dataService.queryList("from office.archive.document.ArchiveDoc where mBizId='"+mBizId+"' and hisVerFlag=1",null);
  int height = 0;
  if(list!=null && list.size()>0){
	  height=(1+list.size())*22+25+30;
		
  }
  %>
 
 
  <div id="his_div" style="background-color:rgb(237, 237, 237);width:100%;"  border="0">
  <script type="text/javascript">
document.getElementById('his_div').style.height="<%=height%>px";
  </script>

  <div class="static_layout">
<div class="stadic_layout_head stadic_head_height" style="background-color:#dadada">
 
   <table id="table001" class="bg_color_white font_size12" width="100%" border="0" bordercolor="#dadada" style="border-collapse: collapse;">
   <tr style="height: 25px;background-color:#EDEDED" >
   <td class="padding_l_5" border="0" colspan="3">
   <span style="font-weight:bold">查看所有历史版本</span>
   </td>
   <td colspan="1" style="padding-right: 5px;border: 0;" align="right">
   <span class="ico16 close_16 cursor-hand" onclick="hideHisList();">X</span>
  </td></tr>
  </table>
</div>
 <div class="over_auto" style="height:200px;" >
 <input type="hidden" name="uuid" />
 <table id="hisTable" width="100%"  border="2"  bordercolor="grey" style="border-collapse: collapse;" class="bg_color_white font_size12">
  <%
  if(list.isEmpty()){
  %>
  <tr style="height: 22px;" class="align_center"><td style="color: #888888;">无正文历史显示</td></tr>
  <%
  }
  else{
  %>
  <tr style="height: 22px;border: 0;" class="align_center padding_l_5">
  <td class="align_left w30b padding_l_5">文档编码</td>
  <td class="w10b">修改人</td>
  <td>修改时间</td>
  <td class="w20b">操作</td>
  </tr>
  <%
  for(int i=0;i<list.size();i++){
  	 DataObject hisObj=list.get(i);
 	 String uuid = hisObj.getString("uuid");//唯一编码
     String modifierId = hisObj.getString("modiforId");//修改人编码
     Date lastModifyDate = hisObj.getDate("lastModifyDate");//最后修改时间
     String modifier = "";
     if(modifierId!=null && modifierId.trim().length()>0){
	     modifier = (String)dataService.queryValue("select userName from foundation.org.User where userId='"+modifierId+"'",null);//修改人
     }
     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
     String dateStr = sdf.format(lastModifyDate);
  
  %>
   <tr class="align_center">
  		<td class="align_left" style="line-height: 20px;"><%=uuid %></td>
  		<td><%=modifier %></td>
  		<td><%=dateStr %></td>
  		<td><span>[<a href="javascript:look('<%=uuid%>','<%=mBizId %>')">查看</a>]</span></td>
   
  </tr>
  <%
  }  
  }
  %>
   </table>
   </div>
 
 </div>
</div>

</html>
