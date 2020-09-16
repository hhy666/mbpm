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
<title>调查页面</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<link href="survey.css" rel="stylesheet" type="text/css"/>
<script>
	
</script>
</head>
<script language=javascript src='<%=request.getContextPath()%>/resource/js/office.js'></script>
<script type="text/javascript">
	function submitForm(){
		var invesInfoId = Matrix.getFormItemValue('invesInfoId');
		var titleIds = Matrix.getFormItemValue('titleIds');
		if(invesInfoId!=null && invesInfoId.length>0 && titleIds!=null && titleIds.length>0){
			var titleIdArr = titleIds.split(",");
			if(titleIdArr!=null && titleIdArr.length>0){
				for(var i = 0;i<titleIdArr.length;i++){
					
					var singleOption = document.getElementsByName(titleId+"_s");
					var other_singleOption = document.getElementsByName(titleId+"_other_s");
					var other_singleOption_input = document.getElementsByName(titleId+"_other_input_s");
					
					var multiOption = document.getElementsByName(titleId+"_m");
					var other_multiOption = document.getElementsByName(titleId+"_other_m");
					var other_multiOption_input = document.getElementsByName(titleId+"_other_input_m");
					
					var textArea = document.getElementById(titleId+"_disscus");
					if(singleOption!=null && singleOption.length>0){//单选
						
					}
				
				}
			}
		}
	}
