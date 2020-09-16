<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService" %>
<%@page import="java.util.List" %>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.office.common.CommonHelper"%>
<%@page import="com.matrix.api.identity.MFUser"%>
<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<head>
		<link href="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/skin_styles.css" rel="stylesheet" type="text/css" />
		<link href='<%=request.getContextPath()%>/resource/html5/css/style.min.css' rel="stylesheet"></link>
		<link href='<%=request.getContextPath()%>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
		<link href='<%=request.getContextPath()%>/resource/html5/css/filecss.css' rel="stylesheet"></link>
		<link href='<%=request.getContextPath()%>/resource/html5/css/custom.css' rel="stylesheet"></link>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
	    <link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
	</head>
	<script language=javascript
		src='<%=request.getContextPath()%>/resource/js/office.js'></script>
	<script type="text/javascript">
	
	function openCtpWindow2(url){
		openCtpWindow(url);
	}
	function openWindow(mBizId,name,status){
		var url = "<%=request.getContextPath()%>/CustomerVelocityServlet?mBizId="+mBizId+"&name="+name+"&type=2&status="+status;
		var data = {};
		data.url = url;
		data.datagrid='';
		data.title = "新闻信息";
		//window.open(url,'新闻信息');
		openCtpWindow(data);
	}
	
	function search(){
		document.getElementById('form01').action = "<%=request.getContextPath()%>/office/news/NewsList.jsp";
		document.getElementById('form01').submit();
		//var searchValue=document.getElementById("searchValue").value;
		//window.location.href="<%=request.getContextPath()%>/office/news/NewsList.jsp?searchValue="+encodeURI(searchValue);
	}
	
</script>
	<style>
h1 {
	-webkit-margin-before: 0em;
	-webkit-margin-after: 0em;
	//background: url(../../resource/images/title.png) no-repeat;
	float: left;
	text-align: center;
	line-height: 28px;
	//color: #fff;
}

.table-striped>tbody>tr:nth-child(odd)>td,.table-striped>tbody>tr:nth-child(odd)>th
	{
	background-color: #f9f9f9
}

table col[class *=col-] {
	position: static;
	float: none;
	display: table-column
}

table td[class *=col-],table th[class *=col-] {
	position: static;
	float: none;
	display: table-cell
}
.search_16 {
    background-position: -32px 0;
}
.ico16 {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(<%=request.getContextPath()%>/resource/images/query.png) no-repeat;
    background-position: 0 0;
    cursor: pointer;
    _overflow: hidden;
    _background: url(<%=request.getContextPath()%>/resource/images/query.png) no-repeat;
}
.ibox {
    clear: both;
	margin-bottom: 8px;
    margin-top: 0px;
    padding: 0px;
}
.ibox-title {
	background-color: #fff;
	border-color: #e7eaec;
	-webkit-border-image: none;
	-o-border-image: none;
	border-image: none;
    border-style: solid solid none;
    border-width: 0px 1px 0;
    color: inherit;
    margin-bottom: 0;
    padding: 14px 15px 7px;
    min-height: 40px;
}
.ibox-content {
    background-color: rgb(255, 255, 255);
    color: inherit;
    -webkit-border-image: none;
    padding: 0px 0px 20px;
    border-color: rgb(231, 234, 236);
    border-image: none 100% / 1 / 0 stretch;
    border-style: solid;
    border-width: 1px;
    padding-left: 5px;
    padding-right: 5px;
}

