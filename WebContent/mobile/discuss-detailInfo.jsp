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
		.td{border:0px;}
		a{text-decoration:none}
		table{border-left: 1px solid #666; border-bottom: 1px solid #666;font-size: 14px; line-height: 1.5;border-color:#cdcdcd;font-family:"Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;font-size:12px;}
		td{border-right:1px solid #666;border-color:#cdcdcd}
		.head{
			//background-image:url('images/page_head_bg.gif');
			background:#f3f3f4;
			width:100%;
			height:45px;
			margin:0px;
			position:fixed;
 			left:0;
 			top:0;
 			color:#fff;
 			font-family:'Microsoft YaHei',SimSun,Arial,Helvetica,sans-serif;
 			z-index:99999;
		}
		.pointer{
			cursor:pointer;
			color:black;
			font-weight: bold;
		}
		
		.ck-editor__editable { 
			min-height: 300px;
		 }	
		 .btn{
		 	/* border-radius: 3px; */
			padding: 5px 10px;
			font-size: 14px;
			line-height: 1.5;
			/* color: #fff;
			background-color: #337ab7;
			border-color: #2e6da4; */
		 }
	</style>
	<script type="text/javascript" src="<%=path %>/office/resources/ckeditor5-build-classic/ckeditor.js"></script>
	<script type="text/javascript" src="<%=path %>/office/resources/ckeditor5-build-classic/translations/zh-cn.js"></script>
	<script type="text/javascript">
		var myEditor;
		window.onload = function(){
			ClassicEditor.create(document.querySelector('#topicContent'), {
		    	language: 'zh-cn',
		    	toolbar: [ 'heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList' ],
		    	//toolbar: [],
		     })
		    .then(newEditor  => {
		    	myEditor  = newEditor;
		    	myEditor.setData("");
		    })
		    .catch(error => {
		        console.log(error);
		    } ); 	
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
		
		//回复
		function showReplyTb(){
			document.getElementById('mytd').innerText="回复主题";
			var replytb=document.getElementById('replytb');
			replytb.style.display='';
			var replyId=createUUID();
			document.getElementById('replyId').value=replyId;
			document.getElementById('replytb').scrollIntoView();
 		}
		
		//取消回复
		function hiddenReplyTb(){
			var replytb=document.getElementById('replytb');
			replytb.style.display='none';
			document.getElementById('topicContent').value = '';
			myEditor.setData("");
			document.getElementById('isAnonymous').checked = false;
			var url="<%=request.getContextPath() %>/cancelFileServlet";
			var mBizId = document.getElementById('replyId').value;
			var params="mBizId="+mBizId;
			getUrlData(url,params,function(data){
				document.getElementById('appendixTR').style.display='none';
			});
		}
		
		//回复之前
		function checkContent(uuid,title){
			//var content=document.getElementById('topicContent').value;
			var content = myEditor.getData();
			var type=document.getElementById('type').value;
			if(type=null||type==''){
				document.getElementById('type').value='1';
			}
			if(content=="<p>&nbsp;</p>"){
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
			return true;
		}
		
		//编辑回复
		function editReply(replyId,isAnonymous){
			document.getElementById('mytd').innerText="编辑回复";
			var content = document.getElementById(replyId+'_content').value;
			//document.getElementById('topicContent').value = content;
			myEditor.setData(content);
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
		
		//引用
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
		
		//添加附件
		function openAttachmentDialog(){
			var mBizId = document.getElementById('replyId').value;//关联回复信息的uuid
			top.recordJs = this;    //discuss.jsp
			top.layer.open({
			    id:'layer01',
				type : 2,
				
				title : ['添加附件'],
				//closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '80%', '80%' ],
				content : "<%=request.getContextPath()%>/UploadAppendix.rform?mBizId="+mBizId+"&mHtml5Flag=true"
			});
		}	

		//删除附件
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
						html += "<span style=\"margin-top:10px\" onclick=\"deleteFile('"+uuid+"','"+name+"')\"><img src=\"<%=request.getContextPath() %>/images/delete.jpg\" width=\"15px\" height=\"15px\" /></span>";
					}
					document.getElementById('files').innerHTML = html;
				}
			});
		}
		
		//收藏
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
		
		//取消收藏
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
		
		//刷新
		function refreshPage(){
			window.location.href = "<%=basePath%>mobile/discuss-detailInfo.jsp?uuid=<%=request.getParameter("uuid")%>&isClick=0";
		}
		
	</script>
	
  </head>
  
  <body style="background-color:#FAFAFA">
  <%!DataService ds= MFormContext.getService("DataService");
  	 MFUser user = MFormContext.getUser();
  	 String userId=user.getUserId();
  	 String userName=user.getUserName();
  %>
  <%!boolean flag = false; %>
  <%
  	 String uuid= request.getParameter("uuid");//讨论信息的 uuid
  	 String str = request.getParameter("startRow");
  	 System.out.print(str);
  	 int curPage;
  	 if(str==null){
  	 	curPage = 1;
  	 }else{
  	 	curPage =Integer.parseInt(request.getParameter("startRow"));
  	 }
  	 int rowCount = 20;
  	 
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
  <div class="head">
  	<div style="font-size:12px;float:right;padding-right:10px;margin-top:23px">
  		<!-- <span><a class="pointer" id="collection" onclick="collection('<%=uuid %>')" style="display:none">收藏</a></span>
  		<span><a class="pointer" id="unCollection" onclick="unCollection('<%=uuid %>')" style="display:none">取消收藏</a></span>
  		<span style="margin-left:5px;margin-right:5px">|</span> -->
  		<span><a class="pointer" onclick="showReplyTb();">回复讨论</a></span>
  		<span style="margin-left:5px;margin-right:5px;color:black;">|</span>
  		<a class="pointer" onclick="refreshPage();">刷新</a>
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
  	 if(content.length()>0&&(!content.isEmpty())){
  	    content=content.substring(3,(content.length()-6));
  	 }
   %>
  
  
    <table width="100%" cellpadding="1" cellspacing="0" style="margin-top:45px;border:0px">
    	<tbody>
    		<tr align="center">
    			<% int sourceType = discussInfo.getInt("isOrgi");//讨论信息的来源
    				String s = "";  //将数据库中的整形数据转换为相应的字符串类型
    			   switch(sourceType){
    			   		case 1: s = ""; break;
    			   		case 2: s = "[原创]";break;
    			   		case 3: s = "[转发]";break;
    			   }		
    			 %>
    			<td colspan="2" style="height:35px;font-size:18px;text-align:left;padding:10px;border:0px"><strong><%=discussInfo.getString("title")+""+s+"" %></strong></td>
    		</tr>
    		<tr>
	    		<td width="15%" style="border:0px">
	    			<div align="center">
	    				<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="30px" height="30px"/>
    				</div>
	    		</td>
	    		<td valign="top" style="border:0px;width:85%">
	    			<div style="float:left;display:block;width:100%">
    					<a style="color:black" href="javascript:volid(0);"><%=discussInfo.getString("starter") %></a>
	    			</div>
	    			<div style="float:left;display:block;width:100%">
    					<%!SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm"); %>
    					<span style="color:#B6B6B6"><%=sdf.format(discussInfo.getDate("createDate")) %></span>
    				</div>
	    		</td>
    		</tr>
    		<tr>
    			<%-- <td rowspan="3" style="background-color: #eef7ff;width:15%;border-top: 1px solid #666;border-color:#cdcdcd " align="center" valign="top">
    				<div>
	    				<a href="javascript:volid(0);"><%=discussInfo.getString("starter") %></a>
	    				<br/>
	    				<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="60%" height="60px"/>
    				</div>
    			</td> --%>
    			<td colspan="3" style="border:0px">
    				<%-- <div style="float:left;">
    					<%!SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); %>
    					<span style="color:#6a6a69">发表时间：<%=sdf.format(discussInfo.getDate("createDate")) %></span>
    				</div> --%>
    				<div style="float:right;margin-right:15px">
    					<span style="color:#6a6a69">点击数：<%=discussInfo.getInt("counts") %>&nbsp;&nbsp;回复数：<%=discussInfo.getInt("replyCounts") %></span>
    				</div>
    			</td>
    		</tr>
    		<tr>
    			<!-- <td style="border:0px">
    			</td> -->
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
    				<div style="float:right;margin-right:15px">
    				<a style="color:#B6B6B6" href="javascript:quot('<%=uuid %>','1');" style="font-size: larger;">[引用]</a>&nbsp;
     				<a style="color:#B6B6B6" href="javascript:showReplyTb();" style="font-size: larger;">[回复]</a></div>
     			</td>
    		</tr>
    	</tbody>
    </table>
    <!-- 回复列表 -->
    <table style="border:0px" width="100%" cellpadding="1" cellspacing="0">
    	<tbody>
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
    		<tr>
    		<!--回复列表头像--------asd    -->
    			<td width="15%" style="border:0px">
	    			<div align="center">
					<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="30px" height="30px"/>
    				</div>
	    		</td>
	    		<td valign="top" style="border:0px;width:85%">
	    			<div style="float:left;display:block;width:100%">
    					<% if(flag){%>
	   	    			<a style="color:black" href="javascript:volid(0);"> 匿名人员  </a>
	   	    			<%}else{%>
	   	    			<a style="color:black" href="javascript:volid(0);"> <%=reply.getString("replyer") %> </a>
	   	    			<%} %>
	    			</div>
	    			<div style="float:left;display:block;width:100%">
    					<span style="color:#B6B6B6"><%=(curPage-1)*rowCount+i %>楼&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=sdf.format(discussInfo.getDate("createDate")) %></span>
    				</div>
	    		</td> 
	    		
    			<%-- <td rowspan="3" style="background-color: #eef7ff;width:25%;border-bottom: 1px solid #666;border-color:#cdcdcd" align="center" valign="top">
    				<% if(flag){%>
   	    			<a href="javascript:volid(0);"> 匿名人员  </a>
   	    			<%}else{%>
   	    			<a href="javascript:volid(0);"> <%=reply.getString("replyer") %> </a>
   	    			<%} %>
	    			<br/>
					<img alt="" src="<%=basePath %>/images/touxiang.jpg" width="60%" height="60px"/>
    			</td>
    			<td>
    				<div style="float:left">
    					<span style="color:#6a6a69">回复时间：<%=sdf.format(reply.getDate("replyDate")) %></span>
    				</div>
    				<div style="float:right;margin-right:20px"><%=(curPage-1)*5+i %>楼</div>&nbsp;&nbsp;
    			</td> --%> 
    		</tr>
    		<tr>
    			<td style="border:0px">
    			
    			</td>
    			<td colspan="3" height="30px" valign="top" style="border:0px">
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
    			<td colspan="3" style="border:0px">
					<div style="float:right;margin-right:15px">
    					<% 
    					String replyerId = reply.getString("replyerId");
    					String currentUserId = MFormContext.getUser().getUserId();
    					if(replyerId.equals(currentUserId)){
    					%>
    						<input type="hidden" id="<%=replyId %>_content" name="<%=replyId %>_content" value='<%=replyStr %>' />
    						<%-- <a style="color:#B6B6B6" href="javascript:editReply('<%=replyId %>','<%=reply.getInt("isAnonymous") %>');" style="font-size: larger;">[编辑]</a>&nbsp;
    						<a style="color:#B6B6B6" href="DiscussReplyServlet?replyId=<%=replyId %>&type=3&uuid=<%=uuid %>&curPage=<%=resultObj.getCurrentPageNumber() %>" style="font-size: larger;" onclick="return confirm('确认删除此条信息吗？');">[删除]</a>&nbsp; --%>
    					<%} %>
    						<a style="color:#B6B6B6" href="javascript:quot('<%=replyId %>','2');" style="font-size: larger;">[引用]</a>&nbsp;