</script>
<body>
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
<form id="form0" name="form0" eventProxy="Mform0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="invesInfoId" id="invesInfoId" value="${param.invesInfoId }"/>
	<input type="hidden" name="titleIds" id="titleIds" value="${param.titleIds }"/>
	<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" class="main-bg">
		<tbody>
		<tr class="page2-header-line">
			<td width="100%" height="41" valign="top" class="page-list-border-LRD">
		 		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="page2-header-line-old">
                <tbody><tr>
                    <td width="80" height="60"><span class="inquiry_img"></span></td>
                    <td class="page2-header-bg-old" width="380">调查</td>
                    <td>&nbsp;</td>
                    <td class="page2-header-line-old padding-right" align="right"></td>
                </tr>
            </tbody></table>
			</td>
		</tr>
	
		<%
			String invesInfoId = "399c83cf-813c-4984-bf82-9b2beae462d7";//request.getParameter("invesInfoId");
			DataService ds = MFormContext.getService("DataService");
			if(invesInfoId!=null && invesInfoId.trim().length()>0){
				if(invesInfoId!=null && invesInfoId.trim().length()>0){
					//调查信息主键存在
					try{
						DataObject invesInfo = ds.load("comprehensive.survery.surverymodule.SurveryInfoBo",invesInfoId);
						if(invesInfo!=null){
							Date toDate = invesInfo.getDate("endTime");
							Date now = new Date();
							String isOver = "开启";
							if(now.getTime()>toDate.getTime()){
								isOver = "结束";
							}
							Date startTime = invesInfo.getDate("startTime");
							String invesTitle = invesInfo.getString("title");
							String starterName = invesInfo.getString("starterName");
							String surveryColumn = invesInfo.getString("surveryColumn");//调查栏目
							String starterDep = invesInfo.getString("starterDep");//发起部门
							String publicDepId = invesInfo.getString("publicDepId");
							String voteStyle = invesInfo.getString("voteStyle");//投票方式
							String publicDep = invesInfo.getString("publicDep");//发布范围
							String voteName = voteStyle=="0"?"实名":"匿名";
							String canSee = invesInfo.getString("canSee");
							String desc = invesInfo.getString("description");//调查描述
		%>
			<!-- 调查标题 
			<td colspan="2" valign="top">
			
			<table height="100%" width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr><td colspan="2" align="right" height="2" width="100%"></td></tr>
					<tr><td class="webfx-menu-bar" colspan="2" height="26">&nbsp;
				 			<font style="font-size:12px;font-weight:bold;">
				 				<%=invesTitle %>（<%=isOver %>）
		         			</font>				 
			    		</td>
			    	</tr>
				</tbody>
  			</table>
  			</td>
  			-->
  			
		<tr>
			<td class="border-top">
				<div style="overflow: auto; height: 100%; width: 100%;" class="scrollList" id="scrollListDiv">
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="">
						<tr>
							<td width="25%" class="bbs-bg border-bottom" valign="top">
                                  <table width="100%" border="0" align="left" valign="top">
                                    <tbody><tr><td colspan="4">&nbsp;</td></tr>
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
							          <%=surveryColumn %>
									   </td>
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
							         <label id="fromDate"></label>
									   <%=startTime %> &nbsp;&nbsp;至
									 </td>   
							       </tr>
							       <tr>
							         <td>&nbsp;</td>
							         <td>&nbsp;</td>
							         <td colspan="2">
									   
								          
									      <%=toDate %>
							          
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
				                                				
																	<script type="text/javascript">
																		
																	</script>
																		<input disabled="disabled" id="cryptonym1" type="radio" name="cryptonym" value="0" checked="checked">
				                                						<%=voteName %>
                                                                        <br>
                                                                        <%
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
                                                                        %>
                                                                       
																	
																	
																
			                                				</nobr>
			                                			</div>
		                                			</td>
                                               		
                                               </tr>
						        </tbody></table>
							</td>
							<td width="78%" valign="top" class=" top-padding" style="padding: 10px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" style="word-break:break-all;word-wrap:break-word;">
                                            <tbody><tr>
                                                <td>
                                                    &nbsp;<font style="font-size: 16px;"><%=desc %><br></font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bbs-tb-padding2" valign="top" style="word-break:break-all;word-wrap:break-word">
                                                
<% 
                                                //到题目表中查找相应的题目
				List<DataObject> titleInfoList = ds.queryList("from comprehensive.survery.surverymodule.SueverySubjectInfoBo where invesInfoId='"+invesInfoId+"'  ORDER BY cOrder asc",null);
				if(titleInfoList!=null && titleInfoList.size()>0){
					String condition = CommonHelper.ListConvert2HqlConditionStr(titleInfoList,"uuid");
					//题目选项集合
					List<DataObject> selectTypeList = ds.queryList("from comprehensive.survery.surverymodule.SujectSelectInfoBO where subjectId in "+condition,null);
					Map<String,List<DataObject>> subjectOptionMap = new HashMap<String,List<DataObject>>();
					if(selectTypeList!=null && selectTypeList.size()>0){
						//题目 与 选项的
						subjectOptionMap = CommonHelper.getSubjectOptionMap(titleInfoList,selectTypeList);
%>
						<!-- 调查描述 -->
						<tr>
							<td style="width:100%;height:20%;"><font id="invesDesc"><%=invesInfo.getString("description") %></font></td>
						</tr>
						
						<!-- 调查题目 -->
						<tr>
							<td style="height:70%;">
<%					
					}
					String titleIds = "";
					for(int i = 0;i<titleInfoList.size();i++){
						DataObject titleInfo = titleInfoList.get(i);
						titleIds+=titleInfo.getString("uuid");
						if(i<titleInfoList.size()-1){
							titleIds+=",";
						}
						String titleName = titleInfo.getString("name");//题目名称
						String titleDesc = titleInfo.getString("description");//描述
						String selectType = titleInfo.getString("selectionType");//选择项
						String titleId = titleInfo.getString("uuid");//题目主键
						String isOtherSelect = titleInfo.getString("isOtherSelect");//其他选项
						String isAllowComment = titleInfo.getString("isAllowComment");//允许评论
						String otherContent = titleInfo.getString("otherContent");//其他选项内容
						String commentContent = titleInfo.getString("commentContent");//评论内容
						String maxSelectOption = titleInfo.getString("maxSelectionCount");
						if(maxSelectOption!=null && maxSelectOption.trim().length()>0){
							//多选
							if(Integer.valueOf(maxSelectOption)>0){  //确保 最大选择数不是0
								titleName = titleName+"（最多"+maxSelectOption+"人）：   (最大选择数:"+maxSelectOption+") ";
							}
						}
%>	
						<ul id="discussul"> 
							<%=i+1 %>.<%=titleName %><!-- 题目 -->
							<br>
							<li><%=titleDesc %></li><!-- 题目描述 -->
<%
								
								if("0".equals(selectType)){//单选
									System.out.println(titleId);
									List<DataObject> optionList = subjectOptionMap.get(titleId);
									System.out.println("selectType"+selectType);
									if(optionList!=null && optionList.size()>0){
										for(int j = 0;j<optionList.size();j++){
											System.out.println("danxuan"+optionList.size());
											DataObject option = optionList.get(j);
											String optionId = option.getString("uuid");
											String selectContent = option.getString("selectContent");
%>	
											<!-- radio -->
											<label for="<%=j%>id">
											<input type="radio" id="<%=j%>id"  value="<%=optionId%>" name="<%=titleId %>_s"><%=selectContent%></input>
											</label><br>
<% 	
										}
										
									}
									if("1".equals(isOtherSelect)){
										//有其他选项
										%>
											<label for="otherOptionId">
											<input type="radio" id="<%=titleId %>_other_s" value="other" name="<%=titleId %>_other_s"/>其他选择项
											</label>
											<input type="text" id="<%=titleId %>_other_input_s" name="<%=titleId %>_other_input_s"/>
											<br>
<%
									}
											
								}else if("1".equals(selectType)){//多选
									List<DataObject> optionList = subjectOptionMap.get(titleId);
									System.out.println(optionList);
									if(optionList!=null && optionList.size()>0){
										System.out.println("duoxuan="+optionList.size());
										for(int j = 0;j<optionList.size();j++){
											DataObject option = optionList.get(j);
											String optionId = option.getString("uuid");
											String selectContent = option.getString("selectContent");
								%>
											<!-- checkbox -->
											<label for="<%=j%>id">
											<input type="checkbox"  id="<%=j%>id" name="<%=titleId %>_m" onclick="clickCount(this,0,7)" ><%=selectContent%></input>
											</label><br>
											
											
<% 
										}
										
									}
									if("1".equals(isOtherSelect)){
										//有其他选项
										%>
										<%
									}
								}else if("2".equals(selectType)){//问答
%>
									<!-- inputTextArea -->
									<textarea cols="100" rows="5"  name="<%=titleId %>_disscus" id="<%=titleId %>_disscus" style="border:1px solid #d8d8d8" inputname="答题内容" validate="maxLength" maxsize="1200"></textarea>
									<br>
<% 
								}
%>
							<li>
								
							</li>
						
						</ul>
							
						
<%						
						
						
					}
					%>
						<script type="text/javascript">
							
			<script>
				Matrix.setFormItemValue('titleIds',<%=titleIds%>);
			</script>
						</script>
					
					<%
				}
			
%>
			</td>
		</tr>
	<!-- 调查附件 -->
		<tr>
			<td style="height:10%;">
<%
			String hql = "from office.common.attach.FileBO where mBizId = '"+invesInfoId+"'";				
			DataService dataService = MFormContext.getService("DataService");
			List<DataObject> fileList = dataService.queryList(hql,null);
			if(fileList!=null && fileList.size()>0){
%>
			<div class="div-float attsContent" >
			<div class="atts-label">附件 ：</div>
<%
				for(DataObject file:fileList){
					String fileName = file.getString("fileName");
					String fileType = file.getString("fileType");
					String fileId = file.getString("uuid");
					String imgSrc = CommonHelper.getImgSrc(fileType);
					Integer fileSize = file.getInt("fileSize");
%>
					
					<div id="attachmentDiv" class="attachment_block" style="float: left;height: 18px; line-height: 14px;">
						<img src="<%=imgSrc %>" border="0" height="16" width="16"  style="margin-right: 3px;">
						<a href="javascript:downLoad('<%=fileId %>','office.common.attach.FileBO')" title="<%=fileName %>" target="downloadFileFrame" style="font-size:12px;color:#007CD2;">
						<%=fileName %>&nbsp;(<%=fileSize %>)
						</a>&nbsp;&nbsp;&nbsp;
					</div>
							
<% 	
				}
				
			}
%>
			</div>
			</td>
			
		</tr>
	</table>
	<script>
		function downLoad(uuid,entityName){
			var url =webContextPath+"/DownLoadFileServlet?uuid="+uuid+"&entityName="+entityName;
			window.location.href=url;
		}
	</script>
				</div>
			</td>
		</tr>
		</tbody>
		
		<tr>
		<td colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-right:0px;">
	<tbody><tr>
	<td class="bg-advance-bottom" align="left" style="margin-right:0px;">
		
			
			 <%
			 	String depHql = "from foundation.org.UserInOrg where depId = '"+publicDepId+"'";
			 	List<DataObject> list = ds.queryList(depHql,null);
			 	String allUserNum = "0";
			 	String canSubmit = "false";
			 	if(list!=null && list.size()>0){
			 		allUserNum = list.size()+"";//总人数
				 	MFUser curUser = MFormContext.getUser();
				 	String userId = curUser.getUserId();
				 	for(DataObject userInOrg:list){
				 		if(userInOrg.getString("userId").equals(userId)){
				 			canSubmit="true";
				 			break;
				 		}
				 	}
			 	}
			 	String votedUserNum = "0";
			 	String votedSql = "SELECT COUNT(C_USER_ID) FROM MO_INVESTIGATION_RESULT_BO  WHERE C_INVES_INFO_ID='"+invesInfoId+"' GROUP BY C_USER_ID";
			 	Object obj = (Object)ds.querySqlValue(votedSql,null,null);
			 	System.out.print(obj);
			 	if(obj!=null){
			 		votedUserNum = obj.toString();//投票人数
			 		
			 	}
				String notVoteNum = (Integer.valueOf(allUserNum)-Integer.valueOf(votedUserNum))+"";//未投票人数
			 %>
				</td><td class="bg-advance-bottom">
                   	参加调查人数 <font color="red"><%=allUserNum %> </font>，
                    目前共有 <font color="red"><%=votedUserNum %></font> 人投票，
                    <font color="red"><%=notVoteNum %></font> 人未投票
                 	</td> 
			
		
	
	<td class="bg-advance-bottom" align="right" height="42">	
	  <input type="submit" id="submit" name="提交" class="button-default-2" value="提交" display="<%=canSubmit %>" />					
	  <input type="button" id="returnResult" value="查看结果" class="button-default-2" onclick="showResult('<%=invesInfoId %>');">
	  </td>
	  </tr>
</tbody></table>
</td>
		</tr>
		<% 
			}
				
			}catch(Exception e){
				e.printStackTrace();
			}
				}
			}
		%>
	
	</table>
<script>
	function showResult(invesInfoId){
    location.replace(webContextPath+"/office/survery/SurveyResultPage.jsp?invesInfoId="+invesInfoId);
}
</script>
</form>
</body>
</html>
