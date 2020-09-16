<%@page import="java.text.SimpleDateFormat"%>
<%@page pageEncoding="utf-8"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService" %>
<%@page import="java.util.List" %>
<%@page import="java.util.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.ArrayList" %>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.api.identity.*"%>
<%@page import="java.util.Map"%>
<%@page import="com.matrix.office.investigation.common.CommonHelper"%>
<!DOCTYPE HTML>

<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<title>调查结果页面</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<link href="survey.css" rel="stylesheet" type="text/css"/>
<style type="text/css">

</style>
<script>
	function backToVote(invesInfoId){
	 // window.close();
	 if("false"!="true")
	 {	
	    var infoRes = "${param.infoRes}";
		window.location.href=webContextPath+"/office/survery/QuestionsList.jsp?invesInfoId="+invesInfoId+"&infoRes="+infoRes+"&readOnly=readOnly";
	  }else
	  {
		var ddd = parent.parent.parent.location;
		parent.parent.parent.location.href = ddd;
	  	//window.close();
	  }
	}
	function deleteThisComment(uuid){
		var url = webContextPath+"/investigation/investigation_deleteInvesComment.action?uuid="+uuid;
		
		var xhr = newXMLHttpRequest();
		xhr.onreadystatechange=function(){
  			if (xhr.readyState==4 && xhr.status==200){
  				var responseText = xhr.responseText;
  				var json = eval('('+responseText+")");
  				if(json.result){
	  				document.getElementById(uuid).style.display="none";
  				}
    			//document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
    		}
  		}
		xhr.open("GET",url,true);
		xhr.send();
		/**
		Matrix.confirm("确认删除？",function(value){
			if(value){
				Matrix.sendRequest(url,{'uuid':uuid} function(data){
					if(data && data.data){
						result = isc.JSON.decode(data.data);
						if(result.result){
							document.location.reload();
						}
					}
					
				});
			}
		});
		**/
	}
	
	
	//ajax Request
	function newXMLHttpRequest() {
 		var xmlreq = false;
 		if (window.XMLHttpRequest) {
 			xmlreq = new XMLHttpRequest();
 		} else if (window.ActiveXObject) {
 			try {
 				xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
 			} catch (e1) {
 				try {
					xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
				}catch (e2) {
				}
			}
		}
		return xmlreq;
	}
	//表单初始加载方法
	window.onload=function(){
		
	}
</script>
</head>
<script language=javascript src='<%=request.getContextPath()%>/resource/js/office.js'></script>
<script type="text/javascript">
	
</script>
<body style="overflow:auto;">
<jsp:include page="/form/admin/common/loading.jsp" />

<script>
 var Mform0=isc.MatrixForm.create({
 				ID:"Mform0",
 				name:"Mform0",
 				position:"absolute",
 				action:"",
 				fields:[{
 					name:'form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'form0_hidden_text_div'
 				}]
  });
