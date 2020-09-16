<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.app.api.Page"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'imageNewsList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <style>
  .page-list-border-LRD {
    vertical-align: top;
}
  .page2-header-line {
    background: #fafafa;
}
.page2-header-img {
    display: none;
}
.page2-header-bg {
    font-size: 20px;
    font-family: "Microsoft YaHei",SimSun, Arial,Helvetica,sans-serif;
    padding: 5px 10px;
    color: #919191;
}
.webfx-menu-bar {
    height: 26px;
    vertical-align: middle;
    background: #f0f0f0;
}
.page2-list-header {
    color: #000000;
    padding-left: 10px;
}
body, td, th, input, textarea, div, select, p {
    font-family: "Microsoft YaHei",SimSun, Arial,Helvetica,sans-serif;
    font-size: 12px;
}
strong, b {
    font-weight: bold;
}
.scrollList {
    float: left;
    clear: left;
    height: 100%;
    width: 100%;
    overflow: auto;
    margin: 0px;
    padding: 0px;
}
a:HOVER {
    color: #318ed9;
}
a {
    font-size: 12px;
    cursor: pointer;
    color: #0052b8;
    text-decoration: none;
}
.common_over_page {
    color: #888888;
    font-size: 12px;
}

.align_right {
    text-align: right;
}

a.common_over_page_btn {
    display: inline-block;
    vertical-align: middle;
    width: 24px;
    height: 24px;
    line-height: 20px;
    border: solid 1px #b6b6b6;
    background: url(<%=request.getContextPath()%>/images/table/btnbg.gif) repeat-x;
    text-align: center;
    margin-left: 10px;
}


.pageFirst {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(<%=request.getContextPath()%>/images/table/control_icon.png) no-repeat left center;
}
.pageFirst {
    background-position: 0 top;
}
.pagePrev {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(<%=request.getContextPath()%>/images/table/control_icon.png) no-repeat;
    background-position: -16px top;
}
.pagePrev {
    background-position: -16px top;
}

.pageNext {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(<%=request.getContextPath()%>/images/table/control_icon.png) no-repeat;
    background-position: -32px top;
}
.pageNext {
    background-position: -32px top;
}