<%--     						<a style="color:black" href="DiscussReplyServlet?isTop=1&replyId=<%=replyId %>&uuid=<%=uuid %>" style="font-size: larger;">[Top]</a>
 --%>    			</div>
				</td>
    		</tr>
    		<%} %>
    	<%} %>
    	</tbody>
    </table>
    <!-- 分页 -->
    <form style="padding:10px" action="<%=path %>/mobile/discuss-detailInfo.jsp?uuid=<%=uuid %>" id="pageForm" method="post">
    	<input type="hidden" name="startRow" id="startRow" />
    	<table style="width:100%;border:0px;text-align:center;">
    		<tr>
    			<td align="right" style="height:30px;border:0px">
    				<table cellSpacing="0" cellPadding="0" style="width:100%;border:0px;text-align:center;" >
    					<tbody>
    						<tr>
    							<%
    								int prestart = resultObj.getStartOfPreviousPage();;
									int nextstart = resultObj.getStartOfNextPage();
									int totalpage = resultObj.getTotalPageNumber();
									Long totalSize = resultObj.getTotalSize();
									if (resultObj.hasPreviousPage()) {
    							 %>
								<td style="border:0px">
									<!-- <a style="color:black" href="javascript:submitQueryByPage(1)"> -->
									<%-- <img src="<%=request.getContextPath()%>/images/first.gif" border=0></img> --%>
										<!-- 首页 -->
									<!-- </a> -->
									<a href="javascript:submitQueryByPage(<%=curPage - 1%>)">
										<%-- <img src="<%=request.getContextPath()%>/images/pre.gif" border=0></img> --%>
										上一页
									</a>
								<%
									} else {
								%>
								 <td style="border:0px">
								 	<%-- <img style="disable:true;" src="<%=request.getContextPath()%>/images/first_gray.gif" border=0></img> --%>
								 	<!-- 首页 -->
								 	<%-- <img style="disable:true;" src="<%=request.getContextPath()%>/images/pre_gray.gif" border=0></img> --%>
								 	<!-- 上一页 -->
								 <%} %>
								&nbsp;&nbsp;&nbsp;&nbsp;共<%=totalpage %>页<%=totalSize %>条记录&nbsp;&nbsp;&nbsp;&nbsp;
								<%--  <td style="border:0px">
									<span><%=totalpage==0?0:curPage %></span>
								 </td> --%>
								 <%
								if (curPage<totalpage) {
								  %>
									<a href="javascript:submitQueryByPage(<%=curPage + 1%>)">
										<%-- <img src="<%=request.getContextPath()%>/images/next.gif" border=0></img> --%>
										下一页
									</a> 
									<%-- <a style="color:black" href="javascript:submitQueryByPage(<%=totalpage%>)"> --%>
										<%-- <img src="<%=request.getContextPath()%>/images/last.gif" border=0></img> --%>
										<!-- 尾页 -->
									<!-- </a> -->
								<%}else{%>
									<%-- <img src="<%=request.getContextPath()%>/images/next_gray.gif" border=0></img> --%>
									<!-- 下一页 -->
									<%-- <img src="<%=request.getContextPath()%>/images/last_gray.gif" border=0></img> --%>
									<!-- 尾页 -->
									<%} %>
									<%-- &nbsp;跳转至&nbsp;<input type="text" id="inputPg" name="inputPg" style="width:28px;height:18px;text-align:center" value="<%=totalpage==0?0:curPage %>"/>
									<input class="buttonbg" type=button value="go" style="display:inline;height:20;valign:middle;" onclick="submitQueryByInputPage(<%=totalpage %>)"> --%>
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
    	<tr><td colspan="2" style="border-top: 1px solid #cdcdcd;background-color:#f3f3f4" id="mytd">回复主题 </td></tr>
    	<tr>
    		<td align="right" width="25%"  style="background-color: #f3f3f4;pading-left:10px">标题：</td>
    		<td><div style="margin-right:10px;"><%--<span style="font-weight:bold"> <%=discussInfo.getString("title")%> --%></span>&nbsp;&nbsp;&nbsp;<!-- <a href="javascript:openAttachmentDialog()">添加附件</a> -->
    				<span id="checkBox"><input type="checkbox" name="isAnonymous" id="isAnonymous">是否匿名回复</input></span>
    				<%if(flag){%>
    					<script type="text/javascript">
    						document.getElementById('checkBox').style.display='none';
    					</script>
    				<%} %>
    				 
    			</div>
    		</td>
    	</tr>
    	<tr id="appendixTR" style="display:none">
    		<td align="right" width="25%" style="background-color: #eef7ff">附件:(<span id="fileNum"></span>)</td>
    		<td valign="top" height="26">
				<div id="files" style="padding-left:10px">	
				</div>
    		</td>
    	</tr>
    	<tr>
    		<td align="right" width="25%"  style="background-color: #f3f3f4">内容：</td>
    		<td>
        		<textarea id="topicContent" name="topicContent" style="WIDTH: 80%; HEIGHT: 500px"></textarea>
        	</td>
    	</tr>
    	<tr align="center">
    		<td colspan="2">
    		<input type="submit" onclick="return checkContent('<%=uuid %>','<%=discussInfo.getString("title") %>');" class="btn" value="提交"/>
    		<input type="button" onclick="hiddenReplyTb();" class="btn" value="取消"/>
    		</td>
    	</tr>
    </table>
    </form>
  </body>
</html>