</style>
	<body class="page_content public_page" style="background: #f3f3f4;overflow:auto;">
	<div style="padding-left: 10px;padding-top:9px">	
            <form id="form01" method="post" action="">
              <!-- 搜索 -->
              <div class="input-group" style="float:right;margin-right:5px;margin-top: 5px;">
              	  <label id="label011" name="label011" style="font-size:18px;font-weight: normal;vertical-align:bottom;" class="control-label">新闻公告&gt;新闻列表</label>
	              <input id="searchValue" name="searchValue" placeholder="请输入新闻标题" class="form-control" style="float:right;width:15%;height:28px;">
				   <div class="input-group-btn">
                        <button type="submit" class="x-btn ok-btn btn-sm">搜索</button>
                   </div>
			  </div>
			</form>
		</div>
		<%
		//获得文本框里面输入的条件
		String searchValue = request.getParameter("searchValue");
		
		MFUser curUser = MFormContext.getUser();
		//******************************************************************
		//如果  在连接上传递  isDep=true  那么这里就要拼接当前人部门的过滤条件
		//如果  在连接上拼接  isDep=false 或者 不拼接  就直接查询非部门栏目的调查栏目列表
		//******************************************************************
		String isDep = request.getParameter("isDep");
		String curUserDepCondition = CommonHelper.getCurUserDepIds(curUser);
		//String str = sb.deleteCharAt(0).toString();
	StringBuffer hql = new StringBuffer();
	if(isDep!=null && "true".equals(isDep)){
		hql.append("from office.info.news.newsTemplate where status=1 and isDepPlate=1");
		if(curUserDepCondition!=null && curUserDepCondition.trim().length()>0){
			hql.append(" and depId in"+curUserDepCondition);
		}
		hql.append(" order by cOrder asc");
	}else{
		
		hql.append("from office.info.news.newsTemplate where status=1 and isDepPlate=0 order by cOrder asc");
	}
 	try{
       	DataService ds = MFormContext.getService("DataService");
    	List<DataObject> plate = ds.queryList(hql.toString(), null);
      for(DataObject dbo2:plate){%>

		<table width="99%" border="0" cellSpacing="0" cellPadding="0"
			style="margin: 0 auto;">
			<tbody>
				<tr>
					<td class="padding_lr_10" vAlign="top" colSpan="3">
						<div style="wdith: 100%; height: 10px;"></div>
						<div class="scrollList" id="scrollListDiv"
							style="overflow: hidden;">
							<!-- 栏目标题} -->
							<div class="index-type-name"
								style="padding-left: 0px; position: relative;">
								<div>
									<div style="overflow:hidden;width:100%;" class="ibox-title">						
										<h5><%=dbo2.getString("name") %></h5>
										<a style='float:right;text-decoration:none;' href=javascript:openCtpWindow2({'url':'<%=request.getContextPath()%>/NewsReadList.rform?mHtml5Flag=true&mBizId=<%=dbo2.getString("uuid")%>'})>更多</a>
							    	</div>
						 <%
						 	/*
							String userId = curUser.getUserId(); 
							StringBuffer queryHql=new StringBuffer();
							queryHql.append("select mBizId from office.archive.document.documentDetail ");
							DataService data = MFormContext.getService("DataService");
							StringBuilder sb = new StringBuilder();
							List<String> lis=data.queryList(queryHql.toString(),null);
							for(String s:lis){
								sb.append(",").append("'").append(s).append("'");
							}
							String str = sb.deleteCharAt(0).toString();
							*/
						 	StringBuffer hqls = new StringBuffer();
						 	if(searchValue!=null && searchValue!=""){
						 		hqls.append("from office.info.news.NewsQueryInfo where o.c_mBiz_id='"+dbo2.getString("uuid")+"' and o.C_NAME like '%"+searchValue+"%' and o.c_status=1 Order By o.c_focus asc,o.C_AUDIT_DATE desc");
						 	}else{
						 		hqls.append("from office.info.news.NewsQueryInfo where o.c_mBiz_id='"+dbo2.getString("uuid")+"' and o.c_status=1 Order By o.c_focus asc,o.C_AUDIT_DATE desc");
						 	}
							
							try{
						       	DataService cs = MFormContext.getService("DataService");
						    	List<DataObject> notice = cs.queryList2(hqls.toString(), null, 0, 6);
						    	int count = 0;
						  	 %>
							<div class="ibox-content">
								<div class="mxt-grid-header ">
									<table class="sort ellipsis table-striped table-native" style="border:0px;table-layout: fixed;"
										id="leaveWord0" width="100%" border="0" cellSpacing="0"
										cellPadding="0">
										<thead class="mxt-grid-thead"
											style="background-color: #FFFFFF">
											<tr class="sort" style="background-color: #fafafa; height:36px;">
												<td width="45%" align="left" class="headerButton">标题</td>
							          		  	<td width="15%" align="left" class="headerButton">发布部门</td>
							          		  	<td width="10%" align="left" class="headerButton">发布人</td>
							          		  	<td width="20%" align="left" class="headerButton">摘要</td>
							          		  	<td width="10%" align="left" class="headerButton">发布时间</td>	
											</tr>
										</thead>
							            <tbody class="mxt-grid-tbody">

							<% if(notice!=null&&notice.size() > 0){
								 for(DataObject dbo:notice){ %>

	          				<%if(count<6){ 
	          					String abstractValue = dbo.getString("abstractInfo")==null?"":dbo.getString("abstractInfo");
	          					String pubDepNameValue = dbo.getString("pubDepName");
	          					if(pubDepNameValue == null)
	          						pubDepNameValue = "";
          						java.text.SimpleDateFormat sdf =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		          		  		String value2 = "";
		          		  		if(dbo.getDate("auditDate") != null){   //发布时间
		          		  			value2 = sdf.format(dbo.getDate("auditDate"));
		          		  		}
		          		  		String focus = dbo.getString("top");
		          		  		String nameValue = dbo.getString("name");
		          		  		if("0".equals(focus)){
		          		  			nameValue="<img src='../../resource/images/infocus.png'>"+nameValue;
		          		  		}
		          		  		String pubNameValue = dbo.getString("pubName");
		          		  		String status = dbo.getString("status");
	          				%>

											<tr class="sort" erow="" style="height:35px;">
												<td width="35%" style="color:rgb(51,51,51);" class="cursor-hand sort titleList">
	          		  	  <a class="title-already-visited" style="text-decoration:none; color:#000000;padding-left:5px;" href=javascript:openWindow('<%=dbo.getString("uuid")%>','<%=dbo2.getString("newsStyle")%>','<%=dbo2.getString("status")%>') >
	          		  	  
	          		  	  <%=nameValue%></a>
	          		  	</td>
	          		  	<td class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
	          		  	<%=pubDepNameValue %>
	          		  	</td>
	          		 <td class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
	          		  	<%=pubNameValue %>
	          		  	</td>
	     
	          		 <td class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;" >

	          		  	 <%= abstractValue%>

	          		  	</td> 	
	          		  	<td class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">

	          		  		
	          		  		 <%=value2 %>

	          		  	</td>
											</tr>
											<%
												count++;
																	//}
																} else {
																	break;
																}

															}
																}else{ %>
																<tr><td>暂无可查看的新闻信息</td><td></td><td></td><td></td><td></td></tr>
															<%}
											%>
										</tbody>
									</table>
								</div>
							     </div>
							      <div style="clear: both;"></div>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>

		<%
			} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</body>
</html>