</script>
<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" class="main-bg" style="height: calc(100% - 43px);">
		<tr class="page2-header-line">
			<td width="100%" height="40px" valign="top" class="page-list-border-LRD">
		 		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">	     	
     				<tr class="page2-header-line">
       					<td width="45" class="page2-header-img"><div class="inquiryIndex"></div></td>
						<td id="notepagerTitle1" class="page2-header-bg">调查</td>
						<td class="page2-header-line padding-right" align="right">&nbsp;</td>
	        		</tr>		 			
		 		</table>
			</td>
		</tr>
		<tr>
		<%
			String invesInfoId = request.getParameter("invesInfoId");
			String voteStyle = "0";
			DataService ds = MFormContext.getService("DataService");
			if(invesInfoId!=null && invesInfoId.trim().length()>0){
				if(invesInfoId!=null && invesInfoId.trim().length()>0){
					//调查信息主键存在
					try{
						DataObject invesInfo = ds.load("comprehensive.survery.surverymodule.SurveryInfoBo",invesInfoId);
						if(invesInfo!=null){
							Date toDate = invesInfo.getDate("endTime");
							int isOverInves = invesInfo.getInt("isOverInves");//是否结束调查 0 未结束调查  1 结束调查
							Date now = new Date();
							String isOver = "开启";
							if(isOverInves==1){
								isOver = "结束";
							}
							Date startTime = invesInfo.getDate("startTime");
							String invesTitle = invesInfo.getString("title");
							String starterName = invesInfo.getString("starterName");
							String surveryColumn = invesInfo.getString("surveryColumn");//调查栏目
							String starterDep = invesInfo.getString("starterDep");//发起部门
							String starter = invesInfo.getString("starterId");//发起人
							String publicDepId = invesInfo.getString("publicDepId");
							voteStyle = invesInfo.getString("voteStyle");//投票方式
							String publicDep = invesInfo.getString("publicDep");//发布范围
							String voteName = "实名";
							if("0".equals(voteStyle)){
								voteName = "匿名";
							}
							String canSee = invesInfo.getString("canSee");
							String desc = invesInfo.getString("description");//调查描述
							if(desc==null){
								desc = "";
							}
							java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
							String end = "";
							if(toDate!=null){
								end = sdf1.format(toDate);
							}
							if(publicDep==null || "null".equals(publicDep)||"undefined".equals(publicDep)){
								publicDep="";								
							}
		%>
			<td  valign="top" style="height:28px">
				<!-- 调查标题 -->
				<table height="100%" width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="webfx-menu-bar" style="height:26px">&nbsp;
				 			<font style="font-size:12px;font-weight:bold;">
				 				<%=invesTitle %>（<%=isOver %>）
		         			</font>				 
			    		</td>
			    	</tr>		
	  			</table>
  			</td>
		</tr>
		<tr>
			<td class="border-top" style="width:10%;height:92%;">
				<!-- 该td是内容区域的td -->	
				<table style="width:100%;height:100%">
					<tr>
						<td style="width:25%;height:100%;" class="bbs-bg border-bottom page-list-border-LRD">
						<!-- 调查问卷信息区域 -->
							<table width="100%;height:100%" border="0" align="left" valign="top">
                                    <tr>
                                    	<td colspan="4">&nbsp;</td>
                                    </tr>
							        <tr>
										<td width="10%">&nbsp;</td>
										<td width="2%"><img src="../../resource/images/dian.gif"></td> <td width="78%" colspan="2">标题:</td>
									</tr>
									<tr>
										 <td width="10%">&nbsp;</td>
										 <td width="2%">&nbsp;</td>
										<td width="78%" colspan="2"><%=invesTitle %></td>
									</tr>
									<tr height="2px">
										<td>&nbsp;</td>
										<td colspan="2" height="2px"><div class="lineDetail"><sub></sub></div></td>
									 </tr>	
									<tr>
										<td width="10%">&nbsp;</td>
										<td width="2%"><img src="../../resource/images/dian.gif"></td> <td width="78%" colspan="2">发起者:</td>
									</tr>
									<tr>
										<td width="10%">&nbsp;</td>
										<td width="2%">&nbsp;</td>
										<td width="78%" colspan="2"><%=starterName %></td>
									</tr>
									 <tr height="2px">
										<td>&nbsp;</td>
										 <td colspan="2" height="2px"><div class="lineDetail"><sub></sub></div></td>
									</tr>								        
							        <tr>
							           <td width="10%">&nbsp;</td>
								       <td width="2%"><img src="../../resource/images/dian.gif"></td> 
									   <td width="78%" colspan="2">发起部门:</td>
						            </tr>
							        <tr>
							          <td>&nbsp;</td>
							          <td>&nbsp;</td>
							          <td><%=starterDep %> </td>
							        </tr>
							        <tr height="2px">
							          <td>&nbsp;</td>
							          <td colspan="3" height="2px"><div class="lineDetail"><sub></sub></div></td>
							        </tr>
							        <tr>
							          <td>&nbsp;</td>
								      <td><img src="../../resource/images/dian.gif"></td> 
									  <td colspan="2">调查板块:</td>
						            </tr>
						            <tr>
						              <td>&nbsp;</td>
							          <td>&nbsp;</td>
							          <td>
									  <%=surveryColumn %></td>
							        </tr>
							        <tr height="2px">
							          <td>&nbsp;</td>
							          <td colspan="3" height="2px"><div class="lineDetail"><sub></sub></div></td>
							        </tr>
							        <tr>
							         <td>&nbsp;</td>
								     <td><img src="../../resource/images/dian.gif"></td> 
									 <td colspan="2">调查期限:</td>
						            </tr>
							        <tr>
							          <td>&nbsp;</td>
							          <td>&nbsp;</td>
							          <td colspan="2">
									   <%=sdf1.format(startTime) %>  &nbsp;&nbsp;至
									  </td>   
							       </tr>
							       <tr>
							          <td>&nbsp;</td>
							          <td>&nbsp;</td>
							          <td colspan="2">
										<%=end %>          
									  </td>  
							      </tr>
							      <tr height="2px">
							         <td>&nbsp;</td>
							         <td colspan="3" height="2px"><div class="lineDetail"><sub></sub></div></td>
							      </tr>						      							     
							      <tr>
							         <td>&nbsp;</td>
								     <td><img src="../../resource/images/dian.gif"></td>
								     <td colspan="2">
								                  发布范围:
								     </td>
						          </tr>
								  <tr>
								     <td>&nbsp;</td>
									 <td>&nbsp;</td>
									 <td colspan="2"><div style=" width:180px;overflow:hidden; text-overflow:ellipsis;" title="<%=publicDep %>"><nobr><%=publicDep %></nobr></div></td>
							     </tr>
							     <tr height="2px">
							     	<td>&nbsp;</td>
                                     <td colspan="3" height="2px"><div class="lineDetail"><sub></sub></div></td>
                                 </tr> 
                                 <tr>
                                      <td></td>
                                      <td width="2%"><img src="../../resource/images/dian.gif"></td> <td width="98%" colspan="2">投票方式:</td>
                                 </tr>
                                 <tr>
                                      <td width="2%">&nbsp;</td>
                                      <td colspan="2">
                                       <div style=" width:280px;overflow:hidden; text-overflow:ellipsis;" title="质量管理部">
                                        <nobr>
                      				
			
			
				<input id="cryptonym2" type="radio" name="cryptonym" disabled="disabled" checked="checked">
                  										 <%=voteName %>
                  										<br>
                  										 <br>
                                                           <%
                                                          if("0".equals(voteStyle)){  //匿名
                                                          	if("1".equals(canSee)){
                                                          %>
                                                          	 <input id="allowAdminViewResult" name="allowAdminViewResult" disabled="disabled" type="checkbox" checked="checked">
                                                          发起人/板块管理员可查看已投票和未投票人及问卷选择结果
                                                          <%
                                                          	}else{
                                                          %>		
                                                          	<input id="allowAdminViewResult" name="allowAdminViewResult" disabled="disabled" type="checkbox" >
                                                          发起人/板块管理员可查看已投票和未投票人及问卷选择结果
                                                          <%		
                                                          	}
                                                          }
                                                          %>
            							 </nobr>
                     				    </div>
                    				   </td>
                       			  </tr>
						      </table>
						</td>					
						<td style="width:75%;height:100%;vertical-align: top;">
						<!-- 编辑区域 -->
						<!-- ------------------------------------------------------------------------------------------- -->
							<table width="100%"  border="0" cellspacing="0" cellpadding="0" style="word-break:break-all;word-wrap:break-word;height:100%;">
										<tr>
											<td class="tbCell4 bbs-tb-padding2 " valign="top">
												<p class="border-padding" id="invesDesc">
													<%=desc %>
												</p>
												<div id="bodyContent" style="overflow: auto;">
														<!-- 调查结果列表 -->
												<%
													//当前人
													MFUser curUser = MFormContext.getUser();
													String userId = curUser.getUserId();
													boolean isAdmin = false;
													if(userId.equals(starter)){
														//当前人是发起人
														isAdmin = true;
													}
													String hql = "from comprehensive.survery.surverymodule.SueverySubjectInfoBo where invesInfoId = '"+invesInfoId+"'";
													List<DataObject> subjectList = ds.queryList(hql,null);//存在
													if(subjectList!=null && subjectList.size()>0){//调查有题目列表
														String condition = CommonHelper.ListConvert2HqlConditionStr(subjectList,"uuid");
														String resultHql = "from comprehensive.survery.surverymodule.InvestigationResultBO where invesInfoId='"+invesInfoId+"' and invesSubjectId in "+condition;
														List<DataObject> resultList = ds.queryList(resultHql,null);
														Map<String,List<DataObject>> map = new HashMap<String,List<DataObject>>();
														if(resultList!=null && resultList.size()>0){//存在结果
															map = CommonHelper.getOptionResultMap(subjectList,resultList);
														}
														for(int i = 0;i<subjectList.size();i++){
															DataObject subject = subjectList.get(i);
															String name = subject.getString("name");//调查题目名称
															String selectWay = subject.getString("selectionType");//选择方式 0 单选 ；1 多选； 2 问答
															String selectWayName = "单选";
															if("1".equals(selectWay)){
																selectWayName = "多选";
															}else if("2".equals(selectWay)){
																selectWayName = "问答式";															
															}
															String maxSelectNum = subject.getString("maxSelectionCount");//最大选择数
															String isOtherSelect = subject.getString("isOtherSelect");//其他选项
															String isAllowComment = subject.getString("isAllowComment");//允许评论
															String otherContent = subject.getString("otherContent");//其他选项内容
															String commentContent = subject.getString("commentContent");//评论内容
															if(map!=null && map.keySet().size()>0){
															List<DataObject> results = map.get(subject.getString("uuid"));//调查题目结果列表
															if("0".equals(selectWay)){//单选
																String optionHql = "from comprehensive.survery.surverymodule.SujectSelectInfoBO where subjectId='"+subject.getString("uuid")+"'";
																List<DataObject> subjectOptions = ds.queryList(optionHql,null);
																if(subjectOptions!=null && subjectOptions.size()>0){
																	
												%>
													<table border="0" width="100%" cellpadding="0" cellspacing="0" align="center" class="">
														<!-- field begin -->
														<tr bgcolor="#ffffff" align="left" class="bbs-title-bar , bbs-td-center">
															<th width="50%">
															<!-- 调查题目div -->
																<div style=" width: 550px;overflow:hidden; text-overflow:ellipsis; cursor: hand;height:25px;line-height: 25px;vertical-align: middle;padding-left: 5px;" title="<%=name %>">
																	<nobr><%=i+1 %>、<%=name %>（<%=selectWayName %>）
																	</nobr>
																</div>
															</th>
															<th width="25%"></th>
															<th width="10%">投票数</th>
															<th width="10%">百分比</th>
														</tr>
														<%
															int totalVoteNum = 0;
															for(int y = 0;y<subjectOptions.size();y++){
																DataObject option = subjectOptions.get(y);//获得选项对象
																if(results!=null && results.size()>0){
																for(DataObject result:results){
																	if(result.getString("result")!=null && option.getString("uuid")!=null){
																		if(result.getString("result").equals(option.getString("uuid"))){
																			totalVoteNum++;
																		}
																	}
																	
																}
																}
															}
															java.text.DecimalFormat df = new java.text.DecimalFormat("#00.0");  
															for(int x = 0;x<subjectOptions.size();x++){
																DataObject option = subjectOptions.get(x);//获得选项对象
																String optionName = option.getString("selectContent");
																int voteNum = 0;
																if(results!=null && results.size()>0){
																for(DataObject result:results){
																	if(result.getString("result")!=null && option.getString("uuid")!=null){
																		if(result.getString("result").equals(option.getString("uuid"))){
																			voteNum=voteNum+1;
																		}
																	}
																}
																}
																String width = df.format(((double)voteNum/totalVoteNum)*100)+"px";
																String percent = "0.0%";
																if(voteNum!=0){
																	percent = df.format(((double)voteNum/totalVoteNum)*100)+"%";
																}
																int mod = x%5;
														%>
														<tr bgcolor="#ffffff">
															<td width="50%">
																<div style="overflow:hidden; text-overflow:ellipsis; cursor: hand" title="<%=optionName %>"><nobr><%=optionName %></nobr></div>
															</td>
															<td width="30%">
                                                   				<img id="sss" src="../../resource/images/<%=mod %>.gif" width="<%=width %>" height="15px">
															</td>
															<td width="10%">
																<%=voteNum %>
															</td>
															<td width="10%">
																<%=percent %>
															</td>
														</tr>																								
														<%
															}
															
														%>
													</table>
															<%
																if("true".equals(isAllowComment)){//允许评论
															%>
															<table width="100%" style="">
															<tr bgcolor="#ffffff" style="height:100%;">
																<td  width="100%" style="padding: 0" class="border-top">				
																	<div id="printDiscuss" style="height:100%; overflow: auto;">
														 				<div class="mxt-grid-header" style="height:100%; overflow: auto;">
														 				<table id="aaaa" class="sort" width="100%" border="0" cellspacing="0" cellpadding="0" onClick="" dragable="false" style="">
																			<thead class="mxt-grid-thead">
																				<tr class="sort">
																					<td width="35%" align="left">评论内容</td>
																					<td width="20%" type="Date" align="left">评论时间</td>
																					<%
																						if("1".equals(voteStyle)) {		//实名															
																					%>
																						
																						<td width="20%" align="left">评论人</td>
																					<%  
																						}
																					%>
																					
																					<%
																						if(isAdmin){//是管理员  添加删除操作
																							%>
																								<td width="20%" type="Date" align="left"> 操作</td>
																							<%
																						}else{
																							%>
																								<td width="20%" type="Date" align="left"></td>
																							<%
																							
																						}
																					%>
																				</tr>
																			</thead>
															 				<tbody class="mxt-grid-tbody" style="height:100%;">
														
															<%
															java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
																String commentHql = "from comprehensive.survery.surverymodule.InvestigationResultBO where invesSubjectId='"+subject.getString("uuid")+"' and type=3";
																List<DataObject> comments = ds.queryList(commentHql,null);
																if(comments!=null && comments.size()>0){
																	for(DataObject comment:comments){
																		String commmentId = comment.getString("uuid");
																		Date joinDate = comment.getDate("joinDate");
																		java.sql.Timestamp time = new  java.sql.Timestamp(joinDate.getTime());
																		String joinDateStr = sdf.format(time);
																		String content = comment.getString("result");
																		String userCommentId = comment.getString("userId");
																		String userName = "";
																		if(userId!=null && userId.trim().length()>0){
																			userName = (String)ds.queryValue("select userName from foundation.org.User where userId = '"+userCommentId+"'", null);
																		}
																		%>
																		<!-- 循环tr -->
																				<tr class="sort" erow="" id="<%=commmentId %>">
																					<td title="<%=content %>" class="sort " width="35%"><%=content %></td>
																					<td align="left" class="sort " width="20%"><%=joinDateStr %></td>
																					<%
																						if("1".equals(voteStyle)) {		//实名															
																					%>
																					 	<td  class="sort " width="20%"><%=userName %></td>
																					<%  
																						} 
																					%>
																					
																				
																					<%
																						if(isAdmin){//是管理员  添加删除操作
																							%>
																								<td width="20%" type="Date" align="left"><a style="text-decoration:none" width="100%" href=javascript:deleteThisComment('<%=commmentId %>')>删除</a></td>
																							<%
																						}else{
																							%>
																							<td width="20%" type="Date" align="left"></td>
																						
																						<%
																							
																						}
																					%>
																				</tr>
																	<%	
																		//break;
																	}
																	
																}
																
														%>
																			</tbody>
																		</table>
																		</div>
																	</div>			
																</td>
															</tr>				
														</table>
														
														<% 
																
															}
														%>													
												</div>
											
																
																<%
																}
															}else if("1".equals(selectWay)){//复选结果
																String optionHql = "from comprehensive.survery.surverymodule.SujectSelectInfoBO where subjectId='"+subject.getString("uuid")+"'";
																List<DataObject> subjectOptions = ds.queryList(optionHql,null);
																if(subjectOptions!=null && subjectOptions.size()>0){
															%>					
												
														<table border="0" width="100%" cellpadding="0" cellspacing="0" align="center" class="border-top border-left border-right">
																<tr bgcolor="#ffffff" align="left" class="bbs-title-bar , bbs-td-center">
																	<th width="50%">
																		<div style=" width: 350px;overflow:hidden; text-overflow:ellipsis; cursor: hand;height:25px;line-height: 25px;vertical-align: middle;padding-left: 5px;" title="<%=name %>">
																			<nobr><%=i+1 %>、<%=name %>（<%=selectWayName %>）
																			</nobr>
																		</div>
																	</th>
																	<th width="30%"></th>
																	<th width="10%">投票数</th>
																	<th width="10%">百分比</th>	
																</tr>
																<%
																int totalVoteNum = 0;
																for(int y = 0;y<subjectOptions.size();y++){
																	DataObject option = subjectOptions.get(y);//获得选项对象
																	if(results!=null && results.size()>0){
																		for(DataObject result:results){
																			if(result.getString("result")!=null && option.getString("uuid")!=null){
																				if(result.getString("result").equals(option.getString("uuid"))){
																					totalVoteNum++;
																				}
																			}
																		}
																	}
																}
																	java.text.DecimalFormat df = new java.text.DecimalFormat("#00.0");  
																	for(int x = 0;x<subjectOptions.size();x++){
																		DataObject option = subjectOptions.get(x);//获得选项对象
																		String optionName = option.getString("selectContent");
																		int voteNum = 0;
																		if(results!=null && results.size()>0){
																			for(DataObject result:results){
																				if(result.getString("result")!=null && option.getString("uuid")!=null){
																					if(result.getString("result").equals(option.getString("uuid"))){
																						voteNum+=1;
																					}
																				}
																			}
																		}
																		String percent = "0.0%";
																		if(voteNum!=0){
																			percent = df.format(((double)voteNum/totalVoteNum)*100)+"%";
																		}
																		String width = df.format(((double)voteNum/totalVoteNum)*100)+"px";
																		int mod = x%5;
																%>
																<tr bgcolor="#ffffff">
																	<td width="50%">
																		<div style="overflow:hidden; text-overflow:ellipsis; cursor: hand" title="<%=optionName %>"><nobr><%=optionName %></nobr></div>
																	</td>
																	<td width="30%">
		                                                   				<img id="sss" src="../../resource/images/<%=mod %>.gif" width="<%=width %>" height="15px">
																	</td>
																	<td width="10%">
																		<%=voteNum %>
																	</td>
																	<td width="10%">
																		<%=percent %>
																	</td>
																</tr>
																
																<%
																
																	}
																	
																%>
																</table>
																<% 
																	if("true".equals(isAllowComment)){//允许评论
																%>
																<table width="100%">
																<tr bgcolor="#ffffff">
																<td  width="100%" style="padding: 0" class="border-top">				
																	<div id="printDiscuss">
														 				<div class="mxt-grid-header">
														 				<table id="aaaa" class="sort" width="100%" border="0" cellspacing="0" cellpadding="0" onClick="sortColumn(event, true, false)" dragable="false">
																			<thead class="mxt-grid-thead">
																				<tr class="sort">
																					<td width="35%" align="left">评论内容</td>
																					<td width="20%" type="Date" align="left">评论时间</td>
																					<%
																						if("1".equals(voteStyle)) {		//实名															
																					%>
																						
																						<td width="20%" align="left">评论人</td>
																					<%  
																						}
																					%>
																					<%
																						if(isAdmin){//是管理员  添加删除操作
																							%>
																								<td width="20%" type="Date" align="left"> 操作</td>
																							<%
																						}else{
																							%>
																							<td width="20%" type="Date" align="left"></td>
																						<%
																							
																						}
																					%>
																				</tr>
																			</thead>
															 				<tbody class="mxt-grid-tbody">
																	<%
																	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
																String commentHql = "from comprehensive.survery.surverymodule.InvestigationResultBO where invesSubjectId='"+subject.getString("uuid")+"' and type=4";
																List<DataObject> comments = ds.queryList(commentHql,null);
																if(comments!=null && comments.size()>0){
																	for(DataObject comment:comments){
																		String commmentId = comment.getString("uuid");
																		Date joinDate = comment.getDate("joinDate");
																		java.sql.Timestamp time = new  java.sql.Timestamp(joinDate.getTime());
																		String joinDateStr = sdf.format(time);
																		String content = comment.getString("result");
																		String userCommentId = comment.getString("userId");
																		String userName = "";
																		if(userId!=null && userId.trim().length()>0){
																			userName = (String)ds.queryValue("select userName from foundation.org.User where userId = '"+userCommentId+"'", null);
																		}
																		
																		%>
																		<!-- 循环tr -->
																				<tr class="sort" erow="" id="<%=commmentId %>">
																					<td title="<%=content %>" class="sort " width="35%"><%=content %></td>
																					<td align="left" class="sort " width="20%"><%=joinDateStr %></td>
																					<%
																						if("1".equals(voteStyle)) {		//实名															
																					%>
																						
																						<td  class="sort " width="20%"><%=userName %></td>
																					<%  
																						}
																					%>

																		<%
																		if(isAdmin){//是管理员  添加删除操作
																			%>
																				<td width="20%" type="Date" align="left"><a style="text-decoration:none" width="100%" href=javascript:deleteThisComment('<%=commmentId %>')>删除</a></td>
																			
																			<%
																		}else{
																			%>
																			<td width="20%" type="Date" align="left"></td>
																		
																		<%
																			
																		}
																					%>
																				</tr>
																	<%	
																		
																	}
																	%>
																			</tbody>
																		</table>
																		</div>
																	</div>				
																</td>
																</tr>				
														</table>
																	<%
																	
																}
																
														%>
																	
																<%
																	}
															}
														}else if("2".equals(selectWay)){
															%>		
															<table border="0" width="100%" cellpadding="0" cellspacing="0" align="center" class="border-top border-left border-right">
																	<tr bgcolor="#ffffff" align="left" class="bbs-title-bar , bbs-td-center">
																		<th >
																			<div style=" width: 350px;overflow:hidden; text-overflow:ellipsis; cursor: hand;height:25px;line-height: 25px;vertical-align: middle;padding-left: 5px;" title="业务知识的学习">
																				<nobr><%=i+1 %>、<%=name %>（<%=selectWayName %>）
																				</nobr>
																			</div>
																		</th>
																		<th></th>
																		<th></th>
																	</tr>
															<%
																if(results!=null && results.size()>0){
															%>
																	<tr bgcolor="#ffffff">
																		<td  width="100%" style="padding: 0" class="border-top">				
																			<div id="printDiscuss">
																	 			<div class="mxt-grid-header">
																	 			<table id="aaaa" class="sort" width="100%" border="0" cellspacing="0" cellpadding="0" onClick="sortColumn(event, true, false)" dragable="false">
																					<thead class="mxt-grid-thead">
																					<%if("1".equals(voteStyle)) {    //1:实名   0:匿名
																						//System.out.println("da  ti  ren");
																					%>
																					
																						<tr class="sort">
																							<td width="35%" align="left">评论内容</td>
																							<td width="30%" align="left">答题人</td>
																							<td width="25%" type="Date" align="left">评论时间</td>
																						</tr>
																					<%}else{ %>
																						<tr class="sort">
																							<td width="35%" align="left">评论内容</td>
																							<td width="20%" type="Date" align="left">评论时间</td>
																							<%
																						if(isAdmin){//是管理员  添加删除操作
																							%>
																								<td width="20%" type="Date" align="left"> 操作</td>
																							<%
																						}else{
																							%>
																							<td width="20%" type="Date" align="left"></td>
																						<%
																							
																						}
																						%>
																						</tr>
																					<%} %>
																					</thead>
																		 			<tbody class="mxt-grid-tbody">
																		
																	
																																
															<%
															for(DataObject resultObj:results){
																java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
																String commmentId = resultObj.getString("uuid");
																Date joinDate = resultObj.getDate("joinDate");
																 java.sql.Timestamp time = new  java.sql.Timestamp(joinDate.getTime());
																String date = sdf.format(time);
																String content = resultObj.getString("result");
																String userName = resultObj.getString("userName");//答题人员姓名
																//System.out.println("********************************************************");
																//System.out.println(date);
																//System.out.println("********************************************************");
																%>
																	<!-- 循环tr -->
																						<tr class="sort" erow="" id="<%=commmentId %>">
																						<%if("1".equals(voteStyle)) {%>
																							<td title="<%=content %>" class="sort " width="35%"><%=content %></td>
																							<td width="20%" align="left"><%=userName %></td>
																							<td align="left" class="sort" type="Date" width="20%"><%=date %></td>
																							<%
																						}else{
																						%>
																						<td title="<%=content %>" class="sort " width="35%"><%=content %></td>
																							<td align="left" class="sort " width="20%"><%=date %></td>
																							<%
																							if(isAdmin){//是管理员  添加删除操作
																								%>
																									<td width="20%" type="Date" align="left"><a style="text-decoration:none" width="100%" href=javascript:deleteThisComment('<%=commmentId %>')>删除</a></td>
																								
																								<%
																							}else{
																								%>
																								<td width="20%" type="Date" align="left"></td>
																							
																							<%
																							}	
																							
																						
																						
																					} %>
																						</tr>
																<%
															}
															%>
																					</tbody>
																				</table>
														 						</div>
																			</div>
																		</td>
																	</tr>				
															</table>
															<% 
															
														}
													}
														}
													}
													}
												%>
						</td>
										</tr>
							</table>						
												
				<!--123 --------------------------------------------------------------------------------------------------------------------------- -->
						
						</td>
					</tr>
				</table>										
			</td>		
		</tr>
		<tr style="height:30px;width:100%"></tr>	
		<tr>
			<td style="height:25px;width:100%" colspan="2">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" style="POSITION: absolute;bottom: 0px;">
									<tr>
			 <%
			 	if(publicDepId!=null && publicDepId.trim().length()>0){
			 		String[] depIdArr = publicDepId.split(";");
			 			StringBuffer condStr = new StringBuffer();
			 		if(depIdArr!=null && depIdArr.length>0){
			 			condStr.append("(");
			 			for(String depId:depIdArr){
			 				condStr.append("'");
			 				condStr.append(depId);
			 				condStr.append("'");
			 				if(!depId.equals(depIdArr[depIdArr.length-1])){
			 					condStr.append(",");
			 				}
			 			}
			 			condStr.append(")");
						 	String allUserNum = "0";
						 	StringBuffer str = new StringBuffer();
						 	allUserNum = ""+com.matrix.office.investigation.common.CommonHelper.getInvesPersonCount(publicDepId);//总人数
						 	String votedUserNum = "0";
						 	StringBuilder votedSql=new StringBuilder();
						 	votedSql.append("SELECT DISTINCT C_USER_ID FROM MO_INVESTIGATION_RESULT_BO  WHERE C_INVES_INFO_ID='"+invesInfoId+"'");
						 	if(condStr!=null && condStr.toString().trim().length()>0){
						 		if(publicDepId!=null && publicDepId.trim().length()>0){
							 		List list3 = com.matrix.office.investigation.common.CommonHelper.getUserList(publicDepId);
							 		StringBuffer userIdStr = new StringBuffer();
								 	if(list3!=null && list3.size()>0){
								 		userIdStr.append("(");
								 		for(Object currentUserId : list3){
								 			userIdStr.append("'");
								 			userIdStr.append(currentUserId);
								 			userIdStr.append("'");
								 			if(!currentUserId.equals(list3.get(list3.size()-1))){
								 				userIdStr.append(",");
											}
								 		}
								 		userIdStr.append(")");
								 	}
								 	votedSql.append("and C_USER_ID in "+userIdStr+"");
						 		}
			 				}
						 	List<DataObject> voteList = ds.querySqlList(votedSql.toString(),null,null);
						 	if(voteList!=null && voteList.size()>0){
						 		votedUserNum = voteList.size()+"";//投票人数
						 		
						 	}
							String notVoteNum = (Integer.valueOf(allUserNum)-Integer.valueOf(votedUserNum))+"";//未投票人数
						 	if("0".equals(allUserNum)){
						 		votedUserNum = "0";
						 		notVoteNum = "0";
						 	}
			 %>
										<td class="bg-advance-bottom" style="padding-left:10px;">
参加调查人数 <font color="red"><%=allUserNum %> </font>，目前共有 <font color="red"><%=votedUserNum %></font> 人投票，<font color="red"><%=notVoteNum %></font> 人未投票
                 						</td> 
			
					
	
										<td class="bg-advance-bottom" align="right" height="42">						
	  										<input type="button" id="returnResult" value="返回" class="button-default-2" onClick="backToVote('<%=invesInfoId %>');">
	  									</td>
	  								</tr>
							</table>
					
		<% 
			 			
			 		}
			 	}
			}
				
			}catch(Exception e){
				e.printStackTrace();
			}
				}
			}
		%>
		</td>
					</tr>
		</table>
		</td></tr>
		
	</table>


</body>
</html>
