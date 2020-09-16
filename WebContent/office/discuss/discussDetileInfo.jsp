<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.api.identity.MFUser"%>
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
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<style type="text/css">
		a{text-decoration:none}
		table{border-left: 1px solid #666; border: 1px solid #666;font-size: 14px; line-height: 1.5;border-color:#cdcdcd;font-family:"Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;font-size:12px;}
		/* td{border-right:1px solid #666;border-color:#cdcdcd} */
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
		.pointer{
			cursor:pointer;
		}
	</style>
	<script type="text/javascript" src="office/resources/ckeditor/ckeditor.js"></script>
	
	<script type="text/javascript">
		window.onload = function(){
			//opener.location.reload();
		}	
		function createUUID(){
			var s = [];
			var hexDigits = "0123456789abcdef";
			for (var i = 0; i < 36; i++) {
				s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
			}
			s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
			s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
			s[8] = s[13] = s[18] = s[23] = "-";

			var uuid = s.join("");
			return uuid;
		}
		
		function getUrlData(url,params,callback){
			var xmlHttp;
			if(window.ActiveXObject){
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if(window.XMLHttpRequest){
				xmlHttp = new XMLHttpRequest();
			}
			xmlHttp.open("POST",url+"?"+params,true);
			xmlHttp.setRequestHeader("Content-","application/x-www-form-urlencoded;charset=UTF-8");
			try{
				xmlHttp.send(params);
				xmlHttp.onreadystatechange = function(){
					if(xmlHttp.readyState == 4){
						if(xmlHttp.status == 200){
							var data = xmlHttp.responseText;
							callback(data);
						}else{
							alert("服务器操作异常,请与管理员联系!");
						}
					}
				}	
			}catch(e){
				alert(e);
			}
		}
		
		function showReplyTb(){
			document.getElementById('mytd').innerText="回复主题";
			var replytb=document.getElementById('replytb');
			replytb.style.display='';
			var replyId=createUUID();
			document.getElementById('replyId').value=replyId;
			document.getElementById('replytb').scrollIntoView();
 		}
		
		function hiddenReplyTb(){
			var replytb=document.getElementById('replytb');
			replytb.style.display='none';
			CKEDITOR.instances.topicContent.setData('');
			document.getElementById('isAnonymous').checked = false;
			var url="<%=request.getContextPath() %>/cancelFileServlet";
			var mBizId = document.getElementById('replyId').value;
			var params="mBizId="+mBizId;
			getUrlData(url,params,function(data){
				document.getElementById('appendixTR').style.display='none';
			});
		}
		
		function checkContent(uuid,title){
			var content=CKEDITOR.instances.topicContent.getData();
			var type=document.getElementById('type').value;
			if(type=null||type==''){
				document.getElementById('type').value='1';
			}
			if(content==""){
				alert('请输入回复内容！');
				return false;
			}
			document.getElementById('content').value=content;
			document.getElementById('uuid').value=uuid;
			document.getElementById('title').value=title;
			if(document.getElementById('isAnonymous').checked){
				document.getElementById('isAnonymous1').value='1';
			}else{
				document.getElementById('isAnonymous1').value='0';
			}
			document.getElementById('bottom').scrollIntoView();
			return true;
		}
		
		function editReply(replyId,isAnonymous){
			document.getElementById('mytd').innerText="编辑回复";
			var content = document.getElementById(replyId+'_content').value;
			CKEDITOR.instances.topicContent.setData(content);
			document.getElementById('type').value='2';
			document.getElementById('replyId').value=replyId;
			var replytb=document.getElementById('replytb');
			replytb.style.display='';
			
			if(isAnonymous == "1"){
				document.getElementById('isAnonymous').checked = 'checked';
			}
			document.getElementById('replytb').scrollIntoView();
			return true;
		}
		
		
		function quot(quotId,quotType){
			document.getElementById('mytd').innerText="引用主题";
			document.getElementById('quotId').value=quotId;
			document.getElementById('isQuot').value='1';
			document.getElementById('quotType').value=quotType;
			
			document.getElementById('replytb').style.display='';
			
			var uuid=createUUID();
			document.getElementById('replyId').value=uuid;
			document.getElementById('replytb').scrollIntoView();
		}
		
		function openAttachmentDialog(){
			var mBizId = document.getElementById('replyId').value;//关联回复信息的uuid
			var iWidth=600;  //弹出窗口的宽度;
  			var iHeight=400;  //弹出窗口的高度;
  			var iTop = (window.screen.availHeight-30-iHeight)/2;//获得窗口的垂直位置;
  			var iLeft = (window.screen.availWidth-10-iWidth)/2;//获得窗口的水平位置;
			window.open('UploadAppendix.rform?mHtml5Flag=true&mBizId='+mBizId,'FileDialog','height='+iHeight+', width='+iWidth+', top='+iTop+',left='+iLeft+',toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no');
		}	
		
		
		
		function deleteFile(uuid,fileName){
			var mBizId = document.getElementById('replyId').value;
			var url="<%=request.getContextPath() %>/deleteFileServlet";
			var params="uuid="+uuid+"&mBizId="+mBizId;
			getUrlData(url,params,function(data){
				var jsonObj = eval("("+data+")");//转换为 JSON 对象
				if(jsonObj.length == 0){
					document.getElementById('appendixTR').style.display = 'none';
				}else{
					document.getElementById('fileNum').innerHTML = jsonObj.length;
					var html="";
					for(var i = 0;i < jsonObj.length; i++){ 
	            		var name = jsonObj[i].fileName;
	            		var uuid = jsonObj[i].uuid;
	            		var type = jsonObj[i].fileType;
	            		var size = jsonObj[i].fileSize;
						html += "<span><a style=\"font-size:12px;text-decoration:none;\" ";
						html += " href=\"DownLoadFileServlet?uuid="+uuid+"&entityName=comprehensive.discuss.discussmodule.DiscussFileBO\">"+name+"("+size+"B)</a></span>";
						html += "<span style=\"margin-top:10px\" onclick=\"deleteFile('"+uuid+"','"+name+"')\"><img src=\"images/delete.jpg\" width=\"15px\" height=\"15px\" /></span>";
					}
					document.getElementById('files').innerHTML = html;
				}
			});
		}
		function collection(uuid){
			var url="<%=request.getContextPath() %>/collectionServlet";
			var status = "0";
			var params="uuid="+uuid+"&status="+status;
			getUrlData(url,params,function(data){
				var obj = eval("("+data+")");
				if(obj.result == "success"){
					document.getElementById('collection').style.display='none';
					document.getElementById('unCollection').style.display='';
				}
			});
		}
		function unCollection(uuid){
			var url="<%=request.getContextPath() %>/collectionServlet";
			var status = "1";
			var params="uuid="+uuid+"&status="+status;
			getUrlData(url,params,function(data){
				var obj = eval("("+data+")");
				if(obj.result == "success"){
					document.getElementById('collection').style.display='';
					document.getElementById('unCollection').style.display='none';
				}
			});
		}
		
		function submitQueryByPage(pg){
	    document.getElementById("startRow").value = pg;
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
		function refreshPage(){
			window.location.href = "<%=basePath%>office/discuss/discussDetileInfo.jsp?uuid=<%=request.getParameter("uuid")%>&isClick=0";
		}
		
	</script>
	
  </head>
  
  <body style="background-color:#F5F5F5">
  <%!DataService ds= MFormContext.getService("DataService");
  	 MFUser user = MFormContext.getUser();
  	 String userId=user.getUserId();
  	 String userName=user.getUserName();
  %>
  <%!boolean flag = false; %>
  <%
  	 String uuid= request.getParameter("uuid");//讨论信息的 uuid
  	 String str = request.getParameter("startRow");
  	 int curPage;
  	 if(str==null){
  	 	curPage = 1;
  	 }else{
  	 	curPage =Integer.parseInt(request.getParameter("startRow"));
  	 }
  	 int rowCount = 5;
  	 
  	 /*StringBuffer hql2 = new StringBuffer("from comprehensive.discuss.discussmodule.DiscussCollectionBO where discussId='");
	 hql2.append(uuid);
	 hql2.append("' and userId='");
	 hql2.append(userId);
	 hql2.append("'");
	 DataObject collectionInfo =(DataObject) ds.queryObject(hql2.toString(),null);
	 String isCollection = "0";
	 if(collectionInfo != null){
	 	isCollection = "1";
	 }*/
   %>
  <div class="head" style="z-index: 9999">
  	<div style="font-size:18px;font-weight:bold;padding-left:10px;float:left;margin-top:17px">讨论</div>
  	<div style="font-size:12px;float:right;padding-right:10px;margin-top:23px">
  		<!-- <span><a class="pointer" id="collection" onclick="collection('<%=uuid %>')" style="display:none">收藏</a></span>
  		<span><a class="pointer" id="unCollection" onclick="unCollection('<%=uuid %>')" style="display:none">取消收藏</a></span>
  		<span style="margin-left:5px;margin-right:5px">|</span> -->
  		<span><a class="pointer" onclick="showReplyTb();">回复讨论</a></span>
  		<span style="margin-left:5px;margin-right:5px">|</span>
  		<a class="pointer" onclick="refreshPage();">刷新</a>
  		<span style="margin-left:5px;margin-right:5px">|</span>
  		<a class="pointer" onclick="window.close();">关闭</a>
  	</div>
  </div>
  	 <%StringBuffer queryInfo=new StringBuffer();
  	 queryInfo.append("from comprehensive.discuss.discussmodule.DiscussInfoBO where uuid='");
	 queryInfo.append(uuid);
	 queryInfo.append("'");
	 DataObject discussInfo=(DataObject)ds.queryObject(queryInfo.toString(), null);
	 flag = discussInfo.getBoolean("isReply");//是否匿名回复
	 String isClick = request.getParameter("isClick");
	 if("1".equals(isClick)){
		 Integer counts = discussInfo.getInt("counts"); //设置点击数 +1
		 discussInfo.setInt("counts", ++counts);
	 }
	 //获取讨论信息的板块信息
	 StringBuffer queryBoard = new StringBuffer("from comprehensive.discuss.discussmodule.DiscussBoardBO where uuid='");
	 queryBoard.append(discussInfo.getString("column"));
	 queryBoard.append("'");
	 DataObject boardInfo = (DataObject)ds.queryObject(queryBoard.toString(),null);
 	StringBuffer queryReply=new StringBuffer();
	queryReply.append("from comprehensive.discuss.discussmodule.ReplyDiscussBO where mBizId='");
	queryReply.append(uuid);
	queryReply.append("' and isDelete=");
	queryReply.append(0);
	queryReply.append("order by isTop desc");
	int t = boardInfo.getInt("descType");
	if(boardInfo.getInt("descType")==1){
		queryReply.append(",cOrder desc");
	}else{
		queryReply.append(",cOrder");
	}
	 Page resultObj = ds.queryPage(queryReply.toString(), null, (curPage-1)*rowCount,rowCount);
	 List<DataObject> replyList=resultObj.getDataList();
	 
  	 byte c[]= discussInfo.getBytes("content");
  	  String content=new String(c,"UTF-8");
  	System.out.println("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
  	System.out.println(content);
  	System.out.println("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
  	 if(content.length()>0&&(!content.isEmpty())){
  	 content=content.substring(3,(content.length()-6));
  	 }
   %>
  
  
    <table border="0" cellpadding="1" cellspacing="0" style="background-color:white;left:10%;margin-top:45px;margin-left:10px;width:80%;position:relative">
    	<tbody>
    		<tr align="center" >
    			<% int sourceType = discussInfo.getInt("isOrgi");//讨论信息的来源
    				String s = "";  //将数据库中的整形数据转换为相应的字符串类型
    			   switch(sourceType){
    			   		case 1: s = ""; break;
    			   		case 2: s = "[原创]";break;
    			   		case 3: s = "[转发]";break;
    			   }		
    			 %>
    			<td colspan="2" style="height:45px;padding-left:5px;font-size:16px;text-align:left"><strong><%=discussInfo.getString("title")+""+s+"" %></strong></td>
    		</tr>
    		<%-- <tr>
    			<td rowspan="3" style="background-color: #eef7ff;width:13%;border-top: 1px solid #666;border-color:#cdcdcd " align="center" valign="top">
    				<div>
	    				<a href="javascript:volid(0);"><%=discussInfo.getString("starter") %></a>
	    				<br/>
	    				<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="60%" height="100px"/>
    				</div>
    			</td>
    			<td style= "border-top: 1px solid #666;border-color:#cdcdcd">
    				<div style="float:left;">
    					<%!SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); %>
    					<span style="color:#6a6a69">发表时间：<%=sdf.format(discussInfo.getDate("createDate")) %></span>
    				</div>
    				<div style="float:right;margin-right:15px">
    					<span style="color:#6a6a69">点击数：<%=discussInfo.getInt("counts") %>&nbsp;&nbsp;回复数：<%=discussInfo.getInt("replyCounts") %></span>
    				</div>
    			</td>
    		</tr> --%>
    		<tr style="background-color: azure">
	    		<td width="15%" style="border-top:1px solid #cdcdcd">
	    			<div align="center">
	    				<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="60px" height="60px"/>
    				</div>
	    		</td>
	    		<td valign="top" style="border-top:1px solid #cdcdcd;width:85%">
	    			<div style="float:left;display:block;width:100%">
    					<a style="color:black" href="javascript:volid(0);"><%=discussInfo.getString("starter") %></a>
	    			</div>
	    			<div style="float:left;display:block;width:100%">
    					<%!SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm"); %>
    					<span style="color:#B6B6B6"><%=sdf.format(discussInfo.getDate("createDate")) %></span>
    				</div>
    				<div style="float:right;margin-right:15px">
    					<span style="color:#6a6a69">点击数：<%=discussInfo.getInt("counts") %>&nbsp;&nbsp;回复数：<%=discussInfo.getInt("replyCounts") %></span>
    				</div>
	    		</td>
    		</tr>
    		<tr>
    			<td height="70px" valign="top" colspan="3" style="border:0px">
    				<%-- <div  id="<%=uuid %>_content" name="<%=uuid %>_content" style="display:none;">
						<span style="font-size:16px"> <%="<di"+content+">" %> </span>
					</div> --%>
					<div style="padding-left:10px "><%="<di"+content+">" %></div>
					<!-- 查询是1否存在附件 -->
					<%  StringBuffer hql=new StringBuffer();
						hql.append("from comprehensive.discuss.discussmodule.DiscussFileBO where mBizId='");
						hql.append(uuid);
						hql.append("'");
						List<DataObject> appendixes=ds.queryList(hql.toString(),null);%>
					<%
						if(appendixes.size() != 0){
					 %>
					 	<div id="<%=uuid %>_appendixes">
					 		<% for(DataObject appendix : appendixes) {%>
									<span><a href="DownLoadFileServlet?uuid=<%=appendix.getString("uuid") %>&entityName=comprehensive.discuss.discussmodule.DiscussFileBO">
										<%=appendix.getString("fileName") %>
									</a></span>&nbsp;
					 		<%} %>
					 	</div>
					 <%} %>
    			</td>
    		</tr>
    		<tr>
    			<td  colspan="3" style="border:0px">
    				<div style="float:right;margin-right:15px"><a href="javascript:quot('<%=uuid %>','1');">[引用]</a>&nbsp;
    				<a href="javascript:showReplyTb();">[回复]</a></div>
    			</td>
    		</tr>
    	</tbody>
    </table>
    <!-- 回复列表 -->
    		<!-- 查询附件 -->
    		<%if(replyList.size() == 0){ %>
    			<tr><td align="center">暂时还没有回复</td></tr>
    		<%} else { %>
    		<%byte replyContent[] =null;
    		  String replyStr = null;
    		  String replyId=null;
    		  int i = 1;
    		  for(DataObject reply: replyList){ 
    		  	replyContent = reply.getBytes("replyContent");
    		  	replyStr=new String(replyContent,"UTF-8");
    		  	//replyStr=replyStr.substring(3,replyStr.length()-6);
    		  	replyId=reply.getString("uuid");
    		  %>
    		  <%  StringBuffer hql1=new StringBuffer();
				hql1.append("from comprehensive.discuss.discussmodule.DiscussFileBO where mBizId='");
				hql1.append(replyId);
				hql1.append("'");
				List<DataObject> appendixes1=ds.queryList(hql1.toString(),null);
			%>
	
    <table border="0" style="background:white;width:80%;margin:10px;position:relative;left:10%" cellpadding="1" cellspacing="0">
    	<tbody>
    		<%-- <tr>
    		<!--回复列表头像--------asd    -->
    			<td rowspan="3" style="background-color: #eef7ff;width:13%;border-bottom: 1px solid #666;border-color:#cdcdcd" align="center" valign="top">
    				<% if(flag){%>
   	    			<a href="javascript:volid(0);"> 匿名人员  </a>
   	    			<%}else{%>
   	    			<a href="javascript:volid(0);"> <%=reply.getString("replyer") %> </a>
   	    			<%} %>
	    			<br/>
					<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="60%" height="100px"/>
    			</td>
    			<td>
    				<div style="float:left">
    					<span style="color:#6a6a69">回复时间：<%=sdf.format(reply.getDate("replyDate")) %></span>
    				</div>
    				<div style="float:right;margin-right:20px"><%=(curPage-1)*5+i %>楼</div>&nbsp;&nbsp;
    			</td>
    		</tr> --%>
    		<tr style="background-color: azure">
    		<!--回复列表头像--------asd    -->
    			<td width="15%" style="border:0px">
	    			<div align="center">
					<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="60px" height="60px"/>
    				</div>
	    		</td>
	    		<td valign="top" style="border:0px;width:85%;vertical-align:middle">
	    			<div style="float:left;display:block;width:100%">
    					<% if(flag){%>
	   	    			<a style="color:black" href="javascript:volid(0);"> 匿名人员  </a>
	   	    			<%}else{%>
	   	    			<a style="color:black" href="javascript:volid(0);"> <%=reply.getString("replyer") %> </a>
	   	    			<%} %>
	    			</div>
	    			<div style="float:left;display:block;width:100%">
    					<span style="color:#B6B6B6"><%=(curPage-1)*5+i %>楼&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=sdf.format(discussInfo.getDate("createDate")) %></span>
    				</div>
	    		</td> 
    		</tr>
    		<%-- <tr>
    			<td height="90px" valign="top" border="0px">
    				<% 	i++;
    					if("1".equals(reply.getString("isQuot"))){ 
    					String queryQuot=null;
    					String writerName=null;
    					String writeDate =null;
    					byte quot[] = null;
    					String quotStr =null;
    					if("1".equals(reply.getString("quotType"))){
    				   	queryQuot="from comprehensive.discuss.discussmodule.DiscussInfoBO where uuid='"+reply.getString("quotId")+"'";
    				   	DataObject quotObj=(DataObject)ds.queryObject(queryQuot,null);
    				   	writerName = quotObj.getString("starter");
    				   	writeDate=sdf.format(quotObj.getDate("createDate"));
    				   	quot=quotObj.getBytes("content");
    				   	quotStr=new String(quot,"UTF-8");
    					}
    					if("2".equals(reply.getString("quotType"))){
    				   	queryQuot="from comprehensive.discuss.discussmodule.ReplyDiscussBO where uuid='"+reply.getString("quotId")+"'";
    				   	DataObject quotObj=(DataObject)ds.queryObject(queryQuot,null);
    				   	writerName=quotObj.getString("replyer");
    				   	writeDate=sdf.format(quotObj.getDate("replyDate"));
    				   	quot=quotObj.getBytes("replyContent");
    				   	quotStr=new String(quot,"UTF-8");
    					}
    				%>
						<div style="background-color: #eef7ff;font-family:'楷体';margin:5px 15px 0 15px;padding:3px; ">
							引用：<%=writerName %>&nbsp;发表于&nbsp;<%=writeDate %>
							<br/>
							<%=quotStr %>
						</div>
					<%} %>
					<span><%=replyStr %></span>
					<!-- 查询是否存在附件 -->
					<%
						if(appendixes1.size() != 0){
					 %>
					 	<div id="<%=replyId %>_appendixes">
					 	附件：
					 		<% for(DataObject appendix : appendixes1) {%>
									<span><a href="DownLoadFileServlet?uuid=<%=appendix.getString("uuid") %>&entityName=comprehensive.discuss.discussmodule.DiscussFileBO">
										<%=appendix.getString("fileName") %>
									</a></span>&nbsp;
					 		<%} %>
					 	</div>
					 <%} %>
    			</td>
    		</tr> --%>
    		<tr>
    			<td colspan="3" height="75px" valign="top" style="border:0px">
    				<% 	i++;
    					if("1".equals(reply.getString("isQuot"))){ 
    					String queryQuot=null;
    					String writerName=null;
    					String writeDate =null;
    					byte quot[] = null;
    					String quotStr =null;
    					if("1".equals(reply.getString("quotType"))){
    				   	queryQuot="from comprehensive.discuss.discussmodule.DiscussInfoBO where uuid='"+reply.getString("quotId")+"'";
    				   	DataObject quotObj=(DataObject)ds.queryObject(queryQuot,null);
    				   	writerName = quotObj.getString("starter");
    				   	writeDate=sdf.format(quotObj.getDate("createDate"));
    				   	quot=quotObj.getBytes("content");
    				   	quotStr=new String(quot,"UTF-8");
    					}
    					if("2".equals(reply.getString("quotType"))){
    				   	queryQuot="from comprehensive.discuss.discussmodule.ReplyDiscussBO where uuid='"+reply.getString("quotId")+"'";
    				   	DataObject quotObj=(DataObject)ds.queryObject(queryQuot,null);
    				   	writerName=quotObj.getString("replyer");
    				   	writeDate=sdf.format(quotObj.getDate("replyDate"));
    				   	quot=quotObj.getBytes("replyContent");
    				   	quotStr=new String(quot,"UTF-8");
    					}
    				%>
						<div style="padding-top:5px;background-color: #F5F5F5;font-family:'楷体';margin:5px 15px 0 15px;padding:3px; ">
							引用：<%=writerName %>&nbsp;发表于&nbsp;<%=writeDate %>
							<br/>
							<%=quotStr %>
						</div>
					<%} %>
					<div style="padding-left: 10px;padding-top: 10px">
						<span><%=replyStr %></span>
					</div>
					
					<!-- 查询是否存在附件 -->
					<%
						if(appendixes1.size() != 0){
					 %>
					 	<div id="<%=replyId %>_appendixes">
					 	附件：
					 		<% for(DataObject appendix : appendixes1) {%>
									<span><a href="DownLoadFileServlet?uuid=<%=appendix.getString("uuid") %>&entityName=comprehensive.discuss.discussmodule.DiscussFileBO">
										<%=appendix.getString("fileName") %>
									</a></span>&nbsp;
					 		<%} %>
					 	</div>
					 <%} %>
    			</td>
    		</tr>
    		<tr>
<!--     			<td style= "border-bottom: 1px solid #666;border-color:#cdcdcd">-->					
    			<td colspan="3" style="border:0px">
					<div style="float:right;margin-right:15px">
    					<% 
    					String replyerId = reply.getString("replyerId");
    					String currentUserId = MFormContext.getUser().getUserId();
    					if(replyerId.equals(currentUserId)){
    					%>
    						<input type="hidden" id="<%=replyId %>_content" name="<%=replyId %>_content" value='<%=replyStr %>' />
    						<a href="javascript:editReply('<%=replyId %>','<%=reply.getInt("isAnonymous") %>');">[编辑]</a>&nbsp;
    						<a href="DiscussReplyServlet?replyId=<%=replyId %>&type=3&uuid=<%=uuid %>&curPage=<%=resultObj.getCurrentPageNumber() %>" onclick="return confirm('确认删除此条信息吗？');">[删除]</a>&nbsp;
    					<%} %>
    						<a href="javascript:quot('<%=replyId %>','2');">[引用]</a>&nbsp;
    						<a href="DiscussReplyServlet?isTop=1&replyId=<%=replyId %>&uuid=<%=uuid %>">[Top]</a>
    				</div>
				</td>
    		</tr>
    		<%} %>
    	</tbody>
    </table>
    </br></br></br>
    	<%} %>
    <!-- 分页 -->
    <form action="office/discuss/discussDetileInfo.jsp?uuid=<%=uuid %>" id="pageForm" method="post">
    	<input type="hidden" name="startRow" id="startRow" />
    	<table style="width:100%;" border="0">
    		<tr>
    			<td align="center" style="height:30px;">
    				<table cellSpacing="0" cellPadding="0" border="0">
    					<tbody>
    						<tr>
    							<%
    								int prestart = resultObj.getStartOfPreviousPage();;
									int nextstart = resultObj.getStartOfNextPage();
									int totalpage = resultObj.getTotalPageNumber();
									Long totalSize = resultObj.getTotalSize();
									if (resultObj.hasPreviousPage()) {
    							 %>
    							<td border="0">
    								<a href="javascript:submitQueryByPage(1)">
	    								<%-- <img src="<%=request.getContextPath()%>/images/first.gif" border=0>
	    								</img> --%>
	    								首页
    								</a>
    								<a href="javascript:submitQueryByPage(<%=curPage-1%>)">
	    								<%-- <img src="<%=request.getContextPath()%>/images/pre.gif"	border=0>
	    								</img> --%>
	    								下一页
    								</a>
    							</td>
								<%
									}else{
								 %>
								 <td style="border-left:none;" border=0>
								 	<%-- <img style="disable:true;" src="<%=request.getContextPath()%>/images/first_gray.gif" border=0></img>
								 	<img style="disable:true;" src="<%=request.getContextPath()%>/images/pre_gray.gif" border=0></img> --%>
								 	首页
								 	下一页
								 </td>
								 <%} %>
								 <td style="border-left:none;" border="0">
									<span>&nbsp;<%=totalpage==0?0:curPage %>&nbsp;</span>
								 </td>
								 <%
								if (curPage<totalpage) {
								  %>
								<td style="border-left:none;" border=0>
									<a href="javascript:submitQueryByPage(<%=curPage + 1%>)">
										<%-- <img src="<%=request.getContextPath()%>/images/next.gif" border=0></img> --%>
										下一页&nbsp;
									</a> 
									<a href="javascript:submitQueryByPage(<%=totalpage%>)">
										<%-- <img src="<%=request.getContextPath()%>/images/last.gif" border=0></img> --%>
										尾页
									</a>
								</td>
								<%}else{%>
								<td style="border-left:none;" border=0 >
									<%-- <img src="<%=request.getContextPath()%>/images/next_gray.gif" border=0></img>
									<img src="<%=request.getContextPath()%>/images/last_gray.gif" border=0></img> --%>
									下一页&nbsp;
									尾页
								</td>
									<%} %>
								<td style="border-left:none; text-align:center;" border=0>
									&nbsp;跳转至&nbsp;<input type="text" id="inputPg" name="inputPg" style="width:28px;height:18px;text-align:center" value="<%=totalpage==0?0:curPage %>"/>
									<input class="buttonbg" type=button value="go" style="display:inline;height:20;valign:middle;" onclick="submitQueryByInputPage(<%=totalpage %>)">
									&nbsp;共<%=totalpage %>页<%=totalSize %>条记录
								</td>
    						</tr>
    					</tbody>
    				</table>
    			</td>
    		</tr>
    	</table>
    </form>
    <!-- 回复 -->
    <form action="DiscussReplyServlet" method="post" enctype="application/x-www-form-urlencoded" id="replyForm">
    <input type="hidden" name="uuid" id="uuid" /><!-- 讨论信息的 uuid -->
    <input type="hidden" name="replyId" id="replyId" /><!-- 回复信息的 uuid -->
    <input type="hidden" name="isAnonymous1" id="isAnonymous1" />
    <input type="hidden" name="type" id="type" />
    <input type="hidden" name="curPage" id="curPage" value="<%=curPage %>"/>
    <input type="hidden" name="content" id="content"/>
    <input type="hidden" name="quotId" id="quotId"/>
    <input type="hidden" name="isQuot" id="isQuot"/>
    <input type="hidden" name="quotType" id="quotType"/>
    <input type="hidden" name="title" id="title"/>
    <table id="replytb" style="display:none;" width="100%" border="0" cellpadding="1" cellspacing="0">
    	<tr><td colspan="2" style="background-color:#eff4fb" id="mytd">回复主题 </td></tr>
    	<tr>
    		<td align="right" width="13%"  style="background-color: #eef7ff;pading-left:10px">标题：</td>
    		<td><div style="padding-left:10px;margin-right:10px;"><span style="font-weight:bold"><%=discussInfo.getString("title")%></span>&nbsp;&nbsp;&nbsp;<a href="javascript:openAttachmentDialog()">添加附件</a>
    				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="checkBox"><input type="checkbox" name="isAnonymous" id="isAnonymous">是否匿名回复</input></span>
    				<%if(flag){%>
    					<script type="text/javascript">
    						document.getElementById('checkBox').style.display='none';
    					</script>
    				<%} %>
    				 
    			</div>
    		</td>
    	</tr>
    	<tr id="appendixTR" style="display:none">
    		<td align="right" width="13%" style="background-color: #eef7ff">附件:(<span id="fileNum"></span>)</td>
    		<td valign="top" height="26">
				<div id="files" style="padding-left:10px">	
				</div>
    		</td>
    	</tr>
    	<tr>
    		<td align="right" width="13%"  style="background-color: #eef7ff">内容：</td>
    		<td>
        		<textarea id="topicContent" name="topicContent" style="WIDTH: 80%; HEIGHT: 500px">
				</textarea>
				<script type="text/javascript">
					CKEDITOR.replace('topicContent');
				</script>
        	</td>
    	</tr>
    	<tr align="center">
    		<td colspan="2">
    		<input type="submit" onclick="return checkContent('<%=uuid %>','<%=discussInfo.getString("title") %>');" value="提交"/>
    		<input type="button" onclick="hiddenReplyTb();" value="取消"/>
    		</td>
    	</tr>
    </table>
    </form>
  </body>
</html>
