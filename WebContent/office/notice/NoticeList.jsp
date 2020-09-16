<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.*"%>
<%@page import="com.matrix.office.common.CommonHelper"%>

<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<link href="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/skin_styles.css"
			rel="stylesheet" type="text/css" />
<link href='<%=request.getContextPath()%>/resource/html5/css/style.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/filecss.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath()%>/resource/html5/css/custom.css' rel="stylesheet"></link>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<style>
	h1 {
	-webkit-margin-before: 0em;
	-webkit-margin-after: 0em;
	width: 128px;
	height: 28px;
	font-size: 12px;
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
</head>
<script language=javascript src='<%=request.getContextPath()%>/resource/js/office.js'></script>
<script type="text/javascript">
	
</script>
<body class="page_content public_page" style="background: #f3f3f4;overflow:auto;">
<div style="padding-left: 10px;padding-top:9px;overflow:auto;">
		<form id="form01" method="post" action="">
              <!-- 搜索 -->
              <div class="input-group" style="float:right;margin-right:5px;margin-top: 5px;">
              	  <label id="label011" name="label011" style="font-size:18px;font-weight: normal;vertical-align:bottom;" class="control-label">新闻公告&gt;公告列表</label>
	              <input id="searchValue" name="searchValue" placeholder="请输入公告名称" class="form-control" style="float:right;width:15%;height:28px;">
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
	String userId = curUser.getUserId();
	//获取当前人信息
	List<String> depIds = curUser.getTotalDepIds();
	List<String> roleIds = curUser.getTotalRoleIds();
	String orgId = curUser.getOrgId();
	List<MFRole> positions = curUser.getPositions();
	StringBuffer hql = new StringBuffer();
	if(isDep!=null && "true".equals(isDep)){
		hql.append("from office.info.notice.noticeColumn where status=1 and isDepPlate=1");
		if(curUserDepCondition!=null && curUserDepCondition.trim().length()>0){
			hql.append(" and depId in"+curUserDepCondition);
		}
		hql.append(" order by cOrder asc");
		
	}else{
		hql.append("from office.info.notice.noticeColumn where status=1 and isDepPlate=0 order by cOrder asc");
	}
	try{
       	DataService ds = MFormContext.getService("DataService");
    	List<DataObject> plate = ds.queryList(hql.toString(), null);//查询所有公告栏目集合
      	for(DataObject dbo2:plate){%>
	<table width="99%" border="0" cellSpacing="0" cellPadding="0" style="margin:0 auto;">
	 <tbody>
	    <tr>
	      <td class="padding_lr_10" vAlign="top" colSpan="3">
	       <div style="wdith:100%;height:10px;"></div>
	        <div class="scrollList" id="scrollListDiv" style="overflow:hidden;">
	<!-- 栏目标题 -->
	<div class="index-type-name" style="padding-left:0px;position:relative;">
	   <div>
		  <div style="overflow:hidden;width:100%;" class="ibox-title">
		      <h5><%=dbo2.getString("name") %></h5>
		      <a style='float: right;text-decoration:none;' href=javascript:openCtpWindow({'url':'<%=request.getContextPath()%>/AllNoticeInfoList.rform?mHtml5Flag=true&uuid=<%=dbo2.getString("uuid")%>&style=<%=dbo2.getString("noticeStyle") %>'})>更多</a>
		  </div>  
	<%
	List totalRoleIds = new ArrayList();
	totalRoleIds.addAll(roleIds);
	StringBuffer sql = new StringBuffer();
	sql.append(" ( ( c_user_code ='"+userId+"' AND c_type =1");
		sql.append(" ) ");
		StringBuffer groupCriteria = new StringBuffer();
		for (int i = 0; i < depIds.size(); i++) {
			String depItemId = (String)depIds.get(i);
			if (groupCriteria.length() > 0)
				groupCriteria.append(" OR ");
			groupCriteria.append(" ( c_dept_code ='"+depItemId+"' AND c_type =2");
			groupCriteria.append(" ) ");
		}
		StringBuffer titleCriteria = new StringBuffer();
		for (int i = 0; i < totalRoleIds.size(); i++) {
			String roleItemId = (String)totalRoleIds.get(i);
			if (titleCriteria.length() > 0)
				titleCriteria.append(" OR ");
			titleCriteria.append(" ( c_role_code ='"+roleItemId+"' AND c_type=3");
			titleCriteria.append(" ) ");
		}
		
		//组织机构
		if(orgId!=null && orgId.trim().length()>0){
			StringBuffer str_ordId = new StringBuffer();
			//sql.append(getAllParentOrgId(orgId,str_ordId));
		}
		//对于岗位满足的(角色限定了部门)
		StringBuffer positionCriteria = new StringBuffer();
		for (int i = 0; i < positions.size(); i++) {
			MFRole mfRole = (MFRole)positions.get(i);
			if (positionCriteria.length() > 0)
				positionCriteria.append(" OR ");
			String depItemId = mfRole.getLimitDepId();
			String roleItemId = mfRole.getRoleId();
			positionCriteria.append(" ( c_dept_code ='"+depItemId+"' AND c_role_code='"+roleItemId+"' AND c_type =4 ");
			positionCriteria.append(" ) ");
		}
		if (depIds.size() >= 1) {
			sql.append(" OR ( ");
			sql.append(groupCriteria.toString());
			sql.append(" ) ");
		}
		if (totalRoleIds.size() >= 1) {
			sql.append(" OR ( ");
			sql.append(titleCriteria.toString());
			sql.append(" ) ");
		}
//		if(jointCriteria.length()>0){
//			sql.append(" OR ( ");
//			sql.append(jointCriteria.toString());
//			sql.append(" ) ");
//		}
		if(positionCriteria.length()>0){
			sql.append(" OR ( ");
			sql.append(positionCriteria.toString());
			sql.append(" ) ");
		}
		sql.append(" ) ");

	//构造授权信息
	/*StringBuffer queryHql=new StringBuffer();
	queryHql.append("select mBizId from office.archive.document.documentDetail where ");
	queryHql.append(sql.toString());
		DataService data = MFormContext.getService("DataService");
		StringBuilder sb = new StringBuilder();
		List<String> lis=data.queryList(queryHql.toString(),null);
		for(String s:lis){
			sb.append(",").append("'").append(s).append("'");
		}
		String str = "''";
		if(sb != null && sb.length()>0){
			str = sb.deleteCharAt(0).toString();
		}*/	
	 	StringBuffer hqls = new StringBuffer();
		if(searchValue!=null && searchValue!=""){
			hqls.append("from office.info.notice.noticeQueryInfo where o.uuid='"+dbo2.getString("uuid")+"' and o.C_NAME like '%"+searchValue+"%' and o.c_uuid in(select c_m_biz_id from mo_archive_security where "+sql.toString()+") and o.c_status=1 Order By o.top asc,o.auditDate desc");
		}else{
			hqls.append("from office.info.notice.noticeQueryInfo where o.uuid='"+dbo2.getString("uuid")+"' and o.c_uuid in(select c_m_biz_id from mo_archive_security where "+sql.toString()+") and o.c_status=1 Order By o.top asc,o.auditDate desc");
		}
		
		
		try{
	       	DataService cs = MFormContext.getService("DataService");
	    	List<DataObject> notice = cs.queryList2(hqls.toString(), null, 0, 6);
	    	int count = 0;
	  	    %>
	          <div class="ibox-content">
	          	<div class="mxt-grid-header ">
					<table class="sort ellipsis table-striped table-native" style="border:0px;table-layout: fixed;"
						id="leaveWord0" width="100%" border="0" cellSpacing="0" cellPadding="0">
						  <thead class="mxt-grid-thead" style="background-color: #FFFFFF">
							 <tr class="sort" style="background-color: #fafafa; height:36px;">
			          		  	<td  width="55%" class="headerButton" align="left" nowrap="true">公告名称</td>
			          		  	<td  width="10%" class="headerButton" align="left" nowrap="true">发布部门</td>
			          		  	<td  width="10%" class="headerButton" align="left" nowrap="true">发布人员</td>
			          		  	<td  width="15%" class="headerButton" align="left" nowrap="true">发布范围</td>
			          		  	<td  width="10%" class="headerButton" align="left" nowrap="true">发布时间</td>	
			          		  </tr>
			          	  </thead>
	          			  <tbody class="mxt-grid-tbody">
	          			<%if(notice!=null&&notice.size() > 0){
	          			for(DataObject dbo:notice){ %>

	          				<%if(count<6){ 
	          					String pubNameValue = dbo.getString("pubName")==null?"":dbo.getString("pubName");
	          					String pubDepNameValue = dbo.getString("pubDepName");
	          					if(pubDepNameValue == null)
	          						pubDepNameValue = "";
	          						java.text.SimpleDateFormat sdf =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		          		  		String value = "";
		          		  		if(dbo.getDate("auditDate") != null)
		          		  			value = sdf.format(dbo.getDate("auditDate"));   //审核发布时间
		          		  		String areaValue = dbo.getString("area")==null?"":dbo.getString("area");
		          		  	String nameValue = dbo.getString("name");
		          		  	//String status = dbo.getString("status");
		          		    String focus = dbo.getString("top");
	          		  		if("0".equals(focus)){
	          		  			nameValue="<img src='../../resource/images/intop.png'>"+nameValue;
	          		  		}
	          		  		int status = dbo.getInt("status");
	          		  		if(status==1){
	          				%>

	          		
	          		  <tr class="sort" erow="" style="height:35px">
	          		  	<td width="35%" style="color:rgb(51,51,51);padding-left:5px;" class="cursor-hand sort titleList">
	          		  	  <script>
	          		  				//	var uuid = '<%=dbo.getString("mBizId")%>';
	          		  				//	var name = '<%=dbo2.getString("noticeStyle")%>';
	          		  					function openWindow(mBizId,name,status){
											var url = "<%=request.getContextPath()%>/CustomerVelocityServlet?mBizId="+mBizId+"&name="+name+"&type=1&status="+status;
											var data = {};
											data.url = url;
											data.datagrid='';
											data.title = "公告信息";
											//window.open(url,'新闻信息');
											openCtpWindow(data);
										}
	          		  				</script>
	          		  	  <a class="title-already-visited" style="text-decoration:none; color:#000000" href=javascript:openWindow('<%=dbo.getString("mBizId")%>','<%=dbo2.getString("noticeStyle")%>','<%=dbo2.getString("status")%>')>
	          		  	  
	          		  	  <%=nameValue %></a>
	          		  	</td>
	          		  	<td class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
	          		  	<%=pubDepNameValue %>
	          		  	</td>
	          		  	<td class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
	          		  	<%=pubNameValue %>
	          		  	</td>
	     
	          		 <td class="title-already-visited-span sort" >
	          		  	 <%=areaValue %>
	          		  	</td> 	
	          		  	<td  class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
	          		  		
	          		  		 <%=value %>
	          		  	</td>
	          		  </tr>
	          		  	<%count++; }%>
	          		  	
	          		     	<%}else{break;}%>
	          		     
	          		    	<%}
	          		    }else{ %>
																<tr><td>暂无可查看的公告信息</td><td></td><td></td><td></td><td></td></tr>
															<%}
											%>
	          		</tbody>
	          	</table>
	          </div>
	        </div>
	        <div style="clear:both;"></div>
	    </div>
	</div>           
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