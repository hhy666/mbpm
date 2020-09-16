<%@page import="java.text.ParseException"%>
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
<title>调查页面</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>

<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<link href="survey.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
*{
	padding:0;
	margin:0;
}
#discussul {
    list-style: none;
    margin: 0px;
    font-weight: bold;
    background: #e7eaec;
    border: 1px #d8d8d8 solid;
}
</style>
</style>
</head>
<script language=javascript src='<%=path%>/resource/js/office.js'></script>
<script type="text/javascript">
 
 
	 $(function(){
		//打开页面时，重新定位窗口位置（--------）
		 self.moveTo(0,0);
		 self.resizeTo(screen.availWidth,screen.availHeight);
		 
		 $('input[type=checkbox]').on('ifChanged', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
			 var id = $(this).attr("id"); 
			 var idStr = id.split("_");
			 var x = idStr[0];
			 var maxNum = idStr[2];
			 
			 var name = $(this).attr("name"); 
			 var nameStr = name.split("_");
			 var val = nameStr[0];  
			
			 clickCount(val,x,maxNum,$(this));
			 
			 return false;
		 }); 
	 });
	 
	 //复选框检查最大选择数
	 function clickCount(id,x,maxNum,curJs){
			var	option = document.getElementsByName(id+"_m");
			var otherOpt = document.getElementsByName(id+"_other_m");     //其他选项
			var hasSelect = 0;
			if(option!=null && option.length>0){
				if(otherOpt!=null && otherOpt.length>0){
					///var otherInput = document.getElementById(id+"_other_input_m");
					if(otherOpt[0].checked){
						//otherInput.readOnly=false; 
						hasSelect+=1;
					}else{
						//otherInput.readOnly=true; 
					}
				}
				for(var i = 0;i<option.length;i++){
					var opt = option[i];
					if(opt.checked){
						hasSelect+=1;
						
						if(hasSelect>parseInt(maxNum)){       //大于最大选择数时提示信息
							setTimeout(function(){  
								curJs.iCheck('uncheck');
							}, 100);
							layer.msg("最多选择"+maxNum+"项");
							return false;
						}
					}
				}
			}
		}

	//结束调查
	function IsOverInvestigation(invesInfoId){
		layer.confirm("确定要结束调查?", {
			 btn: ['确定','取消']
		}, function(index){
			var url = webContextPath+"/investigation/investigation_overInvestigation.action?uuid="+invesInfoId;
			
			var xhr = newXMLHttpRequest();
			xhr.onreadystatechange=function(){
	  			if (xhr.readyState==4 && xhr.status==200){
	  				var responseText = xhr.responseText;
	  				var json = eval('('+responseText+")");
	  				if(json!=null){
	  					if(json.result){
	  						//提交按钮隐藏
	  						var submitBtn = document.getElementById("submit");
	  						if(submitBtn!=null){
	  							submitBtn.style.display="none";
	  						}
	  						//结束调查按钮隐藏
	  						var overInves = document.getElementById("overInves")
	  						if(overInves!=null){
		  						overInves.style.display="none";
	  						}
	  						//开启调查按钮显示
	  						var startInves = document.getElementById("startInves");
	  						if(startInves!=null){
	  							startInves.style.display="";
	  						}
	  						//调查已经结束
	  						var font = document.getElementById("font");
	  						if(font!=null){
	  							font.style.display="";
	  						}
	  						var joinFont = document.getElementById("joinFont");
	  						if(joinFont!=null){
	  							font.style.display="none";
	  						}
	  					}
	  				}
	    		}
	  		}
			xhr.open("GET",url,true);
			xhr.send();
			parent.layer.close(index)
		});
	}
	//开启调查 
	function startInvestigation(invesInfoId){
		 layer.open({
		    	id:'layer01',
				type : 2,
				
				title : ['开启调查'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '40%', '50%' ],
				content : "<%=path%>/office/survery/setNewEndTime.jsp?invesInfoId="+invesInfoId
			});
 
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
	

function checkItems(id,type,name){
	if(0==type){
	var option1 = document.getElementsByName(id+"_s");
	var otherOpt1 = document.getElementsByName(id+"_other_s");
	if(option1!=null && option1.length>0){
		flag=true;
	for(var i=0;i<option1.length;i++)  
	{   
        //判断那个单选按钮为选中状态  
		if(option1[i].checked)  
		{  
			return "";
			break;
		} 
		else{
		  flag=false;
		}
	 } 
		if(flag==false)
		{
			if(otherOpt1.checked)  
			{  
			return "";
			} else{return name+="\n";}
		}
		}
	}
	if(1==type){
	var option2 = document.getElementsByName(id+"_m");
	var otherOpt2 = document.getElementsByName(id+"_other_m");
	if(option2!=null && option2.length>0){
		flag=true;
	for(var i=0;i<option2.length;i++)  
	{   
        //判断那个单选按钮为选中状态  
		if(option2[i].checked)  
		{  
			return "";
			break;
		} 
		else{
		  flag=false;
		}
	 } 
		if(flag==false)
		{
			if(otherOpt2.checked)  
			{  
			return "";
			} else{return name+="\n";}
		}
		}
	}
	if(2==type){
	var option3 = document.getElementsByName(id+"_disscus");
		if(option3[0].value != ""){
			return "";
		}else{
			return name+="\n";
			}
	}
}

function showSurveryVote(invesInfoId){
	 layer.open({
		    id:'layer01',
			type : 2,
			
			title : ['查看投票记录'],
			//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '60%' ],
			content : "<%=request.getContextPath()%>/office/survery/showSurveryVote.jsp?iframewindowid=layer01&invesInfoId="+invesInfoId
	 });
}
</script>
<body>
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>
<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",name:"Mform0",position:"absolute",action:"",canSelectText: true,fields:[{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}]});</script>
<div style="width: 100%; height: 100%; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" onsubmit="return checkContent()"
	action="<%=request.getContextPath()%>/investigation/investigation_saveInvestigationQuestion.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="invesInfoId" id="invesInfoId" value="${param.invesInfoId }"/>
	<input type="hidden" name="titleIds" id="titleIds" value="${param.titleIds }"/>
	<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" class="main-bg">
			<tr class="page2-header-line">
				<td width="100%" height="41" valign="top" class="page-list-border-LRD" colspan="2">
			 		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="page2-header-line-old">    
	                		<tr>
			                    <td width="80" height="60"><span class="inquiry_img"></span></td>
			                    <td class="page2-header-bg-old" width="380">调查</td>		            
			                    <td class="page2-header-line-old padding-right" align="right"></td>
			                </tr>
	            	</table>
				</td>
			</tr>
		<%  
			String invesInfoId = request.getParameter("invesInfoId");
			DataService ds = MFormContext.getService("DataService");
			StringBuffer strBuff = new StringBuffer();
			MFUser curUser = MFormContext.getUser();
			String userId = "";
			//如果为查看投票人详情  此userId不为空
			String checkUserId = request.getParameter("userId");
			if(checkUserId!=null && checkUserId.trim().length()>0){
				userId = checkUserId;
			}else{
				userId = curUser.getUserId();
			}
			String hasJoinHql = "from comprehensive.survery.surverymodule.InvestigationResultBO where userId='"+userId+"' and invesInfoId='"+invesInfoId+"'";
			boolean partake = false;
			List<DataObject> hasJoinList = ds.queryList(hasJoinHql,null);
			if(hasJoinList!=null && hasJoinList.size()>0){   //已经参与调查
				partake = true;
			}
			if(invesInfoId!=null && invesInfoId.trim().length()>0){
				if(invesInfoId!=null && invesInfoId.trim().length()>0){
					//调查信息主键存在
					try{
						DataObject invesInfo = ds.load("comprehensive.survery.surverymodule.SurveryInfoBo",invesInfoId);
						if(invesInfo!=null){
							//取得当前时间
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							Date nowTime = null;   //当前时间
							try {
								String now = sdf.format(new Date());
								nowTime = sdf.parse(now);   //字符串类型转换成Date类型
							} catch (ParseException e) {
								e.printStackTrace();
							}       
							Date toDate = invesInfo.getDate("endTime");
							Date startTime = invesInfo.getDate("startTime");
							String invesTitle = invesInfo.getString("title");
							String starter = invesInfo.getString("starterId");//发起人
							String starterName = invesInfo.getString("starterName");
							String surveryColumn = invesInfo.getString("surveryColumn");//调查栏目
							String starterDep = invesInfo.getString("starterDep");//发起部门
							String publicDepId = invesInfo.getString("publicDepId");
							String voteStyle = invesInfo.getString("voteStyle");//投票方式
							String publicDep = invesInfo.getString("publicDep");//发布范围
							String voteName = "实名";
							if("0".equals(voteStyle)){
								voteName = "匿名";
							}
							String canSee = invesInfo.getString("canSee");
							int isOverInves = invesInfo.getInt("isOverInves");//是否结束调查 0 未结束调查  1 结束调查
							String desc = invesInfo.getString("description");//调查描述
							if(desc==null||"null".equals(desc)){
								desc="";
							}
							StringBuffer hql1 = new StringBuffer();
							String sql = CommonHelper.generateCriteria2(curUser);
							hql1.append("from comprehensive.survery.surverymodule.SurveryInfoBo ");
							hql1.append("where mBizId in (select mBizId from comprehensive.officesupplies.suppliesmodule.AuthorityBO where "
							+ sql + ")");
							hql1.append(" and mBizId='"+invesInfoId+"'");
							//System.out.println(hql1.toString());
							List<DataObject> auth = ds.queryList(hql1.toString(),
													null);
							boolean isAdmin = false;
							if((starter!=null && userId.equals(starter))||(auth!=null&&auth.size()>0)){
								//当前人是发起人
								isAdmin = true;
							}
							boolean isOver = false;   //调查未结束
							if(isOverInves==1 || nowTime.compareTo(toDate)>0){   //调查已结束
								isOver = true;
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
		<tr>
			<td width="25%" class="bbs-bg border-bottom" valign="top">
			 <div style="overflow: auto; height: 100%; width: 100%;">
                <table width="100%" border="0" align="left" valign="top">
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
				          <td colspan="2"><label id="fromDate"></label><%=sdf1.format(startTime) %> &nbsp;&nbsp;至</td>   
				       </tr>
				       <tr>
				         <td>&nbsp;</td>
				         <td>&nbsp;</td>
				         <td colspan="2"><%=end %></td>  
				       </tr>
				       <tr height="2px">
				         <td>&nbsp;</td>
				         <td colspan="3" height="2px"><div class="lineDetail"><sub></sub></div></td>
				       </tr>				     
				      <tr>
				         <td>&nbsp;</td>
					     <td><img src="../../resource/images/dian.gif"></td>
					     <td colspan="2">发布范围:</td>
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
	                          <div style=" width:280px;overflow:hidden; text-overflow:ellipsis;" title="">
	                          <nobr>		
							  <input disabled="disabled" id="cryptonym1" type="radio" name="cryptonym" value="0" checked="checked"><%=voteName %>
	                          <br>                                                    
	                          <%
	                          if("0".equals(voteStyle)){
	                          	if("true".equals(canSee)){
	                          %>
	                          <input id="allowAdminViewResult" name="allowAdminViewResult" disabled="disabled" type="checkbox" style="margin-left:7px;margin-top:7px;" checked="checked">发起人/板块管理员可查看已投票和未投票人
	           				  <img width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query.png" onclick="showSurveryVote('<%=invesInfoId %>');">                                           
	                          <%
	                          	}else{
	                          %>		
	                          <input id="allowAdminViewResult" name="allowAdminViewResult" disabled="disabled" style="margin-left:7px;margin-top:7px;" type="checkbox">发起人/板块管理员可查看已投票和未投票人
	                          <%		
	                          	}
	                          }else{
	                          %>
	                             &nbsp;查看已投票和未投票人<img width="16" height="16" src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/query.png" onclick="showSurveryVote('<%=invesInfoId %>');">
	                         <%
								}
	                          %>
							 </nobr>
	                         </div>
                         </td>
                 	  </tr>
		      </table>
		      </div>
		   </td>
		   <td class="border-top" style="vertical-align: top;">
				<div style="overflow: auto; height: 100%; width: 100%;" class="scrollList" id="scrollListDiv">
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="">
						<tr>
							<td width="78%" valign="top" class=" top-padding" style="padding: 10px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" style="word-break:break-all;word-wrap:break-word;">
                                            <tr>
                                                <td>
                                                    &nbsp;<font style="font-size: 16px;"><%=desc %><br></font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bbs-tb-padding2" valign="top" style="word-break:break-all;word-wrap:break-word">
                                                                                                                                            
                                                </td>
                                            </tr>
                                                
<% 
                                                //到题目表中查找相应的题目
				List<DataObject> titleInfoList = ds.queryList("from comprehensive.survery.surverymodule.SueverySubjectInfoBo where invesInfoId='"+invesInfoId+"'  ORDER BY cOrder asc",null);
				if(titleInfoList!=null && titleInfoList.size()>0){
					String condition = CommonHelper.ListConvert2HqlConditionStr(titleInfoList,"uuid");
					//题目选项集合
					List<DataObject> selectTypeList = ds.queryList("from comprehensive.survery.surverymodule.SujectSelectInfoBO where subjecType is null and subjectId in "+condition,null);
					Map<String,List<DataObject>> subjectOptionMap = new HashMap<String,List<DataObject>>();
					if(selectTypeList!=null && selectTypeList.size()>0){
						//题目 与 选项的
						subjectOptionMap = CommonHelper.getSubjectOptionMap(titleInfoList,selectTypeList);
%>	
						<!-- 调查题目 -->
						<tr>
							<td>
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
						if(titleDesc==null || "".equals(titleDesc)||"undefined".equals(titleDesc)){
							titleDesc="";
						}
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
								titleName = titleName+"(最大选择数:"+maxSelectOption+") ";
							}
						}
%>	
						<ul id="discussul" style="border-bottom: 0px;"> 
							<h5><%=i+1 %>.<%=titleName %></h5><!-- 题目 -->
							<li style="padding: 0px 2px;"><%=titleDesc %></li><!-- 题目描述 -->
<%		
								if("0".equals(selectType)){//单选
									List<DataObject> optionList = subjectOptionMap.get(titleId);
									if(optionList!=null && optionList.size()>0){
										for(int j = 0;j<optionList.size();j++){
											DataObject option = optionList.get(j);
											String optionId = option.getString("uuid");
											String selectContent = option.getString("selectContent");
%>	
											<!-- radio 单选按钮的value是选项主键-->
											<li style="padding: 8px 2px;background: white;border-bottom: 1px solid #d8d8d8;">
											<label for="<%=j%>id">
											<input type="radio" class="box" id="<%=j%>id"  value="<%=optionId%>"  name="<%=titleId %>_s" 
											<%
											if(partake){//已经参与调查
												for(int i1=0; i1<hasJoinList.size(); i1++){
													DataObject hadValObj = hasJoinList.get(i1);
													//type 0:单选的选择值结果    1:多选的选择值结果    2.问答的内容     3.单选评论的内容     4.多选评论的内容     5:单选的其他选项内容    6.多选的其他选项内容
													//int type = hadValObj.getInt("type");
													String result = hadValObj.getString("result");
													if(result!=null && optionId.equals(result)){
														%>
														 checked disabled="disabled"
														<%
														break;
													}else{
														%>
														 disabled="disabled"
														<%
													}
												}
											}else{    //未参与调查
												if(isOver){ //调查已结束
													%>
													 disabled="disabled"
													<%
												}
											}
											%>
											>&nbsp;&nbsp;<%=selectContent%></input>
											</label><br>
											</li>
<% 										
										}
										strBuff.append("str+=checkItems('");
										strBuff.append(titleId);
										strBuff.append("','");
										strBuff.append(selectType);
										strBuff.append("','");
										strBuff.append(titleName+"');\n");
										
									}
									if("true".equals(isOtherSelect)){   //允许填写其他选项									
										String otherSelect = (String)ds.queryValue("select selectContent from comprehensive.survery.surverymodule.SujectSelectInfoBO where uuid = (select result from comprehensive.survery.surverymodule.InvestigationResultBO where userId='"+userId+"' and invesInfoId='"+invesInfoId+"' and invesSubjectId='"+titleId+"' and type=5)", null);
										if(otherSelect==null || otherSelect.trim().length() == 0){
											otherSelect = "";
										}
									%>
										<li style="padding: 8px 2px;background: white;border-bottom: 1px solid #d8d8d8;">
											<label for="otherOptionId">
											<input type="radio" class="box"
											<%
											if(otherSelect!=null && otherSelect.trim().length()>0){  //结果是其他选项
											%>	
											checked 
											<% 
											} 
											%>
											<%
											if(isOver || partake){  //调查已结束或已经参与调查不能修改了
											%>	
											disabled="disabled" 
											<% 
											} 
											%>
											id="<%=titleId %>_other_s" value="other_s" name="<%=titleId %>_s")/>其他选择项
											</label>
											<label>
											<input type="text" class="form-control"
											<%
											if(isOver || partake){  //调查已结束或已经参与调查不能修改了
											%>	
											readOnly="readOnly" 
											<% 
											} 
											%>
											id="<%=titleId %>_other_input_s" name="<%=titleId %>_other_input_s" value="<%=otherSelect%>"/>
											</label>
											<br>
										</li>			
									<%
									}
									if("true".equals(isAllowComment)){   //允许评论					
										String comment = (String)ds.queryValue("select result from comprehensive.survery.surverymodule.InvestigationResultBO where userId='"+userId+"' and invesInfoId='"+invesInfoId+"' and invesSubjectId='"+titleId+"' and type=3", null);
										if(comment==null || comment.trim().length() == 0){
											comment = "";
										}
									%>
											<li style="background: white;font-weight: normal;">评论:</li>
											<li>
												<textarea class="form-control" rows="5" 
												<%
												if(isOver || partake){  //调查已结束或已经参与调查不能修改了
												%>	
												readOnly="readOnly" 
												<% 
												} 
												%>
												name="<%=titleId %>_s_disscus" id="<%=titleId %>_s_disscus" style="border:1px solid #d8d8d8;width:100%;resize: none;" inputname="评论" validate="maxLength" maxsize="1200"><%=comment %></textarea>
											</li>
		
								<% 		
									}
											
								}else if("1".equals(selectType)){//多选
									List<DataObject> optionList = subjectOptionMap.get(titleId);
									if(optionList!=null && optionList.size()>0){
										for(int j = 0;j<optionList.size();j++){
											DataObject option = optionList.get(j);
											String optionId = option.getString("uuid");
											String selectContent = option.getString("selectContent");
								%>
											<!-- checkbox -->
											<li style="padding: 8px 2px;background: white;border-bottom: 1px solid #d8d8d8;">
											<label for="<%=j%>id">
											<input type="checkbox" class="box" id="<%=j%>_id_<%=maxSelectOption%>" name="<%=titleId %>_m" value="<%=optionId %>" onclick="clickCount('<%=titleId %>','<%=j %>','<%=maxSelectOption%>')" 
											<%
												if(partake){//已经参与调查
													for(int i1=0; i1<hasJoinList.size(); i1++){
														DataObject hadValObj = hasJoinList.get(i1);
														String result = hadValObj.getString("result");
														if(result!=null && optionId.equals(result)){
															%>
															 checked disabled="disabled"
															<%
														}else{
															%>
															 disabled="disabled"
															<%
														}
													}
												}else{     //未参与调查
													if(isOver){  //调查已结束
													%>
														 disabled="disabled"
													<%	
													}
												}
											%>
											>&nbsp;&nbsp;<%=selectContent%></input>
											</label><br>
											</li>
											
<% 												
										}
										strBuff.append("str+=checkItems('");
										strBuff.append(titleId);
										strBuff.append("','");
										strBuff.append(selectType);
										strBuff.append("','");
										strBuff.append(titleName+"');\n");
										
									}
									if("true".equals(isOtherSelect)){  //允许其他选项
										String otherSelect = (String)ds.queryValue("select selectContent from comprehensive.survery.surverymodule.SujectSelectInfoBO where uuid = (select result from comprehensive.survery.surverymodule.InvestigationResultBO where userId='"+userId+"' and invesInfoId='"+invesInfoId+"' and invesSubjectId='"+titleId+"' and type=6)", null);
										if(otherSelect==null || otherSelect.trim().length() == 0){
											otherSelect = "";
										}
										%>
											<li style="padding: 8px 2px;background: white;border-bottom: 1px solid #d8d8d8;">
											<label for="otherOptionId">
											<input type="checkbox" class="box" 
											<%
											if(otherSelect!=null && otherSelect.trim().length()>0){  //结果是其他选项
											%>	
											checked 
											<% 
											} 
											%>
											<%
											if(isOver || partake){  //调查已结束或已经参与调查不能修改了
											%>	
											disabled="disabled" 
											<% 
											} 
											%>
											id="<%=titleId %>_other_<%=maxSelectOption%>" value="other_m" name="<%=titleId %>_other_m" onclick="clickCount('<%=titleId %>','o','<%=maxSelectOption%>')"/>其他选择项
											</label>
											<label>
											<input type="text" class="form-control" 
											<%
											if(isOver || partake){  //调查已结束或已经参与调查不能修改了
											%>	
											readOnly="readOnly"
											<% 
											} 
											%>
											id="<%=titleId %>_other_input_<%=maxSelectOption%>" name="<%=titleId %>_other_input_m" value="<%=otherSelect %>"/>
											</label>
											<br>
											</li>	
										<%
									}
									if("true".equals(isAllowComment)){ //允许评论				
										String comment = (String)ds.queryValue("select result from comprehensive.survery.surverymodule.InvestigationResultBO where userId='"+userId+"' and invesInfoId='"+invesInfoId+"' and invesSubjectId='"+titleId+"' and type=4", null);
										if(comment==null || comment.trim().length() == 0){
											comment = "";
										}
										%>
											<li style="background: white;font-weight: normal;">评论:</li>
											<li>
												<textarea class="form-control" rows="5" 
												<%
												if(isOver || partake){  //调查已结束或已经参与调查不能修改了
												%>	
												readOnly="readOnly"
												<% 
												} 
												%>
											 	name="<%=titleId %>_m_disscus" id="<%=titleId %>_m_disscus" style="border:1px solid #d8d8d8;width:100%;resize: none;" inputname="评论" validate="maxLength" maxsize="1200"><%=comment %></textarea>
											</li>									
										<% 								
									}
								}else if("2".equals(selectType)){//问答
									String answer = (String)ds.queryValue("select result from comprehensive.survery.surverymodule.InvestigationResultBO where userId='"+userId+"' and invesInfoId='"+invesInfoId+"' and invesSubjectId='"+titleId+"' and type=2", null);
									if(answer==null || answer.trim().length() == 0){
										answer = "";
									}
							%>
									<!-- inputTextArea -->
									<textarea class="form-control" rows="5" 
									<%
									if(isOver || partake){  //调查已结束或已经参与调查不能修改了
									%>	
									readOnly="readOnly"
									<% 
									} 
									%>			
									 name="<%=titleId %>_disscus" id="<%=titleId %>_disscus" style="border:1px solid #d8d8d8;width:100%;resize: none;" inputname="答题内容" validate="maxLength" maxsize="1200"><%=answer %></textarea>			
									
							<% 
								strBuff.append("str+=checkItems('");
										strBuff.append(titleId);
										strBuff.append("','");
										strBuff.append(selectType);
										strBuff.append("','");
										strBuff.append(titleName+"');\n");
								}
							%>
						</ul>
	
						<%										
					 }
					%>
				</td>
			</tr>	
			<script type="text/javascript">
				Matrix.setFormItemValue('titleIds','<%=titleIds%>');
				function checkContent(){
				var str="";
				<%=strBuff%>
			 if(str != null && str != ""){
					alert("请认真填写题目\n"+str);
					return false;
				}else {
					return true;
				}
				}
			</script>
					
				<%
				}
			
				%>
			
	<!-- 调查附件 -->
		<tr>
			<td style="height:10%;padding-top: 10px">
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
					String imgSrc = CommonHelper.getImgSrc(fileType).replace("../../", "");
					Integer fileSize = file.getInt("fileSize");
%>
					
					<div id="attachmentDiv" class="attachment_block" style="float: left;height: 18px; line-height: 14px;">
						<img src="<%=path%>/<%=imgSrc%>" border="0" height="16" width="16"  style="margin-right: 3px;">
						<a href="javascript:downLoad('<%=fileId %>','office.common.attach.FileBO')" title="<%=fileName %>" style="font-size:12px;color:#007CD2;">
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
		<tr>
			<td height="20px;"></td>
		</tr>
		</table>
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
	
	  <%
		if(!"preview".equals(request.getParameter("sign"))){%>
		<tr>
		  <td colspan="2" height="42">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-right:0px;position: absolute;bottom: 0px;">
			  <tr>
			 	<%
			 		StringBuffer str = new StringBuffer();
			 		String allUserNum = ""+com.matrix.office.investigation.common.CommonHelper.getInvesPersonCount(publicDepId);
			 		if(publicDepId!=null && publicDepId.trim().length()>0){
				 	        List list3 = com.matrix.office.investigation.common.CommonHelper.getUserList(publicDepId);
						 	String canSubmit = "false";
						 	if(list3!=null && list3.size()>0){
						 		//allUserNum = list3.size()+"";//总人数
							 	for(Object currentUserId : list3){
							 		if(currentUserId.equals(userId)){
							 			canSubmit="true";
							 			break;
							 		}
							 	}
						 	}
						 	String votedUserNum = "0";
						 	//这里必须用distinct来区分
						 	StringBuilder votedSql=new StringBuilder();
						 	votedSql.append("SELECT DISTINCT C_USER_ID FROM MO_INVESTIGATION_RESULT_BO  WHERE C_INVES_INFO_ID='"+invesInfoId+"'");
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
						 	
						 	List<DataObject> userList = ds.querySqlList(votedSql.toString(),null,null);
						 	//Object obj = (Object)ds.querySqlValue(votedSql,null,null);
						 	if(userList!=null && userList.size()>0){
						 		votedUserNum = userList.size()+"";
						 	}
						 	//if(obj!=null){
						 	//	votedUserNum = obj.toString();//投票人数
						 		
						 	//}
							String notVoteNum = (Integer.valueOf(allUserNum)-Integer.valueOf(votedUserNum))+"";//未投票人数
				%>
				<td class="bg-advance-bottom" style="padding-left: 10px;">
                   	参加调查人数 <font color="red"><%=allUserNum %> </font>，
                    目前共有 <font color="red" 
                    <%
                    if("0".equals(voteStyle)){
                    	if("1".equals(canSee)){
                    %>
                    onclick="Matrix.showWindow('doSurvey');" style="cursor:pointer;"
                    <%
                    	}
                    }else{
                    	%>
                    	onclick="Matrix.showWindow('doSurvey');" style="cursor:pointer;"
                    	<%
                    }
                    %>
                    ><%=votedUserNum %></font> 人投票，
                    <font color="red" 
                    <%
                    if("0".equals(voteStyle)){
                    	if("1".equals(canSee)){
                    %>
                    onclick="Matrix.showWindow('unDoSurvey');" style="cursor:pointer;"
                    <%
                    	}
                    }else{
                    	%>
                    	onclick="Matrix.showWindow('unDoSurvey');" style="cursor:pointer;"
                    	<%
                    }
                    %>
					><%=notVoteNum %></font> 人未投票
                 	</td> 
			
		
		<td class="bg-advance-bottom" align="right" height="42" id="recordTd" 
			<%
			//调查状态 0.暂存 1.发布 2.审批中  3.已结束
		    String status = request.getParameter("status");  //从调查管理列表进去进入调查  暂存时不显示结束调查等右边操作按钮
			if(status !=null && "0".equals(status)){  
			%>
			style="display:none;"
		    <%
		    }
			%>
			>
			<%
				if(isOverInves==0 && nowTime.compareTo(toDate)<=0){
					if(hasJoinList!=null && hasJoinList.size()>0){
						%>
							<font color="red" id="joinFont">已经参与调查</font>
						<%
					}else{
						String infoRes = request.getParameter("infoRes");
						if(infoRes ==null || !"1".equals(infoRes)){
							%>
					  		<input type="submit" id="submit" name="提交" class="button-default-2" value="提交"  display="<%=canSubmit %>" />					
							<%	
						}else{
							%>
								<font color="red" id="joinFont">参与调查，请切换至“调查列表”</font>
							<%
						}
					}
				}
			%>	
				<%
				if(isOverInves==1 || nowTime.compareTo(toDate)>0){
					%>
					<font color="red" id="font" style="">该调查已经结束</font>
					<%
					}
				%>
				<font color="red" id="font" style="display:none;">该调查已经结束</font>
				<%
				String infoRes = request.getParameter("infoRes");
				//if(infoRes !=null && "1".equals(infoRes)){  //infoRes 和 status存在说明是从调查管理入口进入的
				%>
			   <input type="button" id="returnResult" value="查看结果" class="button-default-2" onclick="showResult('<%=invesInfoId %>');"/>
			   <%
			   %>
			  <%
			  	if(isAdmin){
			  %>
			  <%
			  	if(isOverInves==0 && nowTime.compareTo(toDate)<=0){
			  		%>
			  		
			  <input type="button" id="overInves" value="结束调查" class="button-default-2" onclick="IsOverInvestigation('<%=invesInfoId %>');"/>
			  		
			  		<%
			  	}else{
			  		%>	
			  <input type="button" id="startInves"  value="开启调查" class="button-default-2" onclick="startInvestigation('<%=invesInfoId %>');"/>
			  		<%
			  	}
			  %> 
			  <%
			  	}
			  %>
	  	 </td>
	  </tr>
 </table>
</td>
		</tr><%} }%>
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
	var infoRes = "${param.infoRes}";
    location.replace(webContextPath+"/office/survery/SurveyResultPage.jsp?infoRes="+infoRes+"&invesInfoId="+invesInfoId);
}
	
	isc.Window.create( {
		ID : "MdoSurvey",
		id : "doSurvey",
		name : "doSurvey",
		autoCenter : true,
		position : "absolute",
		height : "50%",
		width : "50%",
		title : "已参与调查",
		canDragReposition : true,
		showMinimizeButton : false,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
		initSrc:"<%=request.getContextPath()%>/surveyRealTimeForm.rform?surveyId=${param.invesInfoId}",
		src:"<%=request.getContextPath()%>/surveyRealTimeForm.rform?surveyId=${param.invesInfoId}",
		showFooter : false
	});
	isc.Window.create( {
		ID : "MunDoSurvey",
		id : "unDoSurvey",
		name : "unDoSurvey",
		autoCenter : true,
		position : "absolute",
		height : "50%",
		width : "50%",
		title : "未参与调查",
		canDragReposition : true,
		showMinimizeButton : false,
		showMaximizeButton : true,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
				"maximizeButton", "closeButton" ],
		initSrc:"<%=request.getContextPath()%>/SurveyRealTimeFormUndo.rform?surveyId=${param.invesInfoId}",
		src:"<%=request.getContextPath()%>/SurveyRealTimeFormUndo.rform?surveyId=${param.invesInfoId}",
		showFooter : false
	});
</script>
</form>
</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>

</body>
</html>
