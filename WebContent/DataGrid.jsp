<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService" %>
<%@page import="java.util.List" %>
<%@page import="commonj.sdo.DataObject"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<link href="monitor/css/skin.css" rel="stylesheet" type="text/css"/>
<link href="monitor/css/default.css" rel="stylesheet" type="text/css"/>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>
<script type="text/javascript">
	
</script>
<body class="page_content public_page">

<%
	String userId = request.getParameter("userId");//当前用户编码
	StringBuffer hql = new StringBuffer();
	hql.append("from office.info.notice.noticeColumn");
	
	try{
       	DataService ds = MFormContext.getService("DataService");
    	List<DataObject> plate = ds.queryList(hql.toString(), null);//查询所有公告栏目集合
      	for(DataObject dbo2:plate){%>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
	 <tbody>
	    <tr>
	      <td class="padding_lr_10" vAlign="top" colSpan="3">
	      
	        <div class="scrollList" id="scrollListDiv" style="overflow:hidden;">
	<!-- 栏目标题 -->
	<div class="index-type-name" style="padding-left:0px;float:none;">
	    <%=dbo2.getString("name") %>
	    
	</div>      
	
	<%
	StringBuffer queryHql=new StringBuffer();
	queryHql.append("select mBizId from office.archive.document.documentDetail where userId='"+userId+"'");
		DataService data = MFormContext.getService("DataService");
		StringBuilder sb = new StringBuilder();
		List<String> lis=data.queryList(queryHql.toString(),null);
		for(String s:lis){
			sb.append(",").append("'").append(s).append("'");
		}
		String str = sb.deleteCharAt(0).toString();
	 	StringBuffer hqls = new StringBuffer();
		hqls.append("from office.info.notice.noticeQueryInfo where o.uuid='"+dbo2.getString("uuid")+"' and o.c_uuid in("+str+") Order By o.top asc,o.time desc");
		try{
	       	DataService cs = MFormContext.getService("DataService");
	    	List<DataObject> notice = cs.queryList(hqls.toString(), null);
	    	int count = 0;
	  	    %>
	          <div>
	          <div class="mxt-grid-header">
	          	<table class="sort ellipsis" id="leaveWord0" width="100%" border="0" cellSpacing="0" cellPadding="0">
	          		<thead class="mxt-grid-thead" >
	          		  <tr class="sort" >
	          		  	<td width="35%" align="left" type="String">公告名称</td>
	          		  	<td width="15%" align="left" type="String">发布部门</td>
	          		  	<td width="13%" align="left" type="String">发布人</td>
	          		  	<td width="20%" align="left" type="String">发布范围</td>
	          		  	<td width="17%" align="left" type="Date">发布时间</td>	
	          		  </tr>
	          		</thead>
	          			<tbody class="mxt-grid-tbody">
	          		
	          			<%for(DataObject dbo:notice){ %>
	          				<%if(count<6){ %>
	          		
	          		  <tr class="sort" erow="">
	          		  	<td width="35%" style="color:rgb(51,51,51);" class="cursor-hand sort titleList">
	          		  	  <a class="title-already-visited" href="<%=request.getContextPath()%>/CustomerVelocityServlet?mBizId=<%=dbo.getString("mBizId")%>&name=<%=dbo2.getString("noticeStyle")%>&type=1" target="_blank">
	          		  	  
	          		  	  <%=dbo.getString("name") %></a>
	          		  	</td>
	          		  	<td width="20%" class="title-already-visited-span sort">
	          		  	<%=dbo.getString("pubDepName")==null?"":dbo.getString("pubDepName")%>
	          		  	</td>
	          		  	<td width="18%" class="title-already-visited-span sort" >
	          		  	<%=dbo.getString("pubName") %>
	          		  	</td>
	     
	          		 <td width="20%" class="title-already-visited-span sort" >
	          		  	 <%=dbo.getString("area") %>
	          		  	</td> 	
	          		  	<td width="27%" class="title-already-visited-span sort">
	          		  		<%=dbo.getString("time") %>
	          		  	</td>
	          		  </tr>
	          		  	<%count++; %>
	          		     <%}else{break;}%>
	          		     
	          		    <%}%>
	          		</tbody>
	          	</table>
	          </div>
	        </div>
	     
	      <div class="index-bottom">
	          <!--  <div class="index-bottom in
	          dex-bottom-left color_gray" style="font-size:10px;">
	          	管理员:
	          	<span class="">陈晓军、王琳琳</span>&nbsp;
	          	审核员:
	          	<span class="">王琳琳</span>
	          </div>  -->
	        <div class="index-bottom index-bottom-right">
	         <!--  <input class="button-default-4" type="button"
	          value="新建公告"></input>-->
	          <a class="link-blue" href="<%=request.getContextPath()%>/AllNoticeInfoList.rform.rform?uuid=<%=dbo2.getString("uuid")%>&style=<%=dbo2.getString("noticeStyle") %>">更多</a>
	        </div>
	       </div>
	          <div style="clear:both;"></div>
	          
	     </div>
	     </td>
	    </tr>
	  </tbody>
	  </table>
	 <%
	   }catch(Exception e){
	    	e.printStackTrace();
	    }
	    }
	    }catch(Exception e){
	    	e.printStackTrace();
	    }%>
</body>
</html>