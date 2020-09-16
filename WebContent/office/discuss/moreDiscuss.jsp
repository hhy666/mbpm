 <%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.util.List"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.python.modules.re"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'moreDiscuss.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<link href="<%=request.getContextPath()%>/monitor/css/skin.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/monitor/css/default.css"
			rel="stylesheet" type="text/css" />
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
	<script language=javascript src='<%=request.getContextPath()%>/resource/js/office.js'></script>
	<script type="text/javascript">
		function openWindow(uuid){
			window.onunload=function(){
				window.opener.location.reload();
			}
			var url = "<%=request.getContextPath()%>/office/discuss/discussDetileInfo.jsp?uuid="+uuid;
			var data = {};
			data.url = url;
			data.datagrid='';
			data.title = "讨论信息";
			openCtpWindow(data);
		}
	
	</script>
	<style>
		h1 {
			-webkit-margin-before: 0em;
			-webkit-margin-after: 0em;
			width: 128px;
			height: 28px;
			font-size: 12px;
			background: url(../../resource/images/title.png) no-repeat;
			float: left;
			text-align: center;
			line-height: 28px;
			color: #fff;
		}
	
		.table-striped>tbody>tr:nth-child(odd)>td,.table-striped>tbody>tr:nth-child(odd)>th
		{
			background-color: #f9f9f9
		}
	
		.table-hover>tbody>tr:hover>td,.table-hover>tbody>tr:hover>th {
			background-color: #E1F2FA
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
		.head{
			background-image:url('images/page_head_bg.gif');
			width:100%;
			height:45px;
			margin:0px;
			position:fixed;
 			left:0;
 			top:0;
 			color:#fff;
 			font-family:'Microsoft YaHei',SimSun,Arial,Helvetica,sans-serif;
 			
		}
	</style>
  </head>
  
  <body class="page_content public_page" style="background: #ffffff;">
  	<div class="head">
  		<div style="font-size:18px;font-weight:bold;padding-left:10px;float:left;margin-top:17px"><%=request.getParameter("name") %></div>
  	</div>
  	<%! DataService ds = MFormContext.getService("DataService"); %>
    <%!	
    	public String authorCondition(String userId,List<String> depIds,List<String> roleIds,List<MFRole> positions){
			StringBuffer sql = new StringBuffer();
			sql.append(" ( ( userId ='" + userId + "' AND type =1");
			sql.append(" ) ");
			//遍历当前用户所属的roleId
			StringBuffer titleCriteria = new StringBuffer();
			for (int i = 0; i < roleIds.size(); i++) {
				String roleId = (String) roleIds.get(i);
				if (titleCriteria.length() > 0)
					titleCriteria.append(" OR ");
				titleCriteria.append(" ( roleId ='" + roleId
						+ "' AND type=3");
				titleCriteria.append(" ) ");
			}
			
			StringBuffer groupCriteria = new StringBuffer();
			for (int i = 0; i < depIds.size(); i++) {
				String depId = (String) depIds.get(i);
				if (groupCriteria.length() > 0)
					groupCriteria.append(" OR ");
				groupCriteria.append(" ( depId ='" + depId
						+ "' AND type =2");
				groupCriteria.append(" ) ");
			}
			
			//对于岗位满足的(角色限定了部门)
			StringBuffer positionCriteria = new StringBuffer();
			for (int i = 0; i < positions.size(); i++) {
				MFRole mfRole = (MFRole) positions.get(i);
				if (positionCriteria.length() > 0)
					positionCriteria.append(" OR ");
				String depItemId = mfRole.getLimitDepId();
				String roleItemId = mfRole.getRoleId();
				positionCriteria.append(" ( depId ='" + depItemId
						+ "' AND roleId='" + roleItemId + "' AND type =4 ");
				positionCriteria.append(" ) ");
			}
			if (depIds.size() >= 1) {
				sql.append(" OR ( ");
				sql.append(groupCriteria.toString());
				sql.append(" ) ");
			}
			if (roleIds.size() >= 1) {
				sql.append(" OR ( ");
				sql.append(titleCriteria.toString());
				sql.append(" ) ");
			}
			if (positionCriteria.length() > 0) {
				sql.append(" OR ( ");
				sql.append(positionCriteria.toString());
				sql.append(" ) ");
			}
			sql.append(" ) ");
			return sql.toString();
		}
		%>
    	<%MFUser curUser = MFormContext.getUser();
			//获取当前人信息
		String userId = curUser.getUserId();
		List<String> depIds = curUser.getTotalDepIds();
		List<String> roleIds = curUser.getRoleIds();
		List<MFRole> positions = curUser.getPositions();
		String sqlStr=authorCondition(userId,depIds,roleIds,positions);
		String column = request.getParameter("column");
		StringBuffer hqls = new StringBuffer(
				"from comprehensive.discuss.discussmodule.DiscussInfoBO where column='");
			hqls.append(column);
			hqls
				.append("' and uuid in (select mBizId from comprehensive.officesupplies.suppliesmodule.AuthorityBO where ");
			hqls.append(sqlStr);
			hqls.append(") Order By createDate desc");
			List<DataObject> discuss = ds.queryList(hqls.toString(), null);
	%>
	<div style="margin-top:45px">
		<div class="mxt-grid-header ">
			<table class="sort ellipsis table-hover table-striped"
				id="leaveWord0" width="100%" border="0" cellSpacing="0" cellPadding="0">
			<thead class="mxt-grid-thead" style="background-color: #FFFFFF">
				<tr class="sort" style="background-color: #fafafa">
					<td width="20%" align="left"
						style="background-color: #B5DBEB">
						标题
					</td>
					<td width="15%" align="left"
						style="background-color: #B5DBEB">
						发起者
					</td>
					<td width="13%" align="left"
						style="background-color: #B5DBEB">
						发起时间
					</td>
					<td width="35%" align="left"
						style="background-color: #B5DBEB">
						点击数
					</td>
					<td width="17%" align="left"
						style="background-color: #B5DBEB">
						回复数
					</td>
				</tr>
		</thead>
		<tbody class="mxt-grid-tbody">
		<%
			for (DataObject info : discuss) {
					String uuid = info.getString("uuid");
					String title = info.getString("title");
					String starter = info.getString("starter");
					SimpleDateFormat sdf = new SimpleDateFormat(
							"yyyy-MM-dd HH:mm");
					String createDate = "";
					if (info.getString("createDate") != null) {
						createDate = sdf.format(info
								.getDate("createDate"));
					}
					String counts = info.getString("counts");
					if (counts == null)
						counts = "0";
					String replyCounts = info
							.getString("replyCounts");
					if (replyCounts == null)
						replyCounts = "0";
		%>
					<tr class="sort" erow="">
						<td width="35%" style="color: rgb(51, 51, 51);"
							class="cursor-hand sort titleList">
							<a class="title-already-visited"
								href=javascript:openWindow('<%=info.getString("uuid")%>')>
								<%=title%></a>
						</td>
						<td width="20%" class="title-already-visited-span sort">
							<%=starter%>
						</td>
						<td width="18%" class="title-already-visited-span sort">
							<%=createDate%>
						</td>
						<td width="20%" class="title-already-visited-span sort" id="counts">
							<%=counts%>
						</td>
						<td width="27%" class="title-already-visited-span sort">
							<%=replyCounts%>
						</td>
					</tr>
		<%} //for%>
				</tbody>
			</table>
		</div>
	</div>
  </body>
</html>
