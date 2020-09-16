 <%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.util.List"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.python.modules.re"%>
<%@page import="com.matrix.office.common.CommonHelper"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
	</head>
	<script language=javascript src='<%=request.getContextPath()%>/resource/js/office.js'></script>
	<script type="text/javascript">
	function openWindow(uuid,type){
		window.onunload=function(){
			if(window.opener){
				window.opener.location.reload();	
			}		
		}
		if(type == '1'){
			var url = "<%=request.getContextPath()%>/office/discuss/discussDetileInfo.jsp?uuid="+uuid+"&isClick=1"; //isClick用来判断是点击进去的下个页面还是刷新下个页面
			var data = {};
			data.url = url;
			data.datagrid='';
			data.title = "讨论信息";
		}else if(type == '2'){
			var url = "<%=request.getContextPath()%>/office/discuss/MoreDiscussInfo.rform?mHtml5Flag=true&column="+uuid;
			var data = {};
			data.url = url;
			data.datagrid='';
			data.title = "更多讨论信息";
		}else if(type == '3'){
			var url = uuid;
			var data = {};
			data.url = url;
			data.datagrid='';
			data.title = "精华讨论信息";
		}
		openCtpWindow(data);
	}
	
	 function search(){
	    	document.getElementById("form01").action = "<%=request.getContextPath()%>/office/discuss/discussList.jsp";
	    	document.getElementById("form01").submit();
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
              <div class="input-group" style="margin-right:5px;margin-top: 5px;">
              	  <label id="label011" name="label011" style="font-size:18px;font-weight: normal;vertical-align:bottom;" class="control-label">调查讨论&gt;讨论列表</label>
	              <input id="searchValue" name="searchValue" placeholder="请输入讨论标题" class="form-control" style="float:right;width:15%;height:28px;">
				  <div class="input-group-btn">
                       <button type="submit" class="x-btn ok-btn btn-sm">搜索</button>              
                  </div>                                        
			  </div>
			 <div>
				  <a style="text-decoration:none;float:right;padding-right:7px;" href="javascript:openWindow('<%=request.getContextPath()%>/EssenceDiscuss.rform?mHtml5Flag=true','3')">
		            [查看精华帖]
		          </a>   
			</div>   
		  </form>
		</div>
		<%!DataService dataService = MFormContext.getService("DataService");%>
		<%!public String authorCondition(String userId,List<String> depIds,List<String> roleIds,List<MFRole> positions){
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
		} %>
		<%
			//获得文本框里面输入的条件
			String searchValue = request.getParameter("searchValue");
		
			MFUser curUser = MFormContext.getUser();
			//获取当前人信息
			String userId = curUser.getUserId();
			
			//******************************************************************
			//如果  在连接上传递  isDep=true  那么这里就要拼接当前人部门的过滤条件
			//如果  在连接上拼接  isDep=false 或者 不拼接  就直接查询非部门栏目的调查栏目列表
			//******************************************************************
			String isDep = request.getParameter("isDep");
			StringBuffer hql = new StringBuffer();
			String curUserDepCondition = CommonHelper.getCurUserDepIds(curUser);
			
			
			List<String> depIds = curUser.getTotalDepIds();
			List<String> roleIds = curUser.getTotalRoleIds();
			List<MFRole> positions = curUser.getPositions();
			String sqlStr=authorCondition(userId,depIds,roleIds,positions);
			if(isDep!=null && "true".equals(isDep)){
				//查当前人部门以及上级逐层部门中的栏目
				hql.append("from comprehensive.discuss.discussmodule.DiscussBoardBO where isDepPlate=1");
				if(curUserDepCondition!=null && curUserDepCondition.trim().length()>0){
					hql.append(" and depId in"+curUserDepCondition);
				}
			}else{
				hql.append("from comprehensive.discuss.discussmodule.DiscussBoardBO where isDepPlate=0");
				
			}
			hql.append(" order by cOrder asc ");
			try {
				List<DataObject> board = dataService.queryList(hql.toString(), null);
				for (DataObject obj : board) {
		%>
		<table width="99%" border="0" cellSpacing="0" cellPadding="0"
			style="margin: 0 auto;">
			<tbody>
				<tr>
					<td class="padding_lr_10" vAlign="top" colSpan="3">
						<!-- 让栏目之间产生间隔 -->
						<div style="wdith: 100%; height: 10px;"></div>
						<!-- 包括栏目标题与内容 -->
						<div class="scrollList" id="scrollListDiv"
							style="overflow: hidden;">
							<!-- 栏目标题 -->
							<div class="index-type-name"
								style="padding-left: 0px;  position: relative;">
								<div>
									<div style="overflow:hidden;width:100%;" class="ibox-title">
										<h5><%=obj.getString("name")%></h5>
										<a style='float: right; text-decoration:none;'
										href="javascript:openWindow('<%=obj.getString("uuid")%>','2')">更多</a>
									</div>
									<%
								StringBuffer hqls = new StringBuffer(
												"from comprehensive.discuss.discussmodule.DiscussInfoBO where column='");
										hqls.append(obj.getString("uuid"));
										if(searchValue!=null && searchValue!=""){
											hqls.append("' and title like '%"+searchValue+"%' and uuid in (select mBizId from comprehensive.officesupplies.suppliesmodule.AuthorityBO where ");
										}else{
											hqls.append("' and uuid in (select mBizId from comprehensive.officesupplies.suppliesmodule.AuthorityBO where ");
										}						
										hqls.append(sqlStr);
										hqls.append(") Order By essence asc,cOrder desc,createDate desc");
										try {
											List<DataObject> discuss = dataService.queryList2(hqls
													.toString(), null,0,6);
											int count = 0;
							%>
							<div class="ibox-content">
								<div class="mxt-grid-header ">
									<table class="sort ellipsis table-striped table-native" style="border:0px;table-layout: fixed;"
										id="leaveWord0" width="100%" border="0" cellSpacing="0"
										cellPadding="0">
										<thead class="mxt-grid-thead"
											style="background-color: #FFFFFF">
											<tr class="sort" style="background-color: #fafafa;height:36px;" >
												<td class="headerButton" width="40%" align="left" class="headerButton">
													标题
												</td>
												<td class="headerButton" width="20%" align="left" class="headerButton">
													发起者
												</td>
												<td class="headerButton" width="20%" align="left" class="headerButton">
													发起时间
												</td>
												<td class="headerButton" width="10%" align="left" class="headerButton">
													点击数
												</td>
												<td class="headerButton" width="10%" align="left" class="headerButton">
													回复数
												</td>
											</tr>
										</thead>
										<tbody class="mxt-grid-tbody">
											<%
												if(discuss!=null&&discuss.size() > 0){
												for (DataObject info : discuss) {
													if (count < 6) {
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
											<tr class="sort" erow="" style="height:30px;">
												<td width="40%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort">
												<% 	if("1".equals(info.getString("essence"))){%>
													<a class="title-already-visited" style="text-decoration:none; color:#000000;padding-left:5px;"
														href=javascript:openWindow('<%=info.getString("uuid")%>','1')><img src="<%=request.getContextPath()%>/resource/images/infocus.png">
														<%=title%></a>
												<%}else{ %>
													<a class="title-already-visited" style="text-decoration:none; color:#000000;padding-left:5px;"
														href=javascript:openWindow('<%=info.getString("uuid")%>','1')>
														<%=title%></a>
												<%} %>
												</td>
												<td width="20%" class="title-already-visited-span sort">
													<%=starter%>
												</td>
												<td width="20%" class="title-already-visited-span sort">
													<%=createDate%>
												</td>
												<td width="10%" class="title-already-visited-span sort" id="counts">
													<%=counts%>
												</td>
												<td width="10%" class="title-already-visited-span sort">
													<%=replyCounts%>
												</td>
											</tr>
											<%
												count++;
																} else {
																	break;
																}

															}
															}
															else{ %>
																<tr><td>暂无可查看的讨论信息</td><td></td><td></td><td></td><td></td></tr>
															<%}
											%>
										</tbody>
									</table>
								</div>
							</div>
							<div style="clear: both;"></div>
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