.pageLast {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(<%=request.getContextPath()%>/images/table/control_icon.png) no-repeat;
    background-position: -48px top;
}
.pageLast {
    background-position: -48px top;
}
  </style>
  <body>
 <table border="0" cellpadding="0" cellspacing="0" width="100%"
	height="100%" align="center">
	<tr class="page2-header-line">
		<td width="100%" height="41" valign="top" class="page-list-border-LRD">
		<table width="100%" height="100%" border="0" cellpadding="0"
			cellspacing="0">
			<tr class="page2-header-line">
				<td width="45" class="page2-header-img">
				<div class="newsIndex"></div>
				</td>
				<td class="page2-header-bg">新闻</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top" class="padding5">
		<table id="newsMoreTable" align="center" width="100%" height="100%"
			cellpadding="0" cellspacing="0" class="page2-list-border">
			<tr>
				<td height="22" class="webfx-menu-bar page2-list-header " style="border-top: 1px solid #b6b6b6;border-bottom: 1px solid #b6b6b6;">
				<b>
				图片新闻

				</b></td>
				<td class="webfx-menu-bar"></td>
			</tr>
			<tr>
				<td colspan="2">
				<div class="scrollList">
					<table border="0" width="100%" height="100%" cellpadding="0"
					cellspacing="0">
					<%
					 String str = request.getParameter("startRow");
  	 int curPage;
  	 if(str==null){
  	 	curPage = 1;
  	 }else{
  	 	curPage =Integer.parseInt(request.getParameter("startRow"));
  	 }
  	  String str2 = request.getParameter("rowCount");
  	 int rowCount;
  	 if(str2==null||str2.trim().length()==0){
  	 	rowCount = 5;
  	 }else{
  	 	rowCount =Integer.parseInt(request.getParameter("rowCount"));
  	 }
		String hql = "from office.info.news.News where imgNews = 1 and status=1 order by time desc"; //新闻表中是图片新闻的按发布时间升序排列
     	DataService ds = MFormContext.getService("DataService");
     	Page resultObj = ds.queryPage(hql, null, (curPage-1)*rowCount,rowCount);
     	List<DataObject> imgNewsList = resultObj.getDataList();;//新闻图片集合
     	if(imgNewsList!=null && imgNewsList.size()>0){
			for(int i=0;i<imgNewsList.size();i++){
				byte[] bytes = imgNewsList.get(i).getBytes("content");
				String uuid = imgNewsList.get(i).getString("uuid");
				String name = imgNewsList.get(i).getString("name");
				Date date = imgNewsList.get(i).getDate("time");
				String textContent = imgNewsList.get(i).getString("textContent");
				String time = "";
				 java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
				if(date!=null) 
				time = format1.format(date);
				String content= "";
				if(bytes!=null && bytes.length>0){
					content = new String(bytes);
				
				}
	 %>
			
				<tr>
				
		<td valign="top" height="100px" style="padding:10px;border-bottom: 1px #ccc dotted;">
		<table border="0" width="100%" height="100%" cellpadding="0" cellspacing="0">
								
						<tr>
						<td width="140px" style="BORDER:1px SOLID #d6d6d6;" align="center">
						<a href="<%=request.getContextPath()%>/CustomerVelocityServlet?type=2&mBizId=<%=uuid%>" target="_blank">
	<img style="padding:0px; border:0px solid #cccccc;" src="<%=request.getContextPath()%>/ImageNewsServlet?args=<%=i%>&mBizId=<%=uuid%>" border="0"  width="140px" height="100px">
							</a>
						</td>
						<td style="padding-left:12px;">
			<table border="0" width="100%" height="100%" cellpadding="0" cellspacing="0">
								
					<tr>
						<td valign="top" style="font-size: 16px;" height="25px" align="left" width="100%">
							<a href="<%=request.getContextPath()%>/CustomerVelocityServlet?type=2&mBizId=<%=uuid%>" target="_blank" style="TEXT-DECORATION:underline">
								<%=name%>
							</a>
						<td style="padding:0 6px;" nowrap="nowrap">
							<%=time %>
						</td>
								<td align="right" style="padding:0 6px;" nowrap="nowrap">
							
								</td>
								</tr>
									<tr>
									<td valign="top" colspan="3">
					<%=textContent==null?"":textContent%>	
							</td>
								</tr>
							</table>	
						</td>
									</tr>
									</table>
								
		</td>
				
				</tr>
						<%
						}
						}
						 %>
						 </table>
						     <!-- 分页 -->
						     	<%
    								int prestart = resultObj.getStartOfPreviousPage();;
									int nextstart = resultObj.getStartOfNextPage();
									int totalpage = resultObj.getTotalPageNumber();
									Long totalSize = resultObj.getTotalSize();
									
    							 %>
    <form action="office/news/imageNewsList.jsp" id="pageForm" method="post">
    	<input type="hidden" name="startRow" id="startRow" />
    	   	<input type="hidden" name="rowCount" id="rowCount" />	
    	<table style="width:100%;" border="0">
    		
						 <tr>
						<td align="right" valign="top">
						<script type="text/javascript">
					function submitQueryByPage(pg){
	    document.getElementById("startRow").value = pg;
	    var rowCount = document.getElementById("rowCounts").value;
	    document.getElementById("rowCount").value = rowCount;
	     document.getElementById("rowCounts").value = rowCount;
	      document.getElementById("inputPg").value = pg;
	    document.getElementById("pageForm").submit();
	}
		
		function submitQueryByInputPage(totalpage){
			var inputPg = document.getElementById("inputPg").value;
			
			if(inputPg>totalpage){
				inputPg = totalpage;
			}else if(inputPg<1){
				inputPg = 1;
			}
			submitQueryByPage(inputPg);
		}
						</script>
						
						 <div class="common_over_page align_right">
						每页<input style="width: 25px;text-align: center;vertical-align: middle; border: 1px solid #ccc;height: 17px" type="text" maxlength="3" id="rowCounts" class="pager-input-25-undrag" defaultValue="5" value="${param.rowCount==null?5:param.rowCount}" name="pageSize" >条/共<%=totalSize %>条记录 <span class="hole_count">共<%=totalpage %>页</span><span class="sepreat">|</span>
<!-- 						<a href="javascript:submitQueryByPage(1)" class="common_over_page_btn" title="首页"><em class="pageFirst"></em></a>
                            
                             <a href="javascript:submitQueryByPage(<%=curPage-1%>)" class="common_over_page_btn" title="上一页"><em class="pagePrev"></em></a>
                             <a href="javascript:submitQueryByPage(<%=curPage + 1%>)" class="common_over_page_btn" title="下一页"><em class="pageNext"></em></a>
                             <a href="javascript:submitQueryByPage(<%=totalpage%>)" class="common_over_page_btn" title="末页"><em class="pageLast"></em></a><span class="sepreat">|</span>
                              -->
                             第<input id="inputPg" style="width: 25px;text-align: center;vertical-align: middle; border: 1px solid #ccc;height: 17px" type="text" maxlength="10" class="pager-input-25-undrag"  value="${param.startRow==null?1:param.startRow}"  pagecount="<%=totalSize %>" >页
						<a id="grid_go" class="common_over_page_btn" href="javascript:submitQueryByInputPage(<%=totalpage %>);">go</a>&nbsp;&nbsp;&nbsp;&nbsp;
						
						 </div>
						</td>
					</tr>
					</table>
					</form>
						

</div>
</td>
</tr>
</table>
</td></td></tr></table>
  </body>
</html>
