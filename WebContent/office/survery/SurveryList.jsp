<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.util.List"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.MFUser"%>
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
	</head>
	<script language=javascript
		src='<%=request.getContextPath()%>/resource/js/office.js'></script>
	<script type="text/javascript">
	function openSurveyWindow(uuid){
	
		var url = "<%=request.getContextPath()%>/office/survery/QuestionsList.jsp?invesInfoId="+uuid;
		var data = {};
		data.url = url;
		data.datagrid='';
		data.title = "调查信息";
		//window.open(url,'调查信息');
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
              	  <label id="label011" name="label011" style="font-size:18px;font-weight: normal;vertical-align:bottom;" class="control-label">调查讨论&gt;调查列表</label>
	              <input id="searchValue" name="searchValue" placeholder="请输入调查标题" class="form-control" style="float:right;width:15%;height:28px;">
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
		%>
		<%
			//******************************************************************
			//如果  在连接上传递  isDep=true  那么这里就要拼接当前人部门的过滤条件
			//如果  在连接上拼接  isDep=false 或者 不拼接  就直接查询非部门栏目的调查栏目列表
			//******************************************************************
			String isDep = request.getParameter("isDep");
			//String str = sb.deleteCharAt(0).toString();
			StringBuffer hql = new StringBuffer();
			String curUserDepCondition = CommonHelper.getCurUserDepIds(curUser);
			if(isDep!=null && "true".equals(isDep)){
				//查当前人部门以及上级逐层部门中的栏目
				hql.append("from comprehensive.survery.surverymodule.SurveryColumnBo where isDepPlate=1");
				if(curUserDepCondition!=null && curUserDepCondition.trim().length()>0){
					hql.append(" and depId in"+curUserDepCondition);
				}
				
			}else{
				hql.append("from comprehensive.survery.surverymodule.SurveryColumnBo where isDepPlate=0");///默认查不是部门调查栏目的调查栏目
			}
			hql.append(" order by cOrder asc ");
			try {
				DataService ds = MFormContext.getService("DataService");
				List<DataObject> plate = ds.queryList(hql.toString(), null);
				for (DataObject dbo2 : plate) {
		%>

		<table width="99%" border="0" cellSpacing="0" cellPadding="0"
			style="margin: 0 auto;">
			<tbody>
				<tr>
					<td class="padding_lr_10" vAlign="top" colSpan="3">
						<div style="wdith: 100%; height: 10px;"></div>
						<div class="scrollList" id="scrollListDiv"
							style="overflow: hidden;">
							<!-- 栏目标题} -->
							<div class="index-type-name" style="padding-left: 0px; position: relative;">
								<div>
									<div style="overflow:hidden;width:100%;" class="ibox-title">
										<h5><%=dbo2.getString("name")%></h5>
										<a style='float: right;text-decoration:none;'
										href=javascript:openCtpWindow({'url':'<%=request.getContextPath()%>/SurveryInfoList.rform?mHtml5Flag=true&invesPlateId=<%=dbo2.getString("uuid")%>'})>
										     更多
								        </a>
									</div>
									
									<%
								
										try {
											StringBuffer hql1 = new StringBuffer();
											DataService cs = MFormContext.getService("DataService");
											String sql = CommonHelper.generateCriteria2(curUser);
											List authlist=cs.querySqlList("select  C_M_BIZ_ID from MO_Archive_Security where "
													+ sql + " UNION ALL select M_BIZ_ID from MO_AUTHORITY_BO where c_user_Id='"+curUser.getUserId()+"'",null,null);
											List<String> depIdList = MFormContext.getUser().getTotalDepIds();
											StringBuffer depIdSql = new StringBuffer();
											depIdSql.append("(");
											for(int i=0; i<depIdList.size(); i++){
												String depId = depIdList.get(i);
												depIdSql.append("'");
												depIdSql.append(depId);
												if(i == depIdList.size()-1){
													depIdSql.append("'");
												}else{
													depIdSql.append("',");
												}
											}
											depIdSql.append(")");
											StringBuffer str = new StringBuffer();
											if(authlist!=null && authlist.size()>0){
												str.append("(");
												for(Object obj:authlist){
														str.append("'");
													str.append(obj.toString());
													str.append("'");
													if(!obj.equals(authlist.get(authlist.size()-1))){
														str.append(",");
													}
												}
											str.append(")");
                                           	}
											//根据当前登录人用户编码取得对应所有部门 角色 人员编码
											StringBuffer condition = new StringBuffer();
										    condition = com.matrix.office.investigation.common.CommonHelper.getCondition(curUser);
										    StringBuffer filter = new StringBuffer();
										    filter.append("(");
										    if(condition.toString()!=null && condition.toString().trim().length()>0){
										    	String[] conditionAarray = condition.toString().split(";");
												for(int i = 0;i<conditionAarray.length;i++){
													String term = conditionAarray[i];	
													filter.append(" publicDepId like '%"+term+"%' ");              //查询当前登录人在调查范围的调查
													if(!term.equals(conditionAarray[conditionAarray.length-1])){
														filter.append("or");
													}
												}
										    }
										    filter.append("or publicDepId like '%root%'");
										    filter.append(")");
										    //System.out.print(filter);
										    
											hql1.append("from comprehensive.survery.surverymodule.SurveryInfoBo where "+filter+"");
//											hql1.append("where mBizId in (select mBizId from comprehensive.survery.surverymodule.SurveryInfoBo where publicDepId in "+depIdSql+")");
//											hql1.append("where ( mBizId in ( select  mBizId from office.archive.document.documentDetail where "
//													+ sql + " ) or mBizId in ( select mBizId from comprehensive.officesupplies.suppliesmodule.AuthorityBO where c_user_Id='"+curUser.getUserId()+"' ))");
											if(searchValue!=null && searchValue!=""){
												hql1.append(" and title like '%"+searchValue+"%'");
											}
											hql1.append(" and invesPlateId='"+dbo2.getString("uuid")+"'");
											hql1.append(" and status='1'");
											hql1.append(" order by startTime desc");
											List<DataObject> notice = cs.queryList2(hql1.toString(),
													null,0,6);
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
												<td width="35%" align="left" class="headerButton">
													标题
												</td>
												<td width="10%" align="left" class="headerButton">
													管理员
												</td>
												<td width="15%" align="left" class="headerButton">
													发布范围
												</td>
												<td width="10%" align="left" class="headerButton">
													开始时间
												</td>
												<td width="10%" align="left" class="headerButton">
													结束时间
												</td>
												<td width="10%" align="left" class="headerButton">
													发起人
												</td>
											</tr>
										</thead>
										<tbody class="mxt-grid-tbody">

											<%if(notice!=null&&notice.size() > 0){
												for (DataObject dbo : notice) {
											%>

											<%
												if (count < 6) {
																	String area = dbo.getString("area") == null ? ""
																			: dbo.getString("area");
																	String publicDep = dbo.getString("publicDep");
																	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
																			"yyyy-MM-dd HH:mm");
																	String startTime = "";
																	String endTime = "";
																	if (dbo.getDate("startTime") != null)
																		startTime = sdf.format(dbo
																				.getDate("startTime"));
																	if (dbo.getDate("endTime") != null)
																		endTime = sdf
																				.format(dbo.getDate("endTime"));
																	String starterId = dbo.getString("starterName");
																	String title = dbo.getString("title");
																	//int status = dbo.getInt("status");
																	//if(status==1){
											%>


											<tr class="sort" erow="" style="height:35px">
												<td width="15%" style="color: rgb(51, 51, 51);"
													class="title-already-visited-span sort">
													<script>
	          		  								</script>
													<a class="title-already-visited" style="text-decoration:none; color:#000000;padding-left:5px;"
														href=javascript:openSurveyWindow('<%=dbo.getString("mBizId")%>')>
														
														<%=title%></a>
												</td>
												<td width="15%" class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
													<%=area%>
												</td>
												<td width="15%" class="title-already-visited-span sort" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
													<%=publicDep%>
												</td>
												<td width="20%" class="title-already-visited-span sort">
													<%=startTime%>
												</td>

												<td width="20%" class="title-already-visited-span sort">

													<%=endTime%>

												</td>
												<td width="15%" class="title-already-visited-span sort">


													<%=starterId%>

												</td>
											</tr>
											<%
												count++;
																	//}
																} else {
																	break;
																}

															}	}else{ %>
																<tr><td>暂无可查看的调查信息</td><td></td><td></td><td></td><td></td><td></td></tr>